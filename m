Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477B5C352A1
	for <kexec@archiver.kernel.org>; Tue,  6 Dec 2022 14:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y2YxCFdHHu9q4TJVlldvVqzpGegj3CsHiYzRAVSpsGU=; b=xroLTJsQvZPYSn
	IHgEuga2BOuFfGljdJoXsfP+JB+beqHDtJJEvKFOZnBZzYJk3IhTfvwT0DF8DSK6ZGB92Xj8ck+G9
	rZEK3jJeR70vScBmGnl0KIqkr9DpLVSbaD46l0MeQvqn6fImVEucVvFi8T/fR+PfdnlpDPn7WmSTd
	KNWTooPFawFBNTNHfkEYaJYEvXmd32+OxUDboR9kQ/jPAyo+utZmIOzvzb2oBxMp0bAbkTXzcvDUN
	DZjSVNM/e7hVtViCznUuybyLgpYCqSbnIhTJfKsiffNW2TodjlshxN3xssZYqogvXzrDuqFndFUIg
	l4pVdoQJuOHzV8wGiRXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Yk8-00APoP-6U; Tue, 06 Dec 2022 14:16:20 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2AEP-002KuF-UM
	for kexec@lists.infradead.org; Mon, 05 Dec 2022 12:05:59 +0000
Received: by mail-pj1-x1035.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so14613445pjp.1
        for <kexec@lists.infradead.org>; Mon, 05 Dec 2022 04:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=je642uC/QM2q2uiJ455cWQgJTQZ2s2VIKEuHkYSqLSY=;
        b=FEmiEyAfYIdpKkVVrcM2myJBq9Gd26hAz6+4yOpADnvfMVE0aPesCBgx342rXF08lp
         TCQyXF8GkzmtS6Z9YrWkolPOItK1xsEU+96tzXEDb1AlyAmzgDCo23jDO4Kl30xB1XIr
         tkvIYPgXOQR4RxorORzC5LorpFYswRYs8vLVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=je642uC/QM2q2uiJ455cWQgJTQZ2s2VIKEuHkYSqLSY=;
        b=eNZ+Yw5CSG+XvQD3vKf1N1JQjKRpayMjBqFq80vPwNneCXUO8vvDudGaZDqtk1fezB
         nT3Zt0nJAGt4pIT3VxP47b6DBfeBQNtteXC33p5YLMZLhF+P/CzQ8FljYfflBjF+EIk4
         mhQvZpzP5stl0evkfDl/ivQOPOURL/CunKU0WP9bhlL3e0fHGtHwzoZOl4fyTrRfGZRn
         A229bAdrb9ffKIitYeLVNGZGOLu1aynQ7rioBwHPHA15PJrSyFVCoBz/4E09fPYCyU1Z
         cGdboGPCWregryefogVou6SUEnFlyUAwDbtrUK47MOrJiFQn7Tt1UeiKtRsPbvIG1lkX
         kk7g==
X-Gm-Message-State: ANoB5plgUYGngePOj76khV55jSzyFz53JEgy7OK7p/ZZ8lkP2NM6HTX8
	CtqtXKToaGULU+0TNS8XlyYZyeI6oQQQ+Oge
X-Google-Smtp-Source: AA0mqf5Ib7Cz7VeEIcFwS52gn+cehSCbNeJMU1Km6G5NEGzXjUqS0ajpwRon6ppv7qPHavdeF2j5DA==
X-Received: by 2002:a17:903:41c3:b0:189:a5b9:4838 with SMTP id u3-20020a17090341c300b00189a5b94838mr27369863ple.104.1670241952293;
        Mon, 05 Dec 2022 04:05:52 -0800 (PST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com. [209.85.216.47])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090adb0200b0020ad53b5883sm9170099pjv.14.2022.12.05.04.05.51
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 04:05:52 -0800 (PST)
Received: by mail-pj1-f47.google.com with SMTP id k88-20020a17090a4ce100b00219d0b857bcso2610906pjh.1
        for <kexec@lists.infradead.org>; Mon, 05 Dec 2022 04:05:51 -0800 (PST)
