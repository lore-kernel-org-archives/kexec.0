Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1byw5J-0000UR-GW
 for kexec@lists.infradead.org; Tue, 25 Oct 2016 07:23:47 +0000
Received: by mail-qt0-f180.google.com with SMTP id r21so7275404qtr.4
 for <kexec@lists.infradead.org>; Tue, 25 Oct 2016 00:23:25 -0700 (PDT)
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH Makedumpfile 02/10] read_vmcoreinfo_long: Allow to read hex
 values as well
Date: Tue, 25 Oct 2016 12:52:54 +0530
Message-Id: <14ce46e3c2e872543de02b369362864812f3bc39.1477378297.git.panand@redhat.com>
In-Reply-To: <cover.1477378297.git.panand@redhat.com>
References: <cover.1477378297.git.panand@redhat.com>
In-Reply-To: <cover.1477378297.git.panand@redhat.com>
References: <cover.1477378297.git.panand@redhat.com>
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
Cc: Pratyush Anand <panand@redhat.com>, sgoel@codeaurora.org, mansip@codeaurora.org, asamson@codeaurora.org, kexec@lists.infradead.org

Kernel can also write a hex value in NUMBER(X) string, for example:
vmcoreinfo_append_str("NUMBER(PHYS_OFFSET)=0x%llx\n",PHYS_OFFSET);

Therefore, allow read_vmcoreinfo_long() to read 'base 16' values if, 'base
10' read resulted in a read of invalid character.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 makedumpfile.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index ab9719bb678e..b2ea3ebdd4cb 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2433,6 +2433,8 @@ read_vmcoreinfo_long(char *str_structure)
 			buf[i - 1] = '\0';
 		if (strncmp(buf, str_structure, strlen(str_structure)) == 0) {
 			data = strtol(buf + strlen(str_structure), &endp, 10);
+			if (strlen(endp) != 0)
+				data = strtol(buf + strlen(str_structure), &endp, 16);
 			if ((data == LONG_MAX) || strlen(endp) != 0) {
 				ERRMSG("Invalid data in %s: %s",
 				    info->name_vmcoreinfo, buf);
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
