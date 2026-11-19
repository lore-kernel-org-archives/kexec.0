Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8816606A330
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 22:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YzrzsibF;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K84lAhix
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Oub/Ol/8+MHQZEeLyeMANUxv5ii8PId82e+apI4K+qk=; b=YzrzsibFzm0zjIdcoRwDUJfuQz
	rY3OpF9ALCWEjRhldbzAouzDCjk5vaYCdVfaBgXCtY8ApU8JvsUTE+Fw+dEvZPv+UUitkTS+c/z2y
	4bCdsPMPU0/hJetIOdhQmhozwu+S/JEm8twTGuDf/+nie9u/6P4Z/KU4VwERE3fUrZSAZTCfzIeNK
	E5mY22LjVID9QCeHCtkE7f/SB+p0Mbe9JkpAA1nXqG7KNL83B7YQqbl3zhRy0Y2hmp1ErSKZZyiLa
	lnTgNZfyq9v78VNOwgWlINaC5DJI3t+qfg2mjU2ppNcSzBDY7DzdqFOvzNv3Xw2daE9e8ThSMDCDz
	htY6YP/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUAmF-0000000Daj9-1QcI;
	Thu, 19 Nov 2026 22:38:47 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUAmD-0000000Dahu-3Njg
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 22:38:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3E71760D29;
	Thu, 19 Nov 2026 22:38:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7FB1F000C6;
	Thu, 19 Nov 2026 22:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795127925;
	bh=Oub/Ol/8+MHQZEeLyeMANUxv5ii8PId82e+apI4K+qk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K84lAhix8cpsbsDJfvQeFZGr+Kk8Lz8wqX8LsgOt1bVOP+kEieFCct6YVOzjhHp7x
	 OpyQVrxppkAYDnQubFP54zWqkFntRE+SzwrlCoyTrb6gIfcBHRgyAl9fNELbzT9wIP
	 6f9ZdkqZ6lOgxy7x4VJM1SJ1d4POd7ZESTcYetGoupVdU2w1on2fb0QaqmkLBOqhtC
	 TKbTLWHkGCIcLv8A0bmo4qecQBFq9m10SQYtCJ3KEVvJEMkjG4sq8l96fdqwsvGenS
	 Y6q1K78HFEyAwsZkjf+8XUozb1Vkb18oCul+Cu3Ve0N4JuLuM2KR6sZBu2CYgu1gIv
	 JK4CKeGZzvC5A==
Message-ID: <sashiko-outbox-224146@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 11/13] PCI: liveupdate: Freeze preservation status
 during shutdown
To: "David Matlack" <dmatlack@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: "Adithya Jayachandran" <ajayachandra@nvidia.com>, "Alexander Graf" <graf@amazon.com>, "Alex
 Williamson" <alex@shazbot.org>, "Alex Williamson" <alex.williamson@nvidia.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Chris Down" <chris@chrisdown.name>, "Chris
 Li" <chrisl@kernel.org>, "David Rientjes" <rientjes@google.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Jonathan Corbet" <corbet@lwn.net>, "Josh
 Hilke" <jrhilke@google.com>, "Leon Romanovsky" <leonro@nvidia.com>, "Lukas
 Wunner" <lukas@wunner.de>, "Mike Rapoport" <rppt@kernel.org>, "Parav Pandit" <parav@nvidia.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pranjal Shrivastava" <praan@google.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, "Samiullah Khawaja" <skhawaja@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Vipin Sharma" <vipinsh@google.com>, "William
 Tu" <witu@nvidia.com>, "Yi Liu" <yi.l.liu@intel.com>
In-Reply-To: <20261118223704.3286085-12-dmatlack@google.com>
References: <20261118223704.3286085-1-dmatlack@google.com>
 <20261118223704.3286085-12-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 22:38:40 +0000
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] pci: liveupdate: panic on session teardown after
  pci_liveupdate_freeze()
--

commit a3120ec70b92ea26f3e1d92d3bd0d1531b5a73b6
Author: David Matlack <dmatlack@google.com>

PCI: liveupdate: Freeze preservation status during shutdown

This commit freezes a PCI device's outgoing live update preservation
status in pci_device_shutdown() so that devices cannot be preserved or
unpreserved once shutdown begins.

> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index a45ad86370d5d..e26d2f5c2338c 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c

[ ... ]

> @@ -520,6 +523,11 @@ static int pci_liveupdate_unpreserve_device(struct p=
ci_flb_outgoing *outgoing,
>  {
>  	struct pci_dev_ser *dev_ser =3D dev->liveupdate.outgoing;
> =20
> +	if (dev->liveupdate.frozen) {
> +		pci_warn(dev, "Cannot unpreserve device after it is frozen!\n");
> +		return -EINVAL;
> +	}

[Severity: High]
Can rejecting pci_liveupdate_unpreserve_device() on a frozen device trigger=
 a
panic in pci_check_all_devices_released() when a Live Update session is
closed during a non-kexec shutdown?

Unlike kernel_kexec(), which calls liveupdate_reboot() to serialize sessions
before device_shutdown(), non-kexec shutdown paths (kernel_restart(),
kernel_halt(), and kernel_power_off()) call device_shutdown() ->
pci_device_shutdown() -> pci_liveupdate_freeze() without serializing Live
Update sessions.

If a task closes an open session FD with a preserved PCI device during or
after pci_device_shutdown(), luo_file_unpreserve_files() invokes the file
handler's .unpreserve() callback and then unconditionally drops the outgoing
FLB reference:

kernel/liveupdate/luo_file.c:luo_file_unpreserve_files() {
    ...
		luo_file->fh->ops->unpreserve(&args);
		luo_flb_file_unpreserve(luo_file->fh);
    ...
}

Because dev->liveupdate.frozen is set, pci_liveupdate_unpreserve_device()
returns -EINVAL without decrementing dev_ser->refcount or
outgoing->ser->nr_devices.  When luo_flb_file_unpreserve() drops the final
FLB reference, pci_flb_unpreserve() calls pci_check_all_devices_released(),
which panics because outgoing->ser->nr_devices is still non-zero.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223704.3286=
085-1-dmatlack@google.com?part=3D11

