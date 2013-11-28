Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VlwMR-00044O-P9
 for kexec@lists.infradead.org; Thu, 28 Nov 2013 07:50:09 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 60B283EE0BC
 for <kexec@lists.infradead.org>; Thu, 28 Nov 2013 16:49:40 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 4FA3F45DEBF
 for <kexec@lists.infradead.org>; Thu, 28 Nov 2013 16:49:40 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.nic.fujitsu.com [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 2984045DEB5
 for <kexec@lists.infradead.org>; Thu, 28 Nov 2013 16:49:40 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 100E11DB8040
 for <kexec@lists.infradead.org>; Thu, 28 Nov 2013 16:49:40 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id A7D491DB803B
 for <kexec@lists.infradead.org>; Thu, 28 Nov 2013 16:49:39 +0900 (JST)
Message-ID: <5296F55F.30403@jp.fujitsu.com>
Date: Thu, 28 Nov 2013 16:48:47 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] makedumpfile: hugepage filtering for vmcore dump
References: <20131105134532.32112.78008.stgit@k.asiapacific.hpqcorp.net>
 <20131105202631.GC4598@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971BB7A9@BPXM01GP.gisp.nec.co.jp>
 <527AE4DE.3050209@jp.fujitsu.com> <528F04EB.4070109@jp.fujitsu.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971C7EC5@BPXM01GP.gisp.nec.co.jp>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE971C7EC5@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "bhe@redhat.com" <bhe@redhat.com>, "tom.vaden@hp.com" <tom.vaden@hp.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "jingbai.ma@hp.com" <jingbai.ma@hp.com>, "ptesarik@suse.cz" <ptesarik@suse.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lisa.mitchell@hp.com" <lisa.mitchell@hp.com>, "anderson@redhat.com" <anderson@redhat.com>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "vgoyal@redhat.com" <vgoyal@redhat.com>

