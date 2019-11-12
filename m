Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUU3F-0000YL-Is
 for kexec@lists.infradead.org; Tue, 12 Nov 2019 11:09:39 +0000
Received: by mail-pg1-f200.google.com with SMTP id p8so7792225pgm.9
 for <kexec@lists.infradead.org>; Tue, 12 Nov 2019 03:09:35 -0800 (PST)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH v4 4/4] makedumpfile: Mark --mem-usage option unsupported for
 arm64
Date: Tue, 12 Nov 2019 16:38:59 +0530
Message-Id: <1573556939-17803-5-git-send-email-bhsharma@redhat.com>
In-Reply-To: <1573556939-17803-1-git-send-email-bhsharma@redhat.com>
References: <1573556939-17803-1-git-send-email-bhsharma@redhat.com>
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
Cc: John Donnelly <john.p.donnelly@oracle.com>, bhsharma@redhat.com, bhupesh.linux@gmail.com, Kazuhito Hagio <k-hagio@ab.jp.nec.com>

This patch marks '--mem-usage' option as unsupported for arm64
architecture.

With the newer arm64 kernels supporting 48-bit/52-bit VA address spaces
and keeping a single binary for supporting the same, the address of
kernel symbols like _stext which could be earlier used to determine
VA_BITS value, can no longer to determine whether VA_BITS is set to 48
or 52 in the kernel space.

Hence for now, it makes sense to mark '--mem-usage' option as
unsupported for arm64 architecture until we have more clarity from arm64
kernel maintainers on how to manage the same in future
kernel/makedumpfile versions.

Cc: John Donnelly <john.p.donnelly@oracle.com>
Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: kexec@lists.infradead.org
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 makedumpfile.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index baf559e4d74e..ae60466a1e9c 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -11564,6 +11564,11 @@ main(int argc, char *argv[])
 		MSG("\n");
 		MSG("The dmesg log is saved to %s.\n", info->name_dumpfile);
 	} else if (info->flag_mem_usage) {
+#ifdef __aarch64__
+		MSG("mem-usage not supported for arm64 architecure.\n");
+		goto out;
+#endif
+
 		if (!check_param_for_creating_dumpfile(argc, argv)) {
 			MSG("Commandline parameter is invalid.\n");
 			MSG("Try `makedumpfile --help' for more information.\n");
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
