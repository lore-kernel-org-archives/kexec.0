Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598B5C25B75
	for <kexec@archiver.kernel.org>; Mon,  3 Jun 2024 18:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3fCcvbhgKh64tdBMAW2ibclQTterpCmGUJ9m7jQxEnE=; b=O4OCImtzdRdXDL
	3TCeuZNF/ly7Q5UB0/W9tYinlnFKuVfGyaYrJyh4u98aDbUcfhqvTJMnkXZ0cEnYQVn9RS/R8EjgS
	iGetPgHtz0U6aLe8zFnUekfF1I08ksU+txupgVPDPOuy3taNhi87jI4sjivjl5IS3iUUMj0c4oAYc
	6jTXmqv2NZy8NEtRRg75jn6k93h6oLaCs9nd8gU8oTu171iBngjwc0/4PDfg4tRfAofML3OfpuOSR
	FG9xNeNEeTHozYD/9/Mz+OLRr37/4bLHB8ZqPXgTH1abp/sp8t6pyxtdNlObV/KZb3zL7A/0gwfSv
	6omxcb8Lzv2REAr5ntAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEC41-0000000Ha3a-48Xk;
	Mon, 03 Jun 2024 18:05:45 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEC3y-0000000Ha21-3xVb
	for kexec@lists.infradead.org;
	Mon, 03 Jun 2024 18:05:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id F20EDCE0E9A;
	Mon,  3 Jun 2024 18:05:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22666C2BD10;
	Mon,  3 Jun 2024 18:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717437940;
	bh=QJ4N6bG30KgmRUICmpMiKiuUXTn31cQuR9emyF3hrAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ogOJQkJFmOibSCcK4++5YySyckSEmo/zMSsz/VQY7vzghBGSm4xCxdtS2um5t0zQ8
	 iL/Gy4tiAOX+XtUx6uiZYKHOBP/RRsH8eNO727wy6GazrUqrfkseOgIqGniU+yJ5rd
	 7/c7BoMxhkyZ/VBhr/PQJ+rClj4BaSj1c1qqXCSJ/XszcH7VSJUhw1gK9MVhbvXquJ
	 2g60ST6AFm6CsXmxus7pdUcw8zYQ+vZFpeDZsl+gUfiVJEUTztNHFcbSaDXJ64PK05
	 +T8Fm/EvL1x9tFKc+BVNtsg0L/CaRhbLi6BQB54Vh1d/rtRPmJb3coTvPIXF04lu5w
	 zfzDVGO24cTjQ==
Date: Mon, 3 Jun 2024 19:05:37 +0100
From: Simon Horman <horms@kernel.org>
To: Hongchen Zhang <zhanghongchen@loongson.cn>
Cc: kexec@lists.infradead.org, chenhuacai@loongson.cn,
	Ming Wang <wangming01@loongson.cn>
Subject: Re: [PATCH] LoongArch: fix kernel image size error
Message-ID: <20240603180537.GG491852@kernel.org>
References: <20240520012016.6898-1-zhanghongchen@loongson.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240520012016.6898-1-zhanghongchen@loongson.cn>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_110543_191553_12F021A4 
X-CRM114-Status: UNSURE (   7.75  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon, May 20, 2024 at 09:20:16AM +0800, Hongchen Zhang wrote:
> Use kernel_size instead of kernel image size is wrong, we should get
> the kernel image size from loongarch image header.
> 
> Signed-off-by: Ming Wang <wangming01@loongson.cn>
> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