(2013/11/28 16:08), Atsushi Kumagai wrote:
> On 2013/11/22 16:18:20, kexec <kexec-bounces@lists.infradead.org> wrote:
>> (2013/11/07 9:54), HATAYAMA Daisuke wrote:
>>> (2013/11/06 11:21), Atsushi Kumagai wrote:
>>>> (2013/11/06 5:27), Vivek Goyal wrote:
>>>>> On Tue, Nov 05, 2013 at 09:45:32PM +0800, Jingbai Ma wrote:
>>>>>> This patch set intend to exclude unnecessary hugepages from vmcore dump file.
>>>>>>
>>>>>> This patch requires the kernel patch to export necessary data structures into
>>>>>> vmcore: "kexec: export hugepage data structure into vmcoreinfo"
>>>>>> http://lists.infradead.org/pipermail/kexec/2013-November/009997.html
>>>>>>
>>>>>> This patch introduce two new dump levels 32 and 64 to exclude all unused and
>>>>>> active hugepages. The level to exclude all unnecessary pages will be 127 now.
>>>>>
>>>>> Interesting. Why hugepages should be treated any differentely than normal
>>>>> pages?
>>>>>
>>>>> If user asked to filter out free page, then it should be filtered and
>>>>> it should not matter whether it is a huge page or not?
>>>>
>>>> I'm making a RFC patch of hugepages filtering based on such policy.
>>>>
>>>> I attach the prototype version.
>>>> It's able to filter out also THPs, and suitable for cyclic processing
>>>> because it depends on mem_map and looking up it can be divided into
>>>> cycles. This is the same idea as page_is_buddy().
>>>>
>>>> So I think it's better.
>>>>
>>>
>>>> @@ -4506,14 +4583,49 @@ __exclude_unnecessary_pages(unsigned long mem_map,
>>>>                 && !isAnon(mapping)) {
>>>>                 if (clear_bit_on_2nd_bitmap_for_kernel(pfn))
>>>>                     pfn_cache_private++;
>>>> +            /*
>>>> +             * NOTE: If THP for cache is introduced, the check for
>>>> +             *       compound pages is needed here.
>>>> +             */
>>>>             }
>>>>             /*
>>>>              * Exclude the data page of the user process.
>>>>              */
>>>> -        else if ((info->dump_level & DL_EXCLUDE_USER_DATA)
>>>> -            && isAnon(mapping)) {
>>>> -            if (clear_bit_on_2nd_bitmap_for_kernel(pfn))
>>>> -                pfn_user++;
>>>> +        else if (info->dump_level & DL_EXCLUDE_USER_DATA) {
>>>> +            /*
>>>> +             * Exclude the anonnymous pages as user pages.
>>>> +             */
>>>> +            if (isAnon(mapping)) {
>>>> +                if (clear_bit_on_2nd_bitmap_for_kernel(pfn))
>>>> +                    pfn_user++;
>>>> +
>>>> +                /*
>>>> +                 * Check the compound page
>>>> +                 */
>>>> +                if (page_is_hugepage(flags) && compound_order > 0) {
>>>> +                    int i, nr_pages = 1 << compound_order;
>>>> +
>>>> +                    for (i = 1; i < nr_pages; ++i) {
>>>> +                        if (clear_bit_on_2nd_bitmap_for_kernel(pfn + i))
>>>> +                            pfn_user++;
>>>> +                    }
>>>> +                    pfn += nr_pages - 2;
>>>> +                    mem_map += (nr_pages - 1) * SIZE(page);
>>>> +                }
>>>> +            }
>>>> +            /*
>>>> +             * Exclude the hugetlbfs pages as user pages.
>>>> +             */
>>>> +            else if (hugetlb_dtor == SYMBOL(free_huge_page)) {
>>>> +                int i, nr_pages = 1 << compound_order;
>>>> +
>>>> +                for (i = 0; i < nr_pages; ++i) {
>>>> +                    if (clear_bit_on_2nd_bitmap_for_kernel(pfn + i))
>>>> +                        pfn_user++;
>>>> +                }
>>>> +                pfn += nr_pages - 1;
>>>> +                mem_map += (nr_pages - 1) * SIZE(page);
>>>> +            }
>>>>             }
>>>>             /*
>>>>              * Exclude the hwpoison page.
>>>
>>> I'm concerned about the case that filtering is not performed to part of mem_map
>>> entries not belonging to the current cyclic range.
>>>
>>> If maximum value of compound_order is larger than maximum value of
>>> CONFIG_FORCE_MAX_ZONEORDER, which makedumpfile obtains by ARRAY_LENGTH(zone.free_area),
>>> it's necessary to align info->bufsize_cyclic with larger one in
>>> check_cyclic_buffer_overrun().
>>>
>>
>> ping, in case you overlooked this...
> 
> Sorry for the delayed response, I prioritize the release of v1.5.5 now.
> 
> Thanks for your advice, check_cyclic_buffer_overrun() should be fixed
> as you said. In addition, I'm considering other way to address such case,
> that is to bring the number of "overflowed pages" to the next cycle and
> exclude them at the top of __exclude_unnecessary_pages() like below:
> 
>                 /*
>                  * The pages which should be excluded still remain.
>                  */
>                 if (remainder >= 1) {
>                         int i;
>                         unsigned long tmp;
>                         for (i = 0; i < remainder; ++i) {
>                                 if (clear_bit_on_2nd_bitmap_for_kernel(pfn + i)) {
>                                         pfn_user++;
>                                         tmp++;
>                                 }
>                         }
>                         pfn += tmp;
>                         remainder -= tmp;
>                         mem_map += (tmp - 1) * SIZE(page);
>                         continue;
>                 }
> 
> If this way works well, then aligning info->buf_size_cyclic will be
> unnecessary.
> 

I selected the current implementation of changing cyclic buffer size becuase
I thought it was simpler than carrying over remaining filtered pages to next cycle
in that there was no need to add extra code in filtering processing.

I guess the reason why you think this is better now is how to detect maximum order of
huge page is hard in some way, right?

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
