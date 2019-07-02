Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hiBRN-00036E-5I
 for kexec@lists.infradead.org; Tue, 02 Jul 2019 05:34:54 +0000
Date: Tue, 2 Jul 2019 13:34:43 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: mgag200 fails kdump kernel booting
Message-ID: <20190702053443.GE3178@localhost.localdomain>
References: <20190626081522.GX24419@MiWiFi-R3L-srv>
 <20190626082907.GY24419@MiWiFi-R3L-srv>
 <CAMwc25oeskFG4bbrb3rwotqi1a5z4wYsGW=Qs_XJmhX_vAdNfQ@mail.gmail.com>
 <20190702014158.GC3178@localhost.localdomain>
 <20190702031715.GB3327@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190702031715.GB3327@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>, David Airlie <airlied@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel <linux-kernel@vger.kernel.org>

On 07/02/19 at 11:17am, Dave Young wrote:
> On 07/02/19 at 09:41am, Baoquan He wrote:
> > On 07/02/19 at 06:51am, David Airlie wrote:
> > > On Wed, Jun 26, 2019 at 6:29 PM Baoquan He <bhe@redhat.com> wrote:
> > > >
> > > > On 06/26/19 at 04:15pm, Baoquan He wrote:
> > > > > Hi Dave,
> > > > >
> > > > > We met an kdump kernel boot failure on a lenovo system. Kdump kernel
> > > > > failed to boot, but just reset to firmware to reboot system. And nothing
> > > > > is printed out.
> > > > >
> > > > > The machine is a big server, with 6T memory and many cpu, its graphic
> > > > > driver module is mgag200.
> > > > >
> > > > > When added 'earlyprintk=ttyS0' into kernel command line, it printed
> > > > > out only one line to console during kdump kernel booting:
> > > > >      KASLR disabled: 'nokaslr' on cmdline.
> > > > >
> > > > > Then reset to firmware to reboot system.
> > > > >
> > > > > By further code debugging, the failure happened in
> > > > > arch/x86/boot/compressed/misc.c, during kernel decompressing stage. It's
> > > > > triggered by the vga printing. As you can see, in __putstr() of
> > > > > arch/x86/boot/compressed/misc.c, the code checks if earlyprintk= is
> > > > > specified, and print out to the target. And no matter if earlyprintk= is
> > > > > added or not, it will print to VGA. And printing to VGA caused it to
> > > > > reset to firmware. That's why we see nothing when didn't specify
> > > > > earlyprintk=, but see only one line of printing about the 'KASLR
> > > > > disabled'.
> > > >
> > > > Here I mean:
> > > > That's why we see nothing when didn't specify earlyprintk=, but see only
> > > > one line of printing about the 'KASLR disabled' message when
> > > > earlyprintk=ttyS0 added.
> > > 
> > > Just to clarify, the original kernel is booted with mgag200 turned
> > > off, then kexec works, but if the original kernel loads mgag200, the
> > > kexec kernels resets hard when the VGA is used to write stuff out.
> > 
> > Thanks for looking into this, Dave.
> > 
> > Yeah, in fact the issue was found in kdump kernel. I haven't checked the
> > kexec jumping. Kexec jumping will call device_shutdown() to attempt to
> > shutdown all devices before jumping to the 2nd kernel. But kdump jumping
> > won't.
> > 
> > > 
> > > This *might* be fixable in the controlled kexec case, but having an
> > > mgag200 shutdown path that tries to put the gpu back into a state
> > > where VGA doesn't die, but for the uncontrolled kexec it'll still be a
> > > problem, since once the gpu is up and running and VGA is disabled, it
> > > doesn't expect to see anymore VGA transactions.
> > 
> > Yes, I see. It should have been shutdown by device_shutdown() in kexec
> > case. The uncontrolled case, I guess you mean the kdump case. In
> > kdump case, we don't call device_shutdown() before jumping because the
> > 1st kernel has been in crashed state, we just want to switch to kdump
> > kernel asap. So wondering how other GPU/VGA device/driver bebahve,
> > currently haven't got report about them. Probably mgag200 is very new,
> > or we may not meet them. This issue was met on a new bought server.
> 
> I assumed the vga writing only take effect when earlyprintk is provided.
> eg. earlyprintk=ttyS0, then x86 early decompress code will write to both
> vga and ttyS0.  So if one does not use earlyprintk, he/she still get
> nothing.  But if one provides earlyprintk, then he/she should provide a
> correct param he want, instead of blindly assume kernel will write to
> vga even if he use ttyS0.

No, the vga printing takes effect always, otherwise those warn() and
error() won't work. It takes effect no matter if CONFIG_EARLY_PRINTK
is enabled, and if any earlyprintk= specified.

That's why I prefer to pursuit fix in driver side. It's making the
error/warn print out even though nothing specific needed, that's make
sense to me.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
