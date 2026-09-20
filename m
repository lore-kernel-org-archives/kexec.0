Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D648FC982F0
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gjdNKKGx+yhFaJeCA90Rv+NyjnhIa6+HpCMo5c2ikFg=; b=AJy3xQc8kq+Bu77Ph2K2PouyNq
	tx1YuUNKFr3b0dfUAnz8aeK01xdY8j4Q2KxiZmYVUhPBRsbygpSwk3eVt8WrFBuqFHabHV57aa9LA
	ZwjgTB8H+cgN/y8IBxVvgrePyH4QjIjzu+hm40U9PP3+yuZBg/DxOowQXg6nnxmBV/jDUsXNR/T3y
	hHQCLiUOH4y/p/irbeDq0BjLJ1SB9O3FRorlQEUbhct6lHuTtCBjKEgeWpzreO8Ci9dUr7/lSimvg
	uhwPuFfIjFy7xm4AmZRakEUwYXmpiY3lkpZqFjqUu5P8MVAWQmhSxfXjgPwV/RxfqaVELzrhFGEQT
	eqCg1Z+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O4L-00000000MFR-3yLC;
	Sun, 20 Sep 2026 20:23:25 +0000
Received: from mail-yx2-x0f.google.com ([2607:f8b0:4864:41::f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8NLe-00000000IKg-27bO
	for kexec@lists.infradead.org;
	Sun, 20 Sep 2026 19:37:16 +0000
Received: by mail-yx2-x0f.google.com with SMTP id 00721157ae682-85d43ac8d1dso14784017b3.3
        for <kexec@lists.infradead.org>; Sun, 20 Sep 2026 12:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1789933033; x=1790537833; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gjdNKKGx+yhFaJeCA90Rv+NyjnhIa6+HpCMo5c2ikFg=;
        b=OsC8DHQPbsuT0YVfcDhVHSS7z4784uLD5N513DlQGBD9iTenHwqqyhhyzigoVqEhtV
         najt8mAWyfONRMjpWr5f+g1Giw3mv3yoHFbgI8644EygfmgQTECN2aw1WTmXowt/Me4I
         fLDsZHHVpoXwFFocDN4aZVrSDZagX3tuEFMXA3jPwej4nOBOV8z661RuR/+Mj8D8urkQ
         iqY1w5kgOqhSwe9gB9To9aCWB4sHKe+mCCekfrKiBGMiQWfUrQ9xlHPqjLrf6moHM1jV
         wWyub0yeuydlkubvP9xhPCmIGafuFu1f6Qhlc9yqFEdzDl/uuC20YKTKkcPDBtb9LvEq
         8sUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933033; x=1790537833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gjdNKKGx+yhFaJeCA90Rv+NyjnhIa6+HpCMo5c2ikFg=;
        b=SxV0oFM5q8Rs1bsj/Ncpy8LL0XopPjyC00zGNW6D17g4eAnmhVpVSJ3x4Bil4CO3N9
         gl3P49DuUKmNUa24eKpQ4byjNDgf5biJQkkCYgZO9e2yIB2ehdOUVjoAxPpfAY7xRhkd
         J51LpbSyh52fOe4je6UNSy9a9sN8dC44LtknY7OnmpV5K7zr1EtLwuH2Uhy/a7pQ+irR
         tZx2CGc4ZGzoYyg99zDOXfRhwYtNscftU3sd4+pmHmEuoQmvKJA65VgM0H/xxryk7ki7
         P4VgFAlC+jsYc2OR5xdpnQsPLExBV3ADrLdC9TZyuLFy2UkaFmp3xNR3H2nKD3+GqGh9
         4J+g==
X-Forwarded-Encrypted: i=1; AKwUvBwBscSI8nzKj1QNke9AVYfSlBbvnaBIn00XFp2UVIsfrQS8h/tr37M1arKfD8/7ZD1Q6lb+vw==@lists.infradead.org
X-Gm-Message-State: AFuF++mlPqpBDzy0SDh3AfmkvG3YEC3M3aNAAvCP6An5nCU69F8rAjcz
	p2JIV3cMJ+/6Jiet9AYTVbFU+dcfHPNZkWQPaYHklKcoyxfVOYpIix21yLUoZ9zT9h8=
X-Gm-Gg: AYBFou3A2I87XqYOyyMekC8eV+C1cmErXaZj5tguiRcHvAx4XMKL7iPQqpL7rPDekjc
	GUgmpkVGc1TMux2sGcTeZbvUSNmyF/U4rrGnplEvKct7tOqRM4L9Ls2jkHsIC7yV2N9fBXN2rjn
	re7FoyOsrqiz/+qdNuzvlOmhoQFa5I+XmQfvSk2dwh08j2SywSSdlSVSK2urtlSbmImDGN7tK/J
	QDyCoohUgX6hFX0gz0kf/s2q+0aAe0nnenLUgW2ZoPuoTRHcaLBv3zgPF+M+QTtp6gjKJuz41un
	28+8XQQ4K1KNyYWAnnjzTrc20jJ+nQJHAMuDVhzATZTt0GypXJf3SyL0vtYSGCEn15Po90wkaks
	oWz5kq21Y4ejbUM9QZzH7GPFq1+bDo5+b5ckcstT7npIz4ThgRqaRz6fEiZGC9FPWGJMM3bVh1j
	JdD1iHJGK6RdFupDT9l/4PgNtLAO2ALFsas46CvEOCIEMVUeCc9czu80JiOBBGw8G5ZyFtoKEUo
	mLoPHq4BVrRRgp8BnAJOHct5axBtojZmXGDnaMevO2f1iHimOcTatkCJpLcJkmCwZvj8Rb2mp6z
	45mrtrirohPaMJgyO6A=
X-Received: by 2002:a05:690c:9988:b0:89b:5551:4305 with SMTP id 00721157ae682-89b5560974dmr13921117b3.17.1789933033098;
        Sun, 20 Sep 2026 12:37:13 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-89a48aab042sm18596427b3.47.2026.09.20.12.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:37:12 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	legion@kernel.org,
	kees@kernel.org,
	will@kernel.org,
	ruanjinjie@huawei.com,
	atomlin@atomlin.com,
	rppt@kernel.org,
	jani.nikula@intel.com,
	hamzamahfooz@linux.microsoft.com,
	joey.gouly@arm.com,
	tglx@kernel.org,
	nsc@kernel.org,
	alexandre.chartre@oracle.com,
	james.morse@arm.com,
	dianders@chromium.org,
	bp@alien8.de,
	jpoimboe@kernel.org,
	shuah@kernel.org,
	catalin.marinas@arm.com,
	linux-kbuild@vger.kernel.org,
	linux-arch@vger.kernel.org,
	kvmarm@lists.linux.dev,
	jaredwhite@microsoft.com,
	johan@kernel.org,
	pbonzini@redhat.com,
	mingo@redhat.com,
	linux-mm@kvack.org,
	seanjc@google.com,
	mark.rutland@arm.com,
	vdonnefort@google.com,
	tarunsahu@google.com,
	gshan@redhat.com,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	xur@google.com,
	djbw@kernel.org,
	oupton@kernel.org,
	nogikh@google.com,
	sumitg@nvidia.com,
	linux-kernel@vger.kernel.org,
	zengheng4@huawei.com,
	peterz@infradead.org,
	corbet@lwn.net,
	suzuki.poulose@arm.com,
	luto@kernel.org,
	hpa@zytor.com,
	zhangpengjie2@huawei.com,
	x86@kernel.org,
	yuzenghui@huawei.com,
	jic23@kernel.org,
	ardb@kernel.org,
	pasha.tatashin@soleen.com,
	petr.pavlu@suse.com,
	ryan.roberts@arm.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	dave.hansen@linux.intel.com,
	rdunlap@infradead.org,
	kvm@vger.kernel.org,
	fuad.tabba@linux.dev,
	maz@kernel.org,
	mbenes@suse.cz,
	jgross@suse.com,
	seiden@linux.ibm.com,
	pierre.gondois@arm.com,
	song@kernel.org,
	nathan@kernel.org,
	pmladek@suse.com,
	graf@amazon.com,
	chao.gao@intel.com,
	zhenglifeng1@huawei.com,
	arnd@arndb.de,
	sidnayyar@google.com,
	linux-arm-kernel@lists.infradead.org,
	vladimir.murzin@arm.com,
	kas@kernel.org
Subject: [RFC PATCH 03/46] KVM: arm64: Split kvm_sys_reg_{get,set}_user from kernel accessors
Date: Sun, 20 Sep 2026 15:36:07 -0400
Message-ID: <20260920193650.3373435-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
References: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_123714_572514_EC4299A1 
X-CRM114-Status: GOOD (  18.44  )
X-Mailman-Approved-At: Sun, 20 Sep 2026 13:23:19 -0700
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

Factor __kvm_sys_reg_get() and __kvm_sys_reg_set() out of the userspace
ioctl handlers and introduce struct sys_reg_index_sink so in-kernel
callers can enumerate, read, and write architectural system registers
via kvm_arm_get_sys_reg_indices(), kvm_arm_sys_reg_read(), and
kvm_arm_sys_reg_write().

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kvm/sys_regs.c | 199 ++++++++++++++++++++++++++++++--------
 arch/arm64/kvm/sys_regs.h |   4 +
 2 files changed, 160 insertions(+), 43 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index b873ccf1ab14..0049e460e5ad 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -5569,38 +5569,43 @@ static int demux_c15_set(struct kvm_vcpu *vcpu, u64 id, void __user *uaddr)
 	return demux_c15_set_val(vcpu, id, newval);
 }
 
-static u64 kvm_one_reg_to_id(const struct kvm_one_reg *reg)
+static u64 kvm_one_reg_to_id(u64 reg_id)
 {
-	switch(reg->id) {
+	switch (reg_id) {
 	case KVM_REG_ARM_TIMER_CVAL:
 		return TO_ARM64_SYS_REG(CNTV_CVAL_EL0);
 	case KVM_REG_ARM_TIMER_CNT:
 		return TO_ARM64_SYS_REG(CNTVCT_EL0);
 	default:
-		return reg->id;
+		return reg_id;
 	}
 }
 
-int kvm_sys_reg_get_user(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg,
-			 const struct sys_reg_desc table[], unsigned int num)
+static int __kvm_sys_reg_get(struct kvm_vcpu *vcpu, u64 reg_id, u64 *val,
+			     const struct sys_reg_desc table[], unsigned int num)
 {
-	u64 __user *uaddr = (u64 __user *)(unsigned long)reg->addr;
 	const struct sys_reg_desc *r;
-	u64 id = kvm_one_reg_to_id(reg);
-	u64 val;
-	int ret;
+	u64 id = kvm_one_reg_to_id(reg_id);
 
 	r = id_to_sys_reg_desc(vcpu, id, table, num);
 	if (!r || sysreg_hidden(vcpu, r))
 		return -ENOENT;
 
-	if (r->get_user) {
-		ret = (r->get_user)(vcpu, r, &val);
-	} else {
-		val = __vcpu_sys_reg(vcpu, r->reg);
-		ret = 0;
-	}
+	if (r->get_user)
+		return (r->get_user)(vcpu, r, val);
+
+	*val = __vcpu_sys_reg(vcpu, r->reg);
+	return 0;
+}
+
+int kvm_sys_reg_get_user(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg,
+			 const struct sys_reg_desc table[], unsigned int num)
+{
+	u64 __user *uaddr = (u64 __user *)(unsigned long)reg->addr;
+	u64 val;
+	int ret;
 
+	ret = __kvm_sys_reg_get(vcpu, reg->id, &val, table, num);
 	if (!ret)
 		ret = put_user(val, uaddr);
 
@@ -5618,17 +5623,11 @@ int kvm_arm_sys_reg_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg
 				    sys_reg_descs, ARRAY_SIZE(sys_reg_descs));
 }
 
-int kvm_sys_reg_set_user(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg,
-			 const struct sys_reg_desc table[], unsigned int num)
+static int __kvm_sys_reg_set(struct kvm_vcpu *vcpu, u64 reg_id, u64 val,
+			     const struct sys_reg_desc table[], unsigned int num)
 {
-	u64 __user *uaddr = (u64 __user *)(unsigned long)reg->addr;
 	const struct sys_reg_desc *r;
-	u64 id = kvm_one_reg_to_id(reg);
-	u64 val;
-	int ret;
-
-	if (get_user(val, uaddr))
-		return -EFAULT;
+	u64 id = kvm_one_reg_to_id(reg_id);
 
 	r = id_to_sys_reg_desc(vcpu, id, table, num);
 	if (!r || sysreg_hidden(vcpu, r))
@@ -5637,14 +5636,23 @@ int kvm_sys_reg_set_user(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg,
 	if (sysreg_user_write_ignore(vcpu, r))
 		return 0;
 
-	if (r->set_user) {
-		ret = (r->set_user)(vcpu, r, val);
-	} else {
-		__vcpu_assign_sys_reg(vcpu, r->reg, val);
-		ret = 0;
-	}
+	if (r->set_user)
+		return (r->set_user)(vcpu, r, val);
 
-	return ret;
+	__vcpu_assign_sys_reg(vcpu, r->reg, val);
+	return 0;
+}
+
+int kvm_sys_reg_set_user(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg,
+			 const struct sys_reg_desc table[], unsigned int num)
+{
+	u64 __user *uaddr = (u64 __user *)(unsigned long)reg->addr;
+	u64 val;
+
+	if (get_user(val, uaddr))
+		return -EFAULT;
+
+	return __kvm_sys_reg_set(vcpu, reg->id, val, table, num);
 }
 
 int kvm_arm_sys_reg_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
@@ -5688,25 +5696,24 @@ static u64 sys_reg_to_index(const struct sys_reg_desc *reg)
 		(reg->Op2 << KVM_REG_ARM64_SYSREG_OP2_SHIFT));
 }
 
