Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b8CjN-0003ya-J2
 for kexec@lists.infradead.org; Wed, 01 Jun 2016 20:27:10 +0000
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u51KPSD5022633
 for <kexec@lists.infradead.org>; Wed, 1 Jun 2016 13:26:48 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
 by mx0a-00082601.pphosted.com with ESMTP id 23a4x28p7d-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 01 Jun 2016 13:26:48 -0700
From: Josef Bacik <jbacik@fb.com>
Subject: [PATCH] kexec-tools: find sysfs smarter
Date: Wed, 1 Jun 2016 16:26:38 -0400
Message-ID: <1464812798-9034-1-git-send-email-jbacik@fb.com>
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
To: kexec@lists.infradead.org, kernel-team@fb.com

Some systems may not have /etc/mtab, so fall back to using /proc/mounts if we
fail to open /etc/mtab.  Also if a user does

mount -t sysfs none /sys

we won't find the sysfs directory.  We need to check mnt->mnt_type, not
mnt->mnt_fsname.

Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 kexec/arch/i386/x86-linux-setup.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
index c75adaa..c24abaa 100644
--- a/kexec/arch/i386/x86-linux-setup.c
+++ b/kexec/arch/i386/x86-linux-setup.c
@@ -425,10 +425,13 @@ char *find_mnt_by_fsname(char *fsname)
 	char *mntdir;
 
 	mtab = setmntent("/etc/mtab", "r");
-	if (!mtab)
-		return NULL;
+	if (!mtab) {
+		mtab = setmntent("/proc/mounts", "r");
+		if (!mtab)
+			return NULL;
+	}
 	for(mnt = getmntent(mtab); mnt; mnt = getmntent(mtab)) {
-		if (strcmp(mnt->mnt_fsname, fsname) == 0)
+		if (strcmp(mnt->mnt_type, fsname) == 0)
 			break;
 	}
 	mntdir = mnt ? strdup(mnt->mnt_dir) : NULL;
-- 
2.5.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
