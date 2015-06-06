(function(){
  var template = "<ul>";
  template += "<% for(var i=0; i<files.length; i++){ %>";
  template += "<li>";
  template += "<% if(files[i].resource_type == \"raw\") { %>";
  template += "<div class=\"raw-file\"></div>";
  template += "<% } else { %>";
  template += "<img ";
  template += "src=\"<%= $.cloudinary.url(files[i].public_id, { \"version\": files[i].version, \"format\": 'jpg', \"crop\": 'fill' }) %>\"";
  template += "alt=\"\" />";
  template += "<% } %>";
  template += "<a href=\"#\" data-remove=\"<%= files[i].public_id %>\">Remove</a>";
  template += "</li>";
  template += "<% } %>";
  template += "</ul>";

  window.Careers.config.attachinary = {
    template: template
  };
})();
