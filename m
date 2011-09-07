Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo200.gate.nec.co.jp ([202.32.8.215])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R1FzK-0006zx-JI
	for kexec@lists.infradead.org; Wed, 07 Sep 2011 11:08:15 +0000
Received: from tyo201.gate.nec.co.jp ([10.7.69.201])
	by tyo200.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id p87830xX027390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <kexec@lists.infradead.org>; Wed, 7 Sep 2011 17:03:01 +0900 (JST)
Date: Wed, 7 Sep 2011 15:59:48 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: [PATCH v2 7/8] makedumpfile: Add erased information in
	compressed kdump file
Message-Id: <20110907155948.d6494440.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <20110906154452.GA18186@in.ibm.com>
References: <20110517200608.12740.68790.stgit@mars.in.ibm.com>
	<20110819151659.6cfd324b.oomichi@mxs.nes.nec.co.jp>
	<20110822115757.GA23157@in.ibm.com>
	<20110906154452.GA18186@in.ibm.com>
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
To: mahesh@linux.vnet.ibm.com
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, Reinhard <BUENDGEN@de.ibm.com>, kexec@lists.infradead.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Dave Anderson <anderson@redhat.com>



Hi Mahesh,

Thank you for the patch.

On Tue, 6 Sep 2011 21:14:52 +0530
Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> 
> makedumpfile: Use the same format as erase commands for eraseinfo data.
> 
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> The format of eraseinfo data differs from that of erase commands. This patch
> makes sure eraseinfo data format is same as erase commands.
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Acked-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>


Thanks
Ken'ichi Ohmichi

> ---
>  IMPLEMENTATION |    4 ++--
>  makedumpfile.c |    4 ++--
>  makedumpfile.h |    2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/IMPLEMENTATION b/IMPLEMENTATION
> index c11bd36..f0f3135 100644
> --- a/IMPLEMENTATION
> +++ b/IMPLEMENTATION
> @@ -26,9 +26,9 @@
>      |                        :                 |
>      |         page data (pfn Z)                |
>      +------------------------------------------+ offset_eraseinfo
> -    | erase mystruct2.mystruct1.var 4          |
> +    | erase mystruct2.mystruct1.var size 4     |
>      | erase mystruct2.mystruct1.ptr nullify    |
> -    | erase mystruct2.mystruct.array 100       |
> +    | erase mystruct2.mystruct.array size 100  |
>      +------------------------------------------+
>  
>  
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 1a88171..2c49bbe 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -3949,7 +3949,7 @@ write_elf_header(struct cache_data *cd_header)
>  		if (fl_info->nullify)
>  			sprintf(size_str, "nullify\n");
>  		else
> -			sprintf(size_str, "%ld\n", fl_info->size);
> +			sprintf(size_str, "size %ld\n", fl_info->size);
>  
>  		size_eraseinfo += strlen("erase ") +
>  				strlen(ei->symbol_expr) + 1 +
> @@ -4799,7 +4799,7 @@ write_eraseinfo(struct cache_data *cd_page, unsigned long *size_out)
>  			continue;
>  		for (j = 0; j < erase_info[i].num_sizes; j++) {
>  			if (erase_info[i].sizes[j] > 0)
> -				sprintf(size_str, "%ld\n",
> +				sprintf(size_str, "size %ld\n",
>  						erase_info[i].sizes[j]);
>  			else if (erase_info[i].sizes[j] == -1)
>  				sprintf(size_str, "nullify\n");
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 8b1bd4f..2741903 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -411,7 +411,7 @@ do { \
>  
>  #define SIZE_XEN_CRASH_INFO_V2	(sizeof(unsigned long) * 10)
>  
> -#define MAX_SIZE_STR_LEN (21)
> +#define MAX_SIZE_STR_LEN (26)	/* strlen("size ") + 21 */
>  
>  /*
>   * The value of dependence on machine
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
