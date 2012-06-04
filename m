Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SbNqM-0001ru-De
 for kexec@lists.infradead.org; Mon, 04 Jun 2012 03:20:36 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id A48553EE081
 for <kexec@lists.infradead.org>; Mon,  4 Jun 2012 12:20:26 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 8D4ED45DE50
 for <kexec@lists.infradead.org>; Mon,  4 Jun 2012 12:20:26 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 74F8445DD78
 for <kexec@lists.infradead.org>; Mon,  4 Jun 2012 12:20:26 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 68B321DB803C
 for <kexec@lists.infradead.org>; Mon,  4 Jun 2012 12:20:26 +0900 (JST)
Received: from m025.s.css.fujitsu.com (m025.s.css.fujitsu.com [10.0.81.65])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 202EE1DB8038
 for <kexec@lists.infradead.org>; Mon,  4 Jun 2012 12:20:26 +0900 (JST)
Date: Mon, 04 Jun 2012 12:19:57 +0900 (JST)
Message-Id: <20120604.121957.454958033.d.hatayama@jp.fujitsu.com>
Subject: Re: [RFC PATCH 2/4] makedumpfile: Add partial bitmap for cyclic.
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20120531140103.264cc0c4.kumagai-atsushi@mxc.nes.nec.co.jp>
References: <20120531140103.264cc0c4.kumagai-atsushi@mxc.nes.nec.co.jp>
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
Subject: [RFC PATCH 2/4] makedumpfile: Add partial bitmap for cyclic.
Date: Thu, 31 May 2012 14:01:03 +0900

>  /*
> + * For cyclic
> + */
> +#define BUFSIZE_CYCLIC	        (8192)
> +#define PFN_CYCLIC		(BUFSIZE_CYCLIC * BITPERBYTE)
> +
> +
> +/*
>   * Minimam vmcore has 2 ProgramHeaderTables(PT_NOTE and PT_LOAD).

How did you choose this buffer size? Best performance? I think the
performacne varies according to this buffer size, and to evaluate it,
it's useful to be able to specify the size through command-line.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
