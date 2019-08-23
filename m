Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i18Ke-0007oQ-Gf
 for kexec@lists.infradead.org; Fri, 23 Aug 2019 12:06:17 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH 2/4 v2] Fix an error definition about the variable 'fname'
Date: Fri, 23 Aug 2019 20:05:37 +0800
Message-Id: <20190823120539.18330-3-lijiang@redhat.com>
In-Reply-To: <20190823120539.18330-1-lijiang@redhat.com>
References: <20190823120539.18330-1-lijiang@redhat.com>
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
To: kexec@lists.infradead.org
Cc: kasong@redhat.com, bhe@redhat.com, piliu@redhat.com, bhsharma@redhat.com, junw99@yahoo.com, horms@verge.net.au, dyoung@redhat.com

The variable 'fname' is mistakenly defined two twice, the first definition
is in the vmcore-dmesg.c, and the second definition is in the elf_info.c.
That is confused and incorrect although it's a static type, because the
value of variable 'fname' is not assigned(set) in elf_info.c. Anyway, its
value will be always 'null' when printing an error information.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 util_lib/elf_info.c         | 2 +-
 vmcore-dmesg/vmcore-dmesg.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/util_lib/elf_info.c b/util_lib/elf_info.c
index d9397ecd8626..5d0efaafab53 100644
--- a/util_lib/elf_info.c
+++ b/util_lib/elf_info.c
@@ -20,7 +20,7 @@
 /* The 32bit and 64bit note headers make it clear we don't care */
 typedef Elf32_Nhdr Elf_Nhdr;
 
-static const char *fname;
+const char *fname;
 static Elf64_Ehdr ehdr;
 static Elf64_Phdr *phdr;
 static int num_pt_loads;
diff --git a/vmcore-dmesg/vmcore-dmesg.c b/vmcore-dmesg/vmcore-dmesg.c
index 7a386b380291..bebc348a657e 100644
--- a/vmcore-dmesg/vmcore-dmesg.c
+++ b/vmcore-dmesg/vmcore-dmesg.c
@@ -3,7 +3,7 @@
 /* The 32bit and 64bit note headers make it clear we don't care */
 typedef Elf32_Nhdr Elf_Nhdr;
 
-static const char *fname;
+extern const char *fname;
 
 int main(int argc, char **argv)
 {
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
