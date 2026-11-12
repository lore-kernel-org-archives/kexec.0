Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6BD606A31C
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 11:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hRoSbpKv;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XKM1hCEB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=zLsrZztbD+ZscRIw64dNIPk38Ao6S3WgpMxepM0KndU=; b=hRoSbpKv8XtdZl4FRJu/MEI5Y5
	y2bNkPvpidK+WWd6DVLgiDkfop0umfHQcuvQWDgGKnzIunsi7hhY3iHGuMZyoNJsEyrQ8c3Xl2Qou
	wLAidMobcEhsPbsMSKgO2z4PVm+iPpNt9gmbSptA9fN78eO2aLUUK5QByUTcEsJBf2b2VBwnf2IiQ
	wLVhanvnPeeVH3Q2gzZaQs4KYxxmlyPU97BfSiQ4LsQYgRSukQTwuft8cEUzSrzp46RA2Z8nK4jbT
	QmhG/uOaVkeOF47W8jH+OUw1zFUl/fsAEQgP38yKoYPRuoPacOFGeepHTVB6lB1vJPQ5USQBV1lbu
	I+Own95g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRT4i-00000009kAi-3Whd;
	Thu, 12 Nov 2026 11:34:40 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRT4i-00000009kAc-0h9t
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 11:34:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 85FC861918;
	Thu, 12 Nov 2026 11:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9631F00A05;
	Thu, 12 Nov 2026 11:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794483279;
	bh=zLsrZztbD+ZscRIw64dNIPk38Ao6S3WgpMxepM0KndU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XKM1hCEB+Y0qpmen5FQZg5n+F3aAUCUNDd6q9uuqcfGcBe902Ijw7gtJ1ZIy1uYTl
	 KZaKYYaeDF2VJIsTDF+GSUgdmAxZGQRS8yS6uC7/WSyyRRAeCl4f5dHn5mHSo+rvMt
	 9ODr2GELrlcmDsHkq/nCCjMDlTtuWnbTXNctPd0S0YcQREerk32CoBQyIXTH9HGX74
	 QoKdUOgw2KOgojaHRhZU+ruAckryVumTQVIT8TsOTDGTnOY6NKQnVr1oUrkRbjONuH
	 bBGohSC2PWKBpMvNjAsubzMEX9ugKTYhjj8teu+WK9sHI7jKeCt8PYs8tSBOPPixTa
	 oyYQXMJfix3Jg==
Message-ID: <sashiko-outbox-211026@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/8] s390/kexec: Pass crashkernel CMA ranges to the
 kdump kernel
To: "Mikhail Zaslonko" <zaslonko@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: "Ilya Leoshkevich" <iii@linux.ibm.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Baoquan
 He" <baoquan.he@linux.dev>, "Mike Rapoport" <rppt@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Dave
 Young" <ruirui.yang@linux.dev>, "Jiri Bohac" <jbohac@suse.cz>, "Jonathan
 Corbet" <corbet@lwn.net>, "Usama Arif" <usama.arif@linux.dev>, linux-s390@vger.kernel.org, kexec@lists.infradead.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261112112105.1169118-4-zaslonko@linux.ibm.com>
References: <20261112112105.1169118-1-zaslonko@linux.ibm.com>
 <20261112112105.1169118-4-zaslonko@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 11:34:38 +0000
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

> Store the crashkernel CMA ranges in the parmarea of the kdump kernel,
> next to oldmem_base and oldmem_size, when it is loaded with
> kexec_file_load().
>=20
> The ranges use 64 of the 72 bytes of pad1, which is enough for the four
> ranges the generic code reserves at most. They are sorted by address
> and unused entries are zero. Older kernels ignore pad1 and kernel images
> have it zeroed, so old and new kernels still work together.
>=20
> For kexec_load(), kexec-tools would have to fill in the ranges. It can
> read them from /sys/kernel/kexec_crash_cma_ranges.
>=20
> Co-developed-by: Vasily Gorbik <gor@linux.ibm.com>
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112112105.1169=
118-1-zaslonko@linux.ibm.com?part=3D3


