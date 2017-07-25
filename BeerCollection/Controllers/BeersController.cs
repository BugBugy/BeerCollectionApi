using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Description;
using BeerCollection.Models;
using Newtonsoft.Json;
using System.Text;

namespace BeerCollection.Controllers
{
    public class BeersController : ApiController
    {
        private beer_collectionEntities db = new beer_collectionEntities();
        
        // GET: api/Beers
        public IHttpActionResult GetBeers()
        {
            var beers = from beer in db.Beers
                        select new
                        {
                            Id = beer.Id,
                            Name = beer.Name,
                            Rating = beer.AverageRating
                        };
            return Json(beers);
        }
        
        // GET: api/Beers
        [System.Web.Http.AcceptVerbs("GET", "POST")]
        [System.Web.Http.HttpGet]
        public IHttpActionResult FindBeer([FromUri(Name = "id")]string term)
        {
            var beers = from beer in db.Beers
                        where beer.Name.ToLower().Contains(term.ToLower())
                        select new
                        {
                            Id = beer.Id,
                            Name = beer.Name,
                            Rating = beer.AverageRating
                        };
            return Json(beers);
        }

        // POST: api/Beers
        [ResponseType(typeof(Beer))]
        public IHttpActionResult PostBeer(Beer beer)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            if (beer.AverageRating.HasValue && beer.AverageRating > 0 && beer.AverageRating < 6)
            {
                return BadRequest("Incorrect Data");

            }
            else
                db.Beers.Add(beer);
            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateException)
            {
                if (BeerExists(beer.Id))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("BeerApi", new { id = beer.Id }, beer);
        }
        // POST: api/Beers
        [ResponseType(typeof(BeerRating))]
        public IHttpActionResult PostBeerRating(BeerRating beerRating)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            if (beerRating?.Rating > 0 && beerRating.Rating < 6)
            {
                db.BeerRatings.Add(beerRating);
                db.SaveChanges();
                var allratings = from ratings in db.BeerRatings
                                 where ratings.BeerId == beerRating.BeerId
                                 select new
                                 {
                                     Rating = ratings.Rating
                                 };
                double avg = allratings.Average(x => x.Rating);
                Beer beer = (from br in db.Beers
                             where br.Id == beerRating.BeerId
                             select br).First();
                beer.AverageRating = avg;
            }
            else
                return BadRequest("Incorrect Data");
            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateException)
            {
                throw;
            }

            return Ok("Success");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool BeerExists(int id)
        {
            return db.Beers.Count(e => e.Id == id) > 0;
        }
    }
}