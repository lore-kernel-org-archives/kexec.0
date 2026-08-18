Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5254C5DF7E
	for <kexec@archiver.kernel.org>; Tue, 18 Aug 2026 12:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Mime-Version:Subject:
	In-Reply-To:Date:From:Cc:To:Content-Type:References:Content-Transfer-Encoding
	:Message-Id:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2T2FjXV2CTfwvVIPw21SzamqS9nkP5SfD8NBp6uivhk=; b=Ya6+rJTKub/YbBR5frY9UZsLhL
	PpLSy2qWrYUnKTqzZaJiMwPqWSnbknulTMVbWhY4cwMRZFAkYPABeA0Y30700RXE4JkKjCclU8dJs
	Rg4rO+RT9Xe5snBxmPBoNAKK4uZS7itJJBJDC1FsNtcpLNXBgPfpLNtIT3Qv6xXr8qtpH4zhA3ZU1
	+ePjjgibFggsxzVDRhIo3ETt8ZXz9sRbv3WfhjxQ6KjZLEipAs7VQ/DMnePglovaIbdYy+YuoagoC
	3k5d1spsPDXE6bB8B/eVb4JxceiStjGVv7LXnEAz+5sFOCN/Rdz6b/suwZT23lzy0C9gMpOQSZ0+p
	oQKzZLwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwJ2X-00000007w66-2Cz5;
	Tue, 18 Aug 2026 12:35:37 +0000
Received: from va-1-114.ptr.blmpb.com ([209.127.230.114])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwJ2U-00000007w3n-3yKt
	for kexec@lists.infradead.org;
	Tue, 18 Aug 2026 12:35:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1787056530; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=2T2FjXV2CTfwvVIPw21SzamqS9nkP5SfD8NBp6uivhk=;
 b=RD9+wx0jOTw114D82inefErPsGwCZYn6LxQyy83SrDbIiqTQsU9qE2V5P9hfoaX/FiYiGc
 z07EV+8QBZ07jDm02n6rgX/yC0zUA7b8om4xg7uhh5WEENYoSQNrFkSP9d81KQ3vbklKym
 NfGHurswJL1lVxNDZ8iRmM8UfVRRyo3MGhSRYY3uTYLuKD0gws3e6EZQUIohyuO/zGGuk4
 ILXAvdMB8+rdUTzaWk//CntmlF6MjJ3pl5Y0KBbbbXQO1s3WDLbdepp4uVSqjBDs2aV02o
 bKwI5Ce4Yl6QyNckjJv28kvK5myBTPVqP2Tj9o0qEGKogVlu/WRafxSsj4wr2A==
Message-Id: <20260818123504.12022-5-qirui.001@bytedance.com>
Content-Transfer-Encoding: 7bit
References: <20260818123504.12022-4-qirui.001@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: <kexec@lists.infradead.org>
Cc: <horms@kernel.org>, <linux-riscv@lists.infradead.org>, 
	"Rui Qi" <qirui.001@bytedance.com>
From: "Rui Qi" <qirui.001@bytedance.com>
Date: Tue, 18 Aug 2026 20:35:06 +0800
X-Original-From: Rui Qi <qirui.001@bytedance.com>
In-Reply-To: <20260818123504.12022-4-qirui.001@bytedance.com>
X-Mailer: git-send-email 2.52.0
X-Lms-Return-Path: <lba+26a845191+7b8025+lists.infradead.org+qirui.001@bytedance.com>
Subject: [PATCH 1/2] kexec: Print crash kernel reserved size from sysfs
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260818_053535_071020_81DE32CD 
X-CRM114-Status: GOOD (  14.57  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

The --print-ckr-size option was added as a user-visible way for
kdump scripts to obtain the crash kernel reserved size. Its original
contract is to print the same value and unit as the kernel
kexec_crash_size sysfs attribute when Linux exports that attribute.

The current implementation derives the value from
get_crash_kernel_load_range(), but that helper describes where crash
kernel segments may be loaded. That is not the same as the total crash
kernel reservation.

The two meanings differ on systems with split crash kernel
reservations. A low reservation may be available to the crash kernel
after boot while the crash image itself must still be loaded into the
main/high reservation. Linux reports the total reserved crash kernel
size through /sys/kernel/kexec_crash_size, including split
reservations.

Prefer /sys/kernel/kexec_crash_size when available so
--print-ckr-size follows its original sysfs-aligned semantics. Keep the
existing load-range calculation as a fallback for older kernels.

Signed-off-by: Rui Qi <qirui.001@bytedance.com>
---
 kexec/kexec.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 58cab57a3ee3..99ec3ff3c373 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -60,6 +60,7 @@
 
 #define KEXEC_LOADED_PATH "/sys/kernel/kexec_loaded"
 #define KEXEC_CRASH_LOADED_PATH "/sys/kernel/kexec_crash_loaded"
+#define KEXEC_CRASH_SIZE_PATH "/sys/kernel/kexec_crash_size"
 
 unsigned long long mem_min = 0;
 unsigned long long mem_max = ULONG_MAX;
@@ -1495,14 +1496,30 @@ static inline unsigned long get_hotplug_kexec_flag(void)
 static void print_crashkernel_region_size(void)
 {
 	uint64_t start = 0, end = 0;
+	uint64_t size = 0;
+	FILE *fp;
 
-	if (is_crashkernel_mem_reserved() &&
-	    get_crash_kernel_load_range(&start, &end)) {
-		fprintf(stderr, "get_crash_kernel_load_range() failed.\n");
-		return;
+	fp = fopen(KEXEC_CRASH_SIZE_PATH, "r");
+	if (fp) {
+		if (fscanf(fp, "%" SCNu64, &size) == 1) {
+			fclose(fp);
+			printf("%" PRIu64 "\n", size);
+			return;
+		}
+		fclose(fp);
+	}
+
+	if (is_crashkernel_mem_reserved()) {
+		if (get_crash_kernel_load_range(&start, &end)) {
+			fprintf(stderr, "get_crash_kernel_load_range() failed.\n");
+			return;
+		}
+
+		if (start != end)
+			size = end - start + 1;
 	}
 
-	printf("%" PRIu64 "\n", (start != end) ? (end - start + 1) : 0UL);
+	printf("%" PRIu64 "\n", size);
 }
 
 int main(int argc, char *argv[])
-- 
2.52.0

