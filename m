Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B251C25B76
	for <kexec@archiver.kernel.org>; Wed,  5 Jun 2024 12:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+WeCiSe659XXwj5U5x6EYOXehn9wKwS7GdFZ/z7JgwQ=; b=VwnGmEcFyUUotC
	V9nvBoCJv6TdKCb0UhKFd3wIfefwfqOXxHUQeQPUV7VyV6KpIPtjd4ep9PKdK5/T1eJKx6fHp7JuT
	xUXVHZUbGLTYvdALSNysrZ9hOlOmRiClGcOikLitHoprINNHdiMYJcD7q2eN9b4zg5xYf6ufw6gLF
	RorlPayB7bx5PqPPY+su8fruWlOFhqg2fYeJT/ZuXD8t4cGPIc3KkITQfgzXbiMSsyl3gfhKpxexu
	ctdFF5rqxJjbTrvCMO8Fd1QSCi9lyo5TdLJAyS5TocRhoVez/s/cBR54pQkIanGuqHDWVs4uWBf7t
	BQBf++OF9/bPJ/KDuxCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEpeN-00000005xoZ-22yB;
	Wed, 05 Jun 2024 12:21:55 +0000
Received: from mgamail.intel.com ([192.198.163.19])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEpeJ-00000005xlu-3rsM
	for kexec@lists.infradead.org;
	Wed, 05 Jun 2024 12:21:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717590112; x=1749126112;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UHHCuXxgr4YI01SKxX+c/bFPiTRBKJKPTARrf8CN9LM=;
  b=kjfbDQ1uh0JBK5ZsDI1MjXmv4q22vbkC7BFNN3vxJSjEduuo4RdcWjRE
   WZSFgA32clb2QeY1ow7KDxZbobDm8D9zY2w5/BXy4HrZJg9qdPbujwhMe
   E879oljGRZdxHu9UZdzsCuGI/Hzi46T9bJyV23y3LBMk24wHiEciMdjGr
   zgBzVZew1ecmAGdiGHoDKIXzBC8nrCjIUMCr+DodheLdSnLZzT0PUAL9m
   7e5MI1+BX38Dhz3+rUoYN4YdFdHllUr3AVjvizwMzUUWc8bpu51qdrTRx
   4iUoC4pssZcVeMMxtE2oJumZ7xNNunj4lbIrVWZnC7shVMoUd5Pbfmknb
   g==;
X-CSE-ConnectionGUID: ofb42qNqRxecUZIAYmFDKw==
X-CSE-MsgGUID: Yef0TEJ0Qyu/AaZeg4viYQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="13998769"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="13998769"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 05:21:49 -0700
X-CSE-ConnectionGUID: CApkPYYZQBC0yiDEy7bMSw==
X-CSE-MsgGUID: 1fIP69SpRjaarDLU3PYGpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="68714614"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 05 Jun 2024 05:21:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 5E1A81B6; Wed, 05 Jun 2024 15:21:42 +0300 (EEST)
Date: Wed, 5 Jun 2024 15:21:42 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>, adrian.hunter@intel.com, 
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
Message-ID: <alkew673cceojzmhsp3wj43yv76cek5ydh2iosfcphuv6ro26q@pj6whxcoetht>
References: <20240531151442.GMZlnpYkDCRlg1_YS0@fat_crate.local>
 <20240602142303.3263551-1-kirill.shutemov@linux.intel.com>
 <20240603083754.GAZl2A4uXvVB5w4l9u@fat_crate.local>
 <noym2bqgxqcyhhdzoax7gvdfzhh7rtw7cv236fhzpqh3wqf76e@2jj733skv7y4>
 <78d33a31-0ef2-417b-a240-b2880b64518e@intel.com>
 <u3hg3fqc2nxsjtfugjmmzlahwriyqlebnkxrbzgrxlkj6l3k36@yd3yudglgevi>
 <20240604180554.GIZl9XgscEI3PUvR-W@fat_crate.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240604180554.GIZl9XgscEI3PUvR-W@fat_crate.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_052152_021181_BC0919DF 
X-CRM114-Status: GOOD (  16.35  )
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

On Tue, Jun 04, 2024 at 08:05:54PM +0200, Borislav Petkov wrote:
> On Tue, Jun 04, 2024 at 07:14:00PM +0300, Kirill A. Shutemov wrote:
> > 			/*
> > 			 * If tdx_enc_status_changed() fails, it leaves memory
> > 			 * in an unknown state. If the memory remains shared,
> > 			 * it can result in an unrecoverable guest shutdown on
> > 			 * the first accessed through a private mapping.
> 
> "access"

Okay.

> So this sentence above can go too, right?

I don't think so.

> Because that comment is in tdx_kexec_finish() and we're basically going
> off to kexec. So can a guest even access it through a private mapping?
> We're shutting down so nothing is running anymore...

This kernel can't. But the next kernel can.

If a page can be accessed via private mapping is determined by the
presence in Secure EPT. This state persist across kexec.

> > 			 * The kdump kernel boot is not impacted as it uses
> > 			 * a pre-reserved memory range that is always private.
> > 			 * However, gathering crash information could lead to
> > 			 * a crash if it accesses unconverted memory through
> > 			 * a private mapping.
> 
> When does the kexec kernel even get such a private mapping? It is not
> even up yet...

Crash kernel provides access to this memory via /proc/vmcore. Crash kernel
will assume all memory there is private.

> > 			 * pr_err() may assist in understanding such crashes.
> 
> "Print error info in order to leave bread crumbs for debugging." is what
> I'd say.

Okay.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
