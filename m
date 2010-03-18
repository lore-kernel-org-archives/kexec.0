Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bw0-f215.google.com ([209.85.218.215])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NsLwM-00071V-Le
	for kexec@lists.infradead.org; Thu, 18 Mar 2010 20:03:38 +0000
Received: by bwz7 with SMTP id 7so1840936bwz.4
	for <kexec@lists.infradead.org>; Thu, 18 Mar 2010 13:03:31 -0700 (PDT)
From: Ameya Palande <2ameya@gmail.com>
Subject: [PATCH 0/6] kexec-tools: Fix rpm build
Date: Thu, 18 Mar 2010 22:03:18 +0200
Message-Id: <cover.1268942234.git.ameya.palande@nokia.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: horms@verge.net.au

This patchset fixes currently broken rpm build.

Ameya Palande (6):
  kexec-tools: Fix rpm Version tag
  kexec-tools: Use same source in rpm spec and Makefile.in
  kexec-tools: Add missing include files in dist target
  kexec-tools: Add kdump and kexec_test to rpm spec
  kexec-tools: Add rpm spec file to the dist-clean target
  kexec-tools: Use default rpmbuild definations

 Makefile.in         |   21 +++++----------------
 configure.ac        |    2 +-
 include/Makefile    |    1 +
 kexec-tools.spec.in |    2 ++
 kexec/Makefile      |    1 +
 5 files changed, 10 insertions(+), 17 deletions(-)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
