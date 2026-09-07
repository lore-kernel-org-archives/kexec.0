Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD49C79F99
	for <kexec@archiver.kernel.org>; Mon,  7 Sep 2026 14:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rztXTxArE4kzHUFZdIzTTHMPPaOeWfni0CGbnXtVrRk=; b=IhqnQWM1G61bPTvpIuIZ9Sws75
	Mvl4TR7Uz6iqb6ghkYnRUILAlnB5ndpTDbhvb4GeonGkb+jjClD/K9AbOwXf+fLoyZgbUGY7l2Yio
	VoWml1cT8y0XojhQLXA3Hv80c7h/ZWvFI93c5CPnY/QT0ybOHHoCkaYAjJ2cjMHGg6B3H2a4I8Ai5
	fCtDuaj3bCeN4XCkxWR/3Qw/J8TSptWBNHr1wvzbzlHRqJYCK04zHdQqFV1cUdSs/exAFVfU1oOFb
	4kZYjv2BKvU/DsTunrePtAvVBWSx8LU2Bx1pEURZ9h/iXm9hwxg2hnVjOQXwpbMOcVu26bxg2nh7X
	YOXdqD+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3aKF-000000072km-1bdL;
	Mon, 07 Sep 2026 14:27:59 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3aKC-000000072k8-3fmi
	for kexec@lists.infradead.org;
	Mon, 07 Sep 2026 14:27:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rztXTxArE4kzHUFZdIzTTHMPPaOeWfni0CGbnXtVrRk=; b=Umw5ALif/GaeXHkSspbhFvoHpV
	ijLLQm+T/BV/rHhk0gvAwCxMVRwRTOMtx26aNAEHtJIKbdhQM3WxgK4MokEQAWyeeKWPCAJTVlXML
	bmc2f/MAzn+EgE22BwT5eY0Is8BLiPfaf1n6kzhQdx27HssCtRhiyNcPcRoU9gHy+ibvVg0M0nioW
	3IuJob4fpt0JUH/gtsGGD6qsBZRPB705AgrGraAsrtjCn18wDiA9nrnJsMkZcITC2MHW5AijAEs0G
	Ijk7UlL2EHiQ2VcO5N1WnjmfJ2soy0YOdupGKE5BNrIOLkbQ2wmdqdrBHZfhCMFHJJjpUuKqfX4Ts
	ceKTlfCw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x3aJu-001ZS2-1N;
	Mon, 07 Sep 2026 14:27:38 +0000
Date: Mon, 7 Sep 2026 07:27:31 -0700
From: Breno Leitao <leitao@debian.org>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	kexec@lists.infradead.org, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, rmikey@meta.com, riel@surriel.com, 
	kernel-team@meta.com
Subject: Re: [PATCH v3 1/5] mm/memory-failure: efi: add the
 LINUX_EFI_POISONED_MEMORY configuration table
Message-ID: <ap7HHvF7tXmz4Nsz@gmail.com>
References: <20260826-hwpoison-kho-v3-0-6f79c4b605bc@debian.org>
 <20260826-hwpoison-kho-v3-1-6f79c4b605bc@debian.org>
 <apGOr0BAFc1DMQe6@thinkstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apGOr0BAFc1DMQe6@thinkstation>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260907_072757_283982_078986E3 
X-CRM114-Status: GOOD (  15.09  )
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

On Fri, Aug 28, 2026 at 02:47:39PM +0100, Kiryl Shutsemau wrote:
> On Wed, Aug 26, 2026 at 05:03:52AM -0700, Breno Leitao wrote:
> > @@ -1271,6 +1274,16 @@ struct linux_efi_memreserve {
> >  #define EFI_MEMRESERVE_COUNT(size) (((size) - sizeof(struct linux_efi_memreserve)) \
> >  	/ sizeof_field(struct linux_efi_memreserve, entry[0]))
> >  
> > +/* Bit N covers unit N of physical address space, counting from address 0. */
> > +struct linux_efi_poisoned_memory {
> > +	u32		version;
> > +	u32		unit_size;	/* bytes of phys space per bitmap bit */
> > +	u64		size;		/* bitmap size in bytes */
> > +	unsigned long	bitmap[];
> > +};
> 
> struct efi_unaccepted_memory has 'phys_base'. Do we want it here too?
> 
> It can be helpful if physical memory starts very high for some reason.
> I believe it is common for risc-v.
> 
> Tenstorrent Blackhole card has 4G of RAM based at 0x400030000000.
> Counting from address 0 that is a 4M bitmap for 4G of RAM. :-/

Sure, although this won't be used much right now, it will prepare the
structure for future expansion. It also shouldn't add much complexity to
the process.

I will get the structure like this now

  /* Bit N covers the unit at @phys_base + N * @unit_size. */
  struct linux_efi_poisoned_memory {
        u32             version;
        u32             unit_size;      /* bytes of phys space per bitmap bit */
        u64             phys_base;      /* address bit 0 covers */
        u64             size;           /* bitmap size in bytes */
        unsigned long   bitmap[];
  };

and then offset the entities in the bitmap by phys_base.

Thanks for the feedback,
--breno

