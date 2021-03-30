Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2120.oracle.com ([156.151.31.85])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRLtK-004vcM-8E
 for kexec@lists.infradead.org; Tue, 30 Mar 2021 21:27:17 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC v2 22/43] x86/boot/compressed/64: use 1GB pages for mappings
Date: Tue, 30 Mar 2021 14:35:57 -0700
Message-Id: <1617140178-8773-23-git-send-email-anthony.yznaga@oracle.com>
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

pkram kaslr code can incur multiple page faults when it walks its
preserved ranges list called via mem_avoid_overlap().  The multiple
faults can easily end up using up the small number of pages available
to be allocated for page table pages.

This patch hacks things so that mappings are 1GB which results in the need
for far fewer page table pages.  As is this breaks AMD SEV-ES which expects
the mappings to be 2M.  This could possibly be fixed by updating split
code to split 1GB page if the aren't any other issues with using 1GB
mappings.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 arch/x86/boot/compressed/ident_map_64.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index f7213d0943b8..6ff02da4cc1a 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -95,8 +95,8 @@ static void add_identity_map(unsigned long start, unsigned long end)
 	int ret;
 
 	/* Align boundary to 2M. */
-	start = round_down(start, PMD_SIZE);
-	end = round_up(end, PMD_SIZE);
+	start = round_down(start, PUD_SIZE);
+	end = round_up(end, PUD_SIZE);
 	if (start >= end)
 		return;
 
@@ -119,6 +119,7 @@ void initialize_identity_maps(void *rmode)
 	mapping_info.context = &pgt_data;
 	mapping_info.page_flag = __PAGE_KERNEL_LARGE_EXEC | sme_me_mask;
 	mapping_info.kernpg_flag = _KERNPG_TABLE;
+	mapping_info.direct_gbpages = true;
 
 	/*
 	 * It should be impossible for this not to already be true,
@@ -329,8 +330,8 @@ void do_boot_page_fault(struct pt_regs *regs, unsigned long error_code)
 
 	ghcb_fault = sev_es_check_ghcb_fault(address);
 
-	address   &= PMD_MASK;
-	end        = address + PMD_SIZE;
+	address   &= PUD_MASK;
+	end        = address + PUD_SIZE;
 
 	/*
 	 * Check for unexpected error codes. Unexpected are:
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
