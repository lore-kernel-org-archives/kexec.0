Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lObmD-00EDK6-SU
 for kexec@lists.infradead.org; Tue, 23 Mar 2021 07:48:39 +0000
Date: Tue, 23 Mar 2021 15:48:18 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] crash_dump: Fix duplicate included pgtable.h
Message-ID: <20210323074818.GA20547@MiWiFi-R3L-srv>
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
Cc: dyoung@redhat.com, kexec@lists.infradead.org, akpm@linux-foundation.org

On 03/19/21 at 08:03pm, Tian Tao wrote:
> linux/pgtable.h is included more than once, Remove the one that isn't
> necessary.
> 
> Fixes: ca5999fde0a1 ("mm: introduce include/linux/pgtable.h")
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Thanks, this looks good to me. But the Fixes tag is unnecessary since
this patch is a trivial cleanup, no need to add to stable kernel.
Otherwise,

Acked-by: Baoquan He <bhe@redhat.com>

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
