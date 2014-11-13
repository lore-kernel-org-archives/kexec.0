Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-Id: <16c283c151e746dc4f8ae6755eac5afb27d53647.1415837218.git.geoff@infradead.org>
In-Reply-To: <cover.1415837218.git.geoff@infradead.org>
References: <cover.1415837218.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH V3 2/4] kexec: Simplify conditional
Date: Thu, 13 Nov 2014 00:19:32 +0000
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, linux-kernel@vger.kernel.org

Simplify the code around one of the conditionals in the kexec_load
syscall routine.

The original code was confusing with a redundant check on KEXEC_ON_CRASH
and comments outside of the conditional block.  This change switches the
order of the conditional check, and cleans up the comments for the
conditional.  There is no functional change to the code.

Signed-off-by: Geoff Levand <geoff@infradead.org>
Acked-by: Vivek Goyal <vgoyal@redhat.com>
---
 kernel/kexec.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 2abf9f6..650fcba 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1288,19 +1288,22 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
 	if (nr_segments > 0) {
 		unsigned long i;
 
-		/* Loading another kernel to reboot into */
-		if ((flags & KEXEC_ON_CRASH) == 0)
-			result = kimage_alloc_init(&image, entry, nr_segments,
-						   segments, flags);
-		/* Loading another kernel to switch to if this one crashes */
-		else if (flags & KEXEC_ON_CRASH) {
-			/* Free any current crash dump kernel before
+		if (flags & KEXEC_ON_CRASH) {
+			/*
+			 * Loading another kernel to switch to if this one
+			 * crashes.  Free any current crash dump kernel before
 			 * we corrupt it.
 			 */
+
 			kimage_free(xchg(&kexec_crash_image, NULL));
 			result = kimage_alloc_init(&image, entry, nr_segments,
 						   segments, flags);
 			crash_map_reserved_pages();
+		} else {
+			/* Loading another kernel to reboot into. */
+
+			result = kimage_alloc_init(&image, entry, nr_segments,
+						   segments, flags);
 		}
 		if (result)
 			goto out;
-- 
1.9.1



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
