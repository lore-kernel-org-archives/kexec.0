Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VlEMj-00058E-Kd
 for kexec@lists.infradead.org; Tue, 26 Nov 2013 08:51:30 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 1A9003EE113
 for <kexec@lists.infradead.org>; Tue, 26 Nov 2013 17:51:03 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 0A6A845DE55
 for <kexec@lists.infradead.org>; Tue, 26 Nov 2013 17:51:03 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.nic.fujitsu.com [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id E716645DE54
 for <kexec@lists.infradead.org>; Tue, 26 Nov 2013 17:51:02 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id D80D61DB8048
 for <kexec@lists.infradead.org>; Tue, 26 Nov 2013 17:51:02 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 7D7FD1DB803F
 for <kexec@lists.infradead.org>; Tue, 26 Nov 2013 17:51:02 +0900 (JST)
Message-ID: <529460EA.2080006@jp.fujitsu.com>
Date: Tue, 26 Nov 2013 17:50:50 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2] makedumpfile: add parameters to update_cyclic_region
References: <20131125023150.GB13197@dhcp-16-252.nay.redhat.com>
 <5292D30E.5070003@jp.fujitsu.com>
 <20131126025221.GA22934@dhcp-16-252.nay.redhat.com>
 <5294368A.8030804@jp.fujitsu.com>
 <20131126075742.GB22934@dhcp-16-252.nay.redhat.com>
In-Reply-To: <20131126075742.GB22934@dhcp-16-252.nay.redhat.com>
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
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, kumagai-atsushi@mxc.nes.nec.co.jp, chaowang@redhat.com

(2013/11/26 16:57), Baoquan He wrote:
> On 11/26/13 at 02:50pm, HATAYAMA Daisuke wrote:
>> (2013/11/26 11:52), Baoquan He wrote:
>>> On 11/25/13 at 01:33pm, HATAYAMA Daisuke wrote:
>>>> (2013/11/25 11:31), Baoquan He wrote:
>
>>
>> To be honest, I don't like current implementation of cyclic mode, too,
>> in particular part of update_cyclic_range() and is_cyclic_region() doing
>> much verbose processing.
>>
>> I think update of cycle should appear topmost level only. For example,
>> current implementation in write_kdump_pages_and_bitmap_cyclic()is
>>
>>          for (pfn = 0; pfn < info->max_mapnr; pfn++) {
>>                  if (is_cyclic_region(pfn))
>>                          continue;
>>                  if (!update_cyclic_region(pfn))
>>                          return FALSE;
>>                  if (!create_1st_bitmap_cyclic())
>>                          return FALSE;
>>                  if (!write_kdump_bitmap1_cyclic())
>>                          return FALSE;
>>          }
>>
>> and the implementation like this needs dull sanity check in various
>> positions, for example, in:
>>
>> int
>> set_bitmap_cyclic(char *bitmap, unsigned long long pfn, int val)
>> {
>>          int byte, bit;
>>
>>          if (pfn < info->cyclic_start_pfn || info->cyclic_end_pfn <= pfn)
>>                  return FALSE;
>>
>> This is due to the implementation above that doesn't satisfy the condition that
>> any pfn passed to inner function call always within the range of the current
>> cycle.
>>
>> Instead, I think it better to change the implementation so the condition
>> that all the pfns passed to inner functions always within the range of
>> current cycle.
>>
>> For example, I locally tried to introduce a kind of for_each_cycle()
>> statement. See the following. (please ignore details,
>>   please feel
>> the atmosphere from the above code.)
>>
>> struct cycle {
>>    uint64_t start_pfn;
>>    uint64_t end_pfn;
>> };
>>
>> #define for_each_cycle(C, MAX_MAPNR) \
>>    for (first_cycle((C), (MAX_MAPNR)); !end_cycle(C); \
>>         update_cycle(C))
>>
>> for_each_cycle(&cycle, info->max_mapnr) {
>>    if (!create_1st_bitmap_cyclic(&cycle))
>>      return FALSE;
>>    if (!exclude_unnecessary_pages_cyclic(&cycle))
>>      return FALSE;
>>    if (!write_kdump_bitmap1_cyclic(&cycle))
>>      return FALSE;
>> }
>>
>> where it's my preference that range of the current cycle is explicitly
>> passed to inner functions as a variable cycle.
>>
>> Anyway, what I'd like to say is: is_cyclic_region(pfn) is unnecessary,
>> and the part of updating cycle should be done in a fixed one position
>> for code readability.
>>
>> BTW, I could successfully clean up the code in this way in kdump-compressed code,
>> but I couldn't do that in the code from ELF to ELF... So I have yet to post
>> such clean up patch.
>
> This is cool, cleanup like this would make code clearer. Let's wait your
> clean up patch, I can help review and test.
>

For that, you need to pass a part with the currnet cycle to __exclude_unnecessary_pages(),
not a whole (mmd->pfn_start, mmd->pfn_end). There might be similar part that needs fix,
but sorry I don't have good memory...

int
exclude_unnecessary_pages_cyclic(void)
{
<cut>
                         if (mmd->pfn_end >= info->cyclic_start_pfn &&
                             mmd->pfn_start <= info->cyclic_end_pfn) {
                                 if (!__exclude_unnecessary_pages(mmd->mem_map,
                                                                  mmd->pfn_start, mmd->pfn_end))
                                         return FALSE;
                         }

For ELF-to-ELF code, unfortunately, I gave up in the middle of source code reading.
At lesst, if I remember correctly, I think the code relied on the current
update_mmap_range() implementation. It might be hard to clean up there in a natural way.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
