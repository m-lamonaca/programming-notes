# ViewModel.cs

```cs
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Text;
using Xamarin.Forms;

namespace AppName.ViewModels
{
    class PageNameViewModel : INotifyPropertyChanged
    {
        public MainPageViewModel()
        {
        }

        public event PropertyChangedEventHandler PropertyChanged;  // event handler to notify changes

        public string field;  // needed, if substituted by ExprBody will cause infinite loop of access with the binding
        public string Property
        {
            get => field;
            set
            {
                field = value;

                var args = new PropertyChangedEventArgs(nameof(Property));  // EVENT: let view know that the Property has changed
                PropertyChanged?.Invoke(this, args);  // Ivoke event to notify the view
            }
        }
    }
}
```