-static bool copy_reg_to_user(const struct sys_reg_desc *reg, u64 __user **uind)
+static u64 reg_to_user_idx(const struct sys_reg_desc *reg)
 {
-	u64 idx;
-
-	if (!*uind)
-		return true;
-
 	switch (reg_to_encoding(reg)) {
 	case SYS_CNTV_CVAL_EL0:
-		idx = KVM_REG_ARM_TIMER_CVAL;
-		break;
+		return KVM_REG_ARM_TIMER_CVAL;
 	case SYS_CNTVCT_EL0:
-		idx = KVM_REG_ARM_TIMER_CNT;
-		break;
+		return KVM_REG_ARM_TIMER_CNT;
 	default:
-		idx = sys_reg_to_index(reg);
+		return sys_reg_to_index(reg);
 	}
+}
 
-	if (put_user(idx, *uind))
+static bool copy_reg_to_user(const struct sys_reg_desc *reg, u64 __user **uind)
+{
+	if (!*uind)
+		return true;
+
+	if (put_user(reg_to_user_idx(reg), *uind))
 		return false;
 
 	(*uind)++;
@@ -5986,3 +5993,109 @@ int __init kvm_sys_reg_table_init(void)
 
 	return ret;
 }
+
+/* The GICv3 CPU interface sysregs, or NULL if the in-kernel GICv3 is unused. */
+static const struct sys_reg_desc *vcpu_gic_sysreg_table(struct kvm_vcpu *vcpu,
+							unsigned int *num)
+{
+	if (!irqchip_in_kernel(vcpu->kvm) ||
+	    vcpu->kvm->arch.vgic.vgic_model != KVM_DEV_TYPE_ARM_VGIC_V3)
+		return NULL;
+
+	return vgic_v3_get_sysreg_table(num);
+}
+
+static void collect_table_indices(struct kvm_vcpu *vcpu,
+				  const struct sys_reg_desc *table,
+				  unsigned int num, u64 **out, int *count)
+{
+	unsigned int i;
+
+	for (i = 0; i < num; i++) {
+		const struct sys_reg_desc *rd = &table[i];
+
+		if (!(rd->reg || rd->get_user) || sysreg_hidden(vcpu, rd))
+			continue;
+		if (*out)
+			*(*out)++ = reg_to_user_idx(rd);
+		(*count)++;
+	}
+}
+
+/*
+ * Enumerate every system register that kvm_arm_sys_reg_read() can return for
+ * @vcpu.  This is a superset of KVM_GET_REG_LIST: it also covers the GICv3 CPU
+ * interface table, which has no uAPI representation.  Pass a NULL @indices to
+ * query the number of entries the array needs to hold.
+ */
+int kvm_arm_get_sys_reg_indices(struct kvm_vcpu *vcpu, u64 *indices)
+{
+	const struct sys_reg_desc *gic_regs;
+	unsigned int sz = 0, i;
+	int count = 0;
+
+	collect_table_indices(vcpu, sys_reg_descs, ARRAY_SIZE(sys_reg_descs),
+			      &indices, &count);
+
+	gic_regs = vcpu_gic_sysreg_table(vcpu, &sz);
+	if (gic_regs)
+		collect_table_indices(vcpu, gic_regs, sz, &indices, &count);
+
+	for (i = 0; i < CSSELR_MAX; i++) {
+		if (indices)
+			*indices++ = KVM_REG_ARM64 | KVM_REG_SIZE_U32 |
+				     KVM_REG_ARM_DEMUX |
+				     KVM_REG_ARM_DEMUX_ID_CCSIDR | i;
+		count++;
+	}
+
+	return count;
+}
+
+int kvm_arm_sys_reg_read(struct kvm_vcpu *vcpu, u64 reg_id, u64 *val)
+{
+	const struct sys_reg_desc *gic_regs;
+	unsigned int sz = 0;
+	int ret;
+
+	if ((reg_id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_DEMUX) {
+		u32 uval;
+
+		ret = demux_c15_get_val(vcpu, reg_id, &uval);
+		if (!ret)
+			*val = uval;
+		return ret;
+	}
+
+	ret = __kvm_sys_reg_get(vcpu, reg_id, val, sys_reg_descs,
+				ARRAY_SIZE(sys_reg_descs));
+	if (ret != -ENOENT)
+		return ret;
+
+	gic_regs = vcpu_gic_sysreg_table(vcpu, &sz);
+	if (!gic_regs)
+		return ret;
+
+	return __kvm_sys_reg_get(vcpu, reg_id, val, gic_regs, sz);
+}
+
+int kvm_arm_sys_reg_write(struct kvm_vcpu *vcpu, u64 reg_id, u64 val)
+{
+	const struct sys_reg_desc *gic_regs;
+	unsigned int sz = 0;
+	int ret;
+
+	if ((reg_id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_DEMUX)
+		return demux_c15_set_val(vcpu, reg_id, (u32)val);
+
+	ret = __kvm_sys_reg_set(vcpu, reg_id, val, sys_reg_descs,
+				ARRAY_SIZE(sys_reg_descs));
+	if (ret != -ENOENT)
+		return ret;
+
+	gic_regs = vcpu_gic_sysreg_table(vcpu, &sz);
+	if (!gic_regs)
+		return ret;
+
+	return __kvm_sys_reg_set(vcpu, reg_id, val, gic_regs, sz);
+}
diff --git a/arch/arm64/kvm/sys_regs.h b/arch/arm64/kvm/sys_regs.h
index bd56a45abbf9..9837db99909b 100644
--- a/arch/arm64/kvm/sys_regs.h
+++ b/arch/arm64/kvm/sys_regs.h
@@ -292,4 +292,8 @@ int kvm_finalize_sys_regs(struct kvm_vcpu *vcpu);
 					      sys_reg_CRm(SYS_ ## r),	\
 					      sys_reg_Op2(SYS_ ## r))
 
+int kvm_arm_get_sys_reg_indices(struct kvm_vcpu *vcpu, u64 *indices);
+int kvm_arm_sys_reg_read(struct kvm_vcpu *vcpu, u64 reg_id, u64 *val);
+int kvm_arm_sys_reg_write(struct kvm_vcpu *vcpu, u64 reg_id, u64 val);
+
 #endif /* __ARM64_KVM_SYS_REGS_LOCAL_H__ */
-- 
2.55.0.1082.g2b9226bbc0-goog


