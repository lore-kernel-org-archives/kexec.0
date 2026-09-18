Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3E6C982DD
	for <kexec@archiver.kernel.org>; Fri, 18 Sep 2026 20:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VhfaDetL1Tv74VraH8efY7aPfmn2/awy9/2560eVmv4=; b=I2ai+P5yWx35Ronv+7LuwGNjMA
	qEs4EoTCXyccVd1AMLgy1EwG/JpIAAwbONLKTPb+k1LP542vvJTMpJKDgX9vd/r+uJ37qBtdiqBFV
	4xEKq7jBz1qEiN4zt4W1Sz8alaEK3qVsEMoqqQ7AnOrF63EkHCZ7tcEDYPwph0VxpKUm3F2i+Chh3
	XZT5D5gWHq5hf8CO3TPl9jDxonB9ufjgzo8fttmw6otdNCOOv2cdfWFNk+Hppn8PwOaZY2P+TvMq/
	41yxrpue9tIfSyN6Aowm2XiQYdHNZJEc9wnXaCJs+qgMMJX+FesmsUCwCGnta6gkqhq5qWEOW/mGi
	WMhRWmVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7exa-0000000FUYJ-3nXB;
	Fri, 18 Sep 2026 20:13:26 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7exa-0000000FUYA-08wg
	for kexec@lists.infradead.org;
	Fri, 18 Sep 2026 20:13:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5B697602CC;
	Fri, 18 Sep 2026 20:13:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987D31F000FF;
	Fri, 18 Sep 2026 20:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789762405;
	bh=VhfaDetL1Tv74VraH8efY7aPfmn2/awy9/2560eVmv4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c2D0ixt7SdY2SGgfpEcGVOwKxPpgIgHPNI6fJUCb1pwoHY5HHE8zoEEH0BZ6gZ0Sr
	 /BLYVOhP6Rgc384qGqrFpI9J1eWiexKj9FFFE7OOVaVWGuXSfLzlcx6GiRyNGvcPKy
	 4pTmnFOtkzelPFI9uucqmthqaSz7i2vUFGBPExR8B3P314nvDmm0hPoV60RfbRZiq/
	 KVrhnvBPKXgTEYUxEALxM16oKhGb0Pvs2LZsnAlVm8xYb//HYPpgD5Wj+q4YgO0uiS
	 RUWCaziVH6ZMq/xt+twk84Kj4GNYrMoeQB7P4Z1wYTTCOjeai8ePTMey+f6kRDkETh
	 7EbFfaX3KZr+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 06/13] PCI: liveupdate: Preserve bus numbers during
 Live Update
To: linux-doc@vger.kernel.org, "David Matlack" <dmatlack@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: "David Rientjes" <rientjes@google.com>, kexec@lists.infradead.org, "Jacob
 Pan" <jacob.pan@linux.microsoft.com>, "Leon Romanovsky" <leonro@nvidia.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Chris Li" <chrisl@kernel.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Vipin Sharma" <vipinsh@google.com>, "William
 Tu" <witu@nvidia.com>, "Parav Pandit" <parav@nvidia.com>, "Bjorn Helgaas" <bhelgaas@google.com>, "Alexander
 Graf" <graf@amazon.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Yi Liu" <yi.l.liu@intel.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Adithya Jayachandran" <ajayachandra@nvidia.com>, "Pranjal
 Shrivastava" <praan@google.com>, "Alex Williamson" <alex@shazbot.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, "Lukas Wunner" <lukas@wunner.de>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Josh Hilke" <jrhilke@google.com>, linux-pci@vger.kernel.org, "Jonathan
 Corbet" <corbet@lwn.net>, "Mike Rapoport" <rppt@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>
In-Reply-To: <20260918200640.887030-7-dmatlack@google.com>
References: <20260918200640.887030-1-dmatlack@google.com>
 <20260918200640.887030-7-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 20:13:23 +0000
Message-Id: <20260918201323.987D31F000FF@smtp.kernel.org>
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

> Keep the secondary and subordinate bus numbers that the previous kernel
> programmed into bridges, rather than assigning new ones, if the previous
> kernel preserved any device across a Live Update. Do this even on
> architectures that would otherwise always assign bus numbers themselves,
> e.g. when pci=3Dassign-busses is passed.
>=20
> Preserved devices must be allowed to continue performing memory
> transactions across a Live Update, so the kernel cannot change the
> fabric topology. Changing the bus numbers of a bridge changes the
> RequesterIDs of the devices below it, which would require disabling and
> flushing any in-flight memory transactions first.
>=20
> Apply the policy globally rather than only to the paths that contain
> preserved devices. Bus numbers have to be preserved above a preserved
> device anyway, since an upstream bridge cannot expand its window. A
> [ ... ]
> Require that CONFIG_CARDBUS is not enabled to enable
> CONFIG_PCI_LIVEUPDATE since preserving bus numbers on PCI-to-CardBus
> bridges requires additional work but is not a priority at the moment.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918200640.8870=
30-1-dmatlack@google.com?part=3D6


