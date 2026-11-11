Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCD1606A324
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 06:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YgYVyIaB;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TSQRUEek
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Wm+QBXzWox8/MSAn20XhSTfS6IOUVHhSpLLWhk/HeBw=; b=YgYVyIaBGg2oyqGLVMV2IZZEkY
	DRjvSxRAtjTN34yW3p92/aVQKhuCGgsJfoBpCo1wSXJShT4b1assuBQ+q+K3lhgcTZu5EgNQIJfv5
	JGAJTdoPSG0uwONNGMKC9zZonHw7Ms8kji2P/bhtcrmkRxj0EIvnZrkAIBR+rRpFv0QzYXVllqoFu
	EeQBpMJ2W0TIl4AD5nK73eEMcViwI8C2WI7kKeiBOR9TFfCvVm7bivkz4+6xPJyeQan9H4drlNLQL
	Z8Y5ndRRsqD+bvfAU0wU/l3Fu2gVp2Qfvoppp25NVrlBzFBzpPO93BPJV1e5tI9AaO9UzDhU2zYnd
	+g4ZJqpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR1dH-00000005iwn-32rM;
	Wed, 11 Nov 2026 06:16:31 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR1dG-00000005iwU-1LZp
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 06:16:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 694DB612BF;
	Wed, 11 Nov 2026 06:16:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD671F00A05;
	Wed, 11 Nov 2026 06:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377789;
	bh=Wm+QBXzWox8/MSAn20XhSTfS6IOUVHhSpLLWhk/HeBw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TSQRUEekdkwGDLq2LTN3GpGBXdfZ0KxjVfw1G/H3ctBMN+1gGe6dsT4aoct25Juk4
	 RC2k5L2Wzt255/pRIiYYzul4oYZOEDbAvn21gL0CXCXTqrLwNg/Ek1ppeJKUI6nnqn
	 LpX26y68ngPrK14CYEUiFFg9OnXkKdCPdFxNguAV/ZnBQ9ggBtPlPFUSJd6R2/Cp0P
	 0LwXznFmywYWVdRdykNiRvonxDbsnT3Oyh2UXYXnTNN4s4GPYg737ndvazO1Odinpb
	 LCEsg8yrQX+7ewzrEjofiw0AWPjpdeye4IcdgxjXYTPu1c2jWfNqFCPtTgGa9B/aeo
	 lRIUpxC23ir2w==
Message-ID: <sashiko-outbox-208404@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/19] liveupdate, kho: Remove __packed from KHO, LUO
 and memfd ABI structures
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, will@kernel.org, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, "Bjorn
 Helgaas" <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, gle.com@google.com, pbonzini@redhat.com, "Andrew
 Morton" <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: linux-pci@vger.kernel.org, "Pratyush Yadav" <pratyush@kernel.org>, kexec@lists.infradead.org, skhawaja@google.com, sagis@google.com
In-Reply-To: <20261110050202.529473-2-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-2-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:16:27 +0000
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

> All structures in include/linux/kho/abi/block.h (struct
> kho_block_header_ser), include/linux/kho/abi/luo.h (struct luo_ser,
> struct luo_file_ser, struct luo_file_set_ser, struct luo_session_ser,
> struct luo_flb_header_ser, struct luo_flb_ser) and
> include/linux/kho/abi/memfd.h (struct memfd_luo_folio_ser, struct
> memfd_luo_ser) have naturally aligned fields on 64-bit architectures,
> with no padding holes between fields or tail padding. Assert both the
> structure size and 8-byte alignment under CONFIG_64BIT at compile time.
> Any future unaligned field addition should come with reserved field to
> keep the structure aligned.
>=20
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110050202.5294=
73-1-tarunsahu@google.com?part=3D1


