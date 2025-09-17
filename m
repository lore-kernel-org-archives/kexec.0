Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA1E8CA0EE8
	for <kexec@archiver.kernel.org>; Wed, 17 Sep 2025 12:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To
	:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ec0asGTrd8ayRRK4foZ3FyVP3qtZ9n13Tw5uWDKt8/4=; b=NonSWo2GSrq4BIdmaBEraiAuBV
	2QniwXe6RdbsrL3zBo0pyj2WV9hqktdIHosmZ3vwE1APpG7o/bYX5JMDvv1MNcD5v8GzzgZmQKOBm
	U7ucy9KBoJozuegVvHkl29nhCJFtbUrkDLroC2ogPD08FIBBQ6GU9s7tM9S11Yk7rGq4kbJ2iruH+
	BamcuDIw+fYxfYPSUk7lxGapGl5OjtzfZXPZ3EuqrwRVdhlCaaMNUvPFQw4aWltlAUlXsGJewB7md
	NSTRuz+aNrSuBDgIrHXVkk2ci7BDdmncNiWsOsQ2avOovm2GhRIFwShb4nAxzlOoFhwJy2U61867E
	s/2TpRKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyr6l-0000000BGyz-3osb;
	Wed, 17 Sep 2025 12:17:59 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyhbj-00000009uxf-3PFV
	for kexec@lists.infradead.org;
	Wed, 17 Sep 2025 02:09:21 +0000
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-32df1321879so3197868a91.2
        for <kexec@lists.infradead.org>; Tue, 16 Sep 2025 19:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758074959; x=1758679759; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ec0asGTrd8ayRRK4foZ3FyVP3qtZ9n13Tw5uWDKt8/4=;
        b=h5D071J7/vymF2Q+2ghCzfXqtZHrLRsHmYpRmBVXUMIA+NQXUYGXDU+7L0+857EShD
         x/Lv4/vyJJ72SJ1OXWz5ue/yT52gM5nd64wVNlPEetE0itqerLEuxDlODubppQGhFnRc
         k+Cb+3IU1Ms+6rZIeloLDhvk27UtGHlXpxa/lJHLffRbDXpVq0L/Uu9ypT+8vVdzWzkH
         GCuYsBLs+0ZGtoxcLMeA+5+iQ2WZW5zfCStWfNWnCDv/0poLD68E+MemE8xFKLZ4fav2
         QWz9CRI5Zo/suwlGFESbS5y+3sh0eKTwOwd1u/f5jBeWd28LU/S/EzkIPYSOkRjz+cn1
         zApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758074959; x=1758679759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ec0asGTrd8ayRRK4foZ3FyVP3qtZ9n13Tw5uWDKt8/4=;
        b=pqrD7FxPSP6Uh+xTjQtQZrvPjCL6pLNXZzV4WAHBuysCLZTse7HgRh9jgFiuiWBN+C
         lkuZ9QfYwoe3lnmPMjMTd0se3NJ8/1kw0tPMvQvzjfOObXyqNylHCU7jgMCb2yDNSQKf
         M+UQ0ax/E62aABpt30oDViBOO1d6IVHqVfJ/XZshPvlrC7Jll1PmfbjnOvgM4swH1UY+
         XmFYjwsfdc3/dzgvBk0ILnGferin8a4Ks0I0Y9w75vdkyXjF1zqZha5qPAdSYe016uxN
         vhRo6BzlwzR4+GLls2Pn+exSQv3Se4nJrAQX6rC+Br94K2DrEhEwf+8+NO/ozt5Empwh
         WVbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/0dJGVQacATCuIeponzjjzDyfbm4Ik6GwFtpy2d1dLO2od6PABs9W1cwHP1onv90wRL92KA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxZyqlFRrd58nbLUUIQH8x1SKT3aAZt9N4ndRpitlhYDIreTpe8
	ZOy9/kNjAuKql1RqArufsUToW0XQ9Hfa+cg90rEkXi0nc24wziqOQdjJ
