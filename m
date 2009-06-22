Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MIdlO-0006wP-3l
	for kexec@lists.infradead.org; Mon, 22 Jun 2009 07:16:29 +0000
Received: from m5.gw.fujitsu.co.jp ([10.0.50.75])
	by fgwmail7.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	n5M7GBtx028999 for <kexec@lists.infradead.org> (envelope-from
	seto.hidetoshi@jp.fujitsu.com); Mon, 22 Jun 2009 16:16:12 +0900
Received: from smail (m5 [127.0.0.1])
	by outgoing.m5.gw.fujitsu.co.jp (Postfix) with ESMTP id 99D6E45DE4F
	for <kexec@lists.infradead.org>; Mon, 22 Jun 2009 16:16:11 +0900 (JST)
Received: from s5.gw.fujitsu.co.jp (s5.gw.fujitsu.co.jp [10.0.50.95])
	by m5.gw.fujitsu.co.jp (Postfix) with ESMTP id 6DDDD45DE51
	for <kexec@lists.infradead.org>; Mon, 22 Jun 2009 16:16:11 +0900 (JST)
Received: from s5.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s5.gw.fujitsu.co.jp (Postfix) with ESMTP id 3753F1DB805D
	for <kexec@lists.infradead.org>; Mon, 22 Jun 2009 16:16:11 +0900 (JST)
Received: from m106.s.css.fujitsu.com (m106.s.css.fujitsu.com [10.249.87.106])
	by s5.gw.fujitsu.co.jp (Postfix) with ESMTP id CBAE2E08009
	for <kexec@lists.infradead.org>; Mon, 22 Jun 2009 16:16:10 +0900 (JST)
Message-ID: <4A3F2FB6.6040901@jp.fujitsu.com>
Date: Mon, 22 Jun 2009 16:16:06 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/7] Patches for kdump vs. INIT
References: <4A39E247.4030908@jp.fujitsu.com>
	<5AA89A0287224699B8E5C0526CE0EA41@Lanx8664>
In-Reply-To: <5AA89A0287224699B8E5C0526CE0EA41@Lanx8664>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Jay Lan <jay.zen.lan@gmail.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, linux-ia64@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Haren Myneni <hbabu@us.ibm.com>, Vivek Goyal <vgoyal@redhat.com>

Jay Lan wrote:
> Kdump with INIT on IPF worked on SGI's IA64 servers when i left SGI last
> December.
> Is this problem something new to you after .27?

No.
This is a potential bug in design, in case of INIT+INIT and panic+INIT. 

> SGI folks should test this patchset to ensure no surprise is introduced
> to their servers.

Any tests and comments would be appreciated.


Thanks,
H.Seto

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
