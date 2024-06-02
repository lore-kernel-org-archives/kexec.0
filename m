Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C3B1C25B7E
	for <kexec@archiver.kernel.org>; Sun,  2 Jun 2024 14:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hSrxAsFva0fY0tGRe0W4wOZJqbUk7nFt3WgkxnYP33I=; b=WOJrbg73mcYUf9
	Bz95mXhl/RDVMm5B00SYCmTcZixc4CSQ1+vsc5X3/HaNo/75An8Qex+WwlaXij3X/NYS56ClU9joe
	79N4tJObL8Fj9R9/KjXWdSGRgdJYHpBLntubqvIIwSMGYdIbrQW/rNYNL4kVJOp4Lr+y6VwvRoSQr
	9br+6aGJ3tFj6m4Yd1WaG17gVrEfXruBw0mnx44nGpVVl1WSPjZLUIuKa8VXIZT3SEu/1CUydBiyM
	Y2IVIkqdunci0R5qRSm42eojH+WPS7LMUWGPU2co1bSaUKMkvVnH2nljCJD64Juqc4NVUbMNEA1FN
	2eyEPBfCMtYHiTkGyDXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDm54-0000000EOhM-41wk;
	Sun, 02 Jun 2024 14:21:06 +0000
Received: from mgamail.intel.com ([198.175.65.15])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDm52-0000000EOgU-1wW0
	for kexec@lists.infradead.org;
	Sun, 02 Jun 2024 14:21:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717338064; x=1748874064;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HHQSybEJxUEGfYcVhVIrgQp0w28pkdQd7EvfJc/M9y4=;
  b=NMwIrjgsL04ZFLkKjeteLbJzMG5Lslxtnw0oUGWbSRmfq5FY/lgHHr/p
   7xpP4T7yftWGA8Rh6w/XavJDHN93FsID8uqfsgyHQUUhcKO+YTdLjjg8P
   luR3O8V5IwZ+W3CaMrOa/PftWhmdO/V+LPiL2q6mldd8IGev1bdEHMEqs
   ABUNrXlwtgCb9gpIoEOTcHUxrIKXrY8WSdGzCn9odB5+Rrg0OilY+dyBM
   4TJenxfGupigvoGrjgrEH7ypF8vBVzc5pQQwwP8VJpWrW+kZBYWenp7re
   TNwfGg81XP4F+qWT/VZVcsQoY78x8wp2wV+/k+jC8cmRJEA8LgxZUXFxj
   Q==;
X-CSE-ConnectionGUID: U/Ui9y6bSiSp4fPuk1Ubiw==
X-CSE-MsgGUID: m9pM94drQs2npKz8iFxACw==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="17629010"
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; 
   d="scan'208";a="17629010"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2024 07:21:02 -0700
X-CSE-ConnectionGUID: ke8Ahaw5T768IbxDwu8Qog==
X-CSE-MsgGUID: wlmiIkyFSpy2c6mxIJT/Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; 
   d="scan'208";a="36560562"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 02 Jun 2024 07:20:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id B8B441CB; Sun, 02 Jun 2024 17:20:54 +0300 (EEST)
Date: Sun, 2 Jun 2024 17:20:54 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, 
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
Message-ID: <tur63s5trxwwnwfs43f4jcc6pfostpw6cchwhrgo7tsfzicozn@mvqrntyi6x4w>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-12-kirill.shutemov@linux.intel.com>
 <20240531151442.GMZlnpYkDCRlg1_YS0@fat_crate.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240531151442.GMZlnpYkDCRlg1_YS0@fat_crate.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240602_072104_608905_DE6829D5 
X-CRM114-Status: GOOD (  19.33  )
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

On Fri, May 31, 2024 at 05:14:42PM +0200, Borislav Petkov wrote:
> On Tue, May 28, 2024 at 12:55:14PM +0300, Kirill A. Shutemov wrote:
> > +static void tdx_kexec_finish(void)
> > +{
> > +	unsigned long addr, end;
> > +	long found = 0, shared;
> > +
> > +	lockdep_assert_irqs_disabled();
> > +
> > +	addr = PAGE_OFFSET;
> > +	end  = PAGE_OFFSET + get_max_mapped();
> > +
> > +	while (addr < end) {
> > +		unsigned long size;
> > +		unsigned int level;
> > +		pte_t *pte;
> > +
> > +		pte = lookup_address(addr, &level);
> > +		size = page_level_size(level);
> > +
> > +		if (pte && pte_decrypted(*pte)) {
> > +			int pages = size / PAGE_SIZE;
> > +
> > +			/*
> > +			 * Touching memory with shared bit set triggers implicit
> > +			 * conversion to shared.
> > +			 *
> > +			 * Make sure nobody touches the shared range from
> > +			 * now on.
> > +			 */
> > +			set_pte(pte, __pte(0));
> > +
> 
> Format the below into a comment here:
> 
> /* 
> 
> The only thing one can do at this point on failure is panic. It is
> reasonable to proceed, especially for the crash case because the
> kexec-ed kernel is using a different page table so there won't be
> a mismatch between shared/private marking of the page so it doesn't
> matter.

Page tables would not make a difference here. We will switch to identity
mappings soon. And kexec-ed kernel will build new page tables from
scratch.

I will drop the part after "It is reasonable to proceed".


-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
