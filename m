Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cgiQz-0002RH-SP
 for kexec@lists.infradead.org; Thu, 23 Feb 2017 01:43:07 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20170222224646.GC14311@altlinux.org>
Date: Thu, 23 Feb 2017 14:37:46 +1300
In-Reply-To: <20170222224646.GC14311@altlinux.org> (Dmitry V. Levin's message
 of "Thu, 23 Feb 2017 01:46:46 +0300")
Message-ID: <87h93l3cwl.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH] uapi: fix linux/kexec.h userspace compilation errors
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
To: "Dmitry V. Levin" <ldv@altlinux.org>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

"Dmitry V. Levin" <ldv@altlinux.org> writes:

> Include <stddef.h> (guarded by #ifndef __KERNEL__) to fix the following
> linux/kexec.h userspace compilation errors:
>
> /usr/include/linux/kexec.h:53:2: error: unknown type name 'size_t'
>   size_t bufsz;
> /usr/include/linux/kexec.h:55:2: error: unknown type name 'size_t'
>   size_t memsz;

Were these failures generated with a static checker?

What changed that you are seeing new failures in old essentially static
headers?

Eric




> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>  include/uapi/linux/kexec.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
> index aae5ebf..7def5f5 100644
> --- a/include/uapi/linux/kexec.h
> +++ b/include/uapi/linux/kexec.h
> @@ -45,6 +45,9 @@
>  #define KEXEC_SEGMENT_MAX 16
>  
>  #ifndef __KERNEL__
> +
> +#include <stddef.h>    /* For size_t. */
> +
>  /*
>   * This structure is used to hold the arguments that are used when
>   * loading  kernel binaries.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
