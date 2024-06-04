Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E11C27C52
	for <kexec@archiver.kernel.org>; Tue,  4 Jun 2024 16:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2kWlqIHpmku9idCkopYXuo3LaRqHEhiXLscv2Jors5Y=; b=1QM7hW37ltTu9R
	A4g8tCEGFHKD4ihy7MnXIIWm3JE2o6z4/Ua6yjCsOJn0FTbd3i5i0//LYoRe8EJ4pIQIM+aAT41LR
	FOS8QIsnPgwc18nFbEILrvn2YJd0VTdvoRyWbJfBbijYUTeebPjpJNNIM1J4htdN7OaiaGgtW7YiM
	CKcA9xVx3soSGgTXWfkJ7PHwjK+3Bx8q2WEAWJ3VIrcvx59TDF6YrDSl95KdIRZQCebattjHoqgVW
	gVfZ6WZ5YTd2Y4VEoTiPNbNyAweUHljBz0ceONIoZd1F1bNaU56rRRkLTvt068AkQa7Y+1rGydlZX
	lnsb9y9J83MnhX4C/FJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEWp6-000000035Du-1sPa;
	Tue, 04 Jun 2024 16:15:44 +0000
Received: from mgamail.intel.com ([198.175.65.19])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEWp2-000000035CN-1zfw
	for kexec@lists.infradead.org;
	Tue, 04 Jun 2024 16:15:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717517741; x=1749053741;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FdB/ePnDZSRVgvQ6ho4nvAZLZ9MKKUp6zPgj0fsmBT0=;
  b=WtLHZuiASEMrXgjJqjQPZXl2HU2zcLDGJTTcGKZyVjMa3OgsdAD475ia
   CtL2L3j1PeKZBg+WHtBs8jq71GcXIzTL10ywFpbnDqbcHxZF6U9ZnSxgv
   dq47qaXooPFEkVnQeh8XIbOepjLUruiEbKPu6y7ASWQA9cUL0M48ZGWHZ
   Ic1veRPSHx3ozyI64xTIDHuxJ1/EAhyq5kuD61kSA64VO8qno/crNuzyt
   mZa7mVT3RATKavf75OE4Bvf70rBciaguJwBNFeDxQQo3dReNIDIvqOfoa
   vDGTFE5m/fk6A0kQebQGIJ+GVHDEXEsmoNxnaN8iqM+7mgANmka9B615f
   g==;
X-CSE-ConnectionGUID: OsBYKxsiTFGaAWB8BVuWpA==
X-CSE-MsgGUID: VldLquHXRDKjFXp0g1S4Uw==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="13919195"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="13919195"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 09:14:09 -0700
X-CSE-ConnectionGUID: 0CVQCKxPTSCYB4M9kCwP9g==
X-CSE-MsgGUID: TiJr7ixrT6GQ0MRToY57eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="37927043"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 04 Jun 2024 09:14:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 427362DC; Tue, 04 Jun 2024 19:14:00 +0300 (EEST)
Date: Tue, 4 Jun 2024 19:14:00 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, adrian.hunter@intel.com, 
	ardb@kernel.org, ashish.kalra@amd.com, bhe@redhat.com, 
	dave.hansen@linux.intel.com, elena.reshetova@intel.com, haiyangz@microsoft.com, hpa@zytor.com, 
	jun.nakajima@intel.com, kai.huang@intel.com, kexec@lists.infradead.org, 
	kys@microsoft.com, linux-acpi@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, ltao@redhat.com, mingo@redhat.com, 
	peterz@infradead.org, rafael@kernel.org, rick.p.edgecombe@intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com, tglx@linutronix.de, thomas.lendacky@amd.com, 
	x86@kernel.org
Subject: Re: [PATCHv11.1 11/19] x86/tdx: Convert shared memory back to
 private on kexec
Message-ID: <u3hg3fqc2nxsjtfugjmmzlahwriyqlebnkxrbzgrxlkj6l3k36@yd3yudglgevi>
References: <20240531151442.GMZlnpYkDCRlg1_YS0@fat_crate.local>
 <20240602142303.3263551-1-kirill.shutemov@linux.intel.com>
 <20240603083754.GAZl2A4uXvVB5w4l9u@fat_crate.local>
 <noym2bqgxqcyhhdzoax7gvdfzhh7rtw7cv236fhzpqh3wqf76e@2jj733skv7y4>
 <78d33a31-0ef2-417b-a240-b2880b64518e@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <78d33a31-0ef2-417b-a240-b2880b64518e@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_091540_585784_204D9F0A 
X-CRM114-Status: GOOD (  26.54  )
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

On Tue, Jun 04, 2024 at 08:47:22AM -0700, Dave Hansen wrote:
> On 6/4/24 08:32, Kirill A. Shutemov wrote:
> > What about the comment below?
> > 
> > 			/*
> > 			 * One possible reason for the failure is if kexec raced
> > 			 * with memory conversion. In this case shared bit in
> > 			 * page table got set (or not cleared) during
> > 			 * shared<->private conversion, but the page is actually
> > 			 * private. So this failure is not going to affect the
> > 			 * kexec'ed kernel.
> > 			 *
> > 			 * The only thing one can do at this point on failure
> > 			 * at this point is panic. In absence of better options,
> > 			 * it is reasonable to proceed, hoping the failure is a
> > 			 * benign shared bit mismatch due to the race.
> > 			 *
> > 			 * Also, even if the failure is real and the page cannot
> > 			 * be touched as private, the kdump kernel will boot
> > 			 * fine as it uses pre-reserved memory. What happens
> > 			 * next depends on what the dumping process does and
> > 			 * there's a reasonable chance to produce useful dump
> > 			 * on crash.
> > 			 *
> > 			 * Regardless, the print leaves a trace in the log to
> > 			 * give a clue for debug.
> > 			 */
> 
> It's rambling too much for my taste.
> 
> Let's boil this down to what matters:
> 
>  1. Failures to change encryption status here can lead a future kernel
>     to touch shared memory with a private mapping
>  2. That causes an immediate unrecoverable guest shutdown (right?)

Right.

>  3. kdump kernels should not be affected since they have their own
>     memory ranges and its encryption status is not being tweawked here
>  4. The pr_err() may help make some sense out of #2 when it happens
> 
> I'm not sure the reason behind the failed conversion is important here.

The important part is that failure can be benign. It explains "can" in #1.
But okay.

> I wouldn't mention panic().
> 
> We don't need to opine about what the next kernel might or might not do.

Is this any better?

			/*
			 * If tdx_enc_status_changed() fails, it leaves memory
			 * in an unknown state. If the memory remains shared,
			 * it can result in an unrecoverable guest shutdown on
			 * the first accessed through a private mapping.
			 *
			 * The kdump kernel boot is not impacted as it uses
			 * a pre-reserved memory range that is always private.
			 * However, gathering crash information could lead to
			 * a crash if it accesses unconverted memory through
			 * a private mapping.
			 *
			 * pr_err() may assist in understanding such crashes.
			 */
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
