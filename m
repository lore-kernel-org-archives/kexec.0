Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29657C3ABD8
	for <kexec@archiver.kernel.org>; Fri, 16 May 2025 23:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AtJd0Na/jGo4Ig2cY/tKGeLlFLwRRNtkt9lGQ8btlZo=; b=umM0IaZQf5FHwDpUZ/gzGsUDOG
	/5PV2DnsXbagZ+Hw5nWXMNMFOnWhFpSUFxqXduy7ntnETkG2tUj9qrPgKVidbRAUn8rAO89FmhY+/
	Ks6G7KslCgYg+9IMZ02poUkrQRFaRgFQcIa4PFwTLqsxHGwe22wbjwB2D1Up8gFujcINv6NRyXXVL
	lW2LIXF0YfALiN5FmnWxFi5DmH1WTcyg1KIPlFL8GJR+r120sR+kvYSbKr7VLbGz0jlRPanvRiw7T
	UEwykjBJZ/QrUlxkB+uS+IuBbQ7Z62w2UxXCsPx1Xk58LtZgoHEJDqhObsvM42PvySp3wbrTxEGuR
	umDD/aWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uG4Lk-00000004q1g-0LtH;
	Fri, 16 May 2025 23:20:20 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uG4Li-00000004q1U-1JIe
	for kexec@lists.infradead.org;
	Fri, 16 May 2025 23:20:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B486760EDF;
	Fri, 16 May 2025 23:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C0DC4CEE4;
	Fri, 16 May 2025 23:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747437617;
	bh=GMJAExymKlyzpKcXEpE4D10c3rl+qsRVgQASHsL38Os=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SANjnk6Vb+BV6/eaioMfhryZ33AY8VS2FmqNMrzTFR8ZTUNHsHHzgjFwy7FLyh9Q9
	 w9mmRCZbD3O7pVuMFz2cIDTgHudJEP/u3r1yH/DKpQrDx1xbOuOysg/hnlUTLDo9yx
	 7bL/ud3bRhN9+U/2mxdtBknOrMvmFJORsxTLzKuQcXEon+ez+ZAQ9lYW5c3SLFreAF
	 bk2C0N4ViNAg5kUXMt6mEdZPXmHogrFcJXOdpsp7erOY3+a+tMUUfcJNvoaA7q9Gj8
	 EXt9SL6LEItndZ3iT0s/ozN9ye1yEuPRnjOnBY2DPf31QGNZuChnvwPc+GQ3W+VDc1
	 A0DmVYAR4sulg==
Date: Fri, 16 May 2025 16:20:13 -0700
From: Kees Cook <kees@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: Coiby Xu <coxu@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
	fuqiang wang <fuqiang.wang@easystack.cn>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v4] x86/kexec: fix potential cmem->ranges out of bounds
Message-ID: <202505161616.F4C1BCCF6A@keescook>
References: <20240108130720.228478-1-fuqiang.wang@easystack.cn>
 <ZZzBhy5bLj0JuZZw@MiWiFi-R3L-srv>
 <4de3c2onosr7negqnfhekm4cpbklzmsimgdfv33c52dktqpza5@z5pb34ghz4at>
 <20250507225959.174dd1eed6b0b1354c95a0fd@linux-foundation.org>
 <2754f4evjfumjqome63bc3inqb7ozepemejn2lcl57ryio2t6k@35l3tnn73gei>
 <aB3RqS85p6DiHKHm@MiWiFi-R3L-srv>
 <20250509183518.bf7cd732ac667a9c20f1fee1@linux-foundation.org>
 <sn775iwfnogyvgxetbcfneuuzsnr5wva6kc4vachyzc7r6uhfi@ozhimoihtk4b>
 <aCaycGEtgNvynjNQ@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCaycGEtgNvynjNQ@MiWiFi-R3L-srv>
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

On Fri, May 16, 2025 at 11:35:12AM +0800, Baoquan He wrote:
> On 05/11/25 at 10:19am, Coiby Xu wrote:
> > On Fri, May 09, 2025 at 06:35:18PM -0700, Andrew Morton wrote:
> > > On Fri, 9 May 2025 17:58:01 +0800 Baoquan He <bhe@redhat.com> wrote:
> > > 
> > > > > The bad commit was introduced in 2021 but only recent gcc-15 supports
> > > > > __counted_by. That's why we don't see this UBSAN warning until this
> > > > > year. And although this UBSAN warning is scary enough, fortunately it
> > > > > doesn't cause a real problem.
> > > > >
> > > > > >
> > > > > > Baoquan, please re-review this?
> > > > > >
> > > > > > A -stable backport is clearly required.  A Fixes: would be nice, but I
> > > > > > assume this goes back a long time so it isn't worth spending a lot of
> > > > > > time working out when this was introduced.
> > > > >
> > > > > So I believe the correct fix should be as follows,
> > > > 
> > > > Thanks for testing and investigation into these. Could you arrange this
> > > > into formal patches based on your testing and analysis?
> > > > 
> > > > It would be great if you can include Fuqiang's patch since it has
> > > > conflict with your LUKS patch. This can facilitate patch merging for
> > > > Andrew. Thanks in advance.
> > > 
> > > Yes please, I'm a bit lost here.
> > > x86-kexec-fix-potential-cmem-ranges-out-of-bounds.patch is not
> > > presently in mm.git and I'd appreciate clarity on how to resolve the
> > > conflicts which a new version of
> > > x86-kexec-fix-potential-cmem-ranges-out-of-bounds.patch will produce.
> > 
> > I'll resolve any conflict between these patches. Before that, I'm not sure
> > if a separate patch to fix the UBSAN warnings alone is needed to Cc
> > stable@vger.kernel.org because 1) the UBSAN warnings don't mean there is a
> > real problem;
> > 2) both Fuqiang's patch and my kdump LUKS support patches fix the UBSAN
> > warnings as a by-product.
> > 
> > It seems the answer largely depends on if the stable tree or longterm
> > trees need it. Currently, only longterm tree 6.12.28 and the stable tree
> > 6.14.6 have the UBSAN warnings if they are compiled with gcc-15 or
> > clang-18. Any advice will be appreciated! Thanks!
> 
> I personally think UBSAN warning fix is not necessary for stable kernel.
> 
> Hi Kees, Andrew,
> 
> Could you help answer Coiby's question about whether we need post a
> standalone patch to fix the UBSAN warning fix so that it can be back
> ported to stable kernel?

I went back through the thread and the referenced threads and I can't
find any details on the USBAN splat. Can that please get reproduced in a
commit log? That would help understand if it's a false positive or not.

Also, referencing the commit would be good. I assume this is discussing
commit 15fcedd43a08 ("kexec: Annotate struct crash_mem with __counted_by")?

> In the case exposed during reviewing this patch, the code UBSAN warned
> is not risky.

Given that this makes things work correctly with newer compilers, I
would say it should be backported to whatever -stable kernels have the
"counted_by" annotation. (Hence the request to add a "Fixes" line so
that it will happen automatically.)

-Kees

-- 
Kees Cook

