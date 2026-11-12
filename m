Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAA1606A8BF
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 11:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=No7PT5qC;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A1rEevOg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=HqMXct5PEV6biJSL+up+Q5a/LP0cl+Qu44P49RwE4SI=; b=No7PT5qC6/1btA8kSeL9EWTCwF
	RRFuag1P7rhOBCyyAB9PQjhP2N/DmS/T8hfrckGykcM34Xa17plX0FL279BsrActV6G+xmDRoAM9t
	fkymuiEBSZaQw8C284S16MP+MkCoe8LHNSXAB8TcWM20OS8i89Gda8/tt4BGbjzRUxv5D/yPpmfyV
	qyxOnsnXb9HFJAu4MzShy21glZffMXAmaIgYnL38ypQLARMh7gGZrGSq2jCZF9DEHT1UYRcyxI14k
	UappdZKQ1efXw56UzoMfiH4trgo0QxApJ+H7OLNc9QAIf1YPCjYyNMm4QKDOYBLflUBh71cTVHb1Z
	vN+lELcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRT0x-00000009jBL-3MoR;
	Thu, 12 Nov 2026 11:30:47 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRT0u-00000009jAi-2A51
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 11:30:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CBE2447A1B;
	Thu, 12 Nov 2026 11:30:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23BD51F00A06;
	Thu, 12 Nov 2026 11:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794483043;
	bh=HqMXct5PEV6biJSL+up+Q5a/LP0cl+Qu44P49RwE4SI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A1rEevOg5JKxJ7L23C//RbmcPanr5CdRQSIJIMowEqwo9dkPnJ6IO/FDAFrocC5IM
	 ycmZW7y+hHdkSYx728Qt6I4XWAJnaoRYoMmb7SfplelzOozah3KLQahlvGMt3zma8f
	 AFgzFluQCDb3lo9VoMg4H0mVFp7baMbUJW3C0qBdkDmUxmK7veoK1fT5TQCdgFgukX
	 38FWT7o4kIRf+F9a6Yb8sJnkmEhHR6LSCgPW/ys47YQn05Hqo0i+7TvkqxiacpQH4p
	 wBjL7q/iECIsU3Zr9R7BcSXmb4dLr63tDblsKVicpbqM3hfPtqqbXQ+L9UhgXyBEam
	 laP9Sco+Kh5Ig==
Message-ID: <sashiko-outbox-211018@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 7/8] s390/kdump: Skip the crashkernel CMA DMA wait
To: "Mikhail Zaslonko" <zaslonko@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: "Ilya Leoshkevich" <iii@linux.ibm.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Baoquan
 He" <baoquan.he@linux.dev>, "Mike Rapoport" <rppt@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Dave
 Young" <ruirui.yang@linux.dev>, "Jiri Bohac" <jbohac@suse.cz>, "Jonathan
 Corbet" <corbet@lwn.net>, "Usama Arif" <usama.arif@linux.dev>, linux-s390@vger.kernel.org, kexec@lists.infradead.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261112112105.1169118-8-zaslonko@linux.ibm.com>
References: <20261112112105.1169118-1-zaslonko@linux.ibm.com>
 <20261112112105.1169118-8-zaslonko@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 11:30:42 +0000
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

> With a crashkernel CMA reservation, __crash_kexec() waits 10 seconds
> before starting the kdump kernel, so that pending DMA into the CMA
> memory can finish.
>=20
> s390 does not need this: before it jumps to the kdump kernel,
> s390_reset_system() issues diag 308 subcode 1, which terminates all
> in-flight I/O.
>=20
> Let architectures override the timeout and set it to 0 on s390.
>=20
> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112112105.1169=
118-1-zaslonko@linux.ibm.com?part=3D7


