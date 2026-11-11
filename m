Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3807960A2600
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 06:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qpB2INFL;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GXLQGJ8d
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=chgLcgNWWDGwDS8IqCXKr0ZTijn05W98YYLpF3I9fXQ=; b=qpB2INFLVtM6j9NyPI9bb/Y9YD
	1hb/cvXv4Kx4CSAnAX09QACPWcqZTZp/ZVTNoLIIl3+ABiDg1ZGjRnyaJ8rfDArWqrLCKFIBtF9Rw
	OEQcoserWQRYKytT5V6aSVQbULRegjWldz1wa8srr6X7vVOuVVGIT3XZYUB5kvLEFlQzVJGPEwdL+
	8y879ElCikAEDvxBRUeCr7hoMBzzNc/3tcuowL1Izg9CxD+3ociKqQZb5Hsq/bFAmz96dVtPyc25v
	bBj+sWjMBZrAa7XeigjNx7r5rewYzKupALNij4+fDmKbKd0qe7o6xxXztzQnpvSEQptSZ9IYYZTFW
	By5YXMLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR1dY-00000005jCQ-3hjG;
	Wed, 11 Nov 2026 06:16:48 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR1dV-00000005j8Q-242x
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 06:16:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 40C7444880;
	Wed, 11 Nov 2026 06:16:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E537B1F00A05;
	Wed, 11 Nov 2026 06:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377805;
	bh=chgLcgNWWDGwDS8IqCXKr0ZTijn05W98YYLpF3I9fXQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GXLQGJ8dXsA1/UYCos49+g9Y7cLE5tsm8IwgSlxkiDcmcKHWhhQd2k8M9H2ODszNZ
	 7GgEM0J0wxIL9+ahDrbmQ+YIFYNOn1M6Uiit1BLcGZlyf/h2aGevvQwIcIZ6WTbhL7
	 7mf32uJ/68t+fJRAFgfdlbfrU+qyc/0Ib+s1NJqwpSZC9kB1rIE2FenpZKYkz6izOx
	 YA8lExodMVE9TdZrzRSHqxwPfZnY9bJInGuqkv9z5GVSMJGiYcrIywAW1eTEpVASBN
	 OgO3CQDxvzrjcxiysUPQ4yzC1c6AGmocsTQJTV+K8LsXbOEcBn+/c/kyZNY11hMZWP
	 j7mF45/R67uUA==
Message-ID: <sashiko-outbox-208413@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/19] liveupdate: Add feature header to struct
 luo_session_ser
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, will@kernel.org, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, "Bjorn
 Helgaas" <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, gle.com@google.com, pbonzini@redhat.com, "Andrew
 Morton" <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: linux-pci@vger.kernel.org, "Pratyush Yadav" <pratyush@kernel.org>, kexec@lists.infradead.org, skhawaja@google.com, sagis@google.com
In-Reply-To: <20261110050202.529473-11-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-11-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:16:43 +0000
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

> Precede each serialized session entry in the LUO session KHO block set
> with struct kho_ser_hdr via DECLARE_KHO_SER so future session features can
> append fields to struct luo_session_ser without breaking compatibility
> between adjacent kernels.
>=20
> Size session block-set entries using kho_ser_size(luo_session_ser),
> initialize each entry feature header during luo_session_serialize(), and
> validate the incoming feature header in luo_session_deserialize_one()
> before accessing the struct luo_session_ser payload.
>=20
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110050202.5294=
73-1-tarunsahu@google.com?part=3D10


