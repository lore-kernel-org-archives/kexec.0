Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6D2C77B7C
	for <kexec@archiver.kernel.org>; Mon, 23 Jun 2025 01:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xIGJzjrM4UQlBbwi+DnK3EXgbxH2JOzerkFxYFShEPw=; b=OfdAGSkYZmmUeZ6FoH2XQcrPtw
	hEAl+Sz1pyYLNmtQdXe5zPnPFmYhL0cHKtF8TG9sKGg/Oowj5gcHqYrKCSmmFlKW+54Xf/0tsYHiO
	RIk6DhJedvH4kKfbPty1M5R5iiXlylG10uTPVUbFnYpaUmQrun5a2FtrG5/FvETspb0k2uV8qqkO9
	egC1fDk5XiSFf0gdqyJyiAa2bXpAqPYbrvwtWf3zKsZQmdbbni+0zMwarKOKlgt0N0hJZgoZ+fq4B
	iNgKnVFmFWpBnoEpOvyFs0aVK0UPt5lPhO1tpeNj3gjdNgq+3Ln7S8yNZMpRLVFUxPN4qWFPEcUrd
	H7ozU7bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTW0c-00000001OVL-2ZU3;
	Mon, 23 Jun 2025 01:30:06 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTW0Z-00000001OUz-47gF
	for kexec@lists.infradead.org;
	Mon, 23 Jun 2025 01:30:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1DFB643DCC;
	Mon, 23 Jun 2025 01:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D07C4CEE3;
	Mon, 23 Jun 2025 01:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750642200;
	bh=LRQSDYr0p5pMRrDYup4vj91KVnPumrzHAzoJieUvEBY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=Ve2rRox4TfzuSGXH9s5FhD6kT7N0eGc2GMHOrG3/Oq5l0npt5NORuhxvwsKGUUbYs
	 ZVjEOFqm+11aG7XVsplFoOT4JJiWveHza4ULTtDWA52kG+Ce0T2Q7A7VaQUVqiuH5b
	 IeRoq7fJgR6w+RLmCzdBBA9MZWvnYl2EBcS5Xos0BjJhC8BnCa57cPSed9m/ucZlmA
	 J1L8MqdWFCGih2V9srAU31lxdvWdA0hh+iN/Pp5Y6uKpuv+NX5cn3hfbJAe+6L5QX4
	 TK2cNSzxofLRU5/CC8N6Xj3QTLAv++KAtAQ04IES5gTY3o43Jh1sMSByhZUl6FiQWR
	 WhF7m3irvc5iw==
Message-ID: <60e5d67a-fc32-459b-93a8-95f54636026c@kernel.org>
Date: Sun, 22 Jun 2025 20:29:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM: Restrict swap use to later in the suspend sequence
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com, rafael@kernel.org, len.brown@intel.com,
 pavel@kernel.org, gregkh@linuxfoundation.org, dakr@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, bhe@redhat.com
Cc: christian.koenig@amd.com, linux-pm@vger.kernel.org,
 kexec@lists.infradead.org, Nat Wittstock <nat@fardog.io>
References: <20250613214413.4127087-1-superm1@kernel.org>
Content-Language: en-US
In-Reply-To: <20250613214413.4127087-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250622_183004_073910_0849896C 
X-CRM114-Status: GOOD (  22.05  )
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



On 6/13/25 4:43 PM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Currently swap is restricted before drivers have had a chance to do their
> prepare() PM callbacks. Restricting swap this early means that if a driver
> needs to evict some content from memory into sawp in it's prepare callback
> it won't be able to.
> 
> On AMD dGPUs this can lead to failed suspends under memory pressure
> situations as all VRAM must be evicted to system memory or swap.
> 
> Move the swap restriction to right after all devices have had a chance to
> do the prepare() callback.  If there is any problem with the sequence,
> restore swap in the appropriate dpm resume callbacks or error handling
> paths.
> 
> Closes: https://github.com/ROCm/ROCK-Kernel-Driver/issues/174
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Besides my testing for this, on the bugs two people have tested it helps 
this issue.  One of them had a hard time replying to the lore post, so 
I'll proxy the tag for them.

Tested-by: Nat Wittstock <nat@fardog.io>

