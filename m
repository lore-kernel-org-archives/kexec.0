Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94121C88E75
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 13:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OiVbNpqvcTpST0O0QqLXW+ZXyZ4rqHD9AsZUlFhTaN8=; b=i70TxYhAU/Pob0PQV7FY9eCA6s
	m4ZEipe8cUuM+8W5WdC94fPfMK5oMiGT02CsWFLwe4lbHaa7Jp5XkVXW7y8okgIOLu/CWjPyJyKpQ
	8nxsxjlonRP4C5ZsMpbLz9Pzb7LhDgu6/0Jo8tle8WVT8IKvg/0kkN/oqIkFkQH64OsGlLEv/4lkI
	7BQbJdDC4MZyHF5wKxBTwq6w2SO3KFljumYam8Voy07XGoTBxxE5lIEc61I5nS4fbV0RqciGwySJi
	FhWxVTbJ7o3vxfpOHd1hNfwwPKZffzE09poLLKfW8+pDqCmCXxdibrkQ0ctOrzoVSt53DwDr0mXdY
	kmA3eRlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6TTi-00000006mq9-1QoY;
	Tue, 15 Sep 2026 13:45:42 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6TTe-00000006mog-2Hsw
	for kexec@lists.infradead.org;
	Tue, 15 Sep 2026 13:45:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E593340255;
	Tue, 15 Sep 2026 13:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3FC91F00899;
	Tue, 15 Sep 2026 13:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789479937;
	bh=OiVbNpqvcTpST0O0QqLXW+ZXyZ4rqHD9AsZUlFhTaN8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hi5BOtIEVU4s+3yGSkPz0/SAa3xuZHvLVpvUfNAH5splg6V68ueCIPFYP3/mpMulN
	 u8P69p91iUJ0DvXufSdZIKn2jcj8/nL90UaX8qWkXmwhffYxBPcX8v6xabJdCHM9uS
	 z0APFIvOBx9ALorAcSTdPK39S6JJt/J+ryBC6YOeWFlhtPrN383awNLaA4SMyFizpA
	 wG92L0Er3GzqiyFFLxmr4DbvFLuVKocAtwi+g/N7XmJ66fdv9ER3gV7xBJROmIeGXh
	 yELnMJVm02pPNLmgfAN6ykp/nJhDspGneThMYtTcbY6FFghJT0/8X1s3mAGVJErlu4
	 R0Rnq9hJzvg2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/9] mm/memory-failure: efi: answer whether a range
 is poisoned
To: "Andrew Morton" <akpm@linux-foundation.org>, hannes@cmpxchg.or, "Borislav
 Petkov" <bp@alien8.de>, "Danilo Krummrich" <dakr@kernel.org>, "Brendan
 Jackman" <brendan.jackman@linux.dev>, x86@kernel.org, kas@kernel.org, "Suren
 Baghdasaryan" <surenb@google.com>, "Zi Yan" <ziy@nvidia.com>, "Liam R.
 Howlett" <liam@infradead.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Thomas
 Gleixner" <tglx@kernel.org>, "Oscar Salvador" <osalvador@suse.de>, "Rafael
 J. Wysocki" <rafael@kernel.org>, shakeel.butt@linux.dev, "Johannes Weiner" <hannes@cmpxchg.org>, "David
 Hildenbrand" <david@kernel.org>, "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, "Miaohe
 Lin" <linmiaohe@huawei.com>, "Ard Biesheuvel" <ardb@kernel.org>, "Breno
 Leitao" <leitao@debian.org>, "Michal Hocko" <mhocko@suse.com>, "Naoya
 Horiguchi" <nao.horiguchi@gmail.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Mike
 Rapoport" <rppt@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Dave Hansen" <dave.hansen@linux.intel.com>, "Ingo
 Molnar" <mingo@redhat.com>
Cc: linux-mm@kvack.org, kexec@lists.infradead.org, linux-cxl@vger.kernel.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, harry@kernel.org, rmikey@meta.com, kernel-team@meta.com, driver-core@lists.linux.dev, riel@surriel.com
In-Reply-To: <20260915-hwpoison-kho-v5-6-3bc7a57bd503@debian.org>
References: <20260915-hwpoison-kho-v5-0-3bc7a57bd503@debian.org>
 <20260915-hwpoison-kho-v5-6-3bc7a57bd503@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 13:45:35 +0000
Message-Id: <20260915134535.C3FC91F00899@smtp.kernel.org>
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

> The bitmap an earlier kernel filled in gets in this one through EFI,
> but nothing reads it back yet.
>=20
> Introduce range_contains_poisoned_memory(), which the page allocator
> will use to ask about a block before handing it out.
>=20
> Signed-off-by: Breno Leitao <leitao@debian.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-hwpoison-k=
ho-v5-0-3bc7a57bd503@debian.org?part=3D6