X-Received: by 2002:a17:902:7d93:b0:186:9cf4:e53b with SMTP id
 a19-20020a1709027d9300b001869cf4e53bmr68703080plm.50.1670241940337; Mon, 05
 Dec 2022 04:05:40 -0800 (PST)
MIME-Version: 1.0
References: <20221127-snd-freeze-v8-0-3bc02d09f2ce@chromium.org>
 <20221127-snd-freeze-v8-2-3bc02d09f2ce@chromium.org> <CAJZ5v0jbKSTQopEoXW9FpqDmAqp6Pn=-Om5QP2-7ocuGdq8R9w@mail.gmail.com>
In-Reply-To: <CAJZ5v0jbKSTQopEoXW9FpqDmAqp6Pn=-Om5QP2-7ocuGdq8R9w@mail.gmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 5 Dec 2022 13:05:29 +0100
X-Gmail-Original-Message-ID: <CANiDSCt2+2EQpXvgQqTA3VwbfwDb=BsXn_YNcc05GK9xdTpVkA@mail.gmail.com>
Message-ID: <CANiDSCt2+2EQpXvgQqTA3VwbfwDb=BsXn_YNcc05GK9xdTpVkA@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] freezer: refactor pm_freezing into a function.
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Juergen Gross <jgross@suse.com>, Mark Brown <broonie@kernel.org>, 
	Chromeos Kdump <chromeos-kdump@google.com>, Daniel Baluta <daniel.baluta@nxp.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Len Brown <len.brown@intel.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Eric Biederman <ebiederm@xmission.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Jaroslav Kysela <perex@perex.cz>, 
	Joel Fernandes <joel@joelfernandes.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, Pavel Machek <pavel@ucw.cz>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, Steven Rostedt <rostedt@goodmis.org>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Ingo Molnar <mingo@redhat.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Dexuan Cui <decui@microsoft.com>, Takashi Iwai <tiwai@suse.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Bard Liao <yung-chuan.liao@linux.intel.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	kexec@lists.infradead.org, alsa-devel@alsa-project.org, 
	stable@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	xen-devel@lists.xenproject.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221205_040558_019101_41844B61 
X-CRM114-Status: GOOD (  40.48  )
X-Mailman-Approved-At: Tue, 06 Dec 2022 06:16:19 -0800
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

Hi Rafael

On Fri, 2 Dec 2022 at 18:48, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Dec 1, 2022 at 12:08 PM Ricardo Ribalda <ribalda@chromium.org> wrote:
> >
> > Add a way to let the drivers know if the processes are frozen.
> >
> > This is needed by drivers that are waiting for processes to end on their
> > shutdown path.
> >
> > Convert pm_freezing into a function and export it, so it can be used by
> > drivers that are either built-in or modules.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 83bfc7e793b5 ("ASoC: SOF: core: unregister clients and machine drivers in .shutdown")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> Why can't you export the original pm_freezing variable and why is this
> fixing anything?

Because then any module will be able to modify the content of the variable.

The Fixes: is because the last patch on the set is doing a real fix.
If you only cherry-pick the last patch on a stable branch, the build
will fail. (Also, the zero-day builder complains)

Anyway, I think we can hold this patch for a bit. The snd people are
discussing if this the way to handle it, or if we should handle
.shutdown in a different way.

Thanks!


