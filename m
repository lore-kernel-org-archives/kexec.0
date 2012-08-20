Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T3FcL-0001zM-QW
 for kexec@lists.infradead.org; Mon, 20 Aug 2012 00:13:19 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 0EF1E3EE0BD
 for <kexec@lists.infradead.org>; Mon, 20 Aug 2012 09:13:11 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id EC1F545DE50
 for <kexec@lists.infradead.org>; Mon, 20 Aug 2012 09:13:10 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id D648445DE52
 for <kexec@lists.infradead.org>; Mon, 20 Aug 2012 09:13:10 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id C8B7A1DB8037
 for <kexec@lists.infradead.org>; Mon, 20 Aug 2012 09:13:10 +0900 (JST)
Received: from m023.s.css.fujitsu.com (m023.s.css.fujitsu.com [10.0.81.63])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 8676EE08001
 for <kexec@lists.infradead.org>; Mon, 20 Aug 2012 09:13:10 +0900 (JST)
Date: Mon, 20 Aug 2012 09:12:44 +0900 (JST)
Message-Id: <20120820.091244.40048129.d.hatayama@jp.fujitsu.com>
Subject: Re: [RFC PATCH v2 0/10] makedumpfile: cyclic processing to keep
 memory consumption.
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20120815152710.982b745a50673defdf9aabd1@mxc.nes.nec.co.jp>
References: <20120810143655.GA5416@redhat.com>
 <20120814.205532.509440957.d.hatayama@jp.fujitsu.com>
 <20120815152710.982b745a50673defdf9aabd1@mxc.nes.nec.co.jp>
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
Date: Wed, 15 Aug 2012 15:27:10 +0900

> Hello HATAYAMA-san,
> 
> On Tue, 14 Aug 2012 20:55:32 +0900 (JST)
> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
> 
>> From: Vivek Goyal <vgoyal@redhat.com>
>> Subject: Re: [RFC PATCH v2 0/10] makedumpfile: cyclic processing to keep memory consumption.
>> Date: Fri, 10 Aug 2012 10:36:55 -0400
>> 
>> > On Fri, Aug 10, 2012 at 05:39:38PM +0900, HATAYAMA Daisuke wrote:
>> > 
>> > [..]
>> >> 
>> >> I finished benchmarking filtering time and demonstrate the result.
>> >> But I failed to collect amount of memory consumption by my mistake. If
>> >> they are necessary, I'll again try to collect them. But we have 9 days
>> >> vacation starting tommorow, so I'll do that after the vacation.
>> >> 
> 
> Thank you for your help.
> Could you continue to measure amount of memory consumption ?
> 

OK, Kumagai-san, please wait for a while.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
