Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C5CCA0EDC
	for <kexec@archiver.kernel.org>; Wed, 20 Aug 2025 14:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Su/OHazANarelKIlAJ/fg6d4xixyDxFKScYwQAQvY7I=; b=HKzumB2jf6I/Z7RxHRlu9lIlj+
	XAjybNsOyUjhXylpCf1lUcrMKtzKwp0kVGClh8ALj4amUYHWcbH0kHszYlMDcvxOMYn+Z+mJc0FXW
	p30YScjCcRBjn/BbfW0gq6MlbRkdDJffcFBoyazcCYiqIECWAXujMkaCkM/jY70c3NaxgHRLfZCVR
	kp5hVXwQazkunJE/fZVhQciyq05jmntickn3CBnRgy3S6+qI/Z6Ei2ShzwDxt0QpmAfiHe1USAFrI
	Hg8wZZSDVVoKL+fk08wEJOTA1lYdX2WKScYXiSRdpckB6ljwM1amZ7xZpsUptZq4jCH4LT33BBBab
	Dfc8rnUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uojtW-0000000E5u8-0gbD;
	Wed, 20 Aug 2025 14:34:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoiz6-0000000DpdC-08QT
	for kexec@lists.infradead.org;
	Wed, 20 Aug 2025 13:36:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755696971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Su/OHazANarelKIlAJ/fg6d4xixyDxFKScYwQAQvY7I=;
	b=iI7gEdaAXDh5yqpg+qNc1chwx8K7FOp+NjdBIuOhjALPPH49STi2xXEnsAXFubMTF3/L2s
	/1Z8afUWNSEuvAAtimAngwklbV56/Sub7eDKMYBxSoyyszQSadkluubNR+VKn4Lzqtc0R7
	jvoUU7ztJ1QaicWKK4wgOHbcK6RfiJA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-347-cerMHnjiOS2Tes0Va8V6QQ-1; Wed,
 20 Aug 2025 09:36:07 -0400
X-MC-Unique: cerMHnjiOS2Tes0Va8V6QQ-1
X-Mimecast-MFC-AGG-ID: cerMHnjiOS2Tes0Va8V6QQ_1755696966
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5749D18004A7;
	Wed, 20 Aug 2025 13:36:05 +0000 (UTC)
Received: from localhost (unknown [10.72.112.99])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A8F8419A4C9C;
	Wed, 20 Aug 2025 13:36:02 +0000 (UTC)
Date: Wed, 20 Aug 2025 21:35:57 +0800
From: Baoquan He <bhe@redhat.com>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: pmladek@suse.com, akpm@linux-foundation.org,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org, feng.tang@linux.alibaba.com,
	joel.granados@kernel.org, john.ogness@linutronix.de,
	namcao@linutronix.de, sravankumarlpu@gmail.com,
	kexec@lists.infradead.org
Subject: Re: [PATCH 3/9] crash_core: use panic_try_start() in crash_kexec()
Message-ID: <aKXPPQ93H/KkxgZh@MiWiFi-R3L-srv>
References: <20250820091702.512524-1-wangjinchao600@gmail.com>
 <20250820091702.512524-2-wangjinchao600@gmail.com>
 <20250820091702.512524-3-wangjinchao600@gmail.com>
 <20250820091702.512524-4-wangjinchao600@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820091702.512524-4-wangjinchao600@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250820_063612_143691_2744B14E 
X-CRM114-Status: GOOD (  20.31  )
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

On 08/20/25 at 05:14pm, Jinchao Wang wrote:
> crash_kexec() had its own code to exclude
> parallel execution by setting panic_cpu.
> This is already handled by panic_try_start().
> 
> Switch to panic_try_start() to remove the
> duplication and keep the logic consistent.
> 
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> ---
>  kernel/crash_core.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index a4ef79591eb2..bb38bbaf3a26 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -4,6 +4,7 @@
>   * Copyright (C) 2002-2004 Eric Biederman  <ebiederm@xmission.com>
>   */
>  
> +#include "linux/panic.h"
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/buildid.h>
> @@ -143,17 +144,7 @@ STACK_FRAME_NON_STANDARD(__crash_kexec);
>  
>  __bpf_kfunc void crash_kexec(struct pt_regs *regs)
>  {
> -	int old_cpu, this_cpu;
> -
> -	/*
> -	 * Only one CPU is allowed to execute the crash_kexec() code as with
> -	 * panic().  Otherwise parallel calls of panic() and crash_kexec()
> -	 * may stop each other.  To exclude them, we use panic_cpu here too.
> -	 */
> -	old_cpu = PANIC_CPU_INVALID;
> -	this_cpu = raw_smp_processor_id();
> -
> -	if (atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu)) {
> +	if (panic_try_start()) {

Seriously, where can I find this panic_try_start() and the
panic_reset()? 

>  		/* This is the 1st CPU which comes here, so go ahead. */
>  		__crash_kexec(regs);
>  
> @@ -161,7 +152,7 @@ __bpf_kfunc void crash_kexec(struct pt_regs *regs)
>  		 * Reset panic_cpu to allow another panic()/crash_kexec()
>  		 * call.
>  		 */
> -		atomic_set(&panic_cpu, PANIC_CPU_INVALID);
> +		panic_reset();
>  	}
>  }
>  
> -- 
> 2.43.0
> 


