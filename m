Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7732DC02198
	for <kexec@archiver.kernel.org>; Fri, 14 Feb 2025 13:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GEVklSWTc5r5f2j5K+BPDEBuXxeisEBKzVm3t5daBoU=; b=oT2q0VNBSWy9LZ8MB+C1kpuAB5
	w5TUXZ+E7m/X7jREbrFf/uNQTFp3oq1dwul1XAe7Hc2wNpliPgqsFG2BzAPZJPuaXy5pjwr61/K8J
	o5ZahtNa6srh/WVVyqdbXQTy7c/R97QFO2Rl5OIaBjFWpcvInpQ56vo+alGD8hQhccTlY7NkVTl7F
	4OSWrzX4Pfqo4ut+qDO/ZiotEwVEJMZvZdqZSFYYN9j7mN2jHJQlxSMC0Lqnl/kKBx6D7asAq/Pj/
	DV1sD350fbyA3SYlxPVRI+LhYWR4pvn1+QoZr0abtx8JRohCEGkKaVPnptjRxVUnYmXzv9WkJHdt+
	aatiiXhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiw1G-0000000F3WP-3peS;
	Fri, 14 Feb 2025 13:46:14 +0000
Received: from mgamail.intel.com ([192.198.163.13])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiw1E-0000000F3Vn-2tcc
	for kexec@lists.infradead.org;
	Fri, 14 Feb 2025 13:46:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739540773; x=1771076773;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PY9/mlFqHwOVMJ7UOaepQH+2dg6cERDBN0/nyE1KoxY=;
  b=cIqHF8MyW0d3F6bi+7NRjFN9WbsH2KyuSiLHbSPSSG4/oRltuIFtyhlu
   gA9TSmMm70zd8uK48bAuVVX+8AvbzRLDjlRKZVia5dSuHdKSML4Z9yUmj
   iZuNari0WUSBDzHsJVM3XuE+/QRbKnLfbEpK7NZsspGYY7gEpn5dbd4Hs
   AlpZ5PpNLJBOSj7NWdIrq6l6ivA9rYouSE3a9E8oBIgDoUmSe2X7CETC2
   HEKrW9+yxUxCC6Sk05QN2BJdnEGBPoGPQNT9wIgGplhHQvqDizjxJeiyX
   dkhdDipGrZgqzq1Et7LRho/bsY8qNzPtP3bS1VML+jFTR9TRAtcBi826d
   Q==;
X-CSE-ConnectionGUID: Xmz95AUtTkGxXnmDosX1DQ==
X-CSE-MsgGUID: K9plHa7uQa6Hut42IXYJyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="43126939"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="43126939"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 05:46:11 -0800
X-CSE-ConnectionGUID: tVeG+U/QTpm59KusxwXGrg==
X-CSE-MsgGUID: 6CjZHkbRRJmRgIf+bHyq4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117588180"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 14 Feb 2025 05:46:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 6F87E33D9; Fri, 14 Feb 2025 15:46:06 +0200 (EET)
Date: Fri, 14 Feb 2025 15:46:06 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, 
	Baoquan He <bhe@redhat.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, 
	akpm@linux-foundation.org, kexec@lists.infradead.org, Yan Zhao <yan.y.zhao@intel.com>, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, x86@kernel.org, 
	rick.p.edgecombe@intel.com, security@kernel.org
Subject: Re: [PATCH v2 0/1] Accept unaccepted kexec segments' destination
 addresses
Message-ID: <fslhdizolr4twqm4ixevzj6ai5l5qg6mxky25jasn3yctsnvt4@hpwphlmfs5cp>
References: <20241213094930.748-1-yan.y.zhao@intel.com>
 <xgycziy2o56hnom3oau7sbqed3meoni3razc6njj7ujatldnmm@s7odbl4splbn>
 <Z4T1G4dwzo7qdwSP@MiWiFi-R3L-srv>
 <87zfjuoj3i.fsf@email.froward.int.ebiederm.org>
 <f38f1b56-a5df-4644-be59-56c70499ed92@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f38f1b56-a5df-4644-be59-56c70499ed92@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250214_054612_746897_AA3CF83F 
