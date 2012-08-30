Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T6zJa-0008DE-Rd
 for kexec@lists.infradead.org; Thu, 30 Aug 2012 07:37:25 +0000
Date: Thu, 30 Aug 2012 15:29:28 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [RFC PATCH v2 0/10] makedumpfile: cyclic processing to keep
 memory consumption.
Message-Id: <20120830152928.8bd757d733bba5e3a5ce7082@mxc.nes.nec.co.jp>
In-Reply-To: <20120830.095506.265670820.d.hatayama@jp.fujitsu.com>
References: <20120815152710.982b745a50673defdf9aabd1@mxc.nes.nec.co.jp>
 <20120829.115031.346071170.d.hatayama@jp.fujitsu.com>
 <20120829123539.GA12504@redhat.com>
 <20120830.095506.265670820.d.hatayama@jp.fujitsu.com>
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
To: d.hatayama@jp.fujitsu.com
Cc: kexec@lists.infradead.org, vgoyal@redhat.com

Hello HATAYAMA-san,

On Thu, 30 Aug 2012 09:55:06 +0900 (JST)
HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

> From: Vivek Goyal <vgoyal@redhat.com>
> Subject: Re: [RFC PATCH v2 0/10] makedumpfile: cyclic processing to keep memory consumption.
> Date: Wed, 29 Aug 2012 08:35:39 -0400
> 
> > On Wed, Aug 29, 2012 at 11:50:31AM +0900, HATAYAMA Daisuke wrote:
> >> From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
> >> Subject: Re: [RFC PATCH v2 0/10] makedumpfile: cyclic processing to keep memory consumption.
> >> Date: Wed, 15 Aug 2012 15:27:10 +0900
> >> 
> >> > Hello HATAYAMA-san,
> >> > 
> >> > On Tue, 14 Aug 2012 20:55:32 +0900 (JST)
> >> > HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
> >> > 
> >> >> From: Vivek Goyal <vgoyal@redhat.com>
> >> >> Subject: Re: [RFC PATCH v2 0/10] makedumpfile: cyclic processing to keep memory consumption.
> >> >> Date: Fri, 10 Aug 2012 10:36:55 -0400
> >> >> 
> >> >> > On Fri, Aug 10, 2012 at 05:39:38PM +0900, HATAYAMA Daisuke wrote:
> >> >> > 
> >> >> > [..]
> >> >> >> 
> >> >> >> I finished benchmarking filtering time and demonstrate the result.
> >> >> >> But I failed to collect amount of memory consumption by my mistake. If
> >> >> >> they are necessary, I'll again try to collect them. But we have 9 days
> >> >> >> vacation starting tommorow, so I'll do that after the vacation.
> >> >> >> 
> >> > 
> >> > Thank you for your help.
> >> > Could you continue to measure amount of memory consumption ?
> >> > 
> >> 
> >> Hello Kumagai-san, here is the benchmark result for the amount of
> >> actual memory consumption when there are multiple child processes
> >> using --split option.

Thank you for all your help, I could make sure that cyclic mode is effective.

> > 
> > Hi,
> > 
> > Thanks for testing results. I had few questions.
> > 
> > - What's the objective of this testing? Are we just trying to figure out
> >   memory footprint of makedumpfile in cyclic mode using struct page 
> >   filtering and compare with free list filtering?
> > 
> 
> Basically yes, and in addition to that, I wanted to see when using
> --split because then makedumpfile process forks and memory usage
> increases.
> 
> > - Why are we testing using --split option. How does that help. In kdump
> >   kernel we boot only 1 cpu. And if all the dump files are being saved
> >   to same disk, it might not give lot of performance boost.
> >  
> >   Even if does give performance boost, this seems to be orthogonal to 
> >   the idea of going using struct page for filtering.  Will single thread
> >   dumping not give a good idea about memory footprint?
> > 
> 
> On this benchmark, I didn't aim at seeing performance gain here, only
> seeing memory footprint, so I used only one disk and one cpu to write
> without any special configuration.
> 
> In cyclic mode, each child process refers to different part of
> physical memory, and the bitmaps each process handles are also
> different each other; in normal mode, each child process shares the
> unique two bitmaps. This bench aims at evaluating amount of memory
> footprint for the former case precisely.
> 
> > 
> > - What's the conclusion of below measurements and numbers.
> > 
> 
> These are expected results, I think. Please forcus on buffer size and
> value of child's PRI. Each child process has two bitmaps and each
> bitmap has buffer size length. So, for 1MB buffer size, PRI finally
> amounts to 2.38 MB where 2.00 MB is the 2 bitmap part, and for other
> buffer sizes, these also hold similarly, and there rest of bitmaps
> part is all 0.37 or 0.38 MB.

Yes, I think so. According to the results, we can estimate memory footprint
with the buffer size even when using --split option. It's what I expected.


BTW, I'll post the patchset as v1.5.0-rc soon.


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
