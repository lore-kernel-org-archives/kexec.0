Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798B5C48BF8
	for <kexec@archiver.kernel.org>; Thu, 22 Feb 2024 10:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=40C+O+uUkZmPuz1hixdGAe26V/iBHT3tBFcidCMuzeY=; b=B/Dw2+rHi5dcGI
	LzyQnXmZBQbZVwATFbOeluJwwCLyLaEJSsBe1xEfVqwtNAn09jFUfXVYDRZ5Y3VxlO7/PH20O8Ud5
	JAjs6rYBG6UGYO0aLd/SC4IugQ62iMltjAoTQDbKMOxBj366lSorYxkFyK8+VrdGL9PZS8JR1/x3t
	N7h0Uacyz6sEnzz1vXAj5WkTTu5m8hQLcrvFbjcXZnG5SfMfyqy2aFv4E/BoftDMRzclTDhTZHeil
	UXCJQKKp0ImdflKcgUOvmQTsjZsei8s+Mhbfjd74hl/PYUeu7UwRpHGNjsVzhHiFG2jpgY6fJZU3F
	5BsOOfUwQUZlsJCE6DUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd6em-00000004XqI-1KdZ;
	Thu, 22 Feb 2024 10:50:24 +0000
Received: from mgamail.intel.com ([192.198.163.10])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd6ej-00000004XpB-17l8
	for kexec@lists.infradead.org;
	Thu, 22 Feb 2024 10:50:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708599021; x=1740135021;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MlCX4WJP2SCKY4u/hH+Za0aayaGTr+j+qDw+YgB04Vc=;
  b=SPWqyZAh5fwmniuFaxYiRDyTcApicoq1q44bFHOA4a79LOD5ttYIbkeC
   DR94rmCclp/ruRL8d7Il1DoXHRvFJw2sgwnza3vOy87iY2FwUoC77jPtU
   5wTRsQRkyrv76EdefRk6Y5ZVSUQm5GdAaPRfDec7KQnV6ZB9R+03+Cb0R
   oTb+1lds/2RSzm/mQrXXOG0iJuaKYgfexWvLWwZIkB+s7jYE/9b5VZkam
   8HCgLgAjleTC5n3KMgb85YVZqPmV5V45vePxmp1RXIBaMvrKbh+XWCVQc
   qPHyIYVklgxN8g0QyFzhXrQz3eW0v8R5tCMTv/F1cwk+p2aFwNhLPKCcK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="14232497"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="14232497"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 02:50:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="936832910"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="936832910"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 22 Feb 2024 02:50:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id EB8B42AB; Thu, 22 Feb 2024 12:50:11 +0200 (EET)
Date: Thu, 22 Feb 2024 12:50:11 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Ashish Kalra <Ashish.Kalra@amd.com>, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, luto@kernel.org, 
	x86@kernel.org, ardb@kernel.org, hpa@zytor.com, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rafael@kernel.org, peterz@infradead.org, adrian.hunter@intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, elena.reshetova@intel.com, jun.nakajima@intel.com, 
	rick.p.edgecombe@intel.com, seanjc@google.com, kai.huang@intel.com, bhe@redhat.com, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, anisinha@redhat.com, 
	michael.roth@amd.com, bdas@redhat.com, vkuznets@redhat.com, dionnaglaze@google.com, 
	jroedel@suse.de, ashwin.kamat@broadcom.com
Subject: Re: [PATCH 2/2] x86/snp: Convert shared memory back to private on
 kexec
Message-ID: <amk4ozai3l65d6ef3k2rsnapaislbvlwpfx7p35tqqhesmc4w7@5vmi52a3qv3o>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <cover.1708390906.git.ashish.kalra@amd.com>
 <aa633d7439885da7e54c41db07d65f8e177bcf51.1708390906.git.ashish.kalra@amd.com>
 <97a7d69f-03e1-4ecc-a0ce-10bfe148509c@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <97a7d69f-03e1-4ecc-a0ce-10bfe148509c@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240222_025021_351150_B3B504D0 
X-CRM114-Status: GOOD (  14.50  )
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

On Wed, Feb 21, 2024 at 02:35:13PM -0600, Tom Lendacky wrote:
> > @@ -906,6 +917,206 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
> >   	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
> >   }
> > +static inline bool pte_decrypted(pte_t pte)
> > +{
> > +	return cc_mkdec(pte_val(pte)) == pte_val(pte);
> > +}
> > +
> 
> This is duplicated in TDX code, arch/x86/coco/tdx/tdx.c, looks like
> something that can go in a header file, maybe mem_encrypt.h.
> 

I think <asm/pgtable.h> is a better fit.

> > +void snp_kexec_stop_conversion(bool crash)
> > +{
> > +	/* Stop new private<->shared conversions */
> > +	conversion_allowed = false;
> > +	crash_requested = crash;
> > +
> > +	/*
> > +	 * Make sure conversion_allowed is cleared before checking
> > +	 * conversions_in_progress.
> > +	 */
> > +	barrier();
> 
> This should be smp_wmb().
> 

Why?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
