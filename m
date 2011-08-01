Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1Qnyuw-0001YC-Eo
	for kexec@lists.infradead.org; Mon, 01 Aug 2011 20:16:51 +0000
Date: Mon, 1 Aug 2011 16:16:44 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [patch v2 01/10] kdump: Add KEXEC_CRASH_CONTROL_MEMORY_LIMIT
Message-ID: <20110801201644.GG3805@redhat.com>
References: <20110727125504.491183728@linux.vnet.ibm.com>
	<20110727125807.529303146@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110727125807.529303146@linux.vnet.ibm.com>
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
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, horms@verge.net.au, ebiederm@xmission.com, schwidefsky@de.ibm.com, kexec@lists.infradead.org

On Wed, Jul 27, 2011 at 02:55:05PM +0200, Michael Holzheu wrote:
> From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> 
> On s390 there is a different KEXEC_CONTROL_MEMORY_LIMIT for the normal and
> the kdump kexec case. Therefore this patch introduces a new macro
> KEXEC_CRASH_CONTROL_MEMORY_LIMIT. This is set to
> KEXEC_CONTROL_MEMORY_LIMIT for all architectures that do not define
> KEXEC_CRASH_CONTROL_MEMORY_LIMIT.

Hi Michael,

Curious that why limit is different for kexec and kdump cases on s390
only.

Thanks
Vivek

> 
> Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
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
