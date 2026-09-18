Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3A7C982D7
	for <kexec@archiver.kernel.org>; Fri, 18 Sep 2026 20:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0mvUweI6LVBPNQEepHdBFnrekjGsiPZ/QHwECl64qEQ=; b=kSlqVbQEVDgfiGcE/ee4UQJQzB
	xuLmPEZzBfp8wtt+5S/1lvo50m7uEJrwfygTLf8XPoI8d8+M3lt52HE4y7/U6lt3FtgqX3Tr3rpGV
	mv6Icm/r78Kg9RQomstFwiboyRDkUo97VaODEavMZ6M/vjQXLPfKH0U4T5aEaS/grUeqxeC+FyQKM
	2Pkk9+OgigILqyAxzbydyuvMMNYTudiwvkhhYmmWNr5u8oRZUOMmVgX1dbEjROe51hsXhEnorjQSd
	ohfX0vSaxpkjYD0YT+5lqQgurEfBcPeJo71xmcImzEgiPPKrKgGWiho8wKussWP8+QwymN4xXj2uT
	556NNTqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7etV-0000000FU5u-0X1T;
	Fri, 18 Sep 2026 20:09:13 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7etU-0000000FU5d-3VUi
	for kexec@lists.infradead.org;
	Fri, 18 Sep 2026 20:09:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6D67B436D7;
	Fri, 18 Sep 2026 20:09:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6EF1F000FF;
	Fri, 18 Sep 2026 20:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789762152;
	bh=0mvUweI6LVBPNQEepHdBFnrekjGsiPZ/QHwECl64qEQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W/Mldq4h5/cLD2pUa/DgWkA03MpbXuZlIHxIkDytYVQJvjTbENm4nRXEc2+CCx+jo
	 1s4arjt9Cp3O9MoLeNhbtEUa6eq7dwLCpSC9Yv+T5muc9iJ2B1RgizBY0qnVFKZvdj
	 +Lll49pXmPatXIM6AFUnuX8vioCs5z57nmEJqmgQqHCuVUapf5rJmFno7H5Zbw1qHU
	 Uy0dWh7vbhPCydklKF/HpuCSYphNIVTt+rFhs/V/nwugrKKSwOYizAtJxCs1m1jAmn
	 9ZJ21/mUBza39FWbEI0wegy/PYVXdjOPs6uoudIfnZLf6NU1MV1iLGErpeikW+lDLP
	 F80I/03u8yrgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 04/13] PCI: liveupdate: Document driver binding
 responsibilities
To: linux-mm@kvack.org, "David Matlack" <dmatlack@google.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org, "Randy Dunlap" <rdunlap@infradead.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Saeed Mahameed" <saeedm@nvidia.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "Pranjal Shrivastava" <praan@google.com>, "Alexander
 Graf" <graf@amazon.com>, "Shuah Khan" <skhan@linuxfoundation.org>, "Mike
 Rapoport" <rppt@kernel.org>, "William Tu" <witu@nvidia.com>, "Adithya
 Jayachandran" <ajayachandra@nvidia.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Jason Gunthorpe" <jgg@nvidia.com>, "Alex
 Williamson" <alex@shazbot.org>, "Parav Pandit" <parav@nvidia.com>, "David
 Rientjes" <rientjes@google.com>, "Vipin Sharma" <vipinsh@google.com>, "Yi
 Liu" <yi.l.liu@intel.com>, "Chris Li" <chrisl@kernel.org>, "Leon Romanovsky" <leonro@nvidia.com>, "Josh
 Hilke" <jrhilke@google.com>, "Pratyush Yadav" <pratyush@kernel.org>, linux-pci@vger.kernel.org, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Lukas Wunner" <lukas@wunner.de>
In-Reply-To: <20260918200640.887030-5-dmatlack@google.com>
References: <20260918200640.887030-1-dmatlack@google.com>
 <20260918200640.887030-5-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 20:09:10 +0000
Message-Id: <20260918200910.DC6EF1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918200640.8870=
30-1-dmatlack@google.com?part=3D4


