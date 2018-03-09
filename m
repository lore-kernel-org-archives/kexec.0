Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1euB5K-0008PT-Ih
 for kexec@lists.infradead.org; Fri, 09 Mar 2018 06:00:56 +0000
From: Masaki Tachibana <mas-tachibana@vf.jp.nec.com>
Subject: RE: [PATCH] makedumpfile: fix for hugepages filtering
Date: Fri, 9 Mar 2018 05:58:08 +0000
Message-ID: <61D4E5D821F1674CB87C99F080A210BE01181B92@BPXM01GP.gisp.nec.co.jp>
References: <152053259516.24027.9253761946115314214.stgit@hbathini.in.ibm.com>
In-Reply-To: <152053259516.24027.9253761946115314214.stgit@hbathini.in.ibm.com>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: "ptesarik@suse.cz" <ptesarik@suse.cz>, Masahiko Hayashi <mas-hayashi@tg.jp.nec.com>, Dave Young <dyoung@redhat.com>, Kexec-ml <kexec@lists.infradead.org>, "piliu@redhat.com" <piliu@redhat.com>

Hi Hari,

Thank you for your patch.
It looks good.
I will merge it into V1.6.4.

Thanks
Tachibana

P.S. Sorry. I am prohibited from sending a mail to free mail address such as gmail.com.


> -----Original Message-----
> From: kexec [mailto:kexec-bounces@lists.infradead.org] On Behalf Of Hari Bathini
> Sent: Friday, March 09, 2018 3:10 AM
> To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
> Cc: Dave Young <dyoung@redhat.com>; ptesarik@suse.cz; Kexec-ml <kexec@lists.infradead.org>; piliu@redhat.com;
> andrej.skvortzov@gmail.com
> Subject: [PATCH] makedumpfile: fix for hugepages filtering
> 
> Kernel commit 036e7aa49fb2 changed 'compound_dtor' & 'compound_order'
> types from 'unsigned short' to 'unsigned char'. Fix it here to ensure
> hugepages are filtered properly.
> 
> Also, makedumpfile tool commit 484c6b18624 used 'int' type for 'dtor'
> argument in 'isHugetlb' function. While this works in recent kernels
> that use 'unsigned short/char' type for 'compound_dtor', it breaks
> older kernels that used address of 'free_huge_page' as dtor. Fix it
> by changing 'dtor' type.
> 
> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
> ---
>  makedumpfile.c |   30 ++++++++++++++++++++++++------
>  makedumpfile.h |    1 +
>  2 files changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index ed138d3..ac8483d 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -241,7 +241,7 @@ is_in_same_page(unsigned long vaddr1, unsigned long vaddr2)
>  }
> 
>  static inline int
> -isHugetlb(int dtor)
> +isHugetlb(unsigned long dtor)
>  {
>          return ((NUMBER(HUGETLB_PAGE_DTOR) != NOT_FOUND_NUMBER)
>  		&& (NUMBER(HUGETLB_PAGE_DTOR) == dtor))
> @@ -5798,18 +5798,36 @@ __exclude_unnecessary_pages(unsigned long mem_map,
>  		 * and PGMM_CACHED is a power of 2.
>  		 */
>  		if ((index_pg < PGMM_CACHED - 1) && isCompoundHead(flags)) {
> -			if (order_offset)
> -				compound_order = USHORT(pcache + SIZE(page) + order_offset);
> +			unsigned long long addr =
> +				(unsigned long long)(pcache + SIZE(page));
> +
> +			if (order_offset) {
> +				if (info->kernel_version >=
> +				    KERNEL_VERSION(4, 16, 0)) {
> +					compound_order =
> +						UCHAR(addr + order_offset);
> +				} else {
> +					compound_order =
> +						USHORT(addr + order_offset);
> +				}
> +			}
> 
>  			if (dtor_offset) {
>  				/*
>  				 * compound_dtor has been changed from the address of descriptor
>  				 * to the ID of it since linux-4.4.
>  				 */
> -				if (info->kernel_version >= KERNEL_VERSION(4, 4, 0)) {
> -					compound_dtor = USHORT(pcache + SIZE(page) + dtor_offset);
> +				if (info->kernel_version >=
> +				    KERNEL_VERSION(4, 16, 0)) {
> +					compound_dtor =
> +						UCHAR(addr + dtor_offset);
> +				} else if (info->kernel_version >=
> +					   KERNEL_VERSION(4, 4, 0)) {
> +					compound_dtor =
> +						USHORT(addr + dtor_offset);
>  				} else {
> -					compound_dtor = ULONG(pcache + SIZE(page) + dtor_offset);
> +					compound_dtor =
> +						ULONG(addr + dtor_offset);
>  				}
>  			}
> 
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 01eece2..4cfad98 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -241,6 +241,7 @@ static inline int string_exists(char *s) { return (s ? TRUE : FALSE); }
>  		     string_exists((char *)(B)) &&	\
>  	(strncmp((char *)(A), (char *)(B), strlen((char *)(B))) == 0))
> 
> +#define UCHAR(ADDR)	*((unsigned char *)(ADDR))
>  #define USHORT(ADDR)	*((unsigned short *)(ADDR))
>  #define UINT(ADDR)	*((unsigned int *)(ADDR))
>  #define ULONG(ADDR)	*((unsigned long *)(ADDR))
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
