Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C56606A32C
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 22:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3rn+gXQ6;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YJKcaicv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8eGubJTOCnJnITzIXMMxMGy3wCz1aEDqmrPh5iTYuKQ=; b=3rn+gXQ6g6KfrJa/VrVhFTV8oo
	sOowInYxXntCdItq/ChU4+UikQYepypinD1OIxD4PEaG+rUaO+PDqUFcDkIfWt9mrw50pTjZVa1N1
	Ux8YdNoSERklnRMJTlb3/tdXcnCl2M2b9/VdYvk9YKgE745sQhqq9lxNURkjaIbJSBL+wMJy4z5sZ
	GzisHMNC+HlC8wWRAJWs2rrBpc+zkcqJGJJjYw4wb67mKqR9bnxiT6yDHWYYiyxA9vJbOuKed78UO
	HAuExRDUeeDZyGR9rWL7swtCC3SUjCwgggLE/0tII4AsOK0djSovancwBgIQGvSWNebQto091aJE5
	Ixs6fqag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUAm4-0000000DaWk-2IWJ;
	Thu, 19 Nov 2026 22:38:36 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUAm1-0000000DaSj-3MoF
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 22:38:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8A3D746747;
	Thu, 19 Nov 2026 22:38:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3411F000C4;
	Thu, 19 Nov 2026 22:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795127913;
	bh=8eGubJTOCnJnITzIXMMxMGy3wCz1aEDqmrPh5iTYuKQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YJKcaicvr+GE5HrDzT+MnxN47v+qwt7PKKGcCq9VaPgWsg0MOCHRjVbWco5vgHsbL
	 LsMTitZpQWGhKqbXrP2GVNYgr+5ZXJuwNh8Mn1EvQBLeUJkfyP6EKmBDu/59BgcmBM
	 do9kDIbYLgJHufnALWxC/Oa19y7+kmjWmCFnRxX4JY61QT+n0LNtN/gbvAl7GI9BX9
	 Tj4R6jpfJ6FUrG0lsRsdyJm/O+Q6UU43T+52F74JT+lupbQTPhmUXAFKgi37qBxGL/
	 3uGBYbLgEBNUNc6fCWthhtPUQdERkRkx9/Q2Gt852o1lYDlG0NZ6kesDP/64Re+EvV
	 xLtxyXdnzV7ZA==
Message-ID: <sashiko-outbox-224142@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 07/13] PCI: Refactor matching logic for
 pci_dev_acs_ops
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
In-Reply-To: <20261118223704.3286085-8-dmatlack@google.com>
References: <20261118223704.3286085-1-dmatlack@google.com>
 <20261118223704.3286085-8-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 22:38:31 +0000
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

> Refactor the logic to match devices to pci_dev_acs_ops by factoring out
> the device matching loop into its own routine, pci_dev_acs_ops_get().
> Move the per-quirk device checks into a new .match callback so that
> pci_dev_acs_ops_get() can return the single matching entry.
>=20
> This eliminates duplicate code between pci_dev_specific_enable_acs() and
> pci_dev_specific_disable_acs_redir(), and will also be used in a
> subsequent commit to check if a device requires device-specific
> enable_acs() during a Live Update.
>=20
> No functional change intended.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223704.3286=
085-1-dmatlack@google.com?part=3D7


