Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B714BC4332F
	for <kexec@archiver.kernel.org>; Wed, 21 Dec 2022 01:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s0ra7xPHLhj8yG1TGA6uncj+2BWjWUwEBSt5ojcwaak=; b=DBHNXmuWcn3Ttg
	uKl8zM6q5mJvOfpfpFyFKoVVFz273Wf40d/I4bPIpL/R2L4V5gp3rVbiHF4lXDbN3mOVCioWZMYBa
	kZKwxRxuhpwinM9rndo79E/sKJeNMqsoyAp15YxjWVMVeXp7B4MeALdkcMspg2qEv1Rq98carcubn
	elzMVx/VQ9TSsJc3f/vrcLGjFoZUT9aQkBp/+yCfikNBt0yKoTDKZtI4WyQ3qAWjM1HrsDBgwyvK4
	Unh1UvIY0Yovn0+D10048wwGRUVo/nRgQNNxhzsM3BxlxiPUd9TZZtkIadTW9IfnipsPpaT7IhP1X
	7la335MFI0yNQbv3CWfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7npH-006wcw-5a; Wed, 21 Dec 2022 01:23:19 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7npD-006wX5-B6
	for kexec@lists.infradead.org; Wed, 21 Dec 2022 01:23:17 +0000
Received: by mail-pj1-x1031.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso2270493pjb.1
        for <kexec@lists.infradead.org>; Tue, 20 Dec 2022 17:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sufVhttXMxBigkR5SmMIzr4R7xZEh5qc5bQeiL07mLM=;
        b=IrHjUKs67YaXq/G+77+CyMTmtu4Of2nMr1UIx6YWQtCYpuBOm8xAMmr+1ZyOIwMZI1
         zGsTnFUWnQANuORwvYrHOU0PCvbfV0rDPH7/giqnHHecgYXt2UDENxyxb2KjalAkZnxP
         fe8eJsxtTD+6zWGTXA8Opn5jPr5wC1FJDclGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sufVhttXMxBigkR5SmMIzr4R7xZEh5qc5bQeiL07mLM=;
        b=VVmgx/QDX4Yf0N7pbwddcunKa2dAnVmLAxZkUdFy3Or2YK4HKhEfP3N34vrrKXYfFN
         0HgvAQZunLxW6u6ouQqsEkscbS2374+xeNu6WmXjCSkglRS0l38O9R1O0/Lj5xNnQntF
         LmZJA6XAISYUy/LhpyIS+AvRnW8rZ2LItFWffIVuwde+eENUNCW77NQ7lnJ+5Sp4bayA
         iMVemS1gvTZ8c9N9LTohncRLMh5RvRMliW+TJSI1todSk/q2nRirKJRAbZIYmFULlUi0
         sTqiE5xhhmbW9Uh46mb24fivE7344iJyFOBBWyUcXp2wfzBrkwm615ezL28uO9sB5Lk/
         SwUQ==
X-Gm-Message-State: AFqh2kpJwqv5G3B2lO4sho7BCTqKexYyfZ7r5Mw0fMsf7hiLHasQTDiZ
	570hVdv8JovSJmfqVfQzSHe13+acpDYt3aUetiQ=
X-Google-Smtp-Source: AMrXdXvUcsxeQ+zbK/qbYDvUr+eo81jYKumC5NbziN+PIF+5IyIXCSWRsGBwHQBotgg/SOxNikugSg==
X-Received: by 2002:a17:902:7488:b0:189:e711:170 with SMTP id h8-20020a170902748800b00189e7110170mr41588pll.64.1671585791361;
        Tue, 20 Dec 2022 17:23:11 -0800 (PST)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com. [209.85.215.180])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902784500b0018685257c0dsm9991552pln.58.2022.12.20.17.23.09
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 17:23:09 -0800 (PST)
Received: by mail-pg1-f180.google.com with SMTP id 36so9457300pgp.10
        for <kexec@lists.infradead.org>; Tue, 20 Dec 2022 17:23:09 -0800 (PST)
