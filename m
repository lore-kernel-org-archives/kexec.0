Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Jisheng Zhang <jszhang@kernel.org>
Subject: [RFC PATCH 1/5] kexec: make crashk_res,
 crashk_low_res and crash_notes symbols always visible
Date: Fri,  3 Dec 2021 13:11:53 +0800
Message-Id: <20211203051157.2160-2-jszhang@kernel.org>
In-Reply-To: <20211203051157.2160-1-jszhang@kernel.org>
References: <20211203051157.2160-1-jszhang@kernel.org>
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
To: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, Will Deacon <will@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, hpa@zytor.com, Eric Biederman <ebiederm@xmission.com>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, kexec@lists.infradead.org

Make the forward declarations of crashk_res, crashk_low_res and
crash_notes always visible. Code referring to these symbols can then
just check for IS_ENABLED(CONFIG_KEXEC_CORE), instead of requiring
conditional compilation using an #ifdef, thus preparing to increase
compile coverage and simplify the code.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 include/linux/kexec.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 0c994ae37729..58d1b58a971e 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -20,6 +20,12 @@
 
 #include <uapi/linux/kexec.h>
 
+/* Location of a reserved region to hold the crash kernel.
+ */
+extern struct resource crashk_res;
+extern struct resource crashk_low_res;
+extern note_buf_t __percpu *crash_notes;
+
 #ifdef CONFIG_KEXEC_CORE
 #include <linux/list.h>
 #include <linux/compat.h>
@@ -350,12 +356,6 @@ extern int kexec_load_disabled;
 #define KEXEC_FILE_FLAGS	(KEXEC_FILE_UNLOAD | KEXEC_FILE_ON_CRASH | \
 				 KEXEC_FILE_NO_INITRAMFS)
 
-/* Location of a reserved region to hold the crash kernel.
- */
-extern struct resource crashk_res;
-extern struct resource crashk_low_res;
-extern note_buf_t __percpu *crash_notes;
-
 /* flag to track if kexec reboot is in progress */
 extern bool kexec_in_progress;
 
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
