Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A64CCCF9F8
	for <kexec@archiver.kernel.org>; Tue,  4 Nov 2025 00:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kg4LF7rkE/bXl9iieD20/QFbOQMW7syaEp2SBV98U9g=; b=yzmCsf9RUuQN5PlO5CovQ6HoqR
	RKtk9jBCWpCpyR0H8bY9qj6YCulCDqo60imCSuAURWyvbXSyDLS7hkeqWiuzsDEg6saSQ82AjiqZW
	gZq1thzJpgJJw0umtfFHrLSGc/nMTIYdKbTfykm8Ba3fAoMwO/n0Is2yw/XERgQL5LJSUxFyMyfbj
	dX7d+V4/O6lE04a7nNP9Y8eo1Ud6N7RvVdt4br/9sBtqWVf2Xj1jqtROBbeiovEYHxEKYKEGCm4Mx
	pDvfWfQg/8tKPBaumnVr/C5MR7jUSUzGQJTXdpFP5XmYPyryNfbS2ePy4xdzmXJ8Eht6+GYK2y1Pb
	BX06aGVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG4mi-0000000Aq1o-1Zeh;
	Tue, 04 Nov 2025 00:20:28 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG4md-0000000Aq1O-1Mhg
	for kexec@lists.infradead.org;
	Tue, 04 Nov 2025 00:20:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D435F44455;
	Tue,  4 Nov 2025 00:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE24C19425;
	Tue,  4 Nov 2025 00:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1762215621;
	bh=ARYJ94hkfr+wqtaTaCXJsG3Gdo7c5EgIBjp/zMCYw74=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kxfHdtZnLR8DJe75xj8jde8hiIdLJsDODUzrkcsU3oth4EmoafaP9q1vIet2FrDF7
	 Vif5lE2/OP4CwnUL/MCo+HJX3LicBWecGw1rfvdMKv85ziXudJQm5eF/OZ1UJX5vzy
	 P0Le76leURiT1Nbr40lIbqF1bECoQ5dIJm3nBBJ0=
Date: Mon, 3 Nov 2025 16:20:20 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Baoquan He <bhe@redhat.com>, Alexander Graf <graf@amazon.com>, Mike
 Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] kho: misc fixes
Message-Id: <20251103162020.ac696dbc695f9341e7a267f7@linux-foundation.org>
In-Reply-To: <20251103180235.71409-1-pratyush@kernel.org>
References: <20251103180235.71409-1-pratyush@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_162023_443723_512393AF 
X-CRM114-Status: GOOD (  13.97  )
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

On Mon,  3 Nov 2025 19:02:30 +0100 Pratyush Yadav <pratyush@kernel.org> wrote:

> This series has a couple of misc fixes for KHO I discovered during code
> review and testing.
> 
> The series is based on top of [0] which has another fix for the function
> touched by patch 1. I spotted these two after sending the patch. If that
> one needs a reroll, I can combine the three into a series.
>

Things appear to be misordered here.

[1/2] "kho: fix unpreservation of higher-order vmalloc preservations"
	fixes a667300bd53f2, so it's wanted in 6.18-rcX

[2/2] "kho: warn and exit when unpreserved page wasn't preserved"
	fixes fc33e4b44b271, so it's wanted in 6.16+

So can we please have [2/2] as a standalone fix against latest -linus,
with a cc:stable?

And then [1/2] as a standalone fix against latest -linus without a
cc:stable.


Once I have those merged up we can then take a look at what to do about
the 6.19 material which is presently queued in mm-unstable.

Thanks.

