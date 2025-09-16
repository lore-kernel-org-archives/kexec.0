Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240C1CAC5A1
	for <kexec@archiver.kernel.org>; Tue, 16 Sep 2025 20:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To
	:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MZkAhMwtG05Nwx51W4BF/MbpYhaSp+19IYTVLsAUUIs=; b=3bvHhicCCGe2acHxxQCRlJnlH/
	QXO1Y8f46rZzH2qPdPC+lMTVblpe8ozGp+FNhY8yskZ+mEQrYZqB4VkeWVb4GFLsEww/nKMORLmn/
	5roYH+MpyIsgH3zrPnooFY5aDNyPnNz/0gttA9afqLmN9+fSP1oYXs04LzSSCyHPAeBwhCDru8eTO
	VRvWaTSjHf2XrMrnV67AT0kKkXjvcAyLMBPhisMyugqjF9LzaG0JCBVI48eR1JijobB38dk4J2nCv
	JdmTMox3RHt/udY9DX7qlQn9Sis5NB60Th/2lPu5uUHvy8U6Xd1kpJMu2wFdp5SwQwXPklDfhluWl
	OWmrUTKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uybyh-00000008xcG-1SzM;
	Tue, 16 Sep 2025 20:08:39 +0000
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyTjA-00000007eSe-3WOB
	for kexec@lists.infradead.org;
	Tue, 16 Sep 2025 11:20:06 +0000
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so802914766b.3
        for <kexec@lists.infradead.org>; Tue, 16 Sep 2025 04:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758021603; x=1758626403; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MZkAhMwtG05Nwx51W4BF/MbpYhaSp+19IYTVLsAUUIs=;
        b=f/o2kekNTIg6qBnG3uEDHAlU4K01k3QdEdtNyADnWPL46Or2sZS7j4wQmU85Zy0Swo
         xam82LI0ti8LaSeuvCv/YwDAGgc6o8kAg7r90trnMfScFAMrYQ5p/fLZhDdUHQ7mPDq/
         kwQv6a1WKkrcqbAsdbpAwWvYDfse/m6vPCza6ElW1cjt55E03gcmgP7Xdqbkkv9yjUvM
         Wm153UjkrDkk+sI5meT0ZfBApgjR1xIgXZUpHfcTGoKW8CasbDkDPo70wnNL45XC7IZ6
         Thi2a1rpU1+QJFUPXUK6dbdfWs/3ddKJKMjbBVIcJ2G8vcgt8KwyXvxkU2Bov73p2b0c
         Is6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758021603; x=1758626403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZkAhMwtG05Nwx51W4BF/MbpYhaSp+19IYTVLsAUUIs=;
        b=GbUIW7BSxdmG0aVpMrELXQnKpSvAOr0hJ0JGe21rXbAvXga16bujYQtRCXy1av0Mm8
         ZOdYLj2m3KdGxcTiFhDGRnO8WR2IhPqzYfd0ok7j5QuBZk+iGfqhNFFtqmvyfI8LQ+/z
         FlatwNEwvQCs47Q2bYS6Ni6pyLDouHiVPJgx9u1s1dmMcwSV7N9pT/kEuNiiqCOUt+nb
         8MW1AK14xVxWC1ZVwhMafcHAt4fGptPIpz3bPKfZ/t5sa/oCaUssO8KVN1nIPmm6BVK4
         +IcfVTSWDbhv6ALOvqZtfEh3iLROAW5OgoVtBHvHID72QnfLZmBT6rSbfSMGL3CBOvVF
         Hf0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVYeYKHTWqQN7Azd9u69xcf4PeTPdvKSifU+c7Dl6zqhAsKg6eMTA2w8DTNNEINNo1RORv4kg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwrbUIK68erz4RNTj96/anzxkRClInUktY3X4vZzRk2jK91iYQo
	i5aKcRDqE/YQB29ElzDeI3RMxOqzrHd1mpYCtJjCLRtWHvOEASKMVLPukxqg0d79l1g=
