import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var keyartView: UIImageView!
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var metadataView: UILabel!
    @IBOutlet weak var gradientView: UILabel!
    @IBOutlet weak var durationView: UILabel!
    @IBOutlet weak var loadingbarView: UIImageView!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var collectionView: CollectionView!
    @IBOutlet weak var fakeUIView: UIImageView!
    
    // dispatch queue
    
    let queue = DispatchQueue(label: "queue", attributes: .concurrent)
    
    var pendingTask: DispatchWorkItem?
    var pendingTask2: DispatchWorkItem?
    var pendingTask3: DispatchWorkItem?
    
    // player layers
    
    var playerLayer: AVPlayerLayer?
    var playerLayerCBS: AVPlayerLayer?
    var playerLayerCNN: AVPlayerLayer?
    var playerLayerCSN: AVPlayerLayer?
    var playerLayerESPN: AVPlayerLayer?
    var playerLayerFOX: AVPlayerLayer?
    var playerLayerHBO: AVPlayerLayer?
    var playerLayerHSN: AVPlayerLayer?
    
    // pip layers
    
    var playerLayer2: AVPlayerLayer?
    var playerLayerCBS2: AVPlayerLayer?
    var playerLayerCNN2: AVPlayerLayer?
    var playerLayerCSN2: AVPlayerLayer?
    var playerLayerESPN2: AVPlayerLayer?
    var playerLayerFOX2: AVPlayerLayer?
    
    // cell content
    
    let channelArrays = Array(repeating: [
        "amc",
        "cbs",
        "cnn",
        "csn",
        "espn",
        "fox"
        ], count: 50)
    
    let channelKeyartArrays = Array(repeating: [
        "keyart_amc",
        "keyart_cbs",
        "keyart_cnn",
        "keyart_csn",
        "keyart_espn",
        "keyart_fox"
        ], count: 50)
    
    let channelLogoArrays = Array(repeating: [
        "logo_amc",
        "logo_cbs",
        "logo_cnn",
        "logo_csn",
        "logo_espn",
        "logo_fox"
        ], count: 50)
    
    var channelTitleArrays = Array(repeating: [
        "The Walking Dead",
        "The Talk",
        "State of the Union",
        "MIL vs SAC",
        "UCLA vs AZW",
        "Empire"
        ], count: 50)
    
    var channelMetadataArrays = Array(repeating: [
        "S2 E7 | The Other Side",
        "S7 EP182 | Actress Salma Hayek",
        "S77 E2 | Gary Johnson",
        "2017",
        "2017",
        "S2 E3 | Bout that"
        ], count: 50)
    
    var timeArrays = Array(repeating: [
        "1h 38m left",
        "32m left",
        "1h 30m left",
        "2h 20m left",
        "18m left",
        "12m left"
        ], count: 50)
    
    var durationArrays = Array(repeating: [
        "7:00 — 9:00p",
        "7:00 — 8:00p",
        "5:00 — 7:30p",
        "7:15 — 9:15p",
        "6:50 — 8:30p",
        "7:00 — 8:00p"
        ], count: 50)
    
    var channels = [String]()
    var channelKeyarts = [String]()
    var channelLogos = [String]()
    var channelTitles = [String]()
    var channelMetadatas = [String]()
    var channelTimes = [String]()
    var channelDurations = [String]()
    
    // mode
    
    var surfing = false
    
    // emulate lag
    
    var randomNum: UInt32?
    var someInt: Int?
    var someDouble: Double?
    var randomTime: TimeInterval?
    
    // loading bar
    
    var loading_0: UIImage!
    var loading_1: UIImage!
    var loading_2: UIImage!
    var loading_3: UIImage!
    var loading_4: UIImage!
    var loading_5: UIImage!
    var loading_6: UIImage!
    var loading_7: UIImage!
    var loading_8: UIImage!
    var loading_9: UIImage!
    var loading_10: UIImage!
    var loading_11: UIImage!
    var loading_12: UIImage!
    var loading_13: UIImage!
    var loading_14: UIImage!
    var loading_15: UIImage!
    var loading_16: UIImage!
    var loading_17: UIImage!
    var loading_18: UIImage!
    var loading_19: UIImage!
    var loading_20: UIImage!
    var loading_21: UIImage!
    var loading_22: UIImage!
    var loading_23: UIImage!
    var loading_24: UIImage!
    var loading_25: UIImage!
    var loading_26: UIImage!
    var loading_27: UIImage!
    var loading_28: UIImage!
    var loading_29: UIImage!
    var loading_30: UIImage!
    var loading_31: UIImage!
    var loading_32: UIImage!
    var loading_33: UIImage!
    var loading_34: UIImage!
    var loading_35: UIImage!
    var loading_36: UIImage!
    var loading_37: UIImage!
    var loading_38: UIImage!
    var loading_39: UIImage!
    var loading_40: UIImage!
    var loading_41: UIImage!
    var loading_42: UIImage!
    var loading_43: UIImage!
    var loading_44: UIImage!
    var loading_45: UIImage!
    var images: [UIImage]!
    var animatedImage: UIImage!
    
    // actual players
    
    var player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "amc", ofType:"mp4")!))
    var playerCBS = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "cbs", ofType:"mp4")!))
    var playerCNN = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "cnn", ofType:"mp4")!))
    var playerCSN = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "csn", ofType:"mp4")!))
    var playerESPN = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "espn", ofType:"mp4")!))
    var playerFOX = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "fox", ofType:"mp4")!))
    
    // current channel
    
    var currentChannel: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        (UIApplication.shared as! MyApplication).myVC = self
        
        // AMC
        
        playerLayer = AVPlayerLayer(player: self.player)
        playerLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayer!.frame = self.videoView.frame
        playerLayer?.isHidden = false
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player.currentItem, queue: nil, using: { (_) in
            DispatchQueue.main.async {
                self.player.seek(to: kCMTimeZero)
                self.player.play()
            }
        })
        
        self.player.isMuted = false;
        self.player.play()
        
        self.videoView.layer.addSublayer(playerLayer!)
        
        // CBS

        playerLayerCBS = AVPlayerLayer(player: self.playerCBS)
        playerLayerCBS?.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayerCBS!.frame = self.videoView.frame
        playerLayerCBS?.isHidden = true
        
        self.videoView.layer.addSublayer(playerLayerCBS!)
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.playerCBS.currentItem, queue: nil, using: { (_) in
            DispatchQueue.main.async {
                self.playerCBS.seek(to: kCMTimeZero)
                self.playerCBS.play()
            }
        })
        
        self.playerCBS.isMuted = true;
        self.playerCBS.play()
 
        // video player CNN
        
        playerLayerCNN = AVPlayerLayer(player: self.playerCNN)
        playerLayerCNN?.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayerCNN!.frame = self.videoView.frame
        playerLayerCNN?.isHidden = true
        
        self.videoView.layer.addSublayer(playerLayerCNN!)
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.playerCNN.currentItem, queue: nil, using: { (_) in
            DispatchQueue.main.async {
                self.playerCNN.seek(to: kCMTimeZero)
                self.playerCNN.play()
            }
        })
        
        self.playerCNN.isMuted = true;
        self.playerCNN.play()
        
        // video player CSN
        
        playerLayerCSN = AVPlayerLayer(player: self.playerCSN)
        playerLayerCSN?.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayerCSN!.frame = self.videoView.frame
        playerLayerCSN?.isHidden = true
        
        self.videoView.layer.addSublayer(playerLayerCSN!)
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.playerCSN.currentItem, queue: nil, using: { (_) in
            DispatchQueue.main.async {
                self.playerCSN.seek(to: kCMTimeZero)
                self.playerCSN.play()
            }
        })
        
        self.playerCSN.isMuted = true;
        self.playerCSN.play()
        
        // video player ESPN
        
        playerLayerESPN = AVPlayerLayer(player: self.playerESPN)
        playerLayerESPN?.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayerESPN!.frame = self.videoView.frame
        playerLayerESPN?.isHidden = true
        
        self.videoView.layer.addSublayer(playerLayerESPN!)
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.playerESPN.currentItem, queue: nil, using: { (_) in
            DispatchQueue.main.async {
                self.playerESPN.seek(to: kCMTimeZero)
                self.playerESPN.play()
            }
        })
        
        self.playerESPN.isMuted = true;
        self.playerESPN.play()
        
        // video player FOX
        
        playerLayerFOX = AVPlayerLayer(player: self.playerFOX)
        playerLayerFOX?.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayerFOX!.frame = self.videoView.frame
        playerLayerFOX?.isHidden = true
        
        self.videoView.layer.addSublayer(playerLayerFOX!)
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.playerFOX.currentItem, queue: nil, using: { (_) in
            DispatchQueue.main.async {
                self.playerFOX.seek(to: kCMTimeZero)
                self.playerFOX.play()
            }
        })
        
        self.playerFOX.isMuted = true;
        self.playerFOX.play()
        
  

        // resume playback upon app focus
        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForegroundNotification), name: .UIApplicationWillEnterForeground, object: nil)
        
        // tap detection
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.respondToTapGesture))
        tapGesture.allowedPressTypes = [NSNumber(value: UIPressType.menu.rawValue)]
        self.view.addGestureRecognizer(tapGesture)
        
        // swipe detection
        
        let swipeUp = UISwipeGestureRecognizer(target: self.overlayView, action: #selector(self.respondToSwipeGesture))
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        self.overlayView.addGestureRecognizer(swipeUp)
        
        // gradient layer
        
        let gradientLayer = CAGradientLayer()

        gradientLayer.frame = CGRect(x: 0, y: 780, width: 1920, height: 400)
        gradientLayer.colors = [UIColor.black.withAlphaComponent(0.5), UIColor.black.cgColor]
        gradientLayer.locations = [0.0, 0.3]
        
        self.overlayView.layer.insertSublayer(gradientLayer, at: 4)
        
        // initial appearance
                
        // Collection View
        self.collectionView.isScrollEnabled = false
        self.collectionView.alpha = 0.0
        
        // overlay view
        self.overlayView.alpha = 0.0
        
        // loading view
        self.loadingView.alpha = 0.0
        
        // Fake UI View
        self.fakeUIView.alpha = 0.0
        self.fakeUIView.frame = CGRect(x: 0, y: 1080, width: 1920, height: 1080)
        
        // fake populate infinite loop
        
        for array in channelArrays {
            channels += array
        }
        
        for array in channelKeyartArrays {
            channelKeyarts += array
        }
        
        for array in channelLogoArrays {
            channelLogos += array
        }
        
        for array in channelTitleArrays {
            channelTitles += array
        }
        
        for array in channelMetadataArrays {
            channelMetadatas += array
        }
        
        for array in timeArrays {
            channelTimes += array
        }
        
        for array in durationArrays {
            channelDurations += array
        }
        
        // loading bar
        
        loading_0 = UIImage(named: "videoloadingbar_loop_00000")
        loading_1 = UIImage(named: "videoloadingbar_loop_00001")
        loading_2 = UIImage(named: "videoloadingbar_loop_00002")
        loading_3 = UIImage(named: "videoloadingbar_loop_00003")
        loading_4 = UIImage(named: "videoloadingbar_loop_00004")
        loading_5 = UIImage(named: "videoloadingbar_loop_00005")
        loading_6 = UIImage(named: "videoloadingbar_loop_00006")
        loading_7 = UIImage(named: "videoloadingbar_loop_00007")
        loading_8 = UIImage(named: "videoloadingbar_loop_00008")
        loading_9 = UIImage(named: "videoloadingbar_loop_00009")
        loading_10 = UIImage(named: "videoloadingbar_loop_00010")
        loading_11 = UIImage(named: "videoloadingbar_loop_00011")
        loading_12 = UIImage(named: "videoloadingbar_loop_00012")
        loading_13 = UIImage(named: "videoloadingbar_loop_00013")
        loading_14 = UIImage(named: "videoloadingbar_loop_00014")
        loading_15 = UIImage(named: "videoloadingbar_loop_00015")
        loading_16 = UIImage(named: "videoloadingbar_loop_00016")
        loading_17 = UIImage(named: "videoloadingbar_loop_00017")
        loading_18 = UIImage(named: "videoloadingbar_loop_00018")
        loading_19 = UIImage(named: "videoloadingbar_loop_00019")
        loading_20 = UIImage(named: "videoloadingbar_loop_00020")
        loading_21 = UIImage(named: "videoloadingbar_loop_00021")
        loading_22 = UIImage(named: "videoloadingbar_loop_00022")
        loading_23 = UIImage(named: "videoloadingbar_loop_00023")
        loading_24 = UIImage(named: "videoloadingbar_loop_00024")
        loading_25 = UIImage(named: "videoloadingbar_loop_00025")
        loading_26 = UIImage(named: "videoloadingbar_loop_00026")
        loading_27 = UIImage(named: "videoloadingbar_loop_00027")
        loading_28 = UIImage(named: "videoloadingbar_loop_00028")
        loading_29 = UIImage(named: "videoloadingbar_loop_00029")
        loading_30 = UIImage(named: "videoloadingbar_loop_00030")
        loading_31 = UIImage(named: "videoloadingbar_loop_00031")
        loading_32 = UIImage(named: "videoloadingbar_loop_00032")
        loading_33 = UIImage(named: "videoloadingbar_loop_00033")
        loading_34 = UIImage(named: "videoloadingbar_loop_00034")
        loading_35 = UIImage(named: "videoloadingbar_loop_00035")
        loading_36 = UIImage(named: "videoloadingbar_loop_00036")
        loading_37 = UIImage(named: "videoloadingbar_loop_00037")
        loading_38 = UIImage(named: "videoloadingbar_loop_00038")
        loading_39 = UIImage(named: "videoloadingbar_loop_00039")
        loading_40 = UIImage(named: "videoloadingbar_loop_00040")
        loading_41 = UIImage(named: "videoloadingbar_loop_00041")
        loading_42 = UIImage(named: "videoloadingbar_loop_00042")
        loading_43 = UIImage(named: "videoloadingbar_loop_00043")
        loading_44 = UIImage(named: "videoloadingbar_loop_00044")
        loading_45 = UIImage(named: "videoloadingbar_loop_00045")
        
        images = [
            loading_0,
            loading_1,
            loading_2,
            loading_3,
            loading_4,
            loading_5,
            loading_6,
            loading_7,
            loading_8,
            loading_9,
            loading_10,
            loading_11,
            loading_12,
            loading_13,
            loading_14,
            loading_15,
            loading_16,
            loading_17,
            loading_18,
            loading_19,
            loading_20,
            loading_21,
            loading_22,
            loading_23,
            loading_24,
            loading_25,
            loading_26,
            loading_27,
            loading_28,
            loading_29,
            loading_30,
            loading_31,
            loading_32,
            loading_33,
            loading_34,
            loading_35,
            loading_36,
            loading_37,
            loading_38,
            loading_39,
            loading_40,
            loading_41,
            loading_42,
            loading_43,
            loading_44,
            loading_45
        ]
        
        animatedImage = UIImage.animatedImage(with: images, duration: 1.3)
        loadingbarView.image = animatedImage
        loadingbarView.layer.cornerRadius = 10
    }
    

    
    func appWillEnterForegroundNotification() {
        playerLayer?.isHidden = false
        playerLayerCBS?.isHidden = false
        playerLayerCNN?.isHidden = false
        playerLayerCSN?.isHidden = false
        playerLayerESPN?.isHidden = false
        playerLayerFOX?.isHidden = false
        
        playerLayer?.player?.isMuted = false
        
        playerLayer?.player?.play()
        playerLayerCBS?.player?.play()
        playerLayerCNN?.player?.play()
        playerLayerCSN?.player?.play()
        playerLayerESPN?.player?.play()
        playerLayerFOX?.player?.play()
    }
    
    func doRestartTimer() {
        pendingTask2 = DispatchWorkItem {
            self.doHide()
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(5000), execute: self.pendingTask2!)
    }
    
    func doInvalidateTimer() {
        pendingTask2?.cancel()
        
        self.doShow()
    }
    
    func doShow() {
        pendingTask = DispatchWorkItem {
            UIView.animate(withDuration: 0.3, animations: {
                self.overlayView.alpha = 1.0
                self.collectionView?.alpha = 1.0
            }, completion: nil)
        }
        
        DispatchQueue.main.async(execute: self.pendingTask!)
    }
    
    func doShowFakeUI() {
        self.doHide()
        
        UIView.animate(withDuration: 0.3, animations: {
            self.fakeUIView.alpha = 1.0
            self.fakeUIView.frame = CGRect(x: 0, y: 0, width: 1920, height: 1080)
        }, completion: nil)
    }
    
    func doHide() {
        UIView.animate(withDuration: 0.3, animations: {
            self.overlayView.alpha = 0.0
            self.collectionView.alpha = 0.0
            self.fakeUIView.alpha = 0.0
            self.fakeUIView.frame = CGRect(x: 0, y: 1080, width: 1920, height: 1080)
        }, completion: nil)
    }
    
    func respondToTapGesture() {
        self.doHide()
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.up:
                // debugPrint("Swiped up")
                self.doShowFakeUI()
            default:
                break
            }
        }
    }
    
    func doChannelChange(channel: String) {
        currentChannel = channel
        
        debugPrint(currentChannel)
        
        switch channel {
        case "amc":
            playerLayer?.player?.isMuted = false
            playerLayer?.isHidden = false
            
            playerLayerCBS?.player?.isMuted = true
            playerLayerCBS?.isHidden = true
            playerLayerCNN?.player?.isMuted = true
            playerLayerCNN?.isHidden = true
            
            playerLayerCSN?.player?.isMuted = true
            playerLayerCSN?.isHidden = true
            
            playerLayerESPN?.player?.isMuted = true
            playerLayerESPN?.isHidden = true
            
            playerLayerFOX?.player?.isMuted = true
            playerLayerFOX?.isHidden = true
            
        case "cbs":
            playerLayer?.player?.isMuted = true
            playerLayer?.isHidden = true
            
            playerLayerCBS?.player?.isMuted = false
            playerLayerCBS?.isHidden = false
            
            playerLayerCNN?.player?.isMuted = true
            playerLayerCNN?.isHidden = true
            
            playerLayerCSN?.player?.isMuted = true
            playerLayerCSN?.isHidden = true
            
            playerLayerESPN?.player?.isMuted = true
            playerLayerESPN?.isHidden = true
            
            playerLayerFOX?.player?.isMuted = true
            playerLayerFOX?.isHidden = true
        
        case "cnn":
            playerLayer?.player?.isMuted = true
            playerLayer?.isHidden = true
            
            playerLayerCBS?.player?.isMuted = true
            playerLayerCBS?.isHidden = true
            
            playerLayerCNN?.player?.isMuted = false
            playerLayerCNN?.isHidden = false
            
            playerLayerCSN?.player?.isMuted = true
            playerLayerCSN?.isHidden = true
            
            playerLayerESPN?.player?.isMuted = true
            playerLayerESPN?.isHidden = true
            
            playerLayerFOX?.player?.isMuted = true
            playerLayerFOX?.isHidden = true
            
        case "csn":
            playerLayer?.player?.isMuted = true
            playerLayer?.isHidden = true
            
            playerLayerCBS?.player?.isMuted = true
            playerLayerCBS?.isHidden = true
            
            playerLayerCNN?.player?.isMuted = true
            playerLayerCNN?.isHidden = true
            
            playerLayerCSN?.player?.isMuted = false
            playerLayerCSN?.isHidden = false
            
            playerLayerESPN?.player?.isMuted = true
            playerLayerESPN?.isHidden = true
            
            playerLayerFOX?.player?.isMuted = true
            playerLayerFOX?.isHidden = true
            
        case "espn":
            playerLayer?.player?.isMuted = true
            playerLayer?.isHidden = true
            
            playerLayerCBS?.player?.isMuted = true
            playerLayerCBS?.isHidden = true
            
            playerLayerCNN?.player?.isMuted = true
            playerLayerCNN?.isHidden = true
            
            playerLayerCSN?.player?.isMuted = true
            playerLayerCSN?.isHidden = true
            
            playerLayerESPN?.player?.isMuted = false
            playerLayerESPN?.isHidden = false
            
            playerLayerFOX?.player?.isMuted = true
            playerLayerFOX?.isHidden = true
            
        case "fox":
            playerLayer?.player?.isMuted = true
            playerLayer?.isHidden = true
            
            playerLayerCBS?.player?.isMuted = true
            playerLayerCBS?.isHidden = true
            
            playerLayerCNN?.player?.isMuted = true
            playerLayerCNN?.isHidden = true
            
            playerLayerCSN?.player?.isMuted = true
            playerLayerCSN?.isHidden = true
            
            playerLayerESPN?.player?.isMuted = true
            playerLayerESPN?.isHidden = true
            
            playerLayerFOX?.player?.isMuted = false
            playerLayerFOX?.isHidden = false
            
        default:
            debugPrint("default")
        }
    }

    /********************************************************/
    // collection view
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return channels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        let channel = self.channels[indexPath.row]
        
        
        cell.keyartView.image = UIImage(named: String(describing: channelKeyarts[indexPath.row]))
        cell.keyartView.contentMode = .scaleAspectFit
        
        switch channel {
        case "amc":
            playerLayer2 = AVPlayerLayer(player: self.player)
        case "cbs":
            playerLayer2 = AVPlayerLayer(player: self.playerCBS)
        case "cnn":
            playerLayer2 = AVPlayerLayer(player: self.playerCNN)
        case "csn":
            playerLayer2 = AVPlayerLayer(player: self.playerCSN)
        case "espn":
            playerLayer2 = AVPlayerLayer(player: self.playerESPN)
        case "fox":
            playerLayer2 = AVPlayerLayer(player: self.playerFOX)
        default:
            debugPrint("default")
        }

        playerLayer2?.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayer2!.frame = cell.pipView.frame
        
        cell.pipView.layer.addSublayer(playerLayer2!)
       
        cell.pipView.alpha = 0.0
        
        cell.logoView.image = UIImage(named: String(describing: channelLogos[indexPath.row]))
        cell.logoView.contentMode = .scaleAspectFit
        
        cell.titleView.text = String(describing: channelTitles[indexPath.row])
        
        cell.metadataView.text = String(describing: channelMetadatas[indexPath.row])
        
        cell.durationView.text = String(describing: channelDurations[indexPath.row])
        
        cell.timeView.text = String(describing: channelTimes[indexPath.row])
        
        cell.alpha = 0.3
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.item)!")
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        pendingTask?.cancel()
        
        // hide UI
        self.doHide()
        
        pendingTask3 = DispatchWorkItem {
            // emulate loading
            self.randomNum = arc4random_uniform(15) // range
            self.someInt = Int(self.randomNum!)
            self.someDouble = Double(self.someInt!) / 10
            
            if (self.someDouble! < 0.5) {
                self.someDouble! = 0.5
            }
            
            // populate loading view
            self.keyartView.image = UIImage(named: String(describing: self.channelKeyarts[indexPath.row]))
            self.logoView.image = UIImage(named: String(describing: self.channelLogos[indexPath.row]))
            self.titleView.text = String(describing: self.channelTitles[indexPath.row])
            self.metadataView.text = String(describing: self.channelMetadatas[indexPath.row])
            self.durationView.text = String(describing: self.channelDurations[indexPath.row])

            UIView.animate(withDuration: 0.3, animations: {
                self.loadingView.alpha = 1.0
            }, completion: { (finished: Bool) in
                // hide UI again just in case it flakes
                self.doHide()
                
                UIView.animate(withDuration: 0.3, delay: self.someDouble!, animations: {
                    self.doChannelChange(channel: self.channels[indexPath.row])
                    
                    self.loadingView.alpha = 0.0
                }, completion: nil)
                
            })
            
        }
        
        DispatchQueue.main.async(execute: self.pendingTask3!)
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        // cell?.backgroundColor = UIColor.cyan
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
        // return CGSize(width: CGFloat(900), height: CGFloat(900))
    }
    
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        var cell: CollectionViewCell
        
        
        
        // As we are not using the default scrollable feature from the UIScrollView we can scroll ourself to the center of the focused cell
        
        if ((context.nextFocusedIndexPath != nil) && !collectionView.isScrollEnabled) {
            collectionView.scrollToItem(at: context.nextFocusedIndexPath!, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
        }
        
        if (context.previouslyFocusedIndexPath != nil) {
            cell = collectionView.cellForItem(at: context.previouslyFocusedIndexPath!) as! CollectionViewCell
            
            UIView.animate(withDuration: 0.3, animations: {
                collectionView.cellForItem(at: context.previouslyFocusedIndexPath!)?.alpha = 0.3
                cell.pipView.alpha = 0.0
                // collectionView.cellForItem(at: context.previouslyFocusedIndexPath!)?.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                
            }, completion: { (finished: Bool) in
                cell.keyartView.adjustsImageWhenAncestorFocused = true
            })
        }
        
        if (context.nextFocusedIndexPath != nil) {
            cell = collectionView.cellForItem(at: context.nextFocusedIndexPath!) as! CollectionViewCell
            
            UIView.animate(withDuration: 0.3, animations: {
                collectionView.cellForItem(at: context.nextFocusedIndexPath!)?.alpha = 1.0
                
                // collectionView.cellForItem(at: context.nextFocusedIndexPath!)?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                
            }, completion: nil)
         
            
            // emulate loading
            self.randomNum = arc4random_uniform(15) // range
            self.someInt = Int(self.randomNum!)
            self.someDouble = Double(self.someInt!) / 10
            
            if (self.someDouble! < 0.5) {
                self.someDouble! = 0.5
            }
            
            if (self.channels[(context.nextFocusedIndexPath?.row)!] != currentChannel) {
                UIView.animate(withDuration: 0.3, delay: self.someDouble!, animations: {
                    cell.pipView.alpha = 1.0
                }, completion: { (finished: Bool) in
                    cell.keyartView.adjustsImageWhenAncestorFocused = false
                })
            }
            
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.collectionView?.scrollToItem(at: IndexPath(row: 149, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: false)
        
        self.currentChannel = self.channels[0]
        debugPrint(currentChannel)
    }
    
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        
        if(presses.first?.type == UIPressType.menu) {
            self.doHide()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    
}



























