Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WNbMS-00066G-I3
 for kexec@lists.infradead.org; Wed, 12 Mar 2014 05:05:49 +0000
From: Arthur Zou <zzou@redhat.com>
Subject: [PATCH v3] vmcore-dmesg stack smashing happend in extreme case
Date: Wed, 12 Mar 2014 13:05:18 +0800
Message-Id: <1394600718-20718-1-git-send-email-zzou@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Arthur Zou <zzou@redhat.com>, horms@verge.net.au

Description
in dump_dmesg_structured() the out_buf size is 4096, and if the
length is less than 4080( 4096-16 ) it won't really write out.
Normally, after writing one or four chars to the out_buf, it will
check the length of out_buf. But in extreme cases, 19 chars was
written to the out_buf before checking the length. This may cause
the stack corruption. If the length was 4079 (won't realy write out),
and then write 19 chars to it. the out_buf will overflow.

Solution
Change 16 to 64 thus can make sure that always have 64bytes before
moving to next records. why using 64 is that a long long int can take
20 bytes. so the length of timestamp can be 44 ('[','.',']',' ') in
extreme case.

Signed-off-by: Arthur Zou <zzou@redhat.com>
Acked-by: Vivek Goyal <vgoyal@redhat.com>
---
 vmcore-dmesg/vmcore-dmesg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vmcore-dmesg/vmcore-dmesg.c b/vmcore-dmesg/vmcore-dmesg.c
index 0345660..e15cd91 100644
--- a/vmcore-dmesg/vmcore-dmesg.c
+++ b/vmcore-dmesg/vmcore-dmesg.c
@@ -674,7 +674,7 @@ static void dump_dmesg_structured(int fd)
 			else
 				out_buf[len++] = c;
 
-			if (len >= OUT_BUF_SIZE - 16) {
+			if (len >= OUT_BUF_SIZE - 64) {
 				write_to_stdout(out_buf, len);
 				len = 0;
 			}
-- 
1.8.4.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
