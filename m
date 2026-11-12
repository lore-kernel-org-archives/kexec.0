Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F39F606A323
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 07:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=MoPmVb91;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fu08OZlQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=1shLe9IVwY4D8MGt7zySWfM+B9KcuUz/MrZ+F8qYFDg=; b=MoPmVb91ZisCT779Sw8iZAv5W0
	jlIEtHO3UgC7OWa5W/6fo3BwVk37m55akyLYWXutJNS4ZEjkBLyzSTcY5CSzWMwZfc4VLTmtKwA+m
	xcy5h/Nho+O+EnEiRXCekUfwJghyn476csaPVOayBUJZ/NnLlH/1cOP7bJHfuVyqNJ0AdyI52F+2l
	p5fKJXPHg5oCcULR2y1jLLjf+5gfqJmFc55gHUdGIvVBFfqGCOo0VOsIi/4ruUfIkaGjlaU+YTWqd
	gMLrrqEtzYCDxVPpCkOE67V6u+3f0H3TPs/erxOKEUi+mQu4FjVEUNJOPn50D8fSZpb3Mg7MYA4/O
	HpBcmATg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRPdZ-00000008yvO-2CR6;
	Thu, 12 Nov 2026 07:54:32 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRPdN-00000008ynE-47Js
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 07:54:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BB41E439AD;
	Thu, 12 Nov 2026 07:54:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD0B1F00A05;
	Thu, 12 Nov 2026 07:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794470053;
	bh=1shLe9IVwY4D8MGt7zySWfM+B9KcuUz/MrZ+F8qYFDg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fu08OZlQ8jv8r8a4aCD6T9xznGvhCR3J/+EtYeo9RgUgjQPd2TwRcGcIRw5lNN7GC
	 K9trgRaolwg+mZfslPsUBLVX+oX9dbnkUn33AFayt0XCe2Ae1izF5s+KVyl6s/iOtY
	 K6++d+2r0Jk/a+OXeG9FWCncQZb1V3DsfI1F0wy0bAbfdz6jI8bybEEAuQJKdiWhKr
	 YMtdxMUOiaSB6VapNIjUoxaTzTQoI8NziP6eKRT+qfoMVGImJXhxAkbfxU8J1Fp3qQ
	 PXvBRjhcTfZqDVIusrnQaCYE9/MjQ3uS4kqxF+TdsQcjl/g6eRiFIeb8KgIEHlhiIz
	 60cPvTjv3ORVA==
Message-ID: <sashiko-outbox-210643@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/9] kho: Report how much handover memory is preserved
 and restored
To: "Chris Down" <chris@chrisdown.name>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, "Pratyush Yadav" <pratyush@kernel.org>
Cc: "Alexander Graf" <graf@amazon.com>, "Baoquan He" <baoquan.he@linux.dev>, "Jonathan
 Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, kexec@lists.infradead.org, kernel-team@meta.com
In-Reply-To: <920192d01c6534b5754648e12840f73cdcfa73de.1794383544.git.chris@chrisdown.name>
References: <cover.1794383544.git.chris@chrisdown.name>
 <920192d01c6534b5754648e12840f73cdcfa73de.1794383544.git.chris@chrisdown.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 07:54:12 +0000
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

> Most memory the previous kernel preserved stays reserved until its user
> restores it through KHO, either to use it again or to free it. If
> nothing does, it stays reserved for as long as the kernel runs. On a
> hypervisor host that can be gigabytes, but amusingly nothing really
> shows it reliably. The host simply has less memory than it should, which
> is not exactly obvious.
>=20
> All preserved memory is reserved in kho_preserved_memory_reserve(), and
> everything restored through KHO goes through kho_restore_page(), so KHO
> can count both easily. Let's add preserved_size and restored_size, in
> bytes, to /sys/kernel/kexec/kho_incoming/.
>=20
> For example, after a live update preserving a 64 MiB memfd:
>=20
>                      preserved_size  restored_size
>     before retrieval       67403776           8192
>     after retrieval        67403776       67395584
>=20
> The 8 KiB left are the incoming KHO FDT and LUO's FLB header.
>=20
> Signed-off-by: Chris Down <chris@chrisdown.name>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794383544.gi=
t.chris@chrisdown.name?part=3D7


