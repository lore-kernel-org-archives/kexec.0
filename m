Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VVxgq-0005oT-9z
 for kexec@lists.infradead.org; Tue, 15 Oct 2013 06:01:09 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 8A3C83EE0B6
 for <kexec@lists.infradead.org>; Tue, 15 Oct 2013 15:00:45 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 787D045DEC1
 for <kexec@lists.infradead.org>; Tue, 15 Oct 2013 15:00:45 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 03C8645DEBB
 for <kexec@lists.infradead.org>; Tue, 15 Oct 2013 15:00:45 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id AF80F1DB8042
 for <kexec@lists.infradead.org>; Tue, 15 Oct 2013 15:00:44 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 5F28AE18002
 for <kexec@lists.infradead.org>; Tue, 15 Oct 2013 15:00:44 +0900 (JST)
Message-ID: <525CD97B.3070209@jp.fujitsu.com>
Date: Tue, 15 Oct 2013 14:58:19 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3] makedumpfile: fix max_mapnr issue on system has over
 44-bit addressing
References: <20131014121648.1409.58312.stgit@k.asiapacific.hpqcorp.net>
In-Reply-To: <20131014121648.1409.58312.stgit@k.asiapacific.hpqcorp.net>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Jingbai Ma <jingbai.ma@hp.com>
Cc: bhe@redhat.com, nishimura@mxp.nes.nec.co.jp, usui@mxm.nes.nec.co.jp, lisa.mitchell@hp.com, ruyang@redhat.com, tachibana@mxm.nes.nec.co.jp, anderson@redhat.com, vgoyal@redhat.com, kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org, chaowang@redhat.com, crash-utility@redhat.com

(2013/10/14 21:16), Jingbai Ma wrote:
<cut>
> @@ -125,7 +126,7 @@ get_max_mapnr(void)
>   	unsigned long long max_paddr;
>
>   	if (info->flag_refiltering) {
> -		info->max_mapnr = info->dh_memory->max_mapnr;
> +		info->max_mapnr = info->kh_memory->max_mapnr_64;
>   		return TRUE;
>   	}
>

Please:

if (dh.header_version < 6)
   info->max_mapnr = info->dh_memmory->max_mapnr;
else
   info->max_mapnr = info->kh_memory->max_mapnr_64;

> @@ -783,6 +784,10 @@ get_kdump_compressed_header_info(char *filename)
>   		ERRMSG("header does not have dump_level member\n");
>   		return FALSE;
>   	}
> +
> +	if (dh.header_version < 6)
> +		kh.max_mapnr_64 = dh.max_mapnr;
> +

Again, please don't do this. It's confusing if in-memory header data
is not identical to in-disk one.

>   	DEBUG_MSG("diskdump main header\n");
>   	DEBUG_MSG("  signature        : %s\n", dh.signature);
>   	DEBUG_MSG("  header_version   : %d\n", dh.header_version);
> @@ -802,6 +807,12 @@ get_kdump_compressed_header_info(char *filename)
>   	DEBUG_MSG("  split            : %d\n", kh.split);
>   	DEBUG_MSG("  start_pfn        : 0x%lx\n", kh.start_pfn);
>   	DEBUG_MSG("  end_pfn          : 0x%lx\n", kh.end_pfn);
> +	if (dh.header_version >= 6) {
> +		/* A dumpfile contains full 64bit values. */
> +		DEBUG_MSG("  start_pfn_64 : 0x%llx\n", kh.start_pfn_64);
> +		DEBUG_MSG("  end_pfn_64 : 0x%llx\n", kh.end_pfn_64);
> +		DEBUG_MSG("  max_mapnr_64 : 0x%llx\n", kh.max_mapnr_64);
> +	}
>
>   	info->dh_memory = malloc(sizeof(dh));
>   	if (info->dh_memory == NULL) {
> @@ -2766,14 +2777,16 @@ int
>   initialize_bitmap_memory(void)
>   {
>   	struct disk_dump_header	*dh;
> +	struct kdump_sub_header *kh;
>   	struct dump_bitmap *bmp;
>   	off_t bitmap_offset;
> -	int bitmap_len, max_sect_len;
> +	off_t bitmap_len, max_sect_len;
>   	unsigned long pfn;
>   	int i, j;
>   	long block_size;
>
>   	dh = info->dh_memory;
> +	kh = info->kh_memory;
>   	block_size = dh->block_size;
>
>   	bitmap_offset
> @@ -2793,7 +2806,7 @@ initialize_bitmap_memory(void)
>   	bmp->offset = bitmap_offset + bitmap_len / 2;
>   	info->bitmap_memory = bmp;
>
> -	max_sect_len = divideup(dh->max_mapnr, BITMAP_SECT_LEN);
> +	max_sect_len = divideup(kh->max_mapnr_64, BITMAP_SECT_LEN);
>   	info->valid_pages = calloc(sizeof(ulong), max_sect_len);

Ah, please here needs to be fixed, too. Here should have been
used sizeof(int) but now sizeof(off_t) should be used.



-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
