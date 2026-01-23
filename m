Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B16D72353
	for <kexec@archiver.kernel.org>; Fri, 23 Jan 2026 08:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FSbY3XgNEeMt7RDjgwXfpbnZxu/CxSRhlv5jLZ5PvPA=; b=2qeM1+pwYUm9b2HKDM1+4W2SxJ
	g600AjRmbEO7LeDIk+d1D8o1AdTUxRrBiduezi6ssCHN9/bs1hjNbGo/OUB5prhH6/+/Yh4BYwqGY
	NhMGDEVbm7ykW8PmprzapJqPxzPp5e0FbmQY4AjScQHS+NmEOucALDLeQYHzfmDKGkArHRzFoHEbg
	/e606UOfO66FWs1aMBteh0tQzAXuruwthRjS4IwlW4X64Ss6USR3VTSXffc9xy7BJSkcna+HdHykN
	PTSzNJLyIXMOzMtj3UW2MZ4/OZVmBCGr4g5pV7WwDFu3Rsjhv2IkZllDN8aewgzDUryNUgx56NKuW
	dx/eVJMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjCvP-00000008VXf-17DY;
	Fri, 23 Jan 2026 08:53:51 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjCvN-00000008VXK-2zbl
	for kexec@lists.infradead.org;
	Fri, 23 Jan 2026 08:53:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 59399434FE;
	Fri, 23 Jan 2026 08:53:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1591C4CEF1;
	Fri, 23 Jan 2026 08:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769158429;
	bh=8xDScLcsy5OFgIJg5rseIw23Z3H5/7lWSJmJgApIXko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EJyy6q4GWlNjzBtY8qzSezHb7bGJ0MPYYNHtLo9jOXlGE/DhGzq1hfsdoLsqjLcHB
	 KyHB/f8pdvDLTlYmTUYPNPK3Abt0FTBwhzIVXmzVsQmfZp8XB1Fdam7mJLMGII6GzU
	 vGYWSG3J6wWzp/HHPspEPHFPwJiVIyoFxLIrAQoi8SlYn+5CFFzJUw6NavLlmM8SZc
	 we7Wuh+48gW6nIFohR3yz54yhjHR4iYs2YXbW8XS6JyGqb/xIdxXwTjAIncCpcVpp4
	 JnJb3EpXp66eRrCBIGWkp71VvVprmAHUEBHJVAXxdycnZQtMG+rVlM2T1F+sYDB5UL
	 o13nTXz1H/wWw==
Date: Fri, 23 Jan 2026 10:53:42 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Evangelos Petrongonas <epetron@amazon.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>, Jason Miu <jasonmiu@google.com>,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	linux-mm@kvack.org, nh-open-source@amazon.com
Subject: Re: [PATCH v2] kho: skip memoryless NUMA nodes when reserving
 scratch areas
Message-ID: <aXM3FoK7g12P5h91@kernel.org>
References: <20260120175913.34368-1-epetron@amazon.de>
 <20260122152112.1a8be8e7bdab72631234cd69@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122152112.1a8be8e7bdab72631234cd69@linux-foundation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260123_005349_778651_21D38B1A 
X-CRM114-Status: GOOD (  12.73  )
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

On Thu, Jan 22, 2026 at 03:21:12PM -0800, Andrew Morton wrote:
> On Tue, 20 Jan 2026 17:59:11 +0000 Evangelos Petrongonas <epetron@amazon.de> wrote:
> 
> > kho_reserve_scratch() iterates over all online NUMA nodes to allocate
> > per-node scratch memory. On systems with memoryless NUMA nodes (nodes
> > that have CPUs but no memory), memblock_alloc_range_nid() fails because
> > there is no memory available on that node. This causes KHO initialization
> > to fail and kho_enable to be set to false.
> > 
> > Some ARM64 systems have NUMA topologies where certain nodes contain only
> > CPUs without any associated memory. These configurations are valid and
> > should not prevent KHO from functioning.
> > 
> > Fix this by only counting nodes that have memory (N_MEMORY state) and
> > skip memoryless nodes in the per-node scratch allocation loop.
> > 
> 
> So kho is unusable on such machines.
> 
> Should we backport this?  I'm thinking
> 
> Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers").

It's only for v6.18, but sure, why not. 

-- 
Sincerely yours,
Mike.

