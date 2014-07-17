Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X7fJt-0002ly-Is
 for kexec@lists.infradead.org; Thu, 17 Jul 2014 06:37:34 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH v2] makedumpfile: Exclude unnecessary hugepages.
Date: Thu, 17 Jul 2014 06:34:33 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE97241BA0@BPXM01GP.gisp.nec.co.jp>
References: <0910DD04CBD6DE4193FCF86B9C00BE9722301C@BPXM01GP.gisp.nec.co.jp>
 <20140714063018.GC1717@dhcp-17-102.nay.redhat.com>
In-Reply-To: <20140714063018.GC1717@dhcp-17-102.nay.redhat.com>
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

>On 06/17/14 at 02:32am, Atsushi Kumagai wrote:
>> Hello,
>>
>>  		/*
>>  		 * Exclude the data page of the user process.
>>  		 */
>> -		else if ((info->dump_level & DL_EXCLUDE_USER_DATA)
>> -		    && isAnon(mapping)) {
>> -			if (clear_bit_on_2nd_bitmap_for_kernel(pfn, cycle))
>> -				pfn_user++;
>> +		else if (info->dump_level & DL_EXCLUDE_USER_DATA) {
>Hi Atsushi,
>
>Could it be changed to checking hugepage first, then anonymous page?
>This can avoid involving the free_huge_page.
>
>like this:
>	int nr_pages;
>	if (page_is_hugepage(flags) {
>		int nr_pages = 1 << compound_order;
>
>		exclude_range(&pfn_user, pfn, pfn + nr_pages, cycle);
>
>		pfn += nr_pages - 1;
>		mem_map += (nr_pages - 1) * SIZE(page);
>	} else if (isAnon(mapping)) {
>		int nr_pages = 1;
>
>		exclude_range(&pfn_user, pfn, pfn + nr_pages, cycle);
>
>		pfn += nr_pages - 1;
>		mem_map += (nr_pages - 1) * SIZE(page);
>	}
>
>But I may not know the meaning of free_huge_page completely. If you
>think introducing free_huge_page is better, I am fine too, can ACK that
>kernel patch to export free_huge_page you posted.

The assumption that all compound pages are user pages is wrong since some
kernel pages can be compound. For example, kmalloc_large_node() calls 
alloc_pages_node() with __GFP_COMP. This means we have to check compound
user pages without only depending on page_is_hugepage(). We can detect THPs
with the combination of page_is_hugepage() and isAnon(), but it can't be
applied to hugetlbfs pages.
This is why we need to export free_huge_page.

BTW, the v2 code can misdetect hugetlbfs due to the wrong check order, 
I'm going to fix it in the next version.


Thanks
Atsushi Kumagai

>Thanks
>Baoquan
>
>> +			/*
>> +			 * Exclude the anonymous pages as user pages.
>> +			 */
>> +			if (isAnon(mapping)) {
>> +				int nr_pages;
>> +				/*
>> +				 * Check the compound page
>> +				 */
>> +				if (page_is_hugepage(flags) && compound_order > 0)
>> +					nr_pages = 1 << compound_order;
>> +				else
>> +					nr_pages = 1;
>> +
>> +				exclude_range(&pfn_user, pfn, pfn + nr_pages, cycle);
>> +
>> +				pfn += nr_pages - 1;
>> +				mem_map += (nr_pages - 1) * SIZE(page);
>> +			}
>> +			/*
>> +			 * Exclude the hugetlbfs pages as user pages.
>> +			 */
>> +			else if (hugetlb_dtor == SYMBOL(free_huge_page)) {
>> +				int nr_pages = 1 << compound_order;
>> +
>> +				exclude_range(&pfn_user, pfn, pfn + nr_pages, cycle);
>> +
>> +				pfn += nr_pages - 1;
>> +				mem_map += (nr_pages - 1) * SIZE(page);
>> +			}
>>  		}
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
