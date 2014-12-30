Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Y5yFV-00013m-3f
 for kexec@lists.infradead.org; Tue, 30 Dec 2014 14:58:17 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
 (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sBUEvs9q027432
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <kexec@lists.infradead.org>; Tue, 30 Dec 2014 09:57:54 -0500
From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH] kexec,
 remove panic_on_warn kernel parameter from kdump situations
Date: Tue, 30 Dec 2014 09:57:51 -0500
Message-Id: <1419951471-19765-1-git-send-email-prarit@redhat.com>
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
Cc: Prarit Bhargava <prarit@redhat.com>, Dave Young <dyoung@redhat.com>, WANG Chao <chaowang@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

panic_on_warn kernel parameter will cause the kernel to panic when a
WARN() is hit in the kernel.  This is not a good situation for the kdump
kernel because then it would be possible for the kdump kernel to panic in
a non-fatal WARN().

This patch removes panic_on_warn as a kernel parameter for the kdump
kernel.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: WANG Chao <chaowang@redhat.com>
---
 kexec/kexec.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index b088916..323cafb 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1048,8 +1048,10 @@ char *get_command_line(void)
 	line[strlen(line) - 1] = '\0';
 
 	remove_parameter(line, "BOOT_IMAGE");
-	if (kexec_flags & KEXEC_ON_CRASH)
+	if (kexec_flags & KEXEC_ON_CRASH) {
 		remove_parameter(line, "crashkernel");
+		remove_parameter(line, "panic_on_warn");
+	}
 
 	return line;
 }
-- 
1.7.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
