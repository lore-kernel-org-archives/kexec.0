Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VmEh0-00070d-OS
 for kexec@lists.infradead.org; Fri, 29 Nov 2013 03:24:36 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 8A3403EE164
 for <kexec@lists.infradead.org>; Fri, 29 Nov 2013 12:24:08 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 733C245DE5C
 for <kexec@lists.infradead.org>; Fri, 29 Nov 2013 12:24:08 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.nic.fujitsu.com [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 4F86645DE55
 for <kexec@lists.infradead.org>; Fri, 29 Nov 2013 12:24:08 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 2A864E18011
 for <kexec@lists.infradead.org>; Fri, 29 Nov 2013 12:24:08 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id CF8671DB8043
 for <kexec@lists.infradead.org>; Fri, 29 Nov 2013 12:24:07 +0900 (JST)
Message-ID: <5298084B.7060603@jp.fujitsu.com>
Date: Fri, 29 Nov 2013 12:21:47 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] makedumpfile: hugepage filtering for vmcore dump
References: <0910DD04CBD6DE4193FCF86B9C00BE971C855E@BPXM01GP.gisp.nec.co.jp>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE971C855E@BPXM01GP.gisp.nec.co.jp>
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
Cc: "bhe@redhat.com" <bhe@redhat.com>, "tom.vaden@hp.com" <tom.vaden@hp.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "ptesarik@suse.cz" <ptesarik@suse.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lisa.mitchell@hp.com" <lisa.mitchell@hp.com>, "vgoyal@redhat.com" <vgoyal@redhat.com>, "anderson@redhat.com" <anderson@redhat.com>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "jingbai.ma@hp.com" <jingbai.ma@hp.com>

(2013/11/29 12:02), Atsushi Kumagai wrote:
> On 2013/11/28 16:50:21, kexec <kexec-bounces@lists.infradead.org> wrote:
>>>> ping, in case you overlooked this...
>>>
>>> Sorry for the delayed response, I prioritize the release of v1.5.5 now.
>>>
>>> Thanks for your advice, check_cyclic_buffer_overrun() should be fixed
>>> as you said. In addition, I'm considering other way to address such case,
>>> that is to bring the number of "overflowed pages" to the next cycle and
>>> exclude them at the top of __exclude_unnecessary_pages() like below:
>>>
>>>                  /*
>>>                   * The pages which should be excluded still remain.
>>>                   */
>>>                  if (remainder >= 1) {
>>>                          int i;
>>>                          unsigned long tmp;
>>>                          for (i = 0; i < remainder; ++i) {
>>>                                  if (clear_bit_on_2nd_bitmap_for_kernel(pfn + i)) {
>>>                                          pfn_user++;
>>>                                          tmp++;
>>>                                  }
>>>                          }
>>>                          pfn += tmp;
>>>                          remainder -= tmp;
>>>                          mem_map += (tmp - 1) * SIZE(page);
>>>                          continue;
>>>                  }
>>>
>>> If this way works well, then aligning info->buf_size_cyclic will be
>>> unnecessary.
>>>
>>
>> I selected the current implementation of changing cyclic buffer size becuase
>> I thought it was simpler than carrying over remaining filtered pages to next cycle
>> in that there was no need to add extra code in filtering processing.
>>
>> I guess the reason why you think this is better now is how to detect maximum order of
>> huge page is hard in some way, right?
> 
> The maximum order will be gotten from HUGETLB_PAGE_ORDER or HPAGE_PMD_ORDER,
> so I don't say it's hard. However, the carrying over method doesn't depend on
> such kernel symbols, so I think it's robuster.
> 

Then, it's better to remove check_cyclic_buffer_overrun() and rewrite part of free page
filtering in __exclude_unnecessary_pages(). Could you do that too?

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
