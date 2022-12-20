Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588F9C4332F
	for <kexec@archiver.kernel.org>; Tue, 20 Dec 2022 22:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rUiyFRMPT280r2eFAIL+LQKKIvpQSN35CSslPTy9LK0=; b=I3qxQNxIEbb+bm
	bZXHvvx3SWubbIPwiNiNOd4IbehN963MqpPi2umcERo98uOGAi+zp2E3+9qk2ynGttmWTieowUu9C
	ZtXu2CRb6qyM2QcZIa+IVoIID1jdOsG9kWwW2JUIFj07imZhFQF2IBMZNPbN8WFk2RPw6eX+tDakO
	7uGa9gXGXcDEt8qWJo4hbryNxWoDH8KDoBy6UD82/6stAxRNmlUod0fuPC9kZewEZyUDzBjsnS3ZX
	fIaQq8S66YJIXea2/Yvjckd8kVHOXGAclK8Gih/ik4k/OeST2yZwU4yP62gKoHchpM53vJtATJA9O
	RLRmo8VSMQlvzKa1KZJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7kjq-004q4R-Uy; Tue, 20 Dec 2022 22:05:30 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7kjl-004pya-55
	for kexec@lists.infradead.org; Tue, 20 Dec 2022 22:05:28 +0000
Received: by mail-pg1-x52c.google.com with SMTP id 82so9273101pgc.0
        for <kexec@lists.infradead.org>; Tue, 20 Dec 2022 14:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PRpBF4WUTe6XJVKrBhj4slZ23pvvv60iZTqKL7C+vCc=;
        b=HILcmf/mOJVag0pFwnctJu207LwnaL0jul6xVAevkxXSp0ghJ8Iy1di/aa3UThJZaQ
         cRSdSBSxSH/9D4Ri3bB8QfzOYfv11sxHoVKBSxhFvfaSSZ+3d8prsGmz/d8ZAEGgnL9b
         RqSQ8+VAdfVEHwH6pwga2rjRt887pqodgsUkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PRpBF4WUTe6XJVKrBhj4slZ23pvvv60iZTqKL7C+vCc=;
        b=x1Xu7hdlF+jxzxsoa5/fzCYZMbrH761s6UO0F/GArM99ngwjvnfraAbwyEXx5v6ZbM
         Rnuv13yTdc8RBBV1Wh2a7If4DERLvMfgwNNAjjDWZT2jfJwRj3SudVN/YC5LyZXxPeAg
         MhxT9PQY/kMdcIrOpg3Twuwoa0Xn5WwMN1uYU6O6U5Peksezm76QLs5JA9rtKUIoOl6r
         WLOeaPDuFre2eQOPpsEVOVWad4ietE9ywbokBTKbxIMWzZ7WdKdjNOgjOdaGRe7tMmN/
         yyo+U4cCL5YJIurnOm5DiHbXlPJkaP3z8NQ+q6OqbW13Q13x/UI8kZY1yV9ImLwGsFwF
         vdww==
X-Gm-Message-State: ANoB5pnRkK33uSzinqu6Jym+uRIfpGJyhwDcHzvC/tRCvyKkGhxRhQtA
	WqzENdpfdRuFAqiciMPxxt55RGFN+Wiy/2z0/Gk=
X-Google-Smtp-Source: AA0mqf6mE8mpCOyI082JRm9UFMNDU4Pxc1kpnDriDaNAO4G2eNAdp0Gc0Tqax9OqzUoQkywQP19myA==
X-Received: by 2002:a62:198a:0:b0:56b:3758:a2d9 with SMTP id 132-20020a62198a000000b0056b3758a2d9mr45663250pfz.21.1671573922003;
        Tue, 20 Dec 2022 14:05:22 -0800 (PST)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com. [209.85.210.180])
        by smtp.gmail.com with ESMTPSA id u66-20020a626045000000b005771f5ea2ebsm9084691pfb.135.2022.12.20.14.05.21
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 14:05:21 -0800 (PST)
Received: by mail-pf1-f180.google.com with SMTP id 65so9425187pfx.9
        for <kexec@lists.infradead.org>; Tue, 20 Dec 2022 14:05:21 -0800 (PST)
X-Received: by 2002:a63:1b44:0:b0:48c:8cc5:1b73 with SMTP id
 b4-20020a631b44000000b0048c8cc51b73mr564369pgm.520.1671573920530; Tue, 20 Dec
 2022 14:05:20 -0800 (PST)
