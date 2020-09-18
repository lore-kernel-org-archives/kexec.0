Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3/4] mm: remove compat_sys_move_pages
Date: Fri, 18 Sep 2020 15:24:38 +0200
Message-Id: <20200918132439.1475479-4-arnd@arndb.de>
In-Reply-To: <20200918132439.1475479-1-arnd@arndb.de>
References: <20200918132439.1475479-1-arnd@arndb.de>
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
To: Christoph Hellwig <hch@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org

The compat move_pages() implementation uses compat_alloc_user_space()
for converting the pointer array. Moving the compat handling into
the function itself is a bit simpler and lets us avoid the
compat_alloc_user_space() call.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/unistd32.h         |  2 +-
 arch/mips/kernel/syscalls/syscall_n32.tbl |  2 +-
 arch/mips/kernel/syscalls/syscall_o32.tbl |  2 +-
 arch/parisc/kernel/syscalls/syscall.tbl   |  2 +-
 arch/powerpc/kernel/syscalls/syscall.tbl  |  2 +-
 arch/s390/kernel/syscalls/syscall.tbl     |  2 +-
 arch/sparc/kernel/syscalls/syscall.tbl    |  2 +-
 arch/x86/entry/syscalls/syscall_32.tbl    |  2 +-
 arch/x86/entry/syscalls/syscall_64.tbl    |  2 +-
 include/linux/compat.h                    |  5 ---
 include/uapi/asm-generic/unistd.h         |  2 +-
 kernel/sys_ni.c                           |  1 -
 mm/migrate.c                              | 45 +++++++++++------------
 13 files changed, 32 insertions(+), 39 deletions(-)

diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index b6517df74037..af793775ba98 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -699,7 +699,7 @@ __SYSCALL(__NR_tee, sys_tee)
 #define __NR_vmsplice 343
 __SYSCALL(__NR_vmsplice, compat_sys_vmsplice)
 #define __NR_move_pages 344
-__SYSCALL(__NR_move_pages, compat_sys_move_pages)
+__SYSCALL(__NR_move_pages, sys_move_pages)
 #define __NR_getcpu 345
 __SYSCALL(__NR_getcpu, sys_getcpu)
 #define __NR_epoll_pwait 346
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index ad157aab4c09..7fa1ca45e44c 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -279,7 +279,7 @@
 268	n32	sync_file_range			sys_sync_file_range
 269	n32	tee				sys_tee
 270	n32	vmsplice			compat_sys_vmsplice
-271	n32	move_pages			compat_sys_move_pages
+271	n32	move_pages			sys_move_pages
 272	n32	set_robust_list			compat_sys_set_robust_list
 273	n32	get_robust_list			compat_sys_get_robust_list
 274	n32	kexec_load			sys_kexec_load
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 57baf6c8008f..194c7fbeedf7 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -319,7 +319,7 @@
 305	o32	sync_file_range			sys_sync_file_range		sys32_sync_file_range
 306	o32	tee				sys_tee
 307	o32	vmsplice			sys_vmsplice			compat_sys_vmsplice
-308	o32	move_pages			sys_move_pages			compat_sys_move_pages
+308	o32	move_pages			sys_move_pages
 309	o32	set_robust_list			sys_set_robust_list		compat_sys_set_robust_list
 310	o32	get_robust_list			sys_get_robust_list		compat_sys_get_robust_list
 311	o32	kexec_load			sys_kexec_load
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 778bf166d7bd..5c17edaffe70 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -331,7 +331,7 @@
 292	64	sync_file_range		sys_sync_file_range
 293	common	tee			sys_tee
 294	common	vmsplice		sys_vmsplice			compat_sys_vmsplice
-295	common	move_pages		sys_move_pages			compat_sys_move_pages
+295	common	move_pages		sys_move_pages
 296	common	getcpu			sys_getcpu
 297	common	epoll_pwait		sys_epoll_pwait			compat_sys_epoll_pwait
 298	common	statfs64		sys_statfs64			compat_sys_statfs64
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index f128ba8b9a71..04fb42d7b377 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -389,7 +389,7 @@
 298	common	faccessat			sys_faccessat
 299	common	get_robust_list			sys_get_robust_list		compat_sys_get_robust_list
 300	common	set_robust_list			sys_set_robust_list		compat_sys_set_robust_list
-301	common	move_pages			sys_move_pages			compat_sys_move_pages
+301	common	move_pages			sys_move_pages
 302	common	getcpu				sys_getcpu
 303	nospu	epoll_pwait			sys_epoll_pwait			compat_sys_epoll_pwait
 304	32	utimensat			sys_utimensat_time32
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index d45952058be2..3197965d45e9 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -317,7 +317,7 @@
 307  common	sync_file_range		sys_sync_file_range		compat_sys_s390_sync_file_range
 308  common	tee			sys_tee				sys_tee
 309  common	vmsplice		sys_vmsplice			compat_sys_vmsplice
-310  common	move_pages		sys_move_pages			compat_sys_move_pages
+310  common	move_pages		sys_move_pages
 311  common	getcpu			sys_getcpu			sys_getcpu
 312  common	epoll_pwait		sys_epoll_pwait			compat_sys_epoll_pwait
 313  common	utimes			sys_utimes			sys_utimes_time32
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index a46edcdd950d..e36ac364e61a 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -370,7 +370,7 @@
 304	common	get_mempolicy		sys_get_mempolicy		compat_sys_get_mempolicy
 305	common	set_mempolicy		sys_set_mempolicy		compat_sys_set_mempolicy
 306	common	kexec_load		sys_kexec_load			sys_kexec_load
