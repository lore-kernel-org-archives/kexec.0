Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QuQ09-0000Tr-2f
	for kexec@lists.infradead.org; Fri, 19 Aug 2011 14:24:49 +0000
Date: Fri, 19 Aug 2011 10:24:03 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [patch 1/2] kdump: Add KEXEC_CRASH_CONTROL_MEMORY_LIMIT
Message-ID: <20110819142403.GF18656@redhat.com>
References: <20110819141857.052232873@linux.vnet.ibm.com>
	<20110819141940.177788593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110819141940.177788593@linux.vnet.ibm.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, horms@verge.net.au, ebiederm@xmission.com, schwidefsky@de.ibm.com, akpm@linux-foundation.org, kexec@lists.infradead.org

On Fri, Aug 19, 2011 at 04:18:58PM +0200, Michael Holzheu wrote:
> From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> 
> On s390 there is a different KEXEC_CONTROL_MEMORY_LIMIT for the normal and
> the kdump kexec case. Therefore this patch introduces a new macro
> KEXEC_CRASH_CONTROL_MEMORY_LIMIT. This is set to
> KEXEC_CONTROL_MEMORY_LIMIT for all architectures that do not define
> KEXEC_CRASH_CONTROL_MEMORY_LIMIT.
> 
> Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>

Looks good to me. 

Acked-by: Vivek Goyal <vgoyal@redhat.com>

Vivek

> ---
>  include/linux/kexec.h |    4 ++++
>  kernel/kexec.c        |    2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -33,6 +33,10 @@
>  #error KEXEC_ARCH not defined
>  #endif
>  
> +#ifndef KEXEC_CRASH_CONTROL_MEMORY_LIMIT
> +#define KEXEC_CRASH_CONTROL_MEMORY_LIMIT KEXEC_CONTROL_MEMORY_LIMIT
> +#endif
> +
>  #define KEXEC_NOTE_HEAD_BYTES ALIGN(sizeof(struct elf_note), 4)
>  #define KEXEC_CORE_NOTE_NAME "CORE"
>  #define KEXEC_CORE_NOTE_NAME_BYTES ALIGN(sizeof(KEXEC_CORE_NOTE_NAME), 4)
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -498,7 +498,7 @@ static struct page *kimage_alloc_crash_c
>  	while (hole_end <= crashk_res.end) {
>  		unsigned long i;
>  
> -		if (hole_end > KEXEC_CONTROL_MEMORY_LIMIT)
> +		if (hole_end > KEXEC_CRASH_CONTROL_MEMORY_LIMIT)
>  			break;
>  		if (hole_end > crashk_res.end)
>  			break;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
