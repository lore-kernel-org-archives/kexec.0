Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6B3C4332F
	for <kexec@archiver.kernel.org>; Wed, 21 Dec 2022 02:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AOOg1qTRV5TSNHV9sWdtnC61WNbnMAD2b9TJ8eZKU3w=; b=wVVbTIukiagNH0
	lHajtL8j1IawNsZJ1nJ1VIblacVSkXZ5Ik1Q22/j/XZbDnKQa2yzpoD6dNWIDB+kj9FvgczW7tMv2
	eII84sa4ia4sf79LQ7yqker/7i49Iu1nDNbUQFJFCPiVMfqo/QIKr2HFvTL2BFSkK9lKmeQxJ6D4l
	G1jRna62+VI722WSDlBxmE5ePg3OeToceAPL0a6JE1diLfToU/FFwn4cpkELFxluyAeFLUGwG2c/C
	vHZCjYgOu9ZJlIaIAdaiUrdil8TUmUClBkB0BEmg3Br0z7jKJBOADsg75a0MI2EDCzSPVz8aP9RBT
	tHyY0XiZwtVkc01z25fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7pE0-008Bbh-B4; Wed, 21 Dec 2022 02:52:56 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7pDu-008BLe-9Y
	for kexec@lists.infradead.org; Wed, 21 Dec 2022 02:52:52 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6FCFA615D2;
	Wed, 21 Dec 2022 02:52:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A91FC433D2;
	Wed, 21 Dec 2022 02:52:39 +0000 (UTC)
Date: Tue, 20 Dec 2022 21:52:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Subject: Re: [PATCH v3 3/3] kexec: Introduce parameters load_limit_reboot
 and load_limit_panic
Message-ID: <20221220215237.7efc96b8@gandalf.local.home>
In-Reply-To: <CANiDSCtgkQKUN6BtCsYc1Yn5UxwsFsCnMrraxpjjpXEErhUyhA@mail.gmail.com>
References: <20221114-disable-kexec-reset-v3-0-4ef4e929adf6@chromium.org>
	<20221114-disable-kexec-reset-v3-3-4ef4e929adf6@chromium.org>
	<20221220192208.4d0c934f@gandalf.local.home>
	<CANiDSCtgkQKUN6BtCsYc1Yn5UxwsFsCnMrraxpjjpXEErhUyhA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221220_185250_454857_48C97E07 
X-CRM114-Status: GOOD (  26.84  )
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
Cc: Jonathan Corbet <corbet@lwn.net>, Philipp Rudo <prudo@redhat.com>, linux-doc@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>, Eric Biederman <ebiederm@xmission.com>, Ross Zwisler <zwisler@kernel.org>, "Joel Fernandes
 \(Google\)" <joel@joelfernandes.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, 21 Dec 2022 02:22:57 +0100
Ricardo Ribalda <ribalda@chromium.org> wrote:

> > > +     kexec_core.load_limit_reboot=
> > > +     kexec_core.load_limit_panic=
> > > +                     [KNL]
> > > +                     This parameter specifies a limit to the number of times
> > > +                     a kexec kernel can be loaded.
> > > +                     Format: <int>
> > > +                     -1  = Unlimited.
> > > +                     int = Number of times kexec can be called.
> > > +
> > > +                     During runtime, this parameter can be modified with a  
> >  
> > > +                     value smaller than the current one (but not -1).  
> >
> > Perhaps state:
> >                         smaller positive value than the current one or if
> >                         current is currently -1.  
> 
> I find it a bit complicated..
> What about:
> 
>  During runtime this parameter can be modified with a more restrictive value

Sure. That's better than the original.


> > > +module_param_cb(load_limit_reboot, &load_limit_ops, &load_limit_reboot, 0644);
> > > +MODULE_PARM_DESC(load_limit_reboot, "Maximum attempts to load a kexec reboot kernel");
> > > +
> > > +module_param_cb(load_limit_panic, &load_limit_ops, &load_limit_panic, 0644);
> > > +MODULE_PARM_DESC(load_limit_reboot, "Maximum attempts to load a kexec panic kernel");  
> >
> > Wait, why the module params if this can not be a module?
> >
> > The kernel/kexec.c is decided via CONFIG_KEXEC_CORE which is bool. Either
> > builtin or not at all. No module selection possible.
> >
> > For kernel parameters, we should just use __setup(), right?  
> 
> Isn't __setup() only kernel parameter and then it cannot be updated on runtime?

Yes, but then we use sysctl.

> 
> What about using late_param_cb? and remove MODULE_PARAM_DESC ?
> 
> I think this is how these parameters work
> 
> $ ls /sys/module/kernel/parameters/
> consoleblank  crash_kexec_post_notifiers  ignore_rlimit_data
> initcall_debug  module_blacklist  panic  panic_on_warn  panic_print
> pause_on_oops

Well, I think those are more leftovers and not something we want to add to.

I believe sysctl is the better option, and a more common one:

$ ls /proc/sys/kernel/
acct                           perf_event_max_contexts_per_stack
acpi_video_flags               perf_event_max_sample_rate
auto_msgmni                    perf_event_max_stack
bootloader_type                perf_event_mlock_kb
bootloader_version             perf_event_paranoid
bpf_stats_enabled              pid_max
cad_pid                        poweroff_cmd
cap_last_cap                   print-fatal-signals
core_pattern                   printk
core_pipe_limit                printk_delay
core_uses_pid                  printk_devkmsg
ctrl-alt-del                   printk_ratelimit
dmesg_restrict                 printk_ratelimit_burst
domainname                     pty
firmware_config                random
ftrace_dump_on_oops            randomize_va_space
ftrace_enabled                 real-root-dev
hardlockup_all_cpu_backtrace   sched_autogroup_enabled
hardlockup_panic               sched_child_runs_first
hostname                       sched_deadline_period_max_us
hotplug                        sched_deadline_period_min_us
hung_task_all_cpu_backtrace    sched_energy_aware
hung_task_check_count          sched_rr_timeslice_ms
hung_task_check_interval_secs  sched_rt_period_us
hung_task_panic                sched_rt_runtime_us
hung_task_timeout_secs         sched_util_clamp_max
hung_task_warnings             sched_util_clamp_min
io_delay_type                  sched_util_clamp_min_rt_default
kexec_load_disabled            seccomp
keys                           sem
kptr_restrict                  sem_next_id
max_lock_depth                 shmall
max_rcu_stall_to_panic         shmmax
modprobe                       shmmni
modules_disabled               shm_next_id
msgmax                         shm_rmid_forced
msgmnb                         softlockup_all_cpu_backtrace
msgmni                         softlockup_panic
msg_next_id                    soft_watchdog
ngroups_max                    stack_tracer_enabled
nmi_watchdog                   sysctl_writes_strict
ns_last_pid                    sysrq
numa_balancing                 tainted
oops_all_cpu_backtrace         task_delayacct
osrelease                      threads-max
ostype                         timer_migration
overflowgid                    traceoff_on_warning
overflowuid                    tracepoint_printk
panic                          unknown_nmi_panic
panic_on_io_nmi                unprivileged_bpf_disabled
panic_on_oops                  usermodehelper
panic_on_rcu_stall             version
panic_on_unrecovered_nmi       watchdog
panic_on_warn                  watchdog_cpumask
panic_print                    watchdog_thresh
perf_cpu_time_max_percent      yama



> I could pass the flags and then check for flags & (KEXEC_ON_CRASH |
> KEXEC_FILE_ON_CRASH)... but not sure if it is better

It keeps the processing in a single place, which helps avoid bugs like this.

-- Steve

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
