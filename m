Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo200.gate.nec.co.jp ([210.143.35.50])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WXRyz-00089X-Gw
 for kexec@lists.infradead.org; Tue, 08 Apr 2014 09:06:19 +0000
Received: from tyo201.gate.nec.co.jp ([10.7.69.201])
 by tyo200.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id s3893qe3008172
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
 for <kexec@lists.infradead.org>; Tue, 8 Apr 2014 18:03:52 +0900 (JST)
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH v2 2/3] Generic handling of multi-page exclusions
Date: Tue, 8 Apr 2014 09:00:19 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971FF28C@BPXM01GP.gisp.nec.co.jp>
References: <25702884512808755449395c1622f2aed7b3be00.1396632131.git.ptesarik@suse.cz>
 <20140408.104907.132144009.d.hatayama@jp.fujitsu.com>
 <20140408085436.51340ae2@hananiah.suse.cz>
 <20140408.171903.322808733.d.hatayama@jp.fujitsu.com>
In-Reply-To: <20140408.171903.322808733.d.hatayama@jp.fujitsu.com>
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
To: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "ptesarik@suse.cz" <ptesarik@suse.cz>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>From: Petr Tesarik <ptesarik@suse.cz>
>Subject: Re: [PATCH v2 2/3] Generic handling of multi-page exclusions
>Date: Tue, 8 Apr 2014 08:54:36 +0200
>
>> On Tue, 08 Apr 2014 10:49:07 +0900 (JST)
>> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
>>
>>> From: Petr Tesarik <ptesarik@suse.cz>
>>> Subject: [PATCH v2 2/3] Generic handling of multi-page exclusions
>>> Date: Fri, 4 Apr 2014 19:25:08 +0200
>>>
>>> > When multiple pages are excluded from the dump, store the extents in the
>>> > mem_map_data structure, and check if anything is still pending on the
>>> > next invocation of __exclude_unnecessary_pages for the same mem_map.
>>> >
>>> > The start PFN of the excluded extent is set to the end of the current
>>> > cycle (which is equal to the start of the next cycle, see update_cycle),
>>> > so only the part of the excluded region which falls beyond current cycle
>>> > buffer is valid. If the excluded region is completely processed in the
>>> > current cycle, the start PFN is even bigger than the end PFN. That
>>> > causes nothing to be done at the beginning of the next cycle.
>>> >
>>> > There is no check whether the adjusted pfn_start is still within the
>>> > current cycle. Nothing bad happens if it isn't, because exclude_range()
>>> > is used again to exclude the remaining part, so even if the excluded
>>> > region happens to span more than two cycles, the code will still work
>>> > correctly.
>>> >
>>> > Note that clear_bit_on_2nd_bitmap_for_kernel() accepts PFNs outside the
>>> > current cyclic range. It willreturn FALSE, so such PFNs are not counted.
>>> >
>>> > Signed-off-by: Petr Tesarik <ptesarik@suse.cz>
>>> > ---
>>> >  makedumpfile.c | 47 +++++++++++++++++++++++++++++++++--------------
>>> >  makedumpfile.h |  7 +++++++
>>> >  2 files changed, 40 insertions(+), 14 deletions(-)
>>> >
>>> > diff --git a/makedumpfile.c b/makedumpfile.c
>>> > index 81c687b..9ffb901 100644
>>> > --- a/makedumpfile.c
>>> > +++ b/makedumpfile.c
>>> > @@ -2385,6 +2385,9 @@ dump_mem_map(unsigned long long pfn_start,
>>> >  	mmd->pfn_end   = pfn_end;
>>> >  	mmd->mem_map   = mem_map;
>>> >
>>> > +	mmd->exclude_pfn_start = 0ULL;
>>> > +	mmd->exclude_pfn_end   = 0ULL;
>>> > +
>>> >  	DEBUG_MSG("mem_map (%d)\n", num_mm);
>>> >  	DEBUG_MSG("  mem_map    : %lx\n", mem_map);
>>> >  	DEBUG_MSG("  pfn_start  : %llx\n", pfn_start);
>>> > @@ -4657,6 +4660,21 @@ initialize_2nd_bitmap_cyclic(struct cycle *cycle)
>>> >  	return TRUE;
>>> >  }
>>> >
>>> > +static void
>>> > +exclude_range(unsigned long long *counter, struct mem_map_data *mmd,
>>> > +    unsigned long long pfn, unsigned long long endpfn, struct cycle *cycle)
>>> > +{
>>> > +	while (pfn < endpfn) {
>>> > +		if (clear_bit_on_2nd_bitmap_for_kernel(pfn, cycle))
>>> > +			(*counter)++;
>>> > +		++pfn;
>>> > +	}
>>>
>>> Here endpfn is pfn + nr_pages in __exclude_unnecessary_pages(), and
>>> the pfn could be cycle->end_pfn <= pfn < endpfn.
>>>
>>> while (pfn < MIN(endpfn, cycle->end_pfn) {
>>> 	if (clear_bit_on_2nd_bitmap_for_kernel(pfn, cycle))
>>> 		(*counter)++;
>>> 	++pfn;
>>> }
>>
>> This is a non-issue: clear_bitmap_cyclic() checks the extents, and I
>> even mentioned it in the commit message. All right, we can save some
>> loop iterations by moving the check out of the loop body...
>>
>
>Ah, OK, I interpreted somehow your code like:
>
>+	mmd->exclude_pfn_start = cycle ? endpfn: ULONGLONG_MAX;
>
>So there's no logically wrong point.
>
>BTW, hmm, the behaviour of clear_bit_on_2nd_bitmap_for_kernel() is not
>what I expect, that is, I don't expect sanity check in
>set_bitmap_cyclic(), which should have been removed by clean up we did
>some times ago.

At that time, I chose the current code since it was simpler and safer.
http://www.mail-archive.com/kexec%40lists.infradead.org/msg10207.html

Don't you like this ?


Thanks
Atsushi Kumagai

>int
>set_bitmap_cyclic(char *bitmap, unsigned long long pfn, int val, struct cycle *cycle)
>{
>        int byte, bit;
>
>        if (pfn < cycle->start_pfn || cycle->end_pfn <= pfn) <-- this
>                return FALSE;
>
>The code some time ago changes region of cycles in many places and it
>was difficult to figure out. So, in the clean up, we introduced struct
>cycle and for_each_cycle() to obtain invariance that cycle is not
>changed under for_each_cycle().
>
>So, could you fix also this if possible?
>
>>> > +
>>> > +	mmd->exclude_pfn_start = cycle ? cycle->end_pfn : ULONGLONG_MAX;
>>>
>>> When does cycle become NULL?
>>
>> When __exclude_unnecessary_pages() is called from
>> exclude_unnecessary_pages, i.e. non-cyclic.
>>
>>> Along with the above point,
>>>
>>> mmd->exclude_pfn_start = MIN(endpfn, cycle->end_pfn);
>>>
>>> and then we can continue the processing in the next cycle.
>>
>> Again, this is a non-issue. These stored extents are validated before
>> use in __exclude_unnecessary_pages. Why should I check them twice?
>> And by the way, this is also mentioned in the commit message.
>>
>>> > +	mmd->exclude_pfn_end = endpfn;
>>> > +	mmd->exclude_pfn_counter = counter;
>>> > +}
>>> > +
>>> >  int
>>> >  __exclude_unnecessary_pages(struct mem_map_data *mmd, struct cycle *cycle)
>>> >  {
>>> > @@ -4671,6 +4689,18 @@ __exclude_unnecessary_pages(struct mem_map_data *mmd, struct cycle *cycle)
>>> >  	unsigned long flags, mapping, private = 0;
>>> >
>>> >  	/*
>>> > +	 * If a multi-page exclusion is pending, do it first
>>> > +	 */
>>> > +	if (mmd->exclude_pfn_start < mmd->exclude_pfn_end) {
>>> > +		exclude_range(mmd->exclude_pfn_counter, mmd,
>>> > +			mmd->exclude_pfn_start, mmd->exclude_pfn_end,
>>> > +			cycle);
>>> > +
>>> > +		mem_map += (mmd->exclude_pfn_end - pfn_start) * SIZE(page);
>>> > +		pfn_start = mmd->exclude_pfn_end;
>>> > +	}
>>> > +
>>> > +	/*
>>> >  	 * Refresh the buffer of struct page, when changing mem_map.
>>> >  	 */
>>> >  	pfn_read_start = ULONGLONG_MAX;
>>> > @@ -4734,21 +4764,10 @@ __exclude_unnecessary_pages(struct mem_map_data *mmd, struct cycle *cycle)
>>> >  		if ((info->dump_level & DL_EXCLUDE_FREE)
>>> >  		    && info->page_is_buddy
>>> >  		    && info->page_is_buddy(flags, _mapcount, private, _count)) {
>>> > -			int i, nr_pages = 1 << private;
>>> > +			int nr_pages = 1 << private;
>>> > +
>>> > +			exclude_range(&pfn_free, mmd, pfn, pfn + nr_pages, cycle);
>>> >
>>> > -			for (i = 0; i < nr_pages; ++i) {
>>> > -				/*
>>> > -				 * According to combination of
>>> > -				 * MAX_ORDER and size of cyclic
>>> > -				 * buffer, this clearing bit operation
>>> > -				 * can overrun the cyclic buffer.
>>> > -				 *
>>> > -				 * See check_cyclic_buffer_overrun()
>>> > -				 * for the detail.
>>> > -				 */
>>> > -				if (clear_bit_on_2nd_bitmap_for_kernel((pfn + i), cycle))
>>> > -					pfn_free++;
>>> > -			}
>>> >  			pfn += nr_pages - 1;
>>> >  			mem_map += (nr_pages - 1) * SIZE(page);
>>> >  		}
>>> > diff --git a/makedumpfile.h b/makedumpfile.h
>>> > index 951ed1b..dfad569 100644
>>> > --- a/makedumpfile.h
>>> > +++ b/makedumpfile.h
>>> > @@ -816,6 +816,13 @@ struct mem_map_data {
>>> >  	unsigned long long	pfn_start;
>>> >  	unsigned long long	pfn_end;
>>> >  	unsigned long	mem_map;
>>> > +
>>> > +	/*
>>> > +	 * for excluding multi-page regions
>>> > +	 */
>>> > +	unsigned long		exclude_pfn_start;
>>> > +	unsigned long		exclude_pfn_end;
>>>
>>> unsigned long long		exclude_pfn_start;
>>> unsigned long long		exclude_pfn_end;
>>>
>>> The integers representing page frame numbers need to be defined as
>>> unsigned long long for architectures where physical address can have
>>> 64-bit length but unsigned long has 32-bit only, such as x86 PAE.
>>
>> Ouch. My mistake. I thought I covered all places, but somehow I
>> missed this one. I'm going to post a fixed series.
>>
>>> Kumagai-san, I saw this sometimes in the past. How about introducing
>>> specific abstract type for page frame number like below?
>>>
>>> typedef unsigned long long pfn_t;
>>>
>>> maybe with some prefix. I think this also helps code readability
>>> because unsigned long long is too long.
>>>
>>> > +	unsigned long long	*exclude_pfn_counter;
>>> >  };
>>>
>>> Also, it seems to me better to introduce a new type for this
>>> processing rather than extending existing code. struct mem_map_data is
>>> not specific for the excluding processing.
>>
>> Kind of agreed. OTOH it will most likely be embedded in struct
>> mem_map_data anyway, because exactly one such object per mm is needed.
>>
>> Petr T
>
>I don't understand well. It seems to me a single object is enough. Is
>it possible to nr_pages cover multiple mm's?
>
>Thanks.
>HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
