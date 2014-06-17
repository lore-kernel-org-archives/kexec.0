Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WwjEq-00015O-DY
 for kexec@lists.infradead.org; Tue, 17 Jun 2014 02:35:09 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH 3/3] Stop maximizing the bitmap buffer to reduce the
 risk of OOM.
Date: Tue, 17 Jun 2014 02:32:26 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE97223015@BPXM01GP.gisp.nec.co.jp>
References: <0910DD04CBD6DE4193FCF86B9C00BE972196C5@BPXM01GP.gisp.nec.co.jp>
 <20140616082959.GA1718@dhcp-16-105.nay.redhat.com>
In-Reply-To: <20140616082959.GA1718@dhcp-16-105.nay.redhat.com>
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
To: "bhe@redhat.com" <bhe@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Baoquan,

Thanks for your careful review.

>On 06/10/14 at 04:54am, Atsushi Kumagai wrote:
>> We tried to maximize the bitmap buffer to get the best performance,
>> but the performance degradation caused by multi-cycle processing
>> looks very small according to the benchmark on 2TB memory:
>>
>>   https://lkml.org/lkml/2013/3/26/914
>>
>> This result means we don't need to make an effort to maximize the
>> bitmap buffer, it will just increase the risk of OOM.
>>
>> This patch sets a small fixed value (4MB) as a safety limit,
>> it may be safer and enough in most cases.
>>
>> Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
>> ---
>>  makedumpfile.c | 17 ++++++++++-------
>>  1 file changed, 10 insertions(+), 7 deletions(-)
>>
>> diff --git a/makedumpfile.c b/makedumpfile.c
>> index b8f1ec4..c23667b 100644
>> --- a/makedumpfile.c
>> +++ b/makedumpfile.c
>> @@ -8946,13 +8946,15 @@ out:
>>
>>
>>  /*
>> - * Choose the lesser value of the two below as the size of cyclic buffer.
>> - *  - the size enough for storing the 1st/2nd bitmap for the whole of vmcore
>> - *  - 80% of free memory (as safety limit)
>> + * Choose the lesser value of the three below as the size of cyclic buffer.
>                 ~~~~~ typo, it should be less.

I'll fix it.

>> + *  - the size enough for storing the 1st or 2nd bitmap for the whole of vmcore
>> + *  - 4MB as sufficient value
>> + *  - 60% of free memory as safety limit
>>   */
>>  int
>>  calculate_cyclic_buffer_size(void) {
>>  	unsigned long long limit_size, bitmap_size;
>> +	const unsigned long long maximum_size = 4 * 1024 * 1024;
>>
>>  	if (info->max_mapnr <= 0) {
>>  		ERRMSG("Invalid max_mapnr(%llu).\n", info->max_mapnr);
>> @@ -8960,17 +8962,18 @@ calculate_cyclic_buffer_size(void) {
>>  	}
>>
>>  	/*
>> -	 *  We should keep the size of cyclic buffer within 80% of free memory
>> -	 *  for safety.
>> +	 *  At least, we should keep the size of cyclic buffer within 60% of
>> +	 *  free memory for safety.
>>  	 */
>> -	limit_size = get_free_memory_size() * 0.8;
>> +	limit_size = get_free_memory_size() * 0.6;
>>  	bitmap_size = info->max_mapnr / BITPERBYTE;
>>
>>  	/* if --split was specified cyclic buffer allocated per dump file */
>>  	if (info->num_dumpfile > 1)
>>  		bitmap_size /= info->num_dumpfile;
>>
>> -	info->bufsize_cyclic = MIN(limit_size, bitmap_size);
>> +	/* 4MB will be enought for performance according to benchmarks. */
>                      ~~~~~~~~
>There's a typo, here should be enough.

I'll fix it.


Thanks
Atsushi Kumagai

>> +	info->bufsize_cyclic = MIN(MIN(limit_size, maximum_size), bitmap_size);
>>
>>  	return TRUE;
>>  }
>> --
>> 1.9.0
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
