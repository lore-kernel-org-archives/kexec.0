Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ra.tuxdriver.com ([70.61.120.52])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Ix1lc-0003xe-CF
	for kexec@lists.infradead.org; Tue, 27 Nov 2007 14:50:35 +0000
Date: Tue, 27 Nov 2007 09:48:56 -0500
From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH] kexec: force x86_64 arches to boot kdump kernels on
	boot cpu
Message-ID: <20071127144856.GC31376@hmsreliant.think-freely.org>
References: <20071127014740.GA28622@hmsreliant.think-freely.org>
	<200711271445.56792.ak@suse.de>
	<20071127142826.GB31376@hmsreliant.think-freely.org>
	<200711271543.11809.ak@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200711271543.11809.ak@suse.de>
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
To: Andi Kleen <ak@suse.de>
Cc: Neil Horman <nhorman@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, vgoyal@in.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>

On Tue, Nov 27, 2007 at 03:43:11PM +0100, Andi Kleen wrote:
> 
> > 
> > As for solution 2, that brings me to my previous question.  Is that really as
> > simple as just not moving the apic to legacy mode?  It would seem some
> > additional programming would be in order to route the interrupt in question to
> > the proper cpu.
> 
> The Linux kernel right now relies on being in legacy mode at bootup.
> So obviously kexec has to switch back to that.
> 
> Not relying on legacy mode would require moving APIC setup much earlier which
> is difficult because that's quite fragile. Longer term it might be a good
> idea though anyways -- at least the timer code was always fragile
> and eliminating one failure case and only ever running it in true
> APIC mode would be probably a good thing.
> 

So, it sounds to me then, like unless I'm willing to really re-write the APIC
setup code (which I don't feel qualified to do quite yet), that the immediate
solution would be to not rely on interrupts in legacy mode, which was according
to my understanding, what the use of the irqpoll command line option was
supposed to enable.  Any thoughts as to why that might not be working in this
case, or suggested tests to determine a cause there?

Thanks & Regards
Neil

> -Andi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
