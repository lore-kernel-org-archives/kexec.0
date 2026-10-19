Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE5DCCA490
	for <kexec@archiver.kernel.org>; Mon, 19 Oct 2026 02:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FexZ/8e1DoqVC/J2TRnL/bBGgp6aOB9jb0xut4TRK7k=; b=X5hozIki7BgMCZ7ceWuJaGXbiI
	KBoYYGm1aemDXBj+sIZmNIzmOAJI1ee0mxhjJLtL21DeodXCZ7FdOkTTge9Lvi7+697W43WD4PeOy
	vabAh/aW2QTCeTL0HKFfqsSwNzQH6jMsIiHCGNKvaP6a8wbYZ0d5hwMgm9slbv//gLN7oFKaR51US
	br+Xg3l2CEeREbJBq36j/uHnT6jxlguemoTx/zKm/kz9fK99CU7E6ArPDSMLlEAcaooKT/Owaxbtt
	3OEyXvYmoQc4nh5RSyznnVDmMY1UInpMyAqxpFcGhzFjlR2QkRyKHeDMnApwAZCqigwSb74A8s5hQ
	oFctmc4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIcxh-00000006SLf-2PWh;
	Mon, 19 Oct 2026 02:18:53 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIcxg-00000006SLQ-2Lz8
	for kexec@lists.infradead.org;
	Mon, 19 Oct 2026 02:18:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E6D964390C;
	Mon, 19 Oct 2026 02:18:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19291F000C4;
	Mon, 19 Oct 2026 02:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792376331;
	bh=FexZ/8e1DoqVC/J2TRnL/bBGgp6aOB9jb0xut4TRK7k=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=n77fhsbADt8elmC5k4mn+tEOC/YTmEcB3beZ4ew5lgQuylsIYOIxlDt6m8MuJpyJw
	 7X16xIu1otq4Am5XQHxZmxX3ZcCuSI6UXYxkQ88BiUWoVzn2sR7ZdymDqMnhHUJ5QH
	 49iIHRRI3aA5Lsu+t/VEhqGp8qt62xaCW4gVhpWZabSq86B209lGh87Fb/rBN/OGR9
	 Aumi/XfFa+PdhFL757Xg/35oDUscX9KF8mRrmzh99RaJk2EByWAN8qfCQTMhFmGBaM
	 xiOfBJe3ZfTO+zAT3LKGsDyuNVlPH0MG+Oz0CdcgybYGqHTG34amKIic09pRTWohiN
	 cVZ/TKplpzL+g==
Message-ID: <sashiko-outbox-176519@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/8] kho: move radix tree, vmalloc, and FDT helpers
 to internal header
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, rppt@kernel.org, kuba@kernel.org, enelsonmoore@gmail.com, bp@alien8.de, shuah@kernel.org, david@kernel.org, akpm@linux-foundation.org, ljs@kernel.org, mhocko@suse.com, skhan@linuxfoundation.org, vbabka@kernel.org, dapeng1.mi@linux.intel.com, corbet@lwn.net, surenb@google.com, kexec@lists.infradead.org, pratyush@kernel.org, rdunlap@infradead.org, elver@google.com, graf@amazon.com, lirongqing@baidu.com, liam@infradead.org, jlayton@kernel.org
In-Reply-To: <20261019021111.990394-3-pasha.tatashin@soleen.com>
References: <20261019021111.990394-1-pasha.tatashin@soleen.com>
 <20261019021111.990394-3-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 02:18:50 +0000
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

> Move the shared KHO radix tree key encoding and indexing helpers,
> vmalloc flag conversion helpers, and FDT validation and lookup helpers
> from kexec_handover.c into kexec_handover_internal.h as static inline
> functions.
>=20
> The radix tree and vmalloc flag helpers are small bit-manipulation
> routines, and the FDT helpers are small wrappers with a single call site
> per translation unit, so it is natural to inline them in the internal
> header.
>=20
> This is going to be used by the upcoming KHO read-only mode to walk
> preserved KHO radix trees, vmalloc preservation chains, and FDT
> subtrees without duplicating the implementation.
>=20
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019021111.9903=
94-1-pasha.tatashin@soleen.com?part=3D2


