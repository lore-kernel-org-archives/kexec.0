Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BE5606A328
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 20:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=aRFUlA7r;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ks04bzIY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:Reply-To:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date
	:Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=cajAByUeZEfXA46wL2DP0e8bMTdgT7qZWKnAlu0+L/s=; b=aRFUlA7rj/J/hs58umLvwOVxnZ
	oZQdLB43WhdQkL7/VijsDIpol95oxDnZxDOVKiv4y3Xas4mIKkaZTaEof0X+iYA6Q6CIekLRx4wEg
	7PRn1Tm/YRBkXfeRpk47d/T9zG31rPFinFVu4BGMicPKAjnfKj2oPqjZe9Z9zRWKwJ++Xx9InNqDb
	j9Rl13dIpjDanEPgKGdi/GpFt2aUddJTjut91pyjg8q4rftgvyRQUflfOIIKkoxxCYqiSCWbAIp+f
	3xVMiOzjnFkmhEhWy70JZirJfDzLjsOebc0yr0++GqsIiRpzya1o6rUZNN5v357iDyawT0CyM5biv
	wfwi1riQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP4Jd-0000000AbP2-2LnH;
	Thu, 05 Nov 2026 20:44:09 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP4Jc-0000000AbOr-0i76
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 20:44:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5F997602D4;
	Thu,  5 Nov 2026 20:44:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD3B1F0089F;
	Thu,  5 Nov 2026 20:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793911447;
	bh=cajAByUeZEfXA46wL2DP0e8bMTdgT7qZWKnAlu0+L/s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ks04bzIYP6YRtJvKU9ftPmzODeSu7My0kic3OATKm6VhntC0VtavJQ3HMcEFGE/9F
	 SpZKoJezE0BGBR8g1vnZqUNcnnARDQ10AfpXGiBdX5aAv8OEwBxbq5luUMbM7YuJeJ
	 caEqF/UBjGgcM4o+IJ5M2L1VVUIQT5/Bw/PS1ufM1Dg+BRW0OLZAKzLU788n1yOHYo
	 oEeoYGiHtrOPq0Vfu3Egc8G0rmrKgY3VK+2GLKMNXYIjPIZ9b/RsJgQ17ov95J/0B7
	 TdsNGb8g0o0LkVWTLEuoQQ7ZHdrlk9LaU1FXuPJG9za71KkPG0yHD61lcTCKxCPqu+
	 z8CF4TnQirVVQ==
Message-ID: <sashiko-outbox-200129@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] memblock: don't allocate new reserve_mem regions on
 a KHO boot
To: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, "Mike Rapoport" <rppt@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Kees Cook" <kees@kernel.org>, "Changyuan
 Lyu" <changyuanl@google.com>, "Alexander Graf" <graf@amazon.com>
In-Reply-To: <20261104204235.9066-1-azpijr@gmail.com>
References: <20261104204235.9066-1-azpijr@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 20:44:06 +0000
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
Cc: Tony Luck <tony.luck@intel.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org, kexec@lists.infradead.org, Pratyush
 Yadav <pratyush@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] memblock: missing is_kho_boot() stub breaks tools/testing/memblock =
build
--

commit 19549caf363a437d6178ec835c2f8f9d0ecc7f1d
Author: Jose A. Perez de Azpillaga <azpijr@gmail.com>

memblock: don't allocate new reserve_mem regions on a KHO boot

This patch rejects allocating new reserve_mem regions during a KHO boot
when the region cannot be revived from the previous kernel, returning
-EOPNOTSUPP instead of allocating from KHO_NOPRSRV memory.

> diff --git a/mm/memblock.c b/mm/memblock.c
> index a450092a80fb5..e325e0542c9a8 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2827,7 +2827,16 @@ static int __init reserve_mem(char *p)
>  	if (reserve_mem_kho_revive(name, size, align))
>  		return 1;
> =20
> -	/* TODO: Allocation must be outside of KHO_NOPRSRV region */
> +	/*
> +	 * On a KHO boot memblock only allocates from KHO_NOPRSRV memory here,
> +	 * which includes the bootmem the next kernel boots out of. Only regions
> +	 * handed over by the previous kernel are supported.
> +	 */
> +	if (is_kho_boot()) {
> +		pr_err("reserve_mem: can't allocate \"%s\" on a KHO boot\n", name);
> +		return -EOPNOTSUPP;
> +	}

[Severity: Low]
Does calling is_kho_boot() in reserve_mem() break the user-space memblock
test suite build in tools/testing/memblock?

When building tools/testing/memblock, mm/memblock.c is compiled with -I.
before -I../../include and without CONFIG_KEXEC_HANDOVER defined. As a
result, #include <linux/kexec_handover.h> resolves to the empty stub header
in tools/testing/memblock/linux/kexec_handover.h rather than
include/linux/kexec_handover.h:

tools/testing/memblock/linux/kexec_handover.h:
    #ifndef LINUX_KEXEC_HANDOVER_H
    #define LINUX_KEXEC_HANDOVER_H

    /*
     * Header stub to avoid test build breakage; we don't need to actually =
implement
     * any KHO functions as they are not used in the tests.
     */
    #endif /* LINUX_KEXEC_HANDOVER_H */

Other KHO helpers called unconditionally from mm/memblock.c, such as
kho_bootmem_overlap(), have stubs in tools/testing/memblock/internal.h:

tools/testing/memblock/internal.h:
    static inline bool kho_bootmem_overlap(phys_addr_t phys, size_t size)
    {
            return false;
    }

Should a stub for is_kho_boot() be added to tools/testing/memblock as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104204235.9066=
-1-azpijr@gmail.com?part=3D1

