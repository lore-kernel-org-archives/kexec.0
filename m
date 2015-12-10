Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail7.hitachi.co.jp ([133.145.228.42])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a6uqK-0005XW-Hb
 for kexec@lists.infradead.org; Thu, 10 Dec 2015 06:36:45 +0000
From: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?=
 <hidehiro.kawai.ez@hitachi.com>
Subject: RE: Re: [V6 PATCH 5/6] x86/nmi: Fix to save registers for crash
 dump on external NMI broadcast
Date: Thu, 10 Dec 2015 06:36:20 +0000
Message-ID: <04EAB7311EE43145B2D3536183D1A84454A4EA10@GSjpTKYDCembx31.service.hitachi.net>
References: <20151210014634.25437.217.stgit@softrs>
 <201512101102.6UNkKzbX%fengguang.wu@intel.com>
In-Reply-To: <201512101102.6UNkKzbX%fengguang.wu@intel.com>
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
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "x86@kernel.org" <x86@kernel.org>, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Eric
 W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, Borislav Petkov <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>, "kbuild-all@01.org" <kbuild-all@01.org>

Hi Steven,

> From: Steven Rostedt [mailto:rostedt@goodmis.org]
> On Tue, Nov 24, 2015 at 11:48:53AM +0100, Borislav Petkov wrote:
> > > +	 */
> > > +	while (!raw_spin_trylock(&nmi_reason_lock))
> > > +		poll_crash_ipi_and_callback(regs);
> >
> > Waaait a minute: so if we're getting NMIs broadcasted on every core but
> > we're *not* crash dumping, we will run into here too. This can't be
> > right. :-\
> 
> This only does something if crash_ipi_done is set, which means you are killing
> the box. But perhaps a comment that states that here would be useful, or maybe
> just put in the check here. There's no need to make it depend on SMP, as
> raw_spin_trylock() will turn to just ({1}) for UP, and that code wont even be
> hit.

It seems that poll_crash_ipi_and_callback (now renamed to run_crash_ipi_callback)
is referred for UP if CONFIG_DEBUG_SPINLOCK=y, and it causes a build error
as below.  run_crash_ipi_callback refers crash_ipi_issued and crash_nmi_callback,
which are defined only if CONFIG_SMP=y.  So we need to defined it separately
for SMP and UP.

I'll resend this patch later.

> Hi Hidehiro,
> 
> [auto build test ERROR on v4.4-rc4]
> [also build test ERROR on next-20151209]
> [cannot apply to tip/x86/core]
> 
> url:
> https://github.com/0day-ci/linux/commits/Hidehiro-Kawai/Fix-race-issues-among-panic-NMI-and-crash_kexec/20151210-095
> 254
> config: x86_64-randconfig-s4-12101030 (attached as .config)
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
> 
> All errors (new ones prefixed by >>):
> 
>    arch/x86/built-in.o: In function `do_nmi':
> >> (.text+0x7339): undefined reference to `run_crash_ipi_callback'
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