X-Gm-Gg: ASbGncuBAu8/sX50aIS1KTBGYcQ4MFdFra6xxSM/0dgV4ZAF+nXpMCb8x9Za2oCcQ5Q
	a8rTk7g2sD2/Z8l83SHuzLrop0l5vTZUXTA2esun/9cacpSW0yQQpE3zjPkxF8g66M5mHvPwX1I
	EtqAijJN3HueGQHFjQxADTDrCAbHnTMCQX9sFeDN8GzTRf0Htgf9bLxzfMWxJd5u4BANzuIb1s/
	CYwmGPg7fWQ5aqAWp2TDjriMHZvM8RvK8ybSZMqB/2QmdN3sWxnblv56zlu97aloo18MpsM5ap4
	FNHAaME019bQ/FfTeb8ZH6XJ649BRmLG1ICzZ5FL3FzDUBI/VjUTlx/YO275lNqcRLByhGViAlg
	OLU/NIHx6Hy7i93hUO2PZ+ZnyjfUUW0THokZS+By5
X-Google-Smtp-Source: AGHT+IGE1lxlxAvcVFpWcXZnKgkQRp7XPS1CVNzz6zy0okJvDf1X7FhTYPGTQTnkoTiUrMzQO5PECQ==
X-Received: by 2002:a17:90b:4a41:b0:32e:3686:830e with SMTP id 98e67ed59e1d1-32ee3f60244mr511848a91.23.1758074958707;
        Tue, 16 Sep 2025 19:09:18 -0700 (PDT)
