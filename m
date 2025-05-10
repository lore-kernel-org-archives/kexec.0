Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA92C3ABC3
	for <kexec@archiver.kernel.org>; Sat, 10 May 2025 01:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WF49SGwnub29UzmpBOlgvv1ARoUghuZ4Dyh1Meba4oo=; b=oLmOeASa6VBwoPRrqUU5bgb2iC
	/RidyF4cMnP5dhOtgdPaUkZfBd5HmBywVRUnEXRAmwJCifNSdKwZ03ecMe0p38tfB0JykeruxY0zm
	4e9+vQOpUinUgeAjO8DWAzjBZXEsVw6ByZUCcqfFu0mEUmHQBnZ26hloGDaH2Ee9JJ1BA2i1lB2oi
	Ed/qo7ufiM21E5WE6wNVxJJuxTmcQp9T8rtKXPd4QY1IregRY0xXDazFq8lvHECyarI82z9wKTbM7
	RHFZQUsEl4dfPAEO+mkWPYJXUqUxOfpHx59uGlPGeiuVeyccj3GhqEkkkw/MwEbIPAtnoL/W5A4j9
	mfR42VaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDZ7b-00000005GVX-1EkF;
	Sat, 10 May 2025 01:35:23 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDZ7Z-00000005GUv-0AMa
	for kexec@lists.infradead.org;
	Sat, 10 May 2025 01:35:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id BF016A4D687;
	Sat, 10 May 2025 01:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF16C4CEE4;
	Sat, 10 May 2025 01:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1746840919;
	bh=RKZARjtItSMo67EEN9USgQO9kVkqBIBwfgHN4qsQIF4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jn7m1SE4CkXhy8+3E6kC1fI4Jx9ahn2xXUX6E5oZu2JSsg8nbWlZObHnAYokfHd/4
	 Uhaid6Xl/iEVNjIJrMr1FIvOWbjdbqF6l5z1AfW50W7pYPunkgAiAdWaPZjwzqZvVg
	 DowEuEXhgAVxjZQsgst+x2RWJiZD3XqeRioz5PxE=
Date: Fri, 9 May 2025 18:35:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Baoquan He <bhe@redhat.com>
Cc: Coiby Xu <coxu@redhat.com>, fuqiang wang <fuqiang.wang@easystack.cn>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v4] x86/kexec: fix potential cmem->ranges out of bounds
Message-Id: <20250509183518.bf7cd732ac667a9c20f1fee1@linux-foundation.org>
In-Reply-To: <aB3RqS85p6DiHKHm@MiWiFi-R3L-srv>
References: <20240108130720.228478-1-fuqiang.wang@easystack.cn>
	<ZZzBhy5bLj0JuZZw@MiWiFi-R3L-srv>
	<4de3c2onosr7negqnfhekm4cpbklzmsimgdfv33c52dktqpza5@z5pb34ghz4at>
	<20250507225959.174dd1eed6b0b1354c95a0fd@linux-foundation.org>
	<2754f4evjfumjqome63bc3inqb7ozepemejn2lcl57ryio2t6k@35l3tnn73gei>
	<aB3RqS85p6DiHKHm@MiWiFi-R3L-srv>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250509_183521_154355_71F74EA3 
X-CRM114-Status: GOOD (  19.24  )
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

On Fri, 9 May 2025 17:58:01 +0800 Baoquan He <bhe@redhat.com> wrote:

> > The bad commit was introduced in 2021 but only recent gcc-15 supports
> > __counted_by. That's why we don't see this UBSAN warning until this
> > year. And although this UBSAN warning is scary enough, fortunately it
> > doesn't cause a real problem.
> > 
> > > 
> > > Baoquan, please re-review this?
> > > 
> > > A -stable backport is clearly required.  A Fixes: would be nice, but I
> > > assume this goes back a long time so it isn't worth spending a lot of
> > > time working out when this was introduced.
> > 
> > So I believe the correct fix should be as follows,
> 
> Thanks for testing and investigation into these. Could you arrange this
> into formal patches based on your testing and analysis? 
> 
> It would be great if you can include Fuqiang's patch since it has
> conflict with your LUKS patch. This can facilitate patch merging for
> Andrew. Thanks in advance.

Yes please, I'm a bit lost here. 
x86-kexec-fix-potential-cmem-ranges-out-of-bounds.patch is not
presently in mm.git and I'd appreciate clarity on how to resolve the
conflicts which a new version of
x86-kexec-fix-potential-cmem-ranges-out-of-bounds.patch will produce.

