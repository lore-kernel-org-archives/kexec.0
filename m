Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-Id: <adf97d602657c72f6ee59aefe5d51149159a3e99.1412640584.git.geoff@infradead.org>
In-Reply-To: <cover.1412640584.git.geoff@infradead.org>
References: <cover.1412640584.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH V25/5] powerpc/kexec: Use global IND_FLAGS macro
Date: Tue, 07 Oct 2014 00:21:30 +0000
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, linux-kernel@vger.kernel.org

linux/kexec.h now defines an IND_FLAGS macro.  Remove the local powerpc
definition and use the generic one.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/powerpc/kernel/machine_kexec_64.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index 879b3aa..75652a32 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -96,8 +96,6 @@ int default_machine_kexec_prepare(struct kimage *image)
 	return 0;
 }
 
-#define IND_FLAGS (IND_DESTINATION | IND_INDIRECTION | IND_DONE | IND_SOURCE)
-
 static void copy_segments(unsigned long ind)
 {
 	unsigned long entry;
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