X-Received: by 2002:a65:628a:0:b0:479:3263:aa35 with SMTP id
 f10-20020a65628a000000b004793263aa35mr1869472pgv.63.1671585788863; Tue, 20
 Dec 2022 17:23:08 -0800 (PST)
MIME-Version: 1.0
References: <20221114-disable-kexec-reset-v3-0-4ef4e929adf6@chromium.org>
 <20221114-disable-kexec-reset-v3-3-4ef4e929adf6@chromium.org> <20221220192208.4d0c934f@gandalf.local.home>
In-Reply-To: <20221220192208.4d0c934f@gandalf.local.home>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 21 Dec 2022 02:22:57 +0100
X-Gmail-Original-Message-ID: <CANiDSCtgkQKUN6BtCsYc1Yn5UxwsFsCnMrraxpjjpXEErhUyhA@mail.gmail.com>
Message-ID: <CANiDSCtgkQKUN6BtCsYc1Yn5UxwsFsCnMrraxpjjpXEErhUyhA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] kexec: Introduce parameters load_limit_reboot and load_limit_panic
To: Steven Rostedt <rostedt@goodmis.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221220_172315_444147_B48F6CDC 
X-CRM114-Status: GOOD (  48.35  )
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
Cc: Jonathan Corbet <corbet@lwn.net>, Philipp Rudo <prudo@redhat.com>, linux-doc@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>, Eric Biederman <ebiederm@xmission.com>, Ross Zwisler <zwisler@kernel.org>, "Joel Fernandes \(Google\)" <joel@joelfernandes.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

 Hi Steven

Thanks for your review!!! Will send a new version.
After giving it a thought... you are right :). setting the current
value should return -EINVAL. We should only return OK if we actually
do something.

On Wed, 21 Dec 2022 at 01:22, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 20 Dec 2022 23:05:45 +0100
> Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> I hate to be the grammar police, but..
>
> > Add two parameter to specify how many times a kexec kernel can be loaded.
>
>    "parameters"
>
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
>
> > +                     value smaller than the current one (but not -1).
>
> Perhaps state:
>                         smaller positive value than the current one or if
>                         current is currently -1.

I find it a bit complicated..
What about:

 During runtime this parameter can be modified with a more restrictive value




