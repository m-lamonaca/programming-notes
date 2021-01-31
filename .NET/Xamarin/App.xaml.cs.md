# App.xaml.cs

This `App` class is defined as `public` and derives from the Xamarin.Forms `Application` class.
The constructor has just one responsibility: to set the `MainPage` property of the `Application` class to an object of type `Page`.

```cs
using System;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace AppName
{
    public partial class App : Application
    {
        public App()
        {
            InitializeComponent();

            MainPage = new MainPage();
        }

        protected override void OnStart()
        {
        }

        protected override void OnSleep()
        {
        }

        protected override void OnResume()
        {
        }
    }
}
```