> ---
>   drivers/base/power/main.c | 5 ++++-
>   include/linux/suspend.h   | 5 +++++
>   kernel/kexec_core.c       | 1 +
>   kernel/power/hibernate.c  | 3 ---
>   kernel/power/power.h      | 5 -----
>   kernel/power/suspend.c    | 3 +--
>   6 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 0215b20c5e2c8..4970a804afb6d 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1241,6 +1241,7 @@ void dpm_complete(pm_message_t state)
>    */
>   void dpm_resume_end(pm_message_t state)
>   {
> +	pm_restore_gfp_mask();
>   	dpm_resume(state);
>   	dpm_complete(state);
>   }
> @@ -2183,8 +2184,10 @@ int dpm_suspend_start(pm_message_t state)
>   	error = dpm_prepare(state);
>   	if (error)
>   		dpm_save_failed_step(SUSPEND_PREPARE);
> -	else
> +	else {
> +		pm_restrict_gfp_mask();
>   		error = dpm_suspend(state);
> +	}
>   
>   	dpm_show_time(starttime, state, error, "start");
>   	return error;
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index b1c76c8f2c822..6a3f920988720 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -446,6 +446,8 @@ extern int unregister_pm_notifier(struct notifier_block *nb);
>   extern void ksys_sync_helper(void);
>   extern void pm_report_hw_sleep_time(u64 t);
>   extern void pm_report_max_hw_sleep(u64 t);
> +void pm_restrict_gfp_mask(void);
> +void pm_restore_gfp_mask(void);
>   
>   #define pm_notifier(fn, pri) {				\
>   	static struct notifier_block fn##_nb =			\
> @@ -492,6 +494,9 @@ static inline int unregister_pm_notifier(struct notifier_block *nb)
>   static inline void pm_report_hw_sleep_time(u64 t) {};
>   static inline void pm_report_max_hw_sleep(u64 t) {};
>   
> +static inline void pm_restrict_gfp_mask(void) {}
> +static inline void pm_restore_gfp_mask(void) {}
> +
>   static inline void ksys_sync_helper(void) {}
>   
>   #define pm_notifier(fn, pri)	do { (void)(fn); } while (0)
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 9c59fa480b0b6..3a9a9f240dbc9 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1136,6 +1136,7 @@ int kernel_kexec(void)
>    Resume_devices:
>   		dpm_resume_end(PMSG_RESTORE);
>    Resume_console:
> +		pm_restore_gfp_mask();
>   		console_resume_all();
>   		thaw_processes();
>    Restore_console:
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 519fb09de5e0c..9216e3b91d3b3 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -423,7 +423,6 @@ int hibernation_snapshot(int platform_mode)
>   	}
>   
>   	console_suspend_all();
> -	pm_restrict_gfp_mask();
>   
>   	error = dpm_suspend(PMSG_FREEZE);
>   
> @@ -559,7 +558,6 @@ int hibernation_restore(int platform_mode)
>   
>   	pm_prepare_console();
>   	console_suspend_all();
> -	pm_restrict_gfp_mask();
>   	error = dpm_suspend_start(PMSG_QUIESCE);
>   	if (!error) {
>   		error = resume_target_kernel(platform_mode);
> @@ -571,7 +569,6 @@ int hibernation_restore(int platform_mode)
>   		BUG_ON(!error);
>   	}
>   	dpm_resume_end(PMSG_RECOVER);
> -	pm_restore_gfp_mask();
>   	console_resume_all();
>   	pm_restore_console();
>   	return error;
> diff --git a/kernel/power/power.h b/kernel/power/power.h
> index cb1d715620020..7ccd709af93f5 100644
> --- a/kernel/power/power.h
> +++ b/kernel/power/power.h
> @@ -239,11 +239,6 @@ static inline void suspend_test_finish(const char *label) {}
>   /* kernel/power/main.c */
>   extern int pm_notifier_call_chain_robust(unsigned long val_up, unsigned long val_down);
>   extern int pm_notifier_call_chain(unsigned long val);
> -void pm_restrict_gfp_mask(void);
> -void pm_restore_gfp_mask(void);
> -#else
> -static inline void pm_restrict_gfp_mask(void) {}
> -static inline void pm_restore_gfp_mask(void) {}
>   #endif
>   
>   #ifdef CONFIG_HIGHMEM
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 76b141b9aac01..bb608b68fb301 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -540,6 +540,7 @@ int suspend_devices_and_enter(suspend_state_t state)
>   	return error;
>   
>    Recover_platform:
> +	pm_restore_gfp_mask();
>   	platform_recover(state);
>   	goto Resume_devices;
>   }
> @@ -606,9 +607,7 @@ static int enter_state(suspend_state_t state)
>   
>   	trace_suspend_resume(TPS("suspend_enter"), state, false);
>   	pm_pr_dbg("Suspending system (%s)\n", mem_sleep_labels[state]);
> -	pm_restrict_gfp_mask();
>   	error = suspend_devices_and_enter(state);
> -	pm_restore_gfp_mask();
>   
>    Finish:
>   	events_check_enabled = false;


