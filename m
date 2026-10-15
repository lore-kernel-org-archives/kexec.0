Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06DE5CC6B33
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 14:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dyWegz/c74wQWzlIU/79EsgJoIZjWRx+HXCpkDaeZLY=; b=0WT4stu8mk9GksJkAqRx+zjbGH
	d93z/G0Wr02VVNCwe0bOQyCRz2dvmiOlRV9/JR7SUJMfWKFFqMzj/eRr+RSy8mKLhQOQtWf/UD3Jm
	DawHJB3QUYR1eBfp1BzWFjMgujnOoQjh65smE3kBHASE1G/A/nDT3E3S8ucd83OLKv/rXlGvFkWNH
	boppAn35I6zXOF43jhORmeNObP26qlMnvD1fQv2Cxc/DVeS5QB1N55K0dq4eE+etsvItLAAMGjWsf
	hYnkLV8f6mrR31mmFbsiyosw8QMOP+K5VXWvkXrDfI7i1BI41J004vH084qmm7bagn8IDZP9jNAzw
	bkXgY0/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHMrz-00000000SLf-3xYW;
	Thu, 15 Oct 2026 14:55:47 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHMrv-00000000SLO-3QTb
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 14:55:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DDF0160120;
	Thu, 15 Oct 2026 14:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B6A1F000C4;
	Thu, 15 Oct 2026 14:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792076142;
	bh=dyWegz/c74wQWzlIU/79EsgJoIZjWRx+HXCpkDaeZLY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QSauYQD2gNFT/UvDcMG422iuxdSZ2iXRl1eK0l0qDXR3cDaZ/q2DCn02q+13WrUNW
	 VNAlI4DgrfJ1lqE1RbzhjnaW1VTGQB4WD7qk6WKGgE42wIxf5cLP2vSu34FYE0mHfd
	 Ohkb2uxON8GGvtPvV1sUrWQOcBdZ+EsyavsbfsCx3br91pXXI+fd3hQPGf4KO4cofi
	 uQOCeNq1pvLghk4gpQfFcqH86Sr/q84YB2rAjMVB3ffMBtf2Z5CBfmX4GLUgQ6dU/9
	 GUIisjsxFSVf8tfrhNmIu+t7UoywqXukoE3gAANwgXR/+ZF5eVgif4yFA3deLI1tkF
	 qFLKurCaNmPMQ==
Message-ID: <sashiko-outbox-173012@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.18.y 1/2] kho: free chunks using free_page() instead
 of kfree()
To: "Federico Parola" <fparola@amazon.de>
Cc: "Mike Rapoport" <rppt@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Alexander Graf" <graf@amazon.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, kexec@lists.infradead.org, nh-open-source@amazon.com
In-Reply-To: <20261015144529.76911-2-fparola@amazon.de>
References: <20261015144529.76911-1-fparola@amazon.de>
 <20261015144529.76911-2-fparola@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 14:55:41 +0000
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

> From: Pratyush Yadav <pratyush@kernel.org>
>=20
> [ Upstream commit b15515155af735a86e5bcd67ed739162f0de27f5 ]
>=20
> Before commit fa759cd75bce5 ("kho: allocate metadata directly from the
> buddy allocator"), the chunks were allocated from the slab allocator using
> kzalloc().  Those were rightly freed using kfree().
>=20
> When the commit switched to using the buddy allocator directly, it missed
> updating kho_mem_ser_free() to use free_page() instead of kfree().
>=20
> Link: https://lkml.kernel.org/r/20251118182218.63044-1-pratyush@kernel.org
> Fixes: fa759cd75bce5 ("kho: allocate metadata directly from the buddy all=
ocator")
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Cc: Alexander Graf <graf@amazon.com>
> Cc: David Matlack <dmatlack@google.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Federico Parola <fparola@amazon.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015144529.7691=
1-1-fparola@amazon.de?part=3D1


