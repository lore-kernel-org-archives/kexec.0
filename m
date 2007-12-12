Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [2002:a646:1c45::1] (helo=ebiederm.dsl.xmission.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1J2NDZ-0007nf-HZ
	for kexec@lists.infradead.org; Wed, 12 Dec 2007 08:45:25 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] k8: Enable legacy irqs with  extended cpu ids
References: <20071207175832.GA18485@hmsreliant.think-freely.org>
	<m1k5nm2g3w.fsf@ebiederm.dsl.xmission.com>
	<20071211034349.GA3635@localhost.localdomain>
	<m1ejdt25x0.fsf@ebiederm.dsl.xmission.com>
	<20071211143910.GA10999@hmsreliant.think-freely.org>
	<m1ve75z1v3.fsf@ebiederm.dsl.xmission.com>
	<20071211182254.GB10999@hmsreliant.think-freely.org>
	<m1ejdtysqd.fsf@ebiederm.dsl.xmission.com>
	<20071211192434.GD10999@hmsreliant.think-freely.org>
	<86802c440712111151t29acd38kf9fac8e41743f3e4@mail.gmail.com>
	<20071211205955.GF10999@hmsreliant.think-freely.org>
Date: Wed, 12 Dec 2007 01:43:31 -0700
In-Reply-To: <20071211205955.GF10999@hmsreliant.think-freely.org> (Neil
	Horman's message of "Tue, 11 Dec 2007 15:59:55 -0500")
Message-ID: <m17ijkz4jw.fsf_-_@ebiederm.dsl.xmission.com>
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
To: Neil Horman <nhorman@tuxdriver.com>
Cc: Ben Woodard <woodard@redhat.com>, Neil Horman <nhorman@redhat.com>, kexec@lists.infradead.org, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, Andi Kleen <andi@firstfloor.org>, Yinghai Lu <yhlu.kernel@gmail.com>, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com

Neil Horman <nhorman@tuxdriver.com> writes:

> Recently a kdump bug was discovered in which a system would hang inside
> calibrate_delay during the booting of the kdump kernel.  This was caused by the
> fact that the jiffies counter was not being incremented during timer
> calibration.  The root cause of this problem was found to be a bios
> misconfiguration of the hypertransport bus.  On system affected by this hang,
> the bios had assigned APIC ids which used extended apic bits (more than the
> nominal 4 bit ids's), but failed to configure bit 17 of the hypertransport
> transaction config register, which indicated that the mask for the destination
> field of interrupt packets accross the ht bus (see section 3.3.9 of
> http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/26094.PDF).
> If a crash occurs on a cpu with an APIC id that extends beyond 4 bits, it will
> not recieve interrupts during the kdump kernel boot, and this hang will be the
> result.  The fix is to add this patch, whcih add an early pci quirk check, to
> forcibly enable this bit in the httcfg register.  This enables all cpus on a
> system to receive interrupts, and allows kdump kernel bootup to procede
> normally.
>
> Regards
> Neil
>
>
> Signed-off-by: Neil Horman <nhorman@tuxdriver.com>

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