Received: from localhost ([146.19.163.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed275fb3csm862045a91.20.2025.09.16.19.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 19:09:18 -0700 (PDT)
Date: Wed, 17 Sep 2025 10:09:12 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2 1/9] panic: Introduce helper functions for panic state
Message-ID: <aMoYSElAEBiBvVET@mdev>
References: <20250825022947.1596226-1-wangjinchao600@gmail.com>
 <20250825022947.1596226-2-wangjinchao600@gmail.com>
 <aMk0d5JO_4YECYGY@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMk0d5JO_4YECYGY@pathway.suse.cz>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250916_190919_859961_E289A40E 
X-CRM114-Status: GOOD (  38.98  )
X-Mailman-Approved-At: Wed, 17 Sep 2025 05:17:58 -0700
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

On Tue, Sep 16, 2025 at 11:57:11AM +0200, Petr Mladek wrote:
> On Mon 2025-08-25 10:29:29, Jinchao Wang wrote:
> > This patch introduces four new helper functions to abstract the
> > management of the panic_cpu variable. These functions will be used in
> > subsequent patches to refactor existing code.
> > 
> > The direct use of panic_cpu can be error-prone and ambiguous, as it
> > requires manual checks to determine which CPU is handling the panic.
> > The new helpers clarify intent:
> > 
> > panic_try_start():
> > Atomically sets the current CPU as the panicking CPU.
> > 
> > panic_reset():
> > Reset panic_cpu to PANIC_CPU_INVALID.
> > 
> > panic_in_progress():
> > Checks if a panic has been triggered.
> > 
> > panic_on_this_cpu():
> > Returns true if the current CPU is the panic originator.
> > 
> > panic_on_other_cpu():
> > Returns true if a panic is on another CPU.
> > 
> > This change lays the groundwork for improved code readability
> > and robustness in the panic handling subsystem.
> > 
> > Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> > ---
> >  include/linux/panic.h  |  6 +++++
> >  kernel/panic.c         | 53 ++++++++++++++++++++++++++++++++++++++++++
> >  kernel/printk/printk.c |  5 ----
> >  3 files changed, 59 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/linux/panic.h b/include/linux/panic.h
> > index 7be742628c25..6f972a66c13e 100644
> > --- a/include/linux/panic.h
> > +++ b/include/linux/panic.h
> > @@ -43,6 +43,12 @@ void abort(void);
> >  extern atomic_t panic_cpu;
> >  #define PANIC_CPU_INVALID	-1
> >  
> > +bool panic_try_start(void);
> > +void panic_reset(void);
> > +bool panic_in_progress(void);
> > +bool panic_on_this_cpu(void);
> > +bool panic_on_other_cpu(void);
> > +
> >  /*
> >   * Only to be used by arch init code. If the user over-wrote the default
> >   * CONFIG_PANIC_TIMEOUT, honor it.
> > diff --git a/kernel/panic.c b/kernel/panic.c
> > index 72fcbb5a071b..eacb0c972110 100644
> > --- a/kernel/panic.c
> > +++ b/kernel/panic.c
> > @@ -294,6 +294,59 @@ void __weak crash_smp_send_stop(void)
> >  
> >  atomic_t panic_cpu = ATOMIC_INIT(PANIC_CPU_INVALID);
> >  
> > +bool panic_try_start(void)
> > +{
> > +	int old_cpu, this_cpu;
> > +
> > +	/*
> > +	 * Only one CPU is allowed to execute the crash_kexec() code as with
> > +	 * panic().  Otherwise parallel calls of panic() and crash_kexec()
> > +	 * may stop each other.  To exclude them, we use panic_cpu here too.
> > +	 */
> > +	old_cpu = PANIC_CPU_INVALID;
> > +	this_cpu = raw_smp_processor_id();
> > +
> > +	return atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu);
> > +}
> > +EXPORT_SYMBOL(panic_try_start);
> > +
> > +void panic_reset(void)
> > +{
> > +	atomic_set(&panic_cpu, PANIC_CPU_INVALID);
> > +}
> > +EXPORT_SYMBOL(panic_reset);
> > +
> > +bool panic_in_progress(void)
> > +{
> > +	return unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID);
> > +}
> > +EXPORT_SYMBOL(panic_in_progress);
> > +
> > +/* Return true if a panic is in progress on the current CPU. */
> > +bool panic_on_this_cpu(void)
> > +{
> > +	/*
> > +	 * We can use raw_smp_processor_id() here because it is impossible for
> > +	 * the task to be migrated to the panic_cpu, or away from it. If
> > +	 * panic_cpu has already been set, and we're not currently executing on
> > +	 * that CPU, then we never will be.
> > +	 */
> > +	return unlikely(atomic_read(&panic_cpu) == raw_smp_processor_id());
> > +}
> > +EXPORT_SYMBOL(panic_on_this_cpu);
> > +
> > +/*
> > + * Return true if a panic is in progress on a remote CPU.
> > + *
> > + * On true, the local CPU should immediately release any printing resources
> > + * that may be needed by the panic CPU.
> > + */
> > +bool panic_on_other_cpu(void)
> > +{
> > +	return (panic_in_progress() && !this_cpu_in_panic());
> > +}
> > +EXPORT_SYMBOL(panic_on_other_cpu);
> > +
> >  /*
> >   * A variant of panic() called from NMI context. We return if we've already
> >   * panicked on this CPU. If another CPU already panicked, loop in
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index 0efbcdda9aab..5fe35f377b79 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -345,11 +345,6 @@ static void __up_console_sem(unsigned long ip)
> >  }
> >  #define up_console_sem() __up_console_sem(_RET_IP_)
> >  
> > -static bool panic_in_progress(void)
> > -{
> > -	return unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID);
> > -}
> > -
> >  /* Return true if a panic is in progress on the current CPU. */
> >  bool this_cpu_in_panic(void)
> >  {
> 
> All the functions are trivial. It would make sense to define
> them in linux/panic.h. Then the callers would benefit
> from the (unlikely) prediction macro...
> 
> It can be done in a followup path.
Thanks for feedback, I will do it later.

BTW, this series was merged to -mm branch already.

> 
> Otherwise, the patch looks good. I think that it is too late
> but feel free to use:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> Best Regards,
> Petr

-- 
Jinchao

