Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from vps.thesusis.net ([34.202.238.73])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kn4ru-0003VC-KT
 for kexec@lists.infradead.org; Wed, 09 Dec 2020 19:11:19 +0000
Received: from localhost (localhost [127.0.0.1])
 by vps.thesusis.net (Postfix) with ESMTP id 1EFCA21C03
 for <kexec@lists.infradead.org>; Wed,  9 Dec 2020 14:11:15 -0500 (EST)
Received: from vps.thesusis.net ([127.0.0.1])
 by localhost (vps.thesusis.net [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LF1PwSUD8ZsL for <kexec@lists.infradead.org>;
 Wed,  9 Dec 2020 14:11:14 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
Subject: kexec not working in xen domU?
Date: Wed, 09 Dec 2020 14:09:13 -0500
Message-ID: <87h7oudcbx.fsf@vps.thesusis.net>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Whenever I try to use kexec in a xen domU, the domain just reboots all
the way through the bios rather than loading the kexec'ed kernel with
the given command line.  Is this a known issue?  I've tried with both
systemctl kexec and kexec -e.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
