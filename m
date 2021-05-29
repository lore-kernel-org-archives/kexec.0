Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmwkk-0052N4-Nv
 for kexec@lists.infradead.org; Sat, 29 May 2021 11:03:41 +0000
From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 2/4] kgdb: Fix spelling mistakes
Date: Sat, 29 May 2021 19:03:03 +0800
Message-ID: <20210529110305.9446-3-thunder.leizhen@huawei.com>
In-Reply-To: <20210529110305.9446-1-thunder.leizhen@huawei.com>
References: <20210529110305.9446-1-thunder.leizhen@huawei.com>
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
To: Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <daniel.thompson@linaro.org>, Douglas Anderson <dianders@chromium.org>, Balbir Singh <bsingharora@gmail.com>, Barry Song <song.bao.hua@hisilicon.com>, Christoph Hellwig <hch@lst.de>, Marek
 Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, Eric Biederman <ebiederm@xmission.com>, "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, Masami Hiramatsu <mhiramat@kernel.org>, Jessica Yu <jeyu@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, Oleg Nesterov <oleg@redhat.com>, John Stultz <john.stultz@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, kgdb-bugreport <kgdb-bugreport@lists.sourceforge.net>, kexec <kexec@lists.infradead.org>, linux-crypto <linux-crypto@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>

Fix some spelling mistakes in comments:
initalization ==> initialization
detatch ==> detach
represntation ==> representation
hexidecimal ==> hexadecimal
delimeter ==> delimiter
architecure ==> architecture

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 include/linux/kgdb.h           | 8 ++++----
 kernel/debug/debug_core.c      | 2 +-
 kernel/debug/kdb/kdb_main.c    | 8 ++++----
 kernel/debug/kdb/kdb_private.h | 2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index 392a3670944c..258cdde8d356 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -105,9 +105,9 @@ extern int dbg_set_reg(int regno, void *mem, struct pt_regs *regs);
  */
 
 /**
- *	kgdb_arch_init - Perform any architecture specific initalization.
+ *	kgdb_arch_init - Perform any architecture specific initialization.
  *
- *	This function will handle the initalization of any architecture
+ *	This function will handle the initialization of any architecture
  *	specific callbacks.
  */
 extern int kgdb_arch_init(void);
@@ -229,9 +229,9 @@ extern int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt);
 extern int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt);
 
 /**
- *	kgdb_arch_late - Perform any architecture specific initalization.
+ *	kgdb_arch_late - Perform any architecture specific initialization.
  *
- *	This function will handle the late initalization of any
+ *	This function will handle the late initialization of any
  *	architecture specific callbacks.  This is an optional function for
  *	handling things like late initialization of hw breakpoints.  The
  *	default implementation does nothing.
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 4708aec492df..a1f26766eb90 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -1032,7 +1032,7 @@ dbg_notify_reboot(struct notifier_block *this, unsigned long code, void *x)
 	/*
 	 * Take the following action on reboot notify depending on value:
 	 *    1 == Enter debugger
-	 *    0 == [the default] detatch debug client
+	 *    0 == [the default] detach debug client
 	 *   -1 == Do nothing... and use this until the board resets
 	 */
 	switch (kgdbreboot) {
diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 622410c45da1..d8ee5647b732 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -253,7 +253,7 @@ static char *kdballocenv(size_t bytes)
  * Parameters:
  *	match	A character string representing a numeric value
  * Outputs:
- *	*value  the unsigned long represntation of the env variable 'match'
+ *	*value  the unsigned long representation of the env variable 'match'
  * Returns:
  *	Zero on success, a kdb diagnostic on failure.
  */
@@ -356,7 +356,7 @@ static void kdb_printenv(void)
  * Parameters:
  *	arg	A character string representing a numeric value
  * Outputs:
- *	*value  the unsigned long represntation of arg.
+ *	*value  the unsigned long representation of arg.
  * Returns:
  *	Zero on success, a kdb diagnostic on failure.
  */
@@ -470,7 +470,7 @@ static int kdb_check_regs(void)
  *	symbol name, and offset to the caller.
  *
  *	The argument may consist of a numeric value (decimal or
- *	hexidecimal), a symbol name, a register name (preceded by the
+ *	hexadecimal), a symbol name, a register name (preceded by the
  *	percent sign), an environment variable with a numeric value
  *	(preceded by a dollar sign) or a simple arithmetic expression
  *	consisting of a symbol name, +/-, and a numeric constant value
@@ -894,7 +894,7 @@ static void parse_grep(const char *str)
  *	Limited to 20 tokens.
  *
  *	Real rudimentary tokenization. Basically only whitespace
- *	is considered a token delimeter (but special consideration
+ *	is considered a token delimiter (but special consideration
  *	is taken of the '=' sign as used by the 'set' command).
  *
  *	The algorithm used to tokenize the input string relies on
diff --git a/kernel/debug/kdb/kdb_private.h b/kernel/debug/kdb/kdb_private.h
index ccbed9089808..170c69aedebb 100644
--- a/kernel/debug/kdb/kdb_private.h
+++ b/kernel/debug/kdb/kdb_private.h
@@ -64,7 +64,7 @@
 
 /*
  * KDB_MAXBPT describes the total number of breakpoints
- * supported by this architecure.
+ * supported by this architecture.
  */
 #define KDB_MAXBPT	16
 
-- 
2.25.1



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
