Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E952CC88E75
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 23:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OPWCzUYSAJXN4K++8vT6w9N1hwOvTESTMHXbrKefK4c=; b=y73e2Mg+05NaN44xHVSU8cOlfG
	R/tbZ14K3X8fKa8i3PGlmT8LZNqGyATKHcYDBQIHWu2TJyk/iKgCycT32JKeg+AaPodVpR99GXzj5
	OHiS9dFDrUt7mudAiGxG01UScW4LYHydHBZUP0MMguW2YgHGwllrq9PCYQViJFJB0sw93uz6BVbC4
	ff5A8X60GDTLKRtU7joGMVI+rIIjgryuzHq2JKC0UjOovMB7RoDlaP4OlFiCekNqBH6N3hdec5lHH
	ccERyq7JTMYdtCKTEowa7QLlx1Kwsfn/9ph4Gi6r82tW4O/8GrqVnS/x1OBWBfYcDK57oOsdSZr0e
	j6PfJStA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6cy8-000000085Mj-3piE;
	Tue, 15 Sep 2026 23:53:44 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6cy7-000000085Mb-3Nj5
	for kexec@lists.infradead.org;
	Tue, 15 Sep 2026 23:53:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 34E38404F9;
	Tue, 15 Sep 2026 23:53:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507961F00893;
	Tue, 15 Sep 2026 23:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789516423;
	bh=OPWCzUYSAJXN4K++8vT6w9N1hwOvTESTMHXbrKefK4c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PplxQb5nyQyaZ7w46hyW23hoFg3yKZvpD+woczhTgPfqovvmPhOTEFEJLwmWzc1gk
	 QAACR2sPNCs6atVacLPhG5TcNwXo3GnUk/zXpbCLCC6i/dNCC8v4FBIXpGo+ojwdgK
	 jt4X9lbnN9dEOPib8ge0m2BdeNY4LlmbZ6XI2nRMjzIHLDUF3OBCskvQbmqNp2qmmh
	 lK4IrtmZ81P6GLSolCKauWVvNPjjVnzC+3wmE7hLQtVrtcvR17KT9Q81+K6VP+F2fO
	 SLa9CSCvNFfMPCmkwMDq60hTsEBKdFK8FjyC+CTaT/ZkdbiFLj3CjevYjYGRl0F0n3
	 ln3J6ul31bpCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vmcore: convert mmap_vmcore_fault() to use folios
To: "Andrew Morton" <akpm@linux-foundation.org>, "Mike Rapoport" <rppt@kernel.org>, "Baoquan
 He" <baoquan.he@linux.dev>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Tal Zussman" <tz2294@columbia.edu>, "Dave
 Young" <ruirui.yang@linux.dev>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, kexec@lists.infradead.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, linux-mm@kvack.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260915-vmcore-fault-folio-v1-1-a0cb6278670f@columbia.edu>
References: <20260915-vmcore-fault-folio-v1-1-a0cb6278670f@columbia.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 23:53:41 +0000
Message-Id: <20260915235342.507961F00893@smtp.kernel.org>
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

> Use a folio for the page cache page the s390 fault handler reads the
> old kernel's memory into. This removes four compound_head() calls and
> one of the last callers of find_or_create_page().
>=20
> The vmcore mapping only has order-0 folios, so the logic is unchanged.
>=20
> Compile tested for s390.
>=20
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-vmcore-fau=
lt-folio-v1-1-a0cb6278670f@columbia.edu?part=3D1


