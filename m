Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1ciaiu-0006X9-Vd
 for kexec@lists.infradead.org; Tue, 28 Feb 2017 05:53:22 +0000
Received: by mail-pg0-f51.google.com with SMTP id b129so1292106pgc.2
 for <kexec@lists.infradead.org>; Mon, 27 Feb 2017 21:53:00 -0800 (PST)
From: Pratyush Anand <panand@redhat.com>
Subject: [Makedumpfile Patch v2 5/7] makedumpfile: Correct the calculation of
 kvaddr in set_kcore_vmcoreinfo
Date: Tue, 28 Feb 2017 11:22:39 +0530
Message-Id: <908b22c0458c7c9b4fb945e53d66dc12e5c44e83.1488260510.git.panand@redhat.com>
In-Reply-To: <cover.1488260510.git.panand@redhat.com>
References: <cover.1488260510.git.panand@redhat.com>
In-Reply-To: <cover.1488260510.git.panand@redhat.com>
References: <cover.1488260510.git.panand@redhat.com>
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

When mm sections kaslr is not enabled, this is correct since the starting
address of direct mapping section is 0xffff880000000000 which 1T aligned.
Usually system with memory below 1T won't cause problem.

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
