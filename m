Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Ix45b-0003rD-13
	for kexec@lists.infradead.org; Tue, 27 Nov 2007 17:19:22 +0000
From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] kexec: force x86_64 arches to boot kdump kernels on boot
	cpu
Date: Tue, 27 Nov 2007 16:24:11 +0100
References: <20071127014740.GA28622@hmsreliant.think-freely.org>
	<200711271543.11809.ak@suse.de>
	<20071127144856.GC31376@hmsreliant.think-freely.org>
In-Reply-To: <20071127144856.GC31376@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200711271624.11914.ak@suse.de>
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
To: Neil Horman <nhorman@tuxdriver.com>
Cc: Neil Horman <nhorman@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, vgoyal@in.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>


> So, it sounds to me then, like unless I'm willing to really re-write the APIC
> setup code (which I don't feel qualified to do quite yet), that the immediate
> solution would be to not rely on interrupts in legacy mode, which was according
> to my understanding, what the use of the irqpoll command line option was
> supposed to enable. 

irqpoll won't fix the timer interrupt.

-Andi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
