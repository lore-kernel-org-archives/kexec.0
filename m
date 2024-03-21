Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B593C54E58
	for <kexec@archiver.kernel.org>; Thu, 21 Mar 2024 14:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Kze3zMIzp3S1dPl425sIgCBhJO16aFmJk44AM7VFIuA=; b=2N3xa6MK79tOhw
	WgVzH5yZ8jJXD4DpGl7CyCSmxEGV603JWXbOD644danjeGrDmvMGKnmBNyvNSW6s711tBltUgvORu
	lXTf/kmz44FIcXPdXCSqIchqMxy9Ro1kIhZeFakg0EwAk9pwMLCUoqKPLLwKtrEqbaj4h6HQaMAe6
	UkfXyikGOkw1Yua2aea8zN1Ix98JUoheMj/buTsxAEFomZ4Z9xRCER2gNBgl/qbjzYdyqMsMuUXoZ
	qvn+tdzWSn0TMzAusbB39SS+QUJJe0Q8jhIllH7pyZSirRNG/mjSUrYeQy53ihY5AjzeCKfE4I6bs
	OVkhBcpTV8xkGWu+bKlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnJso-00000003NIF-1trO;
	Thu, 21 Mar 2024 14:59:06 +0000
Received: from mgamail.intel.com ([192.198.163.17])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnJsk-00000003NFe-2Mwj
	for kexec@lists.infradead.org;
	Thu, 21 Mar 2024 14:59:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711033142; x=1742569142;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7eBq8ekEO6vw2vSin9bneMav1VFWO6ZkBD957BgambQ=;
  b=nVylfvqbD8TC8HWyJswsKqbAPFO3TC51KuEd9OPPn9kNQ/kB+JjEgSn/
   3FVpLtsS0LFz8K/0lp0y/sBuNSolDQG3VCXdBwJXYlRufcxgaqHTNhmkp
   BHq2z7prMvZm4tb4xZz817DX8RuNyhBbxZHqpyWrOY6ElKDvPl4/l1syR
   CYqvfLsGNa4KJsGfG92Wjiry/0MhfFy+HLlFFe/4DISFbf1wPaYNrKZRR
   btiCT1G2Mg7IJIbDcCPk21BaB0bHvmyjZGWeCBwuY7PEyOnBKUOYziPfj
   +WYPVbPrxNDMxT41BKp/KxVoo04PFBnV605jf/pDvJxB9ApNybNrLp6qh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="5879071"
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="5879071"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 07:58:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="937065372"
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="937065372"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 21 Mar 2024 07:58:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 7C090791; Thu, 21 Mar 2024 16:58:52 +0200 (EET)
Date: Thu, 21 Mar 2024 16:58:52 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com, 
	rafael@kernel.org, peterz@infradead.org, adrian.hunter@intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, elena.reshetova@intel.com, jun.nakajima@intel.com, 
	rick.p.edgecombe@intel.com, thomas.lendacky@amd.com, seanjc@google.com, michael.roth@amd.com, 
	kai.huang@intel.com, bhe@redhat.com, kexec@lists.infradead.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, bdas@redhat.com, 
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com, jroedel@suse.de
Subject: Re: [PATCH v2 2/3] x86/mm: Do not zap page table entries mapping
 unaccepted memory table during kdump.
Message-ID: <opa56dnwlyllrrnlfrhtbavnwmhxxatiuzifvx3bquv5qksidn@v2qxrvvw53jl>
References: <20240227212452.3228893-1-kirill.shutemov@linux.intel.com>
 <cover.1710744412.git.ashish.kalra@amd.com>
 <8e11825bb3e4a7472bf0cb30c72ae013c25ac8c9.1710744412.git.ashish.kalra@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8e11825bb3e4a7472bf0cb30c72ae013c25ac8c9.1710744412.git.ashish.kalra@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240321_075902_652389_2EAA8107 
X-CRM114-Status: GOOD (  15.57  )
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

On Mon, Mar 18, 2024 at 07:02:45AM +0000, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> During crashkernel boot only pre-allocated crash memory is presented as
> E820_TYPE_RAM. This can cause page table entries mapping unaccepted memory
> table to be zapped during phys_pte_init(), phys_pmd_init(), phys_pud_init()
> and phys_p4d_init() as SNP/TDX guest use E820_TYPE_ACPI to store the
> unaccepted memory table and pass it between the kernels on
> kexec/kdump.
> 
> E820_TYPE_ACPI covers not only ACPI data, but also EFI tables and might
> be required by kernel to function properly.
> 
> The problem was discovered during debugging kdump for SNP guest. The
> unaccepted memory table stored with E820_TYPE_ACPI and passed between
> the kernels on kdump was getting zapped as the PMD entry mapping this
> is above the E820_TYPE_RAM range for the reserved crashkernel memory.
> 
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

I guess it would be better if I take this patch into my kexec patchset. I
guess I just got lucky not to step onto the issue.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
