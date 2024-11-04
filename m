Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9F5D111BF
	for <kexec@archiver.kernel.org>; Mon,  4 Nov 2024 08:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=agUd8WSGPsH9VUW4rqWrmg5gGIVCm9lU/zjFiHwtMF4=; b=crYPfWmoJ9oX/L
	MGJVq5/+AVlTSjJdcBmm4etqIjHkflqfTGzuWrk52/2jiH9d+cigH0dai017F0unVKH5stDsy4naZ
	MeEMijtct+4UTLuLkvsiDcMN5PJ9dJxTkElu8ZfCJCsEGkgQdqUUqfDukFiXXmXvMAnxNa1AXuhja
	uyKDas9fd5vuZBjR39juwlXeoF60YDBFHsnL8e8LNz5UdQRSboFQvXLkhc6/4CaQdcVPXaRJFadGj
	ueAeYwEJ4x9LtPFE3Wr3GgZgEyxihVuYkEX3pSS8Jxfqt5JIVEvIsGavQehrGn0duClWzk7b49QGw
	8mpKDuxmtgr/HVmgxndA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7sas-0000000CzhS-2teL;
	Mon, 04 Nov 2024 08:37:50 +0000
Received: from mgamail.intel.com ([198.175.65.13])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7sZ3-0000000CzLo-2Fyi
	for kexec@lists.infradead.org;
	Mon, 04 Nov 2024 08:35:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730709358; x=1762245358;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kyIazxcsnD1piSdyaQzAEKNQGTi5kMoAlbZhxGC4Hsc=;
  b=fJkONhyOkKm1cDy3Okj9t/Ns4KabcGWZXakmftba8dG9Y2PoB3RHzFyG
   7KVg3hW04gAYqXQT8SXw2H1BgUrxO2sfoiawiVPK4YYUyfgfoDWDKQaTt
   03CL9smQ9IetE064A6k+53q/tPvvYLgdKwqOBvZe9dZIWzrc9XjnisIR4
   BVIFzm8IqXXCLME65Bv2a0lSI/gzprwMJKCbPhy5Wm1NZEVRZmBUt275n
   cj+N38kw+S1drcienqS437ZS17AdYt3aOEjzeSROUos5ycEXPakUB5qsl
   aDUoooDh867mbMy58FvwFxda8RBnULVQbnqNN1KCq+JSZyf+uj61s3nPr
   A==;
X-CSE-ConnectionGUID: BV8Q/FviQBa6YyTnATTQ3w==
X-CSE-MsgGUID: gVgoBvnQSRm6QBhFoty7Gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41501595"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41501595"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 00:35:57 -0800
X-CSE-ConnectionGUID: /GZTW6eHQ72wu5JQUTGKsA==
X-CSE-MsgGUID: NQ0MhvZzR7mR/WXC6VUHpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="84031503"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 04 Nov 2024 00:35:55 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id DD1824A3; Mon, 04 Nov 2024 10:35:53 +0200 (EET)
Date: Mon, 4 Nov 2024 10:35:53 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, x86@kernel.org, rick.p.edgecombe@intel.com
Subject: Re: [PATCH] kexec_core: Accept unaccepted kexec destination addresses
Message-ID: <ktwgnbsni5pt2cznxj2g6qyb3xwkhjrciym6lpk3uvsxgi4324@tllciap26vb5>
References: <20241021034553.18824-1-yan.y.zhao@intel.com>
 <87frop8r0y.fsf@email.froward.int.ebiederm.org>
 <tpbcun3d4wrnbtsvx3b3hjpdl47f2zuxvx6zqsjoelazdt3eyv@kgqnedtcejta>
 <87cyjq7rjo.fsf@email.froward.int.ebiederm.org>
 <ihzvi5pwn5hrn4ky2ehjqztjxoixaiaby4igmeihqfehy2vrii@tsg6j5qvmyrm>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ihzvi5pwn5hrn4ky2ehjqztjxoixaiaby4igmeihqfehy2vrii@tsg6j5qvmyrm>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_003557_650469_4C302988 
X-CRM114-Status: GOOD (  25.15  )
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

On Fri, Oct 25, 2024 at 04:56:41PM +0300, Kirill A. Shutemov wrote:
> On Wed, Oct 23, 2024 at 10:44:11AM -0500, Eric W. Biederman wrote:
> > "Kirill A. Shutemov" <kirill@shutemov.name> writes:
> > 
> > > Waiting minutes to get VM booted to shell is not feasible for most
> > > deployments. Lazy is sane default to me.
> > 
> > Huh?
> > 
> > Unless my guesses about what is happening are wrong lazy is hiding
> > a serious implementation deficiency.  From all hardware I have seen
> > taking minutes is absolutely ridiculous.
> > 
> > Does writing to all of memory at full speed take minutes?  How can such
> > a system be functional?
> 
> It is not only memory write (to encrypt the memory), but also TDCALL which
> is TD-exit on every page. That is costly in TDX case.
> 
> On single vCPU it takes about a minute to accept 90GiB of memory.
> 
> It improves a bit with number of vCPUs. It is 40 seconds with 4 vCPU, but
> it doesn't scale past that in my setup.
> 
> But it is all rather pathological: VMM doesn't support huge pages yet and
> all memory is accepted in 4K chunks. Bringing 2M support would cut number
> of TDCALLs by 512.
> 
> Once memory accepted, memory access cost is comparable to bare metal minus
> usual virtualisation tax on page walk.
> 
> I don't know what the picture looks like in AMD case.
> j
> > If you don't actually have to write to the pages and it is just some
> > accounting function it is even more ridiculous.
> > 
> > 
> > I had previously thought that accept_memory was the firmware call.
> > Now that I see that it is just a wrapper for some hardware specific
> > calls I am even more perplexed.
> 
> It is hypercall basically. The feature is only used in guests so far.

Eric, can we get the patch applied? It fixes a crash.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
