Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994BECC6B38
	for <kexec@archiver.kernel.org>; Fri, 16 Oct 2026 06:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rqRuRjY6SfVPZz6kADAnUqQu2zSeg0i7Rhj36sY7u2Q=; b=sT4GGAVbzV331H/J42SNvwhOPK
	vFLAxv5+h3pzHfx0aVVAZ09hon3/Tcg1n6Mn+cUs48HO+lCs6uQTr88//iiTmTthowo1F8fJYb4O0
	QqGmH0oNhbZLQ5U1pY8yn2q3YwmNWjwRUV+4BM7WyO5/0cSsEEIdNPIZWnkk4MrHtZ4XemMSAy21m
	UVV8sDdhimqj+y3XiYshU/o0K/Sysc3ANoJfnD5980zBUqcTNXMYIgniZRt97RqY+BwPK6GesZcuU
	hQ4P6K5b9n8Zz3o5zaIfVZIRSg20UZiwijr5duJjiBbyMSs8GWvraEUw1cYbjlZuBAV0oTpIwIemQ
	Q++zaIHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHbOA-000000027TH-2sOD;
	Fri, 16 Oct 2026 06:25:58 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHbO9-000000027Sz-1XmZ
	for kexec@lists.infradead.org;
	Fri, 16 Oct 2026 06:25:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CCF62600D4;
	Fri, 16 Oct 2026 06:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B501F000C4;
	Fri, 16 Oct 2026 06:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792131956;
	bh=rqRuRjY6SfVPZz6kADAnUqQu2zSeg0i7Rhj36sY7u2Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jv6oypGhezhuuA4JOWxH4iz0QU6/AV09ZEVn+PYOoNPVWoX7uCF2y4TrxG2kz1jpy
	 hI2UofEGM/9BdK81x3nqPckJUEpYCiW3fQtutpuNML90aHIMQz3JH8Ku9Ymnsp9vbX
	 QkQyeX/5DcnS9KdgUKwLIAd85lcaiIpH8yWX31FQPaYRGq8BlP58rJBndqmMGgF8hi
	 jsxmk7yH2eGkRS1k5jpsSLZ9fUXONViKFr/0segGucqsazqzDtuY49QHSSejGAmyxJ
	 RkRVtLvAfO9aTdwSWNb17LwiojvSgdsJ3IeJ7Ikl82w4NHAciq0EQx+CDaI1CWm3os
	 BmKXY68OGjT/w==
Message-ID: <sashiko-outbox-173857@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RESEND PATCH v8 8/8] crash_core: skip MEMBLOCK_NODUMP regions
 when building vmcore ELF header
To: "Wandun Chen" <chenwandun1@gmail.com>, robh@kernel.org, baoquan.he@linux.dev, rppt@kernel.org, m.szyprowski@samsung.com
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, saravanak@kernel.org, akpm@linux-foundation.org, pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, robin.murphy@arm.com, kexec@lists.infradead.org
In-Reply-To: <20261016061549.4181390-9-chenwandun1@gmail.com>
References: <20261016061549.4181390-1-chenwandun1@gmail.com>
 <20261016061549.4181390-9-chenwandun1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 06:25:55 +0000
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
> Reserve regions (for GPU, DSP, ...) carry no data useful for crash
> analysis. Exclude MEMBLOCK_NODUMP regions from the vmcore ELF header to
> reduce vmcore size and capture time. crash_should_skip_region() now also
> returns true for MEMBLOCK_NODUMP.
>=20
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016061549.4181=
390-1-chenwandun1@gmail.com?part=3D8


