Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SfLps-0006Hf-D9
 for kexec@lists.infradead.org; Fri, 15 Jun 2012 02:00:30 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 9DCC43EE0C0
 for <kexec@lists.infradead.org>; Fri, 15 Jun 2012 11:00:22 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 874FB45DE56
 for <kexec@lists.infradead.org>; Fri, 15 Jun 2012 11:00:22 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 6E4F645DE5B
 for <kexec@lists.infradead.org>; Fri, 15 Jun 2012 11:00:22 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 5FFA51DB8046
 for <kexec@lists.infradead.org>; Fri, 15 Jun 2012 11:00:22 +0900 (JST)
Received: from m024.s.css.fujitsu.com (m024.s.css.fujitsu.com [10.0.81.64])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 060AEE08003
 for <kexec@lists.infradead.org>; Fri, 15 Jun 2012 11:00:22 +0900 (JST)
Date: Fri, 15 Jun 2012 11:00:11 +0900 (JST)
Message-Id: <20120615.110011.523939983.d.hatayama@jp.fujitsu.com>
Subject: Re: [RFC PATCH 2/4] makedumpfile: Add partial bitmap for cyclic.
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20120612173004.c662378a.kumagai-atsushi@mxc.nes.nec.co.jp>
References: <20120604.121957.454958033.d.hatayama@jp.fujitsu.com>
 <20120607150436.4c1d35cb.kumagai-atsushi@mxc.nes.nec.co.jp>
 <20120612173004.c662378a.kumagai-atsushi@mxc.nes.nec.co.jp>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [RFC PATCH 2/4] makedumpfile: Add partial bitmap for cyclic.
Date: Tue, 12 Jun 2012 17:30:04 +0900

> Hello HATAYAMA-san,
> 
> On Thu, 7 Jun 2012 15:04:36 +0900
> Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:
> 
>> On Mon, 04 Jun 2012 12:19:57 +0900 (JST)
>> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
>> 
>> > > + */
>> > > +#define BUFSIZE_CYCLIC	        (8192)
>> > > +#define PFN_CYCLIC		(BUFSIZE_CYCLIC * BITPERBYTE)
>> > > +
>> > > +
>> > > +/*
>> > >   * Minimam vmcore has 2 ProgramHeaderTables(PT_NOTE and PT_LOAD).
>> > 
>> > How did you choose this buffer size? Best performance? I think the
>> > performacne varies according to this buffer size, and to evaluate it,
>> > it's useful to be able to specify the size through command-line.
>>
>> Honestly, the buffer size has no means, I defined it without a specific reason
>> at first.
>> 
>> However, it's understandable that the size is important key for performance and
>> I agree with your opinion that enabling to specify the size is useful.
>> 
>> But, I noticed just now, prototype with increased buffer size isn't work correctly.
>> 
>>  - BUFSIZE_CYCLIC = 8192:
>> 
>>     $ makedumpfile -Kcd31 vmcore testdump.Kcd31
>>     ...
>>     The dumpfile is saved to testdump.Kcd31.
>> 
>>     makedumpfile Completed.
>>     $ ls -l testdump.*
>>     -rw------- 1 kumagai kumagai 21167309  6月  7 13:55 testdump.Kcd31
>>     -rw------- 1 kumagai kumagai 21167309  6月  7 13:28 testdump.cd31
>>     $
>> 
>>  - BUFSIZE_CYCLIC = 16384:
>> 
>>     $ makedumpfile -Kcd31 vmcore testdump.Kcd31
>>     ...
>>     The dumpfile is saved to testdump.Kcd31.
>> 
>>     makedumpfile Completed.
>>     $ ls -l testdump.*
>>     -rw------- 1 kumagai kumagai 18836948  6月  7 13:59 testdump.Kcd31
>>     -rw------- 1 kumagai kumagai 21167309  6月  7 13:28 testdump.cd31
>>     $
>> 
>> 
>> I must review my code quickly.
> 
> I found my mistake in the process of incraesing target region and
> show the modification at the end of this email.
> 
> On Mon, 4 Jun 2012 16:54:49 +0900
> Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:
> [...]
>> After received your mail, I measured executing time with the patch below.
>> The result below was measured in 5GB memory machine.
>> 
>> Result:
>>   a. makedumpfile -Kcd31 
>>     excluding time:   6.55 [sec]
>>     writing time:     5.89 [sec]
> 
> I measured executing time with BUFSIZE=8192 on 4 June as above.
> Additionally, I measured executing time with BUFSIZE=16384, 24576 and 32768
> in the same environment.
> 
> Result:
>     ------------------------------------------------------------------------
>     buffer size [byte]	     excluding time [sec]        writing time [sec]
>     ------------------------------------------------------------------------
>     	  8192		 	    6.55			 5.89
>     	 16384		 	    3.49			 5.91
>     	 24576		 	    2.39			 5.96
>     	 32768		 	    1.83			 5.96
>     ------------------------------------------------------------------------
> 
> It seems that the buffer size is really effective in performance.
> Even if we choose the way without tracing free_list, the overhead of cyclic processing
> will be reduced, so I expect some speedup.

Performacne of the excluding time looks improved propoertional to
buffer size. I guess this result means part of processing to switch to
next cycle is so much heavy. I'll follow something for further
improvement around there.

> 
> If enabling to specify the buffer size, I think the information for decision of 
> buffer size is needed. How do you decide the buffer size ?
> 

Proper buffer size depends on machine spec. I think it natural to
choose the largest common divisor as default. OTOH, on the environment
where users need maximal speed definitely, such as on the machine
where large memory where a little bit time difference can reach a big
difference in total, and such as when used in kdump, they would want
to know the proper values by actually running makedumpfile for a
variety of parameters relevant to speed. For such tool that make it
easy to do this, I imagine a kind of tool to search for fatest mirror
site.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
