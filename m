Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fLarN-0007yW-O7
 for kexec@lists.infradead.org; Wed, 23 May 2018 20:59:51 +0000
Received: by mail-pl0-x242.google.com with SMTP id t12-v6so13746927plo.7
 for <kexec@lists.infradead.org>; Wed, 23 May 2018 13:59:39 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
Subject: [PATCH] vmcore-dmesg: fix infinite loop if log buffer wraps around
Date: Wed, 23 May 2018 13:59:31 -0700
Message-Id: <931590ebae2be0563ab6fdfa17c84111f393904b.1527108991.git.osandov@fb.com>
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
To: kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>
Cc: kernel-team@fb.com

From: Omar Sandoval <osandov@fb.com>

We hit a bug where vmcore-dmesg would get stuck in a loop, and since we
were redirecting the output to a file, it wouldn't stop until it filled
up the disk. This only happened when the dmesg buffer had filled up and
wrapped around. It turns out that when we hit the end of the buffer, we
are looping back to the first record instead of the beginning of the
buffer, which will always loop forever.

Fixes: e08d26b3b7f1 ("vmcore-dmesg: avoid allocating large memory chunk for log buf")
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 vmcore-dmesg/vmcore-dmesg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vmcore-dmesg/vmcore-dmesg.c b/vmcore-dmesg/vmcore-dmesg.c
index e340ef4..7972788 100644
--- a/vmcore-dmesg/vmcore-dmesg.c
+++ b/vmcore-dmesg/vmcore-dmesg.c
@@ -689,7 +689,7 @@ static void dump_dmesg_structured(int fd)
 		 */
 		loglen = struct_val_u16(buf, log_offset_len);
 		if (!loglen)
-			current_idx = log_first_idx;
+			current_idx = 0;
 		else
 			/* Move to next record */
 			current_idx += loglen;
-- 
2.9.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
