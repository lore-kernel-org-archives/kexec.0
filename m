Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FD0C79F82
	for <kexec@archiver.kernel.org>; Wed,  9 Sep 2026 00:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hR6AzeipmBNfow8mYwPAoPhp3cQitUb8cZO/RDd6r7E=; b=fPVhs1Bobkj1InTwdVfmhJhwqj
	pfvPc9meVGzxY/dhlt+1NVo7Nf+VuxnZx8nGf6DU4m9rRhnIC1zAvTTtETIuiwBoX9Zjdb2mDav9A
	8RduJ4oo/4B0YIEGXbHeLwPWEs0au8jNaKbh4JKoOofKsqCHgIBha8HAqUm9bL4URlrBU353+fjlr
	4v7YEsEMOIuEtll3WbXZTOO0N1pzkLtOW9PJ0oMfJpz8WxXRQfoCLXxMr16rzSBjcZYwWGGCsAiCb
	Yynys3o6EdHtvqUwaN3G9tu1zJGOOY/mUUhP5aGzXcNHfNwKSzSG7creZ+gx4sBRpnd+2LcvGeHIi
	Ci5tsE4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x46Kz-0000000AWTi-0wvA;
	Wed, 09 Sep 2026 00:38:53 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x46Ky-0000000AWTJ-3HUF;
	Wed, 09 Sep 2026 00:38:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C178B601FB;
	Wed,  9 Sep 2026 00:38:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D791E1F00A3A;
	Wed,  9 Sep 2026 00:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788914331;
	bh=hR6AzeipmBNfow8mYwPAoPhp3cQitUb8cZO/RDd6r7E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XqnnaihLeqlAAgNthOwQ8qW5VX2A9G7ziPHbje7fECJa6JOHn5Uoyj1VqzV0pxV8A
	 bYe9bqTZ9RNyxavVNmoodZI2H2ftdy5egU3oXjyvyUXJQbPSEB6YsOu7M0qFr0KUHw
	 gFwWRoNeHrd8O7GHLZHAxsh48/9w6pqZG9VjIcqQ/o9/AyV+zzcYtD0z6Em8THcqFd
	 1qkLTLbbUAOxDlwL8qEONCJilGJF14DRPuf87Tj9HInslKMrfTqD15LEzVhAH9jurE
	 wJYaYaDLeixv5Lyj5IxgBRn7+L/rVXtkOmIt2/DPz31UBDpD+pkD0PBX2LX0ZBkVQ7
	 jHVBb9FQavdXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 9/9] Documentation: kdump: Add arm64 and ppc64le to
 encrypted dump target support list
To: "Coiby Xu" <coiby.xu@gmail.com>
Cc: "Baoquan He" <baoquan.he@linux.dev>, "Jinjie Ruan" <ruanjinjie@huawei.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, =?utf-8?b?b3BlbiBsaXN0OkRPQ1VNRU5UQVRJT04=?= <linux-doc@vger.kernel.org>, "Dave
 Young" <ruirui.yang@linux.dev>, "Randy Dunlap" <rdunlap@infradead.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Jonathan Corbet" <corbet@lwn.net>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Will Deacon" <will@kernel.org>, kexec@lists.infradead.org, "open
 list" <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, "Sourabh
 Jain" <sourabhjain@linux.ibm.com>, "Shuah Khan" <skhan@linuxfoundation.org>,
 =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>, "Mike Rapoport" <rppt@kernel.org>
In-Reply-To: <20260909003657.1570544-10-coiby.xu@gmail.com>
References: <20260909003657.1570544-1-coiby.xu@gmail.com>
 <20260909003657.1570544-10-coiby.xu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 00:38:50 +0000
Message-Id: <20260909003850.D791E1F00A3A@smtp.kernel.org>
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

> The encrypted dump target support is now extended to arm64 and ppc64le.
>=20
> Fixes: e3a84be1ec2f ("arm64,ppc64le/kdump: pass dm-crypt keys to kdump ke=
rnel")
> Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909003657.1570=
544-1-coiby.xu@gmail.com?part=3D9


