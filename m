Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SDQ4T-0006Xc-B5
 for kexec@lists.infradead.org; Fri, 30 Mar 2012 00:52:07 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 4C9D93EE0BB
 for <kexec@lists.infradead.org>; Fri, 30 Mar 2012 09:52:00 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id B97832AEA86
 for <kexec@lists.infradead.org>; Fri, 30 Mar 2012 09:51:58 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 97A5D1EF083
 for <kexec@lists.infradead.org>; Fri, 30 Mar 2012 09:51:58 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 8A93DE08001
 for <kexec@lists.infradead.org>; Fri, 30 Mar 2012 09:51:58 +0900 (JST)
Received: from ml13.s.css.fujitsu.com (ml13.s.css.fujitsu.com [10.240.81.133])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 35399E08004
 for <kexec@lists.infradead.org>; Fri, 30 Mar 2012 09:51:58 +0900 (JST)
Date: Fri, 30 Mar 2012 09:51:43 +0900 (   )
Message-Id: <20120330.095143.347147805.d.hatayama@jp.fujitsu.com>
Subject: Re: makedumpfile memory usage grows with system memory size
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20120329132533.GM18218@redhat.com>
References: <20120329170918.4223e816.oomichi@mxs.nes.nec.co.jp>
 <20120329.215646.28793982.d.hatayama@jp.fujitsu.com>
 <20120329132533.GM18218@redhat.com>
Mime-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: dzickus@redhat.com
Cc: oomichi@mxs.nes.nec.co.jp, kexec@lists.infradead.org

From: Don Zickus <dzickus@redhat.com>
Subject: Re: makedumpfile memory usage grows with system memory size
Date: Thu, 29 Mar 2012 09:25:33 -0400

> On Thu, Mar 29, 2012 at 09:56:46PM +0900, HATAYAMA Daisuke wrote:

>> From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
>> Subject: Re: makedumpfile memory usage grows with system memory size
>> Date: Thu, 29 Mar 2012 17:09:18 +0900

>> > On Wed, 28 Mar 2012 17:22:04 -0400
>> > Don Zickus <dzickus@redhat.com> wrote:

>> >> I was curious if that was true and if it was, would it be possible to only
>> >> process memory in chunks instead of all at once.
>> >> 
>> >> The idea is that a machine with 4Gigs of memory should consume the same
>> >> the amount of kdump runtime memory as a 1TB memory system.
>> >> 
>> >> Just trying to research ways to keep the memory requirements consistent
>> >> across all memory ranges.

>> I think this is possible in constant memory space by creating bitmaps
>> and writing pages in a certain amount of memory. That is, if choosing
>> 4GB, do [0, 4GB) space processing, [4GB, 8GB) space processing, [8GB,
>> 12GB) ... in order. The key is to restrict the target memory range of
>> filtering.

> Yes, that was what I was thinking.  I am glad to hear that is possible.
> Is there some place in the code that I can help try out that idea?  I
> would also be curious if there is a 'time' impact on how long it takes to
> process this (for example, would it add a couple of milliseconds overhead
> or seconds overhead).

The part related is the path in create_dumpfile():

        if (!create_dump_bitmap())
                return FALSE;

        if (info->flag_split) {
                if ((status = writeout_multiple_dumpfiles()) == FALSE)
                        return FALSE;
        } else {
                if ((status = writeout_dumpfile()) == FALSE)
                        return FALSE;
        }

Now this part tries to do the task for a whole memory. So first this
needs to be generalized so that it does processing per range of
memory. If doing the processing three cycles, it would be as follows
pictorically in kdump-compressed format.
                                                
    +------------------------------------------+
    |    main header (struct disk_dump_header) |
    |------------------------------------------+
    |    sub header (struct kdump_sub_header)  |
    |------------------------------------------+
    |                                          | <-- 1st cycle
      -  -  -  -  -  -  -  -  -  -  -  -  -  -
    |            1st-bitmap                    | <-- 2nd cycle
      -  -  -  -  -  -  -  -  -  -  -  -  -  -
    |                                          | <-- 3rd cycle
    |------------------------------------------+
    |                                          | <-- 1st cycle
      -  -  -  -  -  -  -  -  -  -  -  -  -  -
    |            2nd-bitmap                    | <-- 2nd cycle
      -  -  -  -  -  -  -  -  -  -  -  -  -  -
    |                                          | <-- 3rd cycle
    |------------------------------------------+
    |                                          | <-- 1st cycle
      -  -  -  -  -  -  -  -  -  -  -  -  -  -
    |            page header                   | <-- 2nd cycle
      -  -  -  -  -  -  -  -  -  -  -  -  -  -
    |                                          | <-- 3rd cycle
    |------------------------------------------|
    |                                          |
    |            page data                     | <-- 1st cycle
    |                                          |
      -  -  -  -  -  -  -  -  -  -  -  -  -  -
    |            page data                     | <-- 2nd cycle
      -  -  -  -  -  -  -  -  -  -  -  -  -  -
    |                                          |
    |                                          |
    |            page data                     | <-- 3rd cycle
    |                                          |
    |                                          |
    +------------------------------------------+

where the portions except for page data are in fixed length; so I
wrote only page data differently.

For the processing of writing pages per range of memory, it's useful
to reuse the code for --split's splitting features that split a single
dumpfile into a multiple dumpfiles, which has prepared data strucutre
to have start and end page frame numbers of the corresponding dumped
memory. For example, see part below in write_kdump_pages().

        if (info->flag_split) {
                start_pfn = info->split_start_pfn;
                end_pfn   = info->split_end_pfn;
        }
        else {
                start_pfn = 0;
                end_pfn   = info->max_mapnr;
        }

        for (pfn = start_pfn; pfn < end_pfn; pfn++) {

For the processing of creating and referencing bitmaps per range of
memory, there's no functions that do that. The ones for a whole memory
only: create_bitmap() and is_dumpable(). Also, creating bitmap depends
on source dumpfile format. Trying with ELF to kdump-compressed format
case first seems most handy; or if usecase is on the 2nd kernel only,
this case is enough?)

For performance impact, I don't know that exactly. But I guess
iterating filtering processing is most significant. I don't know exact
data structure for each kind of memory, but if there's the ones
needing linear order to look up the data for a given page frame
number, there would be necessary to add some special handling not to
reduce performance.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
