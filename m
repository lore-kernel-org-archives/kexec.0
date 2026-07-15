Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7245C44508
	for <kexec@archiver.kernel.org>; Wed, 15 Jul 2026 14:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oIN1D0w276ZCBo/p6qmKOVTvWs9t/bPnNPZkQ7qbZLc=; b=qNnUmW+3kPzhuAh1P95ls69bYe
	2qOaAPCGDt22nEL6Vl423cMTKcYzPfkawvJV/33/u/riW8AZCB/7xJ1k36UuAUiqo01BbJkt2YcUG
	T9zRU99Ljv8r9Oo5YcnqHV9gDoUjfQTo6XCDlIQOtYDUzDyoFRZ0BiotR0EsnNAPY10BBTiaRuUSa
	XaooM5saYHmgDfvsh7OS+8b29vTIJQF1BCQt/hnMzPQQttjyrRHIzxof2POkRBTn6Q7xOORglOw8G
	KNQiTRFr4yCooEH4ZGYbQYl4n4XdnHOGMzXyDxgef7lOgLj4S91ZZ0cRVWjEx7dQDlxk80XZ4B5hu
	83Gowd/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wk0Kr-0000000F4jW-3B4B;
	Wed, 15 Jul 2026 14:11:41 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wk0Kq-0000000F4j9-2LLc
	for kexec@lists.infradead.org;
	Wed, 15 Jul 2026 14:11:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 35F46418E7;
	Wed, 15 Jul 2026 14:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE871F00ACF;
	Wed, 15 Jul 2026 14:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784124700;
	bh=oIN1D0w276ZCBo/p6qmKOVTvWs9t/bPnNPZkQ7qbZLc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=FE3XxHA6Ht+ZERuQi7iiWlt294ipZ7vERbxGxQ1/QZLtQ0co9d+pByP9Sh2avyAZX
	 3wPFgR9KEzYtyKSbQX66nREbEFlGVHaHgLDSHd1hcYFj7vSfCyIUdS6mfeJOLcZcES
	 plwnpYKEFnTUBTOJOFZybqCFk7aKLhXxvACOisEaVqhVSOdN7VFVlz8YPcLLN9HZi9
	 bRew7c6AFyoM3c0CMh1bgvXZlQAo4ulrC355ABpvGw5WJK6SbGizjQN0SRvHMVvN+f
	 O+xOK4XscPhsySQO477ROwsYUWmgyK8hJLVzqSOeQBxDJ+KtR4aJAgOgezJRQBCqQR
	 VWdOZ2SHQibjQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Jackie Liu <liu.yun@linux.dev>
Cc: pasha.tatashin@soleen.com,  rppt@kernel.org,  kexec@lists.infradead.org
Subject: Re: [PATCH 2/2] liveupdate: reject nonzero reserved value for
 SESSION_FINISH
In-Reply-To: <20260715060613.19272-2-liu.yun@linux.dev> (Jackie Liu's message
	of "Wed, 15 Jul 2026 14:06:13 +0800")
References: <20260715060613.19272-1-liu.yun@linux.dev>
	<20260715060613.19272-2-liu.yun@linux.dev>
Date: Wed, 15 Jul 2026 16:11:37 +0200
Message-ID: <2vxzpl0oibqe.fsf@kernel.org>
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

On Wed, Jul 15 2026, Jackie Liu wrote:

> From: Jackie Liu <liuyun01@kylinos.cn>
>
> The UAPI documents liveupdate_session_finish::reserved as requiring zero,
> but luo_session_finish() currently ignores it and finishes the session.
> Accepting nonzero values prevents the field from being safely repurposed
> by a future extension.
>
> Reject nonzero reserved values before changing session state, matching
> LIVEUPDATE_SESSION_GET_NAME.
>
> Fixes: 16cec0d26521 ("liveupdate: luo_session: add ioctls for file preservation")
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

