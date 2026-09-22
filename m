Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6BEC982FA
	for <kexec@archiver.kernel.org>; Tue, 22 Sep 2026 09:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FH7I6UR6jBDl/t2avlBDN/FfwVeJE6mNz3ibf6d5W4E=; b=Lj/AbdlQzSZsXIpnTnuD51SJZK
	1BSH6ObGyMQH6KF6eg1fWXIrYjzH3altU0bvOs9HiJG5RReqcFmht4OUCmWKdB/S8uQiBSKAvW2Ph
	0LUOmzG3v3ou3+bV6bbuXHJjwakZyiSZ6F/PhrC+oJzWgd4ednsbt9E+0yvfJCGU6JckcRPVJz/i2
	ETz0lIcHgSkcvSo3GpiDsZzmP45DE6qkLashmf4uxZDgzFzWqcdGgETNvH+RxpB1gRZzQan6VAPFP
	qae0fvIOziSHh+LqNU/Td6qQFURhZYmhuogRZcv30Tlt9JuWeF1zfZ/fbMClxXsOvwdA6QDjx9wGG
	SCIu+ksg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8wam-00000004rvK-1R0D;
	Tue, 22 Sep 2026 09:15:12 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8wak-00000004rtk-14wA
	for kexec@lists.infradead.org;
	Tue, 22 Sep 2026 09:15:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FH7I6UR6jBDl/t2avlBDN/FfwVeJE6mNz3ibf6d5W4E=; b=eUPTj9eAaXcbs4q80PbAeG7F41
	9081MjBXTkIMWK+8zT65gf+PM19anFfCRJOI6aZDApSOMevfYWb7efc71TgWLRLz8Exj/Nz6e3oNX
	mp/w6EYIlF0u9JFuQE14R4PxwI4XFehfbZAkhGeX6EqqO11Jmi9aD8og1r8c2WBbO+aoH++ZsQDTq
	5MI3ibU0iCpKRWkSKqMVcUfHWhXxDKZrlmTSKxjS4cR2YGJ5D5lcnutLJShjnAq+FsJHp6txXpr3P
	VyHyIM4Le5aXVewo0dNiv1C6zkiqmZda9lDVm/dor3vG7NOQtXJd4UBmw/Yn3VZTs1fK3FRW1640T
	s6m1xKKg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x8wa5-002sKz-0P;
	Tue, 22 Sep 2026 09:14:29 +0000
Date: Tue, 22 Sep 2026 02:14:20 -0700
From: Breno Leitao <leitao@debian.org>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, rmikey@meta.com, riel@surriel.com, harry@kernel.org, 
	linux-cxl@vger.kernel.org, driver-core@lists.linux.dev, kernel-team@meta.com, 
	Ard Biesheuvel <ardb@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, kas@kernel.org, 
	kexec@lists.infradead.org, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Oscar Salvador <osalvador@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, hannes@cmpxchg.or, 
	shakeel.butt@linux.dev
Subject: Re: [PATCH v5 0/9] mm/memory-failure: keep hardware-poisoned pages
 out of the next kexec
Message-ID: <arJBkNOgbR8NrgFP@gmail.com>
References: <20260915-hwpoison-kho-v5-0-3bc7a57bd503@debian.org>
 <d6e35901-f74d-bf81-75d3-bac4b26d9d72@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6e35901-f74d-bf81-75d3-bac4b26d9d72@huawei.com>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_021510_300602_8946F774 
X-CRM114-Status: GOOD (  16.76  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hello Miaohe,

On Tue, Sep 22, 2026 at 02:27:59PM +0800, Miaohe Lin wrote:
> > A bit is never cleared, which is a known limitation: it stands for a
> > whole unit, so an unpoison of one frame cannot tell whether the unit as a
> > whole is good again.
> 
> Thanks for your patches. I have a question about unpoison: If a bit is never
> cleared, after we do some memory-failure+unpoison tests, kexec will lose the
> tested memory without reboot?

Correct, A bit stands for a 2M unit, so every tested page that falls in
a distinct unit costs 2M in each kernel after the kexec.

Worth being precise about the state today: the unpoison itself works.
The frame goes back to the allocator and num_poisoned_pages drops. Only
the bit stays, so the next kernel poisons the frame again. Test loop
in, memory out, and nothing gives it back.

Important to say that nothing block us from unpoison the bitmap, and in
fact my initial patchset had it. I also _think_ we should unpoison the
bitmap once we unpoison the page. 

I have just kept it out of this patch in order to simplify the patchset and
get the basis correct, and then evolve on top of it.

That said, If you think this is a must have in first patchset, I am more
than happy to do it now, but just keep it in mind that it will grow the
patchset by about 2 extra functions.

Thanks the review,
--breno

