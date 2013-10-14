Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VVctE-0006JJ-TK
 for kexec@lists.infradead.org; Mon, 14 Oct 2013 07:48:34 +0000
Message-ID: <525BA1AD.6000101@hp.com>
Date: Mon, 14 Oct 2013 15:47:57 +0800
From: Jingbai Ma <jingbai.ma@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2] makedumpfile: fix max_mapnr issue on system has over
 44-bit addressing
References: <20131011094651.13548.63033.stgit@k.asiapacific.hpqcorp.net>
 <525B888A.7010401@jp.fujitsu.com>
In-Reply-To: <525B888A.7010401@jp.fujitsu.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: bhe@redhat.com, nishimura@mxp.nes.nec.co.jp, usui@mxm.nes.nec.co.jp, lisa.mitchell@hp.com, vgoyal@redhat.com, ruyang@redhat.com, tachibana@mxm.nes.nec.co.jp, anderson@redhat.com, chaowang@redhat.com, kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org, Jingbai Ma <jingbai.ma@hp.com>, crash-utility@redhat.com

On 10/14/2013 02:00 PM, HATAYAMA Daisuke wrote:
> (2013/10/11 18:46), Jingbai Ma wrote:
>> This patch will fix a bug of makedumpfile doesn't work correctly on
>> system
>> has over 44-bit addressing in compression dump mode.
>> This bug was posted here:
>> http://lists.infradead.org/pipermail/kexec/2013-September/009587.html
>>
>> This patch will add 3 new fields in struct kdump_sub_header.
>> unsigned long long start_pfn_64; /* header_version 6 and later */
>> unsigned long long end_pfn_64; /* header_version 6 and later */
>> unsigned long long max_mapnr_64; /* header_version 6 and later */
>>
>> And the old "unsigned int max_mapnr" in struct disk_dump_header will
>> not be used anymore, but still be there for compatibility purpose.
>>
>> The max_mapnr_64 only exists in strcut kdump_sub_header, and that only
>> for compressed kdump format, so for ELF format kdump files
>> (non-compressed),
>> only the max_mapnr is available, so it still may be truncated for
>> addresses
>> exceed 44bit (above 16TB).
>>
>> This patch will change the header_version to 6.
>>
>> The corresponding patch for crash utility will be sent out separately.
>>
>> This patch doesn't change sadump_header.
>>
>> Changelog:
>> v2:
>> - Rename max_mapnr in struct kdump_sub_header to max_mapnr_64.
>> - Change type of max_mapnr_64 from unsigned long to unsigned long long.
>> In x86 PAE mode on x86_32 kernel, the address may exceeds 44bit limit.
>> - Add start_pfn_64, end_pfn_64 for struct kdump_sub_header.
>> - Only print 64bit start_pfn_64, end_pfn_64 and max_mapnr_64
>> debug messages for disk dump header version >= 6.
>> - Change type of bitmap_len in struct DumpInfo, from unsigned long to
>> unsigned long long.
>> - Enhance bitmap writting function in reassemble_kdump_header().
>> Prevent bitmap writting failure if the size of bitmap is too large to
>> fit a sigle write.
>>
>> v1:
>> - http://lists.infradead.org/pipermail/kexec/2013-September/009662.html
>>
>>
>> Signed-off-by: Jingbai Ma <jingbai.ma@hp.com>
>> Tested-by: Lisa Mitchell <lisa.mitchell@hp.com>
>> ---
>> IMPLEMENTATION | 17 +++++++-
>> diskdump_mod.h | 17 +++++++-
>> makedumpfile.c | 116
>> +++++++++++++++++++++++++++++++++++++++++---------------
>> makedumpfile.h | 2 -
>> 4 files changed, 113 insertions(+), 39 deletions(-)
>>
>> diff --git a/IMPLEMENTATION b/IMPLEMENTATION
>> index f0f3135..4feda02 100644
>> --- a/IMPLEMENTATION
>> +++ b/IMPLEMENTATION
>> @@ -48,7 +48,9 @@
>> header in blocks */
>> unsigned int bitmap_blocks; /* Size of Memory bitmap in
>> block */
>> - unsigned int max_mapnr; /* = max_mapnr */
>> + unsigned int max_mapnr; /* = max_mapnr, 32bit only,
>> + full 64bit in sub header.
>> + Do not use this anymore! */
>
> I think ``obsolete'' is more formal than ``Do not use this anymore!''.

will fix.

