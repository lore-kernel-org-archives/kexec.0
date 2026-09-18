Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38313C982D0
	for <kexec@archiver.kernel.org>; Fri, 18 Sep 2026 00:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OjEB8YoSvr2E8wX9cD7isVumdC5ySqRIBYWNH1Q63aQ=; b=yfMA2Jclk6Cx98jgeJhnQS/fSs
	tiOoFQu8liSQNfAeXumDhFaAKJHpkdNjYpPjRVADYd1zMvZoIwof5A0dqDs584Jk7jxV8IvP1hUGv
	m/8cEte6RBrUIBbX55p5m2KG8jJBWHURAzl3GqHi6yxb3U1H11qwnAv3nYYEmZ0pjdVOEXuv+tYwl
	ffPloqGCcOlOgVO5xn8iOVU+mqBi9KUawsCOegJjOnECDsn8bn1kbZObNH4nVBcadu73u9U5i19AP
	adbHWbqf40uQ1EL9M67Tqm0srR4JIzMQde/U8V+f3MeAv+dRBTtP/xNwd/UIJxF5w3afbX8HX06LY
	cLHIwkww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7MT0-0000000D1rv-0SJA;
	Fri, 18 Sep 2026 00:28:38 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7MSy-0000000D1rK-47Z3
	for kexec@lists.infradead.org;
	Fri, 18 Sep 2026 00:28:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E8FC6601FF;
	Fri, 18 Sep 2026 00:28:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BCF71F00898;
	Fri, 18 Sep 2026 00:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789691315;
	bh=OjEB8YoSvr2E8wX9cD7isVumdC5ySqRIBYWNH1Q63aQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NGLKgzwSwrIvn0iCT+qFyEn8qxZ/uTuu+fXrTh3zKpK5AZt9AvxAH+dw6o5ejPH/z
	 3dMXhPmDyMvjetdJHJhHMHHnx6Ig3uXk5NV9Spo9luo2PJwSGKFuT797OkbSjTAONn
	 C0myLUPUVv/sFeYO8D9VgGhhs0lDiX1KaTGUPGLobwwaoujqlI3tkM5UJWdxKb05gA
	 Mo5eEA2rdlnqSg6wMSMwS+5ZANvMb/kKJ3Nk8krN77jCrFzzV8J8eHjl3azqPgGXEz
	 miQyiBHQZpvDDEvXuZmlRDeO2PPfsWQi9mB8rOT+NxRXNYgaGiWXwfXveYEXUepkf3
	 G4a9Wv70HEZ5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] memblock: drop for_each_memblock_type() and open
 code its users
To: "Andrew Morton" <akpm@linux-foundation.org>, "Mike Rapoport" <rppt@kernel.org>, dmatlack@google.com, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Tarun Sahu" <tarunsahu@google.com>
Cc: linux-kernel@vger.kernel.org, dev.jain@arm.com, "Pratyush Yadav" <pratyush@kernel.org>, linux-mm@kvack.org, kexec@lists.infradead.org
In-Reply-To: <20260918002239.4024231-1-tarunsahu@google.com>
References: <20260918002239.4024231-1-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 00:28:34 +0000
Message-Id: <20260918002835.4BCF71F00898@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] mm: commit message and implementation mismatch regarding variable s=
cope
--

commit c0dca5a3d7239e89d9dccb549819f0c9f7139656
Author: Tarun Sahu <tarunsahu@google.com>

memblock: drop for_each_memblock_type() and open code its users
   =20
Remove the for_each_memblock_type() macro and open code its users to
allow iterating from an arbitrary index. The three users modified are
memblock_add_range(), memblock_isolate_range(), and memblock_dump().

> Remove the macro and open code its three users: memblock_add_range(),
> memblock_isolate_range() and memblock_dump(). While at it, move the
> region pointer into the loop body scope.

[Severity: Low]
This isn't a bug, but the commit message mentions moving the region pointer
into the loop body scope.

Looking at memblock_add_range(), memblock_isolate_range(), and
memblock_dump() in mm/memblock.c, the declaration for=20
struct memblock_region *rgn remains at the top-level function scope rather
than being moved inside the newly open-coded for loops.

Did this patch miss moving the declaration of the rgn pointer into the
loop blocks as intended?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918002239.4024=
231-1-tarunsahu@google.com?part=3D1

