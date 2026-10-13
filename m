Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E11E7CC6B19
	for <kexec@archiver.kernel.org>; Tue, 13 Oct 2026 16:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VNFX5s2VKgimSo/wLOO35HBlQE94Ie8bMyx9duhb58o=; b=WSOKVYAM45s3ZrihkB5fJH6Fnh
	tNLmrRXs+QQXQatlaO/w5qEaJFwckjmS6IjCCZ49FJvZGD3TuZ0MIe8oaJjplXRu8pXhbkDO0CabJ
	7nWFc2Hk1tQMcrl7ZCgop7+wdbDiLbLofBmmw3uuZDWDTz+sKrhXNUDSmUcmpgbnBGVAFjV6HVDAA
	Av4oe037u8uASCxQ/CTIChPo2aAhKIT/w4gKyo9fnWlQBx4C6hJHp57L5I2fjsLbena38dnXkqoxF
	VT3Zb14lnXGfWZhBKLetO7ezCxrNoViJ7uYUCec8fBplKzklMLoB92WDBLeeDolskmca6Q5Miqf/N
	kySZ96Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfXp-0000000DZ2n-3fg5;
	Tue, 13 Oct 2026 16:40:05 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfXj-0000000DZ0Y-3Kau
	for kexec@lists.infradead.org;
	Tue, 13 Oct 2026 16:40:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4087160A5F;
	Tue, 13 Oct 2026 16:39:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972A11F00893;
	Tue, 13 Oct 2026 16:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791909599;
	bh=VNFX5s2VKgimSo/wLOO35HBlQE94Ie8bMyx9duhb58o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TCjS2JYdmQay1eJEIGoT72R4HHOFK1y3qqEAAczW9TIP7lpz8AXFZvgzRLmwYWzJ6
	 rhIu6Wt2f5uKQxitnP3n40KShgs1cG37Os6wxRbfEM7yc3LGwSlpzp9LrdLzP09krY
	 o3yEUnJG/RGW7ntRijKbGYDXHVrPTCoXuneZpAxy5eDX9Vsylwttq+aCSK4jSYenJm
	 X0vSx910HIL2y/7gM9r7wag3viOyxJSsBbtVQWIrFD5F11nosWPVpKJ8/LlrK8X0Z/
	 H6QJFpw1wKzx83ST2JM8BZ5XfY29q2djEYE0xjpq+yPVplq7hEc91OaFHcoe59SswE
	 P7f535rS6oJQw==
Message-ID: <sashiko-outbox-170132@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 11/13] PCI: liveupdate: Freeze preservation status
 during shutdown
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
In-Reply-To: <20261013162529.1928093-12-dmatlack@google.com>
References: <20261013162529.1928093-1-dmatlack@google.com>
 <20261013162529.1928093-12-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 16:39:57 +0000
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
- [High] pci: dangling outgoing pointer on concurrent unpreserve during shu=
tdown
--

commit 87d44fc8f0a5a6587310a2bfb5c312e9de1fe1c8
Author: David Matlack <dmatlack@google.com>

PCI: liveupdate: Freeze preservation status during shutdown

Freeze a device's outgoing preservation status (preserved or not
preserved) during shutdown. This enables the PCI core and drivers to
safely make decisions based on the device's preservation status during
shutdown.

> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index e640794cc8e6b..38b7815fe7d4a 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
[ ... ]
> @@ -499,6 +499,11 @@ static int pci_liveupdate_unpreserve_device(struct p=
ci_flb_outgoing *outgoing,
>  {
>  	struct pci_dev_ser *dev_ser =3D dev->liveupdate.outgoing;
> =20
> +	if (dev->liveupdate.frozen) {
> +		pci_warn(dev, "Cannot unpreserve device after it is frozen!\n");
> +		return -EINVAL;
> +	}
> +

[Severity: High]
If a user task exits or closes the Live Update session fd during system shu=
tdown,
the LU core tears down the preservation session.

When dev->liveupdate.frozen is true, pci_liveupdate_unpreserve_device()
returns -EINVAL and leaves dev->liveupdate.outgoing pointing to the FLB mem=
ory.

However, the LU core ignores this failure and unconditionally drops the FLB
reference:

kernel/liveupdate/luo_file.c:luo_file_unpreserve_files() {
	...
	luo_file->fh->ops->unpreserve(&args);
	luo_flb_file_unpreserve(luo_file->fh);
	...
}

This invokes pci_flb_unpreserve() which destroys the KHO state and frees the
memory:

drivers/pci/liveupdate.c:pci_flb_unpreserve() {
	...
	WARN_ON(outgoing->ser->nr_devices);
	kho_block_set_destroy(&outgoing->block_set);
	kho_unpreserve_free(outgoing->ser);
	kfree(outgoing);
}

Will this leave a dangling pointer in dev->liveupdate.outgoing?

Since pci_device_shutdown() relies on this pointer to skip disabling Bus Ma=
ster,
could this result in the old kernel leaving DMA enabled while the next kern=
el
treats the device as unpreserved, creating a risk of memory corruption?

>  	if (!dev_ser) {
>  		pci_warn(dev, "Cannot unpreserve device that is not preserved\n");
>  		return -EINVAL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013162529.1928=
093-1-dmatlack@google.com?part=3D11