>
>> unsigned int total_ram_blocks;/* Number of blocks should be
>> written */
>> unsigned int device_blocks; /* Number of total blocks in
>> @@ -69,14 +71,23 @@
>> unsigned long phys_base;
>> int dump_level; /* header_version 1 and later */
>> int split; /* header_version 2 and later */
>> - unsigned long start_pfn; /* header_version 2 and later */
>> - unsigned long end_pfn; /* header_version 2 and later */
>> + unsigned long start_pfn; /* header_version 2 and later,
>> + 32bit only, full 64bit in
>> + start_pfn_64.
>> + Do not use this anymore! */
>> + unsigned long end_pfn; /* header_version 2 and later,
>> + 32bit only, full 64bit in
>> + end_pfn_64.
>> + Do not use this anymore! */
>> off_t offset_vmcoreinfo;/* header_version 3 and later */
>> unsigned long size_vmcoreinfo; /* header_version 3 and later */
>> off_t offset_note; /* header_version 4 and later */
>> unsigned long size_note; /* header_version 4 and later */
>> off_t offset_eraseinfo; /* header_version 5 and later */
>> unsigned long size_eraseinfo; /* header_version 5 and later */
>> + unsigned long long start_pfn_64; /* header_version 6 and later */
>> + unsigned long long end_pfn_64; /* header_version 6 and later */
>> + unsigned long long max_mapnr_64; /* header_version 6 and later */
>> };
>>
>> - 1st-bitmap
>> diff --git a/diskdump_mod.h b/diskdump_mod.h
>> index af060b6..d907775 100644
>> --- a/diskdump_mod.h
>> +++ b/diskdump_mod.h
>> @@ -48,7 +48,9 @@ struct disk_dump_header {
>> header in blocks */
>> unsigned int bitmap_blocks; /* Size of Memory bitmap in
>> block */
>> - unsigned int max_mapnr; /* = max_mapnr */
>> + unsigned int max_mapnr; /* = max_mapnr, 32bit only,
>> + full 64bit in sub header.
>> + Do not use this anymore! */
>> unsigned int total_ram_blocks;/* Number of blocks should be
>> written */
>> unsigned int device_blocks; /* Number of total blocks in
>> @@ -67,14 +69,23 @@ struct kdump_sub_header {
>> unsigned long phys_base;
>> int dump_level; /* header_version 1 and later */
>> int split; /* header_version 2 and later */
>> - unsigned long start_pfn; /* header_version 2 and later */
>> - unsigned long end_pfn; /* header_version 2 and later */
>> + unsigned long start_pfn; /* header_version 2 and later,
>> + 32bit only, full 64bit in
>> + start_pfn_64.
>> + Do not use this anymore! */
>> + unsigned long end_pfn; /* header_version 2 and later,
>> + 32bit only, full 64bit in
>> + end_pfn_64.
>> + Do not use this anymore! */
>> off_t offset_vmcoreinfo;/* header_version 3 and later */
>> unsigned long size_vmcoreinfo; /* header_version 3 and later */
>> off_t offset_note; /* header_version 4 and later */
>> unsigned long size_note; /* header_version 4 and later */
>> off_t offset_eraseinfo; /* header_version 5 and later */
>> unsigned long size_eraseinfo; /* header_version 5 and later */
>> + unsigned long long start_pfn_64; /* header_version 6 and later */
>> + unsigned long long end_pfn_64; /* header_version 6 and later */
>> + unsigned long long max_mapnr_64; /* header_version 6 and later */
>> };
>>
>> /* page flags */
>> diff --git a/makedumpfile.c b/makedumpfile.c
>> index b42565c..3ac3ad0 100644
>> --- a/makedumpfile.c
>> +++ b/makedumpfile.c
>> @@ -23,6 +23,7 @@
>> #include <stddef.h>
>> #include <ctype.h>
>> #include <sys/time.h>
>> +#include <limits.h>
>>
>> struct symbol_table symbol_table;
>> struct size_table size_table;
>> @@ -125,7 +126,7 @@ get_max_mapnr(void)
>> unsigned long long max_paddr;
>>
>> if (info->flag_refiltering) {
>> - info->max_mapnr = info->dh_memory->max_mapnr;
>> + info->max_mapnr = info->kh_memory->max_mapnr_64;
>> return TRUE;
>> }
>>
>> @@ -783,6 +784,10 @@ get_kdump_compressed_header_info(char *filename)
>> ERRMSG("header does not have dump_level member\n");
>> return FALSE;
>> }
>> +
>> + if (dh.header_version < 6)
>> + kh.max_mapnr_64 = dh.max_mapnr;
>> +
>
> Don't do this. This debug message should output contents of header
> file with no modification.

