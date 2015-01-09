Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Y9T3k-0003Pv-SX
 for kexec@lists.infradead.org; Fri, 09 Jan 2015 06:28:37 +0000
Message-ID: <54AF74B7.4000807@suse.de>
Date: Thu, 08 Jan 2015 22:27:03 -0800
From: Tony Jones <tonyj@suse.de>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec/x86: fix crashkernel reserved mem detection
References: <1419514701-9397-1-git-send-email-wolchkov.yuri@gmail.com>
In-Reply-To: <1419514701-9397-1-git-send-email-wolchkov.yuri@gmail.com>
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
To: kexec@lists.infradead.org
Cc: horms@verge.net.au, wolchkov.yuri@gmail.com

On 12/25/2014 05:38 AM, Yuri Volchkov wrote:
> Function crashkernel_mem_callback had wrong parameters type
> So crash_reserved_mem got completely insane values
> As a result kexec was unable to allocate segments for crashkernel
> For instance, I got this message:
> 	"Could not find a free area of memory of 0x9f000 bytes..."
> 
> Signed-off-by: Yuri Volchkov <wolchkov.yuri@gmail.com>

See the patch attached to https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=771671
which also fixes kexec/arch/sh/crashdump-sh.c and kexec/arch/sh/kexec-sh.c

Definitely a problem.  Without the x86 fix we seem same failure on i586

tony

> ---
>  kexec/arch/i386/crashdump-x86.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> index 77bdad5..82bf239 100644
> --- a/kexec/arch/i386/crashdump-x86.c
> +++ b/kexec/arch/i386/crashdump-x86.c
> @@ -1041,8 +1041,8 @@ int get_max_crash_kernel_limit(uint64_t *start, uint64_t *end)
>  
>  static int crashkernel_mem_callback(void *UNUSED(data), int nr,
>                                            char *UNUSED(str),
> -                                          unsigned long base,
> -                                          unsigned long length)
> +                                          unsigned long long base,
> +                                          unsigned long long length)
>  {
>  	if (nr >= CRASH_RESERVED_MEM_NR)
>  		return 1;
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
