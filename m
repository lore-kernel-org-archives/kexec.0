Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RY5vT-0004qz-I9
 for kexec@lists.infradead.org; Wed, 07 Dec 2011 01:04:01 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id DF8EC3EE081
 for <kexec@lists.infradead.org>; Wed,  7 Dec 2011 10:03:52 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id C906245DE50
 for <kexec@lists.infradead.org>; Wed,  7 Dec 2011 10:03:52 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id B0D4C45DE4D
 for <kexec@lists.infradead.org>; Wed,  7 Dec 2011 10:03:52 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id A2CF9E08003
 for <kexec@lists.infradead.org>; Wed,  7 Dec 2011 10:03:52 +0900 (JST)
Received: from m107.s.css.fujitsu.com (m107.s.css.fujitsu.com [10.240.81.147])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 5C37E1DB8037
 for <kexec@lists.infradead.org>; Wed,  7 Dec 2011 10:03:52 +0900 (JST)
Date: Wed, 07 Dec 2011 10:03:42 +0900 (   )
Message-Id: <20111207.100342.59655738.d.hatayama@jp.fujitsu.com>
Subject: Re: [RFC] makedumpfile, crash: LZO compression support
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20111205175055.fd3ddb2f.kumagai-atsushi@mxc.nes.nec.co.jp>
References: <20111118121458.5c007bda.kumagai-atsushi@mxc.nes.nec.co.jp>
 <20111118.154853.246506690.d.hatayama@jp.fujitsu.com>
 <20111205175055.fd3ddb2f.kumagai-atsushi@mxc.nes.nec.co.jp>
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

Hello Kumagai-san,

Thanks for the evaluation.

So I'll re-post the patch soon removing RFC prefix in header. But
there is a remaining fix for checking command-line parameters relevant
to addition of the 'l' option.

How about the patch adding compression/IO time report?
I intended it only for the presentation of this RFC.

I'll post the corresponding patch in crash's side after crash 6.0.2 is
released, waiting for new configuration editing feature as Dave has
explained.

Thanks.
HATAYAMA, Daisuke

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [RFC] makedumpfile, crash: LZO compression support
Date: Mon, 5 Dec 2011 17:50:55 +0900

>> > Hello Hatayama-san,
>> > 
>> > Thank you for your work.
>> > 
>> >> Performance Comparison:
>> >> 
>> >>   Sample Data
>> >> 
>> >>     Ideally, I must have measured the performance for many enough
>> >>     vmcores generated from machines that was actually running, but now
>> >>     I don't have enough sample vmcores, I couldn't do so. So this
>> >>     comparison doesn't answer question on I/O time improvement. This
>> >>     is TODO for now.
>> > 
>> > I'll measure the performance for actual vmcores by makedumpfile.
>> > Please wait for a while.
> 
> I measured the performance of makedumpfile for some vmcores.
> Please see below.
> 
> 
> Sample Data
>   
>   To simulate a working server, I captured VMCOREs while almost all pages 
>   were alloceted and filled with random data. (See attached file "fill_random.c")
> 
>   I captured the VMCOREs of 5GB, 7.5GB and 10GB in the same condition.
> 
> How to measure
> 
>   I measured the total execution time and the size of output file.
> 
>   $ time makedumpfile --message-level 16 [-c|-l| ] vmcore dumpfile
> 
> Result
> 
>     See attached file "result.txt".
> 
> 
> This time, lzo's compression was the quickest, and lzo's compression ratio is
> almost the same(only a bit worse) as zlib's.
> It seems good, and I will merge the patch set into the makedumpfile.
> 
> What is your opinion, Dave?
> 
> 
> Thanks.
> KUMAGAI, Atsushi
> 
>> 
>> That's very helpful. Thanks in advance.
>> 
>> But of course I'm also still looking for alternative way.
>> 
>> Thanks.
>> HATAYAMA, Daisuke
>> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
