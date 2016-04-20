# Alternative way to deal with iOS Rotation using autolayout

Due to some difficulties that I faced when developing iPad apps that rotates,
I decided to publish the approach that I came up discussing with some friends.

The scenario:

I have one view controller and one view (.xib) for both landscape and portrait orientations,
Each orientation have its particular layout as I show in the following pictures:

![portrait](https://cloud.githubusercontent.com/assets/692036/14687583/dc721d86-0714-11e6-92c5-b24ebeb7209b.png)
Portrait

![landscape](https://cloud.githubusercontent.com/assets/692036/14687693/4a021388-0715-11e6-9513-c7502981e12a.png)
Landscape

Using a previously defined naming pattern, designing the views became easier and
defining 2 IBOutletCollections that contains the specific NSLayoutConstraints
for each orientation enabled me to manage which constraints should be installed
when the screen rotates.

The naming pattern adopted for constraints was: (View)(Constraint)(Orientation)
For example:
- Top constraint for the yellow view in landscape: YellowTopLandscape
- In case the constraint is useful for both orientation, I used "Both" in the sufix ex: OrangeTopBoth

This pattern helps to debug constraints, I should also advise to use this names on the Constraint Identifier.
Also this pattern could be useful using the interface builder filter in case you want to adjust your xib to display specific orientation layout.

To define the specific constraints follow these steps:

- Start defining your layout for portrait (the order doesn't matter, just to assume a few things);
- Define your view's layout and its constraints, keep in mind every constraint that will be used for both orientations, and name them;
- For the portrait-only constraints name them, and uncheck the "Installed" checkbox on the attributes inspector;
- Redefine your view's layout for landscape orientation, and setup the landscape-only constraints, and name them;
- link your the orientation specific constraints to each IBOutletCollections.
- Check the code, and see how it works.

If you want to check how the layout is presented on each orientation just make sure they both work, and install/uninstall the specific orientation's constraints and update the main view's frame.

For the record, due to this implementation of viewDidLayoutSubviews:

```objc
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    if (self.lastOrientation != Landscape) { //The orientation specified on the nib file
        [self setUpViewConstraintsForInterfaceOrientation:self.lastOrientation];
    }
}
```
I advise you to keep the nib file with the landscape setup. (You can change this, by changing the code)
