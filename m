Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TZUxm-0005mc-1l
 for kexec@lists.infradead.org; Fri, 16 Nov 2012 23:04:43 +0000
From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 6/8] debug print out for add_buf
Date: Fri, 16 Nov 2012 15:04:25 -0800
Message-Id: <1353107067-14564-7-git-send-email-yinghai@kernel.org>
In-Reply-To: <1353107067-14564-1-git-send-email-yinghai@kernel.org>
References: <1353107067-14564-1-git-send-email-yinghai@kernel.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>, "H. Peter Anvin" <hpa@zytor.com>, Vivek Goyal <vgoyal@redhat.com>, Haren Myneni <hbabu@us.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Yinghai Lu <yinghai@kernel.org>, kexec@lists.infradead.org

those info are very important.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 kexec/add_buffer.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/kexec/add_buffer.c b/kexec/add_buffer.c
index 4d4a55f..0e3badf 100644
--- a/kexec/add_buffer.c
+++ b/kexec/add_buffer.c
@@ -9,6 +9,13 @@ unsigned long add_buffer(struct kexec_info *info,
 			 unsigned long buf_max,
 			 int buf_end)
 {
-	return add_buffer_virt(info, buf, bufsz, memsz, buf_align,
+	unsigned long base;
+
+	base = add_buffer_virt(info, buf, bufsz, memsz, buf_align,
 			       buf_min, buf_max, buf_end);
+
+	if (base)
+		printf("add_buffer: base:%lx size:%lx\n", base, bufsz);
+
+	return base;
 }
-- 
1.7.7


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
