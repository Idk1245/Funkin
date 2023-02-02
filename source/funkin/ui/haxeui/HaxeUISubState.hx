package funkin.ui.haxeui;

import haxe.ui.RuntimeComponentBuilder;
import haxe.ui.core.Component;
import haxe.ui.events.MouseEvent;

class HaxeUISubState extends MusicBeatSubstate
{
  // The component representing the main UI.
  public var component:Component;

  var _componentKey:String;

  public function new(key:String)
  {
    super();
    _componentKey = key;
  }

  override function create()
  {
    super.create();

    refreshComponent();
  }

  /**
   * Builds a component from a given XML file.
   * Call this in your code to load additional components at runtime.
   */
  public function buildComponent(assetPath:String)
  {
    trace('Building component $assetPath');
    return RuntimeComponentBuilder.fromAsset(assetPath);
  }

  override function update(elapsed:Float)
  {
    super.update(elapsed);

    // Force quit.
    if (FlxG.keys.justPressed.F4) FlxG.switchState(new MainMenuState());

    // Refresh the component.
    if (FlxG.keys.justPressed.F5)
    {
      refreshComponent();
    }
  }

  function refreshComponent()
  {
    /*
      if (component != null)
      {
        remove(component);
        component = null;
      }

      if (component != null)
      {
        trace('Success!');
        add(component);
      }
      else
      {
        trace('Failed to build component $_componentKey');
      }
     */

    if (component == null)
    {
      component = buildComponent(_componentKey);
      add(component);
      trace(component);
    }
    else
    {
      var component2 = buildComponent(_componentKey);
      component2.x += 100;
      add(component2);
      trace(component2);
      remove(component);
    }
  }

  /**
   * Add an onClick listener to a HaxeUI menu bar item.
   */
  function addUIClickListener(key:String, callback:MouseEvent->Void)
  {
    var target:Component = findComponent(key);
    if (target == null)
    {
      // Gracefully handle the case where the item can't be located.
      trace('WARN: Could not locate menu item: $key');
    }
    else
    {
      target.onClick = callback;
    }
  }

  public function findComponent<T:Component>(criteria:String = null, type:Class<T> = null, recursive:Null<Bool> = null, searchType:String = "id"):Null<T>
  {
    if (component == null) return null;

    return component.findComponent(criteria, type, recursive, searchType);
  }

  override function destroy()
  {
    if (component != null) remove(component);
    component = null;
  }
}