X-CRM114-Status: GOOD (  37.95  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Thu, Feb 13, 2025 at 07:55:15AM -0800, Dave Hansen wrote:
> On 1/13/25 06:59, Eric W. Biederman wrote:
> ...
> > I have a new objection.  I believe ``unaccepted memory'' and especially
> > lazily initialized ``unaccepted memory'' is an information leak that
> > could defeat the purpose of encrypted memory.  For that reason I have
> > Cc'd the security list.  I don't know who to CC to get expertise on this
> > issue, and the security list folks should.
> > 
> > Unless I am misunderstanding things the big idea with encrypted
> > memory is that the hypervisor won't be able to figure out what you
> > are doing, because it can't read your memory.
> 
> At a super high level, you are right. Accepting memory tells the
> hypervisor that the guest is _allocating_ memory. It even tells the host
> what the guest physical address of the memory is. But that's far below
> the standard we've usually exercised in the kernel for rejecting on
> security concerns.
> 
> Did anyone on the security list raise any issues here? I've asked them
> about a few things in the past and usually I've thought that no news is
> good news.
> 
> > My concern is that by making the ``acceptance'' of memory lazy, that
> > there is a fairly strong indication of the function of different parts
> > of memory.  I expect that signal is strong enough to defeat whatever
> > elements of memory address randomization that we implement in the
> > kernel.
> 
> In the end, the information that the hypervisor gets is that the guest
> allocated _some_ page within a 4MB physical region and the time. It gets
> that signal once per boot for each region. It will mostly see a pattern
> of acceptance going top-down from high to low physical addresses.
> 
> The hypervisor never learns anything about KASLR. The fact that the
> physical allocation patterns are predictable (with or without memory
> acceptance) is one of the reasons KASLR is in place.
> 
> I don't think memory acceptance has any real impact on "memory address
> randomization". This is especially true because it's a once-per-boot
> signal, not a continuous thing that can be leveraged. 4MB is also
> awfully coarse.
> 
> > So not only does it appear to me that implementation of ``accepting''
> > memory has a stupidly slow implementation, somewhat enshrined by a bad
> > page at a time ACPI standard, but it appears to me that lazily
> > ``accepting'' that memory probably defeats the purpose of having
> > encrypted memory.
> 
> Memory acceptance is pitifully slow. But it's slow because it
> fundamentally requires getting guest memory into a known state before
> guest use. You either have slow memory acceptance as a thing or you have
> slow guest boot.
> 
> Are there any other CoCo systems that don't have to zero memory like TDX
> does? On the x86 side, we have SGX the various flavors of SEV. They all,
> as far as I know, require some kind of slow "conversion" process when
> pages change security domains.
> 
> > I think the actual solution is to remove all code except for the
> > "accept_memory=eager" code paths.  AKA delete the "accept_memory=lazy"
> > code.  At that point there are no more changes that need to be made to
> > kexec.
> 
> That was my first instinct too: lazy acceptance is too complicated to
> live and must die.
> 
> It sounds like you're advocating for the "slow guest boot" option.
> Kirill, can you remind us how fast a guest boots to the shell for
> modestly-sized (say 256GB) memory with "accept_memory=eager" versus
> "accept_memory=lazy"? IIRC, it was a pretty remarkable difference.

I only have 128GB machine readily available and posted some number on
other thread[1]:

  On single vCPU it takes about a minute to accept 90GiB of memory.

  It improves a bit with number of vCPUs. It is 40 seconds with 4 vCPU, but
  it doesn't scale past that in my setup.

I've mentioned it before in other thread:

[1] https://lore.kernel.org/all/ihzvi5pwn5hrn4ky2ehjqztjxoixaiaby4igmeihqfehy2vrii@tsg6j5qvmyrm

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

