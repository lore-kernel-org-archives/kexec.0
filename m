Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1T5mrd-0004cL-N4
 for kexec@lists.infradead.org; Mon, 27 Aug 2012 00:07:36 +0000
Date: Mon, 27 Aug 2012 09:07:20 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kdump: remove unused including <generated/utsrelease.h>
Message-ID: <20120827000720.GA27105@verge.net.au>
References: <CAPgLHd_ndLkDD7Q1WyqHifMYek9U3-cY0xrNdWfu+tfiDtiHdw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPgLHd_ndLkDD7Q1WyqHifMYek9U3-cY0xrNdWfu+tfiDtiHdw@mail.gmail.com>
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
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: yongjun_wei@trendmicro.com.cn, kexec@lists.infradead.org, ebiederm@xmission.com, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org

On Sat, Aug 25, 2012 at 10:18:20AM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> 
> Remove including <generated/utsrelease.h> that don't need it.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Reviewed-by: Simon Horman <horms@verge.net.au

Andrew, could you consider picking this up?

> ---
>  kernel/kexec.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 0668d58..5e4bd78 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -21,7 +21,6 @@
>  #include <linux/hardirq.h>
>  #include <linux/elf.h>
>  #include <linux/elfcore.h>
> -#include <generated/utsrelease.h>
>  #include <linux/utsname.h>
>  #include <linux/numa.h>
>  #include <linux/suspend.h>
> 
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
