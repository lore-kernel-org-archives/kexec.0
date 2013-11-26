Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VlDXW-0003On-Dq
 for kexec@lists.infradead.org; Tue, 26 Nov 2013 07:58:35 +0000
Date: Tue, 26 Nov 2013 15:57:42 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2] makedumpfile: add parameters to update_cyclic_region
Message-ID: <20131126075742.GB22934@dhcp-16-252.nay.redhat.com>
References: <20131125023150.GB13197@dhcp-16-252.nay.redhat.com>
 <5292D30E.5070003@jp.fujitsu.com>
 <20131126025221.GA22934@dhcp-16-252.nay.redhat.com>
 <5294368A.8030804@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5294368A.8030804@jp.fujitsu.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, kumagai-atsushi@mxc.nes.nec.co.jp, chaowang@redhat.com

On 11/26/13 at 02:50pm, HATAYAMA Daisuke wrote:
> (2013/11/26 11:52), Baoquan He wrote:
> >On 11/25/13 at 01:33pm, HATAYAMA Daisuke wrote:
> >>(2013/11/25 11:31), Baoquan He wrote:

> 
> To be honest, I don't like current implementation of cyclic mode, too,
> in particular part of update_cyclic_range() and is_cyclic_region() doing
> much verbose processing.
> 
> I think update of cycle should appear topmost level only. For example,
> current implementation in write_kdump_pages_and_bitmap_cyclic()is
> 
>         for (pfn = 0; pfn < info->max_mapnr; pfn++) {
>                 if (is_cyclic_region(pfn))
>                         continue;
>                 if (!update_cyclic_region(pfn))
>                         return FALSE;
>                 if (!create_1st_bitmap_cyclic())
>                         return FALSE;
>                 if (!write_kdump_bitmap1_cyclic())
>                         return FALSE;
>         }
> 
> and the implementation like this needs dull sanity check in various
> positions, for example, in:
> 
> int
> set_bitmap_cyclic(char *bitmap, unsigned long long pfn, int val)
> {
>         int byte, bit;
> 
>         if (pfn < info->cyclic_start_pfn || info->cyclic_end_pfn <= pfn)
>                 return FALSE;
> 
> This is due to the implementation above that doesn't satisfy the condition that
> any pfn passed to inner function call always within the range of the current
> cycle.
> 
> Instead, I think it better to change the implementation so the condition
> that all the pfns passed to inner functions always within the range of
> current cycle.
> 
> For example, I locally tried to introduce a kind of for_each_cycle()
> statement. See the following. (please ignore details,
>  please feel
> the atmosphere from the above code.)
> 
> struct cycle {
>   uint64_t start_pfn;
>   uint64_t end_pfn;
> };
> 
> #define for_each_cycle(C, MAX_MAPNR) \
>   for (first_cycle((C), (MAX_MAPNR)); !end_cycle(C); \
>        update_cycle(C))
> 
> for_each_cycle(&cycle, info->max_mapnr) {
>   if (!create_1st_bitmap_cyclic(&cycle))
>     return FALSE;
>   if (!exclude_unnecessary_pages_cyclic(&cycle))
>     return FALSE;
>   if (!write_kdump_bitmap1_cyclic(&cycle))
>     return FALSE;
> }
> 
> where it's my preference that range of the current cycle is explicitly
> passed to inner functions as a variable cycle.
> 
> Anyway, what I'd like to say is: is_cyclic_region(pfn) is unnecessary,
> and the part of updating cycle should be done in a fixed one position
> for code readability.
> 
> BTW, I could successfully clean up the code in this way in kdump-compressed code,
> but I couldn't do that in the code from ELF to ELF... So I have yet to post
> such clean up patch.

This is cool, cleanup like this would make code clearer. Let's wait your
clean up patch, I can help review and test.


> 
> -- 
> Thanks.
> HATAYAMA, Daisuke
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
