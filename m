Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Ix0lH-0008DM-Dw
	for kexec@lists.infradead.org; Tue, 27 Nov 2007 13:46:10 +0000
From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] kexec: force x86_64 arches to boot kdump kernels on boot
	cpu
Date: Tue, 27 Nov 2007 14:45:56 +0100
References: <20071127014740.GA28622@hmsreliant.think-freely.org>
	<20071127131355.GA14887@hmsendeavour.rdu.redhat.com>
	<m1y7cjkec2.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1y7cjkec2.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200711271445.56792.ak@suse.de>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Neil Horman <nhorman@redhat.com>, Neil Horman <nhorman@tuxdriver.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, vgoyal@in.ibm.com

his is any less reliable that what we have currently.
> 
> It doesn't make things more reliable, and it adds code to a code path
> that already has to much code to be solid reliable (thus your
> problem). 
> 
> Putting the system back in PIC legacy mode on the kexec on panic path
> was supposed to be a short term hack until we could remove the need
> by always deliver interrupts in apic mode.
> 
> If you can't root cause your problem and figure out how the apics
> are misconfigured for legacy mode

Probably legacy mode always routes to CPU #0. Makes sense and is
not really a misconfiguration of legacy mode.

But if CPU #0 has interrupts disabled no interrupts get delivered.

So choices are:
- Move to CPU #0
- Do not use legacy mode during shutdown.
- Or do not rely on interrupts after enabling legacy mode
- Or do not disable interrupts on the other CPUs when they're
halted.

First and last option are probably unreliable for the kdump case.
Second or third sound best. 

I suspect the real fix would be to enable IOAPIC mode really
early and never use the timers in legacy mode. Then the kdump
kernel wouldn't care about the legacy mode pointing to the wrong CPU.

IIrc Eric even had  a patch for that a long time ago, but it broke some 
things so it wasn't included. But perhaps it should be revisited.

-Andi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
