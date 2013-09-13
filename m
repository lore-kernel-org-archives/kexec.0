Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VKOS0-0004l1-Kk
 for kexec@lists.infradead.org; Fri, 13 Sep 2013 08:10:03 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH] makedumpfile: shorten cyclic exclude-unnecessary passes
Date: Fri, 13 Sep 2013 08:06:26 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971B1654@BPXM01GP.gisp.nec.co.jp>
References: <E1VEnuJ-0000K6-Lo@eag09.americas.sgi.com>
 <521FEE6C.6090700@jp.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "cpw@sgi.com" <cpw@sgi.com>
Cc: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Cliff,

First, this patch should be divided into four patches as below:

1.
   - get_mm_sparsemem(): reduce the number of entries...
2.
   - shorten the executions of __exclude_unnecessary_pages()...
3.
   - for testing: add option -a to use cyclic mode...
4.
   - cosmetic: in cyclic mode count the number of cycles...
   - cosmetic: let the prints of unnecessary page scans stop...


> +	info->num_mem_map = valid_section_nr;
> +	if (valid_section_nr < num_section) {
> +		if (realloc(mem_sec, mem_section_size) != mem_sec) {
> +			ERRMSG("mem_sec realloc failed\n");
> +			exit(1);
> +		};
>   	}

realloc can return a pointer which is different from mem_sec,
I think the code below is better.

	info->num_mem_map = valid_section_nr;
	if (valid_section_nr < num_section) {
		mem_sec = realloc(mem_sec, mem_section_size);
		if (!mem_sec) {
			ERRMSG("mem_sec realloc failed\n");
			return FALSE;
		};
   	}

As for "1" and "2", the code looks no problem except the above,
so the effect of them is the important thing as HATAYAMA-san said.
I expect good results.

"3" should be removed since "use non-cyclic when possible"
was rejected.

Lastly, as for "4":

> Begin page counting phase.
> Scan cycle 1
> Excluding free pages               : [100 %]
> Excluding unnecessary pages        : [ 45 %]
> Scan cycle 2
> Excluding free pages               : [ 87 %]
> Excluding unnecessary pages        : [ 87 %]
> Scan cycle 3
> Excluding free pages               : [100 %]
> Excluding unnecessary pages        : [ 99 %]
> Scan cycle 4

Your code shows extra message, "Scan cycle 4"
is extra in this case.

> Scan-and-copy cycle 1/3
> Excluding free pages               : [ 45 %]
> Excluding unnecessary pages        : [ 45 %]
> Copying data                       : [ 44 %]
> Scan-and-copy cycle 2/3
> Excluding free pages               : [ 87 %]
> Excluding unnecessary pages        : [ 87 %]
> Copying data                       : [ 86 %]
> Scan-and-copy cycle 3/3
> Excluding free pages               : [100 %]
> Excluding unnecessary pages        : [ 99 %]
> Copying data                       : [100 %]
> Saving core complete


Thanks
Atsushi Kumagai

(2013/08/30 9:59), HATAYAMA Daisuke wrote:
> (2013/08/29 7:08), Cliff Wickman wrote:
>> From: Cliff Wickman <cpw@sgi.com>
>>
>> - get_mm_sparsemem(): reduce the number of entries in the mem_map[] by
>>     recording only those sections which actually exist in memory
>
> I have missed this point. How much does this change speed up?
>
> In general, if you want to say your patch improves performance, it's better to
> demonstrate it in a measurable way such as benchmark.
>
>> - shorten the executions of __exclude_unnecessary_pages() by passing it only
>>     the pfn's of the current cyclic area
>>
>
> I did try to similar kind of effort some months ago locally to figure out where
> to improve cyclic-mode. In case of me, I noticed possibility of unnecessary processing
> being performed out side the area of current cycle from the sanity check below:
>
> int
> set_bitmap_cyclic(char *bitmap, unsigned long long pfn, int val)
> {
>          int byte, bit;
>
>          if (pfn < info->cyclic_start_pfn || info->cyclic_end_pfn <= pfn)
>                  return FALSE;
> <cut>
>
> However, I didn't get distinguishable difference at that time. I ran the program
> relatively ordinary class of system with some gigabyte memory so I might not got
> distinguishable improvement.
>
> Anyway, I thought it was permissible at that time and I didn't continue that work more.
>
> But these days I have a machine with huge physical memory holes and on that system
> this improvement sounds work well. So I much want to try to benchmark this direction
> of your improvement patch set.
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
