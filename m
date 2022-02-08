From: Tiezhu Yang <yangtiezhu@loongson.cn>
Date: Tue,  8 Feb 2022 20:51:02 +0800
Subject: [PATCH v2 1/5] docs: kdump: update description about sysfs file
 system support
In-Reply-To: <1644324666-15947-1-git-send-email-yangtiezhu@loongson.cn>
References: <1644324666-15947-1-git-send-email-yangtiezhu@loongson.cn>
Message-ID: <1644324666-15947-2-git-send-email-yangtiezhu@loongson.cn>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

After commit 6a108a14fa35 ("kconfig: rename CONFIG_EMBEDDED to
CONFIG_EXPERT"), "Configure standard kernel features (for small
systems)" is not exist, we should use "Configure standard kernel
features (expert users)" now.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Acked-by: Baoquan He <bhe@redhat.com>
---
 Documentation/admin-guide/kdump/kdump.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index cb30ca3d..d187df2 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -146,9 +146,9 @@ System kernel config options
 	CONFIG_SYSFS=y
 
    Note that "sysfs file system support" might not appear in the "Pseudo
-   filesystems" menu if "Configure standard kernel features (for small
-   systems)" is not enabled in "General Setup." In this case, check the
-   .config file itself to ensure that sysfs is turned on, as follows::
+   filesystems" menu if "Configure standard kernel features (expert users)"
+   is not enabled in "General Setup." In this case, check the .config file
+   itself to ensure that sysfs is turned on, as follows::
 
 	grep 'CONFIG_SYSFS' .config
 
-- 
2.1.0


