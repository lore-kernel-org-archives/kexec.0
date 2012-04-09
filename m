Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SHOUH-0002Rx-5q
 for kexec@lists.infradead.org; Mon, 09 Apr 2012 23:59:10 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id A0D293EE0AE
 for <kexec@lists.infradead.org>; Tue, 10 Apr 2012 08:59:01 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 8ABCA45DE4F
 for <kexec@lists.infradead.org>; Tue, 10 Apr 2012 08:59:01 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 7304A45DE4E
 for <kexec@lists.infradead.org>; Tue, 10 Apr 2012 08:59:01 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 639CB1DB8037
 for <kexec@lists.infradead.org>; Tue, 10 Apr 2012 08:59:01 +0900 (JST)
Received: from m105.s.css.fujitsu.com (m105.s.css.fujitsu.com [10.240.81.145])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 1FC5E1DB802F
 for <kexec@lists.infradead.org>; Tue, 10 Apr 2012 08:59:01 +0900 (JST)
Date: Tue, 10 Apr 2012 08:58:24 +0900 (JST)
Message-Id: <20120410.085824.193685565.d.hatayama@jp.fujitsu.com>
Subject: Re: makedumpfile memory usage grows with system memory size
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20120409185728.GH1645@redhat.com>
References: <20120406175924.007450fe.kumagai-atsushi@mxc.nes.nec.co.jp>
 <20120406.182940.310075868.d.hatayama@jp.fujitsu.com>
 <20120409185728.GH1645@redhat.com>
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
Cc: dzickus@redhat.com, oomichi@mxs.nes.nec.co.jp, kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org

From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: makedumpfile memory usage grows with system memory size
Date: Mon, 9 Apr 2012 14:57:28 -0400

> On Fri, Apr 06, 2012 at 06:29:40PM +0900, HATAYAMA Daisuke wrote:
> 
> [..]
>> I agree. On the other hand, there is one more thing to consider. The
>> value of order is in private member of the page descripter. Now
>> there's no information for private member in VMCOREINFO. If we choose
>> this method and delete the current one, it's necessary to prepare
>> vmlinux file for old kernels.
> 
> What information do you need to access "private" member of "struct page".
> offset? Can't we extend VMCOREINFO to export this info too?
> 

Yes, I mean offset of private member in page structure. The member
contains order of the buddy. Extending VMCOREINFO is easy, but we
cannot do that for old kernels, for which vmlinux is needed
separately.

This might be the same as what Kumagai-san says he doesn' want to
change behaviour on kernel versions.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
