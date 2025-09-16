Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A5DCAC59F
	for <kexec@archiver.kernel.org>; Tue, 16 Sep 2025 20:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To
	:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6HInf3vVICYvsjl1BbLw9IcLOL1iDFPRtoXvi2r6kSo=; b=G0ZMDbUVxzBlt89o3A7vFLDF+i
	HRDbHZmWMtsXtVC3dgOw7xRjYMs/yNHnuVrom/ux9pdukEY8NwkSx3XJPcqkVUQefLNMCTFkuAxcT
	CuEYSQAIu5hVUbYXhCANZb5j+Sk/qcSR3e44oJdLH2t96+nbuF7AonpAPDr06mlSstHKYG40C04wg
	/zWNfPmr49Zn7SdF4hlo52MlRZiso9hK1mWPjkIUV6ikSwO8duph49srFqv6J4O2W9TGkIQtrI5FB
	s2kp2U5YJNIuvifOl9zpBAykCl6eVBsYGUPcRBrqU/AtJ/wNHu/XXPBNjnQ6Gxg/DQNGKV8VWVImz
	P9TwSVeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uybyf-00000008xZZ-44r5;
	Tue, 16 Sep 2025 20:08:38 +0000
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uySR3-00000007Rjl-0eE6
	for kexec@lists.infradead.org;
	Tue, 16 Sep 2025 09:57:18 +0000
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-b07d4d24d09so271549166b.2
        for <kexec@lists.infradead.org>; Tue, 16 Sep 2025 02:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758016635; x=1758621435; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6HInf3vVICYvsjl1BbLw9IcLOL1iDFPRtoXvi2r6kSo=;
        b=XFttY3qfONc6twFzoKkXNnlvTgzQNuHo8XPeempqfiAyze55YG+MgpgwEGlZYBPFdF
         gpnvPURT+y6bI3JXJDrNk2YbyG2DHRJoyUVV6GAzlYsnpzbVTK0mndhnfuJOlxS3LZIY
         UhQY4X2Exo15xREI0Y5HTGWrHY+DDbd2oVRT3+94dFcIXPb8NUnQ8ue2jn+0Pp+UKMCi
         dm+b0OOYCm1MamZ4c3P0YQS0etb0Av44R1VuvXXZkhyGp6cQLoa/xkfV4F8sLx5lkVYZ
         /sdm42JvMqR3bBvWOAiKaPSFV0x/n5U+fQEtYIRQZJppdQRz9QtdZPCGqG7yHMuUzAR3
         nesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758016635; x=1758621435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HInf3vVICYvsjl1BbLw9IcLOL1iDFPRtoXvi2r6kSo=;
        b=i2sxK26hfCr9/yOeJAJ3C4iwlo9YLDMQYmeF8thRIc1z6yFPFmNn8OFU7xW+ZvKDAJ
         ckeYXxyXGl0pZNg7bgOYBIcRYtX/ifXmixNrO4AUGUKEQlEEHLtXy1AQHOUKGmOEaS+x
         8fm8RDQuLvfQSVA3OFIIztxXJinb8ykeGAiOOl05Ei1kxTz60E8RaFGGF4aCmDpjBXbh
         8wZbWI7CrW9XST4ztG9urtjuTwZ6XErvirk84nuXX64vuy1WpzMcSGKLpOkUJltOM8dL
         VkSFFxIw41rhH3FjIPC1RpicLRYempewzYbxvCaxaSlVVpK9fme65Pg8FikP0cUxfVqC
         8uRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrXBwnN/2jmd0wuydBWKU+W5A2icroJ13WUTl5PJJvaqkH0AdO91Lw1TNtn8aDYMOepPXj6Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YwmjDnxpRxcsXu42eMCL1eE96Efx6FLWhU6j/Mwjeau4J3WL2KW
	wMR+0SzmIfVwmRfEirzrIrx2EyGUjgxIObCUAss5ijawdKvlo/Dxhs9veK29MuF5Zas=
