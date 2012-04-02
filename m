Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SEc17-0005IP-B5
 for kexec@lists.infradead.org; Mon, 02 Apr 2012 07:49:35 +0000
Date: Mon, 2 Apr 2012 16:46:51 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: makedumpfile memory usage grows with system memory size
Message-Id: <20120402164651.6c2b1ae7.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20120330.095143.347147805.d.hatayama@jp.fujitsu.com>
References: <20120329170918.4223e816.oomichi@mxs.nes.nec.co.jp>
 <20120329.215646.28793982.d.hatayama@jp.fujitsu.com>
 <20120329132533.GM18218@redhat.com>
 <20120330.095143.347147805.d.hatayama@jp.fujitsu.com>
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
Cc: dzickus@redhat.com, oomichi@mxs.nes.nec.co.jp, kexec@lists.infradead.org

Hello Hatayama-san,

On Fri, 30 Mar 2012 09:51:43 +0900 (   )
HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
 
> For the processing of writing pages per range of memory, it's useful
> to reuse the code for --split's splitting features that split a single
> dumpfile into a multiple dumpfiles, which has prepared data strucutre
> to have start and end page frame numbers of the corresponding dumped
> memory. For example, see part below in write_kdump_pages().
> 
>         if (info->flag_split) {
>                 start_pfn = info->split_start_pfn;
>                 end_pfn   = info->split_end_pfn;
>         }
>         else {
>                 start_pfn = 0;
>                 end_pfn   = info->max_mapnr;
>         }
> 
>         for (pfn = start_pfn; pfn < end_pfn; pfn++) {
> 
> For the processing of creating and referencing bitmaps per range of
> memory, there's no functions that do that. The ones for a whole memory
> only: create_bitmap() and is_dumpable(). Also, creating bitmap depends
> on source dumpfile format. Trying with ELF to kdump-compressed format
> case first seems most handy; or if usecase is on the 2nd kernel only,
> this case is enough?)
> 
> For performance impact, I don't know that exactly. But I guess
> iterating filtering processing is most significant. I don't know exact
> data structure for each kind of memory, but if there's the ones
> needing linear order to look up the data for a given page frame
> number, there would be necessary to add some special handling not to
> reduce performance.

Thank you for your idea.

I think this is an important issue and I have no idea except iterating
filtering processes for each memory range.

But as you said, we should consider the issue related to performance.
For example, makedumpfile must parse free_list repeatedly to distinguish
whether each pfn is a free page or not, because each range may be inside
the same zone. It will be overhead.


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
