Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452D2C88E53
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 12:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GiH3GbpixJxWQZTib2/+LhbytIGDPVlvBxFpYNkmPeA=; b=XZe7f73RuyO5lgXWlirKJfpmR2
	qCaJwbOrgaIIBy3I4dYETC7E8wdPCM38tCrIF+NSq/W9TxrE6k3ilJ3DMoAjEknr/0tR2rnEXpLsV
	LDUTE5UXsgc+dPbORgSeWHeLL/jTUYCATHNDKh85nXnrkyfEB4QX88TqO6/FEUVSKOieRugM7A8Ux
	eGu7ETlxMtaMALMV3GkTaQjJaIEwO/U1yNnivji+pHa/ErHL16i3rhkz8l4+qiHLu9wYiTt3RVQjB
	P69QXyKfM1RdI/qMlB5+xrZzoI7+i8Tch16klr8fm5IFEm1uRWszta5rzolMuoGmHArHy08+FLKmC
	Yb/XLICg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6SjX-00000006dB3-0R98;
	Tue, 15 Sep 2026 12:57:59 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6SjS-00000006dAk-2O4K
	for kexec@lists.infradead.org;
	Tue, 15 Sep 2026 12:57:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1EA4541AB1;
	Tue, 15 Sep 2026 12:57:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277B01F000FF;
	Tue, 15 Sep 2026 12:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789477074;
	bh=GiH3GbpixJxWQZTib2/+LhbytIGDPVlvBxFpYNkmPeA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DPMTw43P1rwYTS8P0EXbdxH9rXiDRFb59gyNqvlhle+JxNlmfssYbTgWzntdEf8+7
	 0HO7EWNVGdWxkTBDOHq1HRl8fY4n2eYstKC0w1Nh4TQI3oaBKFXDRd4wJPWDsOsn5Q
	 huukrddzTV6Q7VCVcibqr4n03efIgjVNpxoXY0xT3J+xttCaK1YUDQAMuDshsMMERT
	 nlpwvUx0EBXwTs7xXGytKNk1Bvjj+WZm0uZZZSeJx5bDBk38PzthI+jSrEw1k9g2eQ
	 BrKvM56sdUGbqDgKQs6p9TfLTemtacuOAhA5E+UXITXM3zcHyGF7hIrQAgKLHH7gDz
	 qF4Bl1KsOqzmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/9] mm/page_alloc: factor out the accept-and-free
 tail of __free_pages_core()
To: hannes@cmpxchg.or, "Naoya Horiguchi" <nao.horiguchi@gmail.com>, "Breno
 Leitao" <leitao@debian.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Miaohe Lin" <linmiaohe@huawei.com>, "Suren
 Baghdasaryan" <surenb@google.com>, "Oscar Salvador" <osalvador@suse.de>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Brendan Jackman" <brendan.jackman@linux.dev>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, shakeel.butt@linux.dev, "Johannes
 Weiner" <hannes@cmpxchg.org>, kas@kernel.org, "Danilo Krummrich" <dakr@kernel.org>, "Michal
 Hocko" <mhocko@suse.com>, "Ard Biesheuvel" <ardb@kernel.org>, "Borislav
 Petkov" <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, "Vlastimil
 Babka" <vbabka@kernel.org>, "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, "Zi
 Yan" <ziy@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Mike Rapoport" <rppt@kernel.org>, "Liam
 R. Howlett" <liam@infradead.org>, "David Hildenbrand" <david@kernel.org>, "Thomas
 Gleixner" <tglx@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, linux-cxl@vger.kernel.org, rmikey@meta.com, linux-efi@vger.kernel.org, riel@surriel.com, kexec@lists.infradead.org, harry@kernel.org, driver-core@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20260915-hwpoison-kho-v5-1-3bc7a57bd503@debian.org>
References: <20260915-hwpoison-kho-v5-0-3bc7a57bd503@debian.org>
 <20260915-hwpoison-kho-v5-1-3bc7a57bd503@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 12:57:51 +0000
Message-Id: <20260915125752.277B01F000FF@smtp.kernel.org>
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

> __free_pages_core() ends by accepting the block if it is still
> unaccepted and then handing it to the allocator. The poisoned-memory
> replay later in this series needs that same tail for the parts of a
> block it does not withhold.
>=20
> Move it into accept_and_free_block(). This will be used later, when
> we need to accept and free a subset of a order-block that is
> not-poisioned.
>=20
> Signed-off-by: Breno Leitao <leitao@debian.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-hwpoison-k=
ho-v5-0-3bc7a57bd503@debian.org?part=3D1


