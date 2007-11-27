Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from one.firstfloor.org ([213.235.205.2])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1IxAHk-0004Ji-74
	for kexec@lists.infradead.org; Tue, 27 Nov 2007 23:56:18 +0000
Date: Wed, 28 Nov 2007 00:56:10 +0100
From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] kexec: force x86_64 arches to boot kdump kernels on boot
	cpu
Message-ID: <20071127235610.GD31491@one.firstfloor.org>
References: <20071127014740.GA28622@hmsreliant.think-freely.org>
	<20071127131355.GA14887@hmsendeavour.rdu.redhat.com>
	<m1y7cjkec2.fsf@ebiederm.dsl.xmission.com>
	<200711271445.56792.ak@suse.de>
	<m1lk8jka8j.fsf@ebiederm.dsl.xmission.com>
	<474C64CB.7080004@redhat.com>
	<20071127194220.GG14887@hmsendeavour.rdu.redhat.com>
	<20071127200011.GA3703@redhat.com>
	<20071127222408.GH24223@one.firstfloor.org>
	<474CA733.9050908@redhat.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <474CA733.9050908@redhat.com>
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
To: Ben Woodard <woodard@redhat.com>
Cc: Neil Horman <nhorman@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>, hbabu@us.ibm.com, Andi Kleen <andi@firstfloor.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

> Would anyone have any problems with code that simply verified that the 
> state which we are restoring allowed interrupts to get to the processor 
> that we are currently crashing on and if not, poked in a reasonable value.

Sounds reasonable by itself.

> 
> Yes this would add some complexity to the code paths where we were 
> crashing but it could prevent the problem that we are seeing. It seems 
> like a small fairly safe change rather than a big disruptive change like 
> moving the initialization of the IOAPIC earlier in the boot process.

But longer (or not so long) term moving the IOAPIC earlier is the better option, 
simply because the short use of PIC mode traditionally was a source of problems
on a lot of boxes.

And it does not really make sense to keep this source of trouble just for a short 
time during boot when we could as well go directly into IO-APIC mode. This would 
probably also match what other OS are doing better and that is always a good idea
for stable operation.

-Andi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
