Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB02DC98318
	for <kexec@archiver.kernel.org>; Sat, 26 Sep 2026 09:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aahV+yzdFExMYzQQ+dk85KZLNDS7wQg/3/bXdqkAuRo=; b=RlcnhQ65AvOiSLY4DL/aV9Tdeo
	Z7o6iPToVuQMmfvQB3bKeXnRL2I+cLBy863vpIswKJVGk/qAqBEmB9XepwF+jen0olyEGDLHA9JfG
	TNwo0dS3UEOmVIUSeNH70NXaxwZlS+B/5DrTKnBRRdM33b+tqwCHEwY7eeTADrU0jGZtRU3pT51Q1
	b3/7Azm7oxdukAQl/96hd/NVD5DHhsMUZ0WA6dPZndb3vg12mVvcrlToFvh5MKHULb7xgiPa2Cadb
	vXkQuk0p8iL+0Y32JNjuwd9zeBY+7QLK06xIa2lx7/Lpi+fS4D8lK2obemogn5bm/lvJ0h7DB92Xw
	Xemg3TDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAOlH-0000000FDE3-40e3;
	Sat, 26 Sep 2026 09:32:03 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAOlG-0000000FDDv-0MRB
	for kexec@lists.infradead.org;
	Sat, 26 Sep 2026 09:32:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2F3F26020C;
	Sat, 26 Sep 2026 09:32:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5727C1F000FF;
	Sat, 26 Sep 2026 09:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790415120;
	bh=aahV+yzdFExMYzQQ+dk85KZLNDS7wQg/3/bXdqkAuRo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K5QPVHkbO0pFLaCwEOWX/lc1IEnhnMfFx2Tvwe9TgoOqETu+9ttswGq7skYIVlyTk
	 vM5UiMK+EADQGe3DrTxeY2XdszOTw1m7zLkuQlLFkF+kjSuQIIcFWmeaqc5M7x0r1F
	 NlP7zcAg7LLrSwxBWhqhDHbvxcssDrfOUPD7nmF9E5o2Z1iJyKC2gMljqaLCeVbNWx
	 q55RQmOacgCAOek1cnAlt470FG6VjJsLjVZRUKzqwULlIbeXvVvNLTxmlDE0PX3Pqd
	 Ls4l3QW875CN/xouc33gBcC4fyAIVk6J7uFPYjqVRsS3zZ86/HzQhloBm8TBEcA2HO
	 hd8JhY9X7bmaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] memblock: use binary search to locate candidate
 regions
To: "Tarun Sahu" <tarunsahu@google.com>, dmatlack@google.com, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Mike
 Rapoport" <rppt@kernel.org>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, "Pratyush Yadav" <pratyush@kernel.org>, linux-kernel@vger.kernel.org, dev.jain@arm.com
In-Reply-To: <20260926092448.4090401-2-tarunsahu@google.com>
References: <20260926092448.4090401-1-tarunsahu@google.com>
 <20260926092448.4090401-2-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 09:31:59 +0000
Message-Id: <20260926093200.5727C1F000FF@smtp.kernel.org>
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
- [Medium] mm: commit message falsely claims O(N log N) worst-case complexi=
ty
--

commit ffd047af563941b5aabcd86a52d569f9b40c01ec
Author: Tarun Sahu <tarunsahu@google.com>

memblock: use binary search to locate candidate regions

This commit introduces a binary search helper, memblock_bsearch_start(),
to optimize finding candidate regions in memblock_add_range() and
memblock_isolate_range(), aiming to reduce boot-time overhead during heavy
memory fragmentation.

> Under heavy memory fragmentation (such as KHO page preservation registeri=
ng
> hundreds of thousands of disjoint folios), scanning from index 0 on every
> insertion and isolation results in O(N^2) complexity, causing boot-time
> memory retrieval to take several minutes (~268s for 393k pages).
>
> Using binary search reduces the worst-case complexity to O(N log N)
> (and O(N) for sequential appends), cutting KHO memory retrieval time
> from ~268s to ~50ms.

[Severity: Medium]
Is the claim of O(N log N) worst-case complexity mathematically accurate he=
re?

While the binary search reduces the time to locate the insertion index to
O(log N), the regions are still stored in a contiguous array. If disjoint
memory regions are inserted in an order that requires inserting into the
middle of the array, the subsequent elements still need to be shifted.

Looking at memblock_insert_region() which is called during insertion:

static void __init_memblock memblock_insert_region(...)
{
        ...
        memmove(rgn + 1, rgn, (type->cnt - idx) * sizeof(*rgn));
        ...
}

Because this memory move operation guarantees the worst-case complexity of a
single insertion remains O(N), wouldn't inserting N disjoint regions in
descending or scattered order still result in an O(N^2) worst-case time
complexity overall?

The described KHO workload sequentially appends regions, which avoids the
shifting overhead and achieves O(N) overall. Could the commit message be
updated to clarify that this patch improves sequential insertion to O(N),
but the worst-case for fragmented insertions remains O(N^2) due to the array
shifting?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260926092448.4090=
401-1-tarunsahu@google.com?part=3D2

