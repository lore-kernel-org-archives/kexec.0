Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SDEuW-0006eF-Er
 for kexec@lists.infradead.org; Thu, 29 Mar 2012 12:57:06 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id D34D73EE0B6
 for <kexec@lists.infradead.org>; Thu, 29 Mar 2012 21:56:57 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id BAEDA45DE53
 for <kexec@lists.infradead.org>; Thu, 29 Mar 2012 21:56:57 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id A259945DE50
 for <kexec@lists.infradead.org>; Thu, 29 Mar 2012 21:56:57 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 93EAC1DB803F
 for <kexec@lists.infradead.org>; Thu, 29 Mar 2012 21:56:57 +0900 (JST)
Received: from m105.s.css.fujitsu.com (m105.s.css.fujitsu.com [10.240.81.145])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 4D3581DB802F
 for <kexec@lists.infradead.org>; Thu, 29 Mar 2012 21:56:57 +0900 (JST)
Date: Thu, 29 Mar 2012 21:56:46 +0900 (   )
Message-Id: <20120329.215646.28793982.d.hatayama@jp.fujitsu.com>
Subject: Re: makedumpfile memory usage grows with system memory size
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20120329170918.4223e816.oomichi@mxs.nes.nec.co.jp>
References: <20120328212204.GI18218@redhat.com>
 <20120329170918.4223e816.oomichi@mxs.nes.nec.co.jp>
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
To: dzickus@redhat.com
Cc: oomichi@mxs.nes.nec.co.jp, kexec@lists.infradead.org

Hello Don,

I'm missing your mail somehow so replying Oomichi-san's mail...

From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: makedumpfile memory usage grows with system memory size
Date: Thu, 29 Mar 2012 17:09:18 +0900

> 
> On Wed, 28 Mar 2012 17:22:04 -0400
> Don Zickus <dzickus@redhat.com> wrote:

>> I was curious if that was true and if it was, would it be possible to only
>> process memory in chunks instead of all at once.
>> 
>> The idea is that a machine with 4Gigs of memory should consume the same
>> the amount of kdump runtime memory as a 1TB memory system.
>> 
>> Just trying to research ways to keep the memory requirements consistent
>> across all memory ranges.

I think this is possible in constant memory space by creating bitmaps
and writing pages in a certain amount of memory. That is, if choosing
4GB, do [0, 4GB) space processing, [4GB, 8GB) space processing, [8GB,
12GB) ... in order. The key is to restrict the target memory range of
filtering.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
