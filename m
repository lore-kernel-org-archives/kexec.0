Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D236BC001DF
	for <kexec@archiver.kernel.org>; Fri, 20 Oct 2023 12:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tP50W8VYmef/GH8wJ3QA4ivUFo0GVhzz78Kx3M++aGw=; b=B67rr3OA9jqbEb
	b5jMzhbKkMTmFGBwgVEh7JvgrYgkS6MWp4Qkqldng8M3Hli3PKkSYCDZm5HpzTdNoXNMBe0XDuTHY
	N8tdL7zvzxiTLsEMF3uJy3zRNSOp+RbT8JY+5V03gHjFVTltrrlB37MV+5jVGOZmMrs1vHalXmjaj
	9IjRqG17CVyB08sdzf8H5aatm0N8TIn41PaD2PPFK4eaIwdAiPBFvNfuS4p05azm5/S7FpO224jO8
	JRVN9DAza0dIlbUwLaLMhpG4pbGW1brz5eRLNVxN5u2jQpCo9qa9o8GcjtAeFdTp2q/g8uOcLw57z
	2ZVUlTwi4Q7xB8DU+jNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtoi1-002Fi5-12;
	Fri, 20 Oct 2023 12:34:33 +0000
Received: from mgamail.intel.com ([134.134.136.126])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtohx-002Ffm-31
	for kexec@lists.infradead.org;
	Fri, 20 Oct 2023 12:34:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697805269; x=1729341269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=KbNvs0px0D1QU2CACqrpgox2LilZmVWe6/Qr9SDWOLU=;
  b=PtcbFoUi47Aim9L6lTzZPCNGSIk+Fnwi0f0iuSIo3M7vSbUVi/NNrVU7
   tOFM/mu7iiCaxa0u/xssDm34udll6rxEKqmFoSMEp1lzcc6BVP1B8K5EM
   FO4hLQ41kwcjxSDVPV11ZaGOYbsEu/CYGlHU/3+Y/TT8rO2HsRXE8MqW3
   +3yLIDyoLPEChk/QAa2ZvIkxxoTucxaAnFbbSrsPs9kPgyfsMDbq9ewRg
   skFWn+HNPUA8aXi8Y32a7XBIWvXS8DoPB9PGw4O4oIsHTTTRTTQcPL0do
   DIld5WAfG+YuQEPTtWscpJDWPVogA91C5OPKWOQJF/aGrEeg/m/oOa68X
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="371559979"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="371559979"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 05:34:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="873891358"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="873891358"
Received: from dgutows1-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.39.237])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 05:34:20 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 0249010A1C7; Fri, 20 Oct 2023 15:34:17 +0300 (+03)
Date: Fri, 20 Oct 2023 15:34:17 +0300
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
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCH 13/13] x86/acpi: Add support for CPU offlining for ACPI
 MADT wakeup method
Message-ID: <20231020123417.2577fm526juwggkf@box.shutemov.name>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-14-kirill.shutemov@linux.intel.com>
 <e4cf5fbf384a14b06034667d62bb6cb85ec64305.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e4cf5fbf384a14b06034667d62bb6cb85ec64305.camel@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_053430_019668_7171DDE9 
X-CRM114-Status: GOOD (  20.25  )
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

On Fri, Oct 20, 2023 at 11:21:34AM +0000, Huang, Kai wrote:
> =

> > --- /dev/null
> > +++ b/arch/x86/kernel/acpi/madt.S
> > @@ -0,0 +1,28 @@
> > +#include <linux/linkage.h>
> > +#include <asm/nospec-branch.h>
> > +#include <asm/page_types.h>
> > +#include <asm/processor-flags.h>
> > +
> > +	.text
> > +	.align PAGE_SIZE
> > +SYM_FUNC_START(asm_acpi_mp_play_dead)
> > +	/* Load address of reset vector into RCX to jump when kernel is ready=
 */
> > +	movq	acpi_mp_reset_vector_paddr(%rip), %rcx
> > +
> > +	/* zero out flags, and disable interrupts */
> > +	pushq	$0
> > +	popfq
> > +
> > +	/* Turn off global entries. Following CR3 write will flush them. */
> > +	movq	%cr4, %rdx
> > +	andq	$~(X86_CR4_PGE), %rdx
> > +	movq	%rdx, %cr4
> > +
> > +	/* Switch to identity mapping */
> > +	movq	acpi_mp_pgd(%rip), %rax
> > +	movq	%rax, %cr3
> > +
> > +	/* Jump to reset vector */
> > +	ANNOTATE_RETPOLINE_SAFE
> > +	jmp	*%rcx
> > +SYM_FUNC_END(asm_acpi_mp_play_dead)
> > diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/=
madt_wakeup.c
> > index 4e92d1d4a5fa..2cc8590ec7a5 100644
> > --- a/arch/x86/kernel/acpi/madt_wakeup.c
> > +++ b/arch/x86/kernel/acpi/madt_wakeup.c
> > @@ -1,12 +1,162 @@
> >  #include <linux/acpi.h>
> >  #include <linux/cpu.h>
> > +#include <linux/delay.h>
> > +#include <linux/memblock.h>
> > +#include <linux/pgtable.h>
> > +#include <linux/sched/hotplug.h>
> >  #include <asm/apic.h>
> > +#include <asm/init.h>
> >  =

> >  /* Physical address of the Multiprocessor Wakeup Structure mailbox */
> >  static u64 acpi_mp_wake_mailbox_paddr;
> >  /* Virtual address of the Multiprocessor Wakeup Structure mailbox */
> >  static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
> >  =

> > +unsigned long acpi_mp_pgd;
> > +u64 acpi_mp_reset_vector_paddr;
> =

> Nit:=A0
> =

> They are both physical address.  It's a little bit odd for one to use 'un=
signed
> long' and the other to use 'u64'.

Okay, I will make them both u64.

> > +
> > +void asm_acpi_mp_play_dead(void);
> > +
> > +static void __init *alloc_pgt_page(void *context)
> > +{
> > +	return memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> > +}
> =

> If I am reading correclty, @context is never used.  It's not used inside =
this
> function, and all the callers call this with @context =3D NULL.

Yes. We need the argument to conform to x86_mapping_info::alloc_pgt_page
interface.

> > +
> > +static void acpi_mp_play_dead(void)
> > +{
> > +	idle_task_exit();
> > +	cpuhp_ap_report_dead();
> > +	asm_acpi_mp_play_dead();
> > +}
> > +
> =

> Looks you can use play_dead_common() here, if you take IRQ disable part o=
ut from
> the assembly, because play_dead_common() does:
> =

> void play_dead_common(void)
> {               =

>         idle_task_exit();
>                 =

>         cpuhp_ap_report_dead();                                          =
      =

>         =

>         local_irq_disable();                                             =
      =

> }

Okay, fair enough.

-- =

  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
