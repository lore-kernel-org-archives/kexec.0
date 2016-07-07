Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bL6Wa-0006Ob-Ak
 for kexec@lists.infradead.org; Thu, 07 Jul 2016 10:27:17 +0000
From: "Wei, Jiangang" <weijg.fnst@cn.fujitsu.com>
Subject: Re: [PATCH] kexec: Fix kdump failure with notsc
Date: Thu, 7 Jul 2016 10:26:47 +0000
Message-ID: <1467887078.2119.63.camel@localhost>
References: <201607071617.dgK52iri%fengguang.wu@intel.com>
In-Reply-To: <201607071617.dgK52iri%fengguang.wu@intel.com>
Content-Language: en-US
Content-ID: <FD427C6B50FBD445B09FBC700A7CFD90@fujitsu.local>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "lkp@intel.com" <lkp@intel.com>
Cc: "fenghua.yu@intel.com" <fenghua.yu@intel.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "hpa@zytor.com" <hpa@zytor.com>, "Izumi, Taku" <izumi.taku@jp.fujitsu.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "kbuild-all@01.org" <kbuild-all@01.org>

Hi all,

I fixed the compile error and sent the v2.
Please ignore this serial.

Thanks,
wei

On Thu, 2016-07-07 at 16:46 +0800, kbuild test robot wrote:
> Hi,
> 
> [auto build test ERROR on tip/x86/core]
> [also build test ERROR on v4.7-rc6 next-20160706]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Wei-Jiangang/kexec-Fix-kdump-failure-with-notsc/20160707-152535
> config: x86_64-randconfig-s5-07071541 (attached as .config)
> compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>    arch/x86/kernel/machine_kexec_64.c: In function 'machine_kexec':
> >> arch/x86/kernel/machine_kexec_64.c:272:33: error: implicit declaration of function 'lapic_disabled' [-Werror=implicit-function-declaration]
>      if (image->preserve_context || lapic_disabled()) {
>                                     ^~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
> 
> vim +/lapic_disabled +272 arch/x86/kernel/machine_kexec_64.c
> 
>    266		save_ftrace_enabled = __ftrace_enabled_save();
>    267	
>    268		/* Interrupts aren't acceptable while we reboot */
>    269		local_irq_disable();
>    270		hw_breakpoint_disable();
>    271	
>  > 272		if (image->preserve_context || lapic_disabled()) {
>    273	#ifdef CONFIG_X86_IO_APIC
>    274			/*
>    275			 * We need to put APICs in legacy mode so that we can
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
> 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
