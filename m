Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C685FC982ED
	for <kexec@archiver.kernel.org>; Mon, 21 Sep 2026 13:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o50iEUUq9Hico4BGWHaX2sieM5OHx8zB4NrvMh/pa/A=; b=vFCfAnwjUWT43uD7Fuc2nOccNR
	6Sijt/VdRoKAyNQMWi9WwouTu3owB6zGAubZDDY1WSpmvTvjjMpKtwecbvXu1Yf9V0UhDLVfWedDq
	CFdIfoFTVJVr/SvuZQxmLSch5eMU03sGci7jNZdVbxriRm1p3zS65afPgLGe/HHPrLIW5p/fLtkc3
	hVtDkOe2f/HRSm4G8/1gWZJoGt24ziCLvs5WSR5LSNe1Yp7xjgZbiQuJoB/Z1hRYiL2fu2XuXkzFE
	D9BAQxffzXX1JgDsFOQ3nw+VgpWKIQWBvKjKlfv+2ODD9f2EueF/vLIXN+bvwrdco8A/32CJSaw0P
	+HXeD6og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8eHN-00000002Gll-3JcZ;
	Mon, 21 Sep 2026 13:41:57 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8eHJ-00000002GlK-0hAT
	for kexec@lists.infradead.org;
	Mon, 21 Sep 2026 13:41:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=o50iEUUq9Hico4BGWHaX2sieM5OHx8zB4NrvMh/pa/A=; b=aY55STBjtzWrl21NLFuecIM9F2
	jXs+e4PqxodBJcqUkj7CChyA5StfbY9Ye42NLiklat4rxvb5NGZj+KQenVRXFpyd3gwomZAJiMWTa
	30JZIjLf1zIPOIlxFA94dAD6Zv/Oznlygw6D/P59egCuoyjOqLsMhlNX0g4Sz9thM6Ca1CQC6thDY
	qR7OSlOY5QEnQ+gQOzFvY0t+AiVC9QzwlWti+PiUTSk2x6MyOWMxqb7wRxThGVrdZwH3wIhoVPM6U
	1NCQrptYHN1ln22pNHWZBnO03VOZxH02emQU031dZRLEU9C8w3Vm8YG28iXUEuoDdHQayV4kv8/Vp
	OQtvJMqw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x8eH2-002F62-2Q;
	Mon, 21 Sep 2026 13:41:36 +0000
Date: Mon, 21 Sep 2026 06:41:27 -0700
From: Breno Leitao <leitao@debian.org>
To: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Miaohe Lin <linmiaohe@huawei.com>, 
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
	shakeel.butt@linux.dev, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, rmikey@meta.com, riel@surriel.com, harry@kernel.org, 
	linux-cxl@vger.kernel.org, driver-core@lists.linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v5 8/9] mm/memory-failure: add hwpoison_boot_page() to
 flag an inherited frame
Message-ID: <arEz7lp9_nRGwHPm@gmail.com>
References: <20260915-hwpoison-kho-v5-0-3bc7a57bd503@debian.org>
 <20260915-hwpoison-kho-v5-8-3bc7a57bd503@debian.org>
 <aq5jyXzuDAANeCJs@acer-nitro-anv15-41>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aq5jyXzuDAANeCJs@acer-nitro-anv15-41>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_064155_646123_9A3764B9 
X-CRM114-Status: GOOD (  18.04  )
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

On Sat, Sep 19, 2026 at 03:58:25PM +0530, Shaikh Kamaluddin wrote:
> On Tue, Sep 15, 2026 at 05:53:42AM -0700, Breno Leitao wrote:
> > +
> > +	/*
> > +	 * The per memory block half of num_poisoned_pages_inc() has no block to
> > +	 * find at boot, and divides by zero looking for one. A hotplugged block
> > +	 * is already there.
> > +	 */
> > +	if (context == MEMINIT_HOTPLUG)
> > +		num_poisoned_pages_inc(pfn);
> > +	else
> > +		atomic_long_inc(&num_poisoned_pages);
> > +}
> 
> Hi Breno,
> 
> num_poisoned_pages_inc() currently assumes that the supplied PFN can
> be used for per-memory-block accounting and therefore calls
> memblk_nr_poison_inc() unconditionally. The early-boot path needs
> global-only accounting because the memory-block infrastructure is not
> initialized yet.
> 
> Could num_poisoned_pages_inc() treat -1UL as global-only accounting,
> matching num_poisoned_pages_sub()?
> 
> Example as below:
> 
> void num_poisoned_pages_inc(unsigned long pfn)
> {
> 	atomic_long_inc(&num_poisoned_pages);
> 
> 	if (pfn != -1UL)
> 		memblk_nr_poison_inc(pfn);
> }
> 
> 
> The caller could then use:
> 
> num_poisoned_pages_inc(context == MEMINIT_HOTPLUG ? pfn : -1UL);
> 
> This would keep updates to `num_poisoned_pages` encapsulated rather than
> manipulating the counter directly here, while also making the increment
> and decrement interfaces consistent.

Good point, and it is a better fit than what I have.

-1UL already means "global only" on the sub side, and it is not just a
convention on paper: remove_memory_block_devices() calls
num_poisoned_pages_sub(-1UL, memblk_nr_poison(mem)) when a block goes
away. Teaching inc() the same thing costs a branch and keeps
num_poisoned_pages behind the two helpers instead of growing a third
place that pokes the atomic directly.

I will fold this into v6:

      void num_poisoned_pages_inc(unsigned long pfn)
      {
              atomic_long_inc(&num_poisoned_pages);

              if (pfn != -1UL)
                      memblk_nr_poison_inc(pfn);
      }

Thanks for the review and suggestion,
--breno