-307	common	move_pages		sys_move_pages			compat_sys_move_pages
+307	common	move_pages		sys_move_pages
 308	common	getcpu			sys_getcpu
 309	common	epoll_pwait		sys_epoll_pwait			compat_sys_epoll_pwait
 310	32	utimensat		sys_utimensat_time32
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 7e4140b78aad..b3263b8b2eae 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -328,7 +328,7 @@
 314	i386	sync_file_range		sys_ia32_sync_file_range
 315	i386	tee			sys_tee
 316	i386	vmsplice		sys_vmsplice			compat_sys_vmsplice
-317	i386	move_pages		sys_move_pages			compat_sys_move_pages
+317	i386	move_pages		sys_move_pages
 318	i386	getcpu			sys_getcpu
 319	i386	epoll_pwait		sys_epoll_pwait
 320	i386	utimensat		sys_utimensat_time32
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 9986f5f08278..4a997a0cbf47 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -389,7 +389,7 @@
 530	x32	set_robust_list		compat_sys_set_robust_list
 531	x32	get_robust_list		compat_sys_get_robust_list
 532	x32	vmsplice		compat_sys_vmsplice
-533	x32	move_pages		compat_sys_move_pages
+533	x32	move_pages		sys_move_pages
 534	x32	preadv			compat_sys_preadv64
 535	x32	pwritev			compat_sys_pwritev64
 536	x32	rt_tgsigqueueinfo	compat_sys_rt_tgsigqueueinfo
diff --git a/include/linux/compat.h b/include/linux/compat.h
index a7a5a0ff59ef..db1d7ac2c9e0 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -763,11 +763,6 @@ asmlinkage long compat_sys_set_mempolicy(int mode, compat_ulong_t __user *nmask,
 asmlinkage long compat_sys_migrate_pages(compat_pid_t pid,
 		compat_ulong_t maxnode, const compat_ulong_t __user *old_nodes,
 		const compat_ulong_t __user *new_nodes);
-asmlinkage long compat_sys_move_pages(pid_t pid, compat_ulong_t nr_pages,
-				      __u32 __user *pages,
-				      const int __user *nodes,
-				      int __user *status,
-				      int flags);
 
 asmlinkage long compat_sys_rt_tgsigqueueinfo(compat_pid_t tgid,
 					compat_pid_t pid, int sig,
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 83f1fc7fd3d7..4da51702fb21 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -681,7 +681,7 @@ __SC_COMP(__NR_set_mempolicy, sys_set_mempolicy, compat_sys_set_mempolicy)
 #define __NR_migrate_pages 238
 __SC_COMP(__NR_migrate_pages, sys_migrate_pages, compat_sys_migrate_pages)
 #define __NR_move_pages 239
-__SC_COMP(__NR_move_pages, sys_move_pages, compat_sys_move_pages)
+__SYSCALL(__NR_move_pages, sys_move_pages)
 #endif
 
 #define __NR_rt_tgsigqueueinfo 240
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index c925d1e1777e..783a24ceee88 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -290,7 +290,6 @@ COND_SYSCALL_COMPAT(set_mempolicy);
 COND_SYSCALL(migrate_pages);
 COND_SYSCALL_COMPAT(migrate_pages);
 COND_SYSCALL(move_pages);
-COND_SYSCALL_COMPAT(move_pages);
 
 COND_SYSCALL(perf_event_open);
 COND_SYSCALL(accept4);
diff --git a/mm/migrate.c b/mm/migrate.c
index 34a842a8eb6a..e9dfbde5f12c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1835,6 +1835,27 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
 	mmap_read_unlock(mm);
 }
 
+static int put_pages_array(const void __user *chunk_pages[],
+			   const void __user * __user *pages,
+			   unsigned long chunk_nr)
+{
+	compat_uptr_t __user *pages32 = (compat_uptr_t __user *)pages;
+	compat_uptr_t p;
+	int i;
+
+	if (!in_compat_syscall())
+		return copy_from_user(chunk_pages, pages,
+				      chunk_nr * sizeof(*chunk_pages));
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
@@ -1854,7 +1875,7 @@ static int do_pages_stat(struct mm_struct *mm, unsigned long nr_pages,
 		if (chunk_nr > DO_PAGES_STAT_CHUNK_NR)
 			chunk_nr = DO_PAGES_STAT_CHUNK_NR;
 
-		if (copy_from_user(chunk_pages, pages, chunk_nr * sizeof(*chunk_pages)))
+		if (put_pages_array(chunk_pages, pages, chunk_nr))
 			break;
 
 		do_pages_stat_array(mm, chunk_nr, chunk_pages, chunk_status);
@@ -1943,28 +1964,6 @@ SYSCALL_DEFINE6(move_pages, pid_t, pid, unsigned long, nr_pages,
 	return kernel_move_pages(pid, nr_pages, pages, nodes, status, flags);
 }
 
-#ifdef CONFIG_COMPAT
-COMPAT_SYSCALL_DEFINE6(move_pages, pid_t, pid, compat_ulong_t, nr_pages,
-		       compat_uptr_t __user *, pages32,
-		       const int __user *, nodes,
-		       int __user *, status,
-		       int, flags)
-{
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
-}
-#endif /* CONFIG_COMPAT */
-
 #ifdef CONFIG_NUMA_BALANCING
 /*
  * Returns true if this is a safe migration target node for misplaced NUMA
-- 
2.27.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
