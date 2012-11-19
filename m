Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TaHdB-0005qn-D3
 for kexec@lists.infradead.org; Mon, 19 Nov 2012 03:02:43 +0000
From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 2/6] kexec: don't die during buffer finding
Date: Sun, 18 Nov 2012 19:02:27 -0800
Message-Id: <1353294151-32133-3-git-send-email-yinghai@kernel.org>
In-Reply-To: <1353294151-32133-1-git-send-email-yinghai@kernel.org>
References: <878v9zp55t.fsf@xmission.com>
 <1353294151-32133-1-git-send-email-yinghai@kernel.org>
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

could return 0, and let the caller retry with new ranges.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 kexec/kexec.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 8928be0..0f8aec8 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -366,10 +366,9 @@ unsigned long add_buffer_phys_virt(struct kexec_info *info,
 	memsz = (memsz + (pagesize - 1)) & ~(pagesize - 1);
 
 	base = locate_hole(info, memsz, buf_align, buf_min, buf_max, buf_end);
-	if (base == ULONG_MAX) {
-		die("locate_hole failed\n");
-	}
-	
+	if (base == ULONG_MAX)
+		return 0;
+
 	add_segment_phys_virt(info, buf, bufsz, base, memsz, phys);
 	return base;
 }
-- 
1.7.7


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
