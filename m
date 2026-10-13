Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1043CC6B19
	for <kexec@archiver.kernel.org>; Tue, 13 Oct 2026 16:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mca5pzhulPTOJF1qTtDVM/rwKG3e1fXxRzAruQlixIg=; b=OkMeoXU0KWutDrmtEaiXUJUHez
	Mp1tt83PWmDJyk33rkDTZvHFv2DimAg3v+lahRm+JUjbKmZiImGRPAhdpyF93otCvxYBWwXrh9DCq
	jfT4Sto5Ixvvje8a3gb6NRsG9YrZ4KxNlHXI6VHX7EJYYhh8gj3+jnjBRgZIl11l1qNY3yQFwItxB
	xAxX4AjKy3yt5YrP9cNBJ4b/CZOHBkNrhbH2PfrZMliTEKaylzvz6tJKF9MWw78kaa97RTRdMuQmg
	6xRptbaUTxi92EUPI12dJR45vNNXQPAyf+Ti2LUH2G51xT1w4cbu8UPdGLlSkgmhpp8YEVHadI09n
	N2FdStiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfTD-0000000DXsz-2wOY;
	Tue, 13 Oct 2026 16:35:19 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfTC-0000000DXrY-1jON
	for kexec@lists.infradead.org;
	Tue, 13 Oct 2026 16:35:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2B471406CF;
	Tue, 13 Oct 2026 16:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1889F1F000FF;
	Tue, 13 Oct 2026 16:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791909318;
	bh=Mca5pzhulPTOJF1qTtDVM/rwKG3e1fXxRzAruQlixIg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lrMPQS+dkKJNGtNNp46iaPbj3wmoiRvQMd5tprm3pfWR6BW1QbGhyKAdKqjbMBChP
	 qxKqowID10XpBQopeg5UezBGf8VASwroS+RMkLL5o8ce49+my48nYiqCGlUIMZ/yLv
	 EBfYyHJugGWrB/dqoANIs4tMPBm90PkBwJNYnnyZkujh8Ofj6sFgyfIVlYICAMpEZx
	 xF3TnreY1CiJ87Z1W1/2gqy1jmGvLj0w4RMcK3pL2C6ZhDMSZHCcSCfVYT6/CAhUSY
	 hyKbmYIiaIVnNmefWz4P4yobbq0/rtUPuzX/E1ZHnHOFtp7otJtmIpczqxVRKtp+2q
	 zlTxWMEd4qB5Q==
Message-ID: <sashiko-outbox-170123@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 12/13] PCI: liveupdate: Do not disable bus mastering
 on preserved devices during kexec
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
In-Reply-To: <20261013162529.1928093-13-dmatlack@google.com>
References: <20261013162529.1928093-1-dmatlack@google.com>
 <20261013162529.1928093-13-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 16:35:16 +0000
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

> Do not disable bus mastering on outgoing preserved devices during
> pci_device_shutdown() for kexec.
>=20
> Preserved devices must be allowed to perform memory transactions during
> a Live Update to ensure continuous operation.  Clearing the bus
> mastering bit would prevent these devices from issuing any memory
> requests while the new kernel boots.
>=20
> Because bridges upstream of preserved endpoint devices are also
> automatically preserved, this change also avoids clearing bus mastering
> on them. This is critical because clearing bus mastering on an upstream
> bridge prevents the bridge from forwarding memory requests upstream (i.e.
> it would prevent the endpoint device from accessing system RAM and doing
> peer-to-peer transactions with devices not downstream of the bridge).
>=20
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013162529.1928=
093-1-dmatlack@google.com?part=3D12


