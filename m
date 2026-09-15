Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F07C88E7F
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 12:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7Ki6bSBJwaxJJeHi7SKUuFLkbZmfL/7uuTnWaWs93uA=; b=FXEM9X2zbydeKvokh44W3p1eUj
	5PKzlWqyR6L8dIxeKqbu662Q7PCg3Uwa5jvBEsyOY2YYGxBNnwg1e9fmY8+WPhWDfLr61tY2c03ap
	JClrK73XYtKBBAOacWzRPiF5Y/fFFZCrxYx04VzrnVZBZHuyZF++2szKk225gggBRd/mzC7ArdV0I
	Xv6jc9sN7F4GeGmEE8/sF9pAcliNXkRr4J2sqGZh/N1EmKt80G+JsFQj4oWvKtkDsSJpFspVgl81h
	lOAX6pld41DZMsY7vZdw18pKfN0aLxAtit7HHGwGnGzdLzovow4k1KKymKYZt1mmBKzChVkeI3zy6
	nd0KZYxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6S4H-00000006RV1-2eLQ;
	Tue, 15 Sep 2026 12:15:21 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6S4D-00000006RTZ-3Um6;
	Tue, 15 Sep 2026 12:15:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4720D60261;
	Tue, 15 Sep 2026 12:15:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295751F000FF;
	Tue, 15 Sep 2026 12:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474517;
	bh=7Ki6bSBJwaxJJeHi7SKUuFLkbZmfL/7uuTnWaWs93uA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kI77b5Cs1CCH5C2TVxPIT8fy3wL5A+5GVvFbNqnc8ywtIl1xsP+kz2+YtB6oqe4rq
	 l5MIumARVSkDXAKZVkJf4FmmuUstog7U7WkwkoO47/GequtFboDqXFKBhm8gRVl+8O
	 R05h3rhCE8VlU3e70rQ0v5HNwr7mByz6nbAUN2qjsZ4EdPZrSzKMrkSw0ptkltPWdD
	 1K9aNz+rSv8p4Ksfg6V+iO9PxpNKvssHsTIw8bHe/sGHatYYCzuFLzRvKplACIwjle
	 MkbJfnFHm3eFE1Z3cOPmlWvybtFLHN5O2L13O1dy8fXdonFCUhJlZiezPlMPDhpdxP
	 QdqQbUTSLLEqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 44/50] drm/etnaviv: install the out-fence
 descriptor when the ioctl returns
To: "Christian Brauner" <brauner@kernel.org>, "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: virtualization@lists.linux.dev, linux-parisc@vger.kernel.org, io-uring@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Jann Horn" <jannh@google.com>, "Oleg
 Nesterov" <oleg@redhat.com>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-msm@vger.kernel.org, linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, linux-mm@kvack.org, linux-snps-arc@lists.infradead.org, "Eugenio
 Perez" <eperezma@redhat.com>, linux-m68k@lists.linux-m68k.org, linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org, kvm@vger.kernel.org, linux-mips@vger.kernel.org, "Jan
 Kara" <jack@suse.cz>, linux-sh@vger.kernel.org, linux-um@lists.infradead.org, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, "Ingo Molnar" <mingo@redhat.com>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, kexec@lists.infradead.org, "Peter Zijlstra" <peterz@infradead.org>, linux-csky@vger.kernel.org, linux-openrisc@vger.kernel.org, "Jens
 Axboe" <axboe@kernel.dk>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-44-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-44-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:15:14 +0000
Message-Id: <20260915121515.295751F000FF@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D44


