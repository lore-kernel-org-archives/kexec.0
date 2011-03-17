Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Q06vo-0003mS-8I
	for kexec@lists.infradead.org; Thu, 17 Mar 2011 06:43:37 +0000
Date: Thu, 17 Mar 2011 15:39:12 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: [PATCH] makedumpfile: s390x: Fix KVBASE to correct value for
	s390x arcitecture.
Message-Id: <20110317153912.de4162a9.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <20110315170902.32471.52757.stgit@mars.in.ibm.com>
References: <20110315170902.32471.52757.stgit@mars.in.ibm.com>
Mime-Version: 1.0
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
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, kexec-ml <kexec@lists.infradead.org>, Michael Holzheu <holzheu@de.ibm.com>, Sachin P Sant <sachinp@in.ibm.com>, Reinhard <BUENDGEN@de.ibm.com>


Hi Mahesh,

On Tue, 15 Mar 2011 22:39:23 +0530
Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
>
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> While excluding free pages from s390x dumps taken on LPAR, makedumpfile
> fails to convert page address to pfn. The reason is, the memory for
> mem_section structure is allocated below '_stext' and since KVBASE is
> set to SYMBOL(_stext), the function is_kvaddr() fails and return NULL
> address.

Why do we need this patch ?
to support the latest kernel version of s390 ?
or to support LPAR of s390 ?

I'd like to know whether we need a similar change for the other architecture.
I will appreciate if getting a hint.


Thanks
Ken'ichi Ohmichi

> Set KVBASE to KENRELBASE(0) for s390x architecture to fix this issue.
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> ---
> 
>  makedumpfile.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 11e1a93..4ec77b7 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -615,7 +615,7 @@ do { \
>  #ifdef __s390x__
>  #define __PAGE_OFFSET		(info->page_size - 1)
>  #define KERNELBASE		(0)
> -#define KVBASE			(SYMBOL(_stext))
> +#define KVBASE			KERNELBASE
>  #define _SECTION_SIZE_BITS	(28)
>  #define _MAX_PHYSMEM_BITS	(42)
>  
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
