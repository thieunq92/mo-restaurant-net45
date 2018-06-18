using Portal.Modules.OrientalSails.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Portal.Modules.OrientalSails.BusinessLogic
{
    public class MenuAddingBLL
    {
        public MenuRepository MenuRepository { get; set; }
        public MenuAddingBLL() {
            MenuRepository = new MenuRepository();
        }
        public void Dispose() {
            if (MenuRepository != null)
            {
                MenuRepository.Dispose();
                MenuRepository = null;
            }
        }
        public void MenuSaveOrUpdate(Domain.Menu menu)
        {
            MenuRepository.SaveOrUpdate(menu);
        }
    }
}