Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGSMN-0007Af-GB
 for kexec@lists.infradead.org; Thu, 10 Sep 2020 19:35:56 +0000
Received: by mail-oi1-f199.google.com with SMTP id c187so2611409oia.20
 for <kexec@lists.infradead.org>; Thu, 10 Sep 2020 12:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <1599727742-19329-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1599727742-19329-1-git-send-email-tiantao6@hisilicon.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Fri, 11 Sep 2020 01:05:37 +0530
Message-ID: <CACi5LpOWd3hT4zOcP_-wB_g_Ex-ica+6B9sYzydmRd6v20mpxQ@mail.gmail.com>
Subject: Re: [PATCH] crash_dump: Remove the unused include statements
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
Cc: kexec mailing list <kexec@lists.infradead.org>, RuiRui Yang <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Baoquan He <bhe@redhat.com>, linuxarm@huawei.com

Hi Tian,

On Thu, Sep 10, 2020 at 2:22 PM Tian Tao <tiantao6@hisilicon.com> wrote:
>
> linux/pgtable.h is included more than once, Remove the one that isn't
> necessary.
>
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
>  #define ELFCORE_ADDR_MAX       (-1ULL)
>  #define ELFCORE_ADDR_ERR       (-2ULL)
> --

LGTM, so:
Reviewed-by: Bhupesh Sharma <bhsharma@redhat.com>

Thanks.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
