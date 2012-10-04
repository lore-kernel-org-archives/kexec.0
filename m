Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TJa2N-0003YG-Dh
 for kexec@lists.infradead.org; Thu, 04 Oct 2012 01:15:40 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 160F63EE0AE
 for <kexec@lists.infradead.org>; Thu,  4 Oct 2012 10:15:30 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id F2D8745DE58
 for <kexec@lists.infradead.org>; Thu,  4 Oct 2012 10:15:29 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id DC63445DE54
 for <kexec@lists.infradead.org>; Thu,  4 Oct 2012 10:15:29 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id CC39CE08002
 for <kexec@lists.infradead.org>; Thu,  4 Oct 2012 10:15:29 +0900 (JST)
Received: from m023.s.css.fujitsu.com (m023.s.css.fujitsu.com [10.0.81.63])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 874761DB8032
 for <kexec@lists.infradead.org>; Thu,  4 Oct 2012 10:15:29 +0900 (JST)
Date: Thu, 04 Oct 2012 10:15:14 +0900 (JST)
Message-Id: <20121004.101514.97028749.d.hatayama@jp.fujitsu.com>
Subject: Re: makedumpfile 1.5.0 takes much more time to dump
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20121003163835.c4be2b609deb385aab247beb@mxc.nes.nec.co.jp>
References: <20120924.095112.153507503.d.hatayama@jp.fujitsu.com>
 <20120924145157.GA14886@redhat.com>
 <20121003163835.c4be2b609deb385aab247beb@mxc.nes.nec.co.jp>
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
Cc: kexec@lists.infradead.org, dyoung@redhat.com, chaowang@redhat.com, vgoyal@redhat.com

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: makedumpfile 1.5.0 takes much more time to dump
Date: Wed, 3 Oct 2012 16:38:35 +0900
<cut>
>> BTW, Kumagai-san, in what version do you plan release of this new
>> mem_map logic? Around v1.5.2? I want to re-send a new patch set to
>> which I add small changes and comments for maintainability.
> 
> Yes, I plan to merge it in v1.5.2. 
> Would you re-send the new patch set based on v1.5.1 ?
> 

Yes, I'll do so.

> Additionally, I'm afraid that I haven't reviewed the most of patches
> for v1.5.1 yet. So I can't tell you when v1.5.2 will be released.
> 

Please tell me that later when you figure out.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
