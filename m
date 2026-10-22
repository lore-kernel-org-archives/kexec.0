Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F46606A328
	for <kexec@archiver.kernel.org>; Thu, 22 Oct 2026 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IBikKg2H;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CLPxSJLu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=zxfh/bVyc6luYNg6f0sqJGtSpFedqQg0oJhjzoT/Dxg=; b=IBikKg2HD+me22ODag1N8zRxsg
	AusCsQFvFfxEp7Hvg4c1js8IWkONJjeDFnB4U1+GpdmDWSKOqgxzWI3GvdCTZFZY9tBTfAUzFa+eC
	upoJF0s9a9OB7WH/+lDTczECFo8b1MgQn0znIM9UOwxzwvI5v+dkwORngcd+uELQFGgyJUnwCE5nt
	nBwPZqtDyuGouP54PkSPbmBBXQhLhM6rZHnZkZ5ZlCqpyG9j75qT9X89YOMepN1P0N1rgrGP/b4N9
	sejdFoq1KUNRX4dZzMoruu87nthe61MIpRA1H9WXnio1Upu0wHakdStwQNSrkBhguCd8IpzTy7fro
	IhU8tQbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJoEl-0000000Dg2L-44Wy;
	Thu, 22 Oct 2026 08:33:23 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJoEj-0000000Dg0t-3lkx
	for kexec@lists.infradead.org;
	Thu, 22 Oct 2026 08:33:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9553643583;
	Thu, 22 Oct 2026 08:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061111F000C1;
	Thu, 22 Oct 2026 08:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792658001;
	bh=zxfh/bVyc6luYNg6f0sqJGtSpFedqQg0oJhjzoT/Dxg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CLPxSJLu3dVzVG6rmiyxzHQ34n3rM+eWI+GASmkyfbyZ1b4fKLJvg3k30i1QUHQbX
	 2V2JYetvj43lIyE+zsAxktSDLxfuMorQzpl9B8PY1KvRZ1VfAGbQPFfLhkII/Dkb75
	 8pIFqQF7eCdraRWoW7Ip3EaoqJABGwEBbTVuQmjvBoAZjiHZBKY+dseP8sJifpXf40
	 cDidlZDTIjwrsBfMfW7YIN/XmJejmZVQEA2Im+hI3RCoEWY3v/CmqiuFH32HyBLfj/
	 SFV7M74LC0/2uo94g7cjUNUkKBYkg7uG+oWKmIzOSywsF3vRFvRHM7giXebxv2Q+v0
	 OPzgy2tPv29ag==
Message-ID: <sashiko-outbox-181184@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 8/8] crash_core: skip MEMBLOCK_NODUMP regions when
 building vmcore ELF header
To: "Wandun Chen" <chenwandun1@gmail.com>, robh@kernel.org, baoquan.he@linux.dev, rppt@kernel.org, m.szyprowski@samsung.com
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, saravanak@kernel.org, akpm@linux-foundation.org, pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, robin.murphy@arm.com, kexec@lists.infradead.org
In-Reply-To: <20261021083011.2170525-9-chenwandun1@gmail.com>
References: <20261021083011.2170525-1-chenwandun1@gmail.com>
 <20261021083011.2170525-9-chenwandun1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 08:33:19 +0000
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
> Reserve regions (for GPU, DSP, ...) carry no data useful for crash
> analysis. Exclude MEMBLOCK_NODUMP regions from the vmcore ELF header to
> reduce vmcore size and capture time. crash_should_skip_region() now also
> returns true for MEMBLOCK_NODUMP.
>=20
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021083011.2170=
525-1-chenwandun1@gmail.com?part=3D8


