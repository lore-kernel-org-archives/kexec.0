Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cjMEt-00011a-Oq
 for kexec@lists.infradead.org; Thu, 02 Mar 2017 08:37:33 +0000
Received: by mail-pf0-f172.google.com with SMTP id x66so20142851pfb.3
 for <kexec@lists.infradead.org>; Thu, 02 Mar 2017 00:37:11 -0800 (PST)
From: Pratyush Anand <panand@redhat.com>
Subject: [Makedumpfile Patch v3 3/7] x86_64: check physical address in PT_LOAD
 for none direct mapped regions
Date: Thu,  2 Mar 2017 14:06:48 +0530
Message-Id: <1999b01b2b55ef3b8f3c7676b143602279f74f7f.1488443170.git.panand@redhat.com>
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
Cc: Pratyush Anand <panand@redhat.com>, dyoung@redhat.com, kexec@lists.infradead.org, bhe@redhat.com

A kcore PT_LOAD can have a section from vmalloc region. However,
physical address in that header would be invalid (-1) after kernel
commit 464920104bf7 (/proc/kcore: update physical address for kcore ram
and text). Therefore, check for valid physical address while calculating
page_offset or phys_offset.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/x86_64.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86_64.c b/arch/x86_64.c
index 893cd516fc8b..e978a36f8878 100644
--- a/arch/x86_64.c
+++ b/arch/x86_64.c
@@ -41,7 +41,8 @@ get_page_offset_x86_64(void)
 	unsigned long long virt_start;
 
 	for (i = 0; get_pt_load(i, &phys_start, NULL, &virt_start, NULL); i++) {
-		if (virt_start < __START_KERNEL_map) {
+		if (virt_start < __START_KERNEL_map
+				&& phys_start != NOT_PADDR) {
 			info->page_offset = virt_start - phys_start;
 			return TRUE;
 		}
@@ -76,7 +77,8 @@ get_phys_base_x86_64(void)
 	}
 
 	for (i = 0; get_pt_load(i, &phys_start, NULL, &virt_start, NULL); i++) {
-		if (virt_start >= __START_KERNEL_map) {
+		if (virt_start >= __START_KERNEL_map
+				&& phys_start != NOT_PADDR) {
 
 			info->phys_base = phys_start -
 			    (virt_start & ~(__START_KERNEL_map));
-- 
2.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
