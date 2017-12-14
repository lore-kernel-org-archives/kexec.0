Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1ePPlF-0003Gu-1t
 for kexec@lists.infradead.org; Thu, 14 Dec 2017 09:25:02 +0000
Date: Thu, 14 Dec 2017 17:24:29 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: Regression: kexec/kdump boot hangs with x86/vector commits
Message-ID: <20171214092429.GA2004@dhcp-128-65.nay.redhat.com>
References: <20171213025256.GA1913@dhcp-128-65.nay.redhat.com>
 <20171213155746.GA29572@yu-chen.sh.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20171213155746.GA29572@yu-chen.sh.intel.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Yu Chen <yu.c.chen@intel.com>
Cc: Juergen Gross <jgross@suse.com>, Tony Luck <tony.luck@intel.com>, kexec@lists.infradead.org, mingo@kernel.org, Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, Rui Zhang <rui.zhang@intel.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@linux.intel.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>

On 12/13/17 at 11:57pm, Yu Chen wrote:
> On Wed, Dec 13, 2017 at 10:52:56AM +0800, Dave Young wrote:
> > Hi,
> > 
> > Kexec reboot and kdump has broken on my laptop for long time with
> > 4.15.0-rc1+ kernels. With the patch below an early panic been fixed:
> > https://patchwork.kernel.org/patch/10084289/
> > 
> > But still can not get a successful reboot, it looked like graphic
> > issue, but after bisecting the kernel, I got below:
> > 
> > [dyoung@dhcp-*-* linux]$ git bisect good
> > There are only 'skip'ped commits left to test.
> > The first bad commit could be any of:
> > 2db1f959d9dc16035f2eb44ed5fdb2789b754d6a
> > 4900be83602b6be07366d3e69f756c1959f4169a
> > We cannot bisect more!
> > 
> > These two commits can no be reverted because of code conflicts, thus
> > I reverted the whole series from Thomas (below commits), with those
> > x86/vector changes reverted, kexec reboot works fine.
> > 
> > Could you help to take a look, any thoughts?  I can do the test
> > if you have some debug patch to try.
> Is it possible that the "second" kernel runs on non-zero CPU? If yes,
> what if some irqs are only delivered to cpu0? (use cpumask_of(0)
> directly)

Thanks for the reply.

For kdump, yes, for kexec, I'm not sure.  

Here is some kexec kernel boot log:
http://people.redhat.com/~ruyang/misc/kexec-regression.txt

Copy the lockup call trace here:
[   23.779285] NMI watchdog: Watchdog detected hard LOCKUP on cpu 0             
[   23.779285] Modules linked in: arc4 rtsx_pci_sdmmc i915 iwlmvm kvm_intel mac8
0211 kvm irqbypass btusb btrtl btbcm intel_gtt btintel drm_kms_helper snd_hda_in
tel syscopyarea bluetooth iwlwifi snd_hda_codec snd_hwdep snd_hda_core sysfillre
ct snd_seq sysimgblt input_leds fb_sys_fops e1000e ecdh_generic cfg80211 snd_seq
_device drm snd_pcm serio_raw ptp pcspkr thinkpad_acpi i2c_i801 snd_timer rtsx_p
ci pps_core snd soundcore rfkill video                                          
[   23.779307] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.15.0-rc3+ #378       
[   23.779308] Hardware name: LENOVO 20ARS1BJ02/20ARS1BJ02, BIOS GJET92WW (2.42 
) 03/03/2017                                                                    
[   23.779312] RIP: 0010:poll_idle+0x2f/0x5f                                    
[   23.779313] RSP: 0018:ffffffff81c03e80 EFLAGS: 00000246                      
[   23.779314] RAX: ffffffff81c0f4c0 RBX: ffffffff81c6db80 RCX: 0000000000000000
[   23.779315] RDX: 0000000000000000 RSI: ffffffff81c6db80 RDI: ffff88021f2201e8
[   23.779316] RBP: ffff88021f2201e8 R08: 000000349a65b7dd R09: ffff88021f216db4
[   23.779317] R10: ffffffff81c03e68 R11: 0000000000000000 R12: 0000000000000000
[   23.779318] R13: ffffffff81c6db98 R14: 0000000000000000 R15: 0000000578a065b1
[   23.779319] FS:  0000000000000000(0000) GS:ffff88021f200000(0000) knlGS:00000
00000000000                                                                     
[   23.779320] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033                
[   23.779321] CR2: 00007ffed1d0ee60 CR3: 000000021ec0a006 CR4: 00000000001606b0
[   23.779322] Call Trace:                                                      
[   23.779328]  cpuidle_enter_state+0x6a/0x2c0                                  
[   23.779333]  do_idle+0x17b/0x1d0                                             
[   23.779335]  cpu_startup_entry+0x6f/0x80                                     
[   23.779338]  start_kernel+0x431/0x451                                        
[   23.779342]  secondary_startup_64+0xa5/0xb0                                  
[   23.779344] Code: 00 fb 66 0f 1f 44 00 00 65 48 8b 04 25 40 c4 00 00 f0 80 48
 02 20 48 8b 08 83 e1 08 74 0d eb 12 f3 90 65 48 8b 04 25 40 c4 00 00 <48> 8b 00
 a8 08 74 ee 65 48 8b 04 25 40 c4 00 00 f0 80 60 02 df

Thanks
Dave
> 
> Thanks,
> 	Yu
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
