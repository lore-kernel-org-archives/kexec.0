Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hQa8D-0007hz-HQ
 for kexec@lists.infradead.org; Tue, 14 May 2019 16:18:22 +0000
Received: by mail-wr1-x441.google.com with SMTP id e15so7502490wrs.4
 for <kexec@lists.infradead.org>; Tue, 14 May 2019 09:18:21 -0700 (PDT)
From: Cengiz Can <cengizc@gmail.com>
Subject: [PATCH] Documentation: kdump: fix minor typo
Date: Tue, 14 May 2019 19:17:25 +0300
Message-Id: <20190514161724.16604-1-cengizc@gmail.com>
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
Cc: cengizc@gmail.com, linux-doc@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>

kdump.txt had a minor typo.

Signed-off-by: Cengiz Can <cengizc@gmail.com>
---
 Documentation/kdump/kdump.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
index 51814450a7f8..3162eeb8c262 100644
--- a/Documentation/kdump/kdump.txt
+++ b/Documentation/kdump/kdump.txt
@@ -410,7 +410,7 @@ Notes on loading the dump-capture kernel:
 * Boot parameter "1" boots the dump-capture kernel into single-user
   mode without networking. If you want networking, use "3".
 
-* We generally don' have to bring up a SMP kernel just to capture the
+* We generally don't have to bring up a SMP kernel just to capture the
   dump. Hence generally it is useful either to build a UP dump-capture
   kernel or specify maxcpus=1 option while loading dump-capture kernel.
   Note, though maxcpus always works, you had better replace it with
-- 
2.21.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
