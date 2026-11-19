Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E0B606A326
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 22:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2Gz2Ouj0;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RHfDuebs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Rft8BhkDVgM3lrqAebPZw2F/X34gjZWU1HoE0P/PeGI=; b=2Gz2Ouj0I65kNTFXvcc7k8G9bh
	a7ctdFrXEfiL4z6oXK0j2J3BCNSFkZSB18kM+QSsgbUdikInYIf/hcLuk9ZxlpsdzvgnIqFaYcrxk
	uKiXPwUR9yd2Vzq7UTifUZ744uey7aRbs6SOAp49BAZe5O1KKG9NbzDBolkDzpcxLt35mSpBB7hiA
	JYKsReK4fYals9pj6jU8YkjXr1nd+Ce4NXK5thgtYl3qlIQaOwD3XLje1GR52M1xwhv/UvGNThERE
	rvcXyMcqs3iRygYdV716aCITf4lDbgt3MYKRfwBmX+t9HZCfHs8h26MyaG5WVY7wlCCbPmWKr7JO1
	TxKFXw4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUAls-0000000DaII-48QI;
	Thu, 19 Nov 2026 22:38:24 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUAlo-0000000DaHC-2X7B
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 22:38:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CC09046518;
	Thu, 19 Nov 2026 22:38:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E381F000C4;
	Thu, 19 Nov 2026 22:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795127899;
	bh=Rft8BhkDVgM3lrqAebPZw2F/X34gjZWU1HoE0P/PeGI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RHfDuebsp9CcyVmwxWUNXy+YCzZcEgiFPXgtRTSnZSmDVvReT+Y1Unlbgw5YwLN68
	 w5hDOJUJwfpjeOFPGxLU4u26V+preUnnSiyVqvwPie6NotkKMgDHwPwlN7L5KsAy+S
	 IEqOXxIWh8h65+cBkF1/tctlMmgfGG0Qi2sScY6jT66idOoGakVgkRY3QyLevQ9lQ3
	 +kPxMK3ee3RDYmhxoC8wL/3bAH5/ffLDZhvIC8JeJQASxgJWhopV+kXPMlYC+Qj45S
	 L0mCjBwYmWrGdOUSfKTfBwTN2Z5BrPH1s28LWv7Kx+UcPsStIXCOj2woBgb4c9dGAB
	 OTCJm1k7ZKEWQ==
Message-ID: <sashiko-outbox-224136@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 01/13] PCI: liveupdate: Set up FLB handler for the
 PCI core
To: "David Matlack" <dmatlack@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, linux-pci@vger.kernel.org
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
In-Reply-To: <20261118223704.3286085-2-dmatlack@google.com>
References: <20261118223704.3286085-1-dmatlack@google.com>
 <20261118223704.3286085-2-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 22:38:17 +0000
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] PCI: liveupdate: pci_flb_finish() logs unpopulated args->data
- [Low] PCI: liveupdate: separate __free() declaration and init in
  pci_flb_preserve()
--

commit 525f211f02fbb47d85199fbccf703e0ddc3e892e
Author: David Matlack <dmatlack@google.com>

PCI: liveupdate: Set up FLB handler for the PCI core

This commit introduces a File-Lifecycle-Bound (FLB) handler and KHO ABI
for the PCI core so that PCI core state (struct pci_ser) can be allocated,
preserved, retrieved, and freed across a Live Update kexec.

> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> new file mode 100644
> index 0000000000000..173433f64d002
> --- /dev/null
> +++ b/drivers/pci/liveupdate.c
[ ... ]
> +static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
> +{
> +	struct pci_flb_outgoing *outgoing __free(kfree) =3D NULL;
> +	struct pci_ser *ser;
> +
> +	outgoing =3D kzalloc_obj(*outgoing);
> +	if (!outgoing)
> +		return -ENOMEM;

[Severity: Low]
This isn't a bug, but per the Cleanup API conventions, outgoing can be
defined and initialized in a single statement:

	struct pci_flb_outgoing *outgoing __free(kfree) =3D kzalloc_obj(*outgoing);

[ ... ]

> +static void pci_flb_finish(struct liveupdate_flb_op_args *args)
> +{
> +	pr_debug("Finished struct pci_ser (0x%llx)\n", args->data);
> +	kho_restore_free(args->obj);
> +}

[Severity: Low]
Will pci_flb_finish() always log 0x0 for the address of struct pci_ser?

liveupdate_flb_put_incoming() zero-initializes args and only populates
args.flb and args.obj before calling flb->ops->finish(&args) (matching
the struct liveupdate_flb_op_args contract where @data is only provided
to .unpreserve() and .retrieve()). Logging virt_to_phys(args->obj) would
print the actual physical address.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223704.3286=
085-1-dmatlack@google.com?part=3D1

