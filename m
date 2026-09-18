Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9382CC982D7
	for <kexec@archiver.kernel.org>; Fri, 18 Sep 2026 20:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OAEsOLRukFLus0d8Tfr9V8PlCCQdG3TdiUlAGwmhXjA=; b=fgik0JncTjKzyjfRf9YCZCrHIy
	rwBwhlNqDGWcOeK8xkUySRD8GNEQd3gO3OqlpJTsdrn3RqxJM73fod04G3EkPicTqqu4bAR/iQXv/
	3cDOwRObnqV5oLoVYaGtakI180wEun+2769mvbpUH3lgKS0isIrX1kNBieY0HHn2ZFunnqonpdC71
	9owqtWUuAeevFxjE7/KlMnoEmG8glHwW9mbY3liu2NpWz6W6jXMwE4ZgfLBoMf9+3JjAxgl9f7QUh
	bat6+QzhxQVnd2OvoCfIWeOwBbxhgNlhMGDh/dcWvzI9TBjJiYF77r5P/MoWhiVfNSTY1DZGdmj0R
	mNjaabmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7ezn-0000000FUth-2tKe;
	Fri, 18 Sep 2026 20:15:43 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7ezm-0000000FUtS-3Urg
	for kexec@lists.infradead.org;
	Fri, 18 Sep 2026 20:15:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4B333407A5;
	Fri, 18 Sep 2026 20:15:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B171F000FF;
	Fri, 18 Sep 2026 20:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789762542;
	bh=OAEsOLRukFLus0d8Tfr9V8PlCCQdG3TdiUlAGwmhXjA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K//zyog2V0U5XIgFvmnnIv4886FNdZhDLQofPIKBTWXzdsJ0WqbwVY1MECT0yYu4i
	 4ZqWxbUzkgZhfArlZn0Ohx4LFYwze/+QQeCZfTSuZe8bXffQM+TkOo1vajLxH7QWKH
	 pCzk0jC946j9ZqV6KNZOaQ2HQrhA6m3AyVuiamOMb/3xqlTrQVp290o5zWsY95idWy
	 G4mybv/5QF7JoFrCjTh9fQg/QiTBsGdTVOxOAnuaP9GraJEAjOSmEDR2ncBnMgtL/M
	 +ED9/D/rGVUXvb46t+ZZKpA1vQI9jjyYFR8T2zFltuShDIyWw8pfajQO7Jxf92LGze
	 zIJGv2d2yxv/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 08/13] PCI: Save and restore the ACS Control register
To: linux-mm@kvack.org, "David Matlack" <dmatlack@google.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: "Alex Williamson" <alex@shazbot.org>, kexec@lists.infradead.org, "Jonathan
 Corbet" <corbet@lwn.net>, "Mike Rapoport" <rppt@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "David
 Rientjes" <rientjes@google.com>, linux-pci@vger.kernel.org, "Lukas Wunner" <lukas@wunner.de>, "Parav
 Pandit" <parav@nvidia.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, "Samiullah Khawaja" <skhawaja@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Vipin Sharma" <vipinsh@google.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, "Adithya Jayachandran" <ajayachandra@nvidia.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "William Tu" <witu@nvidia.com>, "Josh Hilke" <jrhilke@google.com>, "Yi
 Liu" <yi.l.liu@intel.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pranjal Shrivastava" <praan@google.com>, "Alexander
 Graf" <graf@amazon.com>, "Chris Li" <chrisl@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>
In-Reply-To: <20260918200640.887030-9-dmatlack@google.com>
References: <20260918200640.887030-1-dmatlack@google.com>
 <20260918200640.887030-9-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 20:15:40 +0000
Message-Id: <20260918201540.64B171F000FF@smtp.kernel.org>
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

> Save the ACS Control register in pci_save_state() and write it back
> in pci_restore_state(), instead of recomputing the ACS controls from
> scratch with pci_enable_acs().
>=20
> This makes ACS symmetric with the rest of a device's saved state. Today
> pci_save_state() ignores ACS entirely and pci_restore_state() re-enables
> the ACS controls from the kernel's current ACS policy. As a result, a
> device can come out of a reset with different ACS controls than it went
> in with, e.g. any controls programmed outside of pci_enable_acs() are
> silently dropped.
>=20
> pci_enable_acs() runs when a driver binds to a device
> (pci_dma_configure()), i.e. after pci_bus_add_device() has already saved
> the device's state. Refresh the saved ACS Control register there as
> well, otherwise a subsequent reset would revert ACS back to the
> configuration left behind by firmware.
>=20
> Devices that rely on device-specific quirks to enable an ACS equivalent
> keep that configuration outside of the ACS Control register, so keep
> configuring ACS from scratch for them. Do the same for devices that have
> no saved ACS state at all.
>=20
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918200640.8870=
30-1-dmatlack@google.com?part=3D8


