Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06DDBC982D7
	for <kexec@archiver.kernel.org>; Fri, 18 Sep 2026 20:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q17JrGUK4X2t1hdvERj4yssWTWrML9FbBLdlOjJS310=; b=x4weWiJrCv3Umkqcz/Q/ldSNjA
	DpETsditS1p3FFYfWsCD1ty9ZGLjSG1QoOfAuStj9KosfpPDul/N4isDBltioHI6Fn2++fPRp/K7F
	DYEDxt0RGwmO0B7YpIYVuwSTHfuuyHrAa+qxp4V5DtrEPyEj4AVNX3gvSMEj5px1WdF1SKbUwU95l
	QliGaiKIVWh6u/ZXZgl/tKuM9FfwD2RXcG0eB3SBJ9/QYO1zpCRiF2yZ5PzdKy/upJ3XXr8XXjBNc
	KQm9MaFcCJ8a17KS+aDNcqLBRFJCYVZfsX2chYK03whr6Or10B4OPGuYxTaeLQnfGwKxzLICxgN+p
	uxfx/5+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7eyn-0000000FUlK-1WeK;
	Fri, 18 Sep 2026 20:14:41 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7eyl-0000000FUkd-08EI
	for kexec@lists.infradead.org;
	Fri, 18 Sep 2026 20:14:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 911CF42002;
	Fri, 18 Sep 2026 20:14:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DEB01F000FF;
	Fri, 18 Sep 2026 20:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789762477;
	bh=Q17JrGUK4X2t1hdvERj4yssWTWrML9FbBLdlOjJS310=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ETBEHQSjaEbWTS0FCNxpNsb4d8LaDdQvdvmy91bRbiFD/AtP90FJQjYsAaWVb2aqA
	 OmMgE7vCtF8xOjhn9m38ewd62M/91G0v6uoI1y+8AMBTyOmyK0tXrJV60eaBtA8ZVB
	 ZnpMvv3o7E33QrBp5wb5ZnyRGO5/VBIPM1JVEpN1nKSQ0KIxK3vBeW11oCyqgdI7e/
	 7CwIRWGIipa5Q1VNV7xrMLrNBkL1KIOKc6hU2iUjiyTsqlwWBgx/M18t1++jdRB+NE
	 ulLb1dshJBfQS38N259RH8mEbQROFMLVWMYs6vE2xJRh1NWybcJ+jM/Gtl79jg9t5L
	 hbf9pGUtrElYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 13/13] Documentation: PCI: Add documentation for Live
 Update
To: linux-kernel@vger.kernel.org, "David Matlack" <dmatlack@google.com>, linux-doc@vger.kernel.org, linux-mm@kvack.org
Cc: "Randy Dunlap" <rdunlap@infradead.org>, "Lukas Wunner" <lukas@wunner.de>, kexec@lists.infradead.org, "Adithya
 Jayachandran" <ajayachandra@nvidia.com>, "Alex Williamson" <alex@shazbot.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Shuah Khan" <skhan@linuxfoundation.org>, "Jacob
 Pan" <jacob.pan@linux.microsoft.com>, "Pranjal Shrivastava" <praan@google.com>, "William
 Tu" <witu@nvidia.com>, "Bjorn Helgaas" <bhelgaas@google.com>, "Alexander
 Graf" <graf@amazon.com>, "Jason Gunthorpe" <jgg@nvidia.com>, "Parav Pandit" <parav@nvidia.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Vipin Sharma" <vipinsh@google.com>, "David
 Rientjes" <rientjes@google.com>, "Jonathan Corbet" <corbet@lwn.net>, "Pratyush
 Yadav" <pratyush@kernel.org>, linux-pci@vger.kernel.org, "Mike Rapoport" <rppt@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, "Josh Hilke" <jrhilke@google.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, "Chris Li" <chrisl@kernel.org>, "Yi Liu" <yi.l.liu@intel.com>
In-Reply-To: <20260918200640.887030-14-dmatlack@google.com>
References: <20260918200640.887030-1-dmatlack@google.com>
 <20260918200640.887030-14-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 20:14:35 +0000
Message-Id: <20260918201436.0DEB01F000FF@smtp.kernel.org>
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

> Add documentation files for the PCI subsystem's participation in Live
> Update.
>=20
> These documentation files are generated from the kernel-doc comments in
> the PCI Live Update source code. They describe the File-Lifecycle-Bound
> (FLB) API, the device tracking API, and the specific policies applied to
> preserved devices (such as bus number inheritance and bus mastering
> preservation).
>=20
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918200640.8870=
30-1-dmatlack@google.com?part=3D13


