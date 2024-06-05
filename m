Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B47DC25B76
	for <kexec@archiver.kernel.org>; Wed,  5 Jun 2024 12:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gIflSymhuM70z7ED521atfFGt3+yZOz5odDcpkkT45A=; b=yP6JuTaMEQGXMq
	o1tY0Qweu3FJ+XXq8e2o9AHnvOMUMI9+JIhEEBjIzDGs/JfcEQ9AdIvAeCycht2dM3RwpmOp29HIM
	ekyl/S6MJ7l60Us7o1ZPcN3pt2a80set0OzMD7sTychkRQCw/sZbd0Lh2Nr4aw1unI7QN8WbktkhX
	zk+bD3c6AtBLkDR8QPXbGUiooVCX4NMN6LcySlEWZU6qAfujerufIHL2iDsucuj8Lm9I/BR6Gw6m4
	U9snMeCenbZwUnFuhWqIGIHHvGKlXuQ44+s6sMlDTOl7DH4/Uabp7VrkKIkKAKkmUOojYHOVu4f8h
	L7ZHNhuZaq6YatL6nMQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEpze-000000063ZM-2ubp;
	Wed, 05 Jun 2024 12:43:54 +0000
Received: from mgamail.intel.com ([198.175.65.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEpzc-000000063YH-1weJ
	for kexec@lists.infradead.org;
	Wed, 05 Jun 2024 12:43:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717591432; x=1749127432;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ird/7ibDYFzjfXEOhEaNA8pLzi4g/oGwnmrePMvc8zQ=;
  b=W03P77CXkuB+8Qf4pRhF16n3YuhYDKlpMMNXdC/2/OYhAIFizfAkBZs0
   fnnT9VMvBDxqFgp4upVW2qjySkKM7tKl+0FH8Z+WP81yCYpnvcskIPyh4
   4psJ+YBI9+y5bFZbZ36/nfY9GTxjAZGhOKsl7Gl6x292dyaLQVQND7PP5
   Br8qJtPkpIY54BbljW6MjqzJQFDUo025UuHyjJ6QdG78KVEKtEFWNFVGA
   N7bMWJI8c78Hmsrg+DGJk9IsNThpeQGO8Ky29a15+U3SgW+SoC7rSPte7
   zJq4fZKtwoNC0PfxoR8abmZztpoMWESRahcivKBxd3XqxpkkqC1PBiDoN
   A==;
X-CSE-ConnectionGUID: 9m1yH3VsTL2M7EtOZd1HQA==
X-CSE-MsgGUID: FCDUrrjtRiW7TcsQxCc0cw==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="25603460"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="25603460"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 05:43:47 -0700
X-CSE-ConnectionGUID: fqlx1KVQTw22jSK8Bo+f2g==
X-CSE-MsgGUID: ActVDDhwSRyovQJ4dmAvOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="42133851"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 05 Jun 2024 05:43:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id E5C7F1B6; Wed, 05 Jun 2024 15:43:39 +0300 (EEST)
Date: Wed, 5 Jun 2024 15:43:39 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv11 11/19] x86/tdx: Convert shared memory back to private
 on kexec
Message-ID: <ass6d7jqmjmttnyfzpdfid6dymqriors2awdtyedwvc7ft4zhg@qzj637lzmjt6>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-12-kirill.shutemov@linux.intel.com>
 <68943e0b-8d82-42de-8f09-058e97d9a392@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <68943e0b-8d82-42de-8f09-058e97d9a392@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_054352_573884_387E4AFD 
X-CRM114-Status: GOOD (  30.40  )
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

On Tue, Jun 04, 2024 at 09:27:59AM -0700, Dave Hansen wrote:
> On 5/28/24 02:55, Kirill A. Shutemov wrote:
> > +/* Stop new private<->shared conversions */
> > +static void tdx_kexec_begin(bool crash)
> > +{
> > +	/*
> > +	 * Crash kernel reaches here with interrupts disabled: can't wait for
> > +	 * conversions to finish.
> > +	 *
> > +	 * If race happened, just report and proceed.
> > +	 */
> > +	if (!set_memory_enc_stop_conversion(!crash))
> > +		pr_warn("Failed to stop shared<->private conversions\n");
> > +}
> 
> I don't like having to pass 'crash' in here.
> 
> If interrupts are the problem we have ways of testing for those directly.
> 
> If it's being in an oops that's a problem, we have 'oops_in_progress'
> for that.
> 
> In other words, I'd much rather this function (or better yet
> set_memory_enc_stop_conversion() itself) use some existing API to change
> its behavior in a crash rather than have the context be passed down and
> twiddled through several levels of function calls.
> 
> There are a ton of these in the console code:
> 
> 	if (oops_in_progress)
> 		foo_trylock();
> 	else
> 		foo_lock();
> 
> To me, that's a billion times more clear than a 'wait' argument that
> gets derives from who-knows-what that I have to trace through ten levels
> of function calls.

