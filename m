Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGY4O-00023h-FZ
 for kexec@lists.infradead.org; Fri, 11 Sep 2020 01:41:45 +0000
Date: Fri, 11 Sep 2020 09:40:14 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] crash_dump: Remove the unused include statements
Message-ID: <20200911014014.GA27590@MiWiFi-R3L-srv>
References: <1599727742-19329-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
In-Reply-To: <1599727742-19329-1-git-send-email-tiantao6@hisilicon.com>
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
Cc: kexec@lists.infradead.org, akpm@linux-foundation.org, dyoung@redhat.com, linuxarm@huawei.com, vgoyal@redhat.com

On 09/10/20 at 04:49pm, Tian Tao wrote:
> linux/pgtable.h is included more than once, Remove the one that isn't
> necessary.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

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


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
