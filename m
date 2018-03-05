Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1estgZ-0002s8-Gi
 for kexec@lists.infradead.org; Mon, 05 Mar 2018 17:14:05 +0000
Received: by mail-pg0-f65.google.com with SMTP id e9so7065458pgs.10
 for <kexec@lists.infradead.org>; Mon, 05 Mar 2018 09:13:53 -0800 (PST)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH v2 3/3] Documentation: Update documentation regarding
 --mem-usage' option
Date: Mon,  5 Mar 2018 22:42:56 +0530
Message-Id: <1520269976-8850-4-git-send-email-bhsharma@redhat.com>
In-Reply-To: <1520269976-8850-1-git-send-email-bhsharma@redhat.com>
References: <1520269976-8850-1-git-send-email-bhsharma@redhat.com>
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
Cc: bhsharma@redhat.com, bhupesh.linux@gmail.com

Earlier patch in this patchset, enables the '--mem-usage' makedumpfile
option on arm64 platforms.

In addition, I have validated the '--mem-usage' makedumpfile option
on several ppc64/ppc64le and s390x machines, so update the
'makedumpfile.8' documentation to indicate that '--mem-usage' option is
supported not only on x86_64, but also on ppc64, s390x and arm64
platforms.

Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 makedumpfile.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/makedumpfile.8 b/makedumpfile.8
index 15db7947d62f..3ccfc65798be 100644
--- a/makedumpfile.8
+++ b/makedumpfile.8
@@ -593,7 +593,7 @@ last cleared on the crashed kernel, through "dmesg --clear" for example.
 
 .TP
 \fB\-\-mem-usage\fR
-This option is only for x86_64.
+This option is currently supported on x86_64, arm64, ppc64 and s390x.
 This option is used to show the page numbers of current system in different
 use. It should be executed in 1st kernel. By the help of this, user can know
 how many pages is dumpable when different dump_level is specified. It analyzes
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
