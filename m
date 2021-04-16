Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pj1-f54.google.com ([209.85.216.54])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXYMV-009nEy-NV
 for kexec@lists.infradead.org; Fri, 16 Apr 2021 23:59:04 +0000
Received: by mail-pj1-f54.google.com with SMTP id
 z22-20020a17090a0156b029014d4056663fso15458442pje.0
 for <kexec@lists.infradead.org>; Fri, 16 Apr 2021 16:58:59 -0700 (PDT)
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 2/2] fs/kernel_read_file: use usermodehelper_read_trylock() as
 a stop gap
Date: Fri, 16 Apr 2021 23:58:50 +0000
Message-Id: <20210416235850.23690-3-mcgrof@kernel.org>
In-Reply-To: <20210416235850.23690-1-mcgrof@kernel.org>
References: <20210416235850.23690-1-mcgrof@kernel.org>
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
To: rafael@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org, jeyu@kernel.org, ebiederm@xmission.com
Cc: mchehab@kernel.org, keescook@chromium.org, linux-fsdevel@vger.kernel.org, kernel@tuxforce.de, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>

The VFS lacks support to do automatic freeze / thaw of filesystems
on the suspend / resume cycle. This can cause some issues, namely
stalls when we have reads/writes during the suspend / resume cycle.

Although for module loading / kexec the probability of this happening
is extremely low, maybe even impossible, its a known real issue with
the request_firmare() API which it does direct fs read. For this reason
only be chatty about the issue on the call used by the firmware API.

Lukas Middendorf has reported an easy situation to reproduce, which can
be caused by questionably buggy drivers which call the request_firmware()
API on resume.

All you have to do is do the suspend / resume cycle using a driver
which will call request_firmware() on resume on a fresh XFS or
btrfs filesystem which has random files but the target file present:

for n in {1..1000}; do
	dd if=/dev/urandom of=/lib/firmware/file$( printf %03d "$n" ).bin bs=1 count=$((RANDOM + 1024 ))
done

You can reproduce this either with a buggy driver or by using the
test_firmware driver with the new hooks added to test this case.

No other request_firmware() calls can be triggered for this hang to work.
The hang occurs because:

request_firmware() -->
kernel_read_file_from_path_initns() -->
file_open_root() -->
  btrfs_lookup() --> ... -->
  btrfs_search_slot() --> read_block_for_search() -->
        --> read_tree_block() --> btree_read_extent_buffer_pages() -->
        --> submit_one_bio() --> btrfs_submit_metadata_bio() -->
        --> btrfsic_submit_bio() --> submit_bio()
                --> this completes and then
        --> wait_on_page_locked() on the first page
        --> never returns

The endless wait for the read which the piece of hardware never got
stalls resume as sync calls are all asynchronous.

The VFS fs freeze work fixes this issue, however it requires a bit
more work, which may take a while to land upstream, and so for now
this provides a simple stop-gap solution.

We can remove this stop-gap solution once the kernel gets VFS
fs freeze / thaw support.

Cc: rafael@kernel.org
Cc: jack@suse.cz
Cc: bvanassche@acm.org
Cc: kernel@tuxforce.de
Cc: mchehab@kernel.org
Cc: keescook@chromium.org
Reported-by: Lukas Middendorf <kernel@tuxforce.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/kernel_read_file.c | 37 +++++++++++++++++++++++++++++++++++--
 kernel/kexec_file.c   |  9 ++++++++-
 kernel/module.c       |  8 +++++++-
 3 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
index 90d255fbdd9b..f82d8534bf39 100644
--- a/fs/kernel_read_file.c
+++ b/fs/kernel_read_file.c
@@ -4,6 +4,7 @@
 #include <linux/kernel_read_file.h>
 #include <linux/security.h>
 #include <linux/vmalloc.h>
+#include <linux/umh.h>
 
 /**
  * kernel_read_file() - read file contents into a kernel buffer
@@ -134,12 +135,20 @@ int kernel_read_file_from_path(const char *path, loff_t offset, void **buf,
 	if (!path || !*path)
 		return -EINVAL;
 
+	ret = usermodehelper_read_trylock();
+	if (ret)
+		return ret;
+
 	file = filp_open(path, O_RDONLY, 0);
-	if (IS_ERR(file))
+	if (IS_ERR(file)) {
+		usermodehelper_read_unlock();
 		return PTR_ERR(file);
+	}
 
 	ret = kernel_read_file(file, offset, buf, buf_size, file_size, id);
 	fput(file);
+
+	usermodehelper_read_unlock();
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
@@ -160,13 +169,37 @@ int kernel_read_file_from_path_initns(const char *path, loff_t offset,
 	get_fs_root(init_task.fs, &root);
 	task_unlock(&init_task);
 
+	/*
+	 * Note: we may be incorrectly called on a driver's resume callback.
+	 *
+	 * The kernel's power management may be busy bringing us to suspend
+	 * or trying to get us back to resume. If we try to do a direct write
+	 * during this time a block driver may never get that request, and the
+	 * filesystem can wait forever. This requires proper VFS work, which
+	 * is not yet ready.
+	 *
+	 * Likewise busy trying here is not possible as well as we'd be holding
+	 * up the kernel's pm resume, and waiting will not allow use to thaw
+	 * the filesystem, we'd just wait forever. Best we can do is
+	 * communuicate the problem so that drivers use the firwmare cache or
+	 * implement their own prior to resume.
+	 */
+	ret = usermodehelper_read_trylock();
+	if (ret) {
+		pr_warn_once("Trying direct fs read while not allowed");
+		return ret;
+	}
+
 	file = file_open_root(root.dentry, root.mnt, path, O_RDONLY, 0);
 	path_put(&root);
-	if (IS_ERR(file))
+	if (IS_ERR(file)) {
+		usermodehelper_read_unlock();
 		return PTR_ERR(file);
+	}
 
 	ret = kernel_read_file(file, offset, buf, buf_size, file_size, id);
 	fput(file);
+	usermodehelper_read_unlock();
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kernel_read_file_from_path_initns);
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 33400ff051a8..d19a01836128 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -226,10 +226,16 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	int ret;
 	void *ldata;
 
+	ret = usermodehelper_read_trylock();
+	if (ret)
+		return ret;
+
 	ret = kernel_read_file_from_fd(kernel_fd, 0, &image->kernel_buf,
 				       INT_MAX, NULL, READING_KEXEC_IMAGE);
-	if (ret < 0)
+	if (ret < 0) {
+		usermodehelper_read_unlock();
 		return ret;
+	}
 	image->kernel_buf_len = ret;
 
 	/* Call arch image probe handlers */
@@ -291,6 +297,7 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	/* In case of error, free up all allocated memory in this function */
 	if (ret)
 		kimage_file_post_load_cleanup(image);
+	usermodehelper_read_unlock();
 	return ret;
 }
 
diff --git a/kernel/module.c b/kernel/module.c
index b5dd92e35b02..9058a104610d 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4140,13 +4140,19 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
 		      |MODULE_INIT_IGNORE_VERMAGIC))
 		return -EINVAL;
 
+	err = usermodehelper_read_trylock();
+	if (err)
+		return err;
 	err = kernel_read_file_from_fd(fd, 0, &hdr, INT_MAX, NULL,
 				       READING_MODULE);
-	if (err < 0)
+	if (err < 0) {
+		usermodehelper_read_unlock();
 		return err;
+	}
 	info.hdr = hdr;
 	info.len = err;
 
+	usermodehelper_read_unlock();
 	return load_module(&info, uargs, flags);
 }
 
-- 
2.29.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
