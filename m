Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40992CC6B1A
	for <kexec@archiver.kernel.org>; Tue, 13 Oct 2026 16:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gvPKHDZ9PXmqAfRqRoBQE5C1e2Kg8stYE+1iBXMRupg=; b=Vj/y15FPcCOenT8uTVsEAJcSyu
	s/gKN3xMDPmblJESpCOPNsLonlLc/oiwjgk+iFZ2MyMGDsjybLhSuh7xRRzwJdcS7SLGcnxumdnWE
	IIVEs9X5iKXomGgjq4pQgT3GUmYq5fvhzh3chXltV+Sbssf4XlmiLU6GVNF320bo/0peWUOUlv5tl
	Gb0gsAHcrc+SaA0jPAHiPPG2IV9Yb3Y7INREU5oHMiNzeO0fB+8ff4ryJ34r+loFLMdvAXBMRw7Cm
	iGC2lMX8H2UfsVusxGm8b6pirEeP85/Wy2GdlK8ZK81/iJssaM/GOoHmoCAJQHGKs2azoHmQRNcl5
	Ne8xTbMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfZH-0000000DZUM-1mmu;
	Tue, 13 Oct 2026 16:41:35 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfZE-0000000DZTI-3fB1
	for kexec@lists.infradead.org;
	Tue, 13 Oct 2026 16:41:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5101F602C3;
	Tue, 13 Oct 2026 16:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188B41F000FF;
	Tue, 13 Oct 2026 16:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791909692;
	bh=gvPKHDZ9PXmqAfRqRoBQE5C1e2Kg8stYE+1iBXMRupg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hGtD6FS2Z0u2Iz2gXS/7rWoxt7Y92I+e9s6jHrwSrB68GEzWkxaDgRt/Jn6poQPqL
	 APIvg2tJGphgf1wmaE4IGKqWSw8JjBU2jNU5rIl5hvjwQTa7T6B2RMcm+CNqE+/IYO
	 TXSJ8vYplnPF6UWmOwRewK93sQ1R06O/ygIRAJn2jgV5JQuecxROzszbPu7W2jAheZ
	 e3coj81KRh9LUnCTQn9XUYWj/ZlITAGeVn4Hgm36dodOYxrjEGur6R5WPdt9dTprT1
	 ysrUACReRQUVQmypoMkjz5ug2jiv+HcxDpkscOXr2+WIGc/AGllHu47ZW5ewoiOejx
	 jUeURDmOYOvSg==
Message-ID: <sashiko-outbox-170138@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 05/13] PCI: liveupdate: Auto-preserve upstream
 bridges across Live Update
To: "David Matlack" <dmatlack@google.com>, kexec@lists.infradead.org, linux-pci@vger.kernel.org
Cc: "Adithya Jayachandran" <ajayachandra@nvidia.com>, "Alexander Graf" <graf@amazon.com>, "Alex
 Williamson" <alex@shazbot.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "Chris
 Li" <chrisl@kernel.org>, "David Rientjes" <rientjes@google.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Jonathan Corbet" <corbet@lwn.net>, "Josh
 Hilke" <jrhilke@google.com>, "Leon Romanovsky" <leonro@nvidia.com>, "Lukas
 Wunner" <lukas@wunner.de>, "Mike Rapoport" <rppt@kernel.org>, "Parav Pandit" <parav@nvidia.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pranjal Shrivastava" <praan@google.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, "Samiullah Khawaja" <skhawaja@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Vipin Sharma" <vipinsh@google.com>, "William
 Tu" <witu@nvidia.com>, "Yi Liu" <yi.l.liu@intel.com>
In-Reply-To: <20261013162529.1928093-6-dmatlack@google.com>
References: <20261013162529.1928093-1-dmatlack@google.com>
 <20261013162529.1928093-6-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 16:41:30 +0000
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

> When a PCI device is preserved across a Live Update, all of its upstream
> bridges up to the root port must also be preserved. This enables the PCI
> core and any drivers bound to the bridges to manage bridges correctly
> across a Live Update.
>=20
> Notably, this will be used in subsequent commits to ensure that
> preserved devices can continue performing memory transactions without a
> disruption or change in routing.
>=20
> To preserve bridges, the PCI core tracks the number of downstream
> devices preserved under each bridge using a reference count in struct
> pci_dev_ser. This allows a bridge to remain preserved until all its
> downstream preserved devices are unpreserved or finish their
> participation in the Live Update.
>=20
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013162529.1928=
093-1-dmatlack@google.com?part=3D5


