Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D735E92FCB
	for <kexec@archiver.kernel.org>; Thu,  5 Oct 2023 22:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RbFOFJt/+M4Lo7eBwdxbVW0erEJKjzJKtPGhnUBZl7k=; b=qYY28y4aFnlFNx
	URJ8KFRBONozCZ6hmxtgZgBpoBNCuHr1G3ejyHxzQzpOXybnUYtk0IVHrlmk4ICFCIYJpduZ54Kpf
	WsxfjyqwJDyPPRw0ug7SgpChJsGASOpvGLIUZo0rmLWkS5o7q8e/PgOofqAI7rS8ryil65Otmx4Sd
	BNXMxp8UHY9aopfWHogXe/qBiKC2uWdDH+TVcmEO1yxplAwxlG0wcCGWHxsdjbx1/9fu5pprztb0O
	y4cClQGIS4mgl7epuF6KKXJKBlXxXKSVyT9jfoUBK8oR6v4ggfJaYLJC3ZRLeID6VhuFjvLbN3vyc
	8nYTr1cxwQ4FPHyfWq6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qoWqB-004Z0t-0f;
	Thu, 05 Oct 2023 22:29:07 +0000
Received: from mgamail.intel.com ([192.198.163.7])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qoWq7-004Yzx-2T
	for kexec@lists.infradead.org;
	Thu, 05 Oct 2023 22:29:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696544943; x=1728080943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3ak/CqPJFuvAGz1nL0ORtkufKNGBvhTu0OaUcGSyyRI=;
  b=AlV0j3C4M5PdqRrWEAyFMt5mFE+4OqbWnqvXpR0+hTBgRIwDWKBjQqIw
   ROXhcnlvWBTA7v3R/vurlSVIJpj+4wTA9EIXsLzWkfUVNfmZV4h+rhbd4
   1zE/gm7dI7xf/8uiMQntUXrZJKoiLdBgr4SHLJsdeEKLCbm0VW2M60jxU
   afTQ0Zb3ToZZa9yco7OS7+N9bbJZqQ58ksAt5dMvrfJNDgyTj6OIbCGNV
   uyu9iKtV5pit1nOELpwT2/k1bybzX3fC8IbbOo0yBQc4tjwO1QVZJki1d
   3SB85l6YdhuaN2hATn/5fNii/L/uMwS9hN6iEWCOfdppTzaroLLQe2oYv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="5195872"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="5195872"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 15:28:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="817796476"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="817796476"
Received: from kvsudesh-mobl1.gar.corp.intel.com (HELO box.shutemov.name) ([10.251.222.76])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 15:28:43 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
	id BFE0B10A12D; Fri,  6 Oct 2023 01:28:39 +0300 (+03)
Date: Fri, 6 Oct 2023 01:28:39 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/13] x86/tdx: Convert shared memory back to private on
 kexec
Message-ID: <20231005222839.jt2du72xogg3c5ny@box>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-11-kirill.shutemov@linux.intel.com>
 <8d0e4e71-0614-618a-0f84-55eeb6d27a6d@amd.com>
 <20231005212828.veeekxqc7rwvrbig@box>
 <e0459b50-7e21-7548-8151-9010ee88b0a6@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e0459b50-7e21-7548-8151-9010ee88b0a6@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231005_152903_839632_22259D2A 
X-CRM114-Status: GOOD (  29.67  )
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

On Thu, Oct 05, 2023 at 05:01:23PM -0500, Kalra, Ashish wrote:
> On 10/5/2023 4:28 PM, Kirill A. Shutemov wrote:
> > On Thu, Oct 05, 2023 at 01:41:38PM -0500, Kalra, Ashish wrote:
> > > > +static void unshare_all_memory(bool unmap)
> > > > +{
> > > > +	unsigned long addr, end;
> > > > +	long found = 0, shared;
> > > > +
> > > > +	/*
> > > > +	 * Walk direct mapping and convert all shared memory back to private,
> > > > +	 */
> > > > +
> > > > +	addr = PAGE_OFFSET;
> > > > +	end  = PAGE_OFFSET + get_max_mapped();
> > > > +
> > > > +	while (addr < end) {
> > > > +		unsigned long size;
> > > > +		unsigned int level;
> > > > +		pte_t *pte;
> > > > +
> > > > +		pte = lookup_address(addr, &level);
> > > 
> > > IIRC, you were earlier walking the direct mapping using
> > > walk_page_range_novma(), any particular reason to use lookup_address()
> > > instead ?
> > 
> > walk_page_range_novma() wants mmap lock to be taken, but it is tricky as
> > we run here from atomic context in case of crash.
> > 
> > I considered using trylock to bypass the limitation, but it is a hack.
> > 
> > > 
> > > > +		size = page_level_size(level);
> > > > +
> > > > +		if (pte && pte_decrypted(*pte)) {
> > > 
> > > Additionally need to add check for pte_none() here to handle physical memory
> > > holes in direct mapping.
> > 
> > lookup_address() returns NULL for none entries.
> > 
> 
> Looking at lookup_address_in_pgd(), at pte level it is simply returning
> pte_offset_kernel() and there does not seem to be a check for returning NULL
> if pte_none() ?

Hm. You are right.

I think it yet another quirk in how lookup_address() implemented. We need
to make it straight too.

There's two options: either make lookup_address() return pointer for entry
even if it is NULL, or add check for pte_none() after pte_offset_kernel()
and return NULL if it is true.

I like the first option more as it allows caller to populate the entry if
it wants.

> > > > +			int pages = size / PAGE_SIZE;
> > > > +
> > > > +			/*
> > > > +			 * Touching memory with shared bit set triggers implicit
> > > > +			 * conversion to shared.
> > > > +			 *
> > > > +			 * Make sure nobody touches the shared range from
> > > > +			 * now on.
> > > > +			 *
> > > > +			 * Bypass unmapping for crash scenario. Unmapping
> > > > +			 * requires sleepable context, but in crash case kernel
> > > > +			 * hits the code path with interrupts disabled.
> > > 
> > > In case of SNP we will need to temporarily enable interrupts during this
> > > unsharing as we invoke set_memory_encrypted() which then hits a BUG_ON() in
> > > cpa_flush() if interrupts are disabled.
> > 
> > Do you really need full set_memory_encrypted()? Can't you do something
> > ligher?
> > 
> We need to modify the PTE for setting c-bit to 1 so that will require
> cpa_flush(), though probably can add something lighter to do
> clflush_cache_range() directly ?

For TDX, I don't touch shared bit as nobody suppose to touch the memory
after the point (ans set_memory_np() enforces it for !crash case).

Can't SNP do the same?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
