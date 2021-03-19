Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lNEP4-007PhE-H4
 for kexec@lists.infradead.org; Fri, 19 Mar 2021 12:39:00 +0000
Date: Fri, 19 Mar 2021 20:38:45 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] crash_dump: remove duplicate include in crash_dump.h
Message-ID: <20210319123845.GA2289@MiWiFi-R3L-srv>
References: <20210313103521.364854-1-zhang.yunkai@zte.com.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210313103521.364854-1-zhang.yunkai@zte.com.cn>
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
To: menglong8.dong@gmail.com
Cc: dyoung@redhat.com, vgoyal@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, tiantao6@hisilicon.com, Zhang Yunkai <zhang.yunkai@zte.com.cn>

On 03/13/21 at 02:35am, menglong8.dong@gmail.com wrote:
> From: Zhang Yunkai <zhang.yunkai@zte.com.cn>
> 
> 'linux/pgtable.h' included in 'crash_dump.h' is duplicated.
> It is also included in the 8th line.

Tian Tao posted one to address the same issue, his log is better. Please
update with below to repost.

linux/pgtable.h is included more than once, Remove the one that isn't
necessary.

> 
> Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
> ---
>  include/linux/crash_dump.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
> index a5192b718dbe..6bd8a33cb740 100644
> --- a/include/linux/crash_dump.h
> +++ b/include/linux/crash_dump.h
> @@ -8,8 +8,6 @@
>  #include <linux/pgtable.h>
>  #include <uapi/linux/vmcore.h>
>  
> -#include <linux/pgtable.h> /* for pgprot_t */
> -
>  #ifdef CONFIG_CRASH_DUMP
>  #define ELFCORE_ADDR_MAX	(-1ULL)
>  #define ELFCORE_ADDR_ERR	(-2ULL)
> -- 
> 2.25.1
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
