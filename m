Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A6EC47DD9
	for <kexec@archiver.kernel.org>; Sun, 25 Feb 2024 14:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zcjJwTBEx/jciJ3LRdImOktrlDmvmd9cJka28BSg57g=; b=H3tvo8QkMnUX1J
	5MTnnXy9d6To0x9vW9M3mzJIU/VWw36ZmHAcaaE8PINFXHrZAliL0gCGHfI+bVz8PBOc1jdiczZIr
	kMb9TV9eiOP0lVH3pPhc+pLfbMMvN+Kq7xiyUHvyfSmmj3I2g2f+CluzLa5E9tQ6apzRrGPUMe2C/
	BFYB210gCTod8NCeJofKKSrEseqJ6LQG4KwTJNIYfsWC0e/P/o7lXSiWvLwmr8GPh7RDt9AUJWq/J
	KOgxsc/zMyHDK2eFwPc1rHGw53AKisODfONkesPrwsHP8PXP/YoRGGNuq4xLOYPtODRZ2FdvMUcGR
	XZ6qJNDHtm938d+qUsBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reFy0-0000000F7Vp-4653;
	Sun, 25 Feb 2024 14:59:00 +0000
Received: from mgamail.intel.com ([192.198.163.9])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reFxw-0000000F7VC-1XoZ
	for kexec@lists.infradead.org;
	Sun, 25 Feb 2024 14:58:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708873136; x=1740409136;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jePslZk9gVVhTBiw8BU4nyJ2SOGn6xWwNg6KJ2+6rgk=;
  b=T6RX1lTBtr6HnfH+2LQ53vfRjN8YTN9L1jEUNJSPqqehzaUBSzL6t9Hv
   WlOTco8irVlNLWkPlS139bhquTkX7HUPXJsLG7Ux95WPxqpFVAdKB1jnY
   tAWUGEWrFBmgPu5iM/J7XY1+iLZK1M+ZelfEipEoUZvOA1+jchPtOoxKr
   vmIgrcgu5k5T56I/wJbz6iBfrOCViQ9MxebUQK39XYxSB2xx7tAoGZO8N
   q3HoDYYwa7GFyIBAaIc01azuoj7X45bONseFt8PXTed2gfqDYojbYouEQ
   2EYrtOxGEPOf+GKNca2DyWbUXxXtwBEPQTbOuy8+2a58dEu0sjBX0nf1K
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="13854515"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="13854515"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 06:58:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="937028098"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="937028098"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Feb 2024 06:58:47 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id AACA838F; Sun, 25 Feb 2024 16:58:46 +0200 (EET)
Date: Sun, 25 Feb 2024 16:58:46 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7 10/16] x86/tdx: Convert shared memory back to private
 on kexec
Message-ID: <3nqc34o54ydpdvo6j7a5hltyjs6kkw5jy5i6dgvivg7f4hzec2@l6jetcopnm6k>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-11-kirill.shutemov@linux.intel.com>
 <a14bda4a-15ad-4d20-8b60-0ab92b608f2f@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a14bda4a-15ad-4d20-8b60-0ab92b608f2f@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240225_065856_477650_9334FB34 
X-CRM114-Status: GOOD (  26.83  )
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

On Fri, Feb 23, 2024 at 11:39:07AM -0800, Dave Hansen wrote:
> On 2/12/24 02:44, Kirill A. Shutemov wrote:
> > +static void tdx_kexec_stop_conversion(bool crash)
> > +{
> > +	/* Stop new private<->shared conversions */
> > +	conversion_allowed = false;
> > +
> > +	/*
> > +	 * Make sure conversion_allowed is cleared before checking
> > +	 * conversions_in_progress.
> > +	 */
> > +	barrier();
> > +
> > +	/*
> > +	 * Crash kernel reaches here with interrupts disabled: can't wait for
> > +	 * conversions to finish.
> > +	 *
> > +	 * If race happened, just report and proceed.
> > +	 */
> > +	if (!crash) {
> > +		unsigned long timeout;
> > +
> > +		/*
> > +		 * Wait for in-flight conversions to complete.
> > +		 *
> > +		 * Do not wait more than 30 seconds.
> > +		 */
> > +		timeout = 30 * USEC_PER_SEC;
> > +		while (atomic_read(&conversions_in_progress) && timeout--)
> > +			udelay(1);
> > +	}
> > +
> > +	if (atomic_read(&conversions_in_progress))
> > +		pr_warn("Failed to finish shared<->private conversions\n");
> > +}
> 
> I'd really prefer we find a way to do this with actual locks, especially
> 'conversion_allowed'.
> 
> This is _awfully_ close to being able to be handled by a rwsem where the
> readers are the converters and tdx_kexec_stop_conversion() takes a write.

