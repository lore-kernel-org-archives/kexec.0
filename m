Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51DBAC48BF8
	for <kexec@archiver.kernel.org>; Thu, 22 Feb 2024 14:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SPdqvQIcGzQyWHC67oxWzJE0Rjup8wlp1fPHrStVA3g=; b=OCGk03vmyFASRy
	1Iyu5XGh9oM6lw7bsD2ZO2Wys61LuX4xTmOKqcmOSrV8RcT6qKRvTVLI15rGoUvgcDAcbfL3GDK+V
	jsnv6kzhju5KQLdv+NBVvi0y7xIdfKGhlrBqsijc2M5Yzcw+2nwqC7XCAHeIYIkLLVACfxx6WExli
	RR1wo2UA+vE5QXJVzsQ+SXokKAwx50+oX/p4IfKZ5ox+2zgshDsq49uwkZZmtI8xt6q7g1SVA+V/x
	8acGT+uT5hDDuDu9ryOEqX8bTieivjnZX9GfDzehMqd2RqBmWtvDkb+HJ0dw+nv38+nyCWv+rO6uV
	07NikV4IIxRJEuUWdoEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd9gm-00000005A9k-2Hgf;
	Thu, 22 Feb 2024 14:04:40 +0000
Received: from mgamail.intel.com ([192.198.163.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd9gj-00000005A93-22u2
	for kexec@lists.infradead.org;
	Thu, 22 Feb 2024 14:04:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708610678; x=1740146678;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E75gomph1S/AxYryUcEMcOovIP7yR0F0aFziV9Jmk+c=;
  b=lmyRUOsvu3nwglbTr1n+iRekZYk1IWVU82q5p4d/DIpgzFM72FL/KAzT
   TzrOWv/K0Sq/ZgMSRaaDYft6nA81Im9yPMELfgSo8Aje3Q5QXKrLmpJpr
   4ORn/QjFP8tOpZx0BLIH127t887HRjp7iIIn6WOdzT6Ovhkm6pSMGQYQq
   jhR7ZVfRFu9NAmN/cJ6W5YqtneacuIpEISZjVMtYXDrzyxpUJPLNWVp5a
   DiIQ1IAZUhAOZUyTYlhPMz6dCQmC1zjdJvsF8S7s2N6UgDW7E12XIusn4
   +1vEwdYWpUbqeviDzN7+jyKbZ13aU0RpMX5eN3Wgp27kUkwUBi0GlwehO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="6613719"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="6613719"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 06:04:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="936853749"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="936853749"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 22 Feb 2024 06:04:18 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 353C1458; Thu, 22 Feb 2024 16:04:17 +0200 (EET)
Date: Thu, 22 Feb 2024 16:04:17 +0200
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
Message-ID: <k33hshbceai3tb7qe6id6kx3iqf7kjhlyvdijvmuf6knv32krs@kwo3m7dkn5sm>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-8-kirill.shutemov@linux.intel.com>
 <ZdLjQCaxhOnR+GzX@MiWiFi-R3L-srv>
 <zhbhgq27kjrhkdgbxomjykjez2i4hckguvmxyptvfvoftue5ca@zowl5qbl6psl>
 <ZdR+JzfHjES3zytp@MiWiFi-R3L-srv>
 <ic4v3q4muffjq2jhlkk3k4lg5xxvjwlw22hctzubl5573euzu2@er3m7ztog2a6>
 <ZdVh6efExdt687YY@MiWiFi-R3L-srv>
 <p34d7e5r3gkcj2xl5jycyldvpkmcllmhzioaqcmseeugl3eq73@plk43dd4luzu>
 <ZdcplT8Xb5eevu/9@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZdcplT8Xb5eevu/9@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240222_060437_572132_84D6EA50 
X-CRM114-Status: GOOD (  20.86  )
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

On Thu, Feb 22, 2024 at 07:01:41PM +0800, Baoquan He wrote:
> On 02/21/24 at 04:15pm, Kirill A. Shutemov wrote:
> > On Wed, Feb 21, 2024 at 10:37:29AM +0800, Baoquan He wrote:
> > > > diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> > > > index 3612e3167147..425ff6e192e6 100644
> > > > --- a/arch/x86/mm/pat/set_memory.c
> > > > +++ b/arch/x86/mm/pat/set_memory.c
> > > > @@ -657,7 +657,8 @@ static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long star
> > > >  
> > > >  /*
> > > >   * Lookup the page table entry for a virtual address in a specific pgd.
> > > > - * Return a pointer to the entry and the level of the mapping.
> > > > + * Return a pointer to the entry and the level of the mapping (or NULL if
> > > > + * the entry is none) and level of the entry.
> > >                        ^ this right parenthesis may need be moved to the end.
> > > 
> > > 
> > > =======
> > >  * Return a pointer to the entry and the level of the mapping (or NULL if
> > >  * the entry is none and level of the entry).
> > > =======
> > 
> > Emm.. I like my variant more. We return level regardless if the entry none
> > or not. I don't see a reason to repeat it twice.
> 
> 
>  * Lookup the page table entry for a virtual address in a specific pgd.
>  * Return a pointer to the entry and the level of the mapping (or NULL if
>  * the entry is none) and level of the entry.
> 
> Hmm, I am confused. Why do we need to stress the level of the mapping
> and level of the entry? Wondering what is the difference. I must miss
> something.

My bad. This is way I meant to write:

 * Lookup the page table entry for a virtual address in a specific pgd.
 * Return a pointer to the entry (or NULL if the entry does not exist) and
 * the level of the entry.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
