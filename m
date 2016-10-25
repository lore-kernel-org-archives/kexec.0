Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1byw5O-0000W2-E2
 for kexec@lists.infradead.org; Tue, 25 Oct 2016 07:23:52 +0000
Received: by mail-qk0-f175.google.com with SMTP id x11so46152459qka.1
 for <kexec@lists.infradead.org>; Tue, 25 Oct 2016 00:23:28 -0700 (PDT)
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH Makedumpfile 03/10] Introduce read_vmcoreinfo_ulong()
Date: Tue, 25 Oct 2016 12:52:55 +0530
Message-Id: <34a970eeae39e86d768fba3e0497aa2c0db16f9b.1477378297.git.panand@redhat.com>
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

Kernel may pass an unsigned number into vmcore. For example ARM64 passes:

vmcoreinfo_append_str("NUMBER(PHYS_OFFSET)=0x%llx\n", PHYS_OFFSET);

Therefore, introducing read_vmcoreinfo_ulong() to read such values
correctly.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 makedumpfile.c | 34 ++++++++++++++++++++++++++++++++++
 makedumpfile.h | 16 ++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index b2ea3ebdd4cb..e248db876858 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2412,6 +2412,40 @@ read_vmcoreinfo_symbol(char *str_symbol)
 	return symbol;
 }
 
+unsigned long
+read_vmcoreinfo_ulong(char *str_structure)
+{
+	long data = NOT_FOUND_LONG_VALUE;
+	char buf[BUFSIZE_FGETS], *endp;
+	unsigned int i;
+
+	if (fseek(info->file_vmcoreinfo, 0, SEEK_SET) < 0) {
+		ERRMSG("Can't seek the vmcoreinfo file(%s). %s\n",
+		    info->name_vmcoreinfo, strerror(errno));
+		return INVALID_STRUCTURE_DATA;
+	}
+
+	while (fgets(buf, BUFSIZE_FGETS, info->file_vmcoreinfo)) {
+		i = strlen(buf);
+		if (!i)
+			break;
+		if (buf[i - 1] == '\n')
+			buf[i - 1] = '\0';
+		if (strncmp(buf, str_structure, strlen(str_structure)) == 0) {
+			data = strtoul(buf + strlen(str_structure), &endp, 10);
+			if (strlen(endp) != 0)
+				data = strtoul(buf + strlen(str_structure), &endp, 16);
+			if ((data == LONG_MAX) || strlen(endp) != 0) {
+				ERRMSG("Invalid data in %s: %s",
+				    info->name_vmcoreinfo, buf);
+				return INVALID_STRUCTURE_DATA;
+			}
+			break;
+		}
+	}
+	return data;
+}
+
 long
 read_vmcoreinfo_long(char *str_structure)
 {
diff --git a/makedumpfile.h b/makedumpfile.h
index a5955ff750e5..c5e38a5b6e4b 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -393,6 +393,22 @@ do { \
 			return FALSE; \
 	} \
 } while (0)
+#define WRITE_NUMBER_UNSIGNED(str_number, number) \
+do { \
+	if (NUMBER(number) != NOT_FOUND_NUMBER) { \
+		fprintf(info->file_vmcoreinfo, "%s%lu\n", \
+		    STR_NUMBER(str_number), NUMBER(number)); \
+	} \
+} while (0)
+#define READ_NUMBER_UNSIGNED(str_number, number) \
+do { \
+	if (NUMBER(number) == NOT_FOUND_NUMBER) { \
+		NUMBER(number) = read_vmcoreinfo_ulong(STR_NUMBER(str_number)); \
+		if (NUMBER(number) == INVALID_STRUCTURE_DATA) \
+			return FALSE; \
+	} \
+} while (0)
+
 
 /*
  * for source file name
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
