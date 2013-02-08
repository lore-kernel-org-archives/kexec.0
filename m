Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U3jmQ-0003R0-F7
 for kexec@lists.infradead.org; Fri, 08 Feb 2013 08:58:00 +0000
Date: Fri, 8 Feb 2013 17:49:44 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH 2/2 v2] kexec: Export PG_hwpoison flag into vmcoreinfo
Message-Id: <20130208174944.96a3b50952e45e1219a94819@mxc.nes.nec.co.jp>
In-Reply-To: <50913011.2030900@hitachi.com>
References: <508FDEF3.8030601@hitachi.com> <20121030143750.GF2290@redhat.com>
 <50913011.2030900@hitachi.com>
Mime-Version: 1.0
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
To: mitsuhiro.tanino.gm@hitachi.com
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com, ebiederm@xmission.com

Hello,

On Wed, 31 Oct 2012 23:05:05 +0900
Mitsuhiro Tanino <mitsuhiro.tanino.gm@hitachi.com> wrote:

> This patch exports a PG_hwpoison into vmcoreinfo when
> CONFIG_MEMORY_FAILURE is defined.
> "makedumpfile" needs to read information of memory, such as
> 'mem_section', 'zone', 'pageflags' from vmcore.
> 
> We introduce a function into "makedumpfile" to exclude
> hwpoison page from vmcore dump.
> In order to introduce this function, PG_hwpoison flag have
> to export into vmcoreinfo.
> 
> Signed-off-by: Mitsuhiro Tanino <mitsuhiro.tanino.gm@hitachi.com>

I'm curious to know the status of this patch because I'll release
makedumpfile-1.5.2 with the feature to exclude hwpoison page soon.


Thanks
Atsushi Kumagai

> ---
>  kernel/kexec.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 0668d58..0d5d6bc 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -1513,6 +1513,9 @@ static int __init crash_save_vmcoreinfo_init(void)
>         VMCOREINFO_NUMBER(PG_lru);
>         VMCOREINFO_NUMBER(PG_private);
>         VMCOREINFO_NUMBER(PG_swapcache);
> +#ifdef CONFIG_MEMORY_FAILURE
> +       VMCOREINFO_NUMBER(PG_hwpoison);
> +#endif
> 
>         arch_crash_save_vmcoreinfo();
>         update_vmcoreinfo_note();
> --
> 1.7.10.1
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
