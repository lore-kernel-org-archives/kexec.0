Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A7FC04FFE
	for <kexec@archiver.kernel.org>; Wed,  8 May 2024 13:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5xbZqLxZk5zMBDZa+Dvo+QgbOZHAAvRwNYuosgAK/iw=; b=Crwwz3wvJv+Vtj
	aJGw2wnpFnX3yNnKY5e2QGHXVj2jC/96pUKKRWZ6GFzZ96moE6N2wgH/rbRf38M7h1d0oXwOmeXRr
	FVvOfRft+HDcvu3NjwQhNKkfQ68LYbtmAgk0TP7ILX0qjPNbaF9pJbRc2JpmHZ34XJhGQfoYz5+En
	P7P3khI+iY/5N0MBSrb/SNiGX78klr2Vgv3a6zXIQliTghf+2HOqVGSq53MOqeTuavQhuMsU+YeHd
	OZwLtebS1wqMcYIPkQ1FeX8pya0eGTkzipDbUnT9ToeOhYhzgR1OkkaEKoVMt0brC7b1uRPh6Q4SJ
	J580PkSMKGTWSYj3RO5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4hNR-0000000FeKO-1fYx;
	Wed, 08 May 2024 13:30:33 +0000
Received: from mgamail.intel.com ([192.198.163.19])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4hNK-0000000FeH1-1Q5T
	for kexec@lists.infradead.org;
	Wed, 08 May 2024 13:30:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715175026; x=1746711026;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i48IC3C8a/IgdCCUP6DZhdFvfj9wyd/dBjr8ZN13+DI=;
  b=EtM0rq1BVrthP/n682wXY9A+EdY3ooDTg41ML1DKhOAWRA5pos5bMJc1
   QR3fDqxVs8SJxiQWX3uR3kDFPrzDjMlgE7qV2uWInR/m1o+BS/80pb5Hu
   Z9cB7Ykk+7OV6PHtZj1UwXsAPBfpegqNDpKgLQMjMPW5wZEL6ckbsi3SJ
   +HxNwrf/bi5Oxgd/UW7VcRo2XBIbEyyVxDs+zyQW+fj38WVyDQKihVbsx
   HX8+Xfw/aOGgQuDtQRmAufzPcx7TDkSZqJ9NZfz3yeoG3ESibE6sAvQZ1
   1UJy52BAsjTD5m6kLEJpOydFhhxSKTKLqxFkbuLY8Mca4ufazSx+ZOxAJ
   w==;
X-CSE-ConnectionGUID: AREuKdUtTmG/Yn7/xyvL3w==
X-CSE-MsgGUID: LuRM9HQGTSyGXSf1f3nSsw==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="10901576"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="10901576"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 06:30:24 -0700
X-CSE-ConnectionGUID: ccoTqbJHROK79xfMEgo2zQ==
X-CSE-MsgGUID: 1LsSkgSZSaeYLhPn+tZe6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="52096729"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 08 May 2024 06:30:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 9F34311F; Wed, 08 May 2024 16:30:17 +0300 (EEST)
Date: Wed, 8 May 2024 16:30:17 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv10 10/18] x86/tdx: Convert shared memory back to private
 on kexec
Message-ID: <6pmeqhsvkm6noue6zhg6dqu5234isfjbdgush466l2tek3elij@uw7z2ooaqy4t>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-11-kirill.shutemov@linux.intel.com>
 <20240505121319.GAZjd337gHC0uhk6aM@fat_crate.local>
 <bpmagk7v6swftzjjpchplzjwgx3pbdqzklcxybrmrhprqizk45@lxmvva42z36g>
 <20240508120422.GCZjtqRrSuJeUyByEM@fat_crate.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240508120422.GCZjtqRrSuJeUyByEM@fat_crate.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240508_063026_411963_1FCC4F30 
X-CRM114-Status: GOOD (  18.41  )
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

On Wed, May 08, 2024 at 02:04:22PM +0200, Borislav Petkov wrote:
> On Mon, May 06, 2024 at 06:37:19PM +0300, Kirill A. Shutemov wrote:
> > "second kernel" is nomenclature kexec folks are using, but okay.
> 
> And the "third kernel" is the one which got kexec-ed the second time?
> 
> You can make it: "The second, kexec-ed kernel" and then it is perfectly
> clear.

Okay.

> > One possible reason for the failure is if kdump raced with memory
> > conversion. In this case shared bit in page table got set (or not cleared
> > form shared->private conversion), but the page is actually private. So
> > this failure is not going to affect the kexec'ed kernel.
> 
> Lemme make sure I understand what you're saying here:
> 
> 1. This is a fatal failure and we should panic
> 
> However,
> 
> 2. the kexec-ed kernel is using a different page table so there won't be
>    a mismatch between shared/private marking of the page so it doesn't
>    matter
> 
> Close?

Yes.

One other point is even if the failure is real and we cannot touch the
page as private, kdump kernel will boot fine as it uses pre-reserved
memory. What happens next depends on what dumping process does. We have
reasonable chance to produce useful dump on crash.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
