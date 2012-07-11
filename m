Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SopQP-0005ci-HV
 for kexec@lists.infradead.org; Wed, 11 Jul 2012 05:25:34 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 304FD3EE0AE
 for <kexec@lists.infradead.org>; Wed, 11 Jul 2012 14:25:09 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 170A645DE55
 for <kexec@lists.infradead.org>; Wed, 11 Jul 2012 14:25:09 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id F029645DE54
 for <kexec@lists.infradead.org>; Wed, 11 Jul 2012 14:25:08 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id E38FD1DB8050
 for <kexec@lists.infradead.org>; Wed, 11 Jul 2012 14:25:08 +0900 (JST)
Received: from m024.s.css.fujitsu.com (m024.s.css.fujitsu.com [10.0.81.64])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id A01831DB8046
 for <kexec@lists.infradead.org>; Wed, 11 Jul 2012 14:25:08 +0900 (JST)
Date: Wed, 11 Jul 2012 14:23:59 +0900 (JST)
Message-Id: <20120711.142359.384961737.d.hatayama@jp.fujitsu.com>
Subject: Re: [RFC PATCH v2 0/10] makedumpfile: cyclic processing to keep
 memory consumption.
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20120704.175211.155723295.d.hatayama@jp.fujitsu.com>
References: <20120702123905.GG24929@redhat.com>
 <20120704145406.bf22a34cec586e3c1e8e29b5@mxc.nes.nec.co.jp>
 <20120704.175211.155723295.d.hatayama@jp.fujitsu.com>
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

From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: Re: [RFC PATCH v2 0/10] makedumpfile: cyclic processing to keep memory consumption.
Date: Wed, 4 Jul 2012 17:52:11 +0900

> From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
> Subject: Re: [RFC PATCH v2 0/10] makedumpfile: cyclic processing to keep memory consumption.
> Date: Wed, 4 Jul 2012 14:54:06 +0900
> 
>> Hello Vivek,
>> 
>> On Mon, 2 Jul 2012 08:39:05 -0400
>> Vivek Goyal <vgoyal@redhat.com> wrote:
>> 
>>> On Fri, Jun 29, 2012 at 11:13:20AM +0900, Atsushi Kumagai wrote:
>>> > Hello,
>>> > 
>>> > I improved prototype of cyclic processing as version 2.
>>> > If there is no objection to basic idea, I want to consider the things
>>> > related to performance as next step. (Concretely, buffer size and the patch set
>>> > HATAYAMA-san sent a short time ago.) 
>>> > 
>>> 
>>> Hi Atushi san,
>>> 
>>> Good to see this work making progress. I have few queries.
>>> 
>>> - Do you have some numbers for bigger machines like 1TB or higher memory. 
>>>   I am curious to know how bad is the time penalty.
>> 
>> I'm afraid that I don't have such a large machine, so I need someone who can
>> measure execution time in large machine.
>> 
> 
> I can prepare such machine but I cannot say I can use the machine on
> this day precisely for example. But I think it must be until the end
> of this month at most. So, I would like to fix content of benchmark
> first.
> 

Hello Kumagai-san,

I'm now trying to reserve the machine with big memory, but I'm not
accurately sure when I can use the machine; expecting within this
month? In advance, I want to make sure what I measure in this
benchmark in more detail.

I'm going to collect at least what you showed in your benchmark: RSS
size for no option, -cd31 and -Ed31. Is there another to collect?

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
