Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B818A606A336
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 19:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TLWFrd7C;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=Lceh6Plx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=GUcFaW0QlGFes0C2J7AwtNc1g9u3PZm7aB62qqNYgAQ=; b=TLWFrd7C3lBz7xq1E2WgJdSJXG
	m4ntUd1tLIWWasu9d8mGwgt2/qFrBu+zwAl/EvKJYruYr0XDMtL8U+u4fCOm/hDnWqYjLHPNcC8Bl
	MQAfdOym6Q52Wr3bZXIr5RAcNe79ZUlIKxcdMcokFgb96aen/yzGdzx1vhewyda6NEdTAY3mIMxxg
	d8gg9hNDwPvfwqfTbxjzVoeg6rQb14igNKmafI1YlXxEyj4AfYbp6+KeZ9/xDqJXUirOg8AOnF/mz
	OLAiPlWBKVxTr5EGHu23T5Pcs0RUirlXCoVq6nEO0pl6PPiT1ap37HMRu7xlC8ZNmZnhJTV64eBr8
	jL3DPIZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOKWa-00000003ZRQ-1GlJ;
	Tue, 03 Nov 2026 19:50:28 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOKWX-00000003ZOI-0IkM;
	Tue, 03 Nov 2026 19:50:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GUcFaW0QlGFes0C2J7AwtNc1g9u3PZm7aB62qqNYgAQ=; b=Lceh6PlxsEJklOoM0MsQOhPEBu
	iWoM4NWNkSqK6+mJblh//PkPt9UHzWD8Dp0s9P/i/Mxx3AKaKefvHrfEFvXqTTv7D4heLJ1TV7+DF
	rWCW1KyaAsKhQaP4hn+ntUYPwKgO4CbcjHYw9VGzGK7X+4Nn8UYTh0sOwOhTj7GM7I134azSS/8sp
	CZs97Jqi3SmdnVecHq2zKqiWP9Tup1YJfMylxOBzHY0NpRdzMQKtpiErN2xNVontWr3co6udl6PSm
	CV5IxUZZUtmLZCx653c4XuwlTNnEwVbL8kvVAwsgW63CgFx1aSREEeBM+lMVDv+IWIwQ+g00uaGn6
	zxg0XPmw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xOKW2-007Aup-1U;
	Tue, 03 Nov 2026 19:49:54 +0000
Date: Tue, 3 Nov 2026 11:49:44 -0800
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
Message-ID: <auo3ScXy6dk0Gr3-@gmail.com>
References: <20261016-hwpoison-kho-v6-0-f304255147da@debian.org>
 <20261016-hwpoison-kho-v6-3-f304255147da@debian.org>
 <aumt-4kfGGtoXuh-@kernel.org>
 <aumvVjoHo4KeuyEp@gmail.com>
 <auovL7i1rEcXCeGS@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auovL7i1rEcXCeGS@kernel.org>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_115025_107215_82EF366B 
X-CRM114-Status: GOOD (  17.80  )
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

On Tue, Nov 03, 2026 at 08:59:59PM +0200, Mike Rapoport wrote:
> On Tue, Nov 03, 2026 at 02:06:17AM -0800, Breno Leitao wrote:
> > On Tue, Nov 03, 2026 at 11:48:43AM +0200, Mike Rapoport wrote:
> > > > --- a/mm/internal.h
> > > > +++ b/mm/internal.h
> > > 
> > > We've been splitting internal.h to smaller headers, maybe it's time to add
> > > "memory-faulure.h"?
> > 
> > Ack. I'm happy to move the "mm/memory-failure.c" section out of
> > mm/internal.h into a new mm/memory-failure.h, as preparation for this
> > patch.
> > 
> > Since this patchset is moving slowly, I'll start the header split in
> > parallel as a separate series, and rebase this patchset on top of it
> > when I respin. Is it this ok?
> 
> Sounds good to me.
> 
> Just be aware that MM folks are knee deep into fixes this cycle, so both
> sets could be moving slowly :)

Appreciate the heads up. In that case, should I hold off on the header
split until the next cycle instead of starting it now?

Thanks,
--breno

