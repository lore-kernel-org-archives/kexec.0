Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Prj1s-0006n5-QB
	for kexec@lists.infradead.org; Tue, 22 Feb 2011 03:35:13 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id AC9793EE0BC
	for <kexec@lists.infradead.org>; Tue, 22 Feb 2011 12:35:08 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
	by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 92BFC45DE4E
	for <kexec@lists.infradead.org>; Tue, 22 Feb 2011 12:35:08 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 79FAC45DE4D
	for <kexec@lists.infradead.org>; Tue, 22 Feb 2011 12:35:08 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 6D45E1DB8037
	for <kexec@lists.infradead.org>; Tue, 22 Feb 2011 12:35:08 +0900 (JST)
Received: from m105.s.css.fujitsu.com (m105.s.css.fujitsu.com [10.249.87.105])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 3AE231DB802F
	for <kexec@lists.infradead.org>; Tue, 22 Feb 2011 12:35:08 +0900 (JST)
Date: Tue, 22 Feb 2011 12:34:58 +0900 (   )
Message-Id: <20110222.123458.104045336.d.hatayama@jp.fujitsu.com>
Subject: makedumpfile's segmentation fault with option -V
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: oomichi@mxs.nes.nec.co.jp, kexec@lists.infradead.org

Hello,

On fc14 and el6 on x86_64, makedumpfile has resulted in segmentation
fault with option -V.

  $ makedumpfile -V
  Segmentation fault (core dumped)

I've found this by mistaking -v for -V to display version information.

Thanks.
HATAYAMA Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
