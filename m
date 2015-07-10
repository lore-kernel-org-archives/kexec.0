Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20150710113331.4368.10495.stgit@softrs>
 <20150710113331.4368.63745.stgit@softrs>
Date: Fri, 10 Jul 2015 08:41:28 -0500
In-Reply-To: <20150710113331.4368.63745.stgit@softrs> (Hidehiro Kawai's
 message of "Fri, 10 Jul 2015 20:33:31 +0900")
Message-ID: <87wpy82kqf.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] panic: Disable crash_kexec_post_notifiers if kdump is
 not available
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
Cc: linux-mips@linux-mips.org, Baoquan He <bhe@redhat.com>, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-metag@vger.kernel.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, linux-arm-kernel@lists.infradead.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Daniel Walker <dwalker@fifo99.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com> writes:

> You can call panic notifiers and kmsg dumpers before kdump by
> specifying "crash_kexec_post_notifiers" as a boot parameter.
> However, it doesn't make sense if kdump is not available.  In that
> case, disable "crash_kexec_post_notifiers" boot parameter so that
> you can't change the value of the parameter.

Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>

You are confusing kexec on panic and CONFIG_CRASH_DUMP
which is about the tools for reading the state of the previous kernel.

Eric

> Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> ---
>  kernel/panic.c |    2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 04e91ff..5252331 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -502,12 +502,14 @@ __visible void __stack_chk_fail(void)
>  core_param(pause_on_oops, pause_on_oops, int, 0644);
>  core_param(panic_on_warn, panic_on_warn, int, 0644);
>  
> +#ifdef CONFIG_CRASH_DUMP
>  static int __init setup_crash_kexec_post_notifiers(char *s)
>  {
>  	crash_kexec_post_notifiers = true;
>  	return 0;
>  }
>  early_param("crash_kexec_post_notifiers", setup_crash_kexec_post_notifiers);
> +#endif
>  
>  static int __init oops_setup(char *s)
>  {

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
