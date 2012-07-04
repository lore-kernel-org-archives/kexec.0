Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SmIbG-0002ZV-QL
 for kexec@lists.infradead.org; Wed, 04 Jul 2012 05:58:10 +0000
Date: Wed, 4 Jul 2012 14:54:06 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [RFC PATCH v2 0/10] makedumpfile: cyclic processing to keep
 memory consumption.
Message-Id: <20120704145406.bf22a34cec586e3c1e8e29b5@mxc.nes.nec.co.jp>
In-Reply-To: <20120702123905.GG24929@redhat.com>
References: <20120629111320.694ec85b.kumagai-atsushi@mxc.nes.nec.co.jp>
 <20120702123905.GG24929@redhat.com>
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
To: vgoyal@redhat.com
Cc: kexec@lists.infradead.org

Hello Vivek,

On Mon, 2 Jul 2012 08:39:05 -0400
Vivek Goyal <vgoyal@redhat.com> wrote:

> On Fri, Jun 29, 2012 at 11:13:20AM +0900, Atsushi Kumagai wrote:
> > Hello,
> > 
> > I improved prototype of cyclic processing as version 2.
> > If there is no objection to basic idea, I want to consider the things
> > related to performance as next step. (Concretely, buffer size and the patch set
> > HATAYAMA-san sent a short time ago.) 
> > 
> 
> Hi Atushi san,
> 
> Good to see this work making progress. I have few queries.
> 
> - Do you have some numbers for bigger machines like 1TB or higher memory. 
>   I am curious to know how bad is the time penalty.

I'm afraid that I don't have such a large machine, so I need someone who can
measure execution time in large machine.

> - Will this work with option -F (flattned format). Often people save
>   filtered dump over ssh and we need to make sure it does work with -F
>   option too.

Yes, the cyclic processing supports flattened format too.

> > > Version 1:
> >  
> >   http://lists.infradead.org/pipermail/kexec/2012-May/006363.html
> 
> - I have few queries about the diagram in the link above.
> 
> - What is 1st cycle, 2nd cycle and 3rd cycle. Are we cycling thorough
>   all the pages 3 times for everything?

First, "3 times" is only for example. Practically, the number of cycle is 
determined based on system memory size and BUFSIZE_CYCLIC:
  
  number of cycle = memory size / page size(4k) / bit per byte(8) / BUFSIZE_CYCLIC

The beginning, the cause of the issue we discussed is to save the analytical 
data(called bitmap) for whole memory at a time. The bitmap size increases 
linearly based on system memory size, this issue will be clearly in large system.

Therefore, we considered cyclic processing to work in constant memory space. 
In cyclic processing mode, makedumpfile reads a constant region of memory,
analyzes it, and writes pages to dumpfile repeatedly from start of memory to the end. 
We called the processing for a constant region "one cycle".
Each cycle creates the partial bitmap only for a constant region, so bitmap size
will be kept constantly regardless of system memory size.

> - What is 1st bitmap and 2nd bitmap and page_header? And why 3 cycles for
>   each.
> 
> - And why 3 cycles for page_data.

The kdump compressed format was described by Ohmichi-san, please see below.
  
  http://www.redhat.com/archives/crash-utility/2008-August/msg00001.html

1st bitmap, 2nd bitmap, page_header and page_data correspond to each constant region,
so it is necessary to write them at the same cycle.


Thanks
Atsushi Kumagai

> Thanks
> Vivek
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
