Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7054AC5DF80
	for <kexec@archiver.kernel.org>; Tue, 18 Aug 2026 09:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CgxvZuvkwadEpFuIclkSP8Q6+jXLcm9MUedkH6duLsc=; b=o7TCyDEDIjq9tvy/yfnPMN3cNv
	8uu2Yp+0sN9WVhHXd6hDbng3Gu0ymmD6DXb3iifvvHhj0djN2Bnxw7xBJL5WxGbHa++pyNRBurl8C
	7vFugbZEAmlhjwhUvgDX1L4fBdDTLL3CUgLW1rfqEBlzv4lz8iC2Vt1fFqAmv2DT3SWcOCRH02/Dy
	cYpII+ZlYn0LukMKPGLtLjjul2sUtHpGk1uLUW67XJrHb25WNtl4ziqje2L3PmJcHtyjdeMAa6Gv4
	+6HQUbAe/GfIkNeCwxfnBqUrh2zLPZnq1fcq/tnnvA+7qciBnh4ViFYvEr48PRTFVLI1Dq7xuJafj
	3cXdfNZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwFwW-00000007adF-3kDU;
	Tue, 18 Aug 2026 09:17:12 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwFwU-00000007acl-3FLM
	for kexec@lists.infradead.org;
	Tue, 18 Aug 2026 09:17:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 25348433BB;
	Tue, 18 Aug 2026 09:17:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5751F000E9;
	Tue, 18 Aug 2026 09:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787044630;
	bh=CgxvZuvkwadEpFuIclkSP8Q6+jXLcm9MUedkH6duLsc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Sp+d8/UpGyNfg9ewcl0Xff86tUjKVbiovZXBlh3Ez8eoIN3BHBBPccNWCWgOFcs7r
	 LVZEt5YFnKAmBxjwOWsKZ14WMGgXL99MEGoY8psZcp9Va/MxxfPaJUDoWcUM56Kk21
	 yFQZxRnckxSwrP5xQXVRDsbGZSyaFjGQUsTRMMpaA1QGx0xqRlBR6oaT+60odvl2u+
	 JQH3UW2CSjfU/6pE7mweMMg7erA82fC2Pq6GSQbODg+g7jDCbuugtfcSxPUWKS2+GN
	 M4Kgfe9jfmjsZ55GZQM2ppBjHrz1aoxwZudGG0lU/6cI+eYbucLvLxMsOcfnbp13BY
	 HUJTI/5305zig==
From: Pratyush Yadav <pratyush@kernel.org>
To: Chenghao Duan <duanchenghao@kylinos.cn>
Cc: Pratyush Yadav <pratyush@kernel.org>,  pasha.tatashin@soleen.com,
  rppt@kernel.org,  graf@amazon.com,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  kexec@lists.infradead.org,  jianghaoran@kylinos.cn
Subject: Re: [PATCH] liveupdate: use scoped_guard for mutex in session
 operations
In-Reply-To: <20260817025146.GA133735@chenghao-pc> (Chenghao Duan's message of
	"Mon, 17 Aug 2026 10:51:46 +0800")
References: <20260814095506.631274-1-duanchenghao@kylinos.cn>
	<2vxzzeyo23ol.fsf@kernel.org> <20260817025146.GA133735@chenghao-pc>
Date: Tue, 18 Aug 2026 11:17:07 +0200
Message-ID: <2vxzfr0b23fw.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Mon, Aug 17 2026, Chenghao Duan wrote:

> On Fri, Aug 14, 2026 at 04:10:34PM +0200, Pratyush Yadav wrote:
>> On Fri, Aug 14 2026, Chenghao Duan wrote:
>> 
>> > Replace manually paired mutex_lock/unlock with scoped_guard to align
>> > with the coding style of the rest of the codebase and simplify locking
>> > paths.
>> 
>> No. This is done explicitly because we don't want to mix gotos with the
>> automatic cleanup-style locking. I don't think we should change this.
>> 
>
> Thank you for the clarification. I understand your concern about mixing
> `goto`-based error handling with automatic cleanup-style locking.
>
> I was wondering if these particular cases might still be suitable for
> using `scoped_guard()`. The patch only changes two manually paired mutex
> lock/unlock instances, and in both cases, the guard scope is limited to
> the operation that requires the mutex. The lock is released before the
> subsequent error-handling logic is executed, so the `goto` paths do not
> cross the scope of the guard.
>
> We could also use an explicit `scoped_guard { ... }` scope to make the
> lifetime of the guard more obvious and easier to review.
>
> Of course, I may be missing some broader considerations. If there are
> other reasons why these cases should retain the explicit lock/unlock
> pattern, I would be happy to follow your guidance.

That's one of the recommendations of the cleanup API. From
include/linux/cleanup.h:

    Lastly, given that the benefit of cleanup helpers is removal of
    "goto", and that the "goto" statement can jump between scopes, the
    expectation is that usage of "goto" and cleanup helpers is never
    mixed in the same function. I.e. for a given routine, convert all
    resources that need a "goto" cleanup to scope-based cleanup, or
    convert none of them.

Which sort of makes sense I think. Also, cleanup-style guards can cause
compilation failures too. For example, if you do:

    err = sanity_check();
    if (err)
    	goto out;
    
    guard(mutex)(&my_lock);
    
    ...

This will fail to compile.

Now this problem doesn't exist with scoped guards as far as I can tell,
but I do see why it is recommended to not mix them with gotos.

-- 
Regards,
Pratyush Yadav

