Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from one.firstfloor.org ([213.235.205.2])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Ix8qf-00066B-Sp
	for kexec@lists.infradead.org; Tue, 27 Nov 2007 22:24:16 +0000
Date: Tue, 27 Nov 2007 23:24:08 +0100
From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] kexec: force x86_64 arches to boot kdump kernels on boot
	cpu
Message-ID: <20071127222408.GH24223@one.firstfloor.org>
References: <20071127014740.GA28622@hmsreliant.think-freely.org>
	<20071127131355.GA14887@hmsendeavour.rdu.redhat.com>
	<m1y7cjkec2.fsf@ebiederm.dsl.xmission.com>
	<200711271445.56792.ak@suse.de>
	<m1lk8jka8j.fsf@ebiederm.dsl.xmission.com>
	<474C64CB.7080004@redhat.com>
	<20071127194220.GG14887@hmsendeavour.rdu.redhat.com>
	<20071127200011.GA3703@redhat.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071127200011.GA3703@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Ben Woodard <woodard@redhat.com>, Neil Horman <nhorman@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>, hbabu@us.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>

> Are we putting the system back in PIC mode or virtual wire mode? I have
> not seen systems which support PIC mode. All latest systems seems
> to be having virtual wire mode. I think in case of PIC mode, interrupts

Yes it's probably virtual wire. For real PIC mode we would need really
old systems without APIC.

> can be delivered to cpu0 only. In virt wire mode, one can program IOAPIC
> to deliver interrupt to any of the cpus and that's what we have been

The code doesn't try to program anything specific, it just restores the state
that was left over originally by the BIOS.

-Andi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
