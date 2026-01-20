Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18CFD26280
	for <kexec@archiver.kernel.org>; Tue, 20 Jan 2026 18:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ITCH5eSHHFlFzrcAyVSLkFWfLkiw7PkA+qDqwaON19g=; b=VQLpR/tQvrXwH5jwu5LnjetcaM
	VDg8TXsDezN80hfCUxOpVyhO4PFWaT5v8HT0b5QFuBzRhBzxUsi9mL0T2FYy6rS6rRTdiL6S4DAvv
	99H/HXIq8ivlIvUUL/pyODf8cizZzq/sP33yS7I/yjfGv4VGFOqMvzxmvrX4rYHzuiDz0jlAjaZRG
	dWy1khOo0Ci7BxYYHgYSu/CeCDpCsAKazKGrxdq3TuYTDOnbXld6qdaAE2al5zossaWySbXFUcjGu
	OfbiZD8Ck2LQ65Vv2fP+5zMqYKjUhOg6/Qf+OREk9EbwnVS62SSni9gAx5b1XCYIlUpQufUy3R/iZ
	aYZjhpyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viGbS-00000004JJy-04lR;
	Tue, 20 Jan 2026 18:37:22 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viGbP-00000004JJe-0fD8
	for kexec@lists.infradead.org;
	Tue, 20 Jan 2026 18:37:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0925760010;
	Tue, 20 Jan 2026 18:37:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C598C16AAE;
	Tue, 20 Jan 2026 18:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768934237;
	bh=qMsPsLKr8lsKfYWwVgXUWfhbGnBcx6jUKbbl7LEcQak=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nRcoUS6sAu6+BgNMiYePK91g1ZaWzvwxv7IPVSWT7+mEBsipRiebKmFM/UAH0eXpC
	 9SE9Xl+mi1vH/JrUI9JiIU3rkScWHMsXFjG0cuOUR+4bC8x63o8LELmLFV5BYdk+Zp
	 a/0CyanVVAAizhMAP2hYSqqIVzn+aocGIxop3dQXKWYOIF/C+dBcJb1q5beBRmGS9w
	 vKcapO/vc8FBqDBtOLn+DaBBpyRgXxbT1Q0YrCGhJc+H5II6chN5mbowEOldzZh94S
	 bk7yQKAL06Vj4wAjmCWmEynUSR6woff0aLxofTsDD6UsGKzT4L4CymQ63F2/5/QmwO
	 eTYDKs9FcfvUw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Evangelos Petrongonas <epetron@amazon.de>
Cc: Mike Rapoport <rppt@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Pratyush Yadav <pratyush@kernel.org>,
  "Alexander Graf" <graf@amazon.com>,  Jason Miu <jasonmiu@google.com>,
  <linux-kernel@vger.kernel.org>,  <kexec@lists.infradead.org>,
  <linux-mm@kvack.org>,  <nh-open-source@amazon.com>
Subject: Re: [PATCH v2] kho: skip memoryless NUMA nodes when reserving
 scratch areas
In-Reply-To: <20260120175913.34368-1-epetron@amazon.de> (Evangelos
	Petrongonas's message of "Tue, 20 Jan 2026 17:59:11 +0000")
References: <20260120175913.34368-1-epetron@amazon.de>
Date: Tue, 20 Jan 2026 18:37:14 +0000
Message-ID: <2vxzecnkceqt.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Tue, Jan 20 2026, Evangelos Petrongonas wrote:

> kho_reserve_scratch() iterates over all online NUMA nodes to allocate
> per-node scratch memory. On systems with memoryless NUMA nodes (nodes
> that have CPUs but no memory), memblock_alloc_range_nid() fails because
> there is no memory available on that node. This causes KHO initialization
> to fail and kho_enable to be set to false.
>
> Some ARM64 systems have NUMA topologies where certain nodes contain only
> CPUs without any associated memory. These configurations are valid and
> should not prevent KHO from functioning.
>
> Fix this by only counting nodes that have memory (N_MEMORY state) and
> skip memoryless nodes in the per-node scratch allocation loop.
>
> Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

