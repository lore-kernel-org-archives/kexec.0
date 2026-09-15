Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58083C982C4
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 12:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sOVPYbcZwP0qO0v/wyl6IpYJ7aj9qJBJUvOIh/HcLZU=; b=EaMS27m26hzxX7JiE+U9IUhyuV
	aB9g1Vl0e4yPn+MMLnCTlwJX2On0mppXXVEHK6bYSbDg6galwYmfdIXk1tmYgYRBmFvzoWpS8T6h/
	+EW70RnWnnNsDdSiN/tpH1C4wZw8eWOMhIXokwiXJKemLTe8F91BDOMayVMipR1xCh0afzbRzzNTJ
	qnlhhUd0MI4EyTBBciyhkbL1ziqp07Vv1hLk5ayFq6iYMWqCRHA9ng7D2pkjOUv2Qj+a/nff5O3Qq
	iHOW5dF/IEmBxtpzCJRprhnKrsO57/NrmK+j/pfKI9HgeBJ/TGIK2ZAEoIJEvDXYKGz+JJYJt0z7x
	RbdGXiYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6S0V-00000006PiU-1i62;
	Tue, 15 Sep 2026 12:11:27 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6S0U-00000006Pgi-1zH6;
	Tue, 15 Sep 2026 12:11:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CC954602A8;
	Tue, 15 Sep 2026 12:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D341F00893;
	Tue, 15 Sep 2026 12:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474285;
	bh=sOVPYbcZwP0qO0v/wyl6IpYJ7aj9qJBJUvOIh/HcLZU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RmyX0EJ1B0zOgT5ioEXRLk+o4F4Y5EudQ2MyBappoNbd4lClHN+PysLRe+lqvPVp5
	 tBwJMbqCeZEv7naOUmB5POnQKn+dbX0K1SIPTGnovxWaK3d1hrbCQzt+QTOIjSS0jv
	 ozOLD3b4lQSvA/CU30dXodluwPZzgV+Ca6K7iJVN6Vk+KD4JQXyjNYe7jK3mYcGLUH
	 4XnCIyui6X4vRwCLNy4FaV+3AmDMv+qiX7nSh5emNDsXdPMr643qZCL0VouKa3ayzv
	 pThUPgyUG/CP/C8WVCikSGDKsjSd8zkAPHVNK+58jF+szrJfKJpZ9+ygivmoI9WEAz
	 pHHOzSGPpXmoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 29/50] drm/virtio: install the out-fence
 descriptor when the ioctl returns
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: kvm@vger.kernel.org, "Jan Kara" <jack@suse.cz>, linux-csky@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, dri-devel@lists.freedesktop.org, "Jann
 Horn" <jannh@google.com>, linux-parisc@vger.kernel.org, linux-snps-arc@lists.infradead.org, "Ingo
 Molnar" <mingo@redhat.com>, linux-mips@vger.kernel.org, linux-alpha@vger.kernel.org, linux-um@lists.infradead.org, linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev, io-uring@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, "Jens Axboe" <axboe@kernel.dk>, linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>, linux-hexagon@vger.kernel.org, linux-sh@vger.kernel.org, linux-openrisc@vger.kernel.org, linux-fsdevel@vger.kernel.org, sparclinux@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, "Eugenio
 Perez" <eperezma@redhat.com>, kexec@lists.infradead.org, linux-gpio@vger.kernel.org, linux-m68k@lists.linux-m68k.org, "Oleg
 Nesterov" <oleg@redhat.com>, =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRh?=
 =?utf-8?b?YmxlKQ==?= <brauner@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-29-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-29-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:11:23 +0000
Message-Id: <20260915121123.B5D341F00893@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D29


