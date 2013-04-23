Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from relay3.sgi.com ([192.48.152.1] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UUbfQ-0006d7-9g
 for kexec@lists.infradead.org; Tue, 23 Apr 2013 11:45:49 +0000
Date: Tue, 23 Apr 2013 06:45:41 -0500
From: Cliff Wickman <cpw@sgi.com>
Subject: Re: /proc/vmcore kernel patches
Message-ID: <20130423114541.GA9203@sgi.com>
References: <E1UQGbu-0000on-Qi@eag09.americas.sgi.com>
 <20130412101056.a7371f1297e3057125c44521@mxc.nes.nec.co.jp>
 <20130422175504.GA26312@sgi.com> <5175D821.3060106@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5175D821.3060106@jp.fujitsu.com>
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
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>

On Tue, Apr 23, 2013 at 09:38:57AM +0900, HATAYAMA Daisuke wrote:
> (2013/04/23 2:55), Cliff Wickman wrote:
>> Hello Mr. Atayama and Mr. Kumagai,
>>
>> I have been playing with the v4 patches
>>       kdump, vmcore: support mmap() on /proc/vmcore
>> and find the mmap interface to /proc/vmcore potentially about 80x faster than
>> the read interface.
>>
>> But in practice (using a makedumpfile that mmap's instead of read's) I find
>> it about 10x slower.
>>
>> It looks like makedumpfile's usage of the interface is very inefficient.
>> It will mmap an area, read a page, then back up the offset to a previous
>> page.  It has to munmap and mmap on virtually every read.
>
> You can change size of mapping memory through command-line option  
> --map-size <some KB>.
>
> The version of makedumpfile is experimental. The design should be  
> changed if it turns out to be problematic.

Yes I'm using --map-size <some KB> but the bigger I make the mapping
size the worse makedumpfile performs. The typical pattern is to map and
read page x, then map and read page x - 1.  So every read has to unmap
and remap.  The bigger the mapping, the slower it goes.

>> Do you have a re-worked makedumpfile that predicts a large range of
>> pages and mmap's the whole range just once?
>> It seems that makedumpfile should have the information available to do
>> that.
>>
>
> The benchmark result has already shown that under large enough map size,  
> the current implementation performs as well as other kernel-space  
> implementation that maps a whole range of memory.

I must be missing some part of that benchmark.  I see that the interface
is much faster, but my benchmarks of makedumpfile itself are much slower
when using mmap.
Can you point me to the makedumpfile source that you are using?

> In addition, the current implementation of remap_pfn_range uses 4KB  
> pages only. This means that total size of PTEs amounts to 2GB per 1TB.  
> It's better to map pages little by little for small memory programming.

Agreed, we need a way to map with 2M pages.  And I am not suggesting that
you map all of the old kernel memory at once.  Just one region of page
structures at a time.

-Cliff
-- 
Cliff Wickman
SGI
cpw@sgi.com
(651) 683-3824

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
