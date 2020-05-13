Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYtC8-0000xi-2a
 for kexec@lists.infradead.org; Wed, 13 May 2020 15:21:20 +0000
Received: by mail-pf1-f193.google.com with SMTP id w65so8127026pfc.12
 for <kexec@lists.infradead.org>; Wed, 13 May 2020 08:21:15 -0700 (PDT)
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 1/3] fs: unexport kernel_read_file()
Date: Wed, 13 May 2020 15:21:06 +0000
Message-Id: <20200513152108.25669-2-mcgrof@kernel.org>
In-Reply-To: <20200513152108.25669-1-mcgrof@kernel.org>
References: <20200513152108.25669-1-mcgrof@kernel.org>
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
To: viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org, rafael@kernel.org, ebiederm@xmission.com, jeyu@kernel.org, jmorris@namei.org, keescook@chromium.org, paul@paul-moore.com, stephen.smalley.work@gmail.com, eparis@parisplace.org, nayna@linux.ibm.com, zohar@linux.ibm.com
Cc: scott.branden@broadcom.com, selinux@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-security-module@vger.kernel.org, geert@linux-m68k.org, dan.carpenter@oracle.com, skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org, tglx@linutronix.de, linux-integrity@vger.kernel.org, bauerman@linux.ibm.com, Luis Chamberlain <mcgrof@kernel.org>

There are no modular uses of kernel_read_file(), so just unexport it.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/exec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index 23dc2b45d590..9791b9eef9ce 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -988,7 +988,6 @@ int kernel_read_file(struct file *file, void **buf, loff_t *size,
 	allow_write_access(file);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(kernel_read_file);
 
 int kernel_read_file_from_path(const char *path, void **buf, loff_t *size,
 			       loff_t max_size, enum kernel_read_file_id id)
-- 
2.26.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
