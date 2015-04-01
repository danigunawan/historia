module ApplicationHelper
  def social_share
    '<ul class="share-buttons">
      <li><a href="https://www.facebook.com/sharer/sharer.php?u=https%3A%2F%2Fhistoria-app.herokuapp.com%2F&t=" target="_blank" title="Share on Facebook" onclick="window.open("https://www.facebook.com/sharer/sharer.php?u=" + encodeURIComponent(document.URL) + "&t=" + encodeURIComponent(document.URL)); return false;"><i class="fa fa-facebook fa-lg"></i></a>
      </li>
    <li><a href="https://twitter.com/intent/tweet?source=https%3A%2F%2Fhistoria-app.herokuapp.com%2F&text=:%20https%3A%2F%2Fhistoria-app.herokuapp.com%2F" target="_blank" title="Tweet" onclick="window.open("https://twitter.com/intent/tweet?text=" + encodeURIComponent(document.title) + ":%20" + encodeURIComponent(document.URL)); return false;"><i class="fa fa-twitter fa-lg"></i></a>
    </li>
    <li><a href="https://plus.google.com/share?url=https%3A%2F%2Fhistoria-app.herokuapp.com%2F" target="_blank" title="Share on Google+" onclick="window.open("https://plus.google.com/share?url=" + encodeURIComponent(document.URL)); return false;"><i class="fa fa-google-plus fa-lg"></i></a>
    </li>
    <li><a href="http://pinterest.com/pin/create/button/?url=https%3A%2F%2Fhistoria-app.herokuapp.com%2F&description=" target="_blank" title="Pin it" onclick="window.open("http://pinterest.com/pin/create/button/?url=" + encodeURIComponent(document.URL) + "&description=" +  encodeURIComponent(document.title)); return false;"><i class="fa fa-pinterest fa-lg"></i></a>
    </li>
    <li><a href="mailto:?subject=&body=:%20https%3A%2F%2Fhistoria-app.herokuapp.com%2F" target="_blank" title="Email" onclick="window.open("mailto:?subject=" + encodeURIComponent(document.title) + "&body=" +  encodeURIComponent(document.URL)); return false;"><i class="fa fa-envelope-o fa-lg"></i></a>
    </li>
  </ul>'  
  end

  def footer
    '<footer>
      <span>Made by Julia |</span>
      <i class="fa fa-twitter fa-1x"></i>
      <i class="fa fa-github-alt fa-1x"></i>
      <i class="fa fa-linkedin fa-1x"></i>
      <i class="fa fa-globe fa-1x"></i>
    </footer>'
  end
end
