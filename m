Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 530FEC982D7
	for <kexec@archiver.kernel.org>; Fri, 18 Sep 2026 20:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fUX1CMYSfd1cCzY+rZLKpCj1B/a7Nm8BOcFnIwzacKA=; b=Exx+h+HL6gT1bPNcaOoaonLkbq
	ubsClLwIlPuh+8Cb6QSWXz09S4AGZyRydY3RAlgPE8HizijWv1sOfFOgHutpsJatef84HMQjsSQMV
	a49F3TaAJCYcXgdyLuRFennDuUOFVrYwaXvBdk0zlXU41bPDA2/XLXJT/uK5fqpV+zyr0HAHa9nlE
	FVtRiMT6yMlK59mAXtH/fZvtpYAneaeRD1iIf9CDpT5jHcdaDhXxpgryjoJpIoLwUd7i01RBs8RqF
	deprwpnYBTTJQDU6Ghpa3r8ltgCFi/VoSpLg0lYYLZc6ErcGuWzSu837NN6PPiskezQkQgU4+Yneb
	1RUyuq+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7eya-0000000FUi9-1D58;
	Fri, 18 Sep 2026 20:14:28 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7eyY-0000000FUhx-1cI6
	for kexec@lists.infradead.org;
	Fri, 18 Sep 2026 20:14:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CD628602CC;
	Fri, 18 Sep 2026 20:14:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EBD1F00898;
	Fri, 18 Sep 2026 20:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789762465;
	bh=fUX1CMYSfd1cCzY+rZLKpCj1B/a7Nm8BOcFnIwzacKA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c1K9JuxoIpd0ybPcfa6kWD3z1AEnt7uah5WM781MT65U7w3mGH1TkBNhFdNZ9WXOh
	 u/uCw2YcDD7rWhPfRaPzF1f+7/RHUmkx8mpTbHwUEjxXqM81pAvR8O2S2gOvqywOQO
	 FWvY2hCiZcx1j0t1FQU4VF9shWKsBGbF/DNyGxLVjy6e9E6Wmo69vBFEijiO1lE8J6
	 V2oxC45PLi9hOwYS1uVguivaABUjbrNvSZ84D3HlEADtZgW8CA8HbniVzsALfWIYBE
	 wzbiLZAU4WpZa6wwdHt+L3f4lsoucD79w3I5cmeKiF/xx+9pU6VLVlBAPJL/gIn0Zv
	 SLB4jTZYVNvyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 05/13] PCI: liveupdate: Auto-preserve upstream
 bridges across Live Update
To: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, "David
 Matlack" <dmatlack@google.com>
Cc: "Adithya Jayachandran" <ajayachandra@nvidia.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, kexec@lists.infradead.org, "Alex
 Williamson" <alex@shazbot.org>, "Saeed Mahameed" <saeedm@nvidia.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Shuah Khan" <skhan@linuxfoundation.org>, "Yi
 Liu" <yi.l.liu@intel.com>, "Jason Gunthorpe" <jgg@nvidia.com>, "Alexander
 Graf" <graf@amazon.com>, "David Rientjes" <rientjes@google.com>, "Chris Li" <chrisl@kernel.org>, "Pranjal
 Shrivastava" <praan@google.com>, "William Tu" <witu@nvidia.com>, "Vipin
 Sharma" <vipinsh@google.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Jonathan Corbet" <corbet@lwn.net>, "Josh
 Hilke" <jrhilke@google.com>, "Mike Rapoport" <rppt@kernel.org>, "Parav
 Pandit" <parav@nvidia.com>, linux-pci@vger.kernel.org, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Lukas
 Wunner" <lukas@wunner.de>, "Leon Romanovsky" <leonro@nvidia.com>
In-Reply-To: <20260918200640.887030-6-dmatlack@google.com>
References: <20260918200640.887030-1-dmatlack@google.com>
 <20260918200640.887030-6-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 20:14:24 +0000
Message-Id: <20260918201424.82EBD1F00898@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918200640.8870=
30-1-dmatlack@google.com?part=3D5


