Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail7.hitachi.co.jp ([133.145.228.42])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZgSYF-0002iN-U3
 for kexec@lists.infradead.org; Mon, 28 Sep 2015 07:08:44 +0000
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
 <hidehiro.kawai.ez@hitachi.com>
Subject: RE: Re: [V4 PATCH 3/4] kexec: Fix race between panic() and
 crash_kexec() called directly
Date: Mon, 28 Sep 2015 07:08:19 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A84454994C26@GSjpTKYDCembx31.service.hitachi.net>
References: <20150925112809.4258.39950.stgit@softrs>
 <201509281128.r1CboaDC%fengguang.wu@intel.com>
In-Reply-To: <201509281128.r1CboaDC%fengguang.wu@intel.com>
Content-Language: ja-JP
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
To: "kbuild-all@01.org" <kbuild-all@01.org>
Cc: "x86@kernel.org" <x86@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

> Hi Hidehiro,
> 
> [auto build test results on v4.3-rc2 -- if it's inappropriate base, please ignore]
> 
> config: ia64-allyesconfig (attached as .config)
> reproduce:
>   wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>   chmod +x ~/bin/make.cross
>   git checkout 0077681103150af584e5e592c0238fd010654c26
>   # save the attached .config to linux build tree
>   make.cross ARCH=ia64
[snip]
>    arch/ia64/include/uapi/asm/cmpxchg.h:56:2: warning: value computed is not used [-Wunused-value]
>     ((__typeof__(*(ptr))) __xchg((unsigned long) (x), (ptr), sizeof(*(ptr))))
>      ^
>    arch/ia64/include/asm/atomic.h:135:30: note: in expansion of macro 'xchg'
>     #define atomic_xchg(v, new) (xchg(&((v)->counter), new))
>                                  ^
> >> kernel/kexec_core.c:899:3: note: in expansion of macro 'atomic_xchg'
>       atomic_xchg(&panic_cpu, -1);
>       ^

I changed to use atomic_xchg() instead of atomic_set() in V3
because atomic_set() doesn't mean memory barrier.  However,
I thought again and there is no need of barrier; there is no
problem if a competitor sees old value of panic_cpu or new one.
So, atomic_set() is sufficient and using it will remove this warning.

I will resend the fixed version later.

> vim +/atomic_xchg +899 kernel/kexec_core.c
> 
>    883
>    884		/*
>    885		 * Only one CPU is allowed to execute the crash_kexec() code as with
>    886		 * panic().  Otherwise parallel calls of panic() and crash_kexec()
>    887		 * may stop each other.  To exclude them, we use panic_cpu here too.
>    888		 */
>    889		this_cpu = raw_smp_processor_id();
>    890		old_cpu = atomic_cmpxchg(&panic_cpu, -1, this_cpu);
>    891		if (old_cpu == -1) {
>    892			/* This is the 1st CPU which comes here, so go ahead. */
>    893			__crash_kexec(regs);
>    894
>    895			/*
>    896			 * Reset panic_cpu to allow another panic()/crash_kexec()
>    897			 * call.
>    898			 */
>  > 899			atomic_xchg(&panic_cpu, -1);
>    900		}
>    901	}
>    902
>    903	size_t crash_get_memory_size(void)
>    904	{
>    905		size_t size = 0;
>    906
>    907		mutex_lock(&kexec_mutex);
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


Hidehiro Kawai
Hitachi, Ltd. Research & Development Group



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
