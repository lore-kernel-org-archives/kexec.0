Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a7iBl-0001t5-6U
 for kexec@lists.infradead.org; Sat, 12 Dec 2015 11:18:10 +0000
Date: Sat, 12 Dec 2015 12:17:43 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [V6 PATCH 0/6] Fix race issues among panic, NMI and crash_kexec
Message-ID: <20151212111743.GA3723@pd.tnic>
References: <20151210014624.25437.50028.stgit@softrs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20151210014624.25437.50028.stgit@softrs>
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
Cc: x86@kernel.org, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Michal Hocko <mhocko@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

On Thu, Dec 10, 2015 at 10:46:24AM +0900, Hidehiro Kawai wrote:
> Hidehiro Kawai (6):
>       panic/x86: Fix re-entrance problem due to panic on NMI
>       panic/x86: Allow CPUs to save registers even if they are looping in NMI context
>       kexec: Fix race between panic() and crash_kexec() called directly
>       x86/apic: Introduce apic_extnmi boot option
>       x86/nmi: Fix to save registers for crash dump on external NMI broadcast
>       Documentation: Add documentation for kernel.panic_on_io_nmi sysctl
> 
> 
>  Documentation/kernel-parameters.txt |    9 +++++++++
>  Documentation/sysctl/kernel.txt     |   15 +++++++++++++++
>  arch/x86/include/asm/apic.h         |    5 +++++
>  arch/x86/include/asm/reboot.h       |    1 +
>  arch/x86/kernel/apic/apic.c         |   35 +++++++++++++++++++++++++++++++++--
>  arch/x86/kernel/nmi.c               |   27 ++++++++++++++++++++++-----
>  arch/x86/kernel/reboot.c            |   28 ++++++++++++++++++++++++++++
>  include/linux/kernel.h              |   29 +++++++++++++++++++++++++++++
>  include/linux/kexec.h               |    2 ++
>  kernel/kexec_core.c                 |   30 +++++++++++++++++++++++++++++-
>  kernel/panic.c                      |   29 ++++++++++++++++++++++++-----
>  kernel/watchdog.c                   |    2 +-
>  12 files changed, 198 insertions(+), 14 deletions(-)

All applied,
thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