X-Gm-Gg: ASbGnctyCrvR+CZ8grXOItm0Dhueobl9EyU8E2PW7sQ8khSu1WLy+IH6tzq/acOF4hL
	v7Ki36rUNEF80AQfspe5QFlVB6YKN5gS4Db/+/oA6j1Ng+2nR/1M/RlsMq+mUBXtOqHhdaFH+MI
	g7JLWsueqQRwFIPPVXauqDc81CSSMuRcxWQ9fdHXhBVTBBViI2lwVhctyNHkqg40SrAPlS+Lg3p
	V2Onz+Cl0Uc9Ot+Fl8mWBxUDdJOn0CTq2iTsthsizKEtjj6YPvuJQ7J4adFTclNHZ0/OxVLhNWj
	Ko0xP1SOlK8ZMKU71uRl/TA4iDY4RpEmcYehyEVmRD+jMLYDa+zrCiYhbJfvmfOrWDoWAW+EAqX
	hp4l2huHxtNn/vXAJLxya23xhYwkQuj/861/KveNP
X-Google-Smtp-Source: AGHT+IHumhbFeoKijO1bIfbeRN7muXKT3iQrz7PNZcfL0Hw4Nuwk0HrRa1xVrQAwNjSiMUzT+ONYBQ==
X-Received: by 2002:a17:907:3e9e:b0:b04:5cca:9988 with SMTP id a640c23a62f3a-b07c38699ffmr1699588866b.43.1758016634556;
        Tue, 16 Sep 2025 02:57:14 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b31291b0sm1128497566b.34.2025.09.16.02.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 02:57:14 -0700 (PDT)
Date: Tue, 16 Sep 2025 11:57:11 +0200
From: Petr Mladek <pmladek@suse.com>
To: Jinchao Wang <wangjinchao600@gmail.com>
Subject: Re: [PATCH v2 1/9] panic: Introduce helper functions for panic state
Message-ID: <aMk0d5JO_4YECYGY@pathway.suse.cz>
References: <20250825022947.1596226-1-wangjinchao600@gmail.com>
 <20250825022947.1596226-2-wangjinchao600@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825022947.1596226-2-wangjinchao600@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250916_025717_236533_5C56278E 
