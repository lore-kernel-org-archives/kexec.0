Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Masayoshi Mizuma <msys.mizuma@gmail.com>
Subject: [PATCH v2 1/2] efi: add /proc/efi directory
Date: Tue,  3 Dec 2019 15:14:09 -0500
Message-Id: <20191203201410.28045-2-msys.mizuma@gmail.com>
In-Reply-To: <20191203201410.28045-1-msys.mizuma@gmail.com>
References: <20191203201410.28045-1-msys.mizuma@gmail.com>
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
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org
Cc: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Matthias Brugger <matthias.bgg@gmail.com>, Masayoshi Mizuma <msys.mizuma@gmail.com>, d.hatayama@fujitsu.com

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Add /proc/efi directory to show some efi internal information.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 drivers/firmware/efi/efi.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index d101f072c..d8157cb34 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -325,6 +325,22 @@ static __init int efivar_ssdt_load(void)
 static inline int efivar_ssdt_load(void) { return 0; }
 #endif
 
+#ifdef CONFIG_PROC_FS
+static struct proc_dir_entry *proc_efi;
+static int __init efi_proc_init(void)
+{
+	proc_efi = proc_mkdir("efi", NULL);
+	if (!proc_efi) {
+		pr_err("/proc/efi: Cannot create /proc/efi directory.\n");
+		return 1;
+	}
+
+	return 0;
+}
+#else
+static inline int efi_proc_init(void) { return 0; }
+#endif /* CONFIG_PROC_FS */
+
 /*
  * We register the efi subsystem with the firmware subsystem and the
  * efivars subsystem with the efi subsystem, if the system was booted with
@@ -381,6 +397,12 @@ static int __init efisubsys_init(void)
 		goto err_remove_group;
 	}
 
+	error = efi_proc_init();
+	if (error) {
+		sysfs_remove_mount_point(efi_kobj, "efivars");
+		goto err_remove_group;
+	}
+
 	return 0;
 
 err_remove_group:
-- 
2.18.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
