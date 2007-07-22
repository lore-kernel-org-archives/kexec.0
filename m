Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from py-out-1112.google.com ([64.233.166.181])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1ICQVG-0001Yg-F5
	for kexec@lists.infradead.org; Sat, 21 Jul 2007 21:44:59 -0400
Received: by py-out-1112.google.com with SMTP id a25so2931042pyi
	for <kexec@lists.infradead.org>; Sat, 21 Jul 2007 18:44:56 -0700 (PDT)
Message-ID: <a781481a0707211844s40e203c4t51250ff421d8781d@mail.gmail.com>
Date: Sun, 22 Jul 2007 07:14:56 +0530
From: "Satyam Sharma" <satyam.sharma@gmail.com>
Subject: Re: [PATCH][24/37] Clean up duplicate includes in kernel/
In-Reply-To: <200707211703.30346.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
References: <200707211703.30346.jesper.juhl@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Shailabh Nagar <nagar@watson.ibm.com>, Randy Dunlap <randy.dunlap@oracle.com>, Manfred Spraul <manfred@colorfullife.com>, Thomas Gleixner <tglx@linutronix.de>, Stephen Tweedie <sct@redhat.com>, Ingo Molnar <mingo@elte.hu>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Christoph Lameter <clameter@engr.sgi.com>, Paul McKenney <paulmck@us.ibm.com>, linux-audit@redhat.com, john stultz <johnstul@us.ibm.com>, Eric Biederman <ebiederm@xmission.com>, Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, Rickard Faith <faith@redhat.com>, Josh Triplett <josh@freedesktop.org>

On 7/21/07, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> Hi,
>
> This patch cleans up duplicate includes in
>         kernel/
>
>
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>

Reviewed-by: Satyam Sharma <ssatyam@cse.iitk.ac.in>

[ Jesper, I hope you re-built with all these changes? Some
of these duplicate #include's could have been hiding deeper
header-include-ordering problems, and we'd want to know
about that too. Otherwise looks fairly obvious, thanks. ]

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 145cbb7..5f7dba2 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -45,7 +45,6 @@
>  #include <linux/init.h>
>  #include <asm/types.h>
>  #include <asm/atomic.h>
> -#include <asm/types.h>
>  #include <linux/fs.h>
>  #include <linux/namei.h>
>  #include <linux/mm.h>

Ack

> diff --git a/kernel/exit.c b/kernel/exit.c
> index 464c2b1..9eef513 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -45,7 +45,6 @@
>  #include <linux/resource.h>
>  #include <linux/blkdev.h>
>  #include <linux/task_io_accounting_ops.h>
> -#include <linux/freezer.h>
>
>  #include <asm/uaccess.h>
>  #include <asm/unistd.h>

Ack

> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 25db14b..d8de12e 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -17,7 +17,6 @@
>  #include <linux/highmem.h>
>  #include <linux/syscalls.h>
>  #include <linux/reboot.h>
> -#include <linux/syscalls.h>
>  #include <linux/ioport.h>
>  #include <linux/hardirq.h>
>  #include <linux/elf.h>

Ack

> diff --git a/kernel/rcupdate.c b/kernel/rcupdate.c
> index 2c2dd84..5d9e07e 100644
> --- a/kernel/rcupdate.c
> +++ b/kernel/rcupdate.c
> @@ -45,7 +45,6 @@
>  #include <linux/moduleparam.h>
>  #include <linux/percpu.h>
>  #include <linux/notifier.h>
> -#include <linux/rcupdate.h>
>  #include <linux/cpu.h>
>  #include <linux/mutex.h>

Ack

> diff --git a/kernel/rcutorture.c b/kernel/rcutorture.c
> index ddff332..dd413bf 100644
> --- a/kernel/rcutorture.c
> +++ b/kernel/rcutorture.c
> @@ -35,7 +35,6 @@
>  #include <linux/sched.h>
>  #include <asm/atomic.h>
>  #include <linux/bitops.h>
> -#include <linux/module.h>
>  #include <linux/completion.h>
>  #include <linux/moduleparam.h>
>  #include <linux/percpu.h>

Ack

> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 2222998..e0b2456 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -27,7 +27,6 @@
>  #include <linux/capability.h>
>  #include <linux/ctype.h>
>  #include <linux/utsname.h>
> -#include <linux/capability.h>
>  #include <linux/smp_lock.h>
>  #include <linux/fs.h>
>  #include <linux/init.h>

Ack

> diff --git a/kernel/taskstats.c b/kernel/taskstats.c
> index 059431e..7d4d7f9 100644
> --- a/kernel/taskstats.c
> +++ b/kernel/taskstats.c
> @@ -20,7 +20,6 @@
>  #include <linux/taskstats_kern.h>
>  #include <linux/tsacct_kern.h>
>  #include <linux/delayacct.h>
> -#include <linux/tsacct_kern.h>
>  #include <linux/cpumask.h>
>  #include <linux/percpu.h>
>  #include <net/genetlink.h>

Ack

> diff --git a/kernel/time.c b/kernel/time.c
> index 5b81da0..6304942 100644
> --- a/kernel/time.c
> +++ b/kernel/time.c
> @@ -34,7 +34,6 @@
>  #include <linux/syscalls.h>
>  #include <linux/security.h>
>  #include <linux/fs.h>
> -#include <linux/module.h>
>
>  #include <asm/uaccess.h>
>  #include <asm/unistd.h>

Ack

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
