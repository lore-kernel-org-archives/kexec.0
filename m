Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SSLBF-0007Kx-KX
 for kexec@lists.infradead.org; Thu, 10 May 2012 04:41:13 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id A4C313EE0BC
 for <kexec@lists.infradead.org>; Thu, 10 May 2012 13:40:39 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 8C11E45DEA6
 for <kexec@lists.infradead.org>; Thu, 10 May 2012 13:40:39 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 72E3345DE9E
 for <kexec@lists.infradead.org>; Thu, 10 May 2012 13:40:39 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 664151DB8038
 for <kexec@lists.infradead.org>; Thu, 10 May 2012 13:40:39 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 17FF31DB803C
 for <kexec@lists.infradead.org>; Thu, 10 May 2012 13:40:39 +0900 (JST)
Date: Thu, 10 May 2012 13:40:27 +0900 (JST)
Message-Id: <20120510.134027.59660133.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH makedumpfile v2 0/4] LZO Compression Support
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20120510124027.dd6829f4.kumagai-atsushi@mxc.nes.nec.co.jp>
References: <20120223171646.18e3dd30.kumagai-atsushi@mxc.nes.nec.co.jp>
 <20120510.093829.347152059.d.hatayama@jp.fujitsu.com>
 <20120510124027.dd6829f4.kumagai-atsushi@mxc.nes.nec.co.jp>
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
Cc: kexec@lists.infradead.org, suzuki@in.ibm.com, crash-utility@redhat.com

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH makedumpfile v2 0/4] LZO Compression Support
Date: Thu, 10 May 2012 12:40:27 +0900

> 
> At first, I planned to merge features below into v1.4.4.
> 
>  - vmalloc translation support for PPC32 (by Suzuki K. Poulose)
>  - LZO Compression Support (by HATAYAMA Daisuke)
>  - sadump: check if given cpu is online in per-cpu related helper functions
>    (by HATAYAMA Daisuke)
> 
> However, the first one is being discussed and the schedule is not clear.
> So, I would like to postpone the feature for v1.4.5 and start testing 
> the other two for v1.4.4. 
> 
> If I can start testing now, I will release v1.4.4 in this month.
> 

Thanks. So the release would be before the release of crash utility's
next version. I'll post the patch for crash utility soon.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
