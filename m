Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89215C021B8
	for <kexec@archiver.kernel.org>; Tue,  4 Mar 2025 08:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kV/0qjWbyty96dULjKtf53vZUbbJqrSlizi6px4qYiI=; b=VMMfFrfecVUgdGvWGN7yqtxQmn
	1L7aEW3yrIV2vzWqZYY3FUUl2lBF4sGoIFagCn5KLPQK5teCGmNKkf4ndKB++jz9el0OpAC/HudKT
	woMy/Xftp9VTZ9i/I0tJR+zNpPVlendqSwamwtaLwsyhKYzOo/zYMR5RngW2SX9X5Xkeaie8DX/Hw
	otIWMwx/urWHyb9YS9mypFz9dyrZ3syoe/xoOarbNMUVe5zCeeK2itTnH2Es/kMtHB3grzYhojBgO
	5R9aHlYANE7Zh/6oxm02hbFJiIWcW8B30RJiwJSQbU9DGFXOhaZNhpNyGT3sWuGJ9aXMA4rsummtT
	cvjw8ovA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpNrM-00000003hGI-22pK;
	Tue, 04 Mar 2025 08:42:40 +0000
Received: from mgamail.intel.com ([192.198.163.19])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpNql-00000003h9Y-42ag
	for kexec@lists.infradead.org;
	Tue, 04 Mar 2025 08:42:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741077724; x=1772613724;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wn3ovzB8+lKMg6uUVvb3SxMyjW6zOQiHk1e5vDW0fpA=;
  b=E+u7x266VNBh8KQLpyjm/DFISh9T7IQuc6YvW6ZuXYXvpp10WSS+c+Wv
   1NwmsB3+A7URb+icXXidGEd8jOKiR6ra+NK8HbfItQA8Jv6VqWe1nyODP
   NOdw/tln9GZ6VKc3JLWWGMo2GMNtdGAIEkieik2CXZTB0EGw5zUrIjrrq
   xqopKBPhIT0J6VLZqgSvNhnA9ai2rEg78T1ErkZFngT5AI0V4f9i8AbtI
   tPlP+QkIEvyCEOodd/qIUD66dDrSxA8j8QT5JCJSyO82/H7mX5Od1gU1W
   AbjtApapdB1DwJRYXFuFZUiKQO+o7ezCM3hT7umiRnabXOd83uTdJRDRY
   A==;
X-CSE-ConnectionGUID: Q4QMdjnWRr+IDLNQHBcAag==
X-CSE-MsgGUID: LCq6uXSPR/+W86I4FJe2yQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41161498"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="41161498"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 00:42:01 -0800
X-CSE-ConnectionGUID: nlHEYB1VQ9Wkf2hsrxMr0Q==
X-CSE-MsgGUID: vyhwHtlQRaOAWtMhBkM9Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="118040854"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 04 Mar 2025 00:41:58 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 75EC718F; Tue, 04 Mar 2025 10:41:56 +0200 (EET)
Date: Tue, 4 Mar 2025 10:41:56 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: akpm@linux-foundation.org, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Baoquan He <bhe@redhat.com>, 
	"Kirill A. Shutemov" <kirill@shutemov.name>, kexec@lists.infradead.org, Yan Zhao <yan.y.zhao@intel.com>, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, x86@kernel.org, 
	rick.p.edgecombe@intel.com, security@kernel.org
Subject: Re: [PATCH v2 0/1] Accept unaccepted kexec segments' destination
 addresses
Message-ID: <wk7tfjqtpzgmsvilgszlgqnqjgm5kg2vfxboaspd3qyfs6uqb3@nbgacwb3kcb6>
References: <20241213094930.748-1-yan.y.zhao@intel.com>
 <xgycziy2o56hnom3oau7sbqed3meoni3razc6njj7ujatldnmm@s7odbl4splbn>
 <Z4T1G4dwzo7qdwSP@MiWiFi-R3L-srv>
 <87zfjuoj3i.fsf@email.froward.int.ebiederm.org>
 <f38f1b56-a5df-4644-be59-56c70499ed92@intel.com>
 <fslhdizolr4twqm4ixevzj6ai5l5qg6mxky25jasn3yctsnvt4@hpwphlmfs5cp>
 <4599571f-804b-40d8-b5c8-e19478a3ad18@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4599571f-804b-40d8-b5c8-e19478a3ad18@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250304_004204_014084_BE22D9BB 
X-CRM114-Status: GOOD (  24.62  )
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

On Fri, Feb 14, 2025 at 08:20:07AM -0800, Dave Hansen wrote:
> On 2/14/25 05:46, Kirill A. Shutemov wrote:
> >> It sounds like you're advocating for the "slow guest boot" option.
> >> Kirill, can you remind us how fast a guest boots to the shell for
> >> modestly-sized (say 256GB) memory with "accept_memory=eager" versus
> >> "accept_memory=lazy"? IIRC, it was a pretty remarkable difference.
> > I only have 128GB machine readily available and posted some number on
> > other thread[1]:
> > 
> >   On single vCPU it takes about a minute to accept 90GiB of memory.
> > 
> >   It improves a bit with number of vCPUs. It is 40 seconds with 4 vCPU, but
> >   it doesn't scale past that in my setup.
> > 
> > I've mentioned it before in other thread:
> > 
> > [1] https://lore.kernel.org/all/ihzvi5pwn5hrn4ky2ehjqztjxoixaiaby4igmeihqfehy2vrii@tsg6j5qvmyrm
> 
> Oh, wow, from that other thread, you've been trying to get this crash
> fix accepted since November?
> 
> From the looks of it, Eric stopped responding to that thread. I _think_
> you gave a reasonable explanation of why memory acceptance is slow. He
> then popped back up last month raising security concerns. But I don't
> see anyone that shares those concerns.
> 
> The unaccepted memory stuff is also _already_ touching the page
> allocator. If it's a dumb idea, then we should be gleefully ripping it
> out of the page allocator, not rejecting a 2-line kexec patch.
> 
> Baoquan has also said this looks good to him.
> 
> I'm happy to give Eric another week to respond in case he's on vacation
> or something, but I'm honestly not seeing a good reason to hold this bug
> fix up.
> 
> Andrew, is this the kind of thing you can stick into mm and hold on to
> for a bit while we give Eric time to respond?

Andrew, Eric, can we get this patch in?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

