Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88890C88E7F
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 14:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HhkTKZqSauRlzDBmuIch4WSDGbcfsJp9na+AzwvnNew=; b=hiOrUGIgGhcQIctlyhrUwRWoih
	hmxM7Q//MhHfNB3jlsHZiEG2A8RLlo2202OfYEsa1hIytyhzdGUxWa38GgJ3kqL9LEqwMu6OyKqqw
	Kq59mA+fSTvZyuL0YmkkZnWIfUkymj0lzZsl1NcbGOKkWYU0jOOazCaFmepOsCSqSAKlwLkwvqd3X
	u/V0qmM/hwvam/4NZArhli8vGMEtG+14mqPTH5RIfhXGuLSz+Pn+aGmq62lif9eAdtMemlvv2EkWu
	2Gr3ou6kUPZ7sBmVN2P10bixmBfiVOzaZqVyYfcTAWY/WtwgSs/aI/OfqDXkUWBI7DmcxlfhL6BiB
	EfAhXulg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6UG3-00000006xW7-1hQm;
	Tue, 15 Sep 2026 14:35:39 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6UFz-00000006xUh-3lge
	for kexec@lists.infradead.org;
	Tue, 15 Sep 2026 14:35:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 43B0B600C8;
	Tue, 15 Sep 2026 14:35:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806681F000FF;
	Tue, 15 Sep 2026 14:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789482935;
	bh=HhkTKZqSauRlzDBmuIch4WSDGbcfsJp9na+AzwvnNew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VtKFlspQzOv/Zif2Ow84xQkRnLY0nrqHqoynrLyvg5SIxf+bnjB9jvnYZlJFCKoHk
	 Fsvtg3M88EQ9y23RcTgrVdPVCC12nYfwrTuUPtF7T8/em/9zQkHdQ/95dP05TspWKr
	 wlJbsjBRL2Kjst/08D5KbDCRo3s86XhKAa/vOUrCH037W/omFf9HgCtaWZYqYpWYMl
	 uKKz66IuX3ETy+gTxW9l3SEAwkF8wt6lilp3aw3yD1ss5zU4+IsNIrAC1l7/o+T56X
	 Rlmf4Odr5SnNyIpzIyI9wkTJHAURu7kq0z029COy9SPWurwLO8XzjMUfs1HWzJdOGd
	 394I86ioQiGRQ==
Date: Tue, 15 Sep 2026 15:35:33 +0100
From: Harry Yoo <harry@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>, kexec@lists.infradead.org, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rmikey@meta.com, riel@surriel.com, kernel-team@meta.com
Subject: Re: [PATCH v4 2/5] mm/memory-failure: libstub: install the
 poisoned-memory EFI table
Message-ID: <aqlMiLMZ_6RBbtgE@thinkstation>
References: <20260909-hwpoison-kho-v4-0-359313564495@debian.org>
 <20260909-hwpoison-kho-v4-2-359313564495@debian.org>
 <2c9a7bef-3189-4f78-a6cb-61d2f7afd643@app.fastmail.com>
 <aqKhgPKzRf0e22s3@gmail.com>
 <aqkIdVhoG2wwVBtb@gmail.com>
 <aqkyT0Ui9h5KWuzn@thinkstation>
 <aqk4NUnq92ftuUuJ@gmail.com>
 <aqlFnuIIECOyaweo@thinkstation>
 <aqlI264D-PxJzPWb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqlI264D-PxJzPWb@gmail.com>
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

On Tue, Sep 15, 2026 at 06:38:47AM -0700, Breno Leitao wrote:
> On Tue, Sep 15, 2026 at 02:31:38PM +0100, Harry Yoo wrote:
> > On Tue, Sep 15, 2026 at 05:39:44AM -0700, Breno Leitao wrote:
> > > > Also, I wonder if some architectures have a scattered set of pfn
> > > > ranges so that the span from the start pfn to the end pfn being much
> > > > larger than the actual physical memory size.
> > > >
> > > > If so it might make more sense to have a bitmap for each pfn range.
> > >
> > > Agreed, having a ->next in linux_efi_poisoned_memory is a good idea that
> > > we can lean on depending on whatever problem comes up down the road.
> > >
> > > Very good point — let's keep this linux_efi_poisoned_memory chain idea in
> > > mind for whenever we need to expand it.
> >
> > You mean 1) keeping the structure as-is for now (and expand later with
> > new EFI table version) or 2) adjusting the structure in the future
> > revision of this patchset?
> 
> I'd say option (1): keep the structure as it is for now, and only adjust
> it once/if we actually decide to implement the hot-add use case.
> 
> That's exactly why I added the "u32 version" field to
> struct linux_efi_poisoned_memory, so, it can be expanded later.

Ack.

> Version 1 (this patchset) covers the common, basic approach. If down the
> road someone sees value in extending it to other use cases (such as
> hot-plug), we can bump it to v2 and add a ->next field then.
> 
> What do you think?

That will work, no strong opinion here.

-- 
Cheers,
Harry / Hyeonggon