Okay fair enough. Check out the fixup below. Is it what you mean?

One other thing I realized is that these callback are dead code if kernel
compiled without kexec support. Do we want them to be wrapped with
#ifdef COFNIG_KEXEC_CORE everywhere? It is going to be ugly.

Any better ideas?

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 3d23ea0f5d45..1c5aa036b76b 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -834,7 +834,7 @@ static int tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
 }
 
 /* Stop new private<->shared conversions */
-static void tdx_kexec_begin(bool crash)
+static void tdx_kexec_begin(void)
 {
 	/*
 	 * Crash kernel reaches here with interrupts disabled: can't wait for
@@ -842,7 +842,7 @@ static void tdx_kexec_begin(bool crash)
 	 *
 	 * If race happened, just report and proceed.
 	 */
-	if (!set_memory_enc_stop_conversion(!crash))
+	if (!set_memory_enc_stop_conversion())
 		pr_warn("Failed to stop shared<->private conversions\n");
 }
 
diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index d490db38db9e..4b2abce2e3e7 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -50,7 +50,7 @@ int set_memory_np(unsigned long addr, int numpages);
 int set_memory_p(unsigned long addr, int numpages);
 int set_memory_4k(unsigned long addr, int numpages);
 
-bool set_memory_enc_stop_conversion(bool wait);
+bool set_memory_enc_stop_conversion(void);
 int set_memory_encrypted(unsigned long addr, int numpages);
 int set_memory_decrypted(unsigned long addr, int numpages);
 
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index b0f313278967..213cf5379a5a 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -152,8 +152,6 @@ struct x86_init_acpi {
  * @enc_kexec_begin		Begin the two-step process of converting shared memory back
  *				to private. It stops the new conversions from being started
  *				and waits in-flight conversions to finish, if possible.
- *				The @crash parameter denotes whether the function is being
- *				called in the crash shutdown path.
  * @enc_kexec_finish		Finish the two-step process of converting shared memory to
  *				private. All memory is private after the call when
  *				the function returns.
@@ -165,7 +163,7 @@ struct x86_guest {
 	int (*enc_status_change_finish)(unsigned long vaddr, int npages, bool enc);
 	bool (*enc_tlb_flush_required)(bool enc);
 	bool (*enc_cache_flush_required)(void);
-	void (*enc_kexec_begin)(bool crash);
+	void (*enc_kexec_begin)(void);
 	void (*enc_kexec_finish)(void);
 };
 
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index fc52ea80cdc8..340af8155658 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -137,7 +137,7 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 	 * down and interrupts have been disabled. This allows the callback to
 	 * detect a race with the conversion and report it.
 	 */
-	x86_platform.guest.enc_kexec_begin(true);
+	x86_platform.guest.enc_kexec_begin();
 	x86_platform.guest.enc_kexec_finish();
 
 	crash_save_cpu(regs, safe_smp_processor_id());
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 513809b5b27c..0e0a4cf6b5eb 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -723,7 +723,7 @@ void native_machine_shutdown(void)
 	 * conversions to finish cleanly.
 	 */
 	if (kexec_in_progress)
-		x86_platform.guest.enc_kexec_begin(false);
+		x86_platform.guest.enc_kexec_begin();
 
 	/* Stop the cpus and apics */
 #ifdef CONFIG_X86_IO_APIC
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 8a79fb505303..82b128d3f309 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -138,7 +138,7 @@ static int enc_status_change_prepare_noop(unsigned long vaddr, int npages, bool
 static int enc_status_change_finish_noop(unsigned long vaddr, int npages, bool enc) { return 0; }
 static bool enc_tlb_flush_required_noop(bool enc) { return false; }
 static bool enc_cache_flush_required_noop(void) { return false; }
-static void enc_kexec_begin_noop(bool crash) {}
+static void enc_kexec_begin_noop(void) {}
 static void enc_kexec_finish_noop(void) {}
 static bool is_private_mmio_noop(u64 addr) {return false; }
 
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 2a548b65ef5f..443a97e515c0 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2240,13 +2240,14 @@ static DECLARE_RWSEM(mem_enc_lock);
  *
  * Taking the exclusive mem_enc_lock waits for in-flight conversions to complete.
  * The lock is not released to prevent new conversions from being started.
- *
- * If sleep is not allowed, as in a crash scenario, try to take the lock.
- * Failure indicates that there is a race with the conversion.
  */
-bool set_memory_enc_stop_conversion(bool wait)
+bool set_memory_enc_stop_conversion(void)
 {
-	if (!wait)
+	/*
+	 * In a crash scenario, sleep is not allowed. Try to take the lock.
+	 * Failure indicates that there is a race with the conversion.
+	 */
+	if (oops_in_progress)
 		return down_write_trylock(&mem_enc_lock);
 
 	down_write(&mem_enc_lock);
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
