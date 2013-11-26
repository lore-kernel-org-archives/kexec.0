Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VlBXl-0000W7-TN
 for kexec@lists.infradead.org; Tue, 26 Nov 2013 05:50:42 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id C44E13EE0BB
 for <kexec@lists.infradead.org>; Tue, 26 Nov 2013 14:50:19 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id B392045DE52
 for <kexec@lists.infradead.org>; Tue, 26 Nov 2013 14:50:19 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.nic.fujitsu.com [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 9F26D45DE4E
 for <kexec@lists.infradead.org>; Tue, 26 Nov 2013 14:50:19 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 8B4111DB803B
 for <kexec@lists.infradead.org>; Tue, 26 Nov 2013 14:50:19 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 2FAFC1DB8032
 for <kexec@lists.infradead.org>; Tue, 26 Nov 2013 14:50:19 +0900 (JST)
Message-ID: <5294368A.8030804@jp.fujitsu.com>
Date: Tue, 26 Nov 2013 14:50:02 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2] makedumpfile: add parameters to update_cyclic_region
References: <20131125023150.GB13197@dhcp-16-252.nay.redhat.com>
 <5292D30E.5070003@jp.fujitsu.com>
 <20131126025221.GA22934@dhcp-16-252.nay.redhat.com>
In-Reply-To: <20131126025221.GA22934@dhcp-16-252.nay.redhat.com>
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

(2013/11/26 11:52), Baoquan He wrote:
> On 11/25/13 at 01:33pm, HATAYAMA Daisuke wrote:
>> (2013/11/25 11:31), Baoquan He wrote:
>>> Hi HATAYAMA and Atsushi,
>>>
>>> I think v2 is better than v1, since update_cyclic_region can be used
>>> with a more flexible calling.
>>>
>>> What's your opinion about this?
>>>
>>> On 11/23/13 at 05:29pm, Baoquan He wrote:
>>
>> Thanks for your patch. The bug is caused by my patch set for creating a
>> whole part of 1st bitmap before entering cyclic process.
>>
>> I think v1 is better than v2. The update_cyclic_range() call relevant
>> to this regression is somewhat special compared to other calls; it is
>> the almost only call that doesn't need to perform filtering processing.
>> To fix this bug, please make the patch so as not to affect the other calls,
>> in order to keep change as small as possible.
>
> OK, if you think so. But I still think update_cyclic_region is a little
> weird, its name doesn't match its functionality, this confuses code
> reviewers. And it does something unnecessary somewhere. If it's
> possible, I would rather take out the create_1st_bitmap_cyclic and
> exclude_unnecessary_pages_cyclic, and call them explicitly where they
> are really needed. Surely we can make a little change in both of them,
> E.g add a parameter pfn to them, then we can also judge like
> update_cyclic_region has done:
>
>          if (is_cyclic_region(pfn))
>                  return TRUE;
>
> If you insist on v1 is a better idea, I will repost based on it, but keep
> my personal opinion.
>

To be honest, I don't like current implementation of cyclic mode, too,
in particular part of update_cyclic_range() and is_cyclic_region() doing
much verbose processing.

I think update of cycle should appear topmost level only. For example,
current implementation in write_kdump_pages_and_bitmap_cyclic()is

         for (pfn = 0; pfn < info->max_mapnr; pfn++) {
                 if (is_cyclic_region(pfn))
                         continue;
                 if (!update_cyclic_region(pfn))
                         return FALSE;
                 if (!create_1st_bitmap_cyclic())
                         return FALSE;
                 if (!write_kdump_bitmap1_cyclic())
                         return FALSE;
         }

and the implementation like this needs dull sanity check in various
positions, for example, in:

int
set_bitmap_cyclic(char *bitmap, unsigned long long pfn, int val)
{
         int byte, bit;

         if (pfn < info->cyclic_start_pfn || info->cyclic_end_pfn <= pfn)
                 return FALSE;

This is due to the implementation above that doesn't satisfy the condition that
any pfn passed to inner function call always within the range of the current
cycle.

Instead, I think it better to change the implementation so the condition
that all the pfns passed to inner functions always within the range of
current cycle.

For example, I locally tried to introduce a kind of for_each_cycle()
statement. See the following. (please ignore details,
  please feel
the atmosphere from the above code.)

struct cycle {
   uint64_t start_pfn;
   uint64_t end_pfn;
};

#define for_each_cycle(C, MAX_MAPNR) \
   for (first_cycle((C), (MAX_MAPNR)); !end_cycle(C); \
        update_cycle(C))

for_each_cycle(&cycle, info->max_mapnr) {
   if (!create_1st_bitmap_cyclic(&cycle))
     return FALSE;
   if (!exclude_unnecessary_pages_cyclic(&cycle))
     return FALSE;
   if (!write_kdump_bitmap1_cyclic(&cycle))
     return FALSE;
}

where it's my preference that range of the current cycle is explicitly
passed to inner functions as a variable cycle.

Anyway, what I'd like to say is: is_cyclic_region(pfn) is unnecessary,
and the part of updating cycle should be done in a fixed one position
for code readability.

BTW, I could successfully clean up the code in this way in kdump-compressed code,
but I couldn't do that in the code from ELF to ELF... So I have yet to post
such clean up patch.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
