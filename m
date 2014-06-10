Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WuVja-0007mx-KV
 for kexec@lists.infradead.org; Tue, 10 Jun 2014 23:45:43 +0000
Date: Wed, 11 Jun 2014 08:45:19 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] vmcore-dmesg: don't enforce largefile handling
Message-ID: <20140610234518.GC20738@verge.net.au>
References: <1402428569-3669-1-git-send-email-yegorslists@googlemail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1402428569-3669-1-git-send-email-yegorslists@googlemail.com>
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
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: Peter Korsgaard <jacmet@sunsite.dk>, kexec@lists.infradead.org

On Tue, Jun 10, 2014 at 09:29:29PM +0200, Yegor Yefremov wrote:
> Breaks build on !largefile toolchains.
> 
> Instead simply use whatever mode is selected by toolchain / CFLAGS.

Perhaps the use of configure or something similar is in order
to select these options if they are available. It seems
to me that one would want them if one can have them.

> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> ---
>  vmcore-dmesg/vmcore-dmesg.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/vmcore-dmesg/vmcore-dmesg.c b/vmcore-dmesg/vmcore-dmesg.c
> index f47ee11..9bb1cc2 100644
> --- a/vmcore-dmesg/vmcore-dmesg.c
> +++ b/vmcore-dmesg/vmcore-dmesg.c
> @@ -1,6 +1,4 @@
>  #define _XOPEN_SOURCE 600
> -#define _LARGEFILE_SOURCE 1
> -#define _FILE_OFFSET_BITS 64
>  #include <endian.h>
>  #include <byteswap.h>
>  #include <stdio.h>
> -- 
> 1.8.3.2
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
