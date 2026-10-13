Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14CBFCC6B1A
	for <kexec@archiver.kernel.org>; Tue, 13 Oct 2026 16:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nE1mkOMZDpT6on2AX1ya/fJXSU9L87RAWUT5ffMU6JE=; b=lVV9p870pzySZ3IzalCOU1eOfh
	kBaxyoHbsroe9Syx59ahfVRQ1FbvApDLfDgY1yKsFRHbDAZMi08H8BQkZu7EAJlDG+H8YZef6ldIm
	mA9FuitBa0ElEx+xJ0lrIyKK5vGlG5/CbA9MOTA/If5OIrHpux2bPGUORGSttzIdkUErdpMGxsn39
	DLZGgxCSF0FGZmwonNpJgJjsIRkp6pkbB3zWXBomH+i31WKit34DOnPYg/Fs5IU0ukwcmsgLJIyQ/
	TOSJXlQoTLW/asFWKfDA5PDybt21h1mer+5B9Z6kB7zOQrwLJ2zHfzgln49WD5gIcnUbT1MCaFQ8K
	wSyP1bZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfSp-0000000DXFg-1zl6;
	Tue, 13 Oct 2026 16:34:55 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGfSm-0000000DXAm-3hkv
	for kexec@lists.infradead.org;
	Tue, 13 Oct 2026 16:34:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8954D447AA;
	Tue, 13 Oct 2026 16:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AFDE1F00898;
	Tue, 13 Oct 2026 16:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791909292;
	bh=nE1mkOMZDpT6on2AX1ya/fJXSU9L87RAWUT5ffMU6JE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F6IczZAfZSrhmBjggcLW7HlWGGSGs1cPWftoiH/ed5+UR7kdvFCgQRQy0JzKXubWF
	 saM1E5QPt8NfHlMwK5tpaVshuhzLdPdYPh61XU2XRuHVcKZoGwHoEwQGY7q3dDrjbT
	 jNIMfEn7EHXOVTg9N+NQVuG6GzEWUbK9faASdq0AmsIaQKSKWI13zzTtXQCldlIcki
	 ck5bgEV1BUNg2cGTDcMcuep71JhdD05WnTZ4UkiP8NsIYyHFKOUOgoJ6Xd9F85qzL0
	 QD2VShp+d0ufvKXtgoHvyx/Dzuo7+HHoHfalQEI2BgPK4rWuHxr0Rr/cXdZ9dQWT6k
	 3hxYj1mhF6Blg==
Message-ID: <sashiko-outbox-170120@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 07/13] PCI: Refactor matching logic for
 pci_dev_acs_ops
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
In-Reply-To: <20261013162529.1928093-8-dmatlack@google.com>
References: <20261013162529.1928093-1-dmatlack@google.com>
 <20261013162529.1928093-8-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 16:34:50 +0000
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

> Refactor the logic to match devices to pci_dev_acs_ops by factoring out
> the device matching loop into its own routine, pci_dev_acs_ops_get().
> This eliminates duplicate code between pci_dev_specific_enable_acs() and
> pci_dev_specific_disable_acs_redir(), and will also be used in a
> subsequent commit to check if a device requires device-specific
> enable_acs() during a Live Update.
>=20
> No functional change intended.
>=20
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013162529.1928=
093-1-dmatlack@google.com?part=3D7


