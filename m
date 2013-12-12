Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Message-Id: <868c991fa6d0f1e7c411626a9bb8c7785a6a46f1.1386807069.git.geoff@infradead.org>
In-Reply-To: <cover.1386807069.git.geoff@infradead.org>
References: <cover.1386807069.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 3/4] powerpc/kexec: Use global IND_FLAGS macro
Date: Thu, 12 Dec 2013 00:18:56 +0000
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
To: Eric Biederman <ebiederm@xmission.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>

linux/kexec.h now defines an IND_FLAGS macro.  Remove the local powerpc
definition and use the generic one.

Signed-off-by: Geoff Levand <geoff@infradead.org> for Huawei, Linaro
---
 arch/powerpc/kernel/machine_kexec_64.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index be4e6d6..1fab1f0 100644
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
1.8.1.2



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
