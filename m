Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SpYGl-0000r0-61
 for kexec@lists.infradead.org; Fri, 13 Jul 2012 05:18:27 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 4971B3EE0C3
 for <kexec@lists.infradead.org>; Fri, 13 Jul 2012 14:18:17 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 31A1C45DE59
 for <kexec@lists.infradead.org>; Fri, 13 Jul 2012 14:18:17 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 16FC845DE54
 for <kexec@lists.infradead.org>; Fri, 13 Jul 2012 14:18:17 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 087741DB804C
 for <kexec@lists.infradead.org>; Fri, 13 Jul 2012 14:18:17 +0900 (JST)
Received: from m020.s.css.fujitsu.com (m020.s.css.fujitsu.com [10.0.81.60])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id B740F1DB804A
 for <kexec@lists.infradead.org>; Fri, 13 Jul 2012 14:18:16 +0900 (JST)
Date: Fri, 13 Jul 2012 14:18:01 +0900 (JST)
Message-Id: <20120713.141801.148862713.d.hatayama@jp.fujitsu.com>
Subject: Re: [RFC PATCH v2 0/10] makedumpfile: cyclic processing to keep
 memory consumption.
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20120713093611.af556072aff44268f1bec0e1@mxc.nes.nec.co.jp>
References: <20120704.175211.155723295.d.hatayama@jp.fujitsu.com>
 <20120711.142359.384961737.d.hatayama@jp.fujitsu.com>
 <20120713093611.af556072aff44268f1bec0e1@mxc.nes.nec.co.jp>
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
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org, vgoyal@redhat.com

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [RFC PATCH v2 0/10] makedumpfile: cyclic processing to keep memory consumption.
Date: Fri, 13 Jul 2012 09:36:11 +0900

> Hello HATAYAMA-san,
> 
> On Wed, 11 Jul 2012 14:23:59 +0900 (JST)
> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
> 
> [...]
>> >>> Hi Atushi san,
>> >>> 
>> >>> Good to see this work making progress. I have few queries.
>> >>> 
>> >>> - Do you have some numbers for bigger machines like 1TB or higher memory. 
>> >>>   I am curious to know how bad is the time penalty.
>> >> 
>> >> I'm afraid that I don't have such a large machine, so I need someone who can
>> >> measure execution time in large machine.
>> >> 
>> > 
>> > I can prepare such machine but I cannot say I can use the machine on
>> > this day precisely for example. But I think it must be until the end
>> > of this month at most. So, I would like to fix content of benchmark
>> > first.
>> > 
>> 
>> Hello Kumagai-san,
>> 
>> I'm now trying to reserve the machine with big memory, but I'm not
>> accurately sure when I can use the machine; expecting within this
>> month? In advance, I want to make sure what I measure in this
>> benchmark in more detail.
> 
> OK, I'm glad for your help.
> 
>> I'm going to collect at least what you showed in your benchmark: RSS
>> size for no option, -cd31 and -Ed31. Is there another to collect?
> 
> Would you collect RSS also for --split ?
> While I expect the RSS will be increase based on number of child processes,
> I want to see measured data.
> 

Yes, I'll collect RSS information. But due to COW, child processes
share parent process's memory until they modify their memory, so
simply looking value of RSS is not enough. We need to measure size of
shared part e.g. by looking at /proc/<PID>/smaps.

And, what version of makedumpfile should I use for this bench? If you
have additonal changes locally, it might be better to use the version.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
