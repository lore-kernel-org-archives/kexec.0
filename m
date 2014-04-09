Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WXmv6-0008KH-H3
 for kexec@lists.infradead.org; Wed, 09 Apr 2014 07:27:42 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 6DF393EE189
 for <kexec@lists.infradead.org>; Wed,  9 Apr 2014 16:27:18 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 5DDC545DF49
 for <kexec@lists.infradead.org>; Wed,  9 Apr 2014 16:27:18 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.nic.fujitsu.com [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 445BA45DF42
 for <kexec@lists.infradead.org>; Wed,  9 Apr 2014 16:27:18 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 342CC1DB8038
 for <kexec@lists.infradead.org>; Wed,  9 Apr 2014 16:27:18 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id D6D441DB803E
 for <kexec@lists.infradead.org>; Wed,  9 Apr 2014 16:27:17 +0900 (JST)
Date: Wed, 09 Apr 2014 16:27:08 +0900 (JST)
Message-Id: <20140409.162708.93024867.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH v2 2/3] Generic handling of multi-page exclusions
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE971FF28C@BPXM01GP.gisp.nec.co.jp>
References: <20140408085436.51340ae2@hananiah.suse.cz>
 <20140408.171903.322808733.d.hatayama@jp.fujitsu.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971FF28C@BPXM01GP.gisp.nec.co.jp>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org, ptesarik@suse.cz

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH v2 2/3] Generic handling of multi-page exclusions
Date: Tue, 8 Apr 2014 09:00:19 +0000

> 
> At that time, I chose the current code since it was simpler and safer.
> http://www.mail-archive.com/kexec%40lists.infradead.org/msg10207.html
> 
> Don't you like this ?
> 

Sorry. I had forgotten this. We should keep the sanity check
there. But in our policy, we should not pass to set_bitmap_cyclic(),
pfn and cycle where pfn is not in the cycle. We should chceck that in
the caller side and pass pfn in the cycle only.

Also, on the current implementation, even if pfn outside a current
cycle is passed to set_bitmap_cyclic(), we don't have any means to
know that.

So, how about warning that only once at runtime?

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
