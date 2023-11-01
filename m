Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8591AC4332F
	for <kexec@archiver.kernel.org>; Wed,  1 Nov 2023 13:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lE3PgjlSdbMcuWNwMe5A6KBQ11hOH0v8j5sE3/SuUYE=; b=21KMgX1erC/8qx
	bnQ/8+p8BET1GV+RqC3zDHk1suaUOJMAJnD9Q+CVi0QNDcWJP5ZxO//Zl0cR7j5zYx5pWsOuQv0sz
	f+HO3xcHlTBapan7nrXgKU1iKl0QbT/dj6dYTIF9NPZqKhQkFhDF3Iu/rjAWLlFp7CHnEpkG4osjF
	8TCBRKohQBDvlgG9MGAHIHWEtxp9gtv1pen60t7FpC10/mZnEesK7THkxQn6BN2pfoqGZcd1oY0tc
	EMlYSXjAdjhuCGBCAx6B0woA7JM1A976F2BERhAgXybY9M7MkCweH1saiFWnQVARnnfYK3ZMsPhf9
	5n9zJili8nDNIYRIVY/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qyBEv-007Zpc-1G;
	Wed, 01 Nov 2023 13:26:33 +0000
Received: from mgamail.intel.com ([192.55.52.115])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qyBEq-007ZoG-0t
	for kexec@lists.infradead.org;
	Wed, 01 Nov 2023 13:26:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698845188; x=1730381188;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=05eUvS3RedhhXCBFQIn/RW/rMVXJukr5CxJro4wh1PM=;
  b=dHfHGAVb3YUi9I2hBBeiNs9b+gld1zRi5l/p+CNSKPgHXN7Zj5RQ3Kga
   uIG1YD8sEoqlHxC/cbq3YEOfWIW0KQz4fXiY4dcAQ+qfH9xhkIs46cvRC
   g3X3ScG/eBx5sEjjYqfEc2IwpVI5vkcttJdKvv+AczzGnCP7ZljLtx8AK
   HXAxMHjDCSmlLJHEDD+dF1O48HkWD6PJVbHjmbqnTn/6hEpNhpbykhapA
   pPpq0AxiNZuSDBpiU0lPQM2yk2XYZ98mkCgA6uZ+COnheS32+8gX4HCYn
   hWObWHra/ynha9LC9RGNiHeIjG3VTi6/AvX6GihLfHBFuSu2fLAiMtCPe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="388310499"
X-IronPort-AV: E=Sophos;i="6.03,268,1694761200"; 
   d="scan'208";a="388310499"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 06:26:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="760940760"
X-IronPort-AV: E=Sophos;i="6.03,268,1694761200"; 
   d="scan'208";a="760940760"
Received: from ddraghic-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.42.20])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 06:26:19 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 8E58E10A2F9; Wed,  1 Nov 2023 16:26:16 +0300 (+03)
Date: Wed, 1 Nov 2023 16:26:16 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 13/13] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Message-ID: <20231101132616.nviynrbb53acpnv5@box>
References: <20231020151242.1814-1-kirill.shutemov@linux.intel.com>
 <20231020151242.1814-14-kirill.shutemov@linux.intel.com>
 <87r0ldz66f.ffs@tglx>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87r0ldz66f.ffs@tglx>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231101_062628_326274_278ADD42 
