Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60793C43334
	for <kexec@archiver.kernel.org>; Tue, 26 Jul 2022 09:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=me5swaQR+WW8yzjRb8IL05I6nWqjDX8e2+QCxERfWeY=; b=zXGUDrab8jegP7
	8ty5kI0/4e71w30XlNbAo0+3QHL5OvaGwjfHl/BnnLaIOk64Rv07nhOcIC7FcwE/lstvuCjewuSSd
	wrE0P0f4vcuAKMT5dIbe8egcmfmNCfwb0w8yD3s7riPeHYlosmtFrVDY3ivUReLYYdtz+1HZwKsUu
	mv2wQZDgSZ7NIdT6iWGDkfZ7OwZ81zuRmn3Uz+uJWCYrxOWhvlrbrikH9wIHcJO1xRaDTPfkxRyFT
	Sq+S2E/BKSJqdWBFo0JLSWI+vZTvToP1OF6PUOyCM8oNcMWYaB1iiu/WpJzP9byQ1o+F5O1c+ZbmF
	WjjI4V9OTNoL/MBvNT3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGH0p-00BfAC-L7; Tue, 26 Jul 2022 09:37:59 +0000
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGH0X-00BeeM-Ub; Tue, 26 Jul 2022 09:37:43 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0VKUwhZc_1658828257;
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VKUwhZc_1658828257)
          by smtp.aliyun-inc.com;
          Tue, 26 Jul 2022 17:37:37 +0800
From: Xianting Tian <xianting.tian@linux.alibaba.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	anup@brainfault.org,
	heiko@sntech.de,
	guoren@kernel.org,
	mick@ics.forth.gr,
	alexandre.ghiti@canonical.com,
	bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com,
	corbet@lwn.net
Cc: kexec@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	crash-utility@redhat.com,
	huanyi.xj@alibaba-inc.com,
	heinrich.schuchardt@canonical.com,
	k-hagio-ab@nec.com,
	hschauhan@nulltrace.org,
	Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: [PATCH V4 4/5] RISC-V: Fixup getting correct current pc
Date: Tue, 26 Jul 2022 17:37:28 +0800
Message-Id: <20220726093729.1231867-5-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220726093729.1231867-1-xianting.tian@linux.alibaba.com>
References: <20220726093729.1231867-1-xianting.tian@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220726_023742_294336_A3F44839 
X-CRM114-Status: UNSURE (   9.16  )
X-CRM114-Notice: Please train this message.
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

When use 'echo c > /proc/sysrq-trigger' to trigger kdump, riscv_crash_save_regs()
will be called to save regs to vmcore, we found "epc" value 00ffffffa5537400
is not a valid kernel virtual address, but is a user virtual address. Other
regs(eg, ra, sp, gp...) are correct kernel virtual address.
Actually 0x00ffffffb0dd9400 is the user mode PC of 'PID: 113 Comm: sh', which
is saved in the task's stack.

[   21.201701] CPU: 0 PID: 113 Comm: sh Kdump: loaded Not tainted 5.18.9 #45
[   21.201979] Hardware name: riscv-virtio,qemu (DT)
[   21.202160] epc : 00ffffffa5537400 ra : ffffffff80088640 sp : ff20000010333b90
[   21.202435]  gp : ffffffff810dde38 tp : ff6000000226c200 t0 : ffffffff8032be7c
[   21.202707]  t1 : 0720072007200720 t2 : 30203a7375746174 s0 : ff20000010333cf0
[   21.202973]  s1 : 0000000000000000 a0 : ff20000010333b98 a1 : 0000000000000001
[   21.203243]  a2 : 0000000000000010 a3 : 0000000000000000 a4 : 28c8f0aeffea4e00
[   21.203519]  a5 : 28c8f0aeffea4e00 a6 : 0000000000000009 a7 : ffffffff8035c9b8
[   21.203794]  s2 : ffffffff810df0a8 s3 : ffffffff810df718 s4 : ff20000010333b98
[   21.204062]  s5 : 0000000000000000 s6 : 0000000000000007 s7 : ffffffff80c4a468
[   21.204331]  s8 : 00ffffffef451410 s9 : 0000000000000007 s10: 00aaaaaac0510700
[   21.204606]  s11: 0000000000000001 t3 : ff60000001218f00 t4 : ff60000001218f00
[   21.204876]  t5 : ff60000001218000 t6 : ff200000103338b8
[   21.205079] status: 0000000200000020 badaddr: 0000000000000000 cause: 0000000000000008

