Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C321CC4167B
	for <kexec@archiver.kernel.org>; Fri,  1 Dec 2023 15:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mLcJxu4mBJIvZ+goQ7nXD0MzCE7QrL2/aHRR+ARZonc=; b=bmcAOm6n7MX+Ic
	g6NOurgcy8oFk+6us8SHyXHanr0+85xS9zNCsxs+3CFxtkgAGBpJ+6kUoPV/8y7xD6jyADLkj6sAB
	GoKQX2xbi/I7uiZjBM21lWBkQQX3E9d7cM4DwHbATHDj+18iadrLNdEVmfPh/fxyJ47WUz+SDtEPC
	Rr6KjVZn9bG24Q0NyeOA+OldhEev+aoxOrR2DHLt5cZY7mJcGDdlyuEGaj9Av7ZKGPa0DqUFwgZNl
	CCJ1IqfHrd2jCZPSMZFLF0tQILeajbmTWFQEOPIa105ukU9RoRvSubNPKuG14rg9dIg01S1U+AfgX
	rcTP7LWQmVB2BBXMjTSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r95u1-00E60O-1n;
	Fri, 01 Dec 2023 15:58:05 +0000
Received: from mgamail.intel.com ([192.55.52.115])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r95tx-00E5zD-2t
	for kexec@lists.infradead.org;
	Fri, 01 Dec 2023 15:58:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701446281; x=1732982281;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jUP4W+ON/TvFXhwyY13CHzC3+Zpylwt+iETAAn2F0U8=;
  b=GJAduVTFp/Nl5vhkc+J9D7abBPPv75PZt14F3H6XdjPt3K4EgV3gw3OS
   REOAa8u2MZCMKntaYUGk7N5+RHdTGXEZmV3Wk3gvFWzE/qp2QwopiZXp4
   ELLIZBbbL9saKnAEyux9YytiuyHgfhcUmNCXaWSnlBYl+s2n7zX+Sh72d
   sgm573pK6ut2EvGU3ysxIz2oLtrZu4LeADzdGVHG2Q31+l4VL8ERvYILr
   01y6bbHq4WGnwLmfZ+fQcxqEYNcXxmutHwJRCPl91GSU7uiTyzpi3bvlc
   gDK2np02BbUz5aiK1sDLk8K7It+vgtR7N2sg7zyU0ZUSnLDUqQ56CKeVN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="393250880"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="393250880"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 07:57:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="773472906"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="773472906"
Received: from hadasr-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.33.176])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 07:57:41 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 233E010A437; Fri,  1 Dec 2023 18:57:39 +0300 (+03)
Date: Fri, 1 Dec 2023 18:57:39 +0300
From: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"Reshetova, Elena" <elena.reshetova@intel.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"ashish.kalra@amd.com" <ashish.kalra@amd.com>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"seanjc@google.com" <seanjc@google.com>,
	"bhe@redhat.com" <bhe@redhat.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCHv3 14/14] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Message-ID: <20231201155739.rxo6l5om6mdw54rs@box.shutemov.name>
References: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
 <20231115120044.8034-15-kirill.shutemov@linux.intel.com>
 <7012ba92206efaa6f0a0a2e1a28355d67d55265a.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7012ba92206efaa6f0a0a2e1a28355d67d55265a.camel@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231201_075801_943655_E674553A 
