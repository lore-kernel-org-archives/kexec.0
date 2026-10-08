Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A6DCA600D
	for <kexec@archiver.kernel.org>; Thu,  8 Oct 2026 19:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g8KQeNifzJDkfTub6uCXp9RKMHqJJTc0kuS7L1xFNWM=; b=VUv2UA/1ITITuE4Gd8Fcdq4sH7
	amyE/QnBfPvYPUNmfEvJOmEqoQnq6UBiyKnkapJjdrnDn52Q/BPi4YKJQe7SS+W/JySiJjU7snuHj
	y0EhFxU/4emsoviNX+yV45CNis2/zTdCFmUi/W4rXUlNcM4BDqFbuZ/FznWqJzr/TRozeHELzj8zG
	BTEv+95rAiVjMQpNmQdLjyxxMdvZRY33Qhi8bd6XuGoMFr4Q2qYvUofosBelMTx2y/B52pTovbVAy
	w6tGUQGcnlTu/Yiz+kzccizaLm65R9ipwH998QbTql7jtS73uIe5SgysCise8vSlYeQeiYSDPsdyt
	hVnHVnUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEtZu-00000004uOk-3x6E;
	Thu, 08 Oct 2026 19:14:54 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEtZt-00000004uOV-2SKh
	for kexec@lists.infradead.org;
	Thu, 08 Oct 2026 19:14:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A20E160267;
	Thu,  8 Oct 2026 19:14:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FDC1F000FF;
	Thu,  8 Oct 2026 19:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791486891;
	bh=g8KQeNifzJDkfTub6uCXp9RKMHqJJTc0kuS7L1xFNWM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L2FMifRhEDoiYaA/Dnn2ugNRparTpm3x5ZCC1vqmTwUiiOxVVPC+onovRHhZ5h2QH
	 7taU5pl2DUzoVki4fstwIEh+jmSkXIZvalkchzyzk6y13DQYNaI8xjXCQDfrWPmFJu
	 UGr5GEKkSrEWd6VGjM27xlJekcT26snY+yy1eJNOSPfc8AXLYiNGJSiakQX1G1zieE
	 8/IvER3rxJ3fsGTj6C+NZsE+yeuVbk0CY/kbIpq/a1LhvgWuPx+RVwaRMA+sKKdGkT
	 o3KKtjVYrZmcm6C//CkcvvWtCLDkzIISvC7+9+vZ+f5iUb1mBJqhm1WPThn92spuoh
	 5o0pLdCPueGcQ==
Message-ID: <sashiko-outbox-164506@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] memblock: use binary search to locate candidate
 regions
To: "Andrew Morton" <akpm@linux-foundation.org>, "Pratyush Yadav" <pratyush@kernel.org>, "Mike
 Rapoport" <rppt@kernel.org>, "Tarun Sahu" <tarunsahu@google.com>, dmatlack@google.com, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261008190828.3221718-2-tarunsahu@google.com>
References: <20261008190828.3221718-1-tarunsahu@google.com>
 <20261008190828.3221718-2-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 19:14:50 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

> Use binary search (memblock_bsearch_start) in memblock_add_range() and
> memblock_isolate_range() to locate candidate regions instead of linearly
> scanning from index 0.
>=20
> Under heavy memory fragmentation (such as KHO page preservation registeri=
ng
> hundreds of thousands of disjoint folios), scanning from index 0 on every
> insertion and isolation results in O(N^2) complexity, causing boot-time
> memory retrieval to take several minutes (~268s for 393k pages).
>=20
> Using binary search reduces the candidate search complexity to O(log N)
> (from O(N)), cutting KHO memory retrieval time from ~268s to ~50ms.
>=20
> memblock_search() open codes the same binary search, so reimplement it on
> top of the new helper.
>=20
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008190828.3221=
718-1-tarunsahu@google.com?part=3D2


