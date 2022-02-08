From: Tiezhu Yang <yangtiezhu@loongson.cn>
Date: Tue,  8 Feb 2022 20:51:06 +0800
Subject: [PATCH v2 5/5] kasan: no need to unset panic_on_warn in end_report()
In-Reply-To: <1644324666-15947-1-git-send-email-yangtiezhu@loongson.cn>
References: <1644324666-15947-1-git-send-email-yangtiezhu@loongson.cn>
Message-ID: <1644324666-15947-6-git-send-email-yangtiezhu@loongson.cn>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

panic_on_warn is unset inside panic(), so no need to unset it
before calling panic() in end_report().

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 mm/kasan/report.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 3ad9624..f141465 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -117,16 +117,8 @@ static void end_report(unsigned long *flags, unsigned long addr)
 	pr_err("==================================================================\n");
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 	spin_unlock_irqrestore(&report_lock, *flags);
-	if (panic_on_warn && !test_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags)) {
-		/*
-		 * This thread may hit another WARN() in the panic path.
-		 * Resetting this prevents additional WARN() from panicking the
-		 * system on this thread.  Other threads are blocked by the
-		 * panic_mutex in panic().
-		 */
-		panic_on_warn = 0;
+	if (panic_on_warn && !test_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags))
 		panic("panic_on_warn set ...\n");
-	}
 	if (kasan_arg_fault == KASAN_ARG_FAULT_PANIC)
 		panic("kasan.fault=panic set ...\n");
 	kasan_enable_current();
-- 
2.1.0


