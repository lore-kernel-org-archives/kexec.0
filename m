Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E888AC88E7F
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 12:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6NXKxiOzguyQnoEQO9LxNWTE3iRxMjdJkj6A9mUtc1A=; b=sq5dd94Fschrq2HUV0e9DMp4p/
	LNBoRsRSbWE9nmttQ5GRTeWTyKVRCpaJiQoiUSpjJjQw4BYVHVR+7rkd3Pqa+SX3hP0yCGFVDcBG6
	YKy8oqgwsNK16UN87oord/MGOuDfAetZUbEB9s+pU9NQsqMXGpSZmwmrO668rqaPVdOQXmooS6GA2
	BifCCb4iSIdSlLQ0HPlUkv2vD5Uwkove2mtS3w5QjyDrVmfxQjP+AgPRYtSsUls5YAfJiZUPdTsmK
	RAwgL4GIFo8kXlGlB+1IP7Dmrc9AdgVbihwA+Bb+mRFBNijOARGMYaIf9YIfb2BH9XMKguLDwMltn
	wPqV59XQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6Ruo-00000006Nw7-0S6O;
	Tue, 15 Sep 2026 12:05:34 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6Ruk-00000006Ntz-1prB;
	Tue, 15 Sep 2026 12:05:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A62D4602BA;
	Tue, 15 Sep 2026 12:05:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A631F00893;
	Tue, 15 Sep 2026 12:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473929;
	bh=6NXKxiOzguyQnoEQO9LxNWTE3iRxMjdJkj6A9mUtc1A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FDJd/hPeWG0FQGFbVQjHL1xaPx+T4d5yH5y0Mqbs4pp43o2C3upF/W55cT90yNZY4
	 v0CafCNhn1kfUl9h7/L0G5/2wNT5neqTqXK1mtIHm20rdFzMa6a0JXvgrTKQDa2K0W
	 EpyGSa4pPf3XBWtOTiJWh7acs1xFeKBBUrITujioesXQ0DN26+ocUVIuUJXjh9lEiD
	 QW0DJtvJfkNM/dUEI+lhs0qoSh0U77pi23KqFNoxn/b6iLktEYEx4XGqLkDOAMdead
	 IPztuAKWtncrXXjrtf8THfsOVlqs6SliB8QXWO1MitwNOfsiyqey3a0R1jD39UUoJy
	 wXnPZLwUqx0VQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 26/50] dma-buf: stop unwinding sync file
 descriptors by hand
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: "Oleg Nesterov" <oleg@redhat.com>, linux-hexagon@vger.kernel.org, virtualization@lists.linux.dev, bpf@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-csky@vger.kernel.org, kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, dri-devel@lists.freedesktop.org, "Jan
 Kara" <jack@suse.cz>, "Eugenio Perez" <eperezma@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-alpha@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>, linux-um@lists.infradead.org, "David Airlie" <airlied@redhat.com>, linux-snps-arc@lists.infradead.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, linux-openrisc@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-m68k@lists.linux-m68k.org, sparclinux@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Jann
 Horn" <jannh@google.com>, linux-arm-msm@vger.kernel.org, "Peter Zijlstra" <peterz@infradead.org>, kexec@lists.infradead.org, io-uring@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-26-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-26-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:05:27 +0000
Message-Id: <20260915120527.97A631F00893@smtp.kernel.org>
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

> Rely on the fd exit path machinery.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D26


