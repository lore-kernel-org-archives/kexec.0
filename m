Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DD0C982DA
	for <kexec@archiver.kernel.org>; Fri, 18 Sep 2026 15:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lbVpbtgdB6gGZcR4lzgAB3myFCTkj71uHlYAh1fjtFc=; b=rF7GIJYO4o8zUVuCuc/esxsMu5
	yeK5ibgPIy5+11+ZOjprgSSlGTKzaGxgPZ7SOPYxILFv/z6igvDvOigxN4fFTc7YjbYbtjVj3Ojop
	kCVJjGQdoUTz4STmttTVZQonG61I/P/R6MlJ8ktxGfm8tRFciPUla8fRF0RH4mvC2cPKdh9OJv8Ow
	kUqQqRkCI3DHSds2n0kN8oMejUGV9FHv3dPW+RAYldjzb8oKXc0iUf7mL7SXI8GOb7bWmnXUHKK5q
	92nrZRpPmrz1LBY6P9KUt4UbPAg+xN0UpVtmbbvPoSSYK5FA/FpP/ClJjK0Gl2v9IFGYNMr0E3da9
	jLrRy6FA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7auT-0000000EwDk-20ES;
	Fri, 18 Sep 2026 15:53:57 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7auR-0000000EwDV-2YYD
	for kexec@lists.infradead.org;
	Fri, 18 Sep 2026 15:53:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 89B246022B;
	Fri, 18 Sep 2026 15:53:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5BA1F000FF;
	Fri, 18 Sep 2026 15:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789746834;
	bh=lbVpbtgdB6gGZcR4lzgAB3myFCTkj71uHlYAh1fjtFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IIEriSXVzQQIbmH/FW5DBcrqsy76Yaczc0C0Ik4WHYjVQnzytaQllHxVnCbSmc/wf
	 3ip1FhCfubcWvgEFGaFqhoSBjDlBrbvhIHU25A/1RM1nk2BmIm70/Hxw8/S+DydAV0
	 3SGFaiA3XRt4FWTK9+c0V8lv5q/l4wftpnHooY14rs1ubyLM6hw2/hfF2VKKSwVh1e
	 FhOV+8MyczBeZB8UNCkeyseDoJ5Ct12tMLHGuGVDnY5b3vFJgGhlAZihGM0UyCgXsG
	 35aKDXN/yNndhmB4yIr2PssE15X1XCIQ3h0rbbmm3vNlaIAaUfJsNDydr5HXuEh6Xe
	 SOp7bD+QGVffA==
Date: Fri, 18 Sep 2026 16:53:52 +0100
From: Harry Yoo <harry@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	sashiko-reviews@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>, hannes@cmpxchg.or, 
	Borislav Petkov <bp@alien8.de>, Danilo Krummrich <dakr@kernel.org>, 
	Brendan Jackman <brendan.jackman@linux.dev>, x86@kernel.org, kas@kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, Zi Yan <ziy@nvidia.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Oscar Salvador <osalvador@suse.de>, "Rafael J. Wysocki" <rafael@kernel.org>, shakeel.butt@linux.dev, 
	Johannes Weiner <hannes@cmpxchg.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Ard Biesheuvel <ardb@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Mike Rapoport <rppt@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Lorenzo Stoakes <ljs@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Ingo Molnar <mingo@redhat.com>, linux-mm@kvack.org, kexec@lists.infradead.org, 
	linux-cxl@vger.kernel.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rmikey@meta.com, kernel-team@meta.com, driver-core@lists.linux.dev, 
	riel@surriel.com
Subject: Re: [PATCH v5 6/9] mm/memory-failure: efi: answer whether a range is
 poisoned
Message-ID: <aq1eWgGenthqMNd7@thinkstation>
References: <20260915-hwpoison-kho-v5-0-3bc7a57bd503@debian.org>
 <20260915-hwpoison-kho-v5-6-3bc7a57bd503@debian.org>
 <20260915134535.C3FC91F00899@smtp.kernel.org>
 <edafd246-0bd8-4335-9037-77f552968b56@kernel.org>
 <aq1Xr4b7BXZForCe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aq1Xr4b7BXZForCe@gmail.com>
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

On Fri, Sep 18, 2026 at 08:27:40AM -0700, Breno Leitao wrote:
> On Wed, Sep 16, 2026 at 08:44:30AM +0200, David Hildenbrand (Arm) wrote:
> > On 9/15/26 15:45, sashiko-bot@kernel.org wrote:
> > >> The bitmap an earlier kernel filled in gets in this one through EFI,
> > >> but nothing reads it back yet.
> > >>
> > >> Introduce range_contains_poisoned_memory(), which the page allocator
> > >> will use to ask about a block before handing it out.
> > >>
> > >> Signed-off-by: Breno Leitao <leitao@debian.org>
> > >
> > > Sashiko has reviewed this patch and found no issues. It looks great!
> > >
> >
> > David has reviewed this mail and it annoyed him.
> 
> Breno is curious what annoyed David here.

Harry assumed David was annoyed by Sashiko replying with
every 'LGTM' email :-)

-- 
Cheers,
Harry / Hyeonggon

