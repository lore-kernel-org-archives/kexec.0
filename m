Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SPfht-0003zJ-DX
 for kexec@lists.infradead.org; Wed, 02 May 2012 19:59:26 +0000
Date: Wed, 2 May 2012 15:59:19 -0400
From: Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH] x86, kdump: No need to disable ioapic in crash path
Message-ID: <20120502195919.GU32472@redhat.com>
References: <1330546129-4812-1-git-send-email-dzickus@redhat.com>
 <20120315202652.GA13930@redhat.com>
 <5C4C569E8A4B9B42A84A977CF070A35B2E31C6F859@USINDEVS01.corp.hds.com>
 <20120430205354.GA32472@redhat.com>
 <5C4C569E8A4B9B42A84A977CF070A35B2E4D461583@USINDEVS01.corp.hds.com>
 <87vckemkyt.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87vckemkyt.fsf@xmission.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Seiji Aguchi <seiji.aguchi@hds.com>, kexec-list <kexec@lists.infradead.org>, "x86@kernel.org" <x86@kernel.org>, Vivek Goyal <vgoyal@redhat.com>, LKML <linux-kernel@vger.kernel.org>

On Wed, May 02, 2012 at 12:39:06PM -0700, Eric W. Biederman wrote:
> Seiji Aguchi <seiji.aguchi@hds.com> writes:
> 
> >> Perhaps calling setup_IO_APIC before setup_local_APIC would be a better fix?
> >
> > I checked Intel develper's manual and there is no restriction about the order of enabling IO_APIC/local_APIC.
> > So, it may work.
> >
> > But, I don't understand why we have to change the stable boot-up code.
> 
> Because the boot-up code is buggy.  We need to get a better handle on
> how it is buggy but apparently an interrupt coming in at the wrong
> moment while booting with interrupts on the interrupt flag on the cpus
> disalbed puts us in a state where we fail to boot.
> 
> We should be able to boot with apics enabled, and we almost can
> emperically there are a few bugs.
> 
> The kdump path is particularly good at finding bugs.
> 
> > If kdump disables both local_apic and IO_APIC in proper way in 1st kernel,  2nd kernel works without any change.
> 
> We can not guarnatee disabling the local apics in the first kernel.
> 
> Ultimately the less we do in the first kernel the more reliable kdump is
> going to be.  Disabling the apics has been a long standing bug work
> around.
> 
> At worst we may have been a smidge premature in using assuming the
> kernel can boot with the apics enabled but it I would hope we can
> track down and fix the boot up code.
> 
> Probably what we want to do is not to disable the I/O apics but
> to program the I/O apics before we enable the local apic so that
> we have control of the in-comming interrupts.  But I haven't
> looked at this in nearly enough detail to even guess what needs
> to happen.

Hi Eric,

Thanks for the info.  I have don't have a problem with what you say above,
I think that is a noble effort worth pursuing.  From a high level
perspective, I am trying to understand how that is supposed to be
acheived.  Getting the code to match the theory is probably easier to do
than throw random patches/hacks at various kdump problems as they arise.

So can I understand what your thoughts are? Are you expecting the
following in the first kernel:

panic
disable other cpus
setup 2nd kernel jumptables
disable panic cpu interrupts
idt/gdt settings??
jump to purgatory

(this leaves apics and virt stuff untouched?)
(i am ignoring nmi/mce/faults and other exceptions for now)

purgatory stuff...

2nd kernel:

normal early boot stuff
setup memory
setup scheduler
...
program ioapic/lapic??
   #currently this is down _after_ boot cpu interrupts are enabled
   #which seem problematic if you have leftover screaming interrupts
   #probably a reason for this like timers or something
enable boot cpu interrupts
setup boot cpu
setup other cpus
....

Cheers,
Don

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