Okay, here's what I come up with. It needs more testing.

Any comments?

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index fd212c9bad89..5eb0dac33f37 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -6,8 +6,10 @@
 
 #include <linux/cpufeature.h>
 #include <linux/debugfs.h>
+#include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/io.h>
+#include <linux/kexec.h>
 #include <asm/coco.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
@@ -15,6 +17,7 @@
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
 #include <asm/pgtable.h>
+#include <asm/set_memory.h>
 
 /* MMIO direction */
 #define EPT_READ	0
@@ -837,6 +840,65 @@ static int tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
 	return 0;
 }
 
+static void tdx_kexec_stop_conversion(bool crash)
+{
+	/* Stop new private<->shared conversions */
+	if (!stop_memory_enc_conversion(!crash))
+		pr_warn("Failed to finish shared<->private conversions\n");
+}
+
+static void tdx_kexec_unshare_mem(void)
+{
+	unsigned long addr, end;
+	long found = 0, shared;
+
+	/*
+	 * Walk direct mapping and convert all shared memory back to private,
+	 */
+
+	addr = PAGE_OFFSET;
+	end  = PAGE_OFFSET + get_max_mapped();
+
+	while (addr < end) {
+		unsigned long size;
+		unsigned int level;
+		pte_t *pte;
+
+		pte = lookup_address(addr, &level);
+		size = page_level_size(level);
+
+		if (pte && pte_decrypted(*pte)) {
+			int pages = size / PAGE_SIZE;
+
+			/*
+			 * Touching memory with shared bit set triggers implicit
+			 * conversion to shared.
+			 *
+			 * Make sure nobody touches the shared range from
+			 * now on.
+			 */
+			set_pte(pte, __pte(0));
+
+			if (!tdx_enc_status_changed(addr, pages, true)) {
+				pr_err("Failed to unshare range %#lx-%#lx\n",
+				       addr, addr + size);
+			}
+
+			found += pages;
+		}
+
+		addr += size;
+	}
+
+	__flush_tlb_all();
+
+	shared = atomic_long_read(&nr_shared);
+	if (shared != found) {
+		pr_err("shared page accounting is off\n");
+		pr_err("nr_shared = %ld, nr_found = %ld\n", shared, found);
+	}
+}
+
 void __init tdx_early_init(void)
 {
 	struct tdx_module_args args = {
@@ -896,6 +958,9 @@ void __init tdx_early_init(void)
 	x86_platform.guest.enc_cache_flush_required  = tdx_cache_flush_required;
 	x86_platform.guest.enc_tlb_flush_required    = tdx_tlb_flush_required;
 
+	x86_platform.guest.enc_kexec_stop_conversion = tdx_kexec_stop_conversion;
+	x86_platform.guest.enc_kexec_unshare_mem     = tdx_kexec_unshare_mem;
+
 	/*
 	 * TDX intercepts the RDMSR to read the X2APIC ID in the parallel
 	 * bringup low level code. That raises #VE which cannot be handled
diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index a5e89641bd2d..9d4a8e548820 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -48,8 +48,11 @@ int set_memory_wc(unsigned long addr, int numpages);
 int set_memory_wb(unsigned long addr, int numpages);
 int set_memory_np(unsigned long addr, int numpages);
 int set_memory_4k(unsigned long addr, int numpages);
+
+bool stop_memory_enc_conversion(bool wait);
 int set_memory_encrypted(unsigned long addr, int numpages);
 int set_memory_decrypted(unsigned long addr, int numpages);
+
 int set_memory_np_noalias(unsigned long addr, int numpages);
 int set_memory_nonglobal(unsigned long addr, int numpages);
 int set_memory_global(unsigned long addr, int numpages);
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 0d2267ad4e0e..e074b2aca970 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2176,12 +2176,32 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	return ret;
 }
 
+static DECLARE_RWSEM(mem_enc_lock);
+
+bool stop_memory_enc_conversion(bool wait)
+{
+	if (!wait)
+		return down_write_trylock(&mem_enc_lock);
+
+	down_write(&mem_enc_lock);
+
+	return true;
+}
+
 static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 {
-	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
-		return __set_memory_enc_pgtable(addr, numpages, enc);
+	int ret = 0;
 
-	return 0;
+	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
+		if (!down_read_trylock(&mem_enc_lock))
+			return -EBUSY;
+
+		ret =__set_memory_enc_pgtable(addr, numpages, enc);
+
+		up_read(&mem_enc_lock);
+	}
+
+	return ret;
 }
 
 int set_memory_encrypted(unsigned long addr, int numpages)
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
