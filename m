Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90AF2C4332F
	for <kexec@archiver.kernel.org>; Sun,  4 Dec 2022 09:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sbd+TGHhcoIqqrw9YNuacw1eT8sY61kvPYca/rd2Ugc=; b=LmgEdMHx61hSfI
	jkvtaeVEBqeqPBm1gpoCgnbzlEyGwDBS3HNWfSTjmPW2+lBCIP+ms6NurD2ui3YPInzBFYbnCoYjH
	6AfCFS4k6QyE1JHAG6r4mB69OMg0WA7Ps0uyz0iV9p9ItU8kU/TFFDfLP9gnak4YlESCtH1r5RZhR
	xRw7gSxwRz4EVygV1D5b3F19uP6Uu10tCuwnJRgi3aK+EiXa/8OdUUi6VNcwXvE99447m5QMR91Hf
	gIoJ7ENtwBCxGvXBKRwGtKd+IXRrmKxngIbNMlEKSRyYjn0/0PwCide2vFe4nt0Spkn1qeHd5VceB
	DjxNWoBsAwOri62UwSog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p1lLp-007Bcm-1g; Sun, 04 Dec 2022 09:31:57 +0000
Received: from mail-qt1-f175.google.com ([209.85.160.175])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p1A8m-000REH-46
	for kexec@lists.infradead.org; Fri, 02 Dec 2022 17:48:01 +0000
Received: by mail-qt1-f175.google.com with SMTP id r19so6178796qtx.6
        for <kexec@lists.infradead.org>; Fri, 02 Dec 2022 09:47:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZkrcSltncE8/ZuZoYv4b2d7hscDOxyl0JUDZPI6liw=;
        b=oiELbqG6TLeXbx7ddkX7dARRYbfetN4s9OZjXrqFx/7RxXtK2KBd5trsxJOUIXCAPN
         my2kPKX0b4NYZ4qyX/n0fIAZ9OZxlOGMx9A6F7S8rsqmVr1ZVKV8nIAz2xwak6HenHUE
         2j7PApOHy0kFWUbpBp19lIoY6YOCE5Dd59WU9LPRDoX1fsrk+bZCzFyCNe8+VR2XCgzX
         x1L/YlVxGKr08LaIc6FT4tbyWWrZZY49glemjXhGDI9SkZOzJOfnkJrW18ELJGcrpynS
         oKALLwxRrRep/mndItE7odS/xSnyB3wtOUnoWHLRp4k8ktP/bBAZeEYq8bX0rt+FqHUX
         i2BQ==
X-Gm-Message-State: ANoB5pkJrq/AfwquNbkAaqMHGfez/Dj/Dv/pIc9fgZiEYa0Itpr/9Un7
	OeQ8S6BvEQskCD+dZ4dFIWGYe2NtwwztFrj2GB8=
X-Google-Smtp-Source: AA0mqf51uIOWkjKSwhAqxTpfKMjsu42I0eiMVKrm0VEx7HQYTsVmieNicP3p40lc7YCyIthr+ry0hUYCl4VWsxspqf0=
X-Received: by 2002:ac8:7dcb:0:b0:3a6:8dd0:4712 with SMTP id
 c11-20020ac87dcb000000b003a68dd04712mr11196833qte.411.1670003278849; Fri, 02
 Dec 2022 09:47:58 -0800 (PST)
MIME-Version: 1.0
References: <20221127-snd-freeze-v8-0-3bc02d09f2ce@chromium.org> <20221127-snd-freeze-v8-2-3bc02d09f2ce@chromium.org>
In-Reply-To: <20221127-snd-freeze-v8-2-3bc02d09f2ce@chromium.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 2 Dec 2022 18:47:47 +0100
Message-ID: <CAJZ5v0jbKSTQopEoXW9FpqDmAqp6Pn=-Om5QP2-7ocuGdq8R9w@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] freezer: refactor pm_freezing into a function.
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Juergen Gross <jgross@suse.com>, Mark Brown <broonie@kernel.org>, 
	Chromeos Kdump <chromeos-kdump@google.com>, Daniel Baluta <daniel.baluta@nxp.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Len Brown <len.brown@intel.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Eric Biederman <ebiederm@xmission.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Jaroslav Kysela <perex@perex.cz>, Joel Fernandes <joel@joelfernandes.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
	Pavel Machek <pavel@ucw.cz>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
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
X-CRM114-CacheID: sfid-20221202_094800_208130_852D249C 
X-CRM114-Status: GOOD (  29.50  )
X-Mailman-Approved-At: Sun, 04 Dec 2022 01:31:52 -0800
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

