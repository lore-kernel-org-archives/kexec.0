Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZnkv-0007x5-BF
 for kexec@lists.infradead.org; Wed, 27 Nov 2019 03:12:42 +0000
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE880107ACE6
 for <kexec@lists.infradead.org>; Wed, 27 Nov 2019 03:12:36 +0000 (UTC)
Received: from mylaptop.redhat.com (ovpn-8-19.pek2.redhat.com [10.72.8.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7BF7919C7F
 for <kexec@lists.infradead.org>; Wed, 27 Nov 2019 03:12:35 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
Subject: [PATCH] doc: vmcore-dmesg should work on ELF format
Date: Wed, 27 Nov 2019 11:12:33 +0800
Message-Id: <1574824353-5309-1-git-send-email-piliu@redhat.com>
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

User may mistake to run vmcore-dmesg against an kdump format dumpfile, and
fail to get kernel message.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
---
 vmcore-dmesg/vmcore-dmesg.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vmcore-dmesg/vmcore-dmesg.8 b/vmcore-dmesg/vmcore-dmesg.8
index d9e3c62..dc06909 100644
--- a/vmcore-dmesg/vmcore-dmesg.8
+++ b/vmcore-dmesg/vmcore-dmesg.8
@@ -27,7 +27,7 @@ vmcore-dmesg \- This is just a placeholder until real man page has been written
 .\" respectively.
 \fBvmcore-dmesg\fP extracts the dmesg from a vmcore and write it to
 standard out.  \fBvmcore-dmesg\fP works against either
-\fB/proc/vmcore\fP in a crash dump capture context or a copy
+\fB/proc/vmcore\fP in a crash dump capture context or a ELF format copy
 of \fB/proc/vmcore\fP that has been saved for later analysis.  A
 single build of \fBvmcore-dmesg\fP should work against any linux
 vmcore written created on any architecture.
-- 
2.7.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
