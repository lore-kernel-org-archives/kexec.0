Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D79CAC27C77
	for <kexec@archiver.kernel.org>; Tue, 11 Jun 2024 15:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1hixORj/8eJE68dTUziHaPQ8QKfimGeSopaQG4Bzr84=; b=fp/x4PEd4vQcIQ
	+moy9Ojgy7fCnd1gOTCTZOwtxgtXcWJX7kWG0YMlu8v5TPDv1k0h/tOx4BlvORhUcUNKwfr7uh7IA
	oTRbqPF+PbSc/JQyM2bzREkvCfbEbdDXydwtriipKHPBhVY8wGr1AhsBI//A5oe3thQSREAxBluyU
	qLzC9QF/9wrCai7o/n49GkzVmqoYBgcIJt0tKDRAJpp2qOjla+CYnGpyk85ln2Lv6lMx0jtZ7Bes1
	Rpk6aC6Dd1bQ4mPt58UZbUsBqPpjqVhyxvr9mDreZGgcEzC/KL5KbSkDv4+1wD3G5pEkXDqne4epf
	9WcP8lKYuMYd+c0FHVjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH3iR-00000009O4F-0k9x;
	Tue, 11 Jun 2024 15:47:19 +0000
Received: from mgamail.intel.com ([198.175.65.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH3iM-00000009O32-3fuD
	for kexec@lists.infradead.org;
	Tue, 11 Jun 2024 15:47:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718120835; x=1749656835;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TX63nz8clG540zRkwgoV3FmdB4+YRQdt53SWeHOoP00=;
  b=dSI1U8v4bzrc7Wwo+0fe9SAf0hTGI00cEXnQN9yp/ba3U71p+zHov0L7
   yitjD5EsoduZdRhNxO7kTGGnl9r/XXziDPUoRq90gxzUr4rXW3HGHiZSw
   vLm0L+6Ihx+gwJKF7xH5uQHNSg3oNvuZPdQ8GT0j9npIgLg6gMv8IerR7
   V+2jUshLVn96xyWp6fCFhzSklzzqd70DhQXpXQgRBftpLMl0Qxb0c6fg5
   IezuD22x02m1WAC7FTfuItKR0klvBSXXOtiWDP5E/VNofM0m+qIwk/RvC
   FjiuvfmLqEzTnoPFDUv15l7Sf/emkd91L5BpcN2LeYLhAoaxCyKQxlhEp
   Q==;
X-CSE-ConnectionGUID: up9DXpIxTEiA4tipgIJUQg==
X-CSE-MsgGUID: l/9jRu4wSCO2RnstGZLRMw==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="25419710"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="25419710"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 08:47:13 -0700
X-CSE-ConnectionGUID: MtakBbo6Q/Wi2hPQzssvAQ==
X-CSE-MsgGUID: 9gL7YP+hS4+lRn7WhutdGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="76942409"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 11 Jun 2024 08:47:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 6E61F169; Tue, 11 Jun 2024 18:47:05 +0300 (EEST)
Date: Tue, 11 Jun 2024 18:47:05 +0300
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
Message-ID: <nh7cihzlsjtoddtec6m62biqdn62k3ka5svs6m64qekhpebu5z@dkplwad2urgp>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-19-kirill.shutemov@linux.intel.com>
 <20240603083930.GNZl2BQk2lQ8WtcE4o@fat_crate.local>
 <icu4yecqfwhmbexupo4zzei4lbe5sgavsfkm27jd6t6gyjynul@c2wap3jhtik7>
 <20240610134020.GCZmcCRFxuObyv1W_d@fat_crate.local>
 <hidvykk3yan5rtlhum6go7j3lwgrcfcgxlwyjug3osfakw2x6f@4ohvo23zaesv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <hidvykk3yan5rtlhum6go7j3lwgrcfcgxlwyjug3osfakw2x6f@4ohvo23zaesv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_084714_993819_1793CAB5 
X-CRM114-Status: GOOD (  27.16  )
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

On Mon, Jun 10, 2024 at 05:01:55PM +0300, Kirill A. Shutemov wrote:
> On Mon, Jun 10, 2024 at 03:40:20PM +0200, Borislav Petkov wrote:
> > On Fri, Jun 07, 2024 at 06:14:28PM +0300, Kirill A. Shutemov wrote:
> > >   I was able to address this issue by switching cpa_lock to a mutex.
> > >   However, this solution will only work if the callers for set_memory
> > >   interfaces are not called from an atomic context. I need to verify if
> > >   this is the case.
> > 
> > Dunno, I'd be nervous about this. Althouth from looking at
> > 
> >    ad5ca55f6bdb ("x86, cpa: srlz cpa(), global flush tlb after splitting big page and before doing cpa")
> > 
> > I don't see how "So that we don't allow any other cpu" can't be done
> > with a mutex. Perhaps the set_memory* interfaces should be usable in as
> > many contexts as possible.
> > 
> > Have you run this with lockdep enabled?
> 
> Yes, it booted to the shell just fine. However, that doesn't prove
> anything. The set_memory_* function has many obscured cases.
> 
> > > - The function __flush_tlb_all() in kernel_(un)map_pages_in_pgd() must be
> > >   called with preemption disabled. Once again, I am unsure why this has
> > >   not caused issues in the EFI case.
> > 
> > It could be because EFI does all that setup on the BSP only before the
> > others have arrived but I don't remember anymore... It is more than
> > a decade ago when I did this...
> 
> Are you okay with this? Disabling preemption looks strange, but I don't
> see a better option.

Borislav, given this code deduplication effort is not trivial, maybe we
can do it as a separate patchset on top of this one?

I also wounder if it makes sense to combine ident_map.c and set_memory.c.
There's some overlap between the two.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
