Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vjl05-0007sb-7J
 for kexec@lists.infradead.org; Fri, 22 Nov 2013 07:18:05 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 8C6BE3EE1D9
 for <kexec@lists.infradead.org>; Fri, 22 Nov 2013 16:17:31 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 7BB6245DE4C
 for <kexec@lists.infradead.org>; Fri, 22 Nov 2013 16:17:31 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.nic.fujitsu.com [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 58BB945DE56
 for <kexec@lists.infradead.org>; Fri, 22 Nov 2013 16:17:31 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 34949E38007
 for <kexec@lists.infradead.org>; Fri, 22 Nov 2013 16:17:31 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id D465B1DB803A
 for <kexec@lists.infradead.org>; Fri, 22 Nov 2013 16:17:30 +0900 (JST)
Message-ID: <528F04EB.4070109@jp.fujitsu.com>
Date: Fri, 22 Nov 2013 16:16:59 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] makedumpfile: hugepage filtering for vmcore dump
References: <20131105134532.32112.78008.stgit@k.asiapacific.hpqcorp.net>
 <20131105202631.GC4598@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971BB7A9@BPXM01GP.gisp.nec.co.jp>
 <527AE4DE.3050209@jp.fujitsu.com>
In-Reply-To: <527AE4DE.3050209@jp.fujitsu.com>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "bhe@redhat.com" <bhe@redhat.com>, "tom.vaden@hp.com" <tom.vaden@hp.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "ptesarik@suse.cz" <ptesarik@suse.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lisa.mitchell@hp.com" <lisa.mitchell@hp.com>, "vgoyal@redhat.com" <vgoyal@redhat.com>, "anderson@redhat.com" <anderson@redhat.com>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "jingbai.ma@hp.com" <jingbai.ma@hp.com>

(2013/11/07 9:54), HATAYAMA Daisuke wrote:
> (2013/11/06 11:21), Atsushi Kumagai wrote:
>> (2013/11/06 5:27), Vivek Goyal wrote:
>>> On Tue, Nov 05, 2013 at 09:45:32PM +0800, Jingbai Ma wrote:
>>>> This patch set intend to exclude unnecessary hugepages from vmcore dump file.
>>>>
>>>> This patch requires the kernel patch to export necessary data structures into
>>>> vmcore: "kexec: export hugepage data structure into vmcoreinfo"
>>>> http://lists.infradead.org/pipermail/kexec/2013-November/009997.html
>>>>
>>>> This patch introduce two new dump levels 32 and 64 to exclude all unused and
>>>> active hugepages. The level to exclude all unnecessary pages will be 127 now.
>>>
>>> Interesting. Why hugepages should be treated any differentely than normal
>>> pages?
>>>
>>> If user asked to filter out free page, then it should be filtered and
>>> it should not matter whether it is a huge page or not?
>>
>> I'm making a RFC patch of hugepages filtering based on such policy.
>>
>> I attach the prototype version.
>> It's able to filter out also THPs, and suitable for cyclic processing
>> because it depends on mem_map and looking up it can be divided into
>> cycles. This is the same idea as page_is_buddy().
>>
>> So I think it's better.
>>
>
>> @@ -4506,14 +4583,49 @@ __exclude_unnecessary_pages(unsigned long mem_map,
>>                && !isAnon(mapping)) {
>>                if (clear_bit_on_2nd_bitmap_for_kernel(pfn))
>>                    pfn_cache_private++;
>> +            /*
>> +             * NOTE: If THP for cache is introduced, the check for
>> +             *       compound pages is needed here.
>> +             */
>>            }
>>            /*
>>             * Exclude the data page of the user process.
>>             */
>> -        else if ((info->dump_level & DL_EXCLUDE_USER_DATA)
>> -            && isAnon(mapping)) {
>> -            if (clear_bit_on_2nd_bitmap_for_kernel(pfn))
>> -                pfn_user++;
>> +        else if (info->dump_level & DL_EXCLUDE_USER_DATA) {
>> +            /*
>> +             * Exclude the anonnymous pages as user pages.
>> +             */
>> +            if (isAnon(mapping)) {
>> +                if (clear_bit_on_2nd_bitmap_for_kernel(pfn))
>> +                    pfn_user++;
>> +
>> +                /*
>> +                 * Check the compound page
>> +                 */
>> +                if (page_is_hugepage(flags) && compound_order > 0) {
>> +                    int i, nr_pages = 1 << compound_order;
>> +
>> +                    for (i = 1; i < nr_pages; ++i) {
>> +                        if (clear_bit_on_2nd_bitmap_for_kernel(pfn + i))
>> +                            pfn_user++;
>> +                    }
>> +                    pfn += nr_pages - 2;
>> +                    mem_map += (nr_pages - 1) * SIZE(page);
>> +                }
>> +            }
>> +            /*
>> +             * Exclude the hugetlbfs pages as user pages.
>> +             */
>> +            else if (hugetlb_dtor == SYMBOL(free_huge_page)) {
>> +                int i, nr_pages = 1 << compound_order;
>> +
>> +                for (i = 0; i < nr_pages; ++i) {
>> +                    if (clear_bit_on_2nd_bitmap_for_kernel(pfn + i))
>> +                        pfn_user++;
>> +                }
>> +                pfn += nr_pages - 1;
>> +                mem_map += (nr_pages - 1) * SIZE(page);
>> +            }
>>            }
>>            /*
>>             * Exclude the hwpoison page.
>
> I'm concerned about the case that filtering is not performed to part of mem_map
> entries not belonging to the current cyclic range.
>
> If maximum value of compound_order is larger than maximum value of
> CONFIG_FORCE_MAX_ZONEORDER, which makedumpfile obtains by ARRAY_LENGTH(zone.free_area),
> it's necessary to align info->bufsize_cyclic with larger one in
> check_cyclic_buffer_overrun().
>

ping, in case you overlooked this...

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
