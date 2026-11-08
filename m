Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26743606A31C
	for <kexec@archiver.kernel.org>; Sun,  8 Nov 2026 19:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vwonzK/z;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hxX+GNpp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=NV/yQ+bbys08EWW5BKKubq/IKhYKNF9d2qVqDr2vxDk=; b=vwonzK/zeM8T+2BJQxpMiyAOw+
	W2eHzZ+3fjX8yqIMnRocV6WueFKGGycBoXo1yrU7cfxROEeJyRxpV4xiRf8DhDfNnaJvHVTbvyBz6
	PvRVAuTtOnRvGcJE4yZQGx4q4Q+iXZn696MgEebQIW/ql1AjLDRbYVr/xnQP09LqAoRKZwV5B8CUK
	LpaBXtgZ15CKl0kQdTHtGbyy6AYRDY26Ll8s510E/7Y2ytXSLqajIpruEqTXp6ss4GmY0GwyqppZ2
	Gnn8Jr4GOeBzktbxQXK2GV1dXrdxbD0nTXp70gmkwFvu4Yf3ZE+aYSiWJBBwLn+LBNTch7TrvF6Kk
	pBLipy4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ8Q3-0000000GVuW-10D9;
	Sun, 08 Nov 2026 19:19:11 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ8Q1-0000000GVuQ-1vjW
	for kexec@lists.infradead.org;
	Sun, 08 Nov 2026 19:19:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 617BC61907;
	Sun,  8 Nov 2026 19:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943991F0089F;
	Sun,  8 Nov 2026 19:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794165548;
	bh=NV/yQ+bbys08EWW5BKKubq/IKhYKNF9d2qVqDr2vxDk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hxX+GNppHjNMZegi7HRZWEUzzzGMaI6R78y5+1t4loK6bjfGWOFqiayMx2v5Uoe02
	 tpl6pDaRkYM7ubclLKd88zPysesMg+RO37jlnd4FaXCjODt9zwRKRnaiJFOpikW0/j
	 K+c4coPD3IsTrSJe521w+AgMQx6n4uOgN19spIkSEFmSMLyL3Zo/dHCgd20sbcmk7c
	 +owr88UnWBmhkvlwfvLxlb1YOv+xMXSZhH0sVdWX/erXuLhbxoRRR2KWIfHmuyVRQZ
	 K2Sjkd4pZfDF9rimzTUwq2siaPYCk5wI3gD2C3Xdke7ON2QZhENWFHZqvZrFKaV0nt
	 bLnHEm0kXNQLw==
Message-ID: <sashiko-outbox-203933@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ima: fix kexec measurement buffer overflow after failed
 loads
To: =?utf-8?b?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Baoquan He" <baoquan.he@linux.dev>, "Mike
 Rapoport" <rppt@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Mimi Zohar" <zohar@linux.ibm.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>
Cc: "Eric Snowberg" <eric.snowberg@oracle.com>, linux-security-module@vger.kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261108190404.1397829-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261108190404.1397829-2-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 19:19:07 +0000
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

> When kexec_file_load() fails to install a new image, it can leave the
> global IMA scratch buffer larger than the IMA segment of the current
> image. When that image is executed, ima_update_kexec_buffer() copies
> the larger log past the end of its reserved segment. In a test, KASAN
> reports it as:
>=20
>   BUG: KASAN: vmalloc-out-of-bounds in ima_update_kexec_buffer+0x265/0x280
>   Write of size 868426 at addr ffffc9000004e000 by task init/1
>   ...
>   Call Trace:
>    ...
>    __asan_memcpy+0x3b/0x60
>    ima_update_kexec_buffer+0x265/0x280
>    ...
>    blocking_notifier_call_chain+0x88/0xb0
>    kernel_restart_prepare+0x18/0x40
>    kernel_kexec+0xe4/0x130
>=20
> Limit the dump to the smaller value between the scratch size and the
> installed image segment size. Update the IMA mapping only after
> machine_kexec_post_load() succeeds.
>=20
> Fixes: 9f0ec4b16f2b ("ima: kexec: move IMA log copy from kexec load to ex=
ecute")
> Cc: stable@vger.kernel.org
> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108190404.1397=
829-2-Jeremy.Jean@oss.cyber.gouv.fr?part=3D1


