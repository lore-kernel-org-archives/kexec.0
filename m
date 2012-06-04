Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SbP7l-0002iB-9J
 for kexec@lists.infradead.org; Mon, 04 Jun 2012 04:42:38 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 093CE3EE0B5
 for <kexec@lists.infradead.org>; Mon,  4 Jun 2012 13:42:33 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id E603545DE4D
 for <kexec@lists.infradead.org>; Mon,  4 Jun 2012 13:42:32 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id C966B45DE51
 for <kexec@lists.infradead.org>; Mon,  4 Jun 2012 13:42:32 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id BC0711DB803B
 for <kexec@lists.infradead.org>; Mon,  4 Jun 2012 13:42:32 +0900 (JST)
Received: from m020.s.css.fujitsu.com (m020.s.css.fujitsu.com [10.0.81.60])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 717951DB803E
 for <kexec@lists.infradead.org>; Mon,  4 Jun 2012 13:42:32 +0900 (JST)
Date: Mon, 04 Jun 2012 13:42:12 +0900 (JST)
Message-Id: <20120604.134212.319008231.d.hatayama@jp.fujitsu.com>
Subject: Re: [RFC PATCH 4/4] makedumpfile: Add main routine of cyclic
 processing.
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20120531135654.a26dd3fe.kumagai-atsushi@mxc.nes.nec.co.jp>
References: <20120531135654.a26dd3fe.kumagai-atsushi@mxc.nes.nec.co.jp>
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
Cc: kexec@lists.infradead.org

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [RFC PATCH 4/4] makedumpfile: Add main routine of cyclic processing.
Date: Thu, 31 May 2012 13:56:54 +0900

> +	/*
> +	 * Write pages and bitmap cyclically.
> +	 */
> +	for (info->split_start_pfn = 0, info->split_end_pfn = PFN_CYCLIC;
> +	     info->split_end_pfn <= info->max_mapnr;
> +	     info->split_start_pfn += PFN_CYCLIC, info->split_end_pfn += PFN_CYCLIC) {

The cyclic processing is orthogonal to the splitting feature. The
feature of splitting a single vmcore into multiple dumpfiles is an
important feature on large system to reduce dump generation time. They
should exist together.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
