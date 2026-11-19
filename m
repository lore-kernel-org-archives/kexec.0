Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BB6606A330
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 22:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Te0T3Z5K;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LcMHzkQR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=dXDGDFZiGAWXcI9vIcz/BhexRx9A2x23MiNmB9mDVkY=; b=Te0T3Z5KkvLZUmHW12pzkolGqR
	1QpiAun79CEgSF6WxwcgptYRrXm2vRUF9sJkh7cBo/F50IzIMIIQ3M0Vr892nQ6XhI8IWbnPzsqe0
	JzP0LdBOQWOkvj+zFBVMbdoWWUTyaNGd7/NQFsCVviUN3ovQDGY00XDy21318oJ7PqKanWrHU4w6M
	KV9+vA6dVKWzwYi/SR8n785FYIR5VZg3NF6wJErAsgjlwYDpeYTckJuq8jr+TqPwe4K5jH/eOiYh7
	LEpsN8h628ufxfujiYSPIJDC8fTyRZUuruBy183PKclFDaJH6Eey9cxQIJuaJZxmpDtqhCptSXxCn
	NzMSa2gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUAmH-0000000Dal7-21DE;
	Thu, 19 Nov 2026 22:38:49 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUAmF-0000000DajB-2Ren
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 22:38:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0807661FDA;
	Thu, 19 Nov 2026 22:38:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF1D1F000D0;
	Thu, 19 Nov 2026 22:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795127926;
	bh=dXDGDFZiGAWXcI9vIcz/BhexRx9A2x23MiNmB9mDVkY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LcMHzkQR10FYbEM7SUCzt7A9/vpN1FpYbTgOnDFynkUW+XA0E8GtsO71s1AVzeKCs
	 jMvg1iLpgkaxuBNF5MNBZrTQuOdTYQ0rYY6aH95XcODHlc2rozHszwOwYEi0bEaOo5
	 7I3THb4pU6mFXzA8HR+MpF/eRWuBUxr2qWpCmS/t7awJyrgEj3QvW5kbv86+Lz/EWK
	 p1DURKbyxIDDLTusatVFrNWnEowQL7C0k8WCh3u3Q0g9fVTV8P6rrNA4Bo64kRxjKu
	 hgQ+wIxH/Kf43hbxv8E/mrS+NklKj3s2ckTQSLGT9HdHug7dRpMOxkvlIBqfM35lYK
	 yWMTVVwk0OsjQ==
Message-ID: <sashiko-outbox-224147@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 12/13] PCI: liveupdate: Do not disable bus mastering
 on preserved devices during kexec
To: "David Matlack" <dmatlack@google.com>, kexec@lists.infradead.org, linux-pci@vger.kernel.org
Cc: "Adithya Jayachandran" <ajayachandra@nvidia.com>, "Alexander Graf" <graf@amazon.com>, "Alex
 Williamson" <alex@shazbot.org>, "Alex Williamson" <alex.williamson@nvidia.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Chris Down" <chris@chrisdown.name>, "Chris
 Li" <chrisl@kernel.org>, "David Rientjes" <rientjes@google.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Jonathan Corbet" <corbet@lwn.net>, "Josh
 Hilke" <jrhilke@google.com>, "Leon Romanovsky" <leonro@nvidia.com>, "Lukas
 Wunner" <lukas@wunner.de>, "Mike Rapoport" <rppt@kernel.org>, "Parav Pandit" <parav@nvidia.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pranjal Shrivastava" <praan@google.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, "Samiullah Khawaja" <skhawaja@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Vipin Sharma" <vipinsh@google.com>, "William
 Tu" <witu@nvidia.com>, "Yi Liu" <yi.l.liu@intel.com>
In-Reply-To: <20261118223704.3286085-13-dmatlack@google.com>
References: <20261118223704.3286085-1-dmatlack@google.com>
 <20261118223704.3286085-13-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 22:38:45 +0000
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> Do not disable bus mastering on outgoing preserved devices during
> pci_device_shutdown() for kexec.
>=20
> Preserved devices must keep performing memory transactions during a Live
> Update. Clearing the Bus Master Enable bit would prevent these devices
> from issuing any memory requests while the new kernel boots.
>=20
> Because bridges upstream of preserved endpoint devices are also
> automatically preserved, this change also avoids clearing bus mastering
> on them. Clearing Bus Master Enable on an upstream bridge prevents the
> bridge from forwarding memory requests upstream (i.e. it would prevent
> the endpoint device from accessing system RAM and doing peer-to-peer
> transactions with devices not downstream of the bridge).
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223704.3286=
085-1-dmatlack@google.com?part=3D12


