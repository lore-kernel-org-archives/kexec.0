Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OgC4S-0006fT-25
	for kexec@lists.infradead.org; Tue, 03 Aug 2010 07:37:56 +0000
Subject: Re: [PATCH] kexec: set prstatus.pr_pid to cpu id when current->pid is
	0
References: <AANLkTikuUi=i6Lk-ZpE65Gr0tWOeVnrnpWPe85T=J=Ph@mail.gmail.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 03 Aug 2010 00:37:46 -0700
In-Reply-To: <AANLkTikuUi=i6Lk-ZpE65Gr0tWOeVnrnpWPe85T=J=Ph@mail.gmail.com>
	(Hui Zhu's message of "Tue\, 3 Aug 2010 15\:21\:49 +0800")
Message-ID: <m1zkx4w3hx.fsf@fess.ebiederm.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Hui Zhu <teawater@gmail.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Simon Kagstrom <simon.kagstrom@netinsight.net>, WANG Cong <xiyou.wangcong@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

Hui Zhu <teawater@gmail.com> writes:

> Hi,
>
> I found that from gdb 7.1 to gdb-cvs-head cannot analyze the core file
> that get from kdump.
> What I got:
> [New <main task>]
> [New Thread 2719]
> ../../src/gdb/thread.c:884: internal-error: switch_to_thread:
> Assertion `inf != NULL' failed.
> A problem internal to GDB has been detected,
> further debugging may prove unreliable.
> Quit this debugging session? (y or n)
> That is because:
>  objdump -h ./vmcore
>
> ./vmcore:     file format elf64-x86-64
>
> Sections:
> Idx Name          Size      VMA               LMA               File off  Algn
>   0 note0         00000a48  0000000000000000  0000000000000000  00000238  2**0
>                   CONTENTS, READONLY
>   1 .reg/0        000000d8  0000000000000000  0000000000000000  000002bc  2**2
>                   CONTENTS
>   2 .reg          000000d8  0000000000000000  0000000000000000  000002bc  2**2
>                   CONTENTS
>   3 .reg/2719     000000d8  0000000000000000  0000000000000000  00000420  2**2
>                   CONTENTS
>   4 .reg/0        000000d8  0000000000000000  0000000000000000  00000584  2**2
>                   CONTENTS
>   5 .reg/0        000000d8  0000000000000000  0000000000000000  000006e8  2**2
>                   CONTENTS
> Each of reg/n is a cpu core note.  It will be a GDB thread.  n is the
> prstatus.pr_pid that will be the thread lwpid.  Because the 3 threads
> pid is same, so GDB get error.
>
> current->pid is 0 because this cpu is in idle.  So I add a check, set
> prstatus.pr_pid to cpu id when current->pid is 0.  Then GDB work OK
> with the core.

That is a gdb limitation.  It looks to me like applying this patch will
loose information, and give you no guarantee that prstatus.pr_pid will
not equal 0.

If you want to change something please do it in a post processing tool.

Eric


> Thanks,
> Hui
>
> Signed-off-by: Hui Zhu <teawater@gmail.com>
> ---
>  kernel/kexec.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -1191,7 +1191,10 @@ void crash_save_cpu(struct pt_regs *regs
>  	if (!buf)
>  		return;
>  	memset(&prstatus, 0, sizeof(prstatus));
> -	prstatus.pr_pid = current->pid;
> +	if (current->pid)
> +		prstatus.pr_pid = current->pid;
> +	else
> +		prstatus.pr_pid = cpu;
>  	elf_core_copy_kernel_regs(&prstatus.pr_reg, regs);
>  	buf = append_elf_note(buf, KEXEC_CORE_NOTE_NAME, NT_PRSTATUS,
>  		      	      &prstatus, sizeof(prstatus));

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