>
> > ---
> >  include/linux/freezer.h |  3 ++-
> >  kernel/freezer.c        |  3 +--
> >  kernel/power/process.c  | 24 ++++++++++++++++++++----
> >  3 files changed, 23 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/linux/freezer.h b/include/linux/freezer.h
> > index b303472255be..3413c869d68b 100644
> > --- a/include/linux/freezer.h
> > +++ b/include/linux/freezer.h
> > @@ -13,7 +13,7 @@
> >  #ifdef CONFIG_FREEZER
> >  DECLARE_STATIC_KEY_FALSE(freezer_active);
> >
> > -extern bool pm_freezing;               /* PM freezing in effect */
> > +bool pm_freezing(void);
> >  extern bool pm_nosig_freezing;         /* PM nosig freezing in effect */
> >
> >  /*
> > @@ -80,6 +80,7 @@ static inline int freeze_processes(void) { return -ENOSYS; }
> >  static inline int freeze_kernel_threads(void) { return -ENOSYS; }
> >  static inline void thaw_processes(void) {}
> >  static inline void thaw_kernel_threads(void) {}
> > +static inline bool pm_freezing(void) { return false; }
> >
> >  static inline bool try_to_freeze(void) { return false; }
> >
> > diff --git a/kernel/freezer.c b/kernel/freezer.c
> > index 4fad0e6fca64..2d3530ebdb7e 100644
> > --- a/kernel/freezer.c
> > +++ b/kernel/freezer.c
> > @@ -20,7 +20,6 @@ EXPORT_SYMBOL(freezer_active);
> >   * indicate whether PM freezing is in effect, protected by
> >   * system_transition_mutex
> >   */
> > -bool pm_freezing;
> >  bool pm_nosig_freezing;
> >
> >  /* protects freezing and frozen transitions */
> > @@ -46,7 +45,7 @@ bool freezing_slow_path(struct task_struct *p)
> >         if (pm_nosig_freezing || cgroup_freezing(p))
> >                 return true;
> >
> > -       if (pm_freezing && !(p->flags & PF_KTHREAD))
> > +       if (pm_freezing() && !(p->flags & PF_KTHREAD))
> >                 return true;
> >
> >         return false;
> > diff --git a/kernel/power/process.c b/kernel/power/process.c
> > index ddd9988327fe..8a4d0e2c8c20 100644
> > --- a/kernel/power/process.c
> > +++ b/kernel/power/process.c
> > @@ -108,6 +108,22 @@ static int try_to_freeze_tasks(bool user_only)
> >         return todo ? -EBUSY : 0;
> >  }
> >
> > +/*
> > + * Indicate whether PM freezing is in effect, protected by
> > + * system_transition_mutex.
> > + */
> > +static bool pm_freezing_internal;
> > +
> > +/**
> > + * pm_freezing - indicate whether PM freezing is in effect.
> > + *
> > + */
> > +bool pm_freezing(void)
> > +{
> > +       return pm_freezing_internal;
> > +}
> > +EXPORT_SYMBOL(pm_freezing);
>
> Use EXPORT_SYMBOL_GPL() instead, please.
>
> > +
> >  /**
> >   * freeze_processes - Signal user space processes to enter the refrigerator.
> >   * The current thread will not be frozen.  The same process that calls
> > @@ -126,12 +142,12 @@ int freeze_processes(void)
> >         /* Make sure this task doesn't get frozen */
> >         current->flags |= PF_SUSPEND_TASK;
> >
> > -       if (!pm_freezing)
> > +       if (!pm_freezing())
> >                 static_branch_inc(&freezer_active);
> >
> >         pm_wakeup_clear(0);
> >         pr_info("Freezing user space processes ... ");
> > -       pm_freezing = true;
> > +       pm_freezing_internal = true;
> >         error = try_to_freeze_tasks(true);
> >         if (!error) {
> >                 __usermodehelper_set_disable_depth(UMH_DISABLED);
> > @@ -187,9 +203,9 @@ void thaw_processes(void)
> >         struct task_struct *curr = current;
> >
> >         trace_suspend_resume(TPS("thaw_processes"), 0, true);
> > -       if (pm_freezing)
> > +       if (pm_freezing())
> >                 static_branch_dec(&freezer_active);
> > -       pm_freezing = false;
> > +       pm_freezing_internal = false;
> >         pm_nosig_freezing = false;
> >
> >         oom_killer_enable();
> >
> > --
>
> --
> You received this message because you are subscribed to the Google Groups "Chromeos Kdump" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to chromeos-kdump+unsubscribe@google.com.
> To view this discussion on the web, visit https://groups.google.com/a/google.com/d/msgid/chromeos-kdump/CAJZ5v0jbKSTQopEoXW9FpqDmAqp6Pn%3D-Om5QP2-7ocuGdq8R9w%40mail.gmail.com.



--
Ricardo Ribalda

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
