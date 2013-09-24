Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VOT8j-00008E-TZ
 for kexec@lists.infradead.org; Tue, 24 Sep 2013 13:58:59 +0000
Date: Tue, 24 Sep 2013 09:58:31 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <774037499.1295674.1380031111483.JavaMail.root@redhat.com>
In-Reply-To: <20130924125008.14740.98019.stgit@k.asiapacific.hpqcorp.net>
References: <20130924125008.14740.98019.stgit@k.asiapacific.hpqcorp.net>
Subject: Re: [PATCH] crash utility: fix max_mapnr issue on system has over
 44-bit addressing
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Jingbai Ma <jingbai.ma@hp.com>
Cc: bhe@redhat.com, nishimura@mxp.nes.nec.co.jp, usui@mxm.nes.nec.co.jp, d hatayama <d.hatayama@jp.fujitsu.com>, lisa mitchell <lisa.mitchell@hp.com>, ruyang@redhat.com, tachibana@mxm.nes.nec.co.jp, kumagai-atsushi@mxc.nes.nec.co.jp, vgoyal@redhat.com, kexec@lists.infradead.org, chaowang@redhat.com, crash-utility@redhat.com



----- Original Message -----
> The patch will add support for new compressed dumpfile header_version 6.
> 
> This bug was posted here:
> http://lists.infradead.org/pipermail/kexec/2013-September/009587.html
> 
> This patch will add a new field in struct kdump_sub_header.
> unsigned long   max_mapnr;
> 
> And the old "unsigned int max_mapnr" in struct disk_dump_header will
> not be used anymore. But still be there for compatibility purpose.
> 
> Signed-off-by: Jingbai Ma <jingbai.ma@hp.com>

Hello Jingbai,

This patch needs to be backwards-compatible with respect
to diskdump dumpfiles.  Your patch presumes that it's always
dealing with a compressed kdump, and as a result it immediately
generates a SIGSEGV when presented with a diskdump dumpfile:
 
 $ crash vmcore vmlinux.gz
 
 crash 7.0.3rc5
 Copyright (C) 2002-2013  Red Hat, Inc.
 Copyright (C) 2004, 2005, 2006, 2010  IBM Corporation
 Copyright (C) 1999-2006  Hewlett-Packard Co
 Copyright (C) 2005, 2006, 2011, 2012  Fujitsu Limited
 Copyright (C) 2006, 2007  VA Linux Systems Japan K.K.
 Copyright (C) 2005, 2011  NEC Corporation
 Copyright (C) 1999, 2002, 2007  Silicon Graphics, Inc.
 Copyright (C) 1999, 2000, 2001, 2002  Mission Critical Linux, Inc.
 This program is free software, covered by the GNU General Public License,
 and you are welcome to change it and/or distribute copies of it under
 certain conditions.  Enter "help copying" to see the conditions.
 This program has absolutely no warranty.  Enter "help warranty" for details.
  
 Segmentation fault (core dumped)
 $

The SIGSEGV is generated from this patch to read_dump_header():

+       if (header->header_version < 6)
+               sub_header_kdump->max_mapnr = header->max_mapnr;
 
because the sub_header_kdump pointer is only malloc'd if the
dumpfile is a compressed kdump.

And after that, all of the presumptive usages of the kdump_sub_header
must be handled differently, e.g., this will fail:

 static inline int
-dump_is_partial(const struct disk_dump_header *header)
+dump_is_partial(const struct disk_dump_header *header,
+       const struct kdump_sub_header *sub_header)
 {
        return header->bitmap_blocks >=
-           divideup(divideup(header->max_mapnr, 8), dd->block_size) * 2;
+           divideup(divideup(sub_header->max_mapnr, 8), dd->block_size) * 2;
 }
 
So pretty much everywhere that you've replaced "dd->header->max_mapnr"
with either "sub_header_kdump->max_mapnr" or "dd->sub_header_kdump->max_mapnr"
needs to be changed to use something like a pre-initialized local variable
"max_mapnr" that gets set appropriately to the dumpfile type. 

