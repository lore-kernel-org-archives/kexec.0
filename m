Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A893C4167B
	for <kexec@archiver.kernel.org>; Mon,  4 Dec 2023 10:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=h0q4+MHRlOl6qQtk63z4sE9o56aP3FG/jOYts7palIc=; b=M56wweXkXPprHf
	7KdksZPfuqMs1PwOdMWLlKm7LGJCJelPMLA2idcmehzGGJJ7roedltgaGRhUeW+l3MveL/0WBiTWa
	I1y+e18hP8vc+rzHuSIKjWtON8a9JLLRfKN22akAIQa3i6XojCK7XBo5/RejnPUbbR4WAxKPKLszT
	vcUJyrV7GWkxafM60JHL8Lg2YINOjm/RSqoTZUmIsptBz9UgsO8/+bkQDc8v3XJ5oaMkTGfU6K6LY
	/y+PkyodjtXT7dVoCtLnLsVcz9hITs2Yxv4wUfVSxA5pVOKyksgjFhqvGWQaD7Ble4J6suLU4lzY7
	vbwHcDIWoSTzfvVOdqRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rA6Yj-003aDD-0o;
	Mon, 04 Dec 2023 10:52:17 +0000
Received: from bg4.exmail.qq.com ([43.155.67.158])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rA6Yc-003aC7-1y
	for kexec@lists.infradead.org;
	Mon, 04 Dec 2023 10:52:15 +0000
X-QQ-mid: bizesmtp69t1701687053t1o89dv3
Received: from localhost.localdomain ( [58.240.82.166])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 04 Dec 2023 18:50:51 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: f+ZzKTjTzV3mOc4r9pIU5vH4SLyW7FoVwXxvAeKIHBykbPDEKYM6jbFqIH73M
	RIiAsR8da2wHfeTdtdwxS8ETE2q1KNkcBrW6JdLGzRwrnB0CePoH2FmVBrTbr44R7xWNsz8
	vzoMVJ15TGTAkLFoZyF3I901NaoSy7v8eo+K3JOV1xjnd1tQFWxeb+D7Hsfj8fJJNe6uKwF
	LBxN7mdzL6kGgAMKO2ojuILRTQ6kLtOGx2Qu4ggBO7a6MYZpx6OV/Vmc/on3akX1Rwd4ayt
	Afdw30VViHhF+A9k3Z1Eh8pbNF5f1nqmRSUymqe4kt1DKilswxY4QaRgtbawGFOn+i3RCRB
	NXSOiZKm2uk6o1as1nPtfi3HFaf+w==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3060734497869231758
From: Song Shuai <songshuaishuai@tinylab.org>
To: xianting.tian@linux.alibaba.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org,
	crash-utility@redhat.com
Cc: Song Shuai <songshuaishuai@tinylab.org>
Subject: [PATCH 1/2] [Crash-utility] RISCV64: Dump NT_PRSTATUS in 'help -n'
Date: Mon,  4 Dec 2023 18:50:14 +0800
Message-Id: <20231204105015.2341055-1-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_025211_064902_FD278DDE 
X-CRM114-Status: UNSURE (   8.60  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

With the patch we can get full dump of "struct elf_prstatus" in 'help -n':

```
crash> help -n
<snip>
Elf64_Nhdr:
               n_namesz: 5 ("CORE")
               n_descsz: 376
                 n_type: 1 (NT_PRSTATUS)
                         si.signo: 0  si.code: 0  si.errno: 0
                         cursig: 0  sigpend: 0  sighold: 0
                         pid: 0  ppid: 0  pgrp: 0  sid:0
                         utime: 0.000000  stime: 0.000000
                         cutime: 0.000000  cstime: 0.000000
                         epc: ffffffff80822426   ra: ffffffff80822422 sp: ff20000000093f20
                          gp: ffffffff814ee2a8   tp: ff60000000104800 t0: ff2000000027bb18
                          t1: 0000000000000088   t2: 0000000000000000 s0: ff20000000093f30
                          s1: 0000000000000001   a0: 0000000000000004 a1: 0000000000000008
                          a2: ff6000009e9f0000   a3: 0000000000005fe4 a4: ffffffff80c1c290
                          a5: 0000000000000000   a6: ff6000001f60a6b0 a7: 00000088e4450548
                          s2: ffffffff814ef220   s3: 0000000000000002 s4: 000000000000003f
                          s8: ffffffff814ef3d8   s9: 0000000000000000 s10: ffffffff814ef0d0
                         s11: ffffffff81525d10   t3: ffffffff80c1d840 t4: 0000000000000000
                          t5: 0000000000000001   t6: 00000000000000aa
                         0000000000000000 0000000000000000
                         0000000000000000 0000000000000000
                         0000000000000000 0000000000000000
                         0000000000000000 0000000000000000
                         0000000000000000 0000000000000000
                         0000000000000000 0000000000000000
                         0000000000000000 0000000000000000
                         ffffffff80822426 ffffffff80822422
                         ff20000000093f20 ffffffff814ee2a8
                         ff60000000104800 ff2000000027bb18
<snip>
```

Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
---
 netdump.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/netdump.c b/netdump.c
index 3907863..b266b27 100644
--- a/netdump.c
+++ b/netdump.c
@@ -2578,6 +2578,8 @@ dump_Elf64_Nhdr(Elf64_Off offset, int store)
 				display_ELF_note(EM_PPC64, PRSTATUS_NOTE, note, nd->ofp);
 			if (machine_type("ARM64") && (note->n_type == NT_PRSTATUS))
 				display_ELF_note(EM_AARCH64, PRSTATUS_NOTE, note, nd->ofp);
+			if (machine_type("RISCV64") && (note->n_type == NT_PRSTATUS))
+				display_ELF_note(EM_RISCV, PRSTATUS_NOTE, note, nd->ofp);
 		}
 		for (i = lf = 0; i < note->n_descsz/sizeof(ulonglong); i++) {
 			if (((i%2)==0)) {
@@ -3399,6 +3401,79 @@ display_prstatus_arm64(void *note_ptr, FILE *ofp)
 		space(sp), pr->pr_reg[33], pr->pr_fpvalid);
 }
 
