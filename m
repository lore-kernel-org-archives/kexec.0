Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail7.hitachi.co.jp ([133.145.228.42])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZgQLO-0001sT-9A
 for kexec@lists.infradead.org; Mon, 28 Sep 2015 04:47:19 +0000
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
 <hidehiro.kawai.ez@hitachi.com>
Subject: RE: Re: [V4 PATCH 3/4] kexec: Fix race between panic() and
 crash_kexec() called directly
Date: Mon, 28 Sep 2015 04:46:52 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A84454994A2D@GSjpTKYDCembx31.service.hitachi.net>
References: <20150925112809.4258.39950.stgit@softrs>
 <201509281254.KxcIfuxt%fengguang.wu@intel.com>
In-Reply-To: <201509281254.KxcIfuxt%fengguang.wu@intel.com>
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
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "x86@kernel.org" <x86@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Michal Hocko <mhocko@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>, "kbuild-all@01.org" <kbuild-all@01.org>

> Hi Hidehiro,
> 
> [auto build test results on v4.3-rc2 -- if it's inappropriate base, please ignore]
> 
> config: x86_64-allnoconfig (attached as .config)
> reproduce:
>   git checkout 0077681103150af584e5e592c0238fd010654c26
>   # save the attached .config to linux build tree
>   make ARCH=x86_64
> 
> All error/warnings (new ones prefixed by >>):
> 
>    kernel/panic.c: In function 'panic':
> >> kernel/panic.c:140:3: error: implicit declaration of function '__crash_kexec' [-Werror=implicit-function-declaration]
>       __crash_kexec(NULL);
>       ^

Sorry, I missed to take into account the case of !CONFIG_KEXEC_CORE.

 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
+static inline void __crash_kexec(struct pt_regs *regs) { }
 static inline void crash_kexec(struct pt_regs *regs) { }
 static inline int kexec_should_crash(struct task_struct *p) { return 0; }

I'll resend the revised version later.

>    cc1: some warnings being treated as errors
> 
> vim +/__crash_kexec +140 kernel/panic.c
> 
>    134		 * If we have crashed and we have a crash kernel loaded let it handle
>    135		 * everything else.
>    136		 * If we want to run this after calling panic_notifiers, pass
>    137		 * the "crash_kexec_post_notifiers" option to the kernel.
>    138		 */
>    139		if (!crash_kexec_post_notifiers)
>  > 140			__crash_kexec(NULL);
>    141
>    142		/*
>    143		 * Note smp_send_stop is the usual smp shutdown function, which
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
