Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913D9606A335
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 21:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=29lVXyjj;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bPpfmmkv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=UlpI4GQ7yqIId5MqKlorgIMDKAUcLnv9Id74zHLZKh8=; b=29lVXyjjf2wmr/midiKCLZu+zO
	JoqbTPtyMtg7wjcFMjVevkJMboeiCTPXmy+eCmK4q3h0vUgrdd4p6hByNRFdV2GfdJB8+IWURbUfv
	0Jb2K8tcJ/1YcjfiHfhyB5lU3y0vL8TIxFBiFVkYhUQ9TDtEov6y41MY/6/y+zA/Br9Uu9pAnbjc2
	2XMqgjrk9ctDr3+kjODL286WnYS4CF4tOOe3YMV1IX/5mzmtI4toPUsGl/nVZpmtrV8aZN5Z4uxGj
	TcYC4TDHAxBGRLsitYXoznOK0P3VfLpgnbGq2T1qMWz0K0ICZSrFv/uJHaSrkjptdXqG12X9qF7mD
	rJhSXZLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTnIR-0000000AKd0-1I9p;
	Wed, 18 Nov 2026 21:34:27 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTnIQ-0000000AKcq-2eiD
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 21:34:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BCAE163A6B;
	Wed, 18 Nov 2026 21:34:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6FE81F000C4;
	Wed, 18 Nov 2026 21:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795037665;
	bh=UlpI4GQ7yqIId5MqKlorgIMDKAUcLnv9Id74zHLZKh8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=bPpfmmkvO25wmvYZMH4EX8pDTNQWWvjLLhxADTWPoXCJ/4nhpzSFd+bzQRt9KxkVx
	 7LOUbZTvIzb1PdvJUnAN5j2PYFAMBlZ5q+9anyyJgm6RyAwZ+MGdg5QW/f3fa+b8DI
	 nstKqmtUpkh8SEILPOCtBTv1r/t5YVjxj3iLiTtiHrIAViWtLX08Mr//NxVRcoPINH
	 ebT9l6+Qxwc1DmacpwLusRI2KcZNhXStrWO8OJfvLmBFQS+vvgXEzRUHSx2yFvh0MG
	 u7fTWP8/n4Me/SAZGzQxbCjeBgM1kog763ApqeoTDGWVMMP4KTsjOvFOeYdCpZKPxA
	 qKgXOtulu8pGQ==
Message-ID: <sashiko-outbox-222005@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 7/7] selftests: liveupdate: Test
 LIVEUPDATE_SESSION_FREEZE across kexec
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, rppt@kernel.org, shuah@kernel.org, skhan@linuxfoundation.org, vipinsh@google.com, corbet@lwn.net, dmatlack@google.com, kexec@lists.infradead.org, pratyush@kernel.org, rdunlap@infradead.org, graf@amazon.com
In-Reply-To: <20261118212845.2855249-8-pasha.tatashin@soleen.com>
References: <20261118212845.2855249-1-pasha.tatashin@soleen.com>
 <20261118212845.2855249-8-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 21:34:24 +0000
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

> Extend luo_multi_session.c to exercise auto-frozen, kept-open frozen,
> closed uncommitted frozen, and closed committed sessions together across
> a kexec reboot, and verify that freezing an incoming session returns
> -EINVAL.
>=20
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118212845.2855=
249-1-pasha.tatashin@soleen.com?part=3D7


