Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]
	helo=master.linux-sh.org)
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1MVYpa-0007Sl-QO
	for kexec@lists.infradead.org; Mon, 27 Jul 2009 22:38:11 +0000
Received: from localhost (unknown [127.0.0.1])
	by master.linux-sh.org (Postfix) with ESMTP id 3B1616375A
	for <kexec@lists.infradead.org>; Mon, 27 Jul 2009 22:37:59 +0000 (UTC)
Received: from master.linux-sh.org ([127.0.0.1])
	by localhost (master.linux-sh.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ao5FLlboagpt for <kexec@lists.infradead.org>;
	Tue, 28 Jul 2009 07:37:59 +0900 (JST)
Date: Tue, 28 Jul 2009 07:37:58 +0900
From: Paul Mundt <lethal@linux-sh.org>
Subject: [PATCH] kexec: Handle datarootdir for newer autoconf versions.
Message-ID: <20090727223758.GA22668@linux-sh.org>
MIME-Version: 1.0
Content-Disposition: inline
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
To: kexec@lists.infradead.org

This fixes up the:

config.status: WARNING:  'Makefile.in' seems to ignore the --datarootdir setting

warning when producing the output Makefile.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 Makefile.in |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile.in b/Makefile.in
index 6b4c954..cb0faae 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -10,6 +10,7 @@ bindir		= @bindir@
 sbindir		= @sbindir@
 libexecdir	= @libexecdir@
 datadir		= @datadir@
+datarootdir	= @datarootdir@
 sysconfdir	= @sysconfdir@
 sharedstatedir	= @sharedstatedir@
 localstatedir	= @localstatedir@

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
