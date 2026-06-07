Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6B7CD8C93
	for <kexec@archiver.kernel.org>; Sun,  7 Jun 2026 11:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H2pnv615PWqSZrpd2NRH79qwtsELWXhl5rrCYlTNZXo=; b=RQQHtQTyESOEykg/AoJUvd3rSN
	SeOzrsV8x+DLon8DGlwq1h2O1Xu5SROED5U9ALHtsVrd/lON90oyt7Puby9HZ7/kMdOaVi5tBE8L8
	1am7vpwhygw2OT/o21HCkAzPE+o60WlsgfK64jKP7MXr/zObSyO/Sy/FFmeITx7jSfd5lqbwgi7ET
	Jyeka9D2xVRtYuREyCei06jB8pT9koh+TxjAIrnh2/NNrhg+ZdVxTy/6mm3jwYSpyToe0IUslMpiw
	AbqN86gacSY2XxHX+I7D1ZvOpvUZOmqNjwOtkoxiPRmip8ee6QxVe9KV0++ldybCKfqrzaJ/mWep/
	YVdcF7Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWC90-00000002EGh-2I5Y;
	Sun, 07 Jun 2026 11:58:22 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWC8z-00000002EG9-0iZr
	for kexec@lists.infradead.org;
	Sun, 07 Jun 2026 11:58:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 98183601E0;
	Sun,  7 Jun 2026 11:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0487A1F00898;
	Sun,  7 Jun 2026 11:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780833500;
	bh=H2pnv615PWqSZrpd2NRH79qwtsELWXhl5rrCYlTNZXo=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=ItsDMWphVvFP4D8ih+9sFpqdbEllQp8JuNzqgQys3nbl3JRqSpd7m82izly/lFRXA
	 23SWdwR6HYtp7hRPXyHAUcOCpSsHOvTegPo0+c0Zoc/8HpZOVaNaXYTu391jg8RAcT
	 lNuiTww4Je5vPyjUu6tupBsWXuI6+1WkwqXMcZ1uZzFer2zFa65oT4pvSbc/lPzohm
	 FThaHBR5t10QV7mIFRzbIdC1X3dBWriV7aLfUCAclVbONkt1fiCgXNJgD7wc7Oz4wc
	 9U8zF9tNMbgUZWnuUB23hxabixRlJ3jbIren5pQKdSCeKQcujQXRc3S61MiWKHXSmM
	 xJSxwo9xyAzYw==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC v1 1/9] kho: split out radix tree tracker into
 kho_radix.c
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org, rppt@kernel.org, shuah@kernel.org, 
 akpm@linux-foundation.org, linux-mm@kvack.org, skhan@linuxfoundation.org, 
 linux-doc@vger.kernel.org, jasonmiu@google.com, 
 linux-kernel@vger.kernel.org, corbet@lwn.net, ran.xiaokai@zte.com.cn, 
 kexec@lists.infradead.org, pratyush@kernel.org, graf@amazon.com
In-Reply-To: <20260605033235.717351-2-pasha.tatashin@soleen.com>
References: <20260605033235.717351-1-pasha.tatashin@soleen.com>
 <20260605033235.717351-2-pasha.tatashin@soleen.com>
Date: Sun, 07 Jun 2026 14:58:08 +0300
Message-Id: <178083348873.1648214.11020626647820932506.b4-review@b4>
X-Mailer: b4 0.15.2
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

On Fri, 05 Jun 2026 03:32:27 +0000, Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> Move the radix tree tracker implementation from the core KHO code

It's radix tree data structure implementation, kho memory tracker is it's
user. Please rephrase to keep the semantics clear.

>
>
> diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
> index eec9d3ae07eb..a3ee8a5c27a2 100644
> --- a/kernel/liveupdate/Makefile
> +++ b/kernel/liveupdate/Makefile
> @@ -7,7 +7,11 @@ luo-y :=								\
>  		luo_flb.o						\
>  		luo_session.o
>  
> -obj-$(CONFIG_KEXEC_HANDOVER)		+= kexec_handover.o
> +kho-y :=								\
> +		kexec_handover.o					\

I don't see much value in moving kexec_handover.o to a separate line,
btw, the same is true for luo_core.o, but it's not important enough to
change.

-- 
Sincerely yours,
Mike.


