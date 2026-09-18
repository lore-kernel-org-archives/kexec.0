Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208D2C982DD
	for <kexec@archiver.kernel.org>; Fri, 18 Sep 2026 20:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4BHzfgU7NlhiaeoyLw4QIVrcWHr6+Q91E2JaLOkHxcc=; b=VqI0rrWiuxNW2w4zKmHS7IigRn
	7GyDFJLdDzvHwUDoWa3Zpas/9NPDAOO4icq5faY+BT1q+SiykCtVyP+q2TDXbsD3VePlDxqUmOE15
	/n7xxgCAStBh7qVf+pPXX1Na5uEXHYXWOcMRXd3GuLv1fh8odw3XIfnkjcIYKf8vs2IQrZ53bK/Jt
	cvYszB0ksNbLbc/dPzvkCecGYvnwce1t3rLmimJRUGG6P5K6K8O858IFOc4IztGgE1cSrzW/QgkD6
	r6mjILq2Y8TG/wgz2XnBIYgDg7TX6QZeTvbm/iGI4qBLr8oTrd6JrrpcZnZ+w2zZehz7o5KsTHHIV
	llb0F90w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7exu-0000000FUcw-0QUx;
	Fri, 18 Sep 2026 20:13:46 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7exs-0000000FUcS-48s8
	for kexec@lists.infradead.org;
	Fri, 18 Sep 2026 20:13:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 56CF3602CC;
	Fri, 18 Sep 2026 20:13:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916F81F000FF;
	Fri, 18 Sep 2026 20:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789762424;
	bh=4BHzfgU7NlhiaeoyLw4QIVrcWHr6+Q91E2JaLOkHxcc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HyCzK9W1dXl+/YzMV88nR47sMs1YSKPOm7r206nkfEqmpQfxEqtGNi3uGia1CiCBy
	 58AvHvwaIQ+5VvMMIpang4tGjgDjDjJJHMlILNjF+5dHsU7BoGwhL8u0ThDISYllWa
	 7jwOzqBUcYKmKJocF1NyOwvZClXirVEzLYh7xCASXkO0Xc7ZYgKO/LgUzZj6HR1apQ
	 fEFmh0X2YOQQ+ddXCNBoH92KvaJYaS0WTY5IpHpB67cYD40enYMIXjOOGUAXE3Qvr/
	 zo/uC4l4oyXj/Kr40at8aj+ZgiYbrX4n5HubEsVEjViWcJitj/xiMzVDD9pJJoNy+4
	 om2D0s+D1QSlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 09/13] PCI: liveupdate: Adopt ACS controls in
 incoming preserved devices
To: "David Matlack" <dmatlack@google.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Alex Williamson" <alex@shazbot.org>, linux-pci@vger.kernel.org, "Pratyush
 Yadav" <pratyush@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Mike
 Rapoport" <rppt@kernel.org>, "Yi Liu" <yi.l.liu@intel.com>, "Josh Hilke" <jrhilke@google.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Alexander Graf" <graf@amazon.com>, "Jonathan
 Corbet" <corbet@lwn.net>, kexec@lists.infradead.org, "Adithya Jayachandran" <ajayachandra@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, "Pranjal Shrivastava" <praan@google.com>, "Chris
 Li" <chrisl@kernel.org>, "Samiullah Khawaja" <skhawaja@google.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, "Vipin Sharma" <vipinsh@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "William Tu" <witu@nvidia.com>, "Parav
 Pandit" <parav@nvidia.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Lukas
 Wunner" <lukas@wunner.de>, "Bjorn Helgaas" <bhelgaas@google.com>, "David
 Rientjes" <rientjes@google.com>
In-Reply-To: <20260918200640.887030-10-dmatlack@google.com>
References: <20260918200640.887030-1-dmatlack@google.com>
 <20260918200640.887030-10-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 20:13:42 +0000
Message-Id: <20260918201342.916F81F000FF@smtp.kernel.org>
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

> Adopt Access Control Services (ACS) controls on all incoming preserved
> devices (endpoints and upstream bridges) during a Live Update.
>=20
> Inheriting ACS flags avoids changing routing rules while memory
> transactions are in flight from preserved devices. This is also strictly
> necessary to ensure that IOMMU group assignments do not change during or
> after Live Update.
>=20
> The adopted controls are recorded by the pci_save_state() call in
> pci_bus_add_device(), which runs before drivers bind, so they are
> automatically reapplied by pci_restore_state() if the device is reset.
> If that save buffer could not be allocated there is nowhere to record
> the adopted controls, and they would be silently lost by the first
> reset. Program ACS from scratch in that case, which is a better outcome
> than leaving ACS disabled.
>=20
> To simplify ACS inheritance, reject preserving any devices that require
> quirks to enable ACS as those quirks would also have to take Live Update
> into account.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918200640.8870=
30-1-dmatlack@google.com?part=3D9


