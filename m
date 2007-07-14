Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ogre.sisk.pl ([217.79.144.158])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1I9myh-0007WF-D9
	for kexec@lists.infradead.org; Sat, 14 Jul 2007 15:08:29 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec base hibernation
Date: Sat, 14 Jul 2007 21:16:09 +0200
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<200707141159.47289.rjw@sisk.pl>
	<1184410554.1898.84.camel@caritas-dev.intel.com>
In-Reply-To: <1184410554.1898.84.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200707142116.10237.rjw@sisk.pl>
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
To: "Huang, Ying" <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

On Saturday, 14 July 2007 12:55, Huang, Ying wrote:
> On Sat, 2007-07-14 at 11:59 +0200, Rafael J. Wysocki wrote:
> > > Hibernating process:
> > > 
> > >   1. Normal kernel running
> > >   2. Hibernating is triggered, sys_kexec_load is used to load
> > >      hibernating kernel and initramfs into memory. Then
> > >      sys_reboot(LINUX_REBOOT_CMD_KSPAWN) is invoked.
> > >   3. In sys_reboot, kexec_jump is called to save device/CPU state,
> > >      then relocate_kernel is called. kexec_jump and relocate_kernel
> > >      reside in individual page in 16M~512M.
> > 
> > OK
> > What's going to happen to devices at this point?
> > 
> 
> The devices should be quiesced and the state of devices should be saved
> in kexec_jump, before relocate_kernel is called. This needs the
> implementation of device hibernating as you mentioned before.

Hmm, at which point devices are normally shut down when kexec is used?

> > >   4. In relocate_kernel, 0~16M is backupped firstly, then the
> > >      hibernating kernel and initramfs is copied to 0~16M, after that,
> > >      the hibernating kernel is booted.
> > >   5. In hibernating kernel, the memory of normal kernel (it is in
> > >      16M~512M) is saved into a hibernation image through /dev/mem
> > >      and ELF header.
> > 
> > I don't think it can be _that_ simple:
> > (a) what about processes' memory
> > (b) what about areas that shouldn't be saved?
> 
> The mem_map (struct page[]) of every zone of hibernated kernel is
> checked.  Necessary pages are saved, like memory snapshot of software
> suspend, but in user space.

Well, it's not enough to check that, sorry.  That's why we have
register_nosave_region().

> > > Resume process:
> > > 
> > >   1. Resuming kernel is booted as a normal kernel, but the memory is
> > >      restricted to 0~16M.
> > >   2. Checking whether there is a effective hibernation image. If
> > >      there isn't, the memory of 16M~512M is hot added, and the normal
> > >      boot up process continues; If there is, a resuming process is
> > >      triggered.
> > >   3. sys_kexec_load is used to restore the memory state of hibernated
> > >      kernel. The sys_kexec_load works in crashdump way, that is, the
> > >      hibernation image is copied to destination location in 16M~512M
> > >      in sys_kexec_load instead of relocate_kernel. There is no half
> > >      of memory size restriction.
> > >   4. sys_reboot is called to trigger jumping back, which will jump back
> > >      to kexec_jump of hibernated kernel.
> > >   5. In kexec_jump of hibernated kernel, the memory of 0~16M is copied
> > >      back from the backup area in 16M~512M. The memory state of
> > >      hibernated kernel is restored totally. The CPU and device state
> > >      can be restored after that.
> > 
> > Well, I don't know why this needs to be that complicated.  We already have
> > code in the mainline that's able to load a large hibernation image into memory
> > and jump to the kernel being restored.  And it has _no_ 50% of RAM limitation,
> > this is the _saving_ part of the current code that this limitation comes from.
> 
> There is much similarity between sys_kexec_load and software resuming.
> If resuming can be done by sys_kexec_load, then we need not two similar
> functionality in kernel.

Oh, I see, but your proposed solution seems to be more complicated than that.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
