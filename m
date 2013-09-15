Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from georges.telenet-ops.be ([195.130.137.68])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VL8kY-0002M3-4m
 for kexec@lists.infradead.org; Sun, 15 Sep 2013 09:36:15 +0000
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH TRIVIAL] kexec: Typo s/the/then/
Date: Sun, 15 Sep 2013 11:35:37 +0200
Message-Id: <1379237737-3070-1-git-send-email-geert@linux-m68k.org>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Eric Biederman <ebiederm@xmission.com>, Jiri Kosina <trivial@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 kernel/kexec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 2a74f30..490afc0 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -921,7 +921,7 @@ static int kimage_load_segment(struct kimage *image,
  *   reinitialize them.
  *
  * - A machine specific part that includes the syscall number
- *   and the copies the image to it's final destination.  And
+ *   and then copies the image to it's final destination.  And
  *   jumps into the image at entry.
  *
  * kexec does not sync, or unmount filesystems so if you need
-- 
1.7.9.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
