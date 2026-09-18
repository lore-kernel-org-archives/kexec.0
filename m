Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 246CDC982D2
	for <kexec@archiver.kernel.org>; Fri, 18 Sep 2026 00:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CZyUKeUjL3VbbEuUgq55Wv+PmZoa3E5pWDjbtphAiMU=; b=MOJH/cHKooJ8eQhH2p/FfNSqtp
	5eYZVXGp9HtV8S/HDVIkhUlsvskA+nnoWfcGGc7cmBUG6Z+YGynUjnNmmaxe7Hwr9GTWRLIBYkk2D
	zo6MftQnfXPp9T9b6quN9TjVriqFHWM9LncZpy6SLNYNxIBvfIOCe9tXCdColUV+oJFcMD1lgfAkJ
	5EKf9aHjhGDtaAlXu7kJlHE0qcJb5GM5rhu5v4zRVnl26OVh1n6072K2iyB3CuaBtxEU3K7S+A03S
	6VYPZo/YooimDOwUIne66jST4TbcNqtT5iP+ob/MI+YfxUa3nifpOMCi3Vy2gox+PPAH31m+gUafz
	K3Ebep3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7MTB-0000000D1wq-0IBq;
	Fri, 18 Sep 2026 00:28:49 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7MT9-0000000D1vf-28sw
	for kexec@lists.infradead.org;
	Fri, 18 Sep 2026 00:28:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D657B43751;
	Fri, 18 Sep 2026 00:28:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F13C1F000FF;
	Fri, 18 Sep 2026 00:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789691326;
	bh=CZyUKeUjL3VbbEuUgq55Wv+PmZoa3E5pWDjbtphAiMU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M47w4V8O1MJwov/K8stC0BWLy8Xd0XiFdkCxmRliNYgCEVr89aeb0ZJ/fJ7oeIJlz
	 RGDTB5ikI75dsYAMQ8KU077OumjB63isA59L3wlr396rJIhEwyHz+GUYVS/YEu97H+
	 EZ2JXAkKMa5ejpkR3I/9B5H15Yt776sC/4b/5MqLC/Osa+3GphfLlxJuby2xsuSqOz
	 SGMAqgkuvalFE+/Dw7OTWGqxoy+fr2JAeGyYQAqLirHOWZSGqZSZk1iehgaQ89IwQB
	 oExv03YOfmyEfXlE3N0K8DGcmnNiN/lvF3Avcc6AGD1m7K8W0Mm9DYIOoDMrPXj4a8
	 GWyZrlUiHsUSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] memblock: use binary search to locate candidate
 regions
To: "Tarun Sahu" <tarunsahu@google.com>, "Andrew Morton" <akpm@linux-foundation.org>, dmatlack@google.com, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Mike Rapoport" <rppt@kernel.org>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, "Pratyush Yadav" <pratyush@kernel.org>, dev.jain@arm.com, linux-kernel@vger.kernel.org
In-Reply-To: <20260918002239.4024231-2-tarunsahu@google.com>
References: <20260918002239.4024231-1-tarunsahu@google.com>
 <20260918002239.4024231-2-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 00:28:45 +0000
Message-Id: <20260918002846.3F13C1F000FF@smtp.kernel.org>
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
> Using binary search reduces the worst-case complexity to O(N log N)
> (and O(N) for sequential appends), cutting KHO memory retrieval time
> from ~268s to ~50ms.
>=20
> memblock_search() open codes the same binary search, so reimplement it on
> top of the new helper.
>=20
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918002239.4024=
231-1-tarunsahu@google.com?part=3D2


