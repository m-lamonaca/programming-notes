# ASP.NET (Core) MVC Web App

## Project Structure

```txt
Project
|-Properties
| |- launchSettings.json
|
|-wwwroot  --> location of static files
| |-css
| | |- site.css
| |
| |-js
| | |- site.js
| |
| |-lib
| | |- bootstrap
| | |- jquery
| | |- ...
| |
| |- favicon.ico
|
|-Model
| |-ErrorViewModel.cs
| |- Index.cs
| |-...
|
|-Views
| |-Home
| | |- Index.cshtml
| |
| |-Shared
| | |- _Layout.cshtml  --> reusable default page layout
| | |- _ValidationScriptsPartial  --> jquery validation script imports
| |
| |- _ViewImports.cshtml  --> shared imports and tag helpers for all views
| |- _ViewStart.cshtml  --> shared values for all views
| |- ...
|
|-Controllers
| |-HomeController.cs
|
|- appsettings.json
|- Program.cs  --> App entrypoiny
|- Startup.cs  --> App config
```

**Note**: `_` prefix indicates page to be imported.

## Controllers

```cs
using Microsoft.AspNetCore.Mvc;
using App.Models;
using System.Collections.Generic;

namespace App.Controllers
{
    public class CategoryController : Controller
    {
        private readonly AppDbContext _db;

        // get db context through dependency injection
        public CategoryController(AppDbContext db)
        {
            _db = db;
        }

        // GET /Controller/Index
        public IActionResult Index()
        {
            IEnumerable<Entity> enities = _db.Entities;
            return View(Entities);  // pass data to the @model
        }

        // GET /Controller/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST /Controller/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Create(Entity entity)  // recieve data from the @model
        {
            _db.Entities.Add(entity);
            _db.SaveChanges();
            return RedirectToAction("Index");  // redirection
        }

        // GET - /Controller/Edit
        public IActionResult Edit(int? id)
        {
            if(id == null || id == 0)
            {
                return NotFound();
            }

            Entity entity = _db.Entities.Find(id);
            if (entity == null)
            {
                return NotFound();
            }

            return View(entity);  // return pupulated form for updating
        }

        // POST /Controller/Edit
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Edit(Entity entity)
        {
            if (ModelState.IsValid)  // all rules in model have been met
            {
                _db.Entities.Update(entity);
                _db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(entity);
        }

        // GET /controller/Delete
        public IActionResult Delete(int? id)
        {
            if (id == null || id == 0)
            {
                return NotFound();
            }

            Entity entity = _db.Entities.Find(id);
            if (entity == null)
            {
                return NotFound();
            }

            return View(entity);  // return pupulated form for confirmation
        }

        // POST /Controller/Delete
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Delete(Entity entity)
        {
            if (ModelState.IsValid)  // all rules in model have been met
            {
                _db.Entities.Remove(entity);
                _db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(entity);
        }
    }
}
```

## Data Validation

### Model Annotations

In `Entity.cs`:

```cs
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;

namespace App.Models
{
    public class Entity
    {
        [DisplayName("Integer Number")]
        [Required]
        [Range(1, int.MaxValue, ErrorMessage = "Error Message")]
        public int IntProp { get; set; }
    }
}
```

### Tag Helpers & Client Side Validation

In `View.cshtml`;

```cs
<form method="post" asp-action="Create">
    <div asp-validation-summary="ModelOnly" class="text-danger"></div>

    <div class="form-group row">
        <div class="col-4">
            <label asp-for="IntProp"></label>
        </div>

        <div class="col-8">
            <input asp-for="IntProp" class="form-control"/>
            <span asp-validation-for="IntProp" class="text-danger"></span>  // error message displyed here
        </div>
    </div>
</form>

// client side validation
@section Scripts{ 
    @{ <partial name="_ValidationScriptsPartial" /> }
}
```

### Server Side Validation

```cs
using Microsoft.AspNetCore.Mvc;
using App.Models;
using System.Collections.Generic;

namespace App.Controllers
{
    public class CategoryController : Controller
    {
        private readonly AppDbContext _db;

        // get db context through dependency injection
        public CategoryController(AppDbContext db)
        {
            _db = db;
        }

        // GET /Controller/Index
        public IActionResult Index()
        {
            IEnumerable<Entity> enities = _db.Entities;
            return View(Entities);  // pass data to the @model
        }

        // GET /Controller/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST /Controller/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Create(Entity entity)  // recieve data from the @model
        {
            if (ModelState.IsValid)  // all rules in model have been met
            {
                _db.Entities.Add(entity);
                _db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(entity);   // return model and display error messages
        }
    }
}
```