X-CRM114-Status: GOOD (  53.12  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Sun, Oct 29, 2023 at 06:31:36PM +0100, Thomas Gleixner wrote:
> On Fri, Oct 20 2023 at 18:12, Kirill A. Shutemov wrote:
> 
> > MADT Multiprocessor Wakeup structure version 1 brings support of CPU
> > offlining: BIOS provides a reset vector where the CPU has to jump to
> > offline itself. The new TEST mailbox command can be used to test the CPU
> > offlined successfully and BIOS has control over it.
> >
> > Add CPU offling support for ACPI MADT wakeup method by implementing
> > custom cpu_die, play_dead and stop_other_cpus SMP operations.
> >
> > CPU offlining makes possible to hand over secondary CPUs over kexec, not
> 
> makes it possible
> 
> > limiting the second kernel with single CPU.
> 
> s/with/to/

Okay.

> > The change conforms to the approved ACPI spec change proposal. See the
> > +SYM_FUNC_START(asm_acpi_mp_play_dead)
> > +	/* Load address of reset vector into RCX to jump when kernel is ready */
> > +	movq	acpi_mp_reset_vector_paddr(%rip), %rcx
> > +
> > +	/* Turn off global entries. Following CR3 write will flush them. */
> > +	movq	%cr4, %rdx
> > +	andq	$~(X86_CR4_PGE), %rdx
> > +	movq	%rdx, %cr4
> > +
> > +	/* Switch to identity mapping */
> > +	movq	acpi_mp_pgd(%rip), %rax
> > +	movq	%rax, %cr3
> 
> You can just make this function:
> 
>     asm_acpi_mp_play_dead(u64 reset_vector, u64 pgd_pa);
> 
> then you have the reset vector in RDI and the pgd in RSI and spare the
> global variables.

Yeah, it is better. Thanks.

> >  /* Physical address of the Multiprocessor Wakeup Structure mailbox */
> > @@ -11,6 +16,150 @@ static u64 acpi_mp_wake_mailbox_paddr;
> >  /* Virtual address of the Multiprocessor Wakeup Structure mailbox */
> >  static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
> >  
> > +u64 acpi_mp_pgd;
> > +u64 acpi_mp_reset_vector_paddr;
> 
> See above (static) and __ro_after_init please
> 
> > +
> > +void asm_acpi_mp_play_dead(void);
> > +
> > +static void __init *alloc_pgt_page(void *context)
> > +{
> 
> What's the purpose of the context argument?

To conform to x86_mapping_info::alloc_pgt_page type.

I will rename the argument to 'dummy' and add comment.

> > +	return memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> > +}
> > +
> > +/*
> > + * Make sure asm_acpi_mp_play_dead() is present in the identity mapping at
> > + * the same place as in the kernel page tables. The function switches to
> > + * the identity mapping and has be present at the same spot in before and
> > + * after transition.
> 
> Why does it need to be there after the CPU jumped to the reset vector?

After transition to the identity mapping, not after jumping to reset
vector. I will adjust the comment.

> > + */
> > +static int __init init_transition_pgtable(pgd_t *pgd)
> > +{
> > +	pgprot_t prot = PAGE_KERNEL_EXEC_NOENC;
> > +	unsigned long vaddr, paddr;
> > +	int result = -ENOMEM;
> > +	p4d_t *p4d;
> > +	pud_t *pud;
> > +	pmd_t *pmd;
> > +	pte_t *pte;
> > +
> > +	vaddr = (unsigned long)asm_acpi_mp_play_dead;
> > +	pgd += pgd_index(vaddr);
> > +	if (!pgd_present(*pgd)) {
> > +		p4d = (p4d_t *)alloc_pgt_page(NULL);
> > +		if (!p4d)
> > +			goto err;
> 
>         return -ENOMEM?
> 
> the error labels is pretty silly without an actual cleanup, right?

Right.

> > +		set_pgd(pgd, __pgd(__pa(p4d) | _KERNPG_TABLE));
> > +	}
> > +	p4d = p4d_offset(pgd, vaddr);
> > +	if (!p4d_present(*p4d)) {
> > +		pud = (pud_t *)alloc_pgt_page(NULL);
> > +		if (!pud)
> > +			goto err;
> 
> Ditto. But what mops up the already allocated page above?

Oops. I will add cleanup in acpi_mp_setup_reset() if
kernel_ident_mapping_init() or init_transition_pgtable() fails.

> > +	set_pte(pte, pfn_pte(paddr >> PAGE_SHIFT, prot));
> > +
> > +	return 0;
> > +err:
> > +	return result;
> > +}
> 
> Can you please move that function to the place where it is used?

Sure.

> > +
> > +static void acpi_mp_play_dead(void)
> > +{
> > +	play_dead_common();
> > +	asm_acpi_mp_play_dead();
> > +}
> > +
> > +static void acpi_mp_cpu_die(unsigned int cpu)
> > +{
> > +	int apicid = per_cpu(x86_cpu_to_apicid, cpu);
> 
> u32 apicid

Okay.

> > +	unsigned long timeout;
> > +
> > +	/*
> > +	 * Use TEST mailbox command to prove that BIOS got control over
> > +	 * the CPU before declaring it dead.
> > +	 *
> > +	 * BIOS has to clear 'command' field of the mailbox.
> > +	 */
> > +	acpi_mp_wake_mailbox->apic_id = apicid;
> > +	smp_store_release(&acpi_mp_wake_mailbox->command,
> > +			  ACPI_MP_WAKE_COMMAND_TEST);
> > +
> > +	/* Don't wait longer than a second. */
> > +	timeout = USEC_PER_SEC;
> > +	while (READ_ONCE(acpi_mp_wake_mailbox->command) && timeout--)
> > +		udelay(1);
> > +}
> > +
> > +static void acpi_mp_stop_other_cpus(int wait)
> > +{
> > +	smp_shutdown_nonboot_cpus(smp_processor_id());
> 
> This clearly was never tested with lockdep. At the point where
> stop_other_cpus() is invoked the invoking CPU has interrupts disabled...

Hm. I do have lockdep enabled and there's no reported.

And I am not sure why it should complain. At this point we are running on
reboot cpu (after migrate_to_reboot_cpu()).

Could you elaborate on what the problem here?

> > +}
> > +
> > +static void acpi_mp_crash_stop_other_cpus(void)
> > +{
> > +	smp_shutdown_nonboot_cpus(smp_processor_id());
> 
> Yuck. Crash can happen at arbitrary places. So you really cannot invoke
> the whole CPU hotplug state machine from here.
> 
> There is a reason why the other implementation just kick CPUs into some
> "safe" state.

Yeah, fair enough.

What about the implementation below? It is heavily inspired by
nmi_shootdown_cpus().

BTW, I don't understand why nmi_shootdown_cpus() needs 'crashing_cpu' if
it uses apic_send_IPI_allbutself(). 'crashing_cpu' == self, no?


static atomic_t waiting_for_crash_ipi;
static bool crash_ipi_issued;

static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
{
	local_irq_disable();

	crash_save_cpu(regs, raw_smp_processor_id());

	cpu_emergency_stop_pt();

	disable_local_APIC();

	/*
	 * Prepare the CPU for reboot _after_ invoking the callback so that the
	 * callback can safely use virtualization instructions, e.g. VMCLEAR.
	 */
	cpu_emergency_disable_virtualization();

	atomic_dec(&waiting_for_crash_ipi);

	asm_acpi_mp_play_dead(acpi_mp_reset_vector_paddr,
			      acpi_mp_pgd);

	return NMI_HANDLED;
}

static void acpi_mp_crash_stop_other_cpus(void)
{
	unsigned long timeout;

	/* The kernel is broken so disable interrupts */
	local_irq_disable();

	/*
	 * Avoid certain doom if a shootdown already occurred; re-registering
	 * the NMI handler will cause list corruption, modifying the callback
	 * will do who knows what, etc...
	 */
	if (WARN_ON_ONCE(crash_ipi_issued))
		return;

	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);

	/* Would it be better to replace the trap vector here? */
	if (register_nmi_handler(NMI_LOCAL, crash_nmi_callback,
				 NMI_FLAG_FIRST, "crash"))
		return;		/* Return what? */

	apic_send_IPI_allbutself(NMI_VECTOR);

	WRITE_ONCE(crash_ipi_issued, 1);

	/* Don't wait longer than a second. */
	timeout = USEC_PER_SEC;
	while (atomic_read(&waiting_for_crash_ipi) && timeout--)
		udelay(1);
}

> > +	/* The kernel is broken so disable interrupts */
> > +	local_irq_disable();
> > +}
> > +
> > +static int __init acpi_mp_setup_reset(u64 reset_vector)
> > +{
> > +	pgd_t *pgd;
> > +	struct x86_mapping_info info = {
> > +		.alloc_pgt_page = alloc_pgt_page,
> > +		.page_flag      = __PAGE_KERNEL_LARGE_EXEC,
> > +		.kernpg_flag    = _KERNPG_TABLE_NOENC,
> > +	};
> > +
> > +	pgd = alloc_pgt_page(NULL);
> > +
> > +	for (int i = 0; i < nr_pfn_mapped; i++) {
> > +		unsigned long mstart, mend;
> 
> Missing newline
> 

Okay.

> >  
> > -	/*
> > -	 * ACPI MADT doesn't allow to offline CPU after it got woke up.
> > -	 * It limits kexec: the second kernel won't be able to use more than
> > -	 * one CPU.
> > -	 *
> > -	 * Now acpi_mp_wake_mailbox_paddr already has the mailbox address.
> > -	 * The acpi_wakeup_cpu() will use it to bring up secondary cpus.
> > -	 *
> > -	 * Zero out mailbox address in the ACPI MADT wakeup structure to
> > -	 * indicate that the mailbox is not usable.  This prevents the
> > -	 * kexec()-ed kernel from reading a vaild mailbox, which in turn
> > -	 * makes the kexec()-ed kernel only be able to use the boot CPU.
> > -	 *
> > -	 * This is Linux-specific protocol and not reflected in ACPI spec.
> > -	 */
> > -	mp_wake->mailbox_address = 0;
> > +		/*
> > +		 * ACPI MADT doesn't allow to offline CPU after it got woke up.
> 
> This is not longer accurate as V1 allows that ....
> 

Will fix.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
