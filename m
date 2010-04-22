Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-vw0-f49.google.com ([209.85.212.49])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1O4zBu-00081t-EP
	for kexec@lists.infradead.org; Thu, 22 Apr 2010 16:23:50 +0000
Received: by mail-vw0-f49.google.com with SMTP id 3so1969792vws.36
	for <kexec@lists.infradead.org>; Thu, 22 Apr 2010 09:23:50 -0700 (PDT)
From: Vitaly Mayatskikh <v.mayatskih@gmail.com>
Subject: [PATCH 3/5] Support second memory region in crash_shrink_memory()
Date: Thu, 22 Apr 2010 18:23:10 +0200
Message-Id: <1271953392-6324-4-git-send-email-v.mayatskih@gmail.com>
In-Reply-To: <1271953392-6324-1-git-send-email-v.mayatskih@gmail.com>
References: <1271953392-6324-1-git-send-email-v.mayatskih@gmail.com>
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
To: linux-kernel@vger.kernel.org
Cc: Cong Wang <amwang@redhat.com>, Neil Horman <nhorman@tuxdriver.com>, kexec@lists.infradead.org, Haren Myneni <hbabu@us.ibm.com>, Ingo Molnar <mingo@redhat.com>, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Vivek Goyal <vgoyal@redhat.com>

This patch changes crash_shrink_memory() to work with previosly added
memory region also. When shrink occurs, second region is shrunk first.

Signed-off-by: Vitaly Mayatskikh <v.mayatskih@gmail.com>
---
 kernel/kexec.c |   55 ++++++++++++++++++++++++++++++++++++++++---------------
 1 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index b8fd6eb..dfaa01e 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1117,10 +1117,36 @@ static void free_reserved_phys_range(unsigned long begin, unsigned long end)
 	}
 }
 
+int crash_shrink_region(struct resource *crashk, unsigned long new_size)
+{
+	unsigned long start, end, size;
+
+	start = crashk->start;
+	end = crashk->end;
+	size = end - start + 1;
+
+	if (!size || new_size == size) /* Nothing to free */
+		return 0;
+
+	if (new_size > size)
+		return -EINVAL;
+
+	start = roundup(start, PAGE_SIZE);
+	end = roundup(start + new_size, PAGE_SIZE);
+
+	free_reserved_phys_range(end, crashk->end);
+
+	if (start == end)
+		release_resource(crashk);
+	crashk->end = end - 1;
+
+	return 0;
+}
+
 int crash_shrink_memory(unsigned long new_size)
 {
 	int ret = 0;
-	unsigned long start, end;
+	unsigned long crash_size, low_size;
 
 	mutex_lock(&kexec_mutex);
 
@@ -1128,26 +1154,25 @@ int crash_shrink_memory(unsigned long new_size)
 		ret = -ENOENT;
 		goto unlock;
 	}
-	start = crashk_res.start;
-	end = crashk_res.end;
 
-	if (new_size >= end - start + 1) {
+	crash_size = low_size = crashk_res.end - crashk_res.start + 1;
+	crash_size += crashk_res_hi.end - crashk_res_hi.start + 1;
+
+	if (crash_size == new_size)
+		goto unlock;
+	if (crash_size < new_size) {
 		ret = -EINVAL;
-		if (new_size == end - start + 1)
-			ret = 0;
 		goto unlock;
 	}
 
-	start = roundup(start, PAGE_SIZE);
-	end = roundup(start + new_size, PAGE_SIZE);
-
-	free_reserved_phys_range(end, crashk_res.end);
-
-	if (start == end) {
-		crashk_res.end = end;
-		release_resource(&crashk_res);
+	if (new_size < low_size) {
+		/* Reap crashk_res_hi */
+		ret = crash_shrink_region(&crashk_res_hi, 0);
+		if (ret)
+			goto unlock;
+		ret = crash_shrink_region(&crashk_res, new_size);
 	} else
-		crashk_res.end = end - 1;
+		ret = crash_shrink_region(&crashk_res_hi, new_size - low_size);
 
 unlock:
 	mutex_unlock(&kexec_mutex);
-- 
1.7.0.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
