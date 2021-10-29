Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mgOC2-00AULT-Vb
 for kexec@lists.infradead.org; Fri, 29 Oct 2021 09:29:00 +0000
Date: Fri, 29 Oct 2021 17:28:30 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2] crash_dump: remove duplicate include in crash_dump.h
Message-ID: <20211029092830.GJ27625@MiWiFi-R3L-srv>
References: <20211020015357.GD27625@MiWiFi-R3L-srv>
 <20211020090659.1038877-1-ye.guojin@zte.com.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211020090659.1038877-1-ye.guojin@zte.com.cn>
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
To: cgel.zte@gmail.com
Cc: dyoung@redhat.com, kexec@lists.infradead.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, rppt@linux.ibm.com, vgoyal@redhat.com, ye.guojin@zte.com.cn, zealci@zte.com.cn

On 10/20/21 at 09:06am, cgel.zte@gmail.com wrote:
> From: Ye Guojin <ye.guojin@zte.com.cn>
> 
> In crash_dump.h, header file <linux/pgtable.h> is included twice. This
> duplication was introduced in commit 65fddcfca8ad("mm: reorder includes
> after introduction of linux/pgtable.h") where the order of the header
> files is adjusted, while the old one was not removed.
> 
> Clean it up here.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Acked-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>

Thanks, add Andrew to CC.

> ---
> v2:
> - update the commit log
> ---
>  include/linux/crash_dump.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
> index 0c547d866f1e..b7b255b23b99 100644
> --- a/include/linux/crash_dump.h
> +++ b/include/linux/crash_dump.h
> @@ -8,8 +8,6 @@
>  #include <linux/pgtable.h>
>  #include <uapi/linux/vmcore.h>
> 
> -#include <linux/pgtable.h> /* for pgprot_t */
> -
>  /* For IS_ENABLED(CONFIG_CRASH_DUMP) */
>  #define ELFCORE_ADDR_MAX       (-1ULL)
>  #define ELFCORE_ADDR_ERR       (-2ULL)
> -- 
> 2.25.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
