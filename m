Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lNENT-007PZh-OW
 for kexec@lists.infradead.org; Fri, 19 Mar 2021 12:37:22 +0000
Date: Fri, 19 Mar 2021 20:36:55 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] crash_dump: Fix duplicate included pgtable.h
Message-ID: <20210319123655.GA18717@MiWiFi-R3L-srv>
References: <1616155393-12188-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
In-Reply-To: <1616155393-12188-1-git-send-email-tiantao6@hisilicon.com>
Content-Disposition: inline
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
To: Tian Tao <tiantao6@hisilicon.com>
Cc: dyoung@redhat.com, kexec@lists.infradead.org

On 03/19/21 at 08:03pm, Tian Tao wrote:
> linux/pgtable.h is included more than once, Remove the one that isn't
> necessary.

This trivial clean up has been posted, I would like to ack that one.
You can ack the patch if you have concern.
https://lore.kernel.org/lkml/20210313103521.364854-1-zhang.yunkai@zte.com.cn/

Thanks anyway.

> 
> Fixes: ca5999fde0a1 ("mm: introduce include/linux/pgtable.h")
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  include/linux/crash_dump.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
> index a5192b7..6bd8a33 100644
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
> 2.7.4
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
