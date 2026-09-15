Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5D8C982C3
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 12:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JAT+dPINnJ0baLSnWeyqna2pT2L+zf+r0Hb38LXbJr4=; b=AKBgQDxJhc3hh6YNqZWzCzY8Xi
	zNqsvslutkfWFoxrXpWwmEFIu+JG+KkY/+6MV62I6umoCxgZemanHn6ImXg/v+SVsDCll6/3Wlita
	RjLJQiBGMkep4TN4e6oHpTFybiQr1bV424WXrojoUPlNontx/swbG2rljnwi7hJYaIa8Fke3EfJjK
	meS3n7PbYd7euiHKUSB0luJARD/TtzcMM3gj8bc4ZYCT25pfhBdxq79W2SYq52cPfLGci60OXvbN2
	GGugzd2euWoIwD6Y4J3C2jt5wHL+LilgwebKSBAbIT6AA5T3O3NhKbvoEESvgJWL3yCJaKceNUfVK
	iHEqXXeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6Ru7-00000006Neq-1YWy;
	Tue, 15 Sep 2026 12:04:51 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6Ru6-00000006NeV-0STa;
	Tue, 15 Sep 2026 12:04:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D371E42D5E;
	Tue, 15 Sep 2026 12:04:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92CF1F00893;
	Tue, 15 Sep 2026 12:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473889;
	bh=JAT+dPINnJ0baLSnWeyqna2pT2L+zf+r0Hb38LXbJr4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mh0aJRjvpgxlZiLKhSATPqRfUaES+f2XTT49Q88vDM46+M2joHhrL5IXTe47rLwKc
	 lQ8SWuZa+L36m8Iss1J2WPRz0FGDuI7oSB9RhNnd6Q/OBlecSo2ec3ESUds1YiK9AY
	 yE5zSTou8yCIYMwaO7fw3TkKtVt9q88AVkigmJ0j7/I1yD7epQKS1vU3wqqB1ahaXX
	 LNYP3gTZ6O2PbkoUguLy6zmGopGbgX6RXuAS1J3tZlp1M2JrhXEo7fKehrQrDDD3RI
	 cFHwW76z9ATTIL4qO2fc49BAVBC61Nonh5r1ZU9cD24BOO9dRalQfLo+8prJsERH0V
	 r769lDt95U/fA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC POC 27/50] drm/amdkfd: stop collecting CRIU dma-buf
 descriptors for a final install
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Christian Brauner" <brauner@kernel.org>
Cc: =?utf-8?b?Q2hyaXN0aWFuIEJyYXVuZXIgKEFtdXRhYmxlKQ==?= <brauner@kernel.org>, linux-parisc@vger.kernel.org, "Jann
 Horn" <jannh@google.com>, linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org, bpf@vger.kernel.org, linux-csky@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, linux-snps-arc@lists.infradead.org, io-uring@vger.kernel.org, linux-gpio@vger.kernel.org, sparclinux@vger.kernel.org, linux-mips@vger.kernel.org, "Eugenio
 Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Oleg
 Nesterov" <oleg@redhat.com>, linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, linux-um@lists.infradead.org, "Peter
 Zijlstra" <peterz@infradead.org>, "Jan Kara" <jack@suse.cz>, kexec@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-openrisc@vger.kernel.org, "David
 Airlie" <airlied@redhat.com>, "Ingo Molnar" <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, virtualization@lists.linux.dev, linux-hyperv@vger.kernel.org, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Jens Axboe" <axboe@kernel.dk>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-27-4d5217d6b246@kernel.org>
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <20260915-work-fd-reserve-unify-folded-v1-27-4d5217d6b246@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:04:47 +0000
Message-Id: <20260915120447.D92CF1F00893@smtp.kernel.org>
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
serve-unify-folded-v1-0-4d5217d6b246@kernel.org?part=3D27