On Thu, Dec 1, 2022 at 12:08 PM Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Add a way to let the drivers know if the processes are frozen.
>
> This is needed by drivers that are waiting for processes to end on their
> shutdown path.
>
> Convert pm_freezing into a function and export it, so it can be used by
> drivers that are either built-in or modules.
>
> Cc: stable@vger.kernel.org
> Fixes: 83bfc7e793b5 ("ASoC: SOF: core: unregister clients and machine drivers in .shutdown")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Why can't you export the original pm_freezing variable and why is this
fixing anything?

> ---
>  include/linux/freezer.h |  3 ++-
>  kernel/freezer.c        |  3 +--
>  kernel/power/process.c  | 24 ++++++++++++++++++++----
>  3 files changed, 23 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/freezer.h b/include/linux/freezer.h
> index b303472255be..3413c869d68b 100644
> --- a/include/linux/freezer.h
> +++ b/include/linux/freezer.h
> @@ -13,7 +13,7 @@
>  #ifdef CONFIG_FREEZER
>  DECLARE_STATIC_KEY_FALSE(freezer_active);
>
> -extern bool pm_freezing;               /* PM freezing in effect */
> +bool pm_freezing(void);
>  extern bool pm_nosig_freezing;         /* PM nosig freezing in effect */
>
>  /*
> @@ -80,6 +80,7 @@ static inline int freeze_processes(void) { return -ENOSYS; }
>  static inline int freeze_kernel_threads(void) { return -ENOSYS; }
>  static inline void thaw_processes(void) {}
>  static inline void thaw_kernel_threads(void) {}
> +static inline bool pm_freezing(void) { return false; }
>
>  static inline bool try_to_freeze(void) { return false; }
>
> diff --git a/kernel/freezer.c b/kernel/freezer.c
> index 4fad0e6fca64..2d3530ebdb7e 100644
> --- a/kernel/freezer.c
> +++ b/kernel/freezer.c
> @@ -20,7 +20,6 @@ EXPORT_SYMBOL(freezer_active);
>   * indicate whether PM freezing is in effect, protected by
>   * system_transition_mutex
>   */
> -bool pm_freezing;
>  bool pm_nosig_freezing;
>
>  /* protects freezing and frozen transitions */
> @@ -46,7 +45,7 @@ bool freezing_slow_path(struct task_struct *p)
>         if (pm_nosig_freezing || cgroup_freezing(p))
>                 return true;
>
> -       if (pm_freezing && !(p->flags & PF_KTHREAD))
> +       if (pm_freezing() && !(p->flags & PF_KTHREAD))
>                 return true;
>
>         return false;
> diff --git a/kernel/power/process.c b/kernel/power/process.c
> index ddd9988327fe..8a4d0e2c8c20 100644
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -108,6 +108,22 @@ static int try_to_freeze_tasks(bool user_only)
>         return todo ? -EBUSY : 0;
>  }
>
> +/*
> + * Indicate whether PM freezing is in effect, protected by
> + * system_transition_mutex.
> + */
> +static bool pm_freezing_internal;
> +
> +/**
> + * pm_freezing - indicate whether PM freezing is in effect.
> + *
> + */
> +bool pm_freezing(void)
> +{
> +       return pm_freezing_internal;
> +}
> +EXPORT_SYMBOL(pm_freezing);

Use EXPORT_SYMBOL_GPL() instead, please.

> +
>  /**
>   * freeze_processes - Signal user space processes to enter the refrigerator.
>   * The current thread will not be frozen.  The same process that calls
> @@ -126,12 +142,12 @@ int freeze_processes(void)
>         /* Make sure this task doesn't get frozen */
>         current->flags |= PF_SUSPEND_TASK;
>
> -       if (!pm_freezing)
> +       if (!pm_freezing())
>                 static_branch_inc(&freezer_active);
>
>         pm_wakeup_clear(0);
>         pr_info("Freezing user space processes ... ");
> -       pm_freezing = true;
> +       pm_freezing_internal = true;
>         error = try_to_freeze_tasks(true);
>         if (!error) {
>                 __usermodehelper_set_disable_depth(UMH_DISABLED);
> @@ -187,9 +203,9 @@ void thaw_processes(void)
>         struct task_struct *curr = current;
>
>         trace_suspend_resume(TPS("thaw_processes"), 0, true);
> -       if (pm_freezing)
> +       if (pm_freezing())
>                 static_branch_dec(&freezer_active);
> -       pm_freezing = false;
> +       pm_freezing_internal = false;
>         pm_nosig_freezing = false;
>
>         oom_killer_enable();
>
> --

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
