Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QbSyX-0002M4-RL
	for kexec@lists.infradead.org; Tue, 28 Jun 2011 07:44:51 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 5DE9F3EE0BC
	for <kexec@lists.infradead.org>; Tue, 28 Jun 2011 16:44:41 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
	by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 4838545DE59
	for <kexec@lists.infradead.org>; Tue, 28 Jun 2011 16:44:41 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
	by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 3183F45DE54
	for <kexec@lists.infradead.org>; Tue, 28 Jun 2011 16:44:41 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 2044DE08002
	for <kexec@lists.infradead.org>; Tue, 28 Jun 2011 16:44:41 +0900 (JST)
Received: from m106.s.css.fujitsu.com (m106.s.css.fujitsu.com [10.240.81.146])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id DF0E11DB8049
	for <kexec@lists.infradead.org>; Tue, 28 Jun 2011 16:44:40 +0900 (JST)
Date: Tue, 28 Jun 2011 16:44:25 +0900 (   )
Message-Id: <20110628.164425.39157342.d.hatayama@jp.fujitsu.com>
Subject: [RFI] Support Fujitsu's sadump dump format
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
To: crash-utility@redhat.com, kexec@lists.infradead.org

Fujitsu has stand-alone dump mechanism based on firmware level
functionality, which we call SADUMP, in short.

We've maintained utility tools internally but now we're thinking that
the best is crash utility and makedumpfile supports the sadump format
for the viewpoint of both portability and maintainability.

We'll be of course responsible for its maintainance in a continuous
manner. The sadump dump format is very similar to diskdump format and
so kdump (compressed) format, so we estimate patch set would be a
relatively small size.

Could you tell me whether crash utility and makedumpfile can support
the sadump format? If OK, we'll start to make patchset.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
