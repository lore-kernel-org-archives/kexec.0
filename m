Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UUnOt-00069E-5b
 for kexec@lists.infradead.org; Wed, 24 Apr 2013 00:17:32 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 87C0B3EE081
 for <kexec@lists.infradead.org>; Wed, 24 Apr 2013 09:17:24 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 7A2CF45DE59
 for <kexec@lists.infradead.org>; Wed, 24 Apr 2013 09:17:24 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 5A4FC45DE56
 for <kexec@lists.infradead.org>; Wed, 24 Apr 2013 09:17:24 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 4E72C1DB804E
 for <kexec@lists.infradead.org>; Wed, 24 Apr 2013 09:17:24 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id E82F91DB803A
 for <kexec@lists.infradead.org>; Wed, 24 Apr 2013 09:17:23 +0900 (JST)
Message-ID: <5177247C.1010501@jp.fujitsu.com>
Date: Wed, 24 Apr 2013 09:17:00 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: /proc/vmcore kernel patches
References: <E1UQGbu-0000on-Qi@eag09.americas.sgi.com>
 <20130412101056.a7371f1297e3057125c44521@mxc.nes.nec.co.jp>
 <20130422175504.GA26312@sgi.com> <5175D821.3060106@jp.fujitsu.com>
 <20130423114541.GA9203@sgi.com>
In-Reply-To: <20130423114541.GA9203@sgi.com>
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
To: Cliff Wickman <cpw@sgi.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>

(2013/04/23 20:45), Cliff Wickman wrote:
> On Tue, Apr 23, 2013 at 09:38:57AM +0900, HATAYAMA Daisuke wrote:
>> (2013/04/23 2:55), Cliff Wickman wrote:
>>> Hello Mr. Atayama and Mr. Kumagai,
>>>
>>> I have been playing with the v4 patches
>>>        kdump, vmcore: support mmap() on /proc/vmcore
>>> and find the mmap interface to /proc/vmcore potentially about 80x faster than
>>> the read interface.
>>>
>>> But in practice (using a makedumpfile that mmap's instead of read's) I find
>>> it about 10x slower.
>>>
>>> It looks like makedumpfile's usage of the interface is very inefficient.
>>> It will mmap an area, read a page, then back up the offset to a previous
>>> page.  It has to munmap and mmap on virtually every read.
>>
>> You can change size of mapping memory through command-line option
>> --map-size <some KB>.
>>
>> The version of makedumpfile is experimental. The design should be
>> changed if it turns out to be problematic.
>
> Yes I'm using --map-size <some KB> but the bigger I make the mapping
> size the worse makedumpfile performs. The typical pattern is to map and
> read page x, then map and read page x - 1.  So every read has to unmap
> and remap.  The bigger the mapping, the slower it goes.
>
>>> Do you have a re-worked makedumpfile that predicts a large range of
>>> pages and mmap's the whole range just once?
>>> It seems that makedumpfile should have the information available to do
>>> that.
>>>
>>
>> The benchmark result has already shown that under large enough map size,
>> the current implementation performs as well as other kernel-space
>> implementation that maps a whole range of memory.
>
> I must be missing some part of that benchmark.  I see that the interface
> is much faster, but my benchmarks of makedumpfile itself are much slower
> when using mmap.
> Can you point me to the makedumpfile source that you are using?
>

I used mmap branch at

git://git.code.sf.net/p/makedumpfile/code

with the following patch applied:

===
diff --git a/makedumpfile.c b/makedumpfile.c
index 7acbf72..9dc6aee 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -290,8 +290,10 @@ read_with_mmap(off_t offset, void *bufptr, unsigned 
long size) {

  next_region:

-       if (!is_mapped_with_mmap(offset))
-               update_mmap_range(offset);
+       if (!is_mapped_with_mmap(offset)) {
+               if (!update_mmap_range(offset))
+                       return FALSE;
+       }

         read_size = MIN(info->mmap_end_offset - offset, size);
===

>> In addition, the current implementation of remap_pfn_range uses 4KB
>> pages only. This means that total size of PTEs amounts to 2GB per 1TB.
>> It's better to map pages little by little for small memory programming.
>
> Agreed, we need a way to map with 2M pages.  And I am not suggesting that
> you map all of the old kernel memory at once.  Just one region of page
> structures at a time.

Ideally so, but the benchmark showed good performance even in the 
current impelementation, so I'm now thinking that modifying 
remap_pfn_range is not definitely necessary.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
