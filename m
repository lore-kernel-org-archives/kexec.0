Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDB1C982D7
	for <kexec@archiver.kernel.org>; Fri, 18 Sep 2026 20:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1/IMZi7laPDns0FaC9FTXouqX/JlqimdYvbBnru5FUE=; b=aAoaLLb6jawDwMQDxKTNgvgPQD
	PQA4U60DD8pLk6e0UqmuAPipmbPPpjL7zPdhZb+vHsVcatgYuFaiMXTT1clQrJ4/Q9lavPzMtFQ7z
	jmtzqPtQXdjnlqWw68sWL272cgHraNoq6b9yAEkftxTTA0gMQLbKK4CCyFZZUk0CiLUjVO17+/Ql5
	qAyTzEo+ZxYXtzfq5v5vmM0mj09Qk6Tu/ppxsl/avOuex03e1SXridAN+TTxBM+q3hH16Qw9BxTru
	8a+NVfGdZ4rcs5u61xqNUM4Tf3F5azBVoBGR8soKa7zQ9UyjPd2CwCzssUEE6bIJAxLrl9Q4MAwHB
	fAeRharQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7f3T-0000000FVFE-1hwp;
	Fri, 18 Sep 2026 20:19:31 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7f3R-0000000FVEi-2Ayv
	for kexec@lists.infradead.org;
	Fri, 18 Sep 2026 20:19:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9A070602CC;
	Fri, 18 Sep 2026 20:19:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A171F000FF;
	Fri, 18 Sep 2026 20:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789762768;
	bh=1/IMZi7laPDns0FaC9FTXouqX/JlqimdYvbBnru5FUE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j9mBKbI2ruUGsdiORjKJXRAMUctal6GC2xh6t5MhA9SvK3NDBwBwl8I4JyL/0ye/z
	 9OEAVgB/L/WqfaE8kynPhemr1MuJO7enoO89rgbb3pvIpr55acD7B8fNsTO4j2F8v3
	 aHCYiGbWHT2iP5oDnCcZ8P6zn1n48MyjIoJ/NC9haWSbi7xdkST33Hsu+2UaAET1iy
	 mDp6FW2aVh68L9ahWiFizjOl120e9rfmVU4OHPZYJCCYtV9VEh02AfAZUH/w85mjEU
	 lpEwUrV5JjxGQYjT2ffoYT8c3LlWBKmPyhYilZqdEO7woOLZ66acluO2S8ENI5WpQt
	 xsPrTN8jLQ5LA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 11/13] PCI: liveupdate: Freeze preservation status
 during shutdown
To: linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, "David
 Matlack" <dmatlack@google.com>
Cc: "Adithya Jayachandran" <ajayachandra@nvidia.com>, linux-pci@vger.kernel.org, "Jonathan
 Corbet" <corbet@lwn.net>, "Lukas Wunner" <lukas@wunner.de>, "Parav Pandit" <parav@nvidia.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Vipin Sharma" <vipinsh@google.com>, "David
 Rientjes" <rientjes@google.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Saeed Mahameed" <saeedm@nvidia.com>, "William
 Tu" <witu@nvidia.com>, "Pranjal Shrivastava" <praan@google.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Alexander Graf" <graf@amazon.com>, kexec@lists.infradead.org, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Alex Williamson" <alex@shazbot.org>, "Josh
 Hilke" <jrhilke@google.com>, "Randy Dunlap" <rdunlap@infradead.org>, "Chris
 Li" <chrisl@kernel.org>, "Leon Romanovsky" <leonro@nvidia.com>, "Mike
 Rapoport" <rppt@kernel.org>, "Pratyush Yadav" <pratyush@kernel.org>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Yi Liu" <yi.l.liu@intel.com>
In-Reply-To: <20260918200640.887030-12-dmatlack@google.com>
References: <20260918200640.887030-1-dmatlack@google.com>
 <20260918200640.887030-12-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 20:19:26 +0000
Message-Id: <20260918201926.E4A171F000FF@smtp.kernel.org>
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

> Freeze a device's outgoing preservation status (preserved or not
> preserved) during shutdown. This enables the PCI core and drivers to
> safely make decisions based on the device's preservation status during
> shutdown.
>=20
> Note that pci_liveupdate_freeze() is triggered by the PCI core rather
> than from drivers participating in Live Update so that all devices can
> have their status frozen (i.e. prevent non-preserved devices from
> getting preserved late).
>=20
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918200640.8870=
30-1-dmatlack@google.com?part=3D11


