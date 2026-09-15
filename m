Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F91C88E75
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 13:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tZSU09jDCsIk/tpoX25HEUkW1egfskgNv1nvZG1Ds40=; b=0Sie+ZbiE5NI5iEH5vL7liN902
	bHNaY4wm8fiJeQG5UR5KuLT7/rNowKZzaRZGHYzWvLxNUzfK2Jkjl+5WGRIgENzojxyi+4QXQ1Rfc
	xKtplXvUn/jvSSCo1XJawqLixjRoKXptxp6WXwScH5HBgMQs1qzj/elpm6SL6kyXRgv4XQs2Jqrmg
	vJ+IfKJBBeSOmVqKFgnljEHGq6xcAXDXZAdptvvxYUDuZ2JzUJfZiHlgMDaB/Em4oTfGz94wJiLah
	hEXc3uyi7asEayhlWXtwd+Uc8k5nxra372n88DeO01N5IKpEdhpiI0ffhZHPaoQ7euoHAkLOrzWBQ
	i+3v6n1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6TNX-00000006lg8-21gz;
	Tue, 15 Sep 2026 13:39:19 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6TNU-00000006lej-464Z
	for kexec@lists.infradead.org;
	Tue, 15 Sep 2026 13:39:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=tZSU09jDCsIk/tpoX25HEUkW1egfskgNv1nvZG1Ds40=; b=BANf+DRv0G7ET6nd+Q02kEYT2c
	vD0Mdmy0esC2oiO1N8yesVKAZLUPkTsnz8o42k+YjQG4Z+8iuYgTcrL0MNA6PbeaKganDKnzH1Y6o
	dz1s24SikbwO6UvoBwIl5MOsySvfek4zhd34ghQRFqhlMs76eRAiXy7gCoWV3PKofIQOYDmDdmZ+z
	8umNKp9aZ7sYSbOGScmRPisgvY7fTzJF4LhfQfgaYtHzp+aE8umHMErYILFzLYv+cC6N8zV0soirE
	MzgEa0+BS6oIJQ04ge7Wt0Df7pee81AIR4q7tocqaLjyrupAkjIJjTRtDxCT86XCyk5TrACr2je2b
	QoiL60yw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x6TN9-004QnQ-0c;
	Tue, 15 Sep 2026 13:38:55 +0000
Date: Tue, 15 Sep 2026 06:38:47 -0700
From: Breno Leitao <leitao@debian.org>
To: Harry Yoo <harry@kernel.org>
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
Message-ID: <aqlI264D-PxJzPWb@gmail.com>
References: <20260909-hwpoison-kho-v4-0-359313564495@debian.org>
 <20260909-hwpoison-kho-v4-2-359313564495@debian.org>
 <2c9a7bef-3189-4f78-a6cb-61d2f7afd643@app.fastmail.com>
 <aqKhgPKzRf0e22s3@gmail.com>
 <aqkIdVhoG2wwVBtb@gmail.com>
 <aqkyT0Ui9h5KWuzn@thinkstation>
 <aqk4NUnq92ftuUuJ@gmail.com>
 <aqlFnuIIECOyaweo@thinkstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqlFnuIIECOyaweo@thinkstation>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260915_063917_020499_3E87B209 
X-CRM114-Status: GOOD (  18.46  )
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

On Tue, Sep 15, 2026 at 02:31:38PM +0100, Harry Yoo wrote:
> On Tue, Sep 15, 2026 at 05:39:44AM -0700, Breno Leitao wrote:
> > > Also, I wonder if some architectures have a scattered set of pfn
> > > ranges so that the span from the start pfn to the end pfn being much
> > > larger than the actual physical memory size.
> > >
> > > If so it might make more sense to have a bitmap for each pfn range.
> >
> > Agreed, having a ->next in linux_efi_poisoned_memory is a good idea that
> > we can lean on depending on whatever problem comes up down the road.
> >
> > Very good point — let's keep this linux_efi_poisoned_memory chain idea in
> > mind for whenever we need to expand it.
>
> You mean 1) keeping the structure as-is for now (and expand later with
> new EFI table version) or 2) adjusting the structure in the future
> revision of this patchset?

I'd say option (1): keep the structure as it is for now, and only adjust
it once/if we actually decide to implement the hot-add use case.

That's exactly why I added the "u32 version" field to
struct linux_efi_poisoned_memory, so, it can be expanded later.

Version 1 (this patchset) covers the common, basic approach. If down the
road someone sees value in extending it to other use cases (such as
hot-plug), we can bump it to v2 and add a ->next field then.

What do you think?

Thanks for the review,
--breno

