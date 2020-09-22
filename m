Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKeCR-0004Bd-80
 for kexec@lists.infradead.org; Tue, 22 Sep 2020 09:03:00 +0000
Received: by mail-pj1-f70.google.com with SMTP id hr13so1737914pjb.3
 for <kexec@lists.infradead.org>; Tue, 22 Sep 2020 02:02:56 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH] vmcore-dmesg/man page: Update the vmcore-dmesg man page
Date: Tue, 22 Sep 2020 14:32:44 +0530
Message-Id: <20200922090244.832691-1-bhsharma@redhat.com>
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
To: kexec@lists.infradead.org
Cc: bhsharma@redhat.com, bhupesh.linux@gmail.com, Eric Biederman <ebiederm@xmission.com>, Simon Horman <horms@verge.net.au>

The vmcore-dmesg utility has been in usage for several years,
and is pretty stable now.

So its useful now to modify its man page to indicate the same.
Also fix some minor formatting issues.

Cc: Simon Horman <horms@verge.net.au>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 vmcore-dmesg/vmcore-dmesg.8 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/vmcore-dmesg/vmcore-dmesg.8 b/vmcore-dmesg/vmcore-dmesg.8
index d9e3c62ebcb6..ec594b048a61 100644
--- a/vmcore-dmesg/vmcore-dmesg.8
+++ b/vmcore-dmesg/vmcore-dmesg.8
@@ -2,7 +2,7 @@
 .\" First parameter, NAME, should be all caps
 .\" Second parameter, SECTION, should be 1-8, maybe w/ subsection
 .\" other parameters are allowed: see man(7), man(1)
-.TH VMCORE-DMESG 8 "Sep 7, 2010"
+.TH VMCORE-DMESG 8 "Sep 21, 2020"
 .\" Please adjust this date whenever revising the manpage.
 .\"
 .\" Some roff macros, for reference:
@@ -16,7 +16,7 @@
 .\" .sp <n>    insert n+1 empty lines
 .\" for manpage-specific macros, see man(7)
 .SH NAME
-vmcore-dmesg \- This is just a placeholder until real man page has been written
+vmcore-dmesg
 .SH SYNOPSIS
 .B vmcore-dmesg
 .RI " vmcore"
@@ -26,9 +26,9 @@ vmcore-dmesg \- This is just a placeholder until real man page has been written
 .\" \fI<whatever>\fP escape sequences to invode bold face and italics,
 .\" respectively.
 \fBvmcore-dmesg\fP extracts the dmesg from a vmcore and write it to
-standard out.  \fBvmcore-dmesg\fP works against either
+standard out. \fBvmcore-dmesg\fP works against either
 \fB/proc/vmcore\fP in a crash dump capture context or a copy
-of \fB/proc/vmcore\fP that has been saved for later analysis.  A
+of \fB/proc/vmcore\fP that has been saved for later analysis. A
 single build of \fBvmcore-dmesg\fP should work against any linux
 vmcore written created on any architecture.
 
-- 
2.26.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
