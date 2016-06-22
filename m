Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mgwym02.jp.fujitsu.com ([211.128.242.41])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bFdia-0002C4-Bv
 for kexec@lists.infradead.org; Wed, 22 Jun 2016 08:41:05 +0000
Received: from m3050.s.css.fujitsu.com (msm.b.css.fujitsu.com [10.134.21.208])
 by yt-mxoi2.gw.nic.fujitsu.com (Postfix) with ESMTP id 0F2DBAC01FD
 for <kexec@lists.infradead.org>; Wed, 22 Jun 2016 17:40:32 +0900 (JST)
Subject: Re: [PATCH 1/2] sadump: fix segmentation fault on sadump-related
 formats
References: <20160620.145744.403680288.d.hatayama@jp.fujitsu.com>
From: "HATAYAMA, Daisuke" <d.hatayama@jp.fujitsu.com>
Message-ID: <cba21973-10b6-88cd-bd58-695db8b6cb1d@jp.fujitsu.com>
Date: Wed, 22 Jun 2016 17:40:25 +0900
MIME-Version: 1.0
In-Reply-To: <20160620.145744.403680288.d.hatayama@jp.fujitsu.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: ats-kumagai@wm.jp.nec.com
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Kumagai-san,

Could you review these patches?

On 2016/06/20 14:57, HATAYAMA Daisuke wrote:
> Currently, makedumpfile results in segmentation fault on
> sadump-related formats:
>
>     # ~/makedumpfile --message-level 31 -l -d 31 -x ./vmlinux vmcore
>     sadump: read dump device as single partition
>     sadump: single partition configuration
>     page_size    : 4096
>     Segmentation fault
>
> This is because although commit
> 5fc24bf754fa6d2c0bd0f1c6f5655de371efb9d5 started dynamically
> allocating the buffer of struct dump_bitmap, the sadump source code
> doesn't follow the change.
>
> This commit fixes this by following the change.
>
> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> ---
>  makedumpfile.c |  5 ++++-
>  sadump_info.c  | 28 ++++++++++++++++++++++++++--
>  2 files changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 853b999..90cfc3e 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -11229,8 +11229,11 @@ out:
>  			free(info->kh_memory);
>  		if (info->valid_pages)
>  			free(info->valid_pages);
> -		if (info->bitmap_memory)
> +		if (info->bitmap_memory) {
> +			if (info->bitmap_memory->buf)
> +				free(info->bitmap_memory->buf);
>  			free(info->bitmap_memory);
> +		}
>  		if (info->fd_memory)
>  			close(info->fd_memory);
>  		if (info->fd_dumpfile)
> diff --git a/sadump_info.c b/sadump_info.c
> index 20376f0..8716167 100644
> --- a/sadump_info.c
> +++ b/sadump_info.c
> @@ -832,18 +832,28 @@ sadump_initialize_bitmap_memory(void)
>  		       strerror(errno));
>  		return FALSE;
>  	}
> +
>  	bmp->fd = info->fd_memory;
>  	bmp->file_name = info->name_memory;
>  	bmp->no_block = -1;
> -	memset(bmp->buf, 0, BUFSIZE_BITMAP);
>  	bmp->offset = dumpable_bitmap_offset;
>
> +	bmp->buf = malloc(BUFSIZE_BITMAP);
> +	if (!bmp->buf) {
> +		ERRMSG("Can't allocate memory for the memory-bitmap's buffer. %s\n",
> +		       strerror(errno));
> +		free(bmp);
> +		return FALSE;
> +	}
> +	memset(bmp->buf, 0, BUFSIZE_BITMAP);
> +
>  	max_section = divideup(si->max_mapnr, SADUMP_PF_SECTION_NUM);
>
>  	block_table = calloc(sizeof(unsigned long long), max_section);
>  	if (block_table == NULL) {
>  		ERRMSG("Can't allocate memory for the block_table. %s\n",
>  		       strerror(errno));
> +		free(bmp->buf);
>  		free(bmp);
>  		return FALSE;
>  	}
> @@ -870,8 +880,17 @@ sadump_initialize_bitmap_memory(void)
>  	bmp->fd = info->fd_memory;
>  	bmp->file_name = info->name_memory;
>  	bmp->no_block = -1;
> -	memset(bmp->buf, 0, BUFSIZE_BITMAP);
>  	bmp->offset = si->sub_hdr_offset + sh->block_size * sh->sub_hdr_size;
> +
> +	bmp->buf = malloc(BUFSIZE_BITMAP);
> +	if (!bmp->buf) {
> +		ERRMSG("Can't allocate memory for the memory-bitmap's buffer. %s\n",
> +		       strerror(errno));
> +		free(bmp);
> +		return FALSE;
> +	}
> +	memset(bmp->buf, 0, BUFSIZE_BITMAP);
> +
>  	si->ram_bitmap = bmp;
>
>  	/*
> @@ -1904,6 +1923,11 @@ free_sadump_info(void)
>  		fclose(si->file_elf_note);
>  	if (si->cpu_online_mask_buf)
>  		free(si->cpu_online_mask_buf);
> +	if (si->ram_bitmap) {
> +		if (si->ram_bitmap->buf)
> +			free(si->ram_bitmap->buf);
> +		free(si->ram_bitmap);
> +	}
>  }
>
>  void
>

-- 
Thanks.
HATAYAMA, Daisuke

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
