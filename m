Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VFClo-0007SV-3V
 for kexec@lists.infradead.org; Fri, 30 Aug 2013 00:41:00 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 4A0C93EE0BB
 for <kexec@lists.infradead.org>; Fri, 30 Aug 2013 09:40:38 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 3B36A45DE51
 for <kexec@lists.infradead.org>; Fri, 30 Aug 2013 09:40:38 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 219F745DE50
 for <kexec@lists.infradead.org>; Fri, 30 Aug 2013 09:40:38 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id C21C51DB8042
 for <kexec@lists.infradead.org>; Fri, 30 Aug 2013 09:40:37 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 1B4181DB803F
 for <kexec@lists.infradead.org>; Fri, 30 Aug 2013 09:40:37 +0900 (JST)
Message-ID: <521FE9BC.1090109@jp.fujitsu.com>
Date: Fri, 30 Aug 2013 09:39:24 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: use non-cyclic when possible
References: <E1VEnuJ-0000Jz-JI@eag09.americas.sgi.com>
In-Reply-To: <E1VEnuJ-0000Jz-JI@eag09.americas.sgi.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Cliff Wickman <cpw@sgi.com>
Cc: kexec@lists.infradead.org, kumagai-atsushi@mxc.nes.nec.co.jp

(2013/08/29 7:08), Cliff Wickman wrote:
> From: Cliff Wickman <cpw@sgi.com>
> 
> If there is plenty of memory use non-cyclic mode.
> 

If there is enough memory to use, the number of cycle is 1.
Cyclic mode in 1-cycle is the same as non-cyclic mode in theory.
If slow, it's better to improve cyclic mode implementation.

To be honest, I think the current non-cyclic mode should be implemented as 1-cycle case. Then, makedumpfile can reduce amount of code at the same time.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
