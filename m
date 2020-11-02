Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH v2 2/4] mm: simplify compat_sys_move_pages
Date: Mon,  2 Nov 2020 13:31:49 +0100
Message-Id: <20201102123151.2860165-3-arnd@kernel.org>
In-Reply-To: <20201102123151.2860165-1-arnd@kernel.org>
References: <20201102123151.2860165-1-arnd@kernel.org>
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
To: linux-arch@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org, Borislav Petkov <bp@alien8.de>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>

From: Arnd Bergmann <arnd@arndb.de>

The compat move_pages() implementation uses compat_alloc_user_space()
for converting the pointer array. Moving the compat handling into
the function itself is a bit simpler and lets us avoid the
compat_alloc_user_space() call.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/migrate.c | 45 ++++++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 5ca5842df5db..016e39809ca5 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1830,6 +1830,23 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
 	mmap_read_unlock(mm);
 }
 
+static int put_compat_pages_array(const void __user *chunk_pages[],
+				  const void __user * __user *pages,
+				  unsigned long chunk_nr)
+{
+	compat_uptr_t __user *pages32 = (compat_uptr_t __user *)pages;
+	compat_uptr_t p;
+	int i;
+
+	for (i = 0; i < chunk_nr; i++) {
+		if (get_user(p, pages32 + i))
+			return -EFAULT;
+		chunk_pages[i] = compat_ptr(p);
+	}
+
+	return 0;
+}
+
 /*
  * Determine the nodes of a user array of pages and store it in
  * a user array of status.
@@ -1849,8 +1866,15 @@ static int do_pages_stat(struct mm_struct *mm, unsigned long nr_pages,
 		if (chunk_nr > DO_PAGES_STAT_CHUNK_NR)
 			chunk_nr = DO_PAGES_STAT_CHUNK_NR;
 
-		if (copy_from_user(chunk_pages, pages, chunk_nr * sizeof(*chunk_pages)))
-			break;
+		if (in_compat_syscall()) {
+			if (put_compat_pages_array(chunk_pages, pages,
+						   chunk_nr))
+				break;
+		} else {
+			if (copy_from_user(chunk_pages, pages,
+				      chunk_nr * sizeof(*chunk_pages)))
+				break;
+		}
 
 		do_pages_stat_array(mm, chunk_nr, chunk_pages, chunk_status);
 
@@ -1955,23 +1979,14 @@ SYSCALL_DEFINE6(move_pages, pid_t, pid, unsigned long, nr_pages,
 
 #ifdef CONFIG_COMPAT
 COMPAT_SYSCALL_DEFINE6(move_pages, pid_t, pid, compat_ulong_t, nr_pages,
-		       compat_uptr_t __user *, pages32,
+		       compat_uptr_t __user *, pages,
 		       const int __user *, nodes,
 		       int __user *, status,
 		       int, flags)
 {
-	const void __user * __user *pages;
-	int i;
-
-	pages = compat_alloc_user_space(nr_pages * sizeof(void *));
-	for (i = 0; i < nr_pages; i++) {
-		compat_uptr_t p;
-
-		if (get_user(p, pages32 + i) ||
-			put_user(compat_ptr(p), pages + i))
-			return -EFAULT;
-	}
-	return kernel_move_pages(pid, nr_pages, pages, nodes, status, flags);
+	return kernel_move_pages(pid, nr_pages,
+				 (const void __user *__user *)pages,
+				 nodes, status, flags);
 }
 #endif /* CONFIG_COMPAT */
 
-- 
2.27.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