For old dumps, there is no max_mapnr_64 in the header, and this value 
won't be printed out as below:
         if (dh.header_version >= 6) {
                 /* A dumpfile contains full 64bit values. */
                 DEBUG_MSG("  start_pfn_64 : 0x%llx\n", kh.start_pfn_64);
                 DEBUG_MSG("  end_pfn_64 : 0x%llx\n", kh.end_pfn_64);
                 DEBUG_MSG("  max_mapnr_64 : 0x%llx\n", kh.max_mapnr_64);
         }

So nothing was changed for old dumps.

>
>> DEBUG_MSG("diskdump main header\n");
>> DEBUG_MSG(" signature : %s\n", dh.signature);
>> DEBUG_MSG(" header_version : %d\n", dh.header_version);
>> @@ -790,7 +795,7 @@ get_kdump_compressed_header_info(char *filename)
>> DEBUG_MSG(" block_size : %d\n", dh.block_size);
>> DEBUG_MSG(" sub_hdr_size : %d\n", dh.sub_hdr_size);
>> DEBUG_MSG(" bitmap_blocks : %d\n", dh.bitmap_blocks);
>> - DEBUG_MSG(" max_mapnr : 0x%x\n", dh.max_mapnr);
>> + DEBUG_MSG(" max_mapnr(32bit) : 0x%x\n", dh.max_mapnr);
>
> I don't think annotation "(32bit)" is necessary.
>

OK, will fix.

>> DEBUG_MSG(" total_ram_blocks : %d\n", dh.total_ram_blocks);
>> DEBUG_MSG(" device_blocks : %d\n", dh.device_blocks);
>> DEBUG_MSG(" written_blocks : %d\n", dh.written_blocks);
>> @@ -800,8 +805,14 @@ get_kdump_compressed_header_info(char *filename)
>> DEBUG_MSG(" phys_base : 0x%lx\n", kh.phys_base);
>> DEBUG_MSG(" dump_level : %d\n", kh.dump_level);
>> DEBUG_MSG(" split : %d\n", kh.split);
>> - DEBUG_MSG(" start_pfn : 0x%lx\n", kh.start_pfn);
>> - DEBUG_MSG(" end_pfn : 0x%lx\n", kh.end_pfn);
>> + DEBUG_MSG(" start_pfn(32bit) : 0x%lx\n", kh.start_pfn);
>> + DEBUG_MSG(" end_pfn(32bit) : 0x%lx\n", kh.end_pfn);
>
> These, too.
>

will fix.

