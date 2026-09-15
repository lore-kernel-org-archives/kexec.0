Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B1EC88E7B
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 11:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1FXL4Jf8yBVgDdd94W09xM8udoaJZ5UUF8s2j4f47FI=; b=aIRkkljjq5kJTmoAAPrFfcZDua
	+D9tsUpbieTkP/vTwsCB6c7cp1CL7z+hQ1NJKeLKyHWbzxzMaPi7RDqvfcny13EV0HJvQS6dKuRTH
	7hT0wV6GgbUY8dPBsV1UTsuA4GVmJRDZFhIKKqTYJJz6uiApmNDV21ycYCzjceDDWtK1t0vUpfmG8
	uw36i1uBWMfKahuev4jseBcNGqQhWOFH7Ekglt5qUmorUvRh5Z2TNoo5ZJBxLiyjSVBcHio6i8hij
	zhjfUKQbU+cvNdGwlRcHE4HWy1Ig3N5fXDwUmzZ1yxR3gydgkKxh4UuSD6hAlF61J/lYFewCyJO7z
	yiG46XJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6Rcw-00000006HUU-0pVS;
	Tue, 15 Sep 2026 11:47:06 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6Rcv-00000006HUD-0Uf9;
	Tue, 15 Sep 2026 11:47:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 65AF9600D1;
	Tue, 15 Sep 2026 11:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06AB1F000FF;
	Tue, 15 Sep 2026 11:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472824;
	bh=1FXL4Jf8yBVgDdd94W09xM8udoaJZ5UUF8s2j4f47FI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QZ2fNNJCuZ/sDU9+NThrbq1C/6AJLSLjjYgkUbk/7nyMpmrJulfwzYoTCnnUhGe1L
	 CM809wjln9o8pUKvHaoaakBSdFe1J5tqURNyqgIGcIuV6TRA8iPD7jKUcKFqitGx8q
	 oytUrD66lpaS6duQZikdiD0MeK2wDhNbj/m9eIQI7ZfsqhvaTsVLdZ3ePpFdtQU9w3
	 reft3HQkQjN4ISX6sjFZlRkikFCalaD/JcuYF22HxwucYna7hJWQtoxtZdruPzMFDI
	 MwYt7lw+eOd2EaBTBnZye65X6XApTnuMpo5CD8CFs/K5wRHgdlLP4ZJrnz4u511/Ze
	 ZevBo3IdlwroA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 07/50] csky: commit fds on syscall exit
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: linux-mm@kvack.org, "Ingo Molnar" <mingo@redhat.com>, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>, "Jens Axboe" <axboe@kernel.dk>, "Peter
 Zijlstra" <peterz@infradead.org>, "David Airlie" <airlied@redhat.com>, linux-sh@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-snps-arc@lists.infradead.org, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, sparclinux@vger.kernel.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, linux-parisc@vger.kernel.org, linux-um@lists.infradead.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-openrisc@vger.kernel.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org, "Jann
 Horn" <jannh@google.com>, "Jan Kara" <jack@suse.cz>, linux-hexagon@vger.kernel.org, kvm@vger.kernel.org, "Oleg
 Nesterov" <oleg@redhat.com>, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, io-uring@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-7-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-7-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:47:01 +0000
Message-Id: <20260915114701.C06AB1F000FF@smtp.kernel.org>
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

> Add TIF_FD_SLOTS and test it after the untraced system call has
> stored its return value. A task that reserved descriptors joins the
> traced path, where syscall_trace_exit() commits them before audit and
> the ptrace exit stop.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-work-fd-re=
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D7


