Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.nokia.com ([192.100.122.230] helo=mgw-mx03.nokia.com)
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1NsckS-0000ZY-7y
	for kexec@lists.infradead.org; Fri, 19 Mar 2010 14:00:28 +0000
From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH] kexec-tools: Fix a typo in rpm spec description
Date: Fri, 19 Mar 2010 15:58:52 +0200
Message-Id: <dc79caccb36f1bf0dbd5b105cbd4e885ff79dd71.1269007108.git.ameya.palande@nokia.com>
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

From: Ameya Palande <ameya.palande@nokia.com>

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 kexec-tools.spec.in |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kexec-tools.spec.in b/kexec-tools.spec.in
index 5eadece..ae91b73 100644
--- a/kexec-tools.spec.in
+++ b/kexec-tools.spec.in
@@ -9,7 +9,7 @@ Packager: Eric Biederman <ebiederman@xmission.com>
 BuildRoot: %{_tmppath}/%{name}
 
 %description
-/sbin/kexec is a user space utiltity for loading another kernel
+/sbin/kexec is a user space utilitity for loading another kernel
 and asking the currently running kernel to do something with it.
 A currently running kernel may be asked to start the loaded
 kernel on reboot, or to start the loaded kernel after it panics.
-- 
1.6.3.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
