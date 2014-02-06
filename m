Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WBJQI-0006Dj-7Q
 for kexec@lists.infradead.org; Thu, 06 Feb 2014 07:30:58 +0000
Date: Thu, 6 Feb 2014 16:30:33 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: PATCH: kexec/i386 fix build failure (bzImage_support_efi_boot)
Message-ID: <20140206073033.GC24865@verge.net.au>
References: <52F2BBF2.8080907@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52F2BBF2.8080907@suse.de>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Tony Jones <tonyj@suse.de>
Cc: kexec@lists.infradead.org

On Wed, Feb 05, 2014 at 02:32:18PM -0800, Tony Jones wrote:
> Commit 9c200a85de2245a850546fded96a1977b84ad24d referenced 
> 'bzImage_support_efi_boot' without matching 32-bit definition.
> 
> Signed-off-by: Tony Jones <tonyj@suse.de>

Thanks, applied.

> ---
>  kexec/arch/i386/kexec-bzImage.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- a/kexec/arch/i386/kexec-bzImage.c
> +++ b/kexec/arch/i386/kexec-bzImage.c
> @@ -40,6 +40,7 @@
>  #include <arch/options.h>
>  
>  static const int probe_debug = 0;
> +int bzImage_support_efi_boot = 0;
>  
>  int bzImage_probe(const char *buf, off_t len)
>  {
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
