Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 435EEC88E7F
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 12:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pymhjA3IHUvfc7ZhMmvcj6PWvzmH+JOQJc7von1cOC0=; b=hvCW+pUr6gKphg7Pp3qhM4UpvM
	FsV3VBL8SnKuTnNBE1Lxn+r+ehDukqwHso8KYAnhCpLrcChLi98En4EAaAKeTrIyNyQ4dUNsIrM20
	q5+DZASmAhTdoLl5BLjYC7M+eyXepu3Ku1czIhl3Cs1jvfdgwSKrMmdxc3ploFHf+jcQZnWtJbf3F
	eshZb2p/i0sPE/QKYaaIyfRO+v23dXpFkAlNZQE73gqQ0RGZhh8PcAHCl7DO7RUgTqL3TE1TpR0Qn
	GeUirL54vG7I6h7gUPEfw7be8u5mf80tjqYJK8bu06OhcfRkiin9P3J9t08fhZo4UfE6cxV1hcJ7E
	/eBNo7rA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6S0U-00000006Pgd-0E0l;
	Tue, 15 Sep 2026 12:11:26 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6S0S-00000006Pg9-12Eh;
	Tue, 15 Sep 2026 12:11:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7B5A9600D1;
	Tue, 15 Sep 2026 12:11:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DCB1F000FF;
	Tue, 15 Sep 2026 12:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474283;
	bh=pymhjA3IHUvfc7ZhMmvcj6PWvzmH+JOQJc7von1cOC0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JM7MUu1K3sK0BfbZuufGSUMTjcYng5dpse/wo3EWLf21O2gUgw322DSgVB01AFTtW
	 t52UvxD3bLuUqeuFrp1OK6t6wHAM7ouPbrca6pE9eJrANghgkKMIS9n0Gf/wy0wloB
	 LbU8P8uOHsEx8fNW9Woaznh5JHxhxpBoxXgSLs2p/Y+nXpZgm4aiuBP11/FKE+6Agh
	 dOG9FMxrGVQ/eMMAs/LGH2WwzJPb1jSL8PT90CSvhiLFlxbJWRZR7M9jUUHoxVSb0a
	 49DnQM0TYsO0aM6hSLHh3aoQiYMzGZw+8DgpMeFwYhEfOeLW9W3pCge4KeYSBScMZG
	 GXoCvsjJhnAaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 21/50] io_uring: commit fds per request
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: bpf@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, "Jens Axboe" <axboe@kernel.dk>, linux-m68k@lists.linux-m68k.org, linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "Oleg
 Nesterov" <oleg@redhat.com>, =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRh?=
 =?utf-8?b?YmxlKQ==?= <brauner@kernel.org>, sparclinux@vger.kernel.org, linux-parisc@vger.kernel.org, io-uring@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, linux-mm@kvack.org, "Alexander Viro" <viro@zeniv.linux.org.uk>, linux-sh@vger.kernel.org, "Jann
 Horn" <jannh@google.com>, linux-snps-arc@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, linux-mips@vger.kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, linux-hyperv@vger.kernel.org, linux-hexagon@vger.kernel.org, "Ingo
 Molnar" <mingo@redhat.com>, linux-openrisc@vger.kernel.org, "Eugenio Perez" <eperezma@redhat.com>, kexec@lists.infradead.org, linux-csky@vger.kernel.org, virtualization@lists.linux.dev
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-21-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-21-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:11:20 +0000
Message-Id: <20260915121121.62DCB1F000FF@smtp.kernel.org>
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

> io_uring requests don't complete on syscall exit of the task that
> submitted them. They complete:
>=20
> - inline from io_uring_enter()
> - from task_work on any return to userspace
> - from io-wq workers and from the SQPOLL thread
>=20
> The CQEs are visible to other threads before any syscall returns. So
> commit the reserved descriptors before the completion is posted. Commit
> them after ->issue() based on the request's result and before every CQE
> they post.
>=20
> Nothing reachable from io_uring reserves yet. Once SCM_RIGHTS is
> converted this keeps IORING_OP_RECVMSG working from io-wq workers and
> the SQPOLL thread.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D21


