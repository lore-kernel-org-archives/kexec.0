Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B082CCA462
	for <kexec@archiver.kernel.org>; Fri, 16 Oct 2026 06:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hgQuvmANTd0vBPglWkuNSZISoeFICBvTu/e4sMw04c8=; b=ne1z1OEGJu5fk0w5oKec8QsABb
	03DLppQg1X15anuh1Fcac7xkMwyFXCGpP6be/vWFz41VSPGD4tUa90YGqgZUVvxNwRT+PSuKujEdJ
	DzZU/5LY3q7EMpQIpNv3nUdJZDlk44APfr5kItE/E2H47Otzm8bIbjKseMu1i2kmoTK5Re0/KO9Ru
	TYUNBSlUrgEIWHKExUNLF2dZTfXS8RB23748jFyQOC+M6rnGrcB+c60qm8Tb/t7xO3XyUyGMoiWJl
	z0NgkuW2IgahYz/10AZA2bA/eBl9lhJLXIDyMRV28AbK1l/x6xDEuoM3QOFW9ZtYbZuoy9uNt22B3
	n9PXoIIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHbSU-000000027s5-1YYY;
	Fri, 16 Oct 2026 06:30:26 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHbST-000000027rt-1tjz
	for kexec@lists.infradead.org;
	Fri, 16 Oct 2026 06:30:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2913D416D0;
	Fri, 16 Oct 2026 06:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95D01F000C4;
	Fri, 16 Oct 2026 06:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792132225;
	bh=hgQuvmANTd0vBPglWkuNSZISoeFICBvTu/e4sMw04c8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OqSCOcs7s0wQWUv8ry1uUR33Co1FsKJKUONNEWEHPFIVz3+cTeYarKONK0owF1NrB
	 xXhgCYhbRcFuVrM/OMKcbeW4zCtEgJaTaYup+itHS8JwBd4rMgNIVOjDU31PIQfDC6
	 /VrHR56UVU4wQ1cfhxU1B7x2HuOm9LbtYvq36umSpKj6DxJIyaQ+x4IQjWO52eUj/P
	 YSmO3vhjbY47b4SGogl9wS3dJ4tuA2EasgesL956LlGol/1avw0Wkk5K50j4J6JHTU
	 tdPJaVMnywcyCzae4QZRPH2QQR3/zIkOXeu05RLoxnRaRhvoiTbhOrgIDikLVkgR9o
	 TaA5aICowxu/w==
Message-ID: <sashiko-outbox-173865@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RESEND PATCH v8 2/8] crash_core: fold duplicated memblock arch
 hooks into the weak default
To: "Wandun Chen" <chenwandun1@gmail.com>, robh@kernel.org, baoquan.he@linux.dev, rppt@kernel.org, m.szyprowski@samsung.com
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, saravanak@kernel.org, akpm@linux-foundation.org, pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, robin.murphy@arm.com, kexec@lists.infradead.org
In-Reply-To: <20261016061549.4181390-3-chenwandun1@gmail.com>
References: <20261016061549.4181390-1-chenwandun1@gmail.com>
 <20261016061549.4181390-3-chenwandun1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 06:30:23 +0000
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
> arm64, loongarch and riscv open-code the same memblock walk in
> arch_get_system_nr_ranges() and arch_crash_populate_cmem(). Move it into
> the __weak defaults in kernel/crash_core.c and delete the arch copies.
>=20
> No functional change.
>=20
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016061549.4181=
390-1-chenwandun1@gmail.com?part=3D2


