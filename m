Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F14F606A321
	for <kexec@archiver.kernel.org>; Thu, 22 Oct 2026 15:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=n3TBzHdn;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vk4dAdwQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=MM4qKb+lwfz9u4oUIRD1UWE75e7K7Inr6v9zjgZVszM=; b=n3TBzHdnOA/54NqihnPis+IeeG
	/z9s10mwdlOULLmHQfpVM8F3KDey5tapbp3F188Z5IxHLZbd8iJvn1sfbR3gqXTwezXGHTSpF/pxJ
	+4kjQP1PVnMPw5iQYYVwOxBJvfrJJMfJpywXGfQpPIoha20gE8BSztHdUluhuENUf9i5pQvxmK8cz
	46eEaIuPSyKZ+KMHeMIkw6hmJVt9q1aeWeu2w75eeDGcWOLT3bemVOB/3BQKJ3jf+v0UTbDzT62cL
	vDz0pBfsDDUS+UZg/QpgF6F1sNgWitzZucXM/qO/5w7bv15o1EuhhwgMBUMQCjY2Ly4/eVBD59cMz
	wEQo4hhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJugT-0000000EPCw-2q9M;
	Thu, 22 Oct 2026 15:26:25 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJugL-0000000EPCe-3jtn
	for kexec@lists.infradead.org;
	Thu, 22 Oct 2026 15:26:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1CFB441A39;
	Thu, 22 Oct 2026 15:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB691F01825;
	Thu, 22 Oct 2026 15:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792682777;
	bh=MM4qKb+lwfz9u4oUIRD1UWE75e7K7Inr6v9zjgZVszM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vk4dAdwQOmG4GJ5soumV+3aXqQ4zjQy/aTibAR1YCe8Ti6GQyEGmtYXU2GrR8HZtL
	 K5kXY6ghFdf4se8DjUqgticmj7nKarDCJK9VcZCppplvv4DUFxXI2RA1Vud3A2axVW
	 SqVtGPofa1tz5eq0RuIQyKpVNblcQxOR2ehV2uAS3G2aXw4oYEmOu3v5pyTchoseqY
	 0F3Hp7NGiGtt0V5z60qG9h0UIITgDEeLzMqPvlcAnQq+8MXUTbNpolBUjqUIF/4BPJ
	 RpuuWFxyHfBu5dyVc+uBrCZAeZiDZfkMAjm6Vd/obOjG4cXxxDRUXBmdRtNtu6smI/
	 uWJdqUyUBrIpw==
Message-ID: <sashiko-outbox-181695@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 1/4] liveupdate: Rename handler compatible to
 name
To: "Tarun Sahu" <tarunsahu@google.com>, "Andrew Morton" <akpm@linux-foundation.org>, joro@8bytes.org, "Mike
 Rapoport" <rppt@kernel.org>, "Pratyush Yadav" <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, "David
 Matlack" <dmatlack@google.com>, jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com, oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org, dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, will@kernel.org, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Alexander Graf" <graf@amazon.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, baolu.lu@linux.intel.com
Cc: sagis@google.com, linux-pci@vger.kernel.org, kexec@lists.infradead.org, skhawaja@google.com
In-Reply-To: <20261021152527.375070-2-tarunsahu@google.com>
References: <20261021152527.375070-1-tarunsahu@google.com>
 <20261021152527.375070-2-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 15:26:15 +0000
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

> File handler and File-Lifecycle-Bound (FLB) identifiers name the
> registered handler or FLB rather than a monolithic compatibility version.
> Rename compatible to name across LUO headers, structures, and consumers:
> - struct liveupdate_file_handler and struct luo_file_ser name field
> - LIVEUPDATE_HNDL_NAME_LENGTH (in include/uapi/linux/liveupdate.h) and
>   MEMFD_LUO_FH_NAME
> - struct liveupdate_flb name field, LIVEUPDATE_FLB_NAME_LENGTH,
>   PCI_LUO_FLB_NAME, and LIVEUPDATE_TEST_FLB_NAME
>=20
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021152527.3750=
70-1-tarunsahu@google.com?part=3D1


