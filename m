Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4795606A31A
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 17:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YYC9reVN;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CQGVDx6K
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2vI6KzgrnPxEOj0USenG4BIbwiqedR/9Zf6hU8t5a6o=; b=YYC9reVNz0V1SVpOly4SnXOcfO
	1uYyE0oAi2LeuvrDqwOe7f55gVR0mcc4swhI7J/bDj6t6cjAUOHf1qyKbkXaR3oMpIF6A4X6nqIDG
	ezY/5zv45h900ysSOukvwPK2GB5RsFrpLXyqRtYj8W+EXohVmvTyhwQ4vkG0/edHLtmBrVlcnXMDx
	hp+yU3gsAnv0rFyaaqEbPp0D/CLvGVEXNVDRtrWba71DIxoX2BIxMKRyZoskW0EZtxc2CDgCqpCi6
	IXmG/9px3FMBJC2brc3nN1ejsqIErLl1mlD1cEJJz9A12ga2XrqTBy7dZpMIrheAWfalzW4AYaFHL
	Txoz0W7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLOtP-000000031aR-0Lnh;
	Mon, 26 Oct 2026 17:53:55 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLOtN-000000031aH-3vTu
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 17:53:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1697960A5F;
	Mon, 26 Oct 2026 17:53:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9211F01825;
	Mon, 26 Oct 2026 17:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793037232;
	bh=2vI6KzgrnPxEOj0USenG4BIbwiqedR/9Zf6hU8t5a6o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CQGVDx6Kl6TaGpyZyFVXBd0mKX8FhldSjVyK9ESbaMEO0h6R6vBQzlxv3nCblerJ/
	 O9YUY5lm3fzs7ni3keUyscyef47z34nt/Ao2FqsG06qa6/u1Hf4gVGNRDwIJRhsiTN
	 eViPsmbxc6r+OxL7TMSNNPc9WLEicpWCZA4kdnqD66iBGUIQIZ/vNfvjJka5M4peOQ
	 CNJ8OE5BJiTBpI9DQ7LCtsorG1gQEXcQYJgUuuInWlhdmj7VrgSLpGEcPrx1K6lVoW
	 KbxQEpzVWCQEQi3x/uhgnB7/ifTKN9ztPAkJ94JoCTvwkz3rGsr/M84s6OPMCoBZkx
	 2A/fuC3FBtnbw==
Message-ID: <sashiko-outbox-185598@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 1/4] liveupdate: Remove __packed from LUO and
 memfd ABI structures
To: "Tarun Sahu" <tarunsahu@google.com>, loganodell@google.com, alex@shazbot.org, dwmw2@infradead.org, seanjc@google.com, "Mike
 Rapoport" <rppt@kernel.org>, will@kernel.org, pbonzini@redhat.com, jgg@nvidia.com, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, arnd@arndb.de, "Andrew Morton" <akpm@linux-foundation.org>, oupton@kernel.org, baolu.lu@linux.intel.com, "David
 Matlack" <dmatlack@google.com>, robin.murphy@arm.com, maz@kernel.org, "Alexander
 Graf" <graf@amazon.com>, joro@8bytes.org, "Bjorn Helgaas" <bhelgaas@google.com>, kevin.tian@intel.com, "Pratyush
 Yadav" <pratyush@kernel.org>
Cc: kexec@lists.infradead.org
In-Reply-To: <20261026174217.603114-2-tarunsahu@google.com>
References: <20261026174217.603114-1-tarunsahu@google.com>
 <20261026174217.603114-2-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 17:53:51 +0000
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> All structures in include/linux/kho/abi/luo.h (struct luo_ser, struct
> luo_file_ser, struct luo_file_set_ser, struct luo_session_ser, struct
> luo_flb_header_ser, struct luo_flb_ser) and include/linux/kho/abi/memfd.h
> (struct memfd_luo_folio_ser, struct memfd_luo_ser) have naturally aligned
> fields on 64-bit architectures, with no padding holes between fields or
> tail padding. Any future unaligned field addition should come with
> reserved field to keep the structure aligned.
>=20
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026174217.6031=
14-1-tarunsahu@google.com?part=3D1


