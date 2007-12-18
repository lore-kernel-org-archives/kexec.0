Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [2002:a646:1c45::1] (helo=ebiederm.dsl.xmission.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1J4Q6F-0004EW-0j
	for kexec@lists.infradead.org; Tue, 18 Dec 2007 00:14:19 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] kexec: force x86_64 arches to boot kdump kernels on boot
	cpu
References: <20071211192434.GD10999@hmsreliant.think-freely.org>
	<86802c440712111151t29acd38kf9fac8e41743f3e4@mail.gmail.com>
	<20071211205955.GF10999@hmsreliant.think-freely.org>
	<20071212142132.GC4889@bingen.suse.de>
	<20071212155515.GA29735@hmsendeavour.rdu.redhat.com>
	<20071212160722.GD4889@bingen.suse.de>
	<m1prxbu2ah.fsf@ebiederm.dsl.xmission.com>
	<20071212202215.GB29735@hmsendeavour.rdu.redhat.com>
	<m1lk7ztx9p.fsf@ebiederm.dsl.xmission.com>
	<20071213143922.GA4674@hmsreliant.think-freely.org>
	<20071213151629.GB31269@one.firstfloor.org>
Date: Mon, 17 Dec 2007 17:13:25 -0700
In-Reply-To: <20071213151629.GB31269@one.firstfloor.org> (Andi Kleen's message
	of "Thu, 13 Dec 2007 16:16:29 +0100")
Message-ID: <m1tzmgdfmi.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
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
To: Andi Kleen <andi@firstfloor.org>
Cc: Ben Woodard <woodard@redhat.com>, Neil Horman <nhorman@redhat.com>, Neil Horman <nhorman@tuxdriver.com>, kexec@lists.infradead.org, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, mingo@redhat.com, Yinghai Lu <yhlu.kernel@gmail.com>, hpa@zytor.com, tglx@linutronix.de

Andi Kleen <andi@firstfloor.org> writes:

> On Thu, Dec 13, 2007 at 09:39:22AM -0500, Neil Horman wrote:
>> 
>> Ok, new patch attached, taking into account Andi's request for a cleaner
> method
>
> Sorry for not noticing that earlier, but was there a specific reason this needs
> to be an early quirk at all? kexec can only happen after the standard quirks
> ran.
> I think it should be fine as a standard "late" quirk.

Just to document things.  The important thing is this quirk happens
before calibrate_delay().  Which is still before the normal pci
subsystem gets initialized.  So that seems to require an early_quirk
as the pci subsystem is not initialized by that point.

The only case we are likely to hit this is kdump because BIOS almost
always boot us on the cpu with apic id  == 0.  However in the case
of this bug if we happen to boot on a cpu with apic id >= 16 we
won't be able to boot the linux kernel either, because calibrate_delay
will fail.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
