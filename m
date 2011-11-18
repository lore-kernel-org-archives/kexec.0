Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RRIG8-0004Bo-CI
 for kexec@lists.infradead.org; Fri, 18 Nov 2011 06:49:14 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id AF7313EE0AE
 for <kexec@lists.infradead.org>; Fri, 18 Nov 2011 15:49:06 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 84AEE45DE55
 for <kexec@lists.infradead.org>; Fri, 18 Nov 2011 15:49:06 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 5C95D45DE54
 for <kexec@lists.infradead.org>; Fri, 18 Nov 2011 15:49:06 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 505BC1DB804E
 for <kexec@lists.infradead.org>; Fri, 18 Nov 2011 15:49:06 +0900 (JST)
Received: from m105.s.css.fujitsu.com (m105.s.css.fujitsu.com [10.240.81.145])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 1CE4B1DB8048
 for <kexec@lists.infradead.org>; Fri, 18 Nov 2011 15:49:06 +0900 (JST)
Date: Fri, 18 Nov 2011 15:48:53 +0900 (   )
Message-Id: <20111118.154853.246506690.d.hatayama@jp.fujitsu.com>
Subject: Re: [RFC] makedumpfile, crash: LZO compression support
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20111118121458.5c007bda.kumagai-atsushi@mxc.nes.nec.co.jp>
References: <20111117211946.3e27b840.d.hatayama@jp.fujitsu.com>
 <20111118121458.5c007bda.kumagai-atsushi@mxc.nes.nec.co.jp>
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
Cc: kexec@lists.infradead.org, crash-utility@redhat.com

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [RFC] makedumpfile, crash: LZO compression support
Date: Fri, 18 Nov 2011 12:14:58 +0900

> Hello Hatayama-san,
> 
> Thank you for your work.
> 
>> Performance Comparison:
>> 
>>   Sample Data
>> 
>>     Ideally, I must have measured the performance for many enough
>>     vmcores generated from machines that was actually running, but now
>>     I don't have enough sample vmcores, I couldn't do so. So this
>>     comparison doesn't answer question on I/O time improvement. This
>>     is TODO for now.
> 
> I'll measure the performance for actual vmcores by makedumpfile.
> Please wait for a while.

That's very helpful. Thanks in advance.

But of course I'm also still looking for alternative way.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
