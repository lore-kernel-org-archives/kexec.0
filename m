Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fky1j-0005ik-6l
 for kexec@lists.infradead.org; Wed, 01 Aug 2018 20:47:24 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [PATCH] makedumpfile: when using refiltering, initialize
 bitmap1 from the kdump file's bitmap2
Date: Wed, 1 Aug 2018 20:45:07 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC03559B0D@BPXM09GP.gisp.nec.co.jp>
References: <1533026695-14819-1-git-send-email-piliu@redhat.com>
In-Reply-To: <1533026695-14819-1-git-send-email-piliu@redhat.com>
Content-Language: en-US
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
To: Pingfan Liu <piliu@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hi Pingfan,

Thank you for the patch.

On 7/31/2018 4:44 AM, Pingfan Liu wrote:
> When refiltering on kdump format file, there is no info about pt_load[] for
> exclude_nodata_pages(), and also we can not expect more data than the kdump
> file can provide, hence this patch suggests to initialize the refiltered
> bitmap1 from the kdump file's bitmap2.

I understood the issue (I don't have any vmcore which can reproduce it,
though), but since the bitmap1 is written to the refiltered dump file,
I think that we should not change the meaning of bitmap1 if possible,
which is "a page on memory hole".

For instance, with the patch, crash using the bitmaps prints a different
message for the same "excluded" paddr:

  -read_diskdump: PAGE_EXCLUDED: paddr/pfn: 2613e130/2613e
  +read_diskdump: SEEK_ERROR: paddr/pfn: 2613e130/2613e !page_is_ram

and makedumpfile's -e option using the bitmap1 cannot be utilized when
refiltering, these are not favorable.

So how about initializing the refiltered *bitmap2* from the kdump file's
bitmap2 ?  I'm checking if this works.

Thanks,
Kazu

> 
> Note about the bug reported by the following ops:
>   makedumpfile -l --message-level 1 -d 31 /proc/vmcore /path/to/vmcore
>   makedumpfile  --split  -d 31 ./vmcore dumpfile_{1,2,3} 2>&1
> and hit the following error:
>   Excluding unnecessary pages                       : [100.0 %] \
>   readpage_kdump_compressed: pfn(9b) is excluded from /var/crash/127.0.0.1-2018-07-02-22:10:38/vmcore.
>   readmem: type_addr: 1, addr:9b000, size:4096
>   read_pfn: Can't get the page data.
>   writeout_multiple_dumpfiles: Child process(2277) finished incompletely.(256)
>   Copying data                                      : [ 24.6 %] -           eta: 2s
>   makedumpfile Failed.
> 
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> ---
>  makedumpfile.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 101fa7c..af24359 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -5544,6 +5544,7 @@ copy_1st_bitmap_from_memory(void)
> 
>  	bitmap_offset = (DISKDUMP_HEADER_BLOCKS + dh->sub_hdr_size)
>  			 * dh->block_size;
> +	bitmap_offset += info->len_bitmap / 2;
> 
>  	if (lseek(info->fd_memory, bitmap_offset, SEEK_SET) < 0) {
>  		ERRMSG("Can't seek %s. %s\n",
> @@ -5593,8 +5594,11 @@ create_1st_bitmap_file(void)
>  	struct timespec ts_start;
>  	off_t offset_page;
> 
> -	if (info->flag_refiltering)
> +	if (info->flag_refiltering) {
> +		/* no hole info in kdump file, set it as 0 for refiltering */
> +		pfn_memhole = 0;
>  		return copy_1st_bitmap_from_memory();
> +	}
> 
>  	if (info->flag_sadump)
>  		return sadump_copy_1st_bitmap_from_memory();
> --
> 2.7.4
> 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
