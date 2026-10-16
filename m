Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172E2CCA462
	for <kexec@archiver.kernel.org>; Fri, 16 Oct 2026 06:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eDnse++/sMMqljy7OgeSWKTJCj07VGRD+6nKCHuobdE=; b=THiffDvICtynwvEteQc1jNjayR
	ar93BCPq1CR6KRpLemHrRNbbaiULomdyLPVp4g6jFANtpBy7zzTz2nC9ehfodRlMwRMaUpLA6uxUi
	SMy32f73IB51EyJkJFoF4FaBnGGhh9C0Wilct21x7jLzVudpx9tYEXfITLA2szm4JVon2WBtKdNVY
	VZ1IvIUjUbG1RGy9g5+9Q3AxMTWundCsqCRyZshhFNHgbsmxYlTd9kxMvDV0ekrc5CqWkRSI6m4nF
	u22m814CDQRjKmHO/bfHrBN+DGi4Cvrwzv4OTMqewkUnfw4lcZEB0CyCNKyL6jkRGt0K1IR2k1gGy
	0XP9bfLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHbN1-000000027IO-0g9n;
	Fri, 16 Oct 2026 06:24:47 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHbN0-000000027II-1Mwa
	for kexec@lists.infradead.org;
	Fri, 16 Oct 2026 06:24:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6D7FB601F0;
	Fri, 16 Oct 2026 06:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB85A1F000C4;
	Fri, 16 Oct 2026 06:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792131885;
	bh=eDnse++/sMMqljy7OgeSWKTJCj07VGRD+6nKCHuobdE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QQPbnTEi2cx6sBkJRV0fhIULdRwjRm+h3bxF0HIhrrTyxWlWItJwtAta0QpTJUkDb
	 9a+YD7KYa6YjSJlIWNBrlHuagtf021rdGjN2KxDqv7cGIeqiDPX1V6WH7U+YsbLoZ3
	 0IcYt8UVRS7/kBzCxUzIYLY4GUefwaYEVDGm+WI/Co25PzkUFIhxPJhc0WKyCu235S
	 bebY91gBUgvdteZIwDFDC0GHV3+1FDx8nPOYPy47ovgdHCN470STLj1owB5v+xIfBA
	 3RT64oArDE8Y+jtax2MjirTCebJShE3dZkl20Ha1L1PDL8pIibiblf1YgLwa+x4m2K
	 nuqPxCNtvqx+A==
Message-ID: <sashiko-outbox-173855@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RESEND PATCH v8 6/8] of: reserved_mem: add dumpable flag to
 opt-in vmcore
To: "Wandun Chen" <chenwandun1@gmail.com>, robh@kernel.org, baoquan.he@linux.dev, rppt@kernel.org, m.szyprowski@samsung.com
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, saravanak@kernel.org, akpm@linux-foundation.org, pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, robin.murphy@arm.com, kexec@lists.infradead.org
In-Reply-To: <20261016061549.4181390-7-chenwandun1@gmail.com>
References: <20261016061549.4181390-1-chenwandun1@gmail.com>
 <20261016061549.4181390-7-chenwandun1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 06:24:43 +0000
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

> From: Wandun Chen <chenwandun@lixiang.com>
>=20
> Add a 'dumpable' flag to struct reserved_mem to decide whether a
> reserved area should be included in the kdump vmcore. Non-dumpable
> regions are later marked MEMBLOCK_NODUMP; the filtering itself happens
> in memblock, keeping the arch kdump code independent of the DT API.
>=20
> Most reserved regions are owned by devices and do not contain data
> useful for kernel crash analysis, so dumpable default to false.
> Reusable CMA regions are different: their pages are handed back to the
> buddy allocator and may contain key data for crash analysis, so set
> dumpable to true in rmem_cma_setup().
>=20
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016061549.4181=
390-1-chenwandun1@gmail.com?part=3D6


