Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6D3606A88B
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 11:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=K5GSONKw;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cGkxg11U
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Oy75uPWa0jCFUOquVgVgwNWJp0hYJYnupyTZJ8t3hMc=; b=K5GSONKwDV8fzQHFEEtVOgPzWI
	3KvmkjHE8EsUyUUCIdMskE+GXrECESVbrjFXvtr/b10fHtDyZ3fafyIz+hHQakM7bW2nnW/fNS7Su
	5fekwcL3egQzDP+NyA4aVYe4HJA86jdO/k/ppfjBezDRZrWivnpO1olKj9CVEo6aeOa2lXWeGfu/2
	lvJpBogMU3b0CxgmHyKgsFLKnvEWztBE3hpA5mbXJrUDc7M6kFoj4apFo/lHbxfh1LzCR3/2CmS16
	3qU2HUgzLrpKO2JqKP+UvXKA6ZTGL9WCgeUDGZHfdB520LhQyaHu5/SednDY6rcRLq5llpzjCedGy
	Hwcv+nqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRT18-00000009jH5-3PFx;
	Thu, 12 Nov 2026 11:30:59 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRT16-00000009jFL-3UdM
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 11:30:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1CE4C61918;
	Thu, 12 Nov 2026 11:30:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A311F00A08;
	Thu, 12 Nov 2026 11:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794483055;
	bh=Oy75uPWa0jCFUOquVgVgwNWJp0hYJYnupyTZJ8t3hMc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cGkxg11UfkX84uQlzbchqtsWcMgBYLBziAdRu4TJyBY+M/qnebZ3xGmgHMNZ+eAU1
	 nZza4HqP9ZQ8FYmg7AFoPoXU/ohrA03yGnZGkWxWwiIa1bH/otY3pGmDBWx+RrmMr0
	 IPxeB+sMFtHlTknFamgmyVvlWJYSYr7Kx9czWbMun4DeuZrRhC7Zk8FwPtpoYJ+DVZ
	 5NtMZPhinKxLDiqdklpDbe0LGWSN5D/+RIvQKCH+nV1LAWGngwvI3g3f67Pgp1kbiB
	 GbuCMFg3a6if1An1YpgtELUaN2aSboVOER5ZZsjW8C2rRQwudJrKC4OH7rXlNGSmol
	 RAWfClZvWExOw==
Message-ID: <sashiko-outbox-211020@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/8] s390/kdump: Enable crashkernel CMA
 infrastructure
To: "Mikhail Zaslonko" <zaslonko@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: "Ilya Leoshkevich" <iii@linux.ibm.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Baoquan
 He" <baoquan.he@linux.dev>, "Mike Rapoport" <rppt@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Dave
 Young" <ruirui.yang@linux.dev>, "Jiri Bohac" <jbohac@suse.cz>, "Jonathan
 Corbet" <corbet@lwn.net>, "Usama Arif" <usama.arif@linux.dev>, linux-s390@vger.kernel.org, kexec@lists.infradead.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261112112105.1169118-2-zaslonko@linux.ibm.com>
References: <20261112112105.1169118-1-zaslonko@linux.ibm.com>
 <20261112112105.1169118-2-zaslonko@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 11:30:54 +0000
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

> Select ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION to build the generic
> crashkernel CMA code: reserve_crashkernel_cma() and crashk_cma_ranges[].
>=20
> s390 keeps its own reserve_crashkernel(), the CRASH_* definitions in the
> new asm/crash_reserve.h are only there to satisfy the generic header.
> arch_add_crash_res_to_iomem() returns false because setup_resources()
> already inserts the crashkernel resource.
>=20
> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112112105.1169=
118-1-zaslonko@linux.ibm.com?part=3D1


