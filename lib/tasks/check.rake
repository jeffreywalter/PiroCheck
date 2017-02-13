# frozen_string_literal: true
task check: :environment do
  desc 'Check for in stock items'
  urls = {
    'gimbals' => 'http://pirofliprc.com/New-FrSky-M9-Hall-Sensor-Gimbal-For-Taranis-X9D-X9d-Plus_p_3762.html',
    'evo' => 'http://pirofliprc.com/HyperLite-EVO-5-frame_p_3767.html',
    'evo hd' => 'http://pirofliprc.com/HyperLite-EVO-HD-5_p_3766.html',
    'battery' => 'http://pirofliprc.com/Pyro-Drone-Graphene-1550mAh-4S-148V-95C-Battery-w-XT60_p_3631.html'
  }

  checker = PiroCheck.new(urls)
  checker.check
end
