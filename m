Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFE8606A31C
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 11:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KoUf4L9+;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TVvzxf5+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3nXvkAeO7Bm2WcIP7t4PG/vLc+F7G7Lf+egf8x9mTLc=; b=KoUf4L9+gEd6BEVL8xGYq+9IBS
	UgjZA6sFnkp0KeF+AcxStq/juqRfnQzhf55N6DySoQfPPWbQhiqHNjt6+eVUCAnm6Bct2glDbWmTs
	RIGuhuXigiBpCQiMkvqg2HAyoOGwathxC3UJaAKT1vJeqp+XEglo/omHeeHjDGz9f8VYD5rQZTDTE
	JLspvR8E4yoWjzF78ItY2P0CglScFVTr2ykV2DUM1es18TDatbl8foOES25DY7xRyq2aoeU71TJDz
	mC3A8uNivj2ePJr9QX+8CM4j6wqWklq+cahEdUGc2nO8To4Tx0bglWiERDALajKKLJjLqhaRaPhRo
	Uzrwnvyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRSw0-00000009gWN-1TDw;
	Thu, 12 Nov 2026 11:25:40 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRSvy-00000009gW5-1qPp
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 11:25:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B69BE6397E;
	Thu, 12 Nov 2026 11:25:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B6F1F00A08;
	Thu, 12 Nov 2026 11:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794482737;
	bh=3nXvkAeO7Bm2WcIP7t4PG/vLc+F7G7Lf+egf8x9mTLc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TVvzxf5+GOH5nwMsZHx11vwFa6qvKAXySRLmwc1L7bhkbSZecRf9U2VX4znfVLMAm
	 sh3WiUVnGgTRcrh06Odum3WoeCnk1Cep8DDg7soObl9rKz7+R0FZSRTwouU/o1HK5C
	 QVzVWAmiURH/YGr0RFoGeyFIoSBsUvQ5m4zpXZ38eeS3mE2NaidW3BvdDCqugQfH/h
	 bvXa1dZl8qgXpn/b+PdbEjjXJB39OfvZlilkiXL/X6EK4x9VeSgdjI0Gnx2OQBefHv
	 HvMy7VXQLX3ZA+Mm5MvXx+0ba1TfN26CtV0tAq+0oz2kAKg02n0ltQYyL4dSRG/pH7
	 Pgbj1Nd651YnQ==
Message-ID: <sashiko-outbox-211013@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 8/8] Documentation: kdump: Add s390 to crashkernel
 CMA
To: "Mikhail Zaslonko" <zaslonko@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: "Ilya Leoshkevich" <iii@linux.ibm.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Baoquan
 He" <baoquan.he@linux.dev>, "Mike Rapoport" <rppt@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Dave
 Young" <ruirui.yang@linux.dev>, "Jiri Bohac" <jbohac@suse.cz>, "Jonathan
 Corbet" <corbet@lwn.net>, "Usama Arif" <usama.arif@linux.dev>, linux-s390@vger.kernel.org, kexec@lists.infradead.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261112112105.1169118-9-zaslonko@linux.ibm.com>
References: <20261112112105.1169118-1-zaslonko@linux.ibm.com>
 <20261112112105.1169118-9-zaslonko@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 11:25:36 +0000
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

> Add s390 to the architectures supporting crashkernel=3Dsize,cma and
> mention that on s390 only kexec_file_load() passes the CMA memory on to
> the kdump kernel.
>=20
> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112112105.1169=
118-1-zaslonko@linux.ibm.com?part=3D8


