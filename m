Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZNinW-0004Vt-50
 for kexec@lists.infradead.org; Fri, 07 Aug 2015 14:39:02 +0000
Received: by wibxm9 with SMTP id xm9so64169015wib.0
 for <kexec@lists.infradead.org>; Fri, 07 Aug 2015 07:38:40 -0700 (PDT)
Date: Fri, 7 Aug 2015 16:38:37 +0200
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [V3 PATCH 0/4] Fix race issues among panic, NMI and crash_kexec
Message-ID: <20150807143836.GI30785@dhcp22.suse.cz>
References: <20150806054543.25766.29590.stgit@softrs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150806054543.25766.29590.stgit@softrs>
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
To: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: x86@kernel.org, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

JFYI I have those patches tested on the largish box. Will come back to
you as soon as I have some feedback.

I will also try to review these patches sometimes next week.

Thanks!

On Thu 06-08-15 14:45:43, Hidehiro Kawai wrote:
> When an HA cluster software or administrator detects non-response
> of a host, they issue an NMI to the host to completely stop current
> works and take a crash dump.  If the kernel has already panicked
> or is capturing a crash dump at that time, further NMI can cause
> a crash dump failure.
> 
> Also, crash_kexec() called from oops context and panic() can
> cause race conditions.
> 
> To solve these issue, this patch set does following things:
> 
> - Don't panic on NMI if the kernel has already panicked
> - Extend exclusion control currently done by panic_lock to crash_kexec
> - Introduce "noextnmi" boot option which masks external NMI at the
>   boot time (supported only for x86)
> 
> V3:
> - Introduce nmi_panic() macro to reduce code duplication
> - In the case of panic on NMI, don't return from NMI handlers
>   if another cpu already panicked
> 
> V2:
> - Use atomic_cmpxchg() instead of current spin_trylock() to exclude
>   concurrent accesses to panic() and crash_kexec()
> - Don't introduce no-lock version of panic() and crash_kexec()
> 
> ---
> 
> Hidehiro Kawai (4):
>       panic/x86: Fix re-entrance problem due to panic on NMI
>       panic/x86: Allow cpus to save registers even if they are looping in NMI context
>       kexec: Fix race between panic() and crash_kexec() called directly
>       x86/apic: Introduce noextnmi boot option
> 
> 
>  Documentation/kernel-parameters.txt |    4 ++++
>  arch/x86/kernel/apic/apic.c         |   17 ++++++++++++++++-
>  arch/x86/kernel/nmi.c               |   15 +++++++++++----
>  arch/x86/kernel/reboot.c            |   11 +++++++++++
>  include/linux/kernel.h              |   21 +++++++++++++++++++++
>  kernel/kexec.c                      |   20 ++++++++++++++++++++
>  kernel/panic.c                      |   23 ++++++++++++++++++++---
>  kernel/watchdog.c                   |    5 +++--
>  8 files changed, 106 insertions(+), 10 deletions(-)
> 
> 
> -- 
> Hidehiro Kawai
> Hitachi, Ltd. Research & Development Group
> 
> 

-- 
Michal Hocko
SUSE Labs

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