X-CRM114-Status: GOOD (  32.18  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Thu, Nov 23, 2023 at 09:38:13AM +0000, Huang, Kai wrote:
> =

> > diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> > index 171d86fe71ef..602b5d3982ff 100644
> > --- a/arch/x86/kernel/acpi/boot.c
> > +++ b/arch/x86/kernel/acpi/boot.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/efi-bgrt.h>
> >  #include <linux/serial_core.h>
> >  #include <linux/pgtable.h>
> > +#include <linux/sched/hotplug.h>
> >  =

> >  #include <asm/e820/api.h>
> >  #include <asm/irqdomain.h>
> > @@ -33,6 +34,7 @@
> >  #include <asm/smp.h>
> >  #include <asm/i8259.h>
> >  #include <asm/setup.h>
> > +#include <asm/init.h>
> =

> The above two are leftovers I believe?
> =

> [...]
> =


Right.


> > +
> > +static atomic_t waiting_for_crash_ipi;
> > +
> > +void asm_acpi_mp_play_dead(u64 reset_vector, u64 pgd_pa);
> > +
> > +static void acpi_mp_play_dead(void)
> > +{
> > +	play_dead_common();
> > +	asm_acpi_mp_play_dead(acpi_mp_reset_vector_paddr,
> > +			      acpi_mp_pgd);
> > +}
> > +
> > +static void acpi_mp_cpu_die(unsigned int cpu)
> > +{
> > +	u32 apicid =3D per_cpu(x86_cpu_to_apicid, cpu);
> > +	unsigned long timeout;
> > +
> > +	/*
> > +	 * Use TEST mailbox command to prove that BIOS got control over
> > +	 * the CPU before declaring it dead.
> > +	 *
> > +	 * BIOS has to clear 'command' field of the mailbox.
> > +	 */
> > +	acpi_mp_wake_mailbox->apic_id =3D apicid;
> > +	smp_store_release(&acpi_mp_wake_mailbox->command,
> > +			  ACPI_MP_WAKE_COMMAND_TEST);
> > +
> > +	/* Don't wait longer than a second. */
> > +	timeout =3D USEC_PER_SEC;
> > +	while (READ_ONCE(acpi_mp_wake_mailbox->command) && timeout--)
> > +		udelay(1);
> > +}
> > +
> > +static void acpi_mp_stop_other_cpus(int wait)
> > +{
> > +	smp_shutdown_nonboot_cpus(smp_processor_id());
> > +}
> > +
> > +static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
> > +{
> > +	local_irq_disable();
> > +
> > +	crash_save_cpu(regs, raw_smp_processor_id());
> > +
> > +	cpu_emergency_stop_pt();
> > +
> > +	disable_local_APIC();
> > +
> > +	/*
> > +	 * Prepare the CPU for reboot _after_ invoking the callback so that t=
he
> > +	 * callback can safely use virtualization instructions, e.g. VMCLEAR.
> > +	 */
> > +	cpu_emergency_disable_virtualization();
> > +
> > +	atomic_dec(&waiting_for_crash_ipi);
> > +
> > +	asm_acpi_mp_play_dead(acpi_mp_reset_vector_paddr,
> > +			      acpi_mp_pgd);
> > +
> > +	return NMI_HANDLED;
> > +}
> > +
> > +static void acpi_mp_crash_stop_other_cpus(void)
> > +{
> > +	unsigned long timeout;
> > +
> > +	/* The kernel is broken so disable interrupts */
> > +	local_irq_disable();
> > +
> > +
> > +	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
> > +
> > +	/* Would it be better to replace the trap vector here? */
> > +	if (register_nmi_handler(NMI_LOCAL, crash_nmi_callback,
> > +				 NMI_FLAG_FIRST, "crash"))
> > +		return;		/* Return what? */
> > +
> > +	apic_send_IPI_allbutself(NMI_VECTOR);
> > +
> > +	/* Don't wait longer than a second. */
> > +	timeout =3D USEC_PER_SEC;
> > +	while (atomic_read(&waiting_for_crash_ipi) && timeout--)
> > +		udelay(1);
> > +}
> > +
> > =

> =

> [...]
> =

> > +	smp_ops.stop_other_cpus =3D acpi_mp_stop_other_cpus;
> > +	smp_ops.crash_stop_other_cpus =3D acpi_mp_crash_stop_other_cpus;
> > +
> > =

> =

> The above acpi_mp_crash_stop_other_cpus() and crash_nmi_callback() etc ar=
e kinda
> duplicated code with the normal crash kexec() in reboot.c.
> =

> I am not expert here but spent some time looking into the code, and it ap=
pears
> the main reason preventing us from reusing that code should be TDX guest =
doesn't
> play nicely with mwait/halt staff when putting the cpu to offline. =A0
> =

> I am thinking if we skip/replace them with the asm_acpi_mp_play_dead(), we
> should be able to just reuse the existing smp_ops.stop_other_cpus() and
> smp_ops.crash_stop_other_cpus()?

Okay, fair enough. See fixup below.

> > +
> >  int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
> >  			      const unsigned long end)
> >  {
> >  	struct acpi_madt_multiproc_wakeup *mp_wake;
> >  =

> >  	mp_wake =3D (struct acpi_madt_multiproc_wakeup *)header;
> > -	if (BAD_MADT_ENTRY(mp_wake, end))
> > +	if (!mp_wake)
> > +		return -EINVAL;
> =

> I think you can keep the BAD_MADT_ENTRY() check as a standard check, and =
...

No. BAD_MADT_ENTRY() will fail if the struct version is V0 because the
size will be smaller than sizeof(struct acpi_madt_multiproc_wakeup).


diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 4fab2ed454f3..3c8efba86d5c 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -38,6 +38,7 @@ struct smp_ops {
 	int (*cpu_disable)(void);
 	void (*cpu_die)(unsigned int cpu);
 	void (*play_dead)(void);
+	void (*crash_play_dead)(void);
 =

 	void (*send_call_func_ipi)(const struct cpumask *mask);
 	void (*send_call_func_single_ipi)(int cpu);
diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt=
_wakeup.c
index 782fe8fd533c..a801f773f9f1 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -25,6 +25,12 @@ static u64 acpi_mp_reset_vector_paddr __ro_after_init;
 =

 void asm_acpi_mp_play_dead(u64 reset_vector, u64 pgd_pa);
 =

+static void crash_acpi_mp_play_dead(void)
+{
+	asm_acpi_mp_play_dead(acpi_mp_reset_vector_paddr,
+			      acpi_mp_pgd);
+}
+
 static void acpi_mp_play_dead(void)
 {
 	play_dead_common();
@@ -58,57 +64,6 @@ static void acpi_mp_stop_other_cpus(int wait)
 	smp_shutdown_nonboot_cpus(smp_processor_id());
 }
 =

-#ifdef CONFIG_KEXEC_CORE
-static atomic_t waiting_for_crash_ipi;
-
-static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
-{
-	local_irq_disable();
-
-	crash_save_cpu(regs, raw_smp_processor_id());
-
-	cpu_emergency_stop_pt();
-
-	disable_local_APIC();
-
-	/*
-	 * Prepare the CPU for reboot _after_ invoking the callback so that the
-	 * callback can safely use virtualization instructions, e.g. VMCLEAR.
-	 */
-	cpu_emergency_disable_virtualization();
-
-	atomic_dec(&waiting_for_crash_ipi);
-
-	asm_acpi_mp_play_dead(acpi_mp_reset_vector_paddr,
-			      acpi_mp_pgd);
-
-	return NMI_HANDLED;
-}
-
-static void acpi_mp_crash_stop_other_cpus(void)
-{
-	unsigned long timeout;
-
-	/* The kernel is broken so disable interrupts */
-	local_irq_disable();
-
-
-	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
-
-	/* Would it be better to replace the trap vector here? */
-	if (register_nmi_handler(NMI_LOCAL, crash_nmi_callback,
-				 NMI_FLAG_FIRST, "crash"))
-		return;		/* Return what? */
-
-	apic_send_IPI_allbutself(NMI_VECTOR);
-
-	/* Don't wait longer than a second. */
-	timeout =3D USEC_PER_SEC;
-	while (atomic_read(&waiting_for_crash_ipi) && timeout--)
-		udelay(1);
-}
-#endif
-
 /* The argument is required to match type of x86_mapping_info::alloc_pgt_p=
age */
 static void __init *alloc_pgt_page(void *dummy)
 {
@@ -277,11 +232,9 @@ static int __init acpi_mp_setup_reset(u64 reset_vector)
 	}
 =

 	smp_ops.play_dead =3D acpi_mp_play_dead;
+	smp_ops.crash_play_dead =3D crash_acpi_mp_play_dead;
 	smp_ops.cpu_die =3D acpi_mp_cpu_die;
 	smp_ops.stop_other_cpus =3D acpi_mp_stop_other_cpus;
-#ifdef CONFIG_KEXEC_CORE
-	smp_ops.crash_stop_other_cpus =3D acpi_mp_crash_stop_other_cpus;
-#endif
 =

 	acpi_mp_reset_vector_paddr =3D reset_vector;
 	acpi_mp_pgd =3D __pa(pgd);
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index c81afffaa954..99e6ab552da0 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -878,10 +878,14 @@ static int crash_nmi_callback(unsigned int val, struc=
t pt_regs *regs)
 	cpu_emergency_disable_virtualization();
 =

 	atomic_dec(&waiting_for_crash_ipi);
-	/* Assume hlt works */
-	halt();
-	for (;;)
-		cpu_relax();
+
+	if (smp_ops.crash_play_dead) {
+	    smp_ops.crash_play_dead();
+	} else {
+		halt();
+		for (;;)
+			cpu_relax();
+	}
 =

 	return NMI_HANDLED;
 }
-- =

  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
