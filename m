Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g3Ayq-0008K9-7k
 for kexec@lists.infradead.org; Fri, 21 Sep 2018 02:15:41 +0000
Date: Fri, 21 Sep 2018 10:15:24 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] kernel: kexec_file: remove some duplicated include file
Message-ID: <20180921021524.GP2555@MiWiFi-R3L-srv>
References: <1537420323-30658-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1537420323-30658-1-git-send-email-zhongjiang@huawei.com>
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
To: zhong jiang <zhongjiang@huawei.com>
Cc: kexec@lists.infradead.org, ebiederm@xmission.com, linux-kernel@vger.kernel.org

On 09/20/18 at 01:12pm, zhong jiang wrote:
> kexec.h and slab.h have duplicated include. hence just remove
> redundant file.

They have duplicated include, why do you remove both of them?

> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  kernel/kexec_file.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index c6a3b68..35cf0ad 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -25,8 +25,6 @@
>  #include <linux/elf.h>
>  #include <linux/elfcore.h>
>  #include <linux/kernel.h>
> -#include <linux/kexec.h>
> -#include <linux/slab.h>
>  #include <linux/syscalls.h>
>  #include <linux/vmalloc.h>
>  #include "kexec_internal.h"
> -- 
> 1.7.12.4
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
