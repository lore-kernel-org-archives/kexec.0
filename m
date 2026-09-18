Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF8FDC982DD
	for <kexec@archiver.kernel.org>; Fri, 18 Sep 2026 20:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sPMFs+N7+9joEThLRn1A4j3xw35F8/P+UFOYT3cS5vs=; b=aLZbOXSGb7tgNMPHgDgDKtZgk6
	SxuIuzb5Dw3xye1YBgbfmi27EANkDNTgMyGmjwrjQgipscuQn2vkBSsXYZGvf9Mh0CanT2XW+nBLn
	Hk0fz4bOKV4gjH6zEKPQdGNZQOD1rXuz6XcpatdO8L7TyGbk3yGkelk7Y1UxpKaG7I0dwO0qFwwU8
	ZmlaC4vD7572TD8fMFpwn8nJUrcKX87hzY6/+4ShKom9BoRr1WLEMKTGbtSHK51iL/N/P2RLZVmIc
	PryuWoM3Jr/+Cg+HAN3kG4e6BwZQrPQfkFxypdpWWv3n/n7qqCMjjWeJI2Mqt+uuCdaiJTW61EPAD
	sz4AZVqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7f3G-0000000FVCu-12Q2;
	Fri, 18 Sep 2026 20:19:18 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7f3E-0000000FVCo-3Fiy
	for kexec@lists.infradead.org;
	Fri, 18 Sep 2026 20:19:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 808F64125D;
	Fri, 18 Sep 2026 20:19:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC1D1F000FF;
	Fri, 18 Sep 2026 20:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789762756;
	bh=sPMFs+N7+9joEThLRn1A4j3xw35F8/P+UFOYT3cS5vs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YPlYpnky7mi7B4nDnFiPWFOktxyeOfZ6KKSL7GtCns3H/qFcDP2ymrRRryPu9vgtG
	 q3IxdutHh9FQV/SOx9Wfr7nM7nCvaF6c9fG3dRTc5Pwi6HbXkMEUHCpWm2l+XRvbMO
	 jyeanBPSSs+r9gtihibrV5eci0c2MBoImHb46PnH+WRVi7fbVIbl1nqRcZ4IT6EXdJ
	 lZg0alLcSFWRV3YTOLv2NZHPojAX5Wlyzk00C/tqasLB3LL6/+D84ZWFbIYsTxj4KJ
	 4z1cNCOfQScLPAOORjL2DmtXqRtwA2LJtSLXY7mhhQ0A87b9VYfmZ+8i8MSYTSbUfP
	 5LSVRzzVbIVGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 10/13] PCI: liveupdate: Adopt ARI Forwarding Enable
 on preserved bridges
To: linux-kernel@vger.kernel.org, "David Matlack" <dmatlack@google.com>, linux-doc@vger.kernel.org, linux-mm@kvack.org
Cc: "Jason Gunthorpe" <jgg@nvidia.com>, "Leon Romanovsky" <leonro@nvidia.com>, "Vipin
 Sharma" <vipinsh@google.com>, "William Tu" <witu@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, linux-pci@vger.kernel.org, "Mike Rapoport" <rppt@kernel.org>, "Parav
 Pandit" <parav@nvidia.com>, "Pranjal Shrivastava" <praan@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Alex Williamson" <alex@shazbot.org>, "Jacob
 Pan" <jacob.pan@linux.microsoft.com>, "Alexander Graf" <graf@amazon.com>, "Adithya
 Jayachandran" <ajayachandra@nvidia.com>, kexec@lists.infradead.org, "Josh
 Hilke" <jrhilke@google.com>, "Lukas Wunner" <lukas@wunner.de>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "David Rientjes" <rientjes@google.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "Samiullah Khawaja" <skhawaja@google.com>, "Yi
 Liu" <yi.l.liu@intel.com>, "Chris Li" <chrisl@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>
In-Reply-To: <20260918200640.887030-11-dmatlack@google.com>
References: <20260918200640.887030-1-dmatlack@google.com>
 <20260918200640.887030-11-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 20:19:14 +0000
Message-Id: <20260918201914.EFC1D1F000FF@smtp.kernel.org>
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
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918200640.8870=
30-1-dmatlack@google.com?part=3D10


