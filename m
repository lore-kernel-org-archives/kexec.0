Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7ygG-0002lw-A3
 for kexec@lists.infradead.org; Tue, 18 Aug 2020 10:17:26 +0000
From: Jinyang He <hejinyang@loongson.cn>
Subject: [PATCH] README: Add the necessary method about elfutils
Date: Tue, 18 Aug 2020 18:10:23 +0800
Message-Id: <1597745423-10295-1-git-send-email-hejinyang@loongson.cn>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Kazuhito Hagio <k-hagio-ab@nec.com>, kexec-ml <kexec@lists.infradead.org>

In dwarf_info.c: 20, #include <elfutils/libdwfl.h>

Signed-off-by: Jinyang He <hejinyang@loongson.cn>
---
 README | 1 +
 1 file changed, 1 insertion(+)

diff --git a/README b/README
index f83717f..f69fe43 100644
--- a/README
+++ b/README
@@ -18,6 +18,7 @@
      #
      # mkdir /usr/local/include/elfutils/
      # cp ./libdw/libdw.h   /usr/local/include/elfutils/libdw.h
+     # cp ./libdwfl/libdwfl.h /usr/local/include/elfutils/libdwfl.h
      # cp ./libdw/dwarf.h   /usr/local/include/dwarf.h
      # cp ./libelf/libelf.h /usr/local/include/libelf.h
      # cp ./libelf/gelf.h   /usr/local/include/gelf.h
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
