Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCFAF8D762
	for <kexec@archiver.kernel.org>; Thu, 16 Apr 2026 16:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IUZqLd1e6mQtA0r/0InujOn54jhuCfx3vO3Aq70vCls=; b=ru+Xb8nEz9Lmmrm9674pizVX6X
	WDj34j0caOywpjx2go2KwrV/OffAx+JQ3PMJVU0ylfRn2BOPtWjRIEr1VZjCnkRjSpWZT2lcnEli7
	o7oCRnThoFOW+F4PuS5WHaX5pqCIfipVsC+QFK5jLjCLGIn736mxJQJQs2hCljsq8THdTVyT/Wdxi
	iUYxWb1YGokJfk3K83DmXA+1vURmkeyBA0PDQB2W6L9ukSeOlPLjfu97rg0Qtl4Lt59+XHgO7seyc
	8MnAcuSnwg1iSwIjby7aDvPH1Mu3AB5E1HHGWmakJH+Z/23sw4qdgINJwzuPH+zWZJP9Corc19vZa
	XYO9YOvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDPln-00000002fxK-3uMx;
	Thu, 16 Apr 2026 16:40:47 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDPll-00000002fwm-2In5
	for kexec@lists.infradead.org;
	Thu, 16 Apr 2026 16:40:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 72A26440E8;
	Thu, 16 Apr 2026 16:40:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E96C2BCAF;
	Thu, 16 Apr 2026 16:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776357643;
	bh=lCGmJ3F+1zjEehNS6SOPtlYDsWuMjRcxlWpNpztwY20=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bX6Niq2fCvU2FntF15yZDWJ/6kd2Cd766Rcq3gRZajZ7zH3dwUYzJXmr3v8Ej0VpI
	 Y+ZtIqhAupEVlrXQmQ8VS3DghuyFB5ZRtY0zXOhvSgnMw97KPaucJzr4KinUEczUZt
	 vbwJSi8fzOpDoIxZJa5Skk/0FyALPGDeCO96pXFXimupZpphGc0JKQEtmSQ/bi3c3V
	 7kEbSX0DJbwviS1cRP2J1VRrqS2AdpcLykzDmygRjkuduwfIPwBPhsAnu2Jf+JO97C
	 QPFjR8EZgaVOY4z2jDxxSJMLj/PyyrwZLTSwAQS55NRu/jGwNQ+TDD1mCHqRNGdOFf
	 Rh+gML+PhNJ0Q==
From: Pratyush Yadav <pratyush@kernel.org>
To: Evangelos Petrongonas <epetron@amazon.de>
Cc: Pratyush Yadav <pratyush@kernel.org>,  "Mike Rapoport (Microsoft)"
 <rppt@kernel.org>,  Alexander Graf <graf@amazon.com>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Rob Herring <robh@kernel.org>,  Saravana
 Kannan <saravanak@google.com>,  Changyuan Lyu <changyuanl@google.com>,
  Andrew Morton <akpm@linux-foundation.org>,  <kexec@lists.infradead.org>,
  <linux-mm@kvack.org>,  <linux-kernel@vger.kernel.org>,
  <nh-open-source@amazon.com>
Subject: Re: [PATCH v2] kho: skip KHO for crash kernel
In-Reply-To: <20260416161744.GA65710@dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com>
	(Evangelos Petrongonas's message of "Thu, 16 Apr 2026 16:17:44 +0000")
References: <20260410011609.1103-1-epetron@amazon.de>
	<2vxztstf7ys7.fsf@kernel.org>
	<20260416161744.GA65710@dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com>
Date: Thu, 16 Apr 2026 16:40:39 +0000
Message-ID: <2vxz8qam7ta0.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260416_094045_647730_C0DBEC74 
X-CRM114-Status: GOOD (  17.92  )
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

On Thu, Apr 16 2026, Evangelos Petrongonas wrote:

> On Mon, Apr 13, 2026 at 01:52:40PM +0000 Pratyush Yadav wrote:
>> Hi Evangelos,
>> 
>> On Fri, Apr 10 2026, Evangelos Petrongonas wrote:
[...]
>> > Note regarding backporting
>> > The offending commit was deployed with 6.19. The only other supported
>> > kernel version with 6.18, unless I miss someting uses
>> > ```
>> > if (!kho_out.finalized)
>> > ```
>> > which in the case of crash kernel it shouldn't be finalised.
>> 
>> While normally you should load the crash kernel early in boot and at
>> that point KHO should not be finalized, I don't see anything that
>> prevents crash kernel from being loaded after finalize. In which case,
>> you can trigger this bug before d7255959b69a ("kho: allow kexec load
>> before KHO finalization") as well. Also, before f322a97aeb2a ("kho: only
>> fill kimage if KHO is finalized") (landed in v6.18) kho_fill_kimage()
>> was also guarded by if (!kho_enable). So you'd hit this bug in all
>> kernels before that point in the very same way as today.
>> 
>> So should we update Fixes to 3bdecc3c93f9 ("kexec: add KHO support to
>> kexec file loads") and Cc stable?
>> 
> But in this case it seems a userspace misuse if it finalizes kho for
> crash kernel. Whereas with the current state we hit the bug with a sane
> userspace. Yeap we would hit that in earlier kernel than 6.18, but none
> with KHO is supported is it?
>
> I don't have strong objection for backporting it to 6.18, but it feels
> unnecessary. 

Fair enough. Let's leave it as it is then.

[...]

-- 
Regards,
Pratyush Yadav

