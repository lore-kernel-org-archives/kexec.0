Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A77CC6B19
	for <kexec@archiver.kernel.org>; Tue, 13 Oct 2026 16:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HoODgCJzXTqjjh7wAFdyCzkCbxOfO9p0npLXBlbsnmU=; b=WumuNfr/n2QLIXC3xZIRA8vRQE
	82vleNwVIfO2QFB1lVUbiryWka4zppzL48/ImHNuOx2z0ryCeXUHz51w6u9Dl6CmYL4eMkr85/2ix
	Jl/eeMyUWAUd941YSUpru6IwtMaqHiG1iLS7IxJB9mIjbvdg7BDWDLpAowVPeL0ivW7Q4xnVoIflP
	uixzBuw+AkSrqRcm7HOBHLP4hIfjeC9LYhUCHI8PIFD+TpLWNx+vXO2782KpdnDfJDJzupjnwF+yC
	ZMW6Fv3y0pOvrxeVqQ2J9uThdGZURiXBs+OGC5UVjPCUkrIIpT1PfD0oFMghdePbiEMm++QLigDc+
	kNtVIIhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfMW-0000000DVUd-1yyl;
	Tue, 13 Oct 2026 16:28:24 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfMV-0000000DVUP-0C3z
	for kexec@lists.infradead.org;
	Tue, 13 Oct 2026 16:28:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 97C5F41404;
	Tue, 13 Oct 2026 16:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30FBC1F000FF;
	Tue, 13 Oct 2026 16:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791908902;
	bh=HoODgCJzXTqjjh7wAFdyCzkCbxOfO9p0npLXBlbsnmU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HeNnihRlFwiXHrr5YoMqeQWCimJM54roT275liKqHD0MVnrmZuomrUIuBIcDKYJkE
	 W5SpppvO30YUpwNAFpwkYcni0LnJqwtZFMkp4Bu1RK7iBqq71Of5C+6ranqD5H/3my
	 5JRQFgtQvwecju1otxVtvwXsvPzfWgMxwWnrszep7HYm1ea1XHX13UEam3crD77/fz
	 OvUKaYh1jfn53vAGVgJ/8eEK4cnSCGEmjaIDg9FhZRNpzmhYRIGIqScwIlTwdQJF+M
	 nbn8XA8nwjh+HtvbYl60DhjuDXgZFNtlVums5tdR7DDhofFGj5xhKGkihuk5vg7Rjn
	 GPlQqfc9f+LnQ==
Message-ID: <sashiko-outbox-170110@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 04/13] PCI: liveupdate: Document driver binding
 responsibilities
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
In-Reply-To: <20261013162529.1928093-5-dmatlack@google.com>
References: <20261013162529.1928093-1-dmatlack@google.com>
 <20261013162529.1928093-5-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 16:28:20 +0000
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

> Document how driver binding works during a Live Update and what the PCI
> core expects of drivers and users. Note that this is only a description
> of the current division of responsibilities. These can change in the
> future if we decide.
>=20
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013162529.1928=
093-1-dmatlack@google.com?part=3D4


