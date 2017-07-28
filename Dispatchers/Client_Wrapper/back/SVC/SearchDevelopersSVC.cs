using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Fwk.Bases;
using Health.Isvc.RetrivePatients;
using Health.Back;

using Health.BE;
using Health.ISVC;
using Health.DAC;
using Fwk.Exceptions;


namespace Health.SVC
{
    /// <summary>
    /// Svc que retorna los desarrolladores de reistencia
    /// 
    /// </summary>
    public class SearchDevelopersSVC :
        BusinessService<SearchDevelopersREQ, SearchDevelopersRES>
    {
        public override SearchDevelopersRES Execute(SearchDevelopersREQ pServiceRequest)
        {
            SearchDevelopersRES res = new SearchDevelopersRES();

            FunctionalException fx = new FunctionalException("Saldo insuf");
            fx.ErrorId = "80-Error";
            fx.Source = "Sistema contable";
            throw fx;

            var listaFea = DevDAC.Search(pServiceRequest.BusinessData.FechaDesde, pServiceRequest.ContextInformation.AppId);
            res.BusinessData = new DevBEList();
            res.BusinessData.AddRange(listaFea);

            return res;

        }
    }
}