X-Gm-Gg: ASbGncs32/a6qde5bfQtLCMSCCR6gUPzORzWfIfMdlkczsIYAfWINyt1yvGQs99e42T
	vHtSNa2dY8JNIXq+JV0rfXoZw92xd/OrpRDtRnShCX3vv560ZzFpsHxbsbnbBPtFmb3mM0IQ1C2
	lR4X+mx0JR7RF0OLru3f8y5a+4KLQTVGFA4AWnoHzsqfNZttdZUtnbU60FbbgCpba+giYdeaN0A
	AvBSuk7JFMYWFmM7kb/3KGtxpFxPiPxkOPlDN+MJZ0XjVuR4Ozq2Ki5Y0ysjjFF53B08hgx5n3c
	pX92xHNwISTJs82cBTaghIqEVrgHE7arigcyCFJe1f6QcM/ZlJ4qjoLROyhoHh32GcWoeH795wQ
	9g/f4Pa8wV7Ng+em8bCmYBPOc2+76xjInKnww22zT
X-Google-Smtp-Source: AGHT+IGYOku1dWOd7XgyZFqiTBP3WC2b/azuNq9E2ePki1CNpOxLiy1c6JRukGNdqA80ZoAb+KYahA==
X-Received: by 2002:a17:906:c153:b0:b04:8c45:4bdb with SMTP id a640c23a62f3a-b07c37fb543mr1468835066b.34.1758021602813;
        Tue, 16 Sep 2025 04:20:02 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f3919e168sm4212344a12.34.2025.09.16.04.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 04:20:02 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:20:00 +0200
From: Petr Mladek <pmladek@suse.com>
To: Jinchao Wang <wangjinchao600@gmail.com>
Subject: Re: [PATCH v2 5/9] panic: use panic_try_start() in vpanic()
Message-ID: <aMlH4CcK_n1I1gY2@pathway.suse.cz>
References: <20250825022947.1596226-1-wangjinchao600@gmail.com>
 <20250825022947.1596226-6-wangjinchao600@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825022947.1596226-6-wangjinchao600@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250916_042004_903126_1EC56ED8 
X-CRM114-Status: GOOD (  17.41  )
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

On Mon 2025-08-25 10:29:33, Jinchao Wang wrote:
> vpanic() had open-coded logic to claim panic_cpu with atomic_try_cmpxchg.
> This is already handled by panic_try_start().
> 
> Switch to panic_try_start() and use panic_on_other_cpu() for the fallback
> path.
> 
> This removes duplicate code and makes panic handling consistent across
> functions.
> 
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -415,7 +415,6 @@ void vpanic(const char *fmt, va_list args)
>  	static char buf[1024];
>  	long i, i_next = 0, len;
>  	int state = 0;
> -	int old_cpu, this_cpu;
>  	bool _crash_kexec_post_notifiers = crash_kexec_post_notifiers;
>  
>  	if (panic_on_warn) {
> @@ -452,13 +451,10 @@ void vpanic(const char *fmt, va_list args)
>  	 * `old_cpu == this_cpu' means we came from nmi_panic() which sets
>  	 * panic_cpu to this CPU.  In this case, this is also the 1st CPU.
>  	 */

The above comment does not fit any longer. I think that it can
be removed, maybe except for the 1st paragraph.

> -	old_cpu = PANIC_CPU_INVALID;
> -	this_cpu = raw_smp_processor_id();
> -
>  	/* atomic_try_cmpxchg updates old_cpu on failure */

Also this comment should be removed.

> -	if (atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu)) {
> +	if (panic_try_start()) {
>  		/* go ahead */
> -	} else if (old_cpu != this_cpu)
> +	} else if (panic_on_other_cpu())
>  		panic_smp_self_stop();
>  
>  	console_verbose();

Otherwise, it looks good. And the comments might be removed
by a followup patch.

Best Regards,
Petr

