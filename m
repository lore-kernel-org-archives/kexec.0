Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2120.oracle.com ([141.146.126.78])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRLsz-004vYb-Si
 for kexec@lists.infradead.org; Tue, 30 Mar 2021 21:26:56 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC v2 13/43] PKRAM: free the preserved ranges list
Date: Tue, 30 Mar 2021 14:35:48 -0700
Message-Id: <1617140178-8773-14-git-send-email-anthony.yznaga@oracle.com>
In-Reply-To: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
References: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
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
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: willy@infradead.org, corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, rppt@kernel.org, akpm@linux-foundation.org, hughd@google.com, ebiederm@xmission.com, keescook@chromium.org, ardb@kernel.org, nivedita@alum.mit.edu, jroedel@suse.de, masahiroy@kernel.org, nathan@kernel.org, terrelln@fb.com, vincenzo.frascino@arm.com, martin.b.radev@gmail.com, andreyknvl@google.com, daniel.kiper@oracle.com, rafael.j.wysocki@intel.com, dan.j.williams@intel.com, Jonathan.Cameron@huawei.com, bhe@redhat.com, rminnich@gmail.com, ashish.kalra@amd.com, guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org, iamjoonsoo.kim@lge.com, vbabka@suse.cz, alex.shi@linux.alibaba.com, david@redhat.com, richard.weiyang@gmail.com, vdavydov.dev@gmail.com, graf@amazon.com, jason.zeng@intel.com, lei.l.li@intel.com, daniel.m.jordan@oracle.com, steven.sistare@oracle.com, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, kexec@lists.infradead.org

Free the pages used to pass the preserved ranges to the new boot.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 arch/x86/mm/init_64.c |  1 +
 include/linux/pkram.h |  2 ++
 mm/pkram.c            | 20 ++++++++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 8efb2fb2a88b..69bd71996b8b 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1294,6 +1294,7 @@ void __init mem_init(void)
 	after_bootmem = 1;
 	x86_init.hyper.init_after_bootmem();
 
+	pkram_cleanup();
 	totalram_pages_add(pkram_reserved_pages);
 	/*
 	 * Must be done after boot memory is put on freelist, because here we
diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index 8d3d780d9fe1..c2099a4f2004 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -102,9 +102,11 @@ int pkram_prepare_save(struct pkram_stream *ps, const char *name,
 #ifdef CONFIG_PKRAM
 extern unsigned long pkram_reserved_pages;
 void pkram_reserve(void);
+void pkram_cleanup(void);
 #else
 #define pkram_reserved_pages 0UL
 static inline void pkram_reserve(void) { }
+static inline void pkram_cleanup(void) { }
 #endif
 
 #endif /* _LINUX_PKRAM_H */
diff --git a/mm/pkram.c b/mm/pkram.c
index 03731bb6af26..dab6657080bf 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -1434,3 +1434,23 @@ int __init pkram_merge_with_reserved(void)
 
 	return 0;
 }
+
+void __init pkram_cleanup(void)
+{
+	struct pkram_region_list *rl;
+	unsigned long next_pfn;
+
+	if (!pkram_sb || !pkram_reserved_pages)
+		return;
+
+	next_pfn = pkram_sb->region_list_pfn;
+
+	while (next_pfn) {
+		struct page *page = pfn_to_page(next_pfn);
+
+		rl = pfn_to_kaddr(next_pfn);
+		next_pfn = rl->next_pfn;
+		__free_pages_core(page, 0);
+		pkram_reserved_pages--;
+	}
+}
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
