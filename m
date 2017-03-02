Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cjMEx-00011j-RF
 for kexec@lists.infradead.org; Thu, 02 Mar 2017 08:37:38 +0000
Received: by mail-pf0-f171.google.com with SMTP id j5so20176659pfb.2
 for <kexec@lists.infradead.org>; Thu, 02 Mar 2017 00:37:17 -0800 (PST)
From: Pratyush Anand <panand@redhat.com>
Subject: [Makedumpfile Patch v3 5/7] makedumpfile: Correct the calculation of
 kvaddr in set_kcore_vmcoreinfo
Date: Thu,  2 Mar 2017 14:06:50 +0530
Message-Id: <60d2237114dea2d05892f25beb03a7d8ef8e9b3d.1488443170.git.panand@redhat.com>
In-Reply-To: <cover.1488443170.git.panand@redhat.com>
References: <cover.1488443170.git.panand@redhat.com>
In-Reply-To: <cover.1488443170.git.panand@redhat.com>
References: <cover.1488443170.git.panand@redhat.com>
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
To: ats-kumagai@wm.jp.nec.com
Cc: dyoung@redhat.com, kexec@lists.infradead.org, bhe@redhat.com

From: Baoquan He <bhe@redhat.com>

In set_kcore_vmcoreinfo, we calculate the virtual address of vmcoreinfo
by OR operation as below:

	kvaddr = (ulong)vmcoreinfo_addr | PAGE_OFFSET;

When mm sections kaslr is not enabled, this is correct since the
starting address of direct mapping section is 0xffff880000000000 which
is 1T aligned.  Usually system with memory below 1T won't cause problem.

However with mm section kaslr enabled, the starting address of direct
mapping is 1G aligned. The above code makes kvaddr unsure.

So change it to adding operation:
	kvaddr = (ulong)vmcoreinfo_addr + PAGE_OFFSET;

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 elf_info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/elf_info.c b/elf_info.c
index c5743b3cab28..100272f83c48 100644
--- a/elf_info.c
+++ b/elf_info.c
@@ -372,7 +372,7 @@ int set_kcore_vmcoreinfo(uint64_t vmcoreinfo_addr, uint64_t vmcoreinfo_len)
 	off_t offset_desc;
 
 	offset = UNINITIALIZED;
-	kvaddr = (ulong)vmcoreinfo_addr | PAGE_OFFSET;
+	kvaddr = (ulong)vmcoreinfo_addr + PAGE_OFFSET;
 
 	for (i = 0; i < num_pt_loads; ++i) {
 		struct pt_load_segment *p = &pt_loads[i];
-- 
2.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
