Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1T6hUs-0003wB-Jr
 for kexec@lists.infradead.org; Wed, 29 Aug 2012 12:35:52 +0000
Date: Wed, 29 Aug 2012 08:35:39 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC PATCH v2 0/10] makedumpfile: cyclic processing to keep
 memory consumption.
Message-ID: <20120829123539.GA12504@redhat.com>
References: <20120810143655.GA5416@redhat.com>
 <20120814.205532.509440957.d.hatayama@jp.fujitsu.com>
 <20120815152710.982b745a50673defdf9aabd1@mxc.nes.nec.co.jp>
 <20120829.115031.346071170.d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120829.115031.346071170.d.hatayama@jp.fujitsu.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, kumagai-atsushi@mxc.nes.nec.co.jp

On Wed, Aug 29, 2012 at 11:50:31AM +0900, HATAYAMA Daisuke wrote:
> From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
> Subject: Re: [RFC PATCH v2 0/10] makedumpfile: cyclic processing to keep memory consumption.
> Date: Wed, 15 Aug 2012 15:27:10 +0900
> 
> > Hello HATAYAMA-san,
> > 
> > On Tue, 14 Aug 2012 20:55:32 +0900 (JST)
> > HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
> > 
> >> From: Vivek Goyal <vgoyal@redhat.com>
> >> Subject: Re: [RFC PATCH v2 0/10] makedumpfile: cyclic processing to keep memory consumption.
> >> Date: Fri, 10 Aug 2012 10:36:55 -0400
> >> 
> >> > On Fri, Aug 10, 2012 at 05:39:38PM +0900, HATAYAMA Daisuke wrote:
> >> > 
> >> > [..]
> >> >> 
> >> >> I finished benchmarking filtering time and demonstrate the result.
> >> >> But I failed to collect amount of memory consumption by my mistake. If
> >> >> they are necessary, I'll again try to collect them. But we have 9 days
> >> >> vacation starting tommorow, so I'll do that after the vacation.
> >> >> 
> > 
> > Thank you for your help.
> > Could you continue to measure amount of memory consumption ?
> > 
> 
> Hello Kumagai-san, here is the benchmark result for the amount of
> actual memory consumption when there are multiple child processes
> using --split option.
> 

Hi,

Thanks for testing results. I had few questions.

- What's the objective of this testing? Are we just trying to figure out
  memory footprint of makedumpfile in cyclic mode using struct page 
  filtering and compare with free list filtering?

- Why are we testing using --split option. How does that help. In kdump
  kernel we boot only 1 cpu. And if all the dump files are being saved
  to same disk, it might not give lot of performance boost.
 
  Even if does give performance boost, this seems to be orthogonal to 
  the idea of going using struct page for filtering.  Will single thread
  dumping not give a good idea about memory footprint?


- What's the conclusion of below measurements and numbers.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
