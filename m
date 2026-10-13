Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D869CCC6B19
	for <kexec@archiver.kernel.org>; Tue, 13 Oct 2026 16:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=onpO8lBHEN85iwssSLMsBRvZRHpOY6vwoIhiGQt1cxQ=; b=sOHFYR5/GhzOgl78v6NM0C3IkH
	xAD4zq4sucREgjBl6sosIFTUNipMoHHpcaCKEg28jE31Yh1E39kkBHX/QmZrDlwWSVFMP0q6EsJS2
	lcLZd9eHwu/DdPNvS9+fXnlyKlkE7t69iF1VcIehba2LNv4WDbuJE+b3fANAVdfHIYvxDrVjg7Ulj
	i9Tj+K/N7OVu9W3JHauzMfdHYo4fORyJ5yfxvcGWk0SKk8loL6nLUMwPNabX/RRkdQyNQEzTV7Gs9
	TGr7vp5XZuIbyHndc4THIkW9L4RRJlRI7HKmlbzZ11V1W1RWtm878Bp6hDrtYf0uEIxHr/Vt1lfbM
	7SC1SuWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfY2-0000000DZ8q-49Dj;
	Tue, 13 Oct 2026 16:40:18 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfY1-0000000DZ8E-0xSM
	for kexec@lists.infradead.org;
	Tue, 13 Oct 2026 16:40:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A799260A59;
	Tue, 13 Oct 2026 16:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5311F000FF;
	Tue, 13 Oct 2026 16:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791909616;
	bh=onpO8lBHEN85iwssSLMsBRvZRHpOY6vwoIhiGQt1cxQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YNlQgiKxykUdaNxPXZtWG0oxa6IsM144UcaLaPe226qqU1kDRq0XFsgCT7J8vBOUO
	 Fh9hndQ8L8LhCb5R4U5MjZBiCC8bWfArpNHUSyzQkB5GUs8CoQzrQKj3NQ5uIfHWAO
	 WYj3uwzbAsIOSJoIuUmGKFNMYlIR9auXBOowlqXqEHcGhXcFl0jUJqOihiPZIB41VJ
	 rgyY4zHr2lzfxX0J5sv501jtnKKTGD4/jBA051lwE2lX1H+pqpZqTS2dPX3f40pLUy
	 t++aA/jkfQzHSNhf1bpXr108kA4y2YzNMCYBq0ebTy1wxSuIXVZXeqDejsN6r2w0eR
	 e3EXbsT51vPwQ==
Message-ID: <sashiko-outbox-170133@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 03/13] PCI: liveupdate: Track incoming preserved PCI
 devices
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
In-Reply-To: <20261013162529.1928093-4-dmatlack@google.com>
References: <20261013162529.1928093-1-dmatlack@google.com>
 <20261013162529.1928093-4-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 16:40:14 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci: liveupdate: silent DMA corruption risk on incoming device cle=
anup
--

commit 30099916ad0bce596acb2541018cac55703694d3
Author: David Matlack <dmatlack@google.com>

PCI: liveupdate: Track incoming preserved PCI devices

This commit adds tracking for incoming preserved PCI devices during Live
Update. It introduces pci_liveupdate_setup_device() to fetch the serialized
state from the previous kernel and marks devices as incoming-preserved until
drivers call pci_liveupdate_finish().

> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index 22d5d177e104d..a1d9b2b1f9e38 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
[ ... ]
> @@ -382,7 +599,80 @@ void pci_liveupdate_cleanup_device(struct pci_dev *d=
ev)
>  	 */
>  	if (READ_ONCE(dev->liveupdate.outgoing))
>  		pci_WARN(dev, 1, "Destroying outgoing-preserved device!\n");
> +
> +	if (READ_ONCE(dev->liveupdate.incoming))
> +		pci_WARN(dev, 1, "Destroying incoming-preserved device!\n");

[Severity: High]
Does this code risk silent memory corruption by only warning instead of
panicking?

When an incoming preserved device is destroyed, it is dropped from the
kernel's resource tracking. However, the device may still be live and
performing DMA if it was handed over by the previous kernel.

If this only warns, it allows the PCI core to proceed and potentially
reassign the device's bus numbers and MMIO resources to other devices while
the original device is still active. Although pci_check_all_devices_finishe=
d()
panics at the end of the Live Update session for unfinished devices, there =
is
a dangerous window where resource conflicts and DMA corruption can occur.

> +}
[ ... ]
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 2a37e5d3e8e36..ad7fdf0d56b68 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
[ ... ]
> @@ -2188,6 +2190,7 @@ int pci_setup_device(struct pci_dev *dev)
>  	default:				    /* unknown header */
>  		pci_err(dev, "unknown header type %02x, ignoring device\n",
>  			dev->hdr_type);
> +		pci_liveupdate_cleanup_device(dev);

[Severity: High]
Can an incoming preserved device that fails enumeration here cause a resour=
ce
conflict?

If pci_setup_device() encounters an unknown header type for an incoming
device, it calls pci_liveupdate_cleanup_device() and ignores the device.
Since the cleanup routine only issues a warning, the live device is dropped
from tracking but might still be performing DMA.

>  		pci_release_of_node(dev);
>  		return -EIO;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013162529.1928=
093-1-dmatlack@google.com?part=3D3