MIME-Version: 1.0
References: <20221114-disable-kexec-reset-v2-0-c498313c1bb5@chromium.org>
 <20221114-disable-kexec-reset-v2-3-c498313c1bb5@chromium.org> <Y5tylKOaIO8Df8pu@google.com>
In-Reply-To: <Y5tylKOaIO8Df8pu@google.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 20 Dec 2022 23:05:09 +0100
X-Gmail-Original-Message-ID: <CANiDSCs8O5H0WbEMGEg6Q_JOz_hNWyXu5WuXzG5NSgwrGC=1Ow@mail.gmail.com>
Message-ID: <CANiDSCs8O5H0WbEMGEg6Q_JOz_hNWyXu5WuXzG5NSgwrGC=1Ow@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] kexec: Introduce paramters load_limit_reboot and load_limit_panic
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Philipp Rudo <prudo@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, kexec@lists.infradead.org, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Ross Zwisler <zwisler@kernel.org>, 
	linux-kernel@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221220_140525_261846_51F2A93C 
X-CRM114-Status: GOOD (  39.38  )
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

Hi Joel

Thanks for looking into this

On Thu, 15 Dec 2022 at 20:16, Joel Fernandes <joel@joelfernandes.org> wrote:
>
> Hi Ricardo,
>
> On Thu, Dec 08, 2022 at 05:38:02PM +0100, Ricardo Ribalda wrote:
> > Add two parameter to specify how many times a kexec kernel can be loaded.
> >
> > The sysadmin can set different limits for kexec panic and kexec reboot
> > kernels.
> >
> > The value can be modified at runtime via sysfs, but only with a value
> > smaller than the current one (except -1).
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt | 14 ++++
> >  include/linux/kexec.h                           |  2 +-
> >  kernel/kexec.c                                  |  2 +-
> >  kernel/kexec_core.c                             | 91 ++++++++++++++++++++++++-
> >  kernel/kexec_file.c                             |  2 +-
> >  5 files changed, 106 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 42af9ca0127e..2b37d6a20747 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -2374,6 +2374,20 @@
> >                       for Movable pages.  "nn[KMGTPE]", "nn%", and "mirror"
> >                       are exclusive, so you cannot specify multiple forms.
> >
> > +     kexec_core.load_limit_reboot=
> > +     kexec_core.load_limit_panic=
> > +                     [KNL]
> > +                     This parameter specifies a limit to the number of times
> > +                     a kexec kernel can be loaded.
> > +                     Format: <int>
> > +                     -1  = Unlimited.
> > +                     int = Number of times kexec can be called.
> > +
> > +                     During runtime, this parameter can be modified with a
> > +                     value smaller than the current one (but not -1).
> > +
> > +                     Default: -1
> > +
> >       kgdbdbgp=       [KGDB,HW] kgdb over EHCI usb debug port.
> >                       Format: <Controller#>[,poll interval]
> >                       The controller # is the number of the ehci usb debug
> > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > index e9e1ab5e8006..3d7d10f7187a 100644
> > --- a/include/linux/kexec.h
> > +++ b/include/linux/kexec.h
> > @@ -407,7 +407,7 @@ extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
> >  extern struct kimage *kexec_image;
> >  extern struct kimage *kexec_crash_image;
> >
> > -bool kexec_load_permited(void);
> > +bool kexec_load_permited(bool crash_image);
> >
> >  #ifndef kexec_flush_icache_page
> >  #define kexec_flush_icache_page(page)
> > diff --git a/kernel/kexec.c b/kernel/kexec.c
> > index d83fc9093aff..2b0856e83fe1 100644
> > --- a/kernel/kexec.c
> > +++ b/kernel/kexec.c
> > @@ -193,7 +193,7 @@ static inline int kexec_load_check(unsigned long nr_segments,
> >       int result;
> >
> >       /* We only trust the superuser with rebooting the system. */
> > -     if (!kexec_load_permited())
> > +     if (!kexec_load_permited(flags & KEXEC_ON_CRASH))
>
> nit: permitted.
>
> >               return -EPERM;
> >
> >       /* Permit LSMs and IMA to fail the kexec */
> > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > index 18bd90ca9c99..7f9d5288b24b 100644
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -952,13 +952,100 @@ static int __init kexec_core_sysctl_init(void)
> >  late_initcall(kexec_core_sysctl_init);
> >  #endif
> >
> > -bool kexec_load_permited(void)
> > +struct kexec_load_limit {
> > +     /* Mutex protects the limit count. */
> > +     struct mutex mutex;
> > +     int limit;
>
> Can you not just use atomic ops for limit, and get rid of the mutex?
>
> That will simplify the code as well.

I could not find a way to use atomic_t. The operations are not just
counters, but maybe I am missing a better way to do it :)

The current operations:

- permitted():

if (param==-1) {
  return -1;
}
if (param =0)
 return -1;
param = param -1;



- paramter_set()

new_param = min(-1, new_param);

if (param == -1) {
   param = new_param;
   return
}

if (new_param == -1) {
   return -EINVAL;
}

param = min(new_param, param);

>
> > +};
> > +
> > +struct kexec_load_limit load_limit_reboot = {
> > +     .mutex = __MUTEX_INITIALIZER(load_limit_reboot.mutex),
> > +     .limit = -1,
> > +};
> > +
> > +struct kexec_load_limit load_limit_panic = {
> > +     .mutex = __MUTEX_INITIALIZER(load_limit_panic.mutex),
> > +     .limit = -1,
> > +};
> > +
> > +static int param_get_limit(char *buffer, const struct kernel_param *kp)
> >  {
> > +     int ret;
> > +     struct kexec_load_limit *limit = kp->arg;
> > +
> > +     mutex_lock(&limit->mutex);
> > +     ret = scnprintf(buffer, PAGE_SIZE, "%i\n", limit->limit);
> > +     mutex_unlock(&limit->mutex);
> > +
> > +     return ret;
> > +}
> > +
> > +static int param_set_limit(const char *buffer, const struct kernel_param *kp)
> > +{
> > +     int ret;
> > +     struct kexec_load_limit *limit = kp->arg;
> > +     int new_val;
> > +
> > +     ret = kstrtoint(buffer, 0, &new_val);
> > +     if (ret)
> > +             return ret;
> > +
> > +     new_val = max(-1, new_val);
> > +
> > +     mutex_lock(&limit->mutex);
> > +
> > +     if (new_val == -1 && limit->limit != -1) {
> > +             ret = -EINVAL;
> > +             goto done;
> > +     }
> > +
> > +     if (limit->limit != -1 && new_val > limit->limit) {
> > +             ret = -EINVAL;
> > +             goto done;
> > +     }
> > +
> > +     limit->limit = new_val;
> > +
> > +done:
> > +     mutex_unlock(&limit->mutex);
> > +
> > +     return ret;
> > +}
> > +
> > +static const struct kernel_param_ops load_limit_ops = {
> > +     .get = param_get_limit,
> > +     .set = param_set_limit,
> > +};
> > +
> > +module_param_cb(load_limit_reboot, &load_limit_ops, &load_limit_reboot, 0644);
> > +MODULE_PARM_DESC(load_limit_reboot, "Maximum attempts to load a kexec reboot kernel");
> > +
> > +module_param_cb(load_limit_panic, &load_limit_ops, &load_limit_panic, 0644);
> > +MODULE_PARM_DESC(load_limit_reboot, "Maximum attempts to load a kexec panic kernel");
> > +
> > +bool kexec_load_permited(bool crash_image)
>
> nit: permitted.
>
> > +{
> > +     struct kexec_load_limit *limit;
> > +
> >       /*
> >        * Only the superuser can use the kexec syscall and if it has not
> >        * been disabled.
> >        */
> > -     return capable(CAP_SYS_BOOT) && !kexec_load_disabled;
> > +     if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
> > +             return false;
> > +
> > +     /* Check limit counter and decrease it.*/
> > +     limit = crash_image ? &load_limit_panic : &load_limit_reboot;
> > +     mutex_lock(&limit->mutex);
> > +     if (!limit->limit) {
> > +             mutex_unlock(&limit->mutex);
> > +             return false;
> > +     }
> > +     if (limit->limit != -1)
> > +             limit->limit--;
> > +     mutex_unlock(&limit->mutex);
> > +
> > +     return true;
>
> IMO, patch 2/3 can be squashed with 3/3 but no strong preference.
>
> thanks,
>
>  - Joel
>
>
>
> >  }
> >
> >  /*
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index 701147c118d4..61212a9252a6 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -330,7 +330,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> >       struct kimage **dest_image, *image;
> >
> >       /* We only trust the superuser with rebooting the system. */
> > -     if (!kexec_load_permited())
> > +     if (!kexec_load_permited(flags & KEXEC_FILE_FLAGS))
> >               return -EPERM;
> >
> >       /* Make sure we have a legal set of flags */
> >
> > --
> > 2.39.0.rc0.267.gcb52ba06e7-goog-b4-0.11.0-dev-696ae



-- 
Ricardo Ribalda

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
