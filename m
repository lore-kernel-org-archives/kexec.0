Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UNyCM-0000lx-86
 for kexec@lists.infradead.org; Fri, 05 Apr 2013 04:24:24 +0000
Date: Fri, 5 Apr 2013 11:38:26 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH] makedumpfile: copy over the 'erase_ch' member while
 splitting filter info.
Message-Id: <20130405113826.e7f2890ba0c79e25cd87f93b@mxc.nes.nec.co.jp>
In-Reply-To: <20130402051243.24410.23935.stgit@mars.in.ibm.com>
References: <20130402051243.24410.23935.stgit@mars.in.ibm.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: mahesh@linux.vnet.ibm.com
Cc: aravinda@linux.vnet.ibm.com, hsiddara@in.ibm.com, tachibana@mxm.nes.nec.co.jp, kexec@lists.infradead.org, suzuki@in.ibm.com

Hello Mahesh,

On Tue, 02 Apr 2013 10:43:59 +0530
Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:

> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> Recent eppic support in makedumpfile has introduced 'erase_ch' member in
> filter_info structure. This member holds the erase character specified by the
> user to poison the memory location in the dump file that require to be scrubbed
> out. But, when the memory range to be scrubbed out is spanned across multiple
> pages, only the memory that belongs to first page is poisoned with the
> character set in 'erase_ch' member. The rest of the memory gets poisoned with
> 'null' character. This is because, the 'erase_ch' member is not copied over
> while splitting filter info in split_filter_info() function.
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Signed-off-by: Suzuki Poulose <suzuki@in.ibm.com>
> ---
>  erase_info.c |   11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/erase_info.c b/erase_info.c
> index 61fe637..a1b08e0 100644
> --- a/erase_info.c
> +++ b/erase_info.c
> @@ -1921,12 +1921,15 @@ split_filter_info(struct filter_info *prev, unsigned long long next_paddr,
>  		ERRMSG("Can't allocate memory to split filter info\n");
>  		return;
>  	}
> -	new->nullify        = prev->nullify;
> -	new->erase_info_idx = prev->erase_info_idx;
> -	new->size_idx       = prev->size_idx;
> +	
> +	/*
> +	 * copy over existing data from prev node and only update fields
> +	 * that differ. This approach will take care of copying over of any
> +	 * future member addition to filter_info structure.
> +	 */
> +	*new = *prev;
>  	new->paddr          = next_paddr;
>  	new->size           = size;
> -	new->next           = prev->next;
>  	prev->next          = new;
>  }

Sounds good!
I'll merge this patch into v1.5.4.


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
