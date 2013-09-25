Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VOkHc-0007zB-FA
 for kexec@lists.infradead.org; Wed, 25 Sep 2013 08:17:17 +0000
Message-ID: <52429BF1.3050303@hp.com>
Date: Wed, 25 Sep 2013 16:16:49 +0800
From: Jingbai Ma <jingbai.ma@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: fix max_mapnr issue on system has over
 44-bit addressing
References: <20130924124931.14715.24507.stgit@k.asiapacific.hpqcorp.net>
 <52422FCF.1030206@jp.fujitsu.com>
In-Reply-To: <52422FCF.1030206@jp.fujitsu.com>
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

On 09/25/2013 08:35 AM, HATAYAMA Daisuke wrote:
> (2013/09/24 21:49), Jingbai Ma wrote:
>> This patch will fix a bug of makedumpfile doesn't work correctly on
>> system
>> has over 44-bit addressing in compression dump mode.
>> This bug was posted here:
>> http://lists.infradead.org/pipermail/kexec/2013-September/009587.html
>>
>> This patch will add a new field in struct kdump_sub_header.
>> unsigned long max_mapnr;
>>
>> And the old "unsigned int max_mapnr" in struct disk_dump_header will
>> not be used anymore. But still be there for compatibility purpose.
>>
>> This patch will change the header_version to 6.
>>
>> The corresponding patch for crash utility will be sent out separately.
>>
>> This patch doesn't change sadump_header.
>> Because of in sadump file, there is no any sub-header, it has to change
>> the sadump_header itself.
>> And if do so, will cause backwards-compatibility issue.
>> So it could be a separate patch if needed.
>>
>> Signed-off-by: Jingbai Ma <jingbai.ma@hp.com>
>> ---
>> IMPLEMENTATION | 1 +
>> diskdump_mod.h | 5 ++++-
>> makedumpfile.c | 28 ++++++++++++++++++++++------
>> 3 files changed, 27 insertions(+), 7 deletions(-)
>>
>> diff --git a/IMPLEMENTATION b/IMPLEMENTATION
>> index f0f3135..d576811 100644
>> --- a/IMPLEMENTATION
>> +++ b/IMPLEMENTATION
>> @@ -77,6 +77,7 @@
>> unsigned long size_note; /* header_version 4 and later */
>> off_t offset_eraseinfo; /* header_version 5 and later */
>> unsigned long size_eraseinfo; /* header_version 5 and later */
>> + unsigned long max_mapnr; /* header_version 6 and later */
>
> x86 PAE mode can represents 52-bit physical addresses and so 40-bit
> physical
> page frames. On x86_32 unsigned long has 32-bit length only. So, you should
> define max_mapnr as unsigned long long.
>

Good catch, I forgot x86 PAE mode also may exceed 32-bit length.
Will fix it.

>> };
>>
>> - 1st-bitmap
>> diff --git a/diskdump_mod.h b/diskdump_mod.h
>> index af060b6..30306a5 100644
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
>> @@ -75,6 +77,7 @@ struct kdump_sub_header {
>> unsigned long size_note; /* header_version 4 and later */
>> off_t offset_eraseinfo; /* header_version 5 and later */
>> unsigned long size_eraseinfo; /* header_version 5 and later */
>> + unsigned long max_mapnr; /* header_version 6 and later */
>
> This, too.

Will fix it.

>
>> @@ -5153,10 +5160,11 @@ write_kdump_header(void)
>> * Write common header
>> */
>> strncpy(dh->signature, KDUMP_SIGNATURE, strlen(KDUMP_SIGNATURE));
>> - dh->header_version = 5;
>> + dh->header_version = 6;
>> dh->block_size = info->page_size;
>> dh->sub_hdr_size = sizeof(kh) + size_note;
>> dh->sub_hdr_size = divideup(dh->sub_hdr_size, dh->block_size);
>> + /* dh->max_mapnr may be truncated here, full 64bit in kh.max_mapnr */
>> dh->max_mapnr = info->max_mapnr;
>
> dh->max_mapnr = MIN(info->max_mapnr, UINT_MAX) seems better for old
> versions of crash utitlity.
>

Although change this value to UINT_MAX doesn't help the old crash 
utility very much. At least this special value will tell the user 
something happened.
Will fix it.


-- 
Thanks,
Jingbai Ma

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