+struct riscv64_elf_siginfo {
+    int si_signo;
+    int si_code;
+    int si_errno;
+};
+
+struct riscv64_elf_prstatus {
+    struct riscv64_elf_siginfo pr_info;
+    short pr_cursig;
+    unsigned long pr_sigpend;
+    unsigned long pr_sighold;
+    pid_t pr_pid;
+    pid_t pr_ppid;
+    pid_t pr_pgrp;
+    pid_t pr_sid;
+    struct timeval pr_utime;
+    struct timeval pr_stime;
+    struct timeval pr_cutime;
+    struct timeval pr_cstime;
+/*  elf_gregset_t pr_reg; => typedef struct user_regs_struct elf_gregset_t; */
+    unsigned long pr_reg[32];
+    int pr_fpvalid;
+};
+
+static void
+display_prstatus_riscv64(void *note_ptr, FILE *ofp)
+{
+	struct riscv64_elf_prstatus *pr;
+	Elf64_Nhdr *note;
+	int sp;
+
+	note = (Elf64_Nhdr *)note_ptr;
+	pr = (struct riscv64_elf_prstatus *)(
+		(char *)note + sizeof(Elf64_Nhdr) + note->n_namesz);
+	pr = (struct riscv64_elf_prstatus *)roundup((ulong)pr, 4);
+	sp = nd->num_prstatus_notes ? 25 : 22;
+
+	fprintf(ofp,
+		"%ssi.signo: %d  si.code: %d  si.errno: %d\n"
+		"%scursig: %d  sigpend: %lx  sighold: %lx\n"
+		"%spid: %d  ppid: %d  pgrp: %d  sid:%d\n"
+		"%sutime: %01lld.%06d  stime: %01lld.%06d\n"
+		"%scutime: %01lld.%06d  cstime: %01lld.%06d\n",
+		space(sp), pr->pr_info.si_signo, pr->pr_info.si_code, pr->pr_info.si_errno,
+		space(sp), pr->pr_cursig, pr->pr_sigpend, pr->pr_sighold,
+		space(sp), pr->pr_pid, pr->pr_ppid, pr->pr_pgrp, pr->pr_sid,
+		space(sp), (long long)pr->pr_utime.tv_sec, (int)pr->pr_utime.tv_usec,
+		(long long)pr->pr_stime.tv_sec, (int)pr->pr_stime.tv_usec,
+		space(sp), (long long)pr->pr_cutime.tv_sec, (int)pr->pr_cutime.tv_usec,
+		(long long)pr->pr_cstime.tv_sec, (int)pr->pr_cstime.tv_usec);
+	fprintf(ofp,
+		"%sepc: %016lx   ra: %016lx   sp: %016lx\n"
+		"%s gp: %016lx   tp: %016lx   t0: %016lx\n"
+		"%s t1: %016lx   t2: %016lx   s0: %016lx\n"
+		"%s s1: %016lx   a0: %016lx   a1: %016lx\n"
+		"%s a2: %016lx   a3: %016lx   a4: %016lx\n"
+		"%s a5: %016lx   a6: %016lx   a7: %016lx\n"
+		"%s s2: %016lx   s3: %016lx   s4: %016lx\n"
+		"%s s8: %016lx   s9: %016lx  s10: %016lx\n"
+		"%ss11: %016lx   t3: %016lx   t4: %016lx\n"
+		"%s t5: %016lx   t6: %016lx\n",
+		space(sp), pr->pr_reg[0], pr->pr_reg[1], pr->pr_reg[2],
+		space(sp), pr->pr_reg[3], pr->pr_reg[4], pr->pr_reg[5],
+		space(sp), pr->pr_reg[6], pr->pr_reg[7], pr->pr_reg[8],
+		space(sp), pr->pr_reg[9], pr->pr_reg[10], pr->pr_reg[11],
+		space(sp), pr->pr_reg[12], pr->pr_reg[13], pr->pr_reg[14],
+		space(sp), pr->pr_reg[15], pr->pr_reg[16], pr->pr_reg[17],
+		space(sp), pr->pr_reg[18], pr->pr_reg[19], pr->pr_reg[20],
+		space(sp), pr->pr_reg[21], pr->pr_reg[22], pr->pr_reg[23],
+		space(sp), pr->pr_reg[24], pr->pr_reg[25], pr->pr_reg[26],
+		space(sp), pr->pr_reg[27], pr->pr_reg[28], pr->pr_reg[29],
+		space(sp), pr->pr_reg[30], pr->pr_reg[31]);
+}
 
 void
 display_ELF_note(int machine, int type, void *note, FILE *ofp)
@@ -3449,6 +3524,14 @@ display_ELF_note(int machine, int type, void *note, FILE *ofp)
 			break;
 		}
 		break;
+	case EM_RISCV:
+		switch (type)
+		{
+		case PRSTATUS_NOTE:
+			display_prstatus_riscv64(note, ofp);
+			break;
+		}
+		break;
 
 	default:
 		return;
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
