Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D43ACC6B19
	for <kexec@archiver.kernel.org>; Tue, 13 Oct 2026 16:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZnMQkGjZvfV0sw/bVJGwXFGK/r+xjFxmRuUXfW6+tAM=; b=iqKF4bZSFDkohNn0cQ1PwBw8mN
	S0XBpm3dYXiNszR24QKUW2/bl7TcrXrULNJI/238gcFpUoU86Wrpi5fGUJlCb7ZfL7tWnI79vVxfw
	19nQ8FWzwEuJHpJ+ylLLi16AEIy1SZ0Pzrr4EJRcRhm1rVOuoeObgKjk566+0SI/jInQ7ZeVGV+OI
	dXJxVv5qMhJoe6UxEcTpwS01WCLd2zUK+rovI2HPrTtr7NDKwP/qAhiOKQS9TejKhZ3AB8oqK89z3
	pW7D6xkA8HrTVk+vkmWt6xB4PcE2TD3jAZm1zGOAJ0L08vwXPphn6MEV0rk7xiV0jXh7XKA2j6PE9
	mgHtb2Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfRM-0000000DWph-40Do;
	Tue, 13 Oct 2026 16:33:24 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfRM-0000000DWp5-1wag
	for kexec@lists.infradead.org;
	Tue, 13 Oct 2026 16:33:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E10D441723;
	Tue, 13 Oct 2026 16:33:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3151F000FF;
	Tue, 13 Oct 2026 16:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791909203;
	bh=ZnMQkGjZvfV0sw/bVJGwXFGK/r+xjFxmRuUXfW6+tAM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YsmUbLBsRPAZZ1bjbnWYjJun435h9Gyfu+jjvHrzQb+oPAFTFjh8xyY09somAuhEp
	 IMn+2noPgS89RKNuAOCvc6D6yfTt8qHT7hzs4qAc9Rx5qn3GqhbPfIf0HBeOfN+m4y
	 dc0Dn3pktk0QZrcCPfzKh6yoA8Ur1wrohvZSHRp/I3FY2gmypv2iHdCzZ/7ysziymD
	 cBzKq8HRuJLQDSsVJz0M0fk/zNX7LOE43Kqc4VzLV7vZfgs27kvrb3g2WeDXYU97aE
	 /ejwDhwytVItw06JuSsJmh6jWq1Il8h7My3qbA/R/yfJo6ZDkNBd20ml5uv01bTso2
	 umow7x/9XFsmA==
Message-ID: <sashiko-outbox-170118@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 01/13] PCI: liveupdate: Set up FLB handler for the
 PCI core
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
In-Reply-To: <20261013162529.1928093-2-dmatlack@google.com>
References: <20261013162529.1928093-1-dmatlack@google.com>
 <20261013162529.1928093-2-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 16:33:20 +0000
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

> Set up a File-Lifecycle-Bound (FLB) handler so that the PCI core can
> preserve its own state across a Live Update kexec.
>=20
> Preserving a PCI device across kexec requires preserving two independent
> sets of state:
>=20
>  - Driver state, e.g. everything vfio-pci needs so that userspace can
>    keep using the device in the new kernel. The driver preserves this
>    itself and the PCI core is not involved.
>=20
>  - PCI core state, e.g. which devices are preserved, so that the new
>    kernel knows not to disturb them while they are still running and
>    doing DMA. That is what this commit adds, serialized into struct
>    pci_ser.
>=20
> [ ... ]
> key when looking up incoming preserved devices.
>=20
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013162529.1928=
093-1-dmatlack@google.com?part=3D1


