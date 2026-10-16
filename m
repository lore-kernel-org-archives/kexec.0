Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F6BCCA462
	for <kexec@archiver.kernel.org>; Fri, 16 Oct 2026 06:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wBAD4mrMe+RGYudEGjb+zpWtNEVxspqNQHJ2+VZGMP0=; b=UvoDV1IyipHhXehzUVJJYSBahT
	qUFKLLs5PKSUbADCOOgJ7pJGhjfBHMd3o0m2DpYlw1mPQvwlPgrXJfeOKQf4UYmDhxEl4LLbnS9z0
	W8apogpu6RUXetL+ntVG5wEaickqU2AZH10yrVjdLsUnKb4hW1S9dwhzM3FlorRF2SvPvc058UTIR
	eZlv0Vr6f9wtlcTLoOB6COQkLRz0CGYHARlzRiu/Yq4Y7BK5gPdw+EoKeQ0A1shwXuoXCI+coIIeM
	yufeVBPdqd304Gq0nUpeEl4/cc/jtTGYYupHheuxKJNhuCTpSc8O+4a0gKEDYfkMA+rAzgwZk0Y+C
	1dozS0Hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHbRG-000000027jN-0vby;
	Fri, 16 Oct 2026 06:29:10 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHbRE-000000027io-0UDF
	for kexec@lists.infradead.org;
	Fri, 16 Oct 2026 06:29:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 917A841775;
	Fri, 16 Oct 2026 06:29:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88ADA1F000C4;
	Fri, 16 Oct 2026 06:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792132147;
	bh=wBAD4mrMe+RGYudEGjb+zpWtNEVxspqNQHJ2+VZGMP0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VEfTAUxnWfHO5KGYg+kIxa3bGfUm4LCLUeOBKligHyQJHIiQjKIfQ5SoYEjhjEeJk
	 oFiM1ZHNwnxuQrvX6GL/xWfhwzgSXuHBQGdJrIe7Q0iXUIW+NB5cc1gglY+qygk79z
	 Pk/WuQNQV2SKUKwzksv8XoJwjPXNlGb35JPaX2MbZJ1rN528m85nOJjYTQs0+Y30gh
	 s7VwWaODSi5YuHCOvPlqWCzqozRC07Qd/sVAjgjd5GIgTDgsvO6woCwEzFLnYJ47FL
	 NUJMnQYSsEh3nFyk8dW/wQoBKf6ee0G9MwN51mXHVeqIbhU7xojiYfBn46OqIIFpcR
	 ADZQHcZDXuT5w==
Message-ID: <sashiko-outbox-173862@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RESEND PATCH v8 4/8] crash_core: replace for_each_mem_range()
 with for_each_mem_region()
To: "Wandun Chen" <chenwandun1@gmail.com>, robh@kernel.org, baoquan.he@linux.dev, rppt@kernel.org, m.szyprowski@samsung.com
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, saravanak@kernel.org, akpm@linux-foundation.org, pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, robin.murphy@arm.com, kexec@lists.infradead.org
In-Reply-To: <20261016061549.4181390-5-chenwandun1@gmail.com>
References: <20261016061549.4181390-1-chenwandun1@gmail.com>
 <20261016061549.4181390-5-chenwandun1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 06:29:06 +0000
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
> for_each_mem_range() skips MEMBLOCK_NOMAP regions implicitly. Switch the
> weak defaults to for_each_mem_region(), which exposes struct
> memblock_region and per-region flags, and filter NOMAP regions explicitly
> via the new crash_should_skip_region() helper. This prepares for a
> subsequent patch to extend the skip filter.
>=20
> No functional change.
>=20
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016061549.4181=
390-1-chenwandun1@gmail.com?part=3D4


