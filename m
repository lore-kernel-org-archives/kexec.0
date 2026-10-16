Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B137DCCA462
	for <kexec@archiver.kernel.org>; Fri, 16 Oct 2026 06:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6w/wAauJG26+DKypdnvFxMcj6PYbuiz11JJWb4JPW+k=; b=YY1mpYg7vDE1LqPGMmnx6ncPgj
	ItUJchI8UXsS6v/VjvAf0dh7YDFffijkboo3DAlOmdvLi0YFKYXV3kNN7Emz/bfNdXjlxFVsk5llm
	bqy6qxzOHP9ICG9GTrxWu8WQQMwjjDK0DxxN+yioUwwwJG14hWKXhJmq+qeKZzswwMya97V3BdU5o
	x7Ltnqn0J/dAYF8ixHL3FR2as1pg5Il5jbN/2/+rHhlqtQC3hFjKkO1EDTNndy9f0srpBOxR33yu5
	13Hjo+HhdP6ubBYQRMx7ACjyomjj2PQJSqOlojUcA5NmkOfg9TKEACGUb3VoqRUOkxWdqiH7pp3dZ
	4zOL5vGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHbVr-00000002880-3AyC;
	Fri, 16 Oct 2026 06:33:55 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHbVr-0000000287s-13Wz
	for kexec@lists.infradead.org;
	Fri, 16 Oct 2026 06:33:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7823560018;
	Fri, 16 Oct 2026 06:33:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5E51F000C4;
	Fri, 16 Oct 2026 06:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792132434;
	bh=6w/wAauJG26+DKypdnvFxMcj6PYbuiz11JJWb4JPW+k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fY04TTf6A9HkiPzILEPg2dbgtA1AHZ/2ytUsnN6Ju9+ZC/zv5TASh2nBSTjKQQqBz
	 oFjUyjDMNDfQEDbOJ9/pOZeGpDvm6eHq09PM7GmpKy7qF8zpTEgF6J4mxuDwFgcNVn
	 UlHYWcHs+NRqYUngDL0LXOIe2pmTCb3ATid8VMoB9tEaNkmqvZ9fNulWSTcpIps+UP
	 LKaSqyqZLX8LSEPAbF2vSuGAxuQGabFYjGMp8Jl9/XGcI7l3vQj9W06dhjXHc4OoNd
	 Hq1QvN/48it3dDJPZGXHKmbYCUVxD4VB6/W5jf2kVX26jOGscrP0O4QodfYwv1sf60
	 GUV66NDjaCshw==
Message-ID: <sashiko-outbox-173869@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RESEND PATCH v8 3/8] crash_core: serialize crash header
 preparation against hotplug
To: "Wandun Chen" <chenwandun1@gmail.com>, robh@kernel.org, baoquan.he@linux.dev, rppt@kernel.org, m.szyprowski@samsung.com
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, saravanak@kernel.org, akpm@linux-foundation.org, pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, robin.murphy@arm.com, kexec@lists.infradead.org
In-Reply-To: <20261016061549.4181390-4-chenwandun1@gmail.com>
References: <20261016061549.4181390-1-chenwandun1@gmail.com>
 <20261016061549.4181390-4-chenwandun1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 06:33:52 +0000
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
> crash_prepare_headers() counts memory ranges before populating the
> allocated crash_mem array. The weak implementation used by ARM64,
> RISC-V and LoongArch walks memblock.memory, while x86 performs the same
> two-pass operation over system RAM resources. Concurrent memory hotplug
> can change range source between the two walks and make the populate
> pass overflow cmem->ranges.
>=20
> Take device_hotplug_lock when preparing crash headers during
> kexec_file_load(). The x86/riscv memory hotplug path already takes
> device_hotplug_lock, so call __crash_prepare_headers() directly
> to avoid recursive locking.
>=20
> Sashiko reported this issue in [1].
>=20
> Fixes: 3751e728cef2 ("arm64: kexec_file: add crash dump support")
> Fixes: 1bcca8620a91 ("LoongArch: Add crash dump support for kexec_file")
> Fixes: 8acea455fafa ("RISC-V: Support for kexec_file on panic")
> Fixes: dd5f726076cc ("kexec: support for kexec on panic using new system =
call")
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016061549.4181=
390-1-chenwandun1@gmail.com?part=3D3


