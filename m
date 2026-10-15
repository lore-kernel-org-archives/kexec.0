Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C6DFCC6B33
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 09:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S00GWLqFxC+yjEYO8x+l5SsMW3dmeUVTKVeh0Ga4PsY=; b=CMNM6r7BfQT7SfOSizw1MM8zW6
	YreHmbPqyMBNyck6ye8fJlyt6pqyxwwA50IHRTtyjhu3IlPy85yABkNC7Zv3TZk/cvmCgXvpPq7yl
	l2xyfdMwwNaF0Lvci+htqgsLTN75J2PBEAs/2Vv4ihmpHrbUHCLLfAEse2XJZAdeDdTa4X5aRLHP6
	JxdodJ9cmnnvUWRRpMnoMNSm4mIQ/TbLcQDimNljWQY4Eg1v2yfzNBaLeTYLOogoOY+eQ2lT7MAyk
	DazDZ5QZHshlAF5muwfB9vtG9bcYNkBaJ/FjWK/2TTrXH9ecJAPGu+27gRBFAks2HuBBkJVjHnknj
	ADoI9aAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHI1Y-0000000HJ5J-41jx;
	Thu, 15 Oct 2026 09:45:20 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHI1W-0000000HJ4j-0fbl
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 09:45:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C38D242DC0;
	Thu, 15 Oct 2026 09:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350361F000C4;
	Thu, 15 Oct 2026 09:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792057516;
	bh=S00GWLqFxC+yjEYO8x+l5SsMW3dmeUVTKVeh0Ga4PsY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=JG1LfHlTheCZe3J/U5rLEc9NFts7E54X7DElxt3L/girCLqAMEraQDYyWy55YI3qL
	 P9zmjP1wvaucxWsvtOhWXgnXFdpquUs+kG+EwRv9BTGwM4bm+5ObV+ewQGkjcZy1fB
	 Wpxb2Yj5shujnvxHBXhQJyqQWHVwajN/E0vzABixcOCzIb+tHh1x0c04XQrL8hDgHl
	 OmbU31ngEU7MOTvZ3cztrE/30w5CJ8/LWoPuzZNyPqMQVGAozlGcmkxm7/94viYRab
	 ShGEmuJ3U42Qa2nCa5T5o8DFxDq1t6GyMa9AH2GweJbsTXg7U98ancgZ7SwdzDkVS9
	 BJU9owlmMd+fw==
Message-ID: <sashiko-outbox-172592@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/7] selftests: liveupdate: Add tests for
 LIVEUPDATE_SESSION_FREEZE
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, rppt@kernel.org, shuah@kernel.org, akpm@linux-foundation.org, vipinsh@google.com, dmatlack@google.com, kexec@lists.infradead.org, pratyush@kernel.org, graf@amazon.com
In-Reply-To: <20261015093816.2438942-3-pasha.tatashin@soleen.com>
References: <20261015093816.2438942-1-pasha.tatashin@soleen.com>
 <20261015093816.2438942-3-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 09:45:15 +0000
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

> Provide luo_session_freeze() in the liveupdate test library and add unit
> tests in liveupdate.c covering the LIVEUPDATE_SESSION_FREEZE ioctl. The
> tests verify that an outgoing session with preserved files can be frozen
> early, that freezing an already frozen session returns -EBUSY, and that
> attempting to preserve an additional file descriptor into a frozen session
> fails with -EBUSY.
>=20
> Also freeze the test session early in luo_kexec_simple.c to exercise
> LIVEUPDATE_SESSION_FREEZE across a kexec reboot.
>=20
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015093816.2438=
942-1-pasha.tatashin@soleen.com?part=3D2


