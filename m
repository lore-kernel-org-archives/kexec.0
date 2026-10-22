Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33E1606A326
	for <kexec@archiver.kernel.org>; Thu, 22 Oct 2026 08:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lYKUCKIj;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HwA/MW+h
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Sig2fRytiH3CoX3EJXsHl29TZlpoGoqp+70EEbroBwY=; b=lYKUCKIj4YInnjSDeLq/nP39Oy
	JLkVh2x0ufcIo5nN4FB8oSLuCztkBzraMK+6Qe/bmV+ZIYNmaCYQDmdxMfhZVNDIAeUaqA8ddb3h8
	3JsvSabDM69jmx6r3PYa9aI8Ml82naKD/ag1B8ZOSnToFBMx4MzAG95JN4I7yqrvqA8xc/wC5Yx//
	I5C+N0lzhQKxlAJ0zqZHtLDx3ZSxNx9TZaRg4b1S/YQTdbPYw4DQ84WsCGcOvquAXaAzS67D1S4XH
	i/DfL2X5ZmqcJYZucBwyCaT8YttygcrIPLPwEavU1e4W7kLP1twgNiuD+D/vcXdvy9O8WGPSbRuNP
	Jaz1KDLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJoEl-0000000Dg1w-3CE3;
	Thu, 22 Oct 2026 08:33:23 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJoEg-0000000DfyE-09wx
	for kexec@lists.infradead.org;
	Thu, 22 Oct 2026 08:33:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7226660A65;
	Thu, 22 Oct 2026 08:33:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A532E1F000C2;
	Thu, 22 Oct 2026 08:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792657997;
	bh=Sig2fRytiH3CoX3EJXsHl29TZlpoGoqp+70EEbroBwY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HwA/MW+hz/UlZq9o2AwUT0PWWvZGNTqZynhxdfNoWsVQLjF+1tzz6Sge5knm6RIFU
	 jTo9XuqJB1MpdvVOqeOTBeOAw2BWgVj3sXTlqbAGKAm4tT1UKfXIpHqjUHajYy1hUe
	 Fu6gMcUa3b08x/7vwMTtyTF0BDr7AyS3V4hf/5fJ7qeBMFW+zOa17j3Tge/wTbJZkE
	 zr54Sm2kjDzyFGv7FH095GHhlJ6w00ieOa8BUb1x5dkTUbXEpJPuyArWoTfC+eVbVW
	 pHUB3km8D7Ir3/z7oNQjNKJOfEyOHYBpGVnLMirDcsFqvI9H3MbQsx0KQtJwGeXIO2
	 KRaZPnVbrkmPQ==
Message-ID: <sashiko-outbox-181182@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 6/8] of: reserved_mem: add dumpable flag to opt-in
 vmcore
To: "Wandun Chen" <chenwandun1@gmail.com>, robh@kernel.org, baoquan.he@linux.dev, rppt@kernel.org, m.szyprowski@samsung.com
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, saravanak@kernel.org, akpm@linux-foundation.org, pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, robin.murphy@arm.com, kexec@lists.infradead.org
In-Reply-To: <20261021083011.2170525-7-chenwandun1@gmail.com>
References: <20261021083011.2170525-1-chenwandun1@gmail.com>
 <20261021083011.2170525-7-chenwandun1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 08:33:14 +0000
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

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

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021083011.2170=
525-1-chenwandun1@gmail.com?part=3D6


