Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ufhgt-0003OX-SI
 for kexec@lists.infradead.org; Fri, 24 May 2013 02:25:13 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 482733EE0BB
 for <kexec@lists.infradead.org>; Fri, 24 May 2013 11:24:44 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 3AF0345DEB6
 for <kexec@lists.infradead.org>; Fri, 24 May 2013 11:24:44 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 149B845DEB5
 for <kexec@lists.infradead.org>; Fri, 24 May 2013 11:24:44 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 07036E18001
 for <kexec@lists.infradead.org>; Fri, 24 May 2013 11:24:44 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id A2A1D1DB803B
 for <kexec@lists.infradead.org>; Fri, 24 May 2013 11:24:43 +0900 (JST)
Message-ID: <519ECF57.1080600@jp.fujitsu.com>
Date: Fri, 24 May 2013 11:24:23 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: Petr Tesarik's hugepage filtering
References: <E1UcggB-0005gy-4i@eag09.americas.sgi.com>
 <20130524101121.58d765fdfd5800dee0f1b951@mxc.nes.nec.co.jp>
In-Reply-To: <20130524101121.58d765fdfd5800dee0f1b951@mxc.nes.nec.co.jp>
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
Cc: kexec@lists.infradead.org, cpw@sgi.com

(2013/05/24 10:11), Atsushi Kumagai wrote:
> On Wed, 15 May 2013 13:43:59 -0500
> Cliff Wickman <cpw@sgi.com> wrote:

>>   	/*
>>   	 * The bitmap buffer is not dirty, and it is not necessary
>>   	 * to write out it.
>> @@ -4345,7 +4386,7 @@ __exclude_unnecessary_pages(unsigned lon
>>   		 * Exclude the data page of the user process.
>>   		 */
>>   		else if ((info->dump_level & DL_EXCLUDE_USER_DATA)
>> -		    && isAnon(mapping)) {
>> +		    && (isAnon(mapping) || isHugePage(flags))) {
>>   			if (clear_bit_on_2nd_bitmap_for_kernel(pfn))
>>   				pfn_user++;
>
> This code will filter out both transparent huge pages and hugetlbfs pages.
> But I think hugetlbfs pages shouldn't be filtered out as anonymous pages
> because anonymous pages and hugetlbfs pages are certainly different kind
> of pages.
>
> Therefore, I plan to add a new dump level to filter out hugetlbfs pages.
> My basic idea is like below:
>
>
>   		 * Exclude the data page of the user process.
>   		 */
>                  else if ((info->dump_level & DL_EXCLUDE_USER_DATA)
>                      && isAnon(mapping)) {
>                          if (clear_bit_on_2nd_bitmap_for_kernel(pfn))
>                                  pfn_user++;
> +
> +                       if (isPageHead(flags)) {
> +                               int i, nr_pages = 1 << compound_order;
> +
> +                               for (i = 1; i < nr_pages; ++i) {
> +                                       if (clear_bit_on_2nd_bitmap_for_kernel(pfn + i))
> +                                               pfn_user++;
> +                               }
> +                               pfn += nr_pages - 2;
> +                               mem_map += (nr_pages - 1) * SIZE(page);
> +                       }

This seems correct. We don't know when and where page table gets remapped by huge pages
transparently. If user-space and transparent huge pages are filtered separately, data
larger than size of huge table, 2MiB or 1GiB on x86, can be corrupted. Consider the case
that 2MiB + 4KiB data is allocated on 2MiB boundary and only the first 2MiB area is
remapped by THP. We should filter them together.

> +               }
> +               /*
> +                * Exclude the hugetlbfs pages.
> +                */
> +               else if ((info->dump_level & DL_EXCLUDE_HUGETLBFS_DATA)
> +                        && (!isAnon(mapping) && isPageHead(flags))) {
> +                       int i, nr_pages = 1 << compound_order;
> +
> +                       for (i = 0; i < nr_pages; ++i) {
> +                               if (clear_bit_on_2nd_bitmap_for_kernel(pfn + i))
> +                                       pfn_hugetlb++;
> +                       }
> +                       pfn += nr_pages - 1;
> +                       mem_map += (nr_pages - 1) * SIZE(page);
>                  }
>                  /*
>                   * Exclude the hwpoison page.
>

hugetlbfs has no such risk, so this seems basically OK to me.

Also, hugetlbfs pages are "user data". They should get filtered when user data dump level
is specified. So how about:

       Dump  |  zero   without  with     user    free   hugetlbfs
       Level |  page   private  private  data    page   page
      -------+-----------------------------------------------------
          0  |
          1  |   X
          2  |           X
          4  |           X        X
          8  |                            X              X
         16  |                                    X
         32  |                                           X
         63  |   X       X        X       X       X      X

On dump level 8, hugetlbfs pages also get filtered.

>
> But before that, I would like to hear the opinions about the new dump level
> to make sure that the level is worthy or not.
>



-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
