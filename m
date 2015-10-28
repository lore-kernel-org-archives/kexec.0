Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZrJRp-0001Rh-SW
 for kexec@lists.infradead.org; Wed, 28 Oct 2015 05:38:58 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
 (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
 by mx1.redhat.com (Postfix) with ESMTPS id 2F5EC8E673
 for <kexec@lists.infradead.org>; Wed, 28 Oct 2015 05:38:36 +0000 (UTC)
From: Dangyi Liu <dliu@redhat.com>
Subject: [PATCH] vmcore-dmesg: do not use logged_chars as dmesg length
Date: Wed, 28 Oct 2015 13:38:27 +0800
Message-Id: <1446010707-7527-1-git-send-email-dliu@redhat.com>
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
Cc: Dangyi Liu <dliu@redhat.com>

logged_chars would be set to 0 by `dmesg -c`, but we want to get the
full dmesg after crash. So instead of using logged_chars directly, we
calculate it by ourselves.

Now logged_chars is set to the minimum of log_end and log_buf_len, which
is coherent to how crash utility deals with dmesg length.

Signed-off-by: Dangyi Liu <dliu@redhat.com>
---
 vmcore-dmesg/vmcore-dmesg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/vmcore-dmesg/vmcore-dmesg.c b/vmcore-dmesg/vmcore-dmesg.c
index f47ee11..ec2570f 100644
--- a/vmcore-dmesg/vmcore-dmesg.c
+++ b/vmcore-dmesg/vmcore-dmesg.c
@@ -540,6 +540,9 @@ static void dump_dmesg_legacy(int fd)
 		exit(53);
 	}
 
+	// `dmesg -c` would set logged_chars to 0, then we cannot get a full dmesg.
+	logged_chars = log_end < log_buf_len ? log_end : log_buf_len;
+
 	write_to_stdout(buf + (log_buf_len -  logged_chars), logged_chars);
 }
 
-- 
2.4.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
