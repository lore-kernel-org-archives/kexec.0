Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A912C982D7
	for <kexec@archiver.kernel.org>; Fri, 18 Sep 2026 20:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aFG6NMPPSuorbIlqU27dxScbJKZhV+vI/vVxbxtvQPs=; b=ptWglEu/5n1W1c816h8VaEfLAb
	wrvS01JMq87G5dpjO5Mk+CyfZe9zRr2mEEOpU4AQTVKRhQLP6gVa3qKRq8OEyl6uM+GzNYm5gEBFV
	mFTcGKmp9OV0NF8K6cQXvPFm8rdu/CcsSTKPHgyPRSLpxW8CZAVtj2BiP7l1tKmfINhDG6kQOfmnn
	7RFMlW1Rrv6LGEvj5m7R1w2W4nD2kQwtzTCcO/4ph7gePMlCg29AUS3N5nrP3fhUAZejaaJ/o8wlE
	9s8uVZXRqAAQMvYAX6/2aa5p2X55Q8E0pB17SDyzPl3ny3jDUKUMoXeCSokZgDy/aDdXiAHZcpfqg
	bSZluJZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7f75-0000000FVVW-2LxA;
	Fri, 18 Sep 2026 20:23:15 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7f74-0000000FVVP-1eNX
	for kexec@lists.infradead.org;
	Fri, 18 Sep 2026 20:23:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CFBBE602CC;
	Fri, 18 Sep 2026 20:23:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1483A1F00898;
	Fri, 18 Sep 2026 20:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789762993;
	bh=aFG6NMPPSuorbIlqU27dxScbJKZhV+vI/vVxbxtvQPs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J8EevRzhuZz4nJEgD7WdIubGd5xCkXjojQLV1YgZ45BionFAmz9HLZIbms7CHK15M
	 qGVgkpcsiBOXYX5pbbHphFQYd4YZHAYMdRBoWtpud2Ej7+nwVjI9o3h0YlB5hyhjQ1
	 lxdR3U7SIH3gvr8sECbSpAAwQnXc0JHgxljXo5u9i6vonpDVyEWs5Q5tgfIlqvzDBU
	 +vFA8B2g28agSSRUW9EKOQQsY34hXUyiFvh6fgdJOToPZIj++uRa/MFKgEZzCJJ7oa
	 KgqJTzLXtH+VzfrilkfgyCInD9Y6a71qJLA0scREO7NAMaageYRCdHCAdw3QbKVOSd
	 kEO2Gr9EfF6Zg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 02/13] PCI: liveupdate: Track outgoing preserved PCI
 devices
To: "David Matlack" <dmatlack@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org
Cc: "Saeed Mahameed" <saeedm@nvidia.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Leon Romanovsky" <leonro@nvidia.com>, "William
 Tu" <witu@nvidia.com>, "Shuah Khan" <skhan@linuxfoundation.org>, "Chris Li" <chrisl@kernel.org>, "David
 Rientjes" <rientjes@google.com>, "Alexander Graf" <graf@amazon.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "Adithya Jayachandran" <ajayachandra@nvidia.com>, "Mike
 Rapoport" <rppt@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Vipin
 Sharma" <vipinsh@google.com>, kexec@lists.infradead.org, "Parav Pandit" <parav@nvidia.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Lukas Wunner" <lukas@wunner.de>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Pranjal Shrivastava" <praan@google.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Samiullah Khawaja" <skhawaja@google.com>, "Josh
 Hilke" <jrhilke@google.com>, "Yi Liu" <yi.l.liu@intel.com>, "Alex
 Williamson" <alex@shazbot.org>, linux-pci@vger.kernel.org
In-Reply-To: <20260918200640.887030-3-dmatlack@google.com>
References: <20260918200640.887030-1-dmatlack@google.com>
 <20260918200640.887030-3-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 20:23:11 +0000
Message-Id: <20260918202312.1483A1F00898@smtp.kernel.org>
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

> Add APIs to allow drivers to notify the PCI core of which devices are
> being preserved across a Live Update for the next kernel, i.e.
> "outgoing" devices.
>=20
> Drivers must notify the PCI core when devices are preserved so that the
> PCI core can update its FLB data (struct pci_ser) and track the list of
> outgoing devices. pci_liveupdate_preserve() notifies the PCI core that a
> device must be preserved across Live Update. pci_liveupdate_unpreserve()
> reverses this (cancels the preservation of the device).
>=20
> This tracking ensures the PCI core is fully aware of which devices may
> need special handling during shutdown and kexec, and so the list of
> preserved devices can be handed off to the next kernel.
>=20
> For now, the API only supports preserving non-VF devices on a root bus
> (not behind an PCI-to-PCI bridges).
>=20
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918200640.8870=
30-1-dmatlack@google.com?part=3D2


