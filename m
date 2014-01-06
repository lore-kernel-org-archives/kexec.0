Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W0E7k-0008Nv-1C
 for kexec@lists.infradead.org; Mon, 06 Jan 2014 17:38:00 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
 (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s06HbboO022509
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <kexec@lists.infradead.org>; Mon, 6 Jan 2014 12:37:38 -0500
From: WANG Chao <chaowang@redhat.com>
Subject: [PATCH] vmcore-dmesg: struct_val_u64() not casting u64 to u32
Date: Tue,  7 Jan 2014 01:37:34 +0800
Message-Id: <1389029854-2052-1-git-send-email-chaowang@redhat.com>
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

It seems gcc doesn't check return type from inline function.
struct_val_u64() should return u64 otherwise upper 32bit is lost.

Signed-off-by: WANG Chao <chaowang@redhat.com>
---
 vmcore-dmesg/vmcore-dmesg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vmcore-dmesg/vmcore-dmesg.c b/vmcore-dmesg/vmcore-dmesg.c
index 0f477c0..df14c89 100644
--- a/vmcore-dmesg/vmcore-dmesg.c
+++ b/vmcore-dmesg/vmcore-dmesg.c
@@ -529,7 +529,7 @@ static inline uint32_t struct_val_u32(char *ptr, unsigned int offset)
 	return(file32_to_cpu(*(uint32_t *)(ptr + offset)));
 }
 
-static inline uint32_t struct_val_u64(char *ptr, unsigned int offset)
+static inline uint64_t struct_val_u64(char *ptr, unsigned int offset)
 {
 	return(file64_to_cpu(*(uint64_t *)(ptr + offset)));
 }
-- 
1.8.4.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
