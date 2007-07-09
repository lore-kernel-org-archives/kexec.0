Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ik-out-1112.google.com ([66.249.90.183])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1I7iK6-0007AJ-I2
	for kexec@lists.infradead.org; Sun, 08 Jul 2007 21:46:01 -0400
Received: by ik-out-1112.google.com with SMTP id c29so594058ika
	for <kexec@lists.infradead.org>; Sun, 08 Jul 2007 18:45:57 -0700 (PDT)
Message-ID: <32209efe0707081845y4141a363ic3a0a013ff6d527d@mail.gmail.com>
Date: Sun, 8 Jul 2007 18:45:56 -0700
From: "Natalie Protasevich" <protasnb@gmail.com>
Subject: Re: kexec fails (pretty often)
In-Reply-To: <10EA09EFD8728347A513008B6B0DA77A01751443@pdsmsx411.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
References: <32209efe0707081045w7f110b37h92f385d9103d49ab@mail.gmail.com>
	<10EA09EFD8728347A513008B6B0DA77A01751443@pdsmsx411.ccr.corp.intel.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: "Zou, Nanhai" <nanhai.zou@intel.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, Kexec Mailing List <kexec@lists.infradead.org>, Horms <horms@verge.net.au>

> > > > > > I came across a report about panics on a IA64 system that happen when
> > > > > > kexec is being executed. The FSB parity error gets generated:
> > > > > >
> > > > > > BRLD / UC to x8208208208,   A43:41 = x0,  FSB Parity Error detected
> > on
> > > > > > Processor Request
> > > > > > BRLC / UC to xFFFF2000000,  A43:41 = x7,  FSB Parity Error detected
> > on
> > > > > > the Deferred Reply
> > > > > > BRLD / WB to xFFFFFFF0028,  A43:41 = x7,  FSB Parity Error detected
> > on
> > > > > > the Deferred Reply
> > > > > > BRLD / WB to xFFFFFFF0028,  A43:41 = x7,  FSB Parity Error detected
> > on
> > > > > > the Deferred Reply
> > > > > > BRLC / UC to xFFFF2000000,  A43:41 = x7,  FSB Parity Error detected
> > on
> > > > > > the Deferred Reply
> > > > > > BRLD / UC to x8208208208,   A43:41 = x0,  FSB Parity Error detected
> > on
> > > > > > Processor Request
> > > > > >
> > > > > >
> > > > > > And the pattern of the address on the bus is actually coming from the
> > > > > > piece of code in arch/ia64/kernel/gate.S, calculating ar.bpstore:
> > > > > >
> > > > > > ...
> > > > > >        sub r14=r14,r17         // r14 <- -rse_num_regs(bspstore1,
> > bsp1)
> > > > > >        movl r17=0x8208208208208209
> > > > > >        ;;
> > > > > >        add r18=r18,r14         // r18 (delta) <- rse_slot_num(bsp0)
> > -
> > > > > > rse_num_regs(bspstore1,bsp1)
> > > > > >        setf.sig f7=r17
> > > > > >        cmp.lt p7,p0=r14,r0     // p7 <- (r14 < 0)?
> > > > > >        ;;
> > > > > > ...
> > > > > >
> > > >
> > > >
> > > > Hi,
> > > >
> > > > Is the problem reproducible? Is there any special configuration or kexec
> > > > command line option to reproduce it?
> > > > On which platform and which version of kernel did you see the issue?
> > > >
> > > > It looks like there may be something wrong with the memory map setting
> > > > of the second kernel.
> > > > Can you send me copies of /proc/iomem of the first kernel and the second
> > > > kernel?
> > > >
> > >
> > > Thanks! I will try to get as much information as I can.
> > > It is 100 % reproducible, but intermittent - another words happens
> > > with each run, but not predictably (I will get more precise scenario).
> > > This is a large ES7000 server with up to 512 processors, I will find
> > > out if this happens with large configuration or any.
> > > Kernel is the SLES10 or RHEL4U5, they use both.
> > > I will provide the iomem, not sure how soon - either tomorrow or after
> > > the holiday...
> > >
> > Zou,
> >
> > I got this information. Actually the situation is even worse than I imagined.
> >
> > According to Ben who is working on this those are:
> >
> > --------------------
> > "To sum up what happens, I do this using the default kernel command line
> > (and also one with "debug console=uart,io,0x3f8,115200n8 console=tty0"
> > added to it):
> >
> > # kexec -l /boot/efi/efi/redhat/vmlinuz-2.6.18-8.el5
> > --append=`cat /proc/cmdline`
> > --initrd=/boot/efi/efi/redhat/initrd-2.6.18-8.el5.img
> >
> > # kexec -e
> >
> > The old kernel shuts down and boots the new one successfully, but, the
> > new kernel causes a fault during its boot. I can't positively identify
> > the exact spot it crashes because the serial output stops. Going by the
> > screen, it is either during or immediately after the ACPI system tries
> > to detect all of the CPUs. On a couple occasions I've seen it spit out
> > something along the lines of "EFI Time driver" before it blanks the
> > screen out, but it does it very quickly and the Raritan doesn't update
> > fast enough, even if I'm sitting at the cold floor display.
> >
> > The system is configured with a single CPU, as multiple CPUs cause a
> > different error, something along the lines of "huh? CPU #0x200 is
> > already present" - but this also happened on the system without the
> > capacitor fix. Turning on and off hyperthreading doesn't seem to matter
> > either.
> >
> > Here is entire log and a screen capture of the last things that
> > show up on the video console. The /proc/iomem contents are at line 460
> > in the log, and the kexec I used is at the very end. The second kernel
> > doesn't get far enough to enter any commands, so I'm
> > afraid I can't get you the /proc/iomem for that."
> > --------------
> >
> > Please advise where he can look to analyse this.
> > Thanks!
> > --Natalie
>
>
> From the log it is very hard to tell what is going wrong.
> Is the "acpi=debug" in command line intend to be there?
> Could you try latest base kernel?
> Also could you test if "kexec -p" works?
>
I will ask them to run kexec -p, I think he intended to do apic=debug,
will mention that either ...
I see that they load the same kernel as the first one. It is a good
idea - to test with latest vanilla (2.6.22 as of today) and see if the
problem still there.
Thanks, I will pass on information to you later on as it becomes available.
Regards,
--Natalie

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
