Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D8AC88E75
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 12:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9Lg/vD+u14ITJU8+go78ZuhkRlXcBzG+UGmK5JLRPZA=; b=uMF38WIsksIZjL+VeYvHVFe/dG
	G2ui/w5CD8iTD6x/uBkQNOtNQMxlpUKwGUssCurbujIUND7CX9dwqVUuAAPDaumhah5c/rSjRebt1
	NSbCKe1kot+n/T0cQaWrhidryh5ABDeqEDZssbuOT4SKnQRAqwrKTOhJ1AFiPSUxGMU50Z6JnaFsx
	tTrNN05E5jWtOBPq5+l9gvDBhPZAejKJAgFdiNV7whsGlEifG1C+rNL2/mJFBQfqtpSHP5a1Cqv/h
	3kUf53roZbq0hXlprpnTFkBCFYOBD5H9lekIDPrxJt6NKXD8UP1h8qSwG/cAdH7gBdEKL6DWqG0fq
	H0SLYmdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RwW-00000006OVF-0Tqi;
	Tue, 15 Sep 2026 12:07:20 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6RwV-00000006OUw-0uS1;
	Tue, 15 Sep 2026 12:07:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A10AC600D1;
	Tue, 15 Sep 2026 12:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F5F1F000FF;
	Tue, 15 Sep 2026 12:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474038;
	bh=9Lg/vD+u14ITJU8+go78ZuhkRlXcBzG+UGmK5JLRPZA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TTE6T1XfEzcNIJ8WFiySWnwQP8yJBWzCe+zXTpLvevuGzn9lG1wMo6JkmfwwL/Yd+
	 v0620B9v7rVjPwqdf+dJBvrXj/aAzuqd39yYhvfUVwF6Y68DbvQH8k6e9kkxs5lDOO
	 T8fcWkBPfS2hGnM0lvlb7z4+ZX10iJvVylZm/YCij8A1eYUDStsAMbhEWNr7ZTNW0K
	 d0wxrxeE8FTve/JAmJz66C/VfP51gl+cT2S3btyqcJ0w7YNf/OBOpnS9KLaOzdPK1Q
	 PzvyZfSsvRdUn8CutJLqPgs8jEgY3WTHPuRHCKpcfiaY7lO9YqAql9ka1D9FfKpgP7
	 bePqW74CAgyKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 31/50] vfio: install the migration data
 descriptor when the ioctl returns
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: kexec@lists.infradead.org, linux-csky@vger.kernel.org, "Jens Axboe" <axboe@kernel.dk>, dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, linux-mm@kvack.org, linux-um@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org, "Peter
 Zijlstra" <peterz@infradead.org>, =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFt?=
 =?utf-8?b?dXRhYmxlKQ==?= <brauner@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, linux-sh@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, linux-openrisc@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-hexagon@vger.kernel.org, "Oleg Nesterov" <oleg@redhat.com>, linux-snps-arc@lists.infradead.org, "David
 Airlie" <airlied@redhat.com>, linux-arm-msm@vger.kernel.org, linux-hyperv@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org, virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, io-uring@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, "Jann Horn" <jannh@google.com>, kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, sparclinux@vger.kernel.org, linux-alpha@vger.kernel.org
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-31-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-31-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:07:16 +0000
Message-Id: <20260915120717.15F5F1F000FF@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D31


