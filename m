Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-Id: <115373b6ac68ee7a305975896e1c4971e8e51d4c.1408731991.git.geoff@infradead.org>
In-Reply-To: <cover.1408731991.git.geoff@infradead.org>
References: <cover.1408731991.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 1/5] kexec: Fix make headers_check
Date: Fri, 22 Aug 2014 18:39:47 +0000
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
To: Eric Biederman <ebiederm@xmission.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew Morton <akpm@linux-foundation.org>, kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org

Remove the unneded declaration for a kexec_load() routine.

Fixes errors like these when running 'make headers_check':

include/uapi/linux/kexec.h: userspace cannot reference function or variable defined in the kernel

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 include/uapi/linux/kexec.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
index 6925f5b..99048e5 100644
--- a/include/uapi/linux/kexec.h
+++ b/include/uapi/linux/kexec.h
@@ -55,12 +55,6 @@ struct kexec_segment {
 	size_t memsz;
 };
 
-/* Load a new kernel image as described by the kexec_segment array
- * consisting of passed number of segments at the entry-point address.
- * The flags allow different useage types.
- */
-extern int kexec_load(void *, size_t, struct kexec_segment *,
-		unsigned long int);
 #endif /* __KERNEL__ */
 
 #endif /* _UAPILINUX_KEXEC_H */
-- 
1.9.1



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
