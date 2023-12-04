Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A74C4167B
	for <kexec@archiver.kernel.org>; Mon,  4 Dec 2023 10:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Qk25CLolSi01ImF/JrLOQgpv7HgwCurNfK5O0DAfVBs=; b=oZveJg3VE1ZtZh
	DQ5EBF2yXEklIStYTH9qFROwABhhfpjD3JdtSgFlvGOuoFcZWvn09d3ZRkAyuqfEYE8B8tS8egWge
	s0UBoBKToO2aga7KHsQJTGXqSPz21HaNOtCWmi21xJLE7u/8hGJvNxcNyA9XSu3hHsyMu6PrEbHrV
	1UfAYPFwJseDc6NQufSNV3ewp7EC0YKx+xwO6tToKHwGbLgxzD3SL7MnzC6tC9ei5Mb3xvRwFHSTL
	baYxKPrp8PqFFnGQ6uWtPUxtu6NWojLT2qCcmBK5VGIniDk0XrSvn44v3az1M8Qknsaj9zP/1LOzU
	KYI/E73LBZ0h/P251O0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rA6Yr-003aEl-25;
	Mon, 04 Dec 2023 10:52:25 +0000
Received: from bg4.exmail.qq.com ([43.155.67.158])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rA6Yh-003aCg-0S
	for kexec@lists.infradead.org;
	Mon, 04 Dec 2023 10:52:23 +0000
X-QQ-mid: bizesmtp90t1701687117tuvc74ky
Received: from localhost.localdomain ( [58.240.82.166])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 04 Dec 2023 18:51:56 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: 3M0okmaRx3jGwsqZsDHZwgl+psWHX2umXDNQx7NhgvakzCdZZ5I9iohFIH+Pe
	WtVpd5FMB6rIgLKr0pFtElw4LsK8ZGA9qGw4xZQeXooTOcS1H1oXo4vtiMg8rTQBa80eY7J
	lczxaszlMTAH/xgXMlo1i/HxT9wKjI2SHwCgFUNIVhkR/07N7izxpS096XWX0/xgHGmr7NV
	L+pqwHKFmqfX9OtVtY/DgGYBTYXjcqM766BWTXU/xzqCyF4bY6VZPCGc8fV6GIuOrW0dL0u
	L7kr+azXPCdt6wKbxmMs74PqLDia0d/Jpp0d35hLsGbrfEfHs6Kviw+wBEzOqgQnLa92iKj
	RfkHJvZcyrxtAlLaWlSjWB7YoqQXeYn8o4DFeYIqPo0q02AqUQ=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 212379679253063436
From: Song Shuai <songshuaishuai@tinylab.org>
To: xianting.tian@linux.alibaba.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org,
	crash-utility@redhat.com
Cc: Song Shuai <songshuaishuai@tinylab.org>
Subject: [PATCH 2/2] [Crash-utility] RISCV64: Fix 'bt' output when no ra on the stack top
Date: Mon,  4 Dec 2023 18:50:15 +0800
Message-Id: <20231204105015.2341055-2-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231204105015.2341055-1-songshuaishuai@tinylab.org>
References: <20231204105015.2341055-1-songshuaishuai@tinylab.org>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_025215_483710_665DA586 
X-CRM114-Status: GOOD (  12.61  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Same as the Linux commit f766f77a74f5 ("riscv/stacktrace: Fix
stack output without ra on the stack top").

When a function doesn't have a callee, then it will not
push ra into the stack, such as lkdtm functions, so
correct the FP of the second frame and use pt_regs to get
the right PC of the second frame.

TEST:

Before this patch, the `bt -f` outputs only the first frame with
the wrong PC and FP of next frame:

```
crash> bt -f
PID: 1        TASK: ff600000000e0000  CPU: 1    COMMAND: "sh"
 #0 [ff20000000013cf0] lkdtm_EXCEPTION at ffffffff805303c0
    [PC: ffffffff805303c0 RA: ff20000000013d10 SP: ff20000000013cf0 SIZE: 16] <- wrong next PC
    ff20000000013cf0: 0000000000000001 ff20000000013d10 <- next FP
    ff20000000013d00: ff20000000013d40
crash>
```
After this patch, the `bt` outputs the full frames:

```
crash> bt
PID: 1        TASK: ff600000000e0000  CPU: 1    COMMAND: "sh"
 #0 [ff20000000013cf0] lkdtm_EXCEPTION at ffffffff805303c0
 #1 [ff20000000013d00] lkdtm_do_action at ffffffff8052fe36
 #2 [ff20000000013d10] direct_entry at ffffffff80530018
 #3 [ff20000000013d40] full_proxy_write at ffffffff80305044
 #4 [ff20000000013d80] vfs_write at ffffffff801b68b4
 #5 [ff20000000013e30] ksys_write at ffffffff801b6c4a
 #6 [ff20000000013e80] __riscv_sys_write at ffffffff801b6cc4
 #7 [ff20000000013e90] do_trap_ecall_u at ffffffff80836798
crash>
```
Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
---
 riscv64.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/riscv64.c b/riscv64.c
index 0aaa14b..872be59 100644
--- a/riscv64.c
+++ b/riscv64.c
@@ -747,11 +747,14 @@ riscv64_back_trace_cmd(struct bt_info *bt)
 {
 	struct riscv64_unwind_frame current, previous;
 	struct stackframe curr_frame;
+	struct riscv64_register * regs;
 	int level = 0;
 
 	if (bt->flags & BT_REGS_NOT_FOUND)
 		return;
 
+	regs = (struct riscv64_register *) bt->machdep;
+
 	current.pc = bt->instptr;
 	current.sp = bt->stkptr;
 	current.fp = bt->frameptr;
@@ -788,8 +791,16 @@ riscv64_back_trace_cmd(struct bt_info *bt)
 		    sizeof(curr_frame), "get stack frame", RETURN_ON_ERROR))
 			return;
 
-		previous.pc = curr_frame.ra;
-		previous.fp = curr_frame.fp;
+		/* correct PC and FP of the second frame when the first frame has no callee */
+
+		if (regs && (regs->regs[RISCV64_REGS_EPC] == current.pc) && curr_frame.fp & 0x7){
+			previous.pc = regs->regs[RISCV64_REGS_RA];
+			previous.fp = curr_frame.ra;
+		} else {
+			previous.pc = curr_frame.ra;
+			previous.fp = curr_frame.fp;
+		}
+
 		previous.sp = current.fp;
 
 		riscv64_dump_backtrace_entry(bt, symbol, &current, &previous, level++);
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
