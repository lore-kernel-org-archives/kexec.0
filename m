Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC08C48BC3
	for <kexec@archiver.kernel.org>; Wed, 21 Feb 2024 14:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v1zDj5SUJo23gntL2kY4pSOXy8VNgYV18pWdvUCovAY=; b=g6bnvESbInOVHG
	JElo9QrxlABWGuXUIjLwQSmByppi4cVXoGy2/kUTxFLyRu+dpHfnQ8/MteEo5Xfgc4eNqF9tmAUMc
	5fZ58SjDH03v2J1qI1UjlM7ytktYbREyoqo5fUeL/Bo4rsxcTzROlBGV8YwKBI3TDIfYnLjrtdRjd
	5389w47vi/KZ6DwdtG5PdUc2SIGsyZrPwSduGKhL5i2cnm0gYFGPl/RGVrtey4Bxhqr0TxyXHLHnd
	HvR4h73PZmJCl0cLkleuYV0OZ84wFodYU5NKQaM9ZyLL6tk6tUyXITQNKPqqBFwRTgGdVkGuHnFn5
	+0d/lX1bHJ96ceQGst/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcnNp-00000001E80-2ulC;
	Wed, 21 Feb 2024 14:15:37 +0000
Received: from mgamail.intel.com ([198.175.65.14])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcnNn-00000001E7f-2Sr3
	for kexec@lists.infradead.org;
	Wed, 21 Feb 2024 14:15:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708524935; x=1740060935;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/vYbdGx/biRaDTrw8g8KGes/oIyLAhiiHJyRW4pxB+Y=;
  b=VPXtFVidG4r9Y5CbLjcT0sa4EciJp80M4xlmtN9Sfpm6dlS9VukC/R1e
   wm/KRvWXBRlq0C0/J8QWyzVlZKNirM7jQv3pk0k6GYmmCCWFUoy+ucLuX
   w+0r74KRDbIhvXRW4z3ULuh142BDQnimSP3W6ooCQk5088p0UQ2MRUt1o
   h4OBl7LjY+1Ilw5hRIUhnZhTJ9TSr2npyqW8VAp+rdm4Lq8iOcMbW3GLL
   bd+EaFcc2abYWyV5znk9wgQZ2G/R8B/PUTF83o9CNEjzxmAus4NLS7xQi
   tKHFp8skMup+WUCNDocMQ63QEevtUo77iZky3aCzaYNXnlK8yAO3WDU30
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="6500411"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="6500411"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 06:15:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="936650868"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="936650868"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 21 Feb 2024 06:15:28 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id CEA572AB; Wed, 21 Feb 2024 16:15:27 +0200 (EET)
Date: Wed, 21 Feb 2024 16:15:27 +0200
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
Message-ID: <p34d7e5r3gkcj2xl5jycyldvpkmcllmhzioaqcmseeugl3eq73@plk43dd4luzu>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-8-kirill.shutemov@linux.intel.com>
 <ZdLjQCaxhOnR+GzX@MiWiFi-R3L-srv>
 <zhbhgq27kjrhkdgbxomjykjez2i4hckguvmxyptvfvoftue5ca@zowl5qbl6psl>
 <ZdR+JzfHjES3zytp@MiWiFi-R3L-srv>
 <ic4v3q4muffjq2jhlkk3k4lg5xxvjwlw22hctzubl5573euzu2@er3m7ztog2a6>
 <ZdVh6efExdt687YY@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZdVh6efExdt687YY@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240221_061535_682328_FF6DCD12 
X-CRM114-Status: GOOD (  19.43  )
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

On Wed, Feb 21, 2024 at 10:37:29AM +0800, Baoquan He wrote:
> > diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> > index 3612e3167147..425ff6e192e6 100644
> > --- a/arch/x86/mm/pat/set_memory.c
> > +++ b/arch/x86/mm/pat/set_memory.c
> > @@ -657,7 +657,8 @@ static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long star
> >  
> >  /*
> >   * Lookup the page table entry for a virtual address in a specific pgd.
> > - * Return a pointer to the entry and the level of the mapping.
> > + * Return a pointer to the entry and the level of the mapping (or NULL if
> > + * the entry is none) and level of the entry.
>                        ^ this right parenthesis may need be moved to the end.
> 
> 
> =======
>  * Return a pointer to the entry and the level of the mapping (or NULL if
>  * the entry is none and level of the entry).
> =======

Emm.. I like my variant more. We return level regardless if the entry none
or not. I don't see a reason to repeat it twice.

> >   */
> >  pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
> >  			     unsigned int *level)
> > @@ -704,9 +705,8 @@ pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
> >   * Lookup the page table entry for a virtual address. Return a pointer
> >   * to the entry and the level of the mapping.
> >   *
> > - * Note: We return pud and pmd either when the entry is marked large
> > - * or when the present bit is not set. Otherwise we would return a
> > - * pointer to a nonexisting mapping.
> > + * Note: the function returns p4d, pud and pmd either when the entry is marked
>                                           ~~~
>                                            ^ s/and/or/

Fair enough.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
