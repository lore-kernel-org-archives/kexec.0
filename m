Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C97C43334
	for <kexec@archiver.kernel.org>; Tue, 14 Jun 2022 19:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d33ZmNWjun+yyByaXmeCcQhus4HktYGo2A57t0mMWkk=; b=KPlsZIKBuAEUvu
	oZTV3WSwVQ90s4EKauBnvLe4wqs4rF+jecPkErU5xHNOAVeFjrZkT2lbyISiWsW5jg+9itGNrW09E
	dBTzwMg8o8kP/aWNVicvxz4xWSSYD1S1kMasWNlxrD3oKQ/obDyZ9oXEZJz7a1NNJkCZV1Kgrhto+
	guxPvKnavodOFMcXsXPXSYfIhEJ7fybAvEwEVCB/hhcDEbsng1rlZM6nheRPP2G12Kg/cC5kWoWvw
	oksqNF38QowoXnwZUH9M6hkybgkbnnEYLlxsQZH1JM4D8q/Uj7RnUivu2yx7+6zUH/VzmZyAYGmth
	xnY5yznQuhYiCHr6HvAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1Blc-00AqqC-PW; Tue, 14 Jun 2022 18:59:56 +0000
Received: from mga14.intel.com ([192.55.52.115])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1BlY-00AqpD-CR
	for kexec@lists.infradead.org; Tue, 14 Jun 2022 18:59:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655233192; x=1686769192;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TJmxkFAg5DcQYSeiZno0G1i6Bgz3X6igQii0Ttgjycw=;
  b=oIej5bCkmUmQU9eKLIbWgsgeT28tGQ4BHWgzECwAT3BtmzD1EckmHbKW
   xq8K3DxV3s4S3P+f59ebX7fZirSHpuu1SBSX/1004h3BdAReNsCJ6yn44
   3k8hs+esMmbX47NpadMwJR/gy6OnAmuEYYjRZ49cKEvnW05OW9Kj+X4Ls
   B9/g1jsnmaP2WZLMLw4dZI58l4KDNZ9HQnGjbl5YMYSTmrwDwjf+Ce8EC
   Bh3mx+7KLUp8n1Ck5Dzws4mh7B7R58E+IKfSCY4VSIZEM2TPUJOpUrKot
   DH8N1nLcXjlbGKsQ7evgSUJpgQK4LBDB6nPTpL84fLXOHxVDxtoQp3Sqk
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="278755527"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="278755527"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 11:59:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="712593088"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 14 Jun 2022 11:59:48 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
	(envelope-from <lkp@intel.com>)
	id 1o1BlT-000MDR-Ah;
	Tue, 14 Jun 2022 18:59:47 +0000
Date: Wed, 15 Jun 2022 02:58:47 +0800
From: kernel test robot <lkp@intel.com>
To: Stefan Berger <stefanb@linux.ibm.com>, kexec@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: kbuild-all@lists.01.org, nayna@linux.ibm.com, nasastry@in.ibm.com,
	Stefan Berger <stefanb@linux.ibm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 2/3] tpm/kexec: Duplicate TPM measurement log in of-tree
 for kexec
Message-ID: <202206150235.zvfG6DIM-lkp@intel.com>
References: <20220614161258.1741427-3-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220614161258.1741427-3-stefanb@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220614_115952_533461_313470C9 
X-CRM114-Status: GOOD (  14.61  )
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

