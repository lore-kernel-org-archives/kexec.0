Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80079CA1004
	for <kexec@archiver.kernel.org>; Sat, 30 Aug 2025 17:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To
	:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/NSh9exXaV3mbXvMj+1kS4uqG4EyWHM1miHRNzuQSLM=; b=IJenqm+UMZMWCTTpLb9VwLsDYX
	20ise/FoGars71D8+SryermKTKWFX6BdeRBe3kayE3jqWgbirbl1Q3jHyGzJaPNFPHqTnooa6YduN
	3GEFtmfqW0STyAa/lZOEfpBTHauTP+bC2ekMNRcNJHqzNLyZIsb7RNnVSJZPz0MyzE48Omqxo0XeZ
	qOSiAuRHaIwYBItrGwBzl3L/uIaZHvszfeERz6dVAKrEqXxFDdIlaBuv9DmgWlEYtBBgFwNZLSR01
	5ygby/cnZkggys7N4HvNd0gZ8O6iG6O3/vWObhljg0E2wO9diFG5KyeS0WaODrbs9DgWiA99EnAi1
	G4PWIILw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1usPgB-00000008G9Z-3CXD;
	Sat, 30 Aug 2025 17:47:55 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urovB-0000000484g-1U3r
	for kexec@bombadil.infradead.org;
	Fri, 29 Aug 2025 02:32:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/NSh9exXaV3mbXvMj+1kS4uqG4EyWHM1miHRNzuQSLM=; b=Me6vF+bixpnnRMyDysrLUsLcF+
	H6XPhhmQTy1BhdDtIwEWMolncXgXeg3AswJ/FwtGkiTmMDRrB6ZxYI1c47sW36sUbVQwu6FPAZqRl
	8E6HtZoEirySLilBtAmBMjHu9pCZ4cp3KZaLVxpxvfnjiZb8hUtgdlls8E8ZFbWdBAkwFFNKxSDEH
	FyVLhal/LFmiSAcBoNyNH7df1gBuO1GgN7gKrVI7qi64h06WrXLqORpfXh/komrzmsjWSZ8bgmQNS
	Mq1oun4gFXzJ6q3yIoKhbctsoTHlqm2bP9bKZKHErsRm6kvAHIqzQ7TsXAs2lUaPLzDY91UgAlySG
	10ID71Mw==;
Received: from m16.mail.163.com ([117.135.210.4])
	by desiato.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urov4-00000003282-1m6a
	for kexec@lists.infradead.org;
	Fri, 29 Aug 2025 02:32:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=/NSh9exXaV3mbXvMj+1kS4uqG4EyWHM1miHRNzuQSLM=;
	b=hjl7ZbxXK4eydWkCtecrgKvGYg5I86g18ky3ymLIRDCGQEiXg+YpeQk0mtqz3u
	TcsOAAYx83eG5JvkPjFVOLp5AFw6PBUrL2gzr/x40bkZGxFU6kYtbPjchN3nB0Ac
	ERsjwcm3G0RyaJqqVB/3imrXd2wNw65O98jPpSFE3UYcI=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3HznMELFo1sYnEw--.1949S2;
	Fri, 29 Aug 2025 10:30:37 +0800 (CST)
Date: Fri, 29 Aug 2025 10:30:35 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: Jinchao Wang <wangjinchao600@gmail.com>
Subject: Re: [PATCH v2 3/9] crash_core: use panic_try_start() in crash_kexec()
Message-ID: <aLEQy-srX89Rndch@debian.debian.local>
References: <20250825022947.1596226-1-wangjinchao600@gmail.com>
 <20250825022947.1596226-4-wangjinchao600@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825022947.1596226-4-wangjinchao600@gmail.com>
X-CM-TRANSID: _____wD3HznMELFo1sYnEw--.1949S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF47JFy8JFyUCw18tr1rCrg_yoW8AFW7pF
	1ayay7Kw4kuFn5Kwn7JrsrtF4Fvw48JayxJa4vvF1fAasxJr15Jryv934xtFWjg343Kw1r
	AF12g3Zag398XFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziuT5PUUUUU=
X-Originating-IP: [60.166.106.45]
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiYhq3amiwW6b1mwABsv
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250829_033251_489111_C3650AEF 
X-CRM114-Status: GOOD (  21.11  )
X-Mailman-Approved-At: Sat, 30 Aug 2025 10:29:56 -0700
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
Cc: Sravan Kumar Gundu <sravankumarlpu@gmail.com>, linux-fbdev@vger.kernel.org, Kees Cook <kees@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, Yunhui Cui <cuiyunhui@bytedance.com>, Yicong Yang <yangyicong@hisilicon.com>, linux-hardening@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, Simona Vetter <simona@ffwll.ch>, Max Kellermann <max.kellermann@ionos.com>, John Ogness <john.ogness@linutronix.de>, Baoquan He <bhe@redhat.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Helge Deller <deller@gmx.de>, Joel Granados <joel.granados@kernel.org>, Thorsten Blum <thorsten.blum@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Petr Mladek <pmladek@suse.com>, Zsolt Kajtar <soci@c64.rulez.org>, Yury Norov <yury.norov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, dri-devel@lists.freedesktop.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Sohil Mehta <sohil.mehta@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Luo Gengkun <luogengkun@huaweicloud.com>, Feng Tang <feng.tang@linux.alibaba.com>, Shixiong Ou <oushixiong@kylinos.cn>, Anna Schumaker <anna.schumaker@oracle.com>, Tony Luck <tony.luck@intel.com>, Joel Fernandes <joelagnelf@nvidia.com>, kexec@lists.infradead.org, Douglas Anderson <dianders@chromium.org>, Li Huafei <lihuafei1@huawei.com>, linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon, Aug 25, 2025 at 10:29:31AM +0800, Jinchao Wang wrote:
> crash_kexec() had its own code to exclude parallel execution by setting
> panic_cpu. This is already handled by panic_try_start(). Switch to
> panic_try_start() to remove the duplication and keep the logic consistent.
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

Can you change this line of code to #include <linux/panic.h>?

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

-- 
Best,
Qianqiang Liu


