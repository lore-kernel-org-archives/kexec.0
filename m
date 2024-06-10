Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9390C27C55
	for <kexec@archiver.kernel.org>; Mon, 10 Jun 2024 14:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iDe+E4lMLQ+2NoryU4twiVj5PGRlx1m6EKLFtIbTZDg=; b=dcJ9jNuEkWW0IO
	LifnXRd/02LYQ1FvpPOegt1l3fJ8D63jAbVx1Pag+W/b11iUiXkaEzzEICNfRVUoHgipTIBORR+Qm
	WfkVbjsR8vNllPjeUznV9R3A1IKAaDbRjghZVJ1yNN/1RGDotMkHk+rANnQ9pVEetFhsrLN83OCar
	JJHM22O6PGPyUvo5dtJgE3Hwirh+jXPKec8WW/ON1uZndsvhXw+sYnYj8m2xCQLylX35M2m8iA25Q
	NRQ9RHpKxZaPYF5mThDi+V5FS5HJKRS3QeDHZ9W92k/uCnvIjJIprapDzhWIouztjzdEs5BfhAxsL
	nVIxOVoOtm7LvvmmdQ4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGfb8-00000005KBA-2PUf;
	Mon, 10 Jun 2024 14:02:10 +0000
Received: from mgamail.intel.com ([192.198.163.16])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGfb3-00000005K7H-3Dq1
	for kexec@lists.infradead.org;
	Mon, 10 Jun 2024 14:02:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718028126; x=1749564126;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g0xcEy+pFWVYmhSOSWpyQFktSP+xBDDKruU8/KgTUqM=;
  b=lkVvX+BlHV6lzBn5ZHMonZ80x/aHmPQDCzS6ISKHi8Ey+JrO2N6/eDYJ
   g8Fx0CIdjt+mKRHKeHszzK1fRzpKjaoTBoSZjIeGDRKG+S+BZmvI6iMGb
   jmtcjxBWWGJOsPD0BSyLfMViMH1I2keBOLdLVBGjQIW8Mu72er+Zl+A0W
   IqpMlUOIMLobt+eD5Hs/01f7eOkQaY6HdnZjR72PDeNZ0j4FSHPhrCI2x
   fpwcpUI9cbIl0ZiHlQ6psg02XsmXEQEWxx9GXsRmOQn5yDnc/M3jD6pNL
   qDoz8zq6n/p6A3ZNqlumrOtgDK/o5FmzhLgZbvLym0Hq6NLohlbrzJWsT
   Q==;
X-CSE-ConnectionGUID: dyJC/OONTRe/477yQHi+zw==
X-CSE-MsgGUID: GS+IK9RAS6iGGgMog2MWNA==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="11998238"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="11998238"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 07:02:03 -0700
X-CSE-ConnectionGUID: 9ErXJ/nuQHmHPs8IKgjiRA==
X-CSE-MsgGUID: OUlS4SOxTGyzDSRbYOqyxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="39736967"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 10 Jun 2024 07:01:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id AC1CC20B; Mon, 10 Jun 2024 17:01:55 +0300 (EEST)
Date: Mon, 10 Jun 2024 17:01:55 +0300
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
Subject: Re: [PATCHv11 18/19] x86/acpi: Add support for CPU offlining for
 ACPI MADT wakeup method
Message-ID: <hidvykk3yan5rtlhum6go7j3lwgrcfcgxlwyjug3osfakw2x6f@4ohvo23zaesv>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-19-kirill.shutemov@linux.intel.com>
 <20240603083930.GNZl2BQk2lQ8WtcE4o@fat_crate.local>
 <icu4yecqfwhmbexupo4zzei4lbe5sgavsfkm27jd6t6gyjynul@c2wap3jhtik7>
 <20240610134020.GCZmcCRFxuObyv1W_d@fat_crate.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240610134020.GCZmcCRFxuObyv1W_d@fat_crate.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_070205_835394_29136456 
X-CRM114-Status: GOOD (  21.19  )
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

On Mon, Jun 10, 2024 at 03:40:20PM +0200, Borislav Petkov wrote:
> On Fri, Jun 07, 2024 at 06:14:28PM +0300, Kirill A. Shutemov wrote:
> >   I was able to address this issue by switching cpa_lock to a mutex.
> >   However, this solution will only work if the callers for set_memory
> >   interfaces are not called from an atomic context. I need to verify if
> >   this is the case.
> 
> Dunno, I'd be nervous about this. Althouth from looking at
> 
>    ad5ca55f6bdb ("x86, cpa: srlz cpa(), global flush tlb after splitting big page and before doing cpa")
> 
> I don't see how "So that we don't allow any other cpu" can't be done
> with a mutex. Perhaps the set_memory* interfaces should be usable in as
> many contexts as possible.
> 
> Have you run this with lockdep enabled?

Yes, it booted to the shell just fine. However, that doesn't prove
anything. The set_memory_* function has many obscured cases.

> > - The function __flush_tlb_all() in kernel_(un)map_pages_in_pgd() must be
> >   called with preemption disabled. Once again, I am unsure why this has
> >   not caused issues in the EFI case.
> 
> It could be because EFI does all that setup on the BSP only before the
> others have arrived but I don't remember anymore... It is more than
> a decade ago when I did this...

Are you okay with this? Disabling preemption looks strange, but I don't
see a better option.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
