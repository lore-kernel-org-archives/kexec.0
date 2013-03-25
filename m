Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UK4z4-0006fr-PS
 for kexec@lists.infradead.org; Mon, 25 Mar 2013 10:50:36 +0000
Received: by mail-pb0-f48.google.com with SMTP id wy12so4068934pbc.7
 for <kexec@lists.infradead.org>; Mon, 25 Mar 2013 03:50:30 -0700 (PDT)
From: Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH 1/1] On Documentation/kdump/kdump.txt,
 section Boot into System Kernel: On x86 and x86_64, use "crashkernel=64M@16M",
 but some OSes like ubuntu 12.10 use ram fs larger than 64M,
 so in these cases the memory reserved for crashkernel should be at least 128M.
Date: Mon, 25 Mar 2013 18:50:10 +0800
Message-Id: <1364208610-11409-1-git-send-email-yizhouzhou@ict.ac.cn>
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
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com, yizhouzhou@ict.ac.cn

From: root <root@zzy-Lenovo.(none)>


Signed-off-by: Zhouyi Zhou <yizhouzhou@ict.ac.cn>
---
 Documentation/kdump/kdump.txt |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
index 13f1aa0..1e850e0 100644
--- a/Documentation/kdump/kdump.txt
+++ b/Documentation/kdump/kdump.txt
@@ -290,7 +290,9 @@ Boot into System Kernel
    "crashkernel=64M@16M" tells the system kernel to reserve 64 MB of memory
    starting at physical address 0x01000000 (16MB) for the dump-capture kernel.
 
-   On x86 and x86_64, use "crashkernel=64M@16M".
+   On x86 and x86_64, use "crashkernel=64M@16M" (some OSes use init ram fs larger
+than 64M, for example ubuntu-12.10, use crashkernel=128M@16M instead, or dump-capture
+kernel will out of memory).
 
    On ppc64, use "crashkernel=128M@32M".
 
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
