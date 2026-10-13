Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0D6CC6B1A
	for <kexec@archiver.kernel.org>; Tue, 13 Oct 2026 16:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=odVEBCmsRbJOJ1+9+4qgE6bBwt1qmTgdLvR2oIvMX4Q=; b=ezN0NMqn5ebUIjTWUb08K8L7Dv
	4YOqM54kH54/2TwWNZdcdOwK4T9FIf1ugm6E38lb7952JQfuuT3MOCPczRl4k8psKQy1wFwaxq0Aa
	fZ/77dt+p+m0UAx1cAvHUFgExQ9FC8/vsRjjGRUBzCQjMwA4ohAl6prFS1bc5rDrIgNVUR4CKMWXO
	9bi9aWQ1dFKABiu1fepmBXg4kvbByQhhK9sDFnGPiKUX+HhQXGX6jUBnQODoBTgNQii2aUEQ6gh0e
	rAORy6TsMe+ZhvNnPXM55DVvs1FZJLWAkOWSev0pQE53ojoTVmPZRNdnHZJCGzqA5NTwUqQbroPXN
	vK20KVOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfMo-0000000DVZ9-2M1a;
	Tue, 13 Oct 2026 16:28:42 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfMm-0000000DVYU-2IA0
	for kexec@lists.infradead.org;
	Tue, 13 Oct 2026 16:28:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 28E9142E5A;
	Tue, 13 Oct 2026 16:28:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA00A1F00893;
	Tue, 13 Oct 2026 16:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791908920;
	bh=odVEBCmsRbJOJ1+9+4qgE6bBwt1qmTgdLvR2oIvMX4Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nCwm4mJEHorrQsUlrCM50K/8k5X4D7ZKAk9onNNpKdoZk/h29ZePz4wAfwQwb0ieM
	 JkCR9tdXoCW9olbYraKuyXCPLu8fe4lmRRvoQ+Cbj+gpBtc9Dxq2q3+FYFzjvkJ+kF
	 wjy+pxHuZuNLIzD1D3XSMqGb0oo2EvE67x+D7c6c7cJzcBzBskVq3Qk60MKTXnW1k1
	 jOVdr2MI+GtVFp8R5NrkPe+IaUkgH/WciC1cwY53aXSvQdQi7Erc7PAIqwdItFSCXE
	 e3aqGvILN7RTMmb/z7V0FFXzUs7dbf6yzjRWRkJB9gCbgdVeGYrDi7ZO0sCQPzRyUC
	 SbwlG1hi7aMPA==
Message-ID: <sashiko-outbox-170112@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 13/13] Documentation: PCI: Add documentation for
 Live Update
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
In-Reply-To: <20261013162529.1928093-14-dmatlack@google.com>
References: <20261013162529.1928093-1-dmatlack@google.com>
 <20261013162529.1928093-14-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 16:28:38 +0000
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

> Add documentation files for the PCI subsystem's participation in Live
> Update.
>=20
> These documentation files are generated from the kernel-doc comments in
> the PCI Live Update source code. They describe the File-Lifecycle-Bound
> (FLB) API, the device tracking API, and the specific policies applied to
> preserved devices (such as bus number inheritance and bus mastering
> preservation).
>=20
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013162529.1928=
093-1-dmatlack@google.com?part=3D13


