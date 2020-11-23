Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kh3cU-0006zM-3z
 for kexec@lists.infradead.org; Mon, 23 Nov 2020 04:38:31 +0000
Received: by mail-pf1-x441.google.com with SMTP id b6so3287984pfp.7
 for <kexec@lists.infradead.org>; Sun, 22 Nov 2020 20:38:29 -0800 (PST)
From: Alexander Kamensky <alexander.kamensky42@gmail.com>
Subject: [RFC PATCH 2/3] added way to determine kernel version that vmcore is
 from
Date: Sun, 22 Nov 2020 20:37:57 -0800
Message-Id: <20201123043758.105713-3-alexander.kamensky42@gmail.com>
In-Reply-To: <20201123043758.105713-1-alexander.kamensky42@gmail.com>
References: <20201123043758.105713-1-alexander.kamensky42@gmail.com>
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
To: kexec@lists.infradead.org, Kazuhito Hagio <k-hagio-ab@nec.com>, Bhupesh Sharma <bhsharma@redhat.com>
Cc: Alexander Kamensky <alexander.kamensky42@gmail.com>

In some cases reading kernel dump require knowledge of the kernel version
that created the kernel dump file. Introduce release_kernel_version field
in struct DumpInfo, and fill it by parsing OSRELEASE value during
vmcoreinfo note read.

Signed-off-by: Alexander Kamensky <alexander.kamensky42@gmail.com>
---
 makedumpfile.c | 27 +++++++++++++++++++++++++++
 makedumpfile.h |  1 +
 2 files changed, 28 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index a955912..e2b0bc2 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2380,6 +2380,32 @@ generate_vmcoreinfo(void)
 	return TRUE;
 }
 
+static void
+update_release_kernel_version(void)
+{
+	char *endp, *curp;
+	unsigned int kver_maj, kver_min, kver_rel;
+
+	curp = info->release;
+	kver_maj = strtoul(curp, &endp, 10);
+	if ((curp != endp) && (endp[0] == '.')) {
+		curp = endp + 1;
+		kver_min = strtoul(curp, &endp, 10);
+		if ((curp != endp) && (endp[0] == '.')) {
+			curp = endp + 1;
+			kver_rel =  strtoul(curp, &endp, 10);
+			if (curp != endp) {
+				info->release_kernel_version = KERNEL_VERSION(kver_maj,
+									      kver_min,
+									      kver_rel);
+				return;
+			}
+		}
+	}
+	ERRMSG("Cannot extract kernel version from %s%s\n", STR_OSRELEASE,
+	       info->release);
+}
+
 int
 read_vmcoreinfo_basic_info(void)
 {
@@ -2409,6 +2435,7 @@ read_vmcoreinfo_basic_info(void)
 			if (strlen(info->release))
 				continue;
 			strcpy(info->release, buf + strlen(STR_OSRELEASE));
+			update_release_kernel_version();
 		}
 		if (strncmp(buf, STR_PAGESIZE, strlen(STR_PAGESIZE)) == 0) {
 			page_size = strtol(buf+strlen(STR_PAGESIZE),&endp,10);
diff --git a/makedumpfile.h b/makedumpfile.h
index b95c7b6..b36766a 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1440,6 +1440,7 @@ struct DumpInfo {
 	FILE			*file_vmcoreinfo;
 	char			*name_vmcoreinfo;	     /* vmcoreinfo file */
 	char			release[STRLEN_OSRELEASE];
+	int32_t			release_kernel_version; /* extracted from release */
 	int			read_text_vmcoreinfo;
 
 	/*
-- 
2.26.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
