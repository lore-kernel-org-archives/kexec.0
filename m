Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5318F606A328
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 10:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fFRsKb08;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EeMZhO8D
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=OHhrH3mVCZL9F+uul7Pko5LwqezUEkg/0ds9TVqWkW0=; b=fFRsKb08BK9n+ukhahf3MgGC5q
	YxpOOetjXGVjGV8NweBdFjjZRr9Sc21StNoeU/wsdz2krItFlwVPsn5CDZrrK0GBhK2F3COrsxg8T
	J99dS6CnEDWAFg1Ff2oi6Y2setKHjQCaidfVmXD941ypTj7doXpi21CvqjaEWyzuUDodgJO3Da85G
	aW0Z8eZue8vkB0vXu4LGxyAhe0cOVg/tDEEE0mjYfkC2ioyT9GgucI5ggDwXRwL0Fo5N9ayR5CgLn
	Zu/lE8Bdf7PqZ9uN9rfDLYIcXGnM777Ygc1gfXxWEHI1ramyGIQdvBU8yeHkrt0ru6yaHFCjHEG/P
	Zsisxj2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOYPy-000000051P0-09i4;
	Wed, 04 Nov 2026 10:40:34 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOYPx-000000051Ob-0zmO;
	Wed, 04 Nov 2026 10:40:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A33E941926;
	Wed,  4 Nov 2026 10:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962121F000C1;
	Wed,  4 Nov 2026 10:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793788832;
	bh=OHhrH3mVCZL9F+uul7Pko5LwqezUEkg/0ds9TVqWkW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EeMZhO8DjG4Z1LNGDG6wdfrR5/jvvahFgvuj3m7HOQrS5HMxi/U+6lT8CdBS1mQBG
	 IC79mPKN5pooYxKGcfp/3nadOdWf8Fym3XSVAO968hO1SW6hTg6elGvzxmkBPwmNaS
	 v9T63ChJrQAQbad0an5kGXooCbmvv9MDXmPvDoorGg+XyLiYGBnkViAIHcypGwqbpJ
	 ppQezfycclcHYH/cH5pj6vY3QPZi1ua1tE+LaTlont55dEIEeB+v8CFlcxuVMlA3hL
	 myTh9yVFL8UBjo6Snz+ghL8sE2j0/RkU7G36RxL7WrUdRykGnhNHAiwYwIXZ3Ksf2n
	 rYu3AjolMYkzw==
Date: Wed, 4 Nov 2026 12:40:16 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	kas@kernel.org, kexec@lists.infradead.org,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	shakeel.butt@linux.dev, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, driver-core@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, rmikey@meta.com,
	riel@surriel.com, harry@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v6 3/7] mm/memory-failure: add hwpoison_boot_page() to
 flag an inherited frame
Message-ID: <ausLkNhb8ZPz0ra_@kernel.org>
References: <20261016-hwpoison-kho-v6-0-f304255147da@debian.org>
 <20261016-hwpoison-kho-v6-3-f304255147da@debian.org>
 <aumt-4kfGGtoXuh-@kernel.org>
 <aumvVjoHo4KeuyEp@gmail.com>
 <auovL7i1rEcXCeGS@kernel.org>
 <auo3ScXy6dk0Gr3-@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auo3ScXy6dk0Gr3-@gmail.com>
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

On Tue, Nov 03, 2026 at 11:49:44AM -0800, Breno Leitao wrote:
> On Tue, Nov 03, 2026 at 08:59:59PM +0200, Mike Rapoport wrote:
> > On Tue, Nov 03, 2026 at 02:06:17AM -0800, Breno Leitao wrote:
> > > On Tue, Nov 03, 2026 at 11:48:43AM +0200, Mike Rapoport wrote:
> > > > > --- a/mm/internal.h
> > > > > +++ b/mm/internal.h
> > > > 
> > > > We've been splitting internal.h to smaller headers, maybe it's time to add
> > > > "memory-faulure.h"?
> > > 
> > > Ack. I'm happy to move the "mm/memory-failure.c" section out of
> > > mm/internal.h into a new mm/memory-failure.h, as preparation for this
> > > patch.
> > > 
> > > Since this patchset is moving slowly, I'll start the header split in
> > > parallel as a separate series, and rebase this patchset on top of it
> > > when I respin. Is it this ok?
> > 
> > Sounds good to me.
> > 
> > Just be aware that MM folks are knee deep into fixes this cycle, so both
> > sets could be moving slowly :)
> 
> Appreciate the heads up. In that case, should I hold off on the header
> split until the next cycle instead of starting it now?

I believe one header split patch is small enough and not controversial to
have it this cycle.
 
> Thanks,
> --breno

-- 
Sincerely yours,
Mike.

