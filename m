Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TveTB-000590-1P
 for kexec@lists.infradead.org; Thu, 17 Jan 2013 01:40:43 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 33C283EE0BC
 for <kexec@lists.infradead.org>; Thu, 17 Jan 2013 10:40:38 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 1D3AB45DE4E
 for <kexec@lists.infradead.org>; Thu, 17 Jan 2013 10:40:38 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id EA5C245DD78
 for <kexec@lists.infradead.org>; Thu, 17 Jan 2013 10:40:37 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id C8AF01DB802C
 for <kexec@lists.infradead.org>; Thu, 17 Jan 2013 10:40:37 +0900 (JST)
Received: from m023.s.css.fujitsu.com (m023.s.css.fujitsu.com [10.0.81.63])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 774421DB803A
 for <kexec@lists.infradead.org>; Thu, 17 Jan 2013 10:40:37 +0900 (JST)
Date: Thu, 17 Jan 2013 10:38:13 +0900 (JST)
Message-Id: <20130117.103813.295979615.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH v2] makedumpfile: request the kernel do page scans
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20130111223034.GA2154@sgi.com>
References: <20130107133935.GA1207@sgi.com>
 <20130110.000954.305449175.d.hatayama@jp.fujitsu.com>
 <20130111223034.GA2154@sgi.com>
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
To: cpw@sgi.com
Cc: kexec@lists.infradead.org

From: Cliff Wickman <cpw@sgi.com>
Subject: Re: [PATCH v2] makedumpfile: request the kernel do page scans
Date: Fri, 11 Jan 2013 16:30:34 -0600

> Hi Hatayama,
> 

Hello Cliff,

Sorry, I failed to reply this to you. I have not noticed error mail
returned back to from system...

First, today I sent the RFC patch set focussing on mapping vmcore
regions in direct mapping region. Please see it. I signed off the 2nd
patch with your signature because I reused your code constructing page
tables.

> On Thu, Jan 10, 2013 at 12:09:54AM +0900, HATAYAMA Daisuke wrote:
>> From: Cliff Wickman <cpw@sgi.com>
>> Subject: Re: [PATCH v2] makedumpfile: request the kernel do page scans
>> Date: Mon, 7 Jan 2013 07:39:35 -0600
>> 
>> > An update on testing thise patches:
>> > 
>> >> This version of the patch improves the consolidation of the mem_map table
>> >> that is passed to the kernel.  See make_kernel_mmap().
>> >> Particularly the seemingly duplicate pfn ranges generated on an older
>> >> (2.6.32-based, rhel6) kernel.
>> > 
>> > 
>> > On a 2TB machine (idle) machine:
>> >   the crash kernel ran successfully in 512M
>> >   the scan for unnecessary pages takes about 40 seconds
>> >   it was a single scan, not cyclic
>> >   
>> > On a 16TB machine (idle) machine:
>> >   the crash kernel ran successfully in 512M
>> >   there is a pause of about 4 minutes during makedumpfile initialization
>> >   the scan for unnecessary pages takes about 4.8 minutes
>> >   it was a single scan, not cyclic
>> > 
>> 
>> I wonder why this didn't result in OOM on 16TB. Was that really done
>> in non-cyclic mode? Could you show me a log of makedumpfile? You can
>> create it by passing --message-level 31.
> 
> The test was done in non-cyclic mode.
> 
> But I had changed the kernel patch to do a direct mapping of the page
> structures, rather than using ioremap.

Then, I still wonder why this didn't result in OOM. This OOM is not
caused by memory consumption of page table, by two bitmaps of
makedumpfile that grows in proportion to memory size. On 2TB, there
are 64MB two bitmaps and on 16TB, there are 512MB two bitmaps.

> I'll attach the kernel patch and the makedumpfile patch, if you would
> like to test them.
> (2 kernel patches, one for 2.6.32-based and one for 3.0.13-based)

As I said some times previously, I have already tried your patch set
on local machine. See the url below, where I attached result profiling
your patch set with perf record.

http://lists.infradead.org/pipermail/kexec/2012-December/007500.html

> I'm also experimenting with the same interface to copy pages back to
> makedumpfile without using /proc/vmcore.  There is some improvement
> there.  I just now dumped a 2TB idle system (it wrote a 3.6GB dump
> file).

So, I have already understood your patch is effective for this issue
but I have continued to say that this is mainly caused by calling
ioremap too many times. IOW, I guess the performance improvement you
saw is mostly by remapping a whole memory by ioremap at the same time.

> The copy phase took 7:12 with the direct copy, 8:35 using /proc/vmcore.
> I'll attach that patch too.

Please show us more detailed results. I don't know how you did this
benchmark and how I should evaluate this.

I also think that makedumpfile also does IO. Improvement of a few
minutes seems a small impact, not enough for porting filtering into
kernel-space.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
