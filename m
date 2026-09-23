Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9320C98311
	for <kexec@archiver.kernel.org>; Wed, 23 Sep 2026 22:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cpax/13k0jxkQdS7/A/IMz8DDLbIlyvkUqdfAGRN0Xc=; b=cP+gdms4ULeZBaMsIqkcTSrIsH
	+8jtq/gPKxQy4AkadnnCAh4brN6EoJ05hXAxro8nHlVDbarUTEcN1sHkPr0hN7lcLl5SH0MR2PDc4
	bGsw9h66YKRTVWI9nDoLFBE4XxKqqZ2odqbQqiNuE2mRTiVj3gCIhtXNhEAdBbq1UAsehgZQX/2ze
	ZMoQ58GUzKnxMcBPTEHG+SKGNlyXOiaurYdWJkz1NQek2tGZSy53jHLDajFSXu7qvEMjXbhGGGWuu
	8RAZaS2NyAU2jG4ijJeA9Q2P5rqaTqwSqaK4kOzq4sWUO8HtSZD3lz+NYNTiNjNAlHfq8GU1MxFle
	TCCW13Ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9Vqu-00000009gM5-0mit;
	Wed, 23 Sep 2026 22:54:12 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9Vqs-00000009gLy-36Zb
	for kexec@lists.infradead.org;
	Wed, 23 Sep 2026 22:54:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D912360008;
	Wed, 23 Sep 2026 22:54:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD201F000FF;
	Wed, 23 Sep 2026 22:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790204049;
	bh=cpax/13k0jxkQdS7/A/IMz8DDLbIlyvkUqdfAGRN0Xc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gYiiLuGvstukngP8msMKYZXuDIplTIHYq4g75NWD3qcMZ8W6gFbfZeTbQajsP10w/
	 wtanWytSJ0RBLmG2/0YqNDt/DoEz8IqN4QhScpT0ro37i6GhZEenIMJPzeG4qVa12h
	 aHJjv5RpU9ucXK6i51V1C0nouwOcpGq/Cbqvw4VCVpptJnlB0rynvZz61v9a6GAOo9
	 1fQJ13yXCF2PIhXYCuDZhV8VCxhh8O8Tv7FQVa6xesTQiVDbNLQq1nnC9WgkpO93j/
	 XcAyKHpwcW+7BIyCuJgpAI/CR+efXFvzPWXZL2sF83/bqRmELqcvmXObLUvKO0nJ5H
	 2FoAuE9i8MC2A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/6] shmem: add tmpfs_create_mount() to create tmpfs
 mounts internally
To: "Pratyush Yadav" <pratyush@kernel.org>, "David Hildenbrand" <david@kernel.org>, "Alexander
 Graf" <graf@amazon.com>, "Lorenzo Stoakes" <ljs@kernel.org>, "Hugh Dickins" <hughd@google.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Baolin Wang" <baolin.wang@linux.alibaba.com>, "David
 Matlack" <dmatlack@google.com>, "Mike Rapoport" <rppt@kernel.org>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Andrew Morton" <akpm@linux-foundation.org>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260923224408.3745689-3-pratyush@kernel.org>
References: <20260923224408.3745689-1-pratyush@kernel.org>
 <20260923224408.3745689-3-pratyush@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 22:54:08 +0000
Message-Id: <20260923225409.1DD201F000FF@smtp.kernel.org>
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

> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>=20
> Upcoming commits will add support for preserving a tmpfs mount via LUO.
> While the retrieve logic can create the mount by constructing an options
> string from its preserved data, it is simpler to let it directly pass
> the parameters.
>=20
> tmpfs_create_mount() allows creating a mount with the specified
> max_blocks and mode. The function only takes max_blocks and mode for now
> because that is all the tmpfs preservation will use. All other values
> are left to their defaults.
>=20
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923224408.3745=
689-1-pratyush@kernel.org?part=3D2