>
> > +
> > +                     Default: -1
> > +
> >       kgdbdbgp=       [KGDB,HW] kgdb over EHCI usb debug port.
> >                       Format: <Controller#>[,poll interval]
> >                       The controller # is the number of the ehci usb debug
> > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > index 182e0c11b87b..5daf9990d5b8 100644
> > --- a/include/linux/kexec.h
> > +++ b/include/linux/kexec.h
> > @@ -407,7 +407,7 @@ extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
> >  extern struct kimage *kexec_image;
> >  extern struct kimage *kexec_crash_image;
> >
> > -bool kexec_load_permitted(void);
> > +bool kexec_load_permitted(bool crash_image);
> >
> >  #ifndef kexec_flush_icache_page
> >  #define kexec_flush_icache_page(page)
> > diff --git a/kernel/kexec.c b/kernel/kexec.c
> > index ce1bca874a8d..7aefd134e319 100644
> > --- a/kernel/kexec.c
> > +++ b/kernel/kexec.c
> > @@ -193,7 +193,7 @@ static inline int kexec_load_check(unsigned long nr_segments,
> >       int result;
> >
> >       /* We only trust the superuser with rebooting the system. */
> > -     if (!kexec_load_permitted())
> > +     if (!kexec_load_permitted(flags & KEXEC_ON_CRASH))
>
> Note, here we have KEXEC_ON_CRASH (see bottom).
>
> >               return -EPERM;
> >
> >       /* Permit LSMs and IMA to fail the kexec */
> > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > index a1efc70f4158..adf71f2be3ff 100644
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -952,13 +952,100 @@ static int __init kexec_core_sysctl_init(void)
> >  late_initcall(kexec_core_sysctl_init);
> >  #endif
> >
> > -bool kexec_load_permitted(void)
> > +struct kexec_load_limit {
> > +     /* Mutex protects the limit count. */
> > +     struct mutex mutex;
> > +     int limit;
> > +};
> > +
> > +struct kexec_load_limit load_limit_reboot = {
>
> Perhaps make the above static?
>
> > +     .mutex = __MUTEX_INITIALIZER(load_limit_reboot.mutex),
> > +     .limit = -1,
> > +};
> > +
> > +struct kexec_load_limit load_limit_panic = {
>
> static?
>
> > +     .mutex = __MUTEX_INITIALIZER(load_limit_panic.mutex),
> > +     .limit = -1,
> > +};
> > +
> > +static int param_get_limit(char *buffer, const struct kernel_param *kp)
> >  {
> > +     int ret;
> > +     struct kexec_load_limit *limit = kp->arg;
>
> Looks better if "int ret;" is after the "limit".
>
> > +
> > +     mutex_lock(&limit->mutex);
> > +     ret = scnprintf(buffer, PAGE_SIZE, "%i\n", limit->limit);
>
> The above string can be at most "-2147483648\n\0"
>
> Which is 13 characters. Why use PAGE_SIZE. Or scnprintf(), and not just
> state:
>
like it!
>         /* buffer is PAGE_SIZE, much larger than what %i can be */
>         ret = sprintf(buffer, "%i\n", limit->limit);
>
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
>
> I wonder if anything less than -1 should be invalid.
>
> > +
> > +     mutex_lock(&limit->mutex);
> > +
> > +     if (new_val == -1 && limit->limit != -1) {
>
> If -1 can't change the value, why allow it to be passed in to begin with.
>
> Perhaps we should only allow sysctl to set positive values? Would make the
> code simpler.
>
> > +             ret = -EINVAL;
> > +             goto done;
> > +     }
> > +
> > +     if (limit->limit != -1 && new_val > limit->limit) {
>
> Since the above documentation said "small than" perhaps ">="?
>
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
>
> Wait, why the module params if this can not be a module?
>
> The kernel/kexec.c is decided via CONFIG_KEXEC_CORE which is bool. Either
> builtin or not at all. No module selection possible.
>
> For kernel parameters, we should just use __setup(), right?

Isn't __setup() only kernel parameter and then it cannot be updated on runtime?

What about using late_param_cb? and remove MODULE_PARAM_DESC ?

I think this is how these parameters work

$ ls /sys/module/kernel/parameters/
consoleblank  crash_kexec_post_notifiers  ignore_rlimit_data
initcall_debug  module_blacklist  panic  panic_on_warn  panic_print
pause_on_oops


>
> > +
> > +bool kexec_load_permitted(bool crash_image)
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
> >  }
> >
> >  /*
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index 29efa43ea951..6a1d4b07635e 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -330,7 +330,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> >       struct kimage **dest_image, *image;
> >
> >       /* We only trust the superuser with rebooting the system. */
> > -     if (!kexec_load_permitted())
> > +     if (!kexec_load_permitted(flags & KEXEC_FILE_FLAGS))
>
> Here we have KEXEC_FILE_FLAGS, where above it was KEXCE_FILE_CRASH.
>
> This is confusing to what denotes the "crash_image" boolean. Can we just
> pass in flags and figure it out in the kexec_load_permitted() function?

This is a typo and a bad one!, thanks for catching up!.

It should be KEXEC_ON_CRASH and KEXEC_FILE_ON_CRASH, Of course both
have different values

I could pass the flags and then check for flags & (KEXEC_ON_CRASH |
KEXEC_FILE_ON_CRASH)... but not sure if it is better
>
> -- Steve
>
>
> >               return -EPERM;
> >
> >       /* Make sure we have a legal set of flags */
> >
>


-- 
Ricardo Ribalda

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
