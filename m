Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3ECFC48BC3
	for <kexec@archiver.kernel.org>; Tue, 20 Feb 2024 12:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pdRNyoeE60jbztLdKkXh5GqRxYg7hYwQA4pTgerP41E=; b=KqHiSPQdpA8e4v
	rDentxiF0vu4Xx5cy0cEOgfzpE1GxXaQiUGgPJo/Mzd9oaWy+I7IGq/ztQJTfeW/94WtNvUnqEszY
	Qyo/WvPOoN3YXucb+W2OIyMPTDv6Yu/QFBX/tSL4Iioe1L/XzqMsd1XzhQBsTTFPG4bvc3uepxWS9
	dWoleBkHoFDHwK7jesFxL5bWHKuoPGjYh3fyvJHYs/sRS2Agrdj39tHZcPvvMm7qRGxV40m00FryK
	VbjET05ubd43obJ8M7XGm16SwoFS9wdbzOfESeghf0vnbeos2Ua246gOuIqZwMwXWrs3dQ1Fo2gLG
	cbmBtUQ8cslcsLC2aGjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcPMq-0000000EipQ-2Kft;
	Tue, 20 Feb 2024 12:37:00 +0000
Received: from mgamail.intel.com ([192.198.163.19])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcPMo-0000000EioX-0BeP
	for kexec@lists.infradead.org;
	Tue, 20 Feb 2024 12:36:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708432618; x=1739968618;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iNBAnZuBMR9OpFb371kjh23uca3k0nUqZwIq/GwOHag=;
  b=CdfjWuf6pX+RzD10RqLUfqYmSXb7AYO2l6fjLWpuR829EFtsUu9Et0Mq
   p5nIPtOw8yexmOUlO+xCc6mw/DFIA1MvNg43liHrwBS5TmQkdQ5WjB1+8
   qr6bPpPG7EJ/VjKXS5oHf2zG8Mq0OFdZZ6iXCJgdhv0fVwObprJO3UdaY
   t5BEMIksEy+0m14OlXLFhuirR22/wWmzXvBYkd1oO5d9YzIVLz6QdXP44
   +OzCJJFDdUuYyv0vmKcXkU4vQ9Lx7YEdqjFJ9lElgi3A8ZV9Ss4l23PcS
   nDxs0PVhHToumcY7mUa7xnkhyGXQnr4h4I2oB1qSK4gXM9ZEcDkIlIxIE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2395641"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="2395641"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 04:36:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="936448238"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="936448238"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 20 Feb 2024 04:36:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id D0CCE305; Tue, 20 Feb 2024 14:36:48 +0200 (EET)
Date: Tue, 20 Feb 2024 14:36:48 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Baoquan He <bhe@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, kexec@lists.infradead.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7 07/16] x86/mm: Return correct level from
 lookup_address() if pte is none
Message-ID: <ic4v3q4muffjq2jhlkk3k4lg5xxvjwlw22hctzubl5573euzu2@er3m7ztog2a6>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-8-kirill.shutemov@linux.intel.com>
 <ZdLjQCaxhOnR+GzX@MiWiFi-R3L-srv>
 <zhbhgq27kjrhkdgbxomjykjez2i4hckguvmxyptvfvoftue5ca@zowl5qbl6psl>
 <ZdR+JzfHjES3zytp@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZdR+JzfHjES3zytp@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240220_043658_117642_B7DD4545 
X-CRM114-Status: GOOD (  25.22  )
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

On Tue, Feb 20, 2024 at 06:25:43PM +0800, Baoquan He wrote:
> > I am not sure what part of the comment you see doesn't reflect the
> > behaviour. From my PoV, changed code matches the comment closer that
> > original.
> 
> Oh, I didn't make it clear. I mean update the code comment for
> lookup_address(), and add code comment for lookup_address_in_pgd() to
> mention the level thing. Maybe it's a chance to do that.
> 
> ===1>
> *
>  * Lookup the page table entry for a virtual address. Return a pointer
>  * to the entry and the level of the mapping.
>  *
>  * Note: We return pud and pmd either when the entry is marked large
>                    ~~~~~~~~~~~ seems we return p4d too
>  * or when the present bit is not set. Otherwise we would return a
>  * pointer to a nonexisting mapping.
>               ~~~~~~~~~~~~~~~ NULL?
>  */                          
> pte_t *lookup_address(unsigned long address, unsigned int *level)
> {
>         return lookup_address_in_pgd(pgd_offset_k(address), address, level);
> }
> EXPORT_SYMBOL_GPL(lookup_address);
> ===
> 
> ===2>
> /*
>  * Lookup the page table entry for a virtual address in a specific pgd.
>  * Return a pointer to the entry and the level of the mapping.
>    ~~ also could return NULL if it's none entry. And do we need to
> mention the level thing?
>  */
> pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
>                              unsigned int *level)
> ...
> }
> 

What about this fixup:

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 3612e3167147..425ff6e192e6 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -657,7 +657,8 @@ static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long star
 
 /*
  * Lookup the page table entry for a virtual address in a specific pgd.
- * Return a pointer to the entry and the level of the mapping.
+ * Return a pointer to the entry and the level of the mapping (or NULL if
+ * the entry is none) and level of the entry.
  */
 pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
 			     unsigned int *level)
@@ -704,9 +705,8 @@ pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
  * Lookup the page table entry for a virtual address. Return a pointer
  * to the entry and the level of the mapping.
  *
- * Note: We return pud and pmd either when the entry is marked large
- * or when the present bit is not set. Otherwise we would return a
- * pointer to a nonexisting mapping.
+ * Note: the function returns p4d, pud and pmd either when the entry is marked
+ * large or when the present bit is not set. Otherwise it returns NULL.
  */
 pte_t *lookup_address(unsigned long address, unsigned int *level)
 {
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
