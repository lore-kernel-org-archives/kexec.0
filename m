Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC48C53219
	for <kexec@archiver.kernel.org>; Tue, 28 Jul 2026 17:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YWcOuz2FCk2M/N4hPo/RfjZ4wgMZydAAPFWNhRgyIZk=; b=vZ7nbqYW3s2WWnrejnb89LW7uU
	AullAXS29f6ZzkbvZn8vGo39cmZhZQRJCwE/L4gjWKMo797ZdYtvTB+jJ+CRTabJdKY45bkpvEccG
	bxhaNsYEJROKrfrFofA2+T1/yqROVqzKVveRfjOHGAR/qB0gqmCn+0Sn4vdluGd9ge4GCq8mf0z7Y
	FJPOMZePB64TEJ/9Vs3mY2M985kP/f37bhXoxLi1WrAooTNfngG7HAsW53XQ+OgrQ+MtDKZA9Ah7p
	22irKeqTmHhIcYAnM9A6pr966uZOYPIzqD+PJppFdWlF3PoRIDFXxk7nqktVJU6yrqQ9jMD8/C+bn
	d9IccZvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wolsC-000000061lv-1wMd;
	Tue, 28 Jul 2026 17:45:48 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wolsB-000000061lk-0HYP
	for kexec@lists.infradead.org;
	Tue, 28 Jul 2026 17:45:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id F2D7960AA4;
	Tue, 28 Jul 2026 17:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF991F000E9;
	Tue, 28 Jul 2026 17:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785260744;
	bh=YWcOuz2FCk2M/N4hPo/RfjZ4wgMZydAAPFWNhRgyIZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FVzER59y3LnsZPz15yo4AC8e7/M/vcFnKF3tIZSYNB1SZ0cQxWVt9kgUaV5bm+YDe
	 xyFScO5UJgXzpbR1FS0DHEMnp+HdxrqFY4odmatBbI5gGa9FVOTiTByo1GouzNQ5qD
	 ZfScDcSGGCtJsVBuGCFwOe7Fe/v1vp86pHMpGIccPMtGyoqhLeiKCoq+biPLHnVXoA
	 Xufi/amjsgf9qbEEhJK4b1mmdNpoSKtRZ5SrO7YDrlK+3b58eFCYpQFYsfoOmiRFzu
	 LHRNBpb3t94bHxyfavFNXfVD9d8/I7tjHkuve5VWRsEGyMT7vFvKiAZ1VebjyCJrsX
	 jR3LiTzNR9OWA==
Date: Tue, 28 Jul 2026 20:45:36 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>,
	Jork Loeser <jloeser@linux.microsoft.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 19/21] memblock: make HugeTLB bootmem allocation work
 with KHO
Message-ID: <amjqwKoF0XrvYw9N@kernel.org>
References: <20260725172133.4018491-1-pratyush@kernel.org>
 <20260725172133.4018491-20-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260725172133.4018491-20-pratyush@kernel.org>
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

On Sat, Jul 25, 2026 at 07:21:19PM +0200, Pratyush Yadav wrote:
>
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 8b2e551435ae..ff470fd0fd10 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -19,11 +19,9 @@
>  #include <linux/mutex.h>
>  #include <linux/string_helpers.h>
>  
> -#ifdef CONFIG_KEXEC_HANDOVER
>  #include <linux/libfdt.h>
>  #include <linux/kexec_handover.h>
>  #include <linux/kho/abi/memblock.h>
> -#endif /* CONFIG_KEXEC_HANDOVER */

This breaks memblock tests, can you please add stubs for these in
tools/testing/memblock?
  
-- 
Sincerely yours,
Mike.