Hi Stefan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on linus/master v5.19-rc2 next-20220614]
[cannot apply to robh/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Stefan-Berger/tpm-Preserve-TPM-measurement-log-across-kexec/20220615-001510
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 0a35780c755ccec097d15c6b4ff8b246a89f1689
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220615/202206150235.zvfG6DIM-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/c42b5be1ad82e8a991a3d35417c9e495e7eb4c93
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Stefan-Berger/tpm-Preserve-TPM-measurement-log-across-kexec/20220615-001510
        git checkout c42b5be1ad82e8a991a3d35417c9e495e7eb4c93
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from include/linux/i2c.h:13,
                    from drivers/input/mouse/synaptics.c:30:
>> include/linux/of.h:848:48: warning: 'struct kimage' declared inside parameter list will not be visible outside of this definition or declaration
     848 | static inline void tpm_add_kexec_buffer(struct kimage *image)
         |                                                ^~~~~~
   drivers/input/mouse/synaptics.c:164:27: warning: 'smbus_pnp_ids' defined but not used [-Wunused-const-variable=]
     164 | static const char * const smbus_pnp_ids[] = {
         |                           ^~~~~~~~~~~~~
--
   In file included from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from init/main.c:30:
>> include/linux/of.h:848:48: warning: 'struct kimage' declared inside parameter list will not be visible outside of this definition or declaration
     848 | static inline void tpm_add_kexec_buffer(struct kimage *image)
         |                                                ^~~~~~
   init/main.c:769:20: warning: no previous prototype for 'arch_post_acpi_subsys_init' [-Wmissing-prototypes]
     769 | void __init __weak arch_post_acpi_subsys_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   init/main.c:781:20: warning: no previous prototype for 'mem_encrypt_init' [-Wmissing-prototypes]
     781 | void __init __weak mem_encrypt_init(void) { }
         |                    ^~~~~~~~~~~~~~~~
   init/main.c:783:20: warning: no previous prototype for 'poking_init' [-Wmissing-prototypes]
     783 | void __init __weak poking_init(void) { }
         |                    ^~~~~~~~~~~
--
   In file included from include/linux/clocksource.h:19,
                    from include/linux/clockchips.h:14,
                    from include/linux/tick.h:8,
                    from arch/um/kernel/process.c:24:
>> include/linux/of.h:848:48: warning: 'struct kimage' declared inside parameter list will not be visible outside of this definition or declaration
     848 | static inline void tpm_add_kexec_buffer(struct kimage *image)
         |                                                ^~~~~~
   arch/um/kernel/process.c:50:5: warning: no previous prototype for 'pid_to_processor_id' [-Wmissing-prototypes]
      50 | int pid_to_processor_id(int pid)
         |     ^~~~~~~~~~~~~~~~~~~
   arch/um/kernel/process.c:86:7: warning: no previous prototype for '__switch_to' [-Wmissing-prototypes]
      86 | void *__switch_to(struct task_struct *from, struct task_struct *to)
         |       ^~~~~~~~~~~
   arch/um/kernel/process.c: In function 'new_thread_handler':
   arch/um/kernel/process.c:121:28: warning: variable 'n' set but not used [-Wunused-but-set-variable]
     121 |         int (*fn)(void *), n;
         |                            ^
   arch/um/kernel/process.c: At top level:
   arch/um/kernel/process.c:139:6: warning: no previous prototype for 'fork_handler' [-Wmissing-prototypes]
     139 | void fork_handler(void)
         |      ^~~~~~~~~~~~
   arch/um/kernel/process.c:216:6: warning: no previous prototype for 'arch_cpu_idle' [-Wmissing-prototypes]
     216 | void arch_cpu_idle(void)
         |      ^~~~~~~~~~~~~
   arch/um/kernel/process.c:253:5: warning: no previous prototype for 'copy_to_user_proc' [-Wmissing-prototypes]
     253 | int copy_to_user_proc(void __user *to, void *from, int size)
         |     ^~~~~~~~~~~~~~~~~
   arch/um/kernel/process.c:263:5: warning: no previous prototype for 'clear_user_proc' [-Wmissing-prototypes]
     263 | int clear_user_proc(void __user *buf, int size)
         |     ^~~~~~~~~~~~~~~
   arch/um/kernel/process.c:316:12: warning: no previous prototype for 'make_proc_sysemu' [-Wmissing-prototypes]
     316 | int __init make_proc_sysemu(void)
         |            ^~~~~~~~~~~~~~~~
   arch/um/kernel/process.c:356:15: warning: no previous prototype for 'arch_align_stack' [-Wmissing-prototypes]
     356 | unsigned long arch_align_stack(unsigned long sp)
         |               ^~~~~~~~~~~~~~~~
--
   In file included from include/linux/clocksource.h:19,
                    from include/linux/clockchips.h:14,
                    from arch/um/kernel/time.c:10:
>> include/linux/of.h:848:48: warning: 'struct kimage' declared inside parameter list will not be visible outside of this definition or declaration
     848 | static inline void tpm_add_kexec_buffer(struct kimage *image)
         |                                                ^~~~~~
   arch/um/kernel/time.c:778:13: warning: no previous prototype for 'time_init' [-Wmissing-prototypes]
     778 | void __init time_init(void)
         |             ^~~~~~~~~
--
   In file included from include/linux/clocksource.h:19,
                    from include/linux/clockchips.h:14,
                    from include/linux/tick.h:8,
                    from include/linux/sched/isolation.h:6,
                    from kernel/workqueue.c:51:
>> include/linux/of.h:848:48: warning: 'struct kimage' declared inside parameter list will not be visible outside of this definition or declaration
     848 | static inline void tpm_add_kexec_buffer(struct kimage *image)
         |                                                ^~~~~~
--
   In file included from include/linux/clocksource.h:19,
                    from include/linux/clockchips.h:14,
                    from include/linux/tick.h:8,
                    from kernel/irq_work.c:17:
>> include/linux/of.h:848:48: warning: 'struct kimage' declared inside parameter list will not be visible outside of this definition or declaration
     848 | static inline void tpm_add_kexec_buffer(struct kimage *image)
         |                                                ^~~~~~
   kernel/irq_work.c:70:13: warning: no previous prototype for 'arch_irq_work_raise' [-Wmissing-prototypes]
      70 | void __weak arch_irq_work_raise(void)
         |             ^~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/clocksource.h:19,
                    from include/linux/clockchips.h:14,
                    from include/linux/tick.h:8,
                    from include/linux/sched/isolation.h:6,
                    from kernel/sched/fair.c:38:
>> include/linux/of.h:848:48: warning: 'struct kimage' declared inside parameter list will not be visible outside of this definition or declaration
     848 | static inline void tpm_add_kexec_buffer(struct kimage *image)
         |                                                ^~~~~~
   kernel/sched/fair.c:675:5: warning: no previous prototype for 'sched_update_scaling' [-Wmissing-prototypes]
     675 | int sched_update_scaling(void)
         |     ^~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/clocksource.h:19,
                    from include/linux/clockchips.h:14,
                    from include/linux/tick.h:8,
                    from kernel/time/hrtimer.c:32:
>> include/linux/of.h:848:48: warning: 'struct kimage' declared inside parameter list will not be visible outside of this definition or declaration
     848 | static inline void tpm_add_kexec_buffer(struct kimage *image)
         |                                                ^~~~~~
   kernel/time/hrtimer.c:120:35: warning: initialized field overwritten [-Woverride-init]
     120 |         [CLOCK_REALTIME]        = HRTIMER_BASE_REALTIME,
         |                                   ^~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:120:35: note: (near initialization for 'hrtimer_clock_to_base_table[0]')
   kernel/time/hrtimer.c:121:35: warning: initialized field overwritten [-Woverride-init]
     121 |         [CLOCK_MONOTONIC]       = HRTIMER_BASE_MONOTONIC,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:121:35: note: (near initialization for 'hrtimer_clock_to_base_table[1]')
   kernel/time/hrtimer.c:122:35: warning: initialized field overwritten [-Woverride-init]
     122 |         [CLOCK_BOOTTIME]        = HRTIMER_BASE_BOOTTIME,
         |                                   ^~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:122:35: note: (near initialization for 'hrtimer_clock_to_base_table[7]')
   kernel/time/hrtimer.c:123:35: warning: initialized field overwritten [-Woverride-init]
     123 |         [CLOCK_TAI]             = HRTIMER_BASE_TAI,
         |                                   ^~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:123:35: note: (near initialization for 'hrtimer_clock_to_base_table[11]')
   kernel/time/hrtimer.c: In function '__run_hrtimer':
   kernel/time/hrtimer.c:1648:14: warning: variable 'expires_in_hardirq' set but not used [-Wunused-but-set-variable]
    1648 |         bool expires_in_hardirq;
         |              ^~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/clk-provider.h:9,
                    from lib/vsprintf.c:23:
>> include/linux/of.h:848:48: warning: 'struct kimage' declared inside parameter list will not be visible outside of this definition or declaration
     848 | static inline void tpm_add_kexec_buffer(struct kimage *image)
         |                                                ^~~~~~
   lib/vsprintf.c: In function 'va_format':
   lib/vsprintf.c:1681:9: warning: function 'va_format' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1681 |         buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
         |         ^~~


vim +848 include/linux/of.h

   847	
 > 848	static inline void tpm_add_kexec_buffer(struct kimage *image)
   849	{
   850	}
   851	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
