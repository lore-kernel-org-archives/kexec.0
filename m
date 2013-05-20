Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UeFkH-0002Dh-JX
 for kexec@lists.infradead.org; Mon, 20 May 2013 02:22:44 +0000
Date: Mon, 20 May 2013 11:20:32 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH] makedumpfile: message on non-mmap kernels
Message-Id: <20130520112032.6734fd38217e05661a9f5665@mxc.nes.nec.co.jp>
In-Reply-To: <E1UcggB-0005hX-L1@eag09.americas.sgi.com>
References: <E1UcggB-0005hX-L1@eag09.americas.sgi.com>
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
To: cpw@sgi.com
Cc: d.hatayama@jp.fujitsu.com, kexec@lists.infradead.org

On Wed, 15 May 2013 13:43:59 -0500
Cliff Wickman <cpw@sgi.com> wrote:

> From: Cliff Wickman <cpw@sgi.com>
> 
> If the crash kernel does not support mmap(2) of /proc/vmcore, make
> makedumpfile fall back to using reads with a non-alarming message.
> 
> Signed-off-by: Cliff Wickman <cpw@sgi.com>
> ---
>  makedumpfile.c |   37 ++++++++++++++++++++++---------------
>  1 file changed, 22 insertions(+), 15 deletions(-)
> 
> Index: makedumpfile.mmap/makedumpfile.c
> ===================================================================
> --- makedumpfile.mmap.orig/makedumpfile.c
> +++ makedumpfile.mmap/makedumpfile.c
> @@ -239,7 +239,7 @@ read_page_desc(unsigned long long paddr,
>  }
>  
>  static int
> -update_mmap_range(off_t offset) {
> +update_mmap_range(off_t offset, int initial) {
>  	off_t start_offset;
>  	off_t map_size;
>  	off_t max_offset = get_max_file_offset();
> @@ -258,10 +258,11 @@ update_mmap_range(off_t offset) {
>  				     info->fd_memory, start_offset);
>  
>  	if (info->mmap_buf == MAP_FAILED) {
> -		ERRMSG("Can't map [%llx-%llx] with mmap()\n %s",
> -		       (ulonglong)start_offset,
> -		       (ulonglong)(start_offset + map_size),
> -		       strerror(errno));
> +		if (!initial)
> +			ERRMSG("Can't map [%llx-%llx] with mmap()\n %s",
> +				(ulonglong)start_offset,
> +				(ulonglong)(start_offset + map_size),
> +				strerror(errno));
>  		return FALSE;
>  	}
>  
> @@ -285,7 +286,7 @@ is_mapped_with_mmap(off_t offset) {
>  int
>  initialize_mmap(void) {
>  	info->mmap_buf = MAP_FAILED;
> -	if (!update_mmap_range(0))
> +	if (!update_mmap_range(0, 1))
>  		return FALSE;
>  
>  	return TRUE;
> @@ -298,7 +299,7 @@ read_with_mmap(off_t offset, void *bufpt
>  next_region:
>  
>  	if (!is_mapped_with_mmap(offset)) {
> -		if (!update_mmap_range(offset))
> +		if (!update_mmap_range(offset, 0))
>  			return FALSE;
>  	}

Where came from this original code ?
The current code in mmap branch doesn't look the return value of
update_mmap_range():

	if (!is_mapped_with_mmap(offset))
		update_mmap_range(offset);

Anyway, I'll merge this patch into mmap branch after I push the patch
below.


Thanks
Atsushi Kumagai

-----------------------------------------------------------------------
Author: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Date:   Thu May 17 15:02:19 2013 +0900

    [PATCH] Add error handling for read_with_mmap().

    Add error handling for read_with_mmap the same as read()'s case.

    Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>

diff --git a/makedumpfile.c b/makedumpfile.c
index fce2e35..1f656e8 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -291,7 +291,8 @@ read_with_mmap(off_t offset, void *bufptr, unsigned long size) {
 next_region:

        if (!is_mapped_with_mmap(offset))
-               update_mmap_range(offset);
+               if (!update_mmap_range(offset))
+                       return FALSE;

        read_size = MIN(info->mmap_end_offset - offset, size);

@@ -320,9 +321,13 @@ readpage_elf(unsigned long long paddr, void *bufptr)
                return FALSE;
        }

-       if (info->flag_usemmap)
-               read_with_mmap(offset, bufptr, info->page_size);
-       else {
+       if (info->flag_usemmap) {
+               if (!read_with_mmap(offset, bufptr, info->page_size)) {
+                       ERRMSG("Can't read the dump memory(%s) with mmap().\n",
+                               info->name_memory);
+                        return FALSE;
+               }
+       } else {
                if (lseek(info->fd_memory, offset, SEEK_SET) == failed) {
                        ERRMSG("Can't seek the dump memory(%s). (offset: %llx) %s\n",
                               info->name_memory, (unsigned long long)offset, strerror(errno));

  
> @@ -2984,14 +2985,20 @@ out:
>  	if (info->dump_level & DL_EXCLUDE_FREE)
>  		setup_page_is_buddy();
>  
> -	if (info->mmap_region_size > 0 && initialize_mmap()) {
> -		/*
> -		 * The map size is specified as Kbyte with
> -		 * --map-size <size> option.
> -		 */
> -		info->mmap_region_size <<= 10;
> -		info->flag_usemmap = TRUE;
> -		DEBUG_MSG("read %s with mmap()\n", info->name_memory);
> +	if (info->mmap_region_size > 0) {
> +		if (!initialize_mmap()) {
> +			/* this kernel does not support mmap of vmcore */
> +			ERRMSG("Kernel can't mmap vmcore, using reads.\n");
> +			info->flag_usemmap = FALSE;
> +		} else {
> +			/*
> +			 * The map size is specified as Kbyte with
> +			 * --map-size <size> option.
> +			 */
> +			info->mmap_region_size <<= 10;
> +			info->flag_usemmap = TRUE;
> +			DEBUG_MSG("read %s with mmap()\n", info->name_memory);
> +		}
>  	} else {
>  		info->flag_usemmap = FALSE;
>  		DEBUG_MSG("read %s with read()\n", info->name_memory);
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
