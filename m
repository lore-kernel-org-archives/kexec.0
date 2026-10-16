Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24BB0CCA462
	for <kexec@archiver.kernel.org>; Fri, 16 Oct 2026 12:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PUdWkNueulRXqTUltKYYi/VwALEztDRpAc6P38T0QDc=; b=ldW43EiI6UxegNk+7alGH0kruN
	k9DiyeY5mR8sflRq8Heaxnm94J2QQcr+sqdX3htvtzdwGSPYYWtLeSsk+1+jl/ryhU7GlfrVVjbUZ
	0zZVj45n0ojy2x9R/mCWQHysC69+hU/XS9OW7q9F0iSw/3ooVu02r5o5xy4yp7v0s804fKfFI7JRO
	tU1pqZ+5aMM7S8H09xcjxcqlfFGUN7Oo9tAfkucIhU+1qxh+IczY4Jzfi09Ulf80v5XSvd36dziry
	gbg85V/0Hfz7KRPhqX8bzV1uikdCxfKZ5emHI5S8qhByf64cBfPAgqY4fdcrfoqc/t7AMlaFDdg+p
	NQu2mA/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHh4l-00000002siZ-0zGr;
	Fri, 16 Oct 2026 12:30:19 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHh4k-00000002siO-1823
	for kexec@lists.infradead.org;
	Fri, 16 Oct 2026 12:30:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 06D1940111;
	Fri, 16 Oct 2026 12:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F3D1F000C4;
	Fri, 16 Oct 2026 12:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792153817;
	bh=PUdWkNueulRXqTUltKYYi/VwALEztDRpAc6P38T0QDc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cAAqQYwxIQBSPgetCNShvLRoIPdZgyyz3J33hJgsN7pNOu7Mo26ICddFhCWh4hESU
	 ErCrOnNnp7OjaXlZnHjcTB5szoT2jnpCX+0YTttANRmgfzjX1GftakoV/OlrOSSEbX
	 Nh7m+1jeBEE6YwWMwIJpsye2CuVx/bAbnbiynx9QGlydMALbNvYABqGloJgAQqnPwj
	 LVSYQF7PegQZmtaQBBuQoMR7m6GBlMXXUPjCA3+hv9KkhrPsZXL4lKeHmhx9iA7Knl
	 8qZlUSifv4kIEul9m01sfsFc8xShi3k+mxZzKAjwX/ktGQ/+/EtvOH6CKceYBwTDmA
	 oB8oPSemBI+Eg==
Message-ID: <sashiko-outbox-174296@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/7] drivers/base/memory: count the poison a block
 already holds when creating it
To: "Breno Leitao" <leitao@debian.org>, "Ard Biesheuvel" <ardb@kernel.org>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, "Thomas Gleixner" <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org, "H.
 Peter Anvin" <hpa@zytor.com>, "Andrew Morton" <akpm@linux-foundation.org>, "David
 Hildenbrand" <david@kernel.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Liam
 R. Howlett" <liam@infradead.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Mike
 Rapoport" <rppt@kernel.org>, "Suren Baghdasaryan" <surenb@google.com>, "Michal
 Hocko" <mhocko@suse.com>, "Miaohe Lin" <linmiaohe@huawei.com>, "Naoya
 Horiguchi" <nao.horiguchi@gmail.com>, "Oscar Salvador" <osalvador@suse.de>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Danilo
 Krummrich" <dakr@kernel.org>, "Catalin Marinas" <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, kas@kernel.org, kexec@lists.infradead.org, "Brendan
 Jackman" <brendan.jackman@linux.dev>, "Johannes Weiner" <hannes@cmpxchg.org>, "Zi
 Yan" <ziy@nvidia.com>, shakeel.butt@linux.dev
Cc: rmikey@meta.com, riel@surriel.com, harry@kernel.org, kernel-team@meta.com
In-Reply-To: <20261016-hwpoison-kho-v6-5-f304255147da@debian.org>
References: <20261016-hwpoison-kho-v6-0-f304255147da@debian.org>
 <20261016-hwpoison-kho-v6-5-f304255147da@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 12:30:15 +0000
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

> A frame flagged poisoned before memory_dev_init() runs cannot be counted
> on its memory block. memblk_nr_poison_inc() divides by sections_per_block,
> which memory_dev_init() sets, and the block does not exist yet. The block
> is then created reading zero, however many of its frames are poisoned.
>=20
> Until now nothing could poison a frame that early. It becomes possible
> once a kernel flags the frames it inherits from the one that kexeced into
> it, as it initializes its memmap.
>=20
> memory_block_online() refuses a block that holds a poisoned frame, and a
> counter stuck at zero lets one through.
>=20
> Count what a block holds when it is created at boot. The walk sits behind
> num_poisoned_pages, so a machine with no poison does not pay for it.
>=20
> Signed-off-by: Breno Leitao <leitao@debian.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-hwpoison-k=
ho-v6-0-f304255147da@debian.org?part=3D5