With the incorrect PC, the backtrace showed by crash tool as below, the first
stack frame is abnormal,

crash> bt
PID: 113      TASK: ff60000002269600  CPU: 0    COMMAND: "sh"
 #0 [ff2000001039bb90] __efistub_.Ldebug_info0 at 00ffffffa5537400 <-- Abnormal
 #1 [ff2000001039bcf0] panic at ffffffff806578ba
 #2 [ff2000001039bd50] sysrq_reset_seq_param_set at ffffffff8038c030
 #3 [ff2000001039bda0] __handle_sysrq at ffffffff8038c5f8
 #4 [ff2000001039be00] write_sysrq_trigger at ffffffff8038cad8
 #5 [ff2000001039be20] proc_reg_write at ffffffff801b7edc
 #6 [ff2000001039be40] vfs_write at ffffffff80152ba6
 #7 [ff2000001039be80] ksys_write at ffffffff80152ece
 #8 [ff2000001039bed0] sys_write at ffffffff80152f46

With the patch, we can get current kernel mode PC, the output as below,

[   17.607658] CPU: 0 PID: 113 Comm: sh Kdump: loaded Not tainted 5.18.9 #42
[   17.607937] Hardware name: riscv-virtio,qemu (DT)
[   17.608150] epc : ffffffff800078f8 ra : ffffffff8008862c sp : ff20000010333b90
[   17.608441]  gp : ffffffff810dde38 tp : ff6000000226c200 t0 : ffffffff8032be68
[   17.608741]  t1 : 0720072007200720 t2 : 666666666666663c s0 : ff20000010333cf0
[   17.609025]  s1 : 0000000000000000 a0 : ff20000010333b98 a1 : 0000000000000001
[   17.609320]  a2 : 0000000000000010 a3 : 0000000000000000 a4 : 0000000000000000
[   17.609601]  a5 : ff60000001c78000 a6 : 000000000000003c a7 : ffffffff8035c9a4
[   17.609894]  s2 : ffffffff810df0a8 s3 : ffffffff810df718 s4 : ff20000010333b98
[   17.610186]  s5 : 0000000000000000 s6 : 0000000000000007 s7 : ffffffff80c4a468
[   17.610469]  s8 : 00ffffffca281410 s9 : 0000000000000007 s10: 00aaaaaab5bb6700
[   17.610755]  s11: 0000000000000001 t3 : ff60000001218f00 t4 : ff60000001218f00
[   17.611041]  t5 : ff60000001218000 t6 : ff20000010333988
[   17.611255] status: 0000000200000020 badaddr: 0000000000000000 cause: 0000000000000008

With the correct PC, the backtrace showed by crash tool as below,

crash> bt
PID: 113      TASK: ff6000000226c200  CPU: 0    COMMAND: "sh"
 #0 [ff20000010333b90] riscv_crash_save_regs at ffffffff800078f8 <--- Normal
 #1 [ff20000010333cf0] panic at ffffffff806578c6
 #2 [ff20000010333d50] sysrq_reset_seq_param_set at ffffffff8038c03c
 #3 [ff20000010333da0] __handle_sysrq at ffffffff8038c604
 #4 [ff20000010333e00] write_sysrq_trigger at ffffffff8038cae4
 #5 [ff20000010333e20] proc_reg_write at ffffffff801b7ee8
 #6 [ff20000010333e40] vfs_write at ffffffff80152bb2
 #7 [ff20000010333e80] ksys_write at ffffffff80152eda
 #8 [ff20000010333ed0] sys_write at ffffffff80152f52

Fixes: e53d28180d4d ("RISC-V: Add kdump support")
Co-developed-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 arch/riscv/kernel/crash_save_regs.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/crash_save_regs.S b/arch/riscv/kernel/crash_save_regs.S
index 7832fb763aba..b2a1908c0463 100644
--- a/arch/riscv/kernel/crash_save_regs.S
+++ b/arch/riscv/kernel/crash_save_regs.S
@@ -44,7 +44,7 @@ SYM_CODE_START(riscv_crash_save_regs)
 	REG_S t6,  PT_T6(a0)	/* x31 */
 
 	csrr t1, CSR_STATUS
-	csrr t2, CSR_EPC
+	auipc t2, 0x0
 	csrr t3, CSR_TVAL
 	csrr t4, CSR_CAUSE
 
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
