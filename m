Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WBJQM-0006Dl-Sw
 for kexec@lists.infradead.org; Thu, 06 Feb 2014 07:31:03 +0000
Date: Thu, 6 Feb 2014 16:30:41 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: PATCH: fix redefinition error for e820entry
Message-ID: <20140206073041.GD24865@verge.net.au>
References: <52F2BD4F.10707@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52F2BD4F.10707@suse.com>
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
To: Tony Jones <tonyj@suse.com>
Cc: kexec@lists.infradead.org

On Wed, Feb 05, 2014 at 02:38:07PM -0800, Tony Jones wrote:
> At least on our systems, xenctrl.h defines (unguarded) struct e820entry
> Move the (guarded) definition in include/x86/x86-linux.h to below.
> 
> Signed-off-by: Tony Jones <tonyj@suse.de>

Thanks, applied.

> ---
>  kexec/arch/i386/crashdump-x86.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- a/kexec/arch/i386/crashdump-x86.c
> +++ b/kexec/arch/i386/crashdump-x86.c
> @@ -41,12 +41,13 @@
>  #include "../../crashdump.h"
>  #include "kexec-x86.h"
>  #include "crashdump-x86.h"
> -#include "x86-linux-setup.h"
> 
>  #ifdef HAVE_LIBXENCTRL
>  #include <xenctrl.h>
>  #endif /* HAVE_LIBXENCTRL */
> 
> +#include "x86-linux-setup.h"
> +
>  #include <x86/x86-linux.h>
> 
>  extern struct arch_options_t arch_options;
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
