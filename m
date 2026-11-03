Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461A4606A80C
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 10:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0C04mpbZ;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=T8GHUIeu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=yOEv4rlICtm+9MGZIVJit4iJjbb/HbqDxTBh2E0PNYM=; b=0C04mpbZVh6F5wCXpKqn5C4RJX
	0FVJJzSDg9+1WvTVaggXX4cPNgqhdvxRNhLKEQ8S2fcteWszld+qvFzOFI2pV2xUhSr8UDI6CV8Rp
	X+dH6LT6fedUGW1Vo0aaZ6IYjLjaXBrT3c/rJU6anoYbiRLt5JoFIPMrL2pu4YBS3OCTRabUNXVJ0
	V+ZsSKN9RoRWMkTQ0v6VGVwfR2wU//fxNMfeIeNLQZYfy7/xfm/Vus/0hf4bSogc5rJKCohxrvysO
	WzPtumPuKvZGGCFkXH+BpKN7OPoWnqnZ/jHk53kOL2XVU5gPumD+ZQG0JlZN5rXZ5K+ieEHAtduIJ
	mdNBJxJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOBQ0-00000001slB-2JfH;
	Tue, 03 Nov 2026 10:07:04 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOBPu-00000001sjM-0fmD;
	Tue, 03 Nov 2026 10:07:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yOEv4rlICtm+9MGZIVJit4iJjbb/HbqDxTBh2E0PNYM=; b=T8GHUIeuwcDQEX7YFBA0dHaPtB
	2kVj9KSOFPEikB0F9pAaccEJIVjNxbKR3+e0f9oaOThinmGoXpI0EvZVDNwsXfU7AGr9ATQG+ak4X
	z2dA0u862tnlHdxULQMW9u6wC8/34oIlt51HyBjY2ZPhPEqEQ7F2QlBBCab/c1vclkwgOD+hM7I5Y
	Apd1Al26l3U1O8FO7cvKq+udwXcUON4wKT7E1OLcFB1DgsHO9juQDwNhoajOQfbR9TQ7vZZE+8K4T
	LmEzS5pvIZvxQ3GwRaJaAmhojV9r2fEIapcI/uXjfq4sDAf9cLR2RFL0jyHQmO9HjiEpQaLi6OAZZ
	0upLu0Xg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xOBPO-006r0Z-0j;
	Tue, 03 Nov 2026 10:06:26 +0000
Date: Tue, 3 Nov 2026 02:06:17 -0800
From: Breno Leitao <leitao@debian.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, kas@kernel.org, 
	kexec@lists.infradead.org, Brendan Jackman <brendan.jackman@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, shakeel.butt@linux.dev, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-cxl@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, rmikey@meta.com, riel@surriel.com, harry@kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v6 3/7] mm/memory-failure: add hwpoison_boot_page() to
 flag an inherited frame
Message-ID: <aumvVjoHo4KeuyEp@gmail.com>
References: <20261016-hwpoison-kho-v6-0-f304255147da@debian.org>
 <20261016-hwpoison-kho-v6-3-f304255147da@debian.org>
 <aumt-4kfGGtoXuh-@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aumt-4kfGGtoXuh-@kernel.org>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_020658_198901_7CAF39CE 
X-CRM114-Status: GOOD (  10.65  )
X-Spam-Score: -4.4 (----)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 11:48:43AM +0200, Mike Rapoport wrote:
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> 
> We've been splitting internal.h to smaller headers, maybe it's time to add
> "memory-faulure.h"?

Ack. I'm happy to move the "mm/memory-failure.c" section out of
mm/internal.h into a new mm/memory-failure.h, as preparation for this
patch.

Since this patchset is moving slowly, I'll start the header split in
parallel as a separate series, and rebase this patchset on top of it
when I respin. Is it this ok?

Thanks,
--breno

