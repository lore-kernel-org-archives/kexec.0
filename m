Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ug585-0003gQ-DK
 for kexec@lists.infradead.org; Sat, 25 May 2013 03:26:50 +0000
Received: by mail-pd0-f176.google.com with SMTP id r11so4760234pdi.21
 for <kexec@lists.infradead.org>; Fri, 24 May 2013 20:26:28 -0700 (PDT)
Message-ID: <51A02F59.8000103@gmail.com>
Date: Sat, 25 May 2013 11:26:17 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 2/7] Documentation/devices.txt: Remove /dev/oldmem description
References: <51A02E50.5020507@gmail.com>
In-Reply-To: <51A02E50.5020507@gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Simon Horman <horms@verge.net.au>
Cc: davej@redhat.com, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Cc: Dave Jones <davej@redhat.com>
---
 Documentation/devices.txt |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/Documentation/devices.txt b/Documentation/devices.txt
index 08f01e7..4f85739 100644
--- a/Documentation/devices.txt
+++ b/Documentation/devices.txt
@@ -100,8 +100,6 @@ Your cooperation is appreciated.
 		 10 = /dev/aio		Asynchronous I/O notification interface
 		 11 = /dev/kmsg		Writes to this come out as printk's, reads
 					export the buffered printk records.
-		 12 = /dev/oldmem	Used by crashdump kernels to access
-					the memory of the kernel that crashed.
 
   1 block	RAM disk
 		  0 = /dev/ram0		First RAM disk
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
