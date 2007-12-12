Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [2002:a646:1c45::1] (helo=ebiederm.dsl.xmission.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1J2XW4-0005qc-01
	for kexec@lists.infradead.org; Wed, 12 Dec 2007 19:45:12 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] kexec: force x86_64 arches to boot kdump kernels on boot
	cpu
References: <m1ejdt25x0.fsf@ebiederm.dsl.xmission.com>
	<20071211143910.GA10999@hmsreliant.think-freely.org>
	<m1ve75z1v3.fsf@ebiederm.dsl.xmission.com>
	<20071211182254.GB10999@hmsreliant.think-freely.org>
	<m1ejdtysqd.fsf@ebiederm.dsl.xmission.com>
	<20071211192434.GD10999@hmsreliant.think-freely.org>
	<86802c440712111151t29acd38kf9fac8e41743f3e4@mail.gmail.com>
	<20071211205955.GF10999@hmsreliant.think-freely.org>
	<20071212142132.GC4889@bingen.suse.de>
	<20071212155515.GA29735@hmsendeavour.rdu.redhat.com>
	<20071212160722.GD4889@bingen.suse.de>
Date: Wed, 12 Dec 2007 12:43:34 -0700
In-Reply-To: <20071212160722.GD4889@bingen.suse.de> (Andi Kleen's message of
	"Wed, 12 Dec 2007 17:07:22 +0100")
Message-ID: <m1prxbu2ah.fsf@ebiederm.dsl.xmission.com>
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
To: Andi Kleen <ak@suse.de>
Cc: Ben Woodard <woodard@redhat.com>, Neil Horman <nhorman@redhat.com>, Neil Horman <nhorman@tuxdriver.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, Andi Kleen <andi@firstfloor.org>, Yinghai Lu <yhlu.kernel@gmail.com>, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com

Andi Kleen <ak@suse.de> writes:
>
> It could enable the extended APIC IDs but not use them? 

In which case complaining is still correct (the BIOS was out of sync),
enabling bit 17 is still correct and we are just in overkill mode.

> Anyways I haven't got docs on that NV bridge so I might be wrong.

This has everything to do with how AMD coherent hypertransport works and
little if anything to do with how the NV bridge operated.

Basically the NV bridge seems to be sending a standard hypertransport
x86 legacy interrupt packet (that doesn't have any target information)
and when that packet  hits the coherent hypertransport domain it isn't
being converted into whatever would send it to all cpus. 

.....

The real practical problem is if somehow the BIOS goofs up this way
and it then decides to ask us to boot on one of these cpus with
an extended apic id.  We will hang in calibrate_delay.  So far
this only seems to happen in the kdump case but in theory the BIOS
could be completely crazy.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
