Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C0DC5DF93
	for <kexec@archiver.kernel.org>; Fri, 21 Aug 2026 14:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eb7xA0CZoUY2QWL9JJY5cm27fWnsNVXdbEb3sAd4rNw=; b=TA9riORt4SSuNu9wdVGr8hTB/V
	TBw8doB/cCqmLpE5ul3jWHLCz4v3kBWQHRjzAG0HM772UXXPT73VDHWuZbcpTnw9g+pAFDteBSwUK
	s9ZMQAJDInsfonRSLrH3E/J6fAKu1EHqcRXgc7t98K4GuUfxKRAowQm4HAPMl5OiBy8U76ZFLk8vO
	eIar2zVGnn4GCyVUxXWsj7TA1xmLGnVegV0ez7Enc0QNbtjkFRdnLgZE3wghUfzy7WS8yHELco/JT
	GWdTIlsmHDki1kfpHXzJTTWCGUTySWz99mNYecNlVuGpAxByBORH8al/G0nRGhlXzK8afrBmA+0vq
	FwWCaPTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxPye-0000000DW1B-1ypY;
	Fri, 21 Aug 2026 14:12:12 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxPyd-0000000DW0n-0yrY
	for kexec@bombadil.infradead.org;
	Fri, 21 Aug 2026 14:12:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eb7xA0CZoUY2QWL9JJY5cm27fWnsNVXdbEb3sAd4rNw=; b=oTwKL53lxqaDGB7MtM9Y4a/3g4
	oNFeZTydZ011b/0fYBE82io3Da6IMK2nNtM++2e/XIolA0UhapO3h24OvET/fC5jRaZ7w7CFbe6zi
	OmS7WrRw5KXomk1GTlBBSf5H6ZmUwJj8sY6t5jPiekJ9I2fyDgTqumgLuy0AIbnn91b1hoLLzHMA2
	pmL1vMDwy5NtN8/iXKkDGqdcNWCKKIOdjQggUsaZh41iJbrthT+Su75e0H6yti4OqUEKs1ckXT36Y
	NMGfVaHC3rJyLoyAD9FfpDegNQbVQAFuEMuvv5CGTCtQ1eI38Fzs1uQyJeKUsjh/ZfcwnJRRkNOY5
	gqMXvsXA==;
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wxPya-00000003pCh-2PTz
	for kexec@lists.infradead.org;
	Fri, 21 Aug 2026 14:12:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eb7xA0CZoUY2QWL9JJY5cm27fWnsNVXdbEb3sAd4rNw=; b=fsH1sn0fhWE8VQ6z44pz/Lqc0a
	aCuIa4UarAIbljORKpZoWr5R+6hCDAZCFRXWhw03ztEtOLQEAiso10RmuGAuvbUom2dZRqwfOts8T
	DflDsj6s87G8SrgSKJetC2hOs7bkiC5VmU2tr2ONT1PGzK6UZUTOEQHT6mVos88136eN0KHVzSi5K
	kEArKhSiS0hL+otnGvynq3ETl9EJ1kxDAJqglojE0UsKQfqDM+QahbRafrvAGQQlQLrRwQjQDLIKt
	JNqShfQBu8zJgRuB1Ydjc2ADFaEYuvhsRvRcFilDMT7zEAi5QYlXu1ebTL23bI1fh9M1+lAqt8HI+
	Fi8v6Zug==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wxPyJ-00BOWn-2i;
	Fri, 21 Aug 2026 14:11:52 +0000
Date: Fri, 21 Aug 2026 07:11:47 -0700
From: Breno Leitao <leitao@debian.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Kiryl Shutsemau <kas@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rmikey@meta.com, riel@surriel.com, kexec@lists.infradead.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v2 2/6] efi: add the LINUX_EFI_POISONED_MEMORY
 configuration table
Message-ID: <aohbRisiQ9Mn-ldY@gmail.com>
References: <20260821-hwpoison-kho-v2-0-5743791e48e6@debian.org>
 <20260821-hwpoison-kho-v2-2-5743791e48e6@debian.org>
 <aog7bwfMVpSy9LcY@thinkstation>
 <2vxz5x13znn1.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxz5x13znn1.fsf@kernel.org>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_151208_677054_F82CE678 
X-CRM114-Status: GOOD (  13.76  )
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

Hello Pratyush,

On Fri, Aug 21, 2026 at 02:03:30PM +0200, Pratyush Yadav wrote:
> >> +config EFI_POISONED_MEMORY
> >> +	bool "Carry hardware-poisoned pages across kexec"
> >> +	depends on EFI_STUB && MEMORY_FAILURE && 64BIT
> >> +	help
> >> +	  Record page frames that are hardware-poisoned while this kernel runs
> >> +	  into an EFI configuration table, and honor that table early on the
> >> +	  next kernel so a kexec does not hand known-bad RAM back out.
> >> +
> >> +	  If unsure, say N.
> >> +
> >
> > Do we want to make it conditional? Maybe just for everyone with EFI_STUB
> > && MEMORY_FAILURE?
>
> +1. Each config we add is a decision someone has to make when compiling
> the kernel. If they rely on the default, they will miss out on this
> fairly useful feature.
>
> So, is there any downside to just doing this by default without any
> config?

The only downside I see is that this extra config table gets carved
out of main memory for every MEMORY_FAILURE user.

That is roughly 64 KiB per TiB of RAM, though, so maybe it is small
enough to just enable by default?!

Thanks for the review,
--breno

