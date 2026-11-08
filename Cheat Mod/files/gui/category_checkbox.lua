local a = {}

function a:onSizeChanged()
    self.rawW = self.rawH;
    self.w = self.h;

    self.baseClass.onSizeChanged(self);
end

gui.register("CategoryCheckbox", a, "Checkbox")