Thanks,
  Dave





> ---
>  diskdump.c |   36 +++++++++++++++++++++++++-----------
>  diskdump.h |    5 ++++-
>  2 files changed, 29 insertions(+), 12 deletions(-)
> 
> diff --git a/diskdump.c b/diskdump.c
> index 0819a3f..8a2928b 100644
> --- a/diskdump.c
> +++ b/diskdump.c
> @@ -199,22 +199,23 @@ get_bit(char *map, int byte, int bit)
>  }
>  
>  static inline int
> -page_is_ram(unsigned int nr)
> +page_is_ram(unsigned long nr)
>  {
>  	return get_bit(dd->bitmap, nr >> 3, nr & 7);
>  }
>  
>  static inline int
> -page_is_dumpable(unsigned int nr)
> +page_is_dumpable(unsigned long nr)
>  {
>  	return dd->dumpable_bitmap[nr>>3] & (1 << (nr & 7));
>  }
>  
>  static inline int
> -dump_is_partial(const struct disk_dump_header *header)
> +dump_is_partial(const struct disk_dump_header *header,
> +	const struct kdump_sub_header *sub_header)
>  {
>  	return header->bitmap_blocks >=
> -	    divideup(divideup(header->max_mapnr, 8), dd->block_size) * 2;
> +	    divideup(divideup(sub_header->max_mapnr, 8), dd->block_size) * 2;
>  }
>  
>  static int
> @@ -321,6 +322,7 @@ x86_process_elf_notes(void *note_ptr, unsigned long
> size_note)
>   * [40]    unsigned long   size_note;          /  header_version 4 and later
>   /
>   * [44]    off_t           offset_eraseinfo;   /  header_version 5 and later
>   /
>   * [52]    unsigned long   size_eraseinfo;     /  header_version 5 and later
>   /
> + * [56]    unsigned long   max_mapnr;          /  header_version 6 and later
> /
>   * };
>   *
>   * But when compiled on an ARM processor, each 64-bit "off_t" would be
>   pushed
> @@ -338,6 +340,7 @@ x86_process_elf_notes(void *note_ptr, unsigned long
> size_note)
>   * [48]    unsigned long   size_note;          /  header_version 4 and later
>   /
>   * [56]    off_t           offset_eraseinfo;   /  header_version 5 and later
>   /
>   * [62]    unsigned long   size_eraseinfo;     /  header_version 5 and later
>   /
> + * [66]    unsigned long   max_mapnr;          /  header_version 6 and later
> /
>   * };
>   *
>   */
> @@ -357,6 +360,7 @@ struct kdump_sub_header_ARM_target {
>  	int 		pad3;
>          off_t           offset_eraseinfo;   /* header_version 5 and later */
>          unsigned long   size_eraseinfo;     /* header_version 5 and later */
> +	unsigned long	max_mapnr;	    /* header_version 6 and later */
>  };
>  
>  static void
> @@ -380,6 +384,8 @@ arm_kdump_header_adjust(int header_version)
>  		kdsh->offset_eraseinfo = kdsh_ARM_target->offset_eraseinfo;
>  		kdsh->size_eraseinfo = kdsh_ARM_target->size_eraseinfo;
>  	}
> +	if (header_version >= 6)
> +		kdsh->max_mapnr = kdsh_ARM_target->map_mapnr;
>  }
>  #endif  /* __i386__ && ARM */
>  
> @@ -578,7 +584,10 @@ restart:
>  		}
>  	}
>  
> -	if (dump_is_partial(header))
> +	if (header->header_version < 6)
> +		sub_header_kdump->max_mapnr = header->max_mapnr;
> +
> +	if (dump_is_partial(header, sub_header_kdump))
>  		memcpy(dd->dumpable_bitmap, dd->bitmap + bitmap_len/2,
>  		       bitmap_len/2);
>  	else
> @@ -679,7 +688,8 @@ restart:
>  	}
>  
>  	if (!is_split) {
> -		max_sect_len = divideup(header->max_mapnr, BITMAP_SECT_LEN);
> +		max_sect_len = divideup(sub_header_kdump->max_mapnr,
> +			BITMAP_SECT_LEN);
>  		pfn = 0;
>  		dd->filename = file;
>  	}
> @@ -1058,14 +1068,14 @@ read_diskdump(int fd, void *bufptr, int cnt, ulong
> addr, physaddr_t paddr)
>  	curpaddr = paddr & ~((physaddr_t)(dd->block_size-1));
>  	page_offset = paddr & ((physaddr_t)(dd->block_size-1));
>  
> -	if ((pfn >= dd->header->max_mapnr) || !page_is_ram(pfn)) {
> +	if ((pfn >= dd->sub_header_kdump->max_mapnr) || !page_is_ram(pfn)) {
>  		if (CRASHDEBUG(8)) {
>  			fprintf(fp, "read_diskdump: SEEK_ERROR: "
>  			    "paddr/pfn: %llx/%lx ",
>  				(ulonglong)paddr, pfn);
> -			if (pfn >= dd->header->max_mapnr)
> -				fprintf(fp, "max_mapnr: %x\n",
> -					dd->header->max_mapnr);
> +			if (pfn >= dd->sub_header_kdump->max_mapnr)
> +				fprintf(fp, "max_mapnr: %lx\n",
> +					dd->sub_header_kdump->max_mapnr);
>  			else
>  				fprintf(fp, "!page_is_ram\n");
>  		}
> @@ -1517,7 +1527,11 @@ __diskdump_memory_dump(FILE *fp)
>  	fprintf(fp, "          block_size: %d\n", dh->block_size);
>  	fprintf(fp, "        sub_hdr_size: %d\n", dh->sub_hdr_size);
>  	fprintf(fp, "       bitmap_blocks: %u\n", dh->bitmap_blocks);
> -	fprintf(fp, "           max_mapnr: %u\n", dh->max_mapnr);
> +	if (dh->header_version >= 6)
> +		fprintf(fp, "           max_mapnr: %lu\n",
> +			dd->sub_header_kdump->max_mapnr);
> +	else
> +		fprintf(fp, "           max_mapnr: %u\n", dh->max_mapnr);
>  	fprintf(fp, "    total_ram_blocks: %u\n", dh->total_ram_blocks);
>  	fprintf(fp, "       device_blocks: %u\n", dh->device_blocks);
>  	fprintf(fp, "      written_blocks: %u\n", dh->written_blocks);
> diff --git a/diskdump.h b/diskdump.h
> index 9ab10b6..17642b6 100644
> --- a/diskdump.h
> +++ b/diskdump.h
> @@ -42,7 +42,9 @@ struct disk_dump_header {
>  						   header in blocks */
>  	unsigned int		bitmap_blocks;	/* Size of Memory bitmap in
>  						   block */
> -	unsigned int		max_mapnr;	/* = max_mapnr */
> +	unsigned int		max_mapnr;	/* = max_mapnr, 32bit only,
> +						   full 64bit in sub header.
> +						   Do NOT use this anymore! */
>  	unsigned int		total_ram_blocks;/* Number of blocks should be
>  						   written */
>  	unsigned int		device_blocks;	/* Number of total blocks in
> @@ -69,6 +71,7 @@ struct kdump_sub_header {
>  	unsigned long	size_note;          /* header_version 4 and later */
>  	off_t		offset_eraseinfo;   /* header_version 5 and later */
>  	unsigned long	size_eraseinfo;     /* header_version 5 and later */
> +	unsigned long	max_mapnr;          /* header_version 6 and later */
>  };
>  
>  /* page flags */
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