>> + if (dh.header_version >= 6) {
>> + /* A dumpfile contains full 64bit values. */
>> + DEBUG_MSG(" start_pfn_64 : 0x%llx\n", kh.start_pfn_64);
>> + DEBUG_MSG(" end_pfn_64 : 0x%llx\n", kh.end_pfn_64);
>> + DEBUG_MSG(" max_mapnr_64 : 0x%llx\n", kh.max_mapnr_64);
>> + }
>>
>> info->dh_memory = malloc(sizeof(dh));
>> if (info->dh_memory == NULL) {
>> @@ -2766,14 +2777,16 @@ int
>> initialize_bitmap_memory(void)
>> {
>> struct disk_dump_header *dh;
>> + struct kdump_sub_header *kh;
>> struct dump_bitmap *bmp;
>> off_t bitmap_offset;
>> - int bitmap_len, max_sect_len;
>> + off_t bitmap_len, max_sect_len;
>> unsigned long pfn;
>> int i, j;
>> long block_size;
>>
>> dh = info->dh_memory;
>> + kh = info->kh_memory;
>> block_size = dh->block_size;
>>
>> bitmap_offset
>> @@ -2793,7 +2806,7 @@ initialize_bitmap_memory(void)
>> bmp->offset = bitmap_offset + bitmap_len / 2;
>> info->bitmap_memory = bmp;
>>
>> - max_sect_len = divideup(dh->max_mapnr, BITMAP_SECT_LEN);
>> + max_sect_len = divideup(kh->max_mapnr_64, BITMAP_SECT_LEN);
>> info->valid_pages = calloc(sizeof(ulong), max_sect_len);
>> if (info->valid_pages == NULL) {
>> ERRMSG("Can't allocate memory for the valid_pages. %s\n",
>> @@ -4705,7 +4718,7 @@ create_2nd_bitmap(void)
>> int
>> prepare_bitmap_buffer(void)
>> {
>> - unsigned long tmp;
>> + unsigned long long tmp;
>>
>> /*
>> * Create 2 bitmaps (1st-bitmap & 2nd-bitmap) on block_size boundary.
>> @@ -4737,7 +4750,7 @@ prepare_bitmap_buffer(void)
>> int
>> prepare_bitmap_buffer_cyclic(void)
>> {
>> - unsigned long tmp;
>> + unsigned long long tmp;
>>
>> /*
>> * Create 2 bitmaps (1st-bitmap & 2nd-bitmap) on block_size boundary.
>> @@ -5153,11 +5166,12 @@ write_kdump_header(void)
>> * Write common header
>> */
>> strncpy(dh->signature, KDUMP_SIGNATURE, strlen(KDUMP_SIGNATURE));
>> - dh->header_version = 5;
>> + dh->header_version = 6;
>> dh->block_size = info->page_size;
>> dh->sub_hdr_size = sizeof(kh) + size_note;
>> dh->sub_hdr_size = divideup(dh->sub_hdr_size, dh->block_size);
>> - dh->max_mapnr = info->max_mapnr;
>> + /* dh->max_mapnr may be truncated, full 64bit in kh.max_mapnr_64 */
>> + dh->max_mapnr = MIN(info->max_mapnr, UINT_MAX);
>> dh->nr_cpus = get_nr_cpus();
>> dh->bitmap_blocks = divideup(info->len_bitmap, dh->block_size);
>> memcpy(&dh->timestamp, &info->timestamp, sizeof(dh->timestamp));
>> @@ -5172,12 +5186,21 @@ write_kdump_header(void)
>> */
>> size = sizeof(struct kdump_sub_header);
>> memset(&kh, 0, size);
>> + /* 64bit max_mapnr_64 */
>> + kh.max_mapnr_64 = info->max_mapnr;
>> kh.phys_base = info->phys_base;
>> kh.dump_level = info->dump_level;
>> if (info->flag_split) {
>> kh.split = 1;
>> + /* start_pfn and end_pfn may be truncated,
>> + * only for compatibility purpose
>> + */
>> kh.start_pfn = info->split_start_pfn;
>> kh.end_pfn = info->split_end_pfn;
>
> Please:
>
> kh.start_pfn = MIN(info->split_start_pfn, UINT_MAX);
> kh.end_pfn = MIN(info->split_end_pfn, UINT_MAX);
>

will fix.

>> +
>> + /* 64bit start_pfn_64 and end_pfn_64 */
>> + kh.start_pfn_64 = info->split_start_pfn;
>> + kh.end_pfn_64 = info->split_end_pfn;
>> }
>> if (has_pt_note()) {
>> /*
>> @@ -6421,7 +6444,7 @@ int
>> write_kdump_bitmap(void)
>> {
>> struct cache_data bm;
>> - long buf_size;
>> + long long buf_size;
>> off_t offset;
>>
>> int ret = FALSE;
>> @@ -7796,10 +7819,8 @@ store_splitting_info(void)
>>
>> if (i == 0) {
>> memcpy(&dh, &tmp_dh, sizeof(tmp_dh));
>> - info->max_mapnr = dh.max_mapnr;
>> if (!set_page_size(dh.block_size))
>> return FALSE;
>> - DEBUG_MSG("max_mapnr : %llx\n", info->max_mapnr);
>> DEBUG_MSG("page_size : %ld\n", info->page_size);
>> }
>>
>> @@ -7816,11 +7837,26 @@ store_splitting_info(void)
>> return FALSE;
>>
>> if (i == 0) {
>> + if (dh.header_version >= 6)
>> + info->max_mapnr = kh.max_mapnr_64;
>> + else
>> + info->max_mapnr = dh.max_mapnr;
>> +
>> + DEBUG_MSG("max_mapnr : %llx\n", info->max_mapnr);
>> + }
>> +
>> + if (i == 0) {
>> info->dump_level = kh.dump_level;
>> DEBUG_MSG("dump_level : %d\n", info->dump_level);
>> }
>> - SPLITTING_START_PFN(i) = kh.start_pfn;
>> - SPLITTING_END_PFN(i) = kh.end_pfn;
>> +
>> + if (dh.header_version >= 6) {
>> + SPLITTING_START_PFN(i) = kh.start_pfn_64;
>> + SPLITTING_END_PFN(i) = kh.end_pfn_64;
>> + } else {
>> + SPLITTING_START_PFN(i) = kh.start_pfn;
>> + SPLITTING_END_PFN(i) = kh.end_pfn;
>> + }
>> SPLITTING_OFFSET_EI(i) = kh.offset_eraseinfo;
>> SPLITTING_SIZE_EI(i) = kh.size_eraseinfo;
>> }
>> @@ -7954,6 +7990,7 @@ reassemble_kdump_header(void)
>> struct disk_dump_header dh;
>> struct kdump_sub_header kh;
>> char *buf_bitmap = NULL;
>> + ssize_t status, read_size, written_size;
>>
>> /*
>> * Write common header.
>> @@ -7981,6 +8018,8 @@ reassemble_kdump_header(void)
>> kh.split = 0;
>> kh.start_pfn = 0;
>> kh.end_pfn = 0;
>> + kh.start_pfn_64 = 0;
>> + kh.end_pfn_64 = 0;
>>
>> if (lseek(info->fd_dumpfile, info->page_size, SEEK_SET) < 0) {
>> ERRMSG("Can't seek a file(%s). %s\n",
>> @@ -8030,36 +8069,49 @@ reassemble_kdump_header(void)
>> SPLITTING_DUMPFILE(0), strerror(errno));
>> goto out;
>> }
>> - if (read(fd, buf_bitmap, info->len_bitmap) != info->len_bitmap) {
>> - ERRMSG("Can't read a file(%s). %s\n",
>> - SPLITTING_DUMPFILE(0), strerror(errno));
>> - goto out;
>> + read_size = 0;
>> + while (read_size < info->len_bitmap) {
>> + status = read(fd, buf_bitmap + read_size, info->len_bitmap
>> + - read_size);
>> + if (status < 0) {
>> + ERRMSG("Can't read a file(%s). %s\n",
>> + SPLITTING_DUMPFILE(0), strerror(errno));
>> + goto out;
>> + }
>> + read_size += status;
>
> This change is not relevant to topic of this patch.
>

OK, I will send out it in a separate patch.

>> }
>> -
>> if (lseek(info->fd_dumpfile, offset, SEEK_SET) < 0) {
>> ERRMSG("Can't seek a file(%s). %s\n",
>> info->name_dumpfile, strerror(errno));
>> goto out;
>> }
>> - if (write(info->fd_dumpfile, buf_bitmap, info->len_bitmap)
>> - != info->len_bitmap) {
>> - ERRMSG("Can't write a file(%s). %s\n",
>> - info->name_dumpfile, strerror(errno));
>> - goto out;
>> + written_size = 0;
>> + while (written_size < info->len_bitmap) {
>> + status = write(info->fd_dumpfile, buf_bitmap + written_size,
>> + info->len_bitmap - written_size);
>> + if (status < 0) {
>> + ERRMSG("Can't write a file(%s). %s\n",
>> + info->name_dumpfile, strerror(errno));
>> + goto out;
>> + }
>> + written_size += status;
>
> This, too.
>

will fix.

>> }
>> -
>> if (lseek(info->fd_bitmap, 0x0, SEEK_SET) < 0) {
>> ERRMSG("Can't seek a file(%s). %s\n",
>> info->name_bitmap, strerror(errno));
>> goto out;
>> }
>> - if (write(info->fd_bitmap, buf_bitmap, info->len_bitmap)
>> - != info->len_bitmap) {
>> - ERRMSG("Can't write a file(%s). %s\n",
>> - info->name_bitmap, strerror(errno));
>> - goto out;
>> + written_size = 0;
>> + while (written_size < info->len_bitmap) {
>> + status = write(info->fd_bitmap, buf_bitmap + written_size,
>> + info->len_bitmap - written_size);
>> + if (status < 0) {
>> + ERRMSG("Can't write a file(%s). %s\n",
>> + info->name_bitmap, strerror(errno));
>> + goto out;
>> + }
>> + written_size += status;
>
> This, too.
>

will fix.

>> }
>> -
>
> Unintended deletion?
>

will fix.

>> ret = TRUE;
>> out:
>> if (fd > 0)
>> diff --git a/makedumpfile.h b/makedumpfile.h
>> index a5826e0..4056fa0 100644
>> --- a/makedumpfile.h
>> +++ b/makedumpfile.h
>> @@ -927,7 +927,7 @@ struct DumpInfo {
>> */
>> int block_order;
>> off_t offset_bitmap1;
>> - unsigned long len_bitmap; /* size of bitmap(1st and 2nd) */
>> + unsigned long long len_bitmap; /* size of bitmap(1st and 2nd) */
>
> unsigned long can still represent upto 128 TiB physical memory.
> This change doesn't seem definitely needed.

Actually it covers two bitmaps, so it will represent up-to 64TB physical 
memory. anyway, Linux x86_64 only supports 64TB currently, so I will 
change it back.

>
>> struct dump_bitmap *bitmap1;
>> struct dump_bitmap *bitmap2;
>> struct disk_dump_header *dump_header;
>>
>
>

I will send my v3 patch soon.
Thanks!

-- 
Thanks,
Jingbai Ma

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
