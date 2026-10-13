Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE45CC6B19
	for <kexec@archiver.kernel.org>; Tue, 13 Oct 2026 16:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vU9iDpTw6BhQUXTMuwZ7IfGm84e7qgJyw7tFxT1/9fE=; b=PKZ7pz0LDon9/s8x1n/l62fkqv
	eKaq9hQtPWntVJpATv83XinT+A9p7i2dnL9T8qiWNpMJT81Mx7vZuQ2ukN2t9spycP9ITG1va9RRG
	K5MRIr4+AS71todfZio5G1dlO4fRdLEgThjvAx/5nl0nYLpZzDWWGFJGxpNcoqloUbzSAa/ELKEJv
	tt5yC9XXEgLrb6XVkHsxIaq1FNOSkWVeMC36pp97PlUHuS7atg8+y3Zt7D0YWYX4FiOcQhOSTLpFM
	moeftwh4iEVKp1bVHrVaEBkzG2xI/jstmODhdBm2HlZ33Urs5iVmFOcniCSTq5T3SiJu7yD+5BbD+
	OuOqBBPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfYi-0000000DZKq-0dD6;
	Tue, 13 Oct 2026 16:41:00 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfYh-0000000DZK7-0kO1
	for kexec@lists.infradead.org;
	Tue, 13 Oct 2026 16:40:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D38774071B;
	Tue, 13 Oct 2026 16:40:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D411F00893;
	Tue, 13 Oct 2026 16:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791909658;
	bh=vU9iDpTw6BhQUXTMuwZ7IfGm84e7qgJyw7tFxT1/9fE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RMRtbK7UcA5SdLsEX5/pelGjDR8F208CZNPjIkSj/2ZD27wPtooimHoiVmLTs12hs
	 a/w1aTYGmNzA3jcEPaUEUV/ma5629qBG2Mevvul8O37z2AgvliDBxQmqEW6cWlMTe8
	 tKuKjH5aPQ7ryVQ+SimIKlN1p0e8YBI4aSZBZVJRpwe6DnkHwLZiy2oHr7K/Eoqa4Y
	 v7jZc1Oy+klAOVHcK0hvCRhJDjYXe9mUVcCrsBI4Wl30XrKQrgwZ1ubnrePlyyGBMV
	 OalTqaR83FYwW1I5lHOFRT/BaPR8HZ/yX50GtNUTo8pco2//wEoGJsVoYoWbAvmTdP
	 4+xxTiVqNRXMQ==
Message-ID: <sashiko-outbox-170134@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 10/13] PCI: liveupdate: Adopt ARI Forwarding Enable
 on preserved bridges
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
In-Reply-To: <20261013162529.1928093-11-dmatlack@google.com>
References: <20261013162529.1928093-1-dmatlack@google.com>
 <20261013162529.1928093-11-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 16:40:57 +0000
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

> Adopt the ARI Forwarding Enable bit on preserved bridges and update
> pci_dev->ari_enabled accordingly during a Live Update. This ensures that
> the preserved devices on the bridge's secondary bus can be identified
> with the same expanded 8-bit function number after a Live Update.
>=20
> pci_liveupdate_adopt_ari() updates the bridge's ari_enabled the same way,
> and from the same context, as pci_configure_ari() already does when it
> enables or disables ARI Forwarding on the bridge.
>=20
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013162529.1928=
093-1-dmatlack@google.com?part=3D10