X-CRM114-Status: GOOD (  32.98  )
X-Mailman-Approved-At: Tue, 16 Sep 2025 13:07:58 -0700
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
Cc: Sravan Kumar Gundu <sravankumarlpu@gmail.com>, linux-fbdev@vger.kernel.org, Kees Cook <kees@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, Yunhui Cui <cuiyunhui@bytedance.com>, Yicong Yang <yangyicong@hisilicon.com>, Zsolt Kajtar <soci@c64.rulez.org>, linux-hardening@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, Simona Vetter <simona@ffwll.ch>, Max Kellermann <max.kellermann@ionos.com>, John Ogness <john.ogness@linutronix.de>, Baoquan He <bhe@redhat.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Helge Deller <deller@gmx.de>, Joel Granados <joel.granados@kernel.org>, Thorsten Blum <thorsten.blum@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Nam Cao <namcao@linutronix.de>, Qianqiang Liu <qianqiang.liu@163.com>, Yury Norov <yury.norov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, dri-devel@lists.freedesktop.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Sohil Mehta <sohil.mehta@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Luo Gengkun <luogengkun@huaweicloud.com>, Feng Tang <feng.tang@linux.alibaba.com>, Shixiong Ou <oushixiong@kylinos.cn>, Anna Schumaker <anna.schumaker@oracle.com>, Tony Luck <tony.luck@intel.com>, Joel Fernandes <joelagnelf@nvidia.com>, kexec@lists.infradead.org, Douglas Anderson <dianders@chromium.org>, Li Huafei <lihuafei1@huawei.com>, linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon 2025-08-25 10:29:29, Jinchao Wang wrote:
> This patch introduces four new helper functions to abstract the
> management of the panic_cpu variable. These functions will be used in
> subsequent patches to refactor existing code.
> 
> The direct use of panic_cpu can be error-prone and ambiguous, as it
> requires manual checks to determine which CPU is handling the panic.
> The new helpers clarify intent:
> 
> panic_try_start():
> Atomically sets the current CPU as the panicking CPU.
> 
> panic_reset():
> Reset panic_cpu to PANIC_CPU_INVALID.
> 
> panic_in_progress():
> Checks if a panic has been triggered.
> 
> panic_on_this_cpu():
> Returns true if the current CPU is the panic originator.
> 
> panic_on_other_cpu():
> Returns true if a panic is on another CPU.
> 
> This change lays the groundwork for improved code readability
> and robustness in the panic handling subsystem.
> 
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> ---
>  include/linux/panic.h  |  6 +++++
>  kernel/panic.c         | 53 ++++++++++++++++++++++++++++++++++++++++++
>  kernel/printk/printk.c |  5 ----
>  3 files changed, 59 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/panic.h b/include/linux/panic.h
> index 7be742628c25..6f972a66c13e 100644
> --- a/include/linux/panic.h
> +++ b/include/linux/panic.h
> @@ -43,6 +43,12 @@ void abort(void);
>  extern atomic_t panic_cpu;
>  #define PANIC_CPU_INVALID	-1
>  
> +bool panic_try_start(void);
> +void panic_reset(void);
> +bool panic_in_progress(void);
> +bool panic_on_this_cpu(void);
> +bool panic_on_other_cpu(void);
> +
>  /*
>   * Only to be used by arch init code. If the user over-wrote the default
>   * CONFIG_PANIC_TIMEOUT, honor it.
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 72fcbb5a071b..eacb0c972110 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -294,6 +294,59 @@ void __weak crash_smp_send_stop(void)
>  
>  atomic_t panic_cpu = ATOMIC_INIT(PANIC_CPU_INVALID);
>  
> +bool panic_try_start(void)
> +{
> +	int old_cpu, this_cpu;
> +
> +	/*
> +	 * Only one CPU is allowed to execute the crash_kexec() code as with
> +	 * panic().  Otherwise parallel calls of panic() and crash_kexec()
> +	 * may stop each other.  To exclude them, we use panic_cpu here too.
> +	 */
> +	old_cpu = PANIC_CPU_INVALID;
> +	this_cpu = raw_smp_processor_id();
> +
> +	return atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu);
> +}
> +EXPORT_SYMBOL(panic_try_start);
> +
> +void panic_reset(void)
> +{
> +	atomic_set(&panic_cpu, PANIC_CPU_INVALID);
> +}
> +EXPORT_SYMBOL(panic_reset);
> +
> +bool panic_in_progress(void)
> +{
> +	return unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID);
> +}
> +EXPORT_SYMBOL(panic_in_progress);
> +
> +/* Return true if a panic is in progress on the current CPU. */
> +bool panic_on_this_cpu(void)
> +{
> +	/*
> +	 * We can use raw_smp_processor_id() here because it is impossible for
> +	 * the task to be migrated to the panic_cpu, or away from it. If
> +	 * panic_cpu has already been set, and we're not currently executing on
> +	 * that CPU, then we never will be.
> +	 */
> +	return unlikely(atomic_read(&panic_cpu) == raw_smp_processor_id());
> +}
> +EXPORT_SYMBOL(panic_on_this_cpu);
> +
> +/*
> + * Return true if a panic is in progress on a remote CPU.
> + *
> + * On true, the local CPU should immediately release any printing resources
> + * that may be needed by the panic CPU.
> + */
> +bool panic_on_other_cpu(void)
> +{
> +	return (panic_in_progress() && !this_cpu_in_panic());
> +}
> +EXPORT_SYMBOL(panic_on_other_cpu);
> +
>  /*
>   * A variant of panic() called from NMI context. We return if we've already
>   * panicked on this CPU. If another CPU already panicked, loop in
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 0efbcdda9aab..5fe35f377b79 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -345,11 +345,6 @@ static void __up_console_sem(unsigned long ip)
>  }
>  #define up_console_sem() __up_console_sem(_RET_IP_)
>  
> -static bool panic_in_progress(void)
> -{
> -	return unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID);
> -}
> -
>  /* Return true if a panic is in progress on the current CPU. */
>  bool this_cpu_in_panic(void)
>  {

All the functions are trivial. It would make sense to define
them in linux/panic.h. Then the callers would benefit
from the (unlikely) prediction macro...

It can be done in a followup path.

Otherwise, the patch looks good. I think that it is too late
but feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

