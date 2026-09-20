Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5E95C982EB
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wVwJQFyVies0sN36ZwALD03xlxJgg7HjR5Oz9PMtlp0=; b=q2GYCg214KPIuyytuXQW4T9SS8
	kjVMzhc1JT/BGgFOvs2LCXJQCCORGOsvmagZbemT0lMpqkuN9woXETN6wY4wQ94j1b30xGEfAn8Gt
	6IoCxOnT4gsyRwy9HvQvTPmWoB9BADHSsSU/vCrsuhexK4W6y2KX+1A5TZyjUQXhG+8gZbIR0/VZn
	ySyyfaDIpKiFWh91VLT3rQx1vNX0OEyRFsTaUCZqjxpQ0WHWNkNYbwEg35uxEh1EMRMY8HqlC/Wjr
	75En5NSVJ0wmtyVI7xOyN6la5eSqMNC4BjdpkPM+8FanLLb5DqXsxtZ9kCe5ybSu177ojhYOmgCTU
	lfdVBzRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O4L-00000000MFJ-3VIc;
	Sun, 20 Sep 2026 20:23:25 +0000
Received: from mail-yx2-x1a.google.com ([2607:f8b0:4864:41::1a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8NLY-00000000IHm-2ZAg
	for kexec@lists.infradead.org;
	Sun, 20 Sep 2026 19:37:09 +0000
Received: by mail-yx2-x1a.google.com with SMTP id 00721157ae682-85d4ddd1d91so15237987b3.1
        for <kexec@lists.infradead.org>; Sun, 20 Sep 2026 12:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1789933027; x=1790537827; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wVwJQFyVies0sN36ZwALD03xlxJgg7HjR5Oz9PMtlp0=;
        b=i0oeu1zJMO69y2obmq85JKFLSFIsXHR9GPeJhw2T+7BYPZ8ILHAkaVe/KVhDqw4RFm
         GeNrAOsTYv0thmwObE4kLZ6rfKQZhoYcm3J/iY4eG6QwltseDSfW+gjBvDjRNxRoxXLo
         Vk+EQFVQ89LClbmLY34oKncaT4XK5ft5+YmHXCqHAqkZMcbUwWrwOZpmzC/YBs/WemNO
         lUhl5ONM0hbxc/GQCDoIdJF81omh8EJ2g/dlDQ7V+32ATXbceLlHJEyYCzvCkH4l/J8n
         A1y11Ct6YcvjtlKv/sA6rk/Ow66adLBxTwgR76cvxNE2Wsi0JuxmdErJyYZmcI7g0PVw
         G/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933027; x=1790537827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wVwJQFyVies0sN36ZwALD03xlxJgg7HjR5Oz9PMtlp0=;
        b=PS132kc5Y/9Uvar+7UOenqkYCqDCyQDboLFiv3juVmQ1/Qo31IXknFMnPPgMvpDMPw
         4GV4YG8v8fw37G39xtXkscIUQ91G0vjIMFQ6ZuwtEW2b0pMvjSyq1EIKEy0A4bY46waL
         gQbai/GUKszZ6/nKiLNywyXrVJSfc8WPV5YVE2iIXSoeyc03OXDjanTvA6qE6A2p4m6o
         XG8mCDsDa5zx8wHV4M6MQirnnkbFoK7hH9xA7dAyfl/PCbJB9ApvHvhWuj1GQNeSTARs
         TRowdvgAND7uVKBroNYhEUmAcNjq2Ryof5zZNZa5ZXFLANd2m6t5X8CAQ7wqHa05VQiG
         LQ1w==
X-Forwarded-Encrypted: i=1; AKwUvBzBivd+Fc7H6KBnLo1QlIqhozgJCGnrx6PY5grEj8ley93XVxHLZR5hmBmQdisJp+xi9Bwpjw==@lists.infradead.org
X-Gm-Message-State: AFuF++nFONI+Pxuxm32DyWc/W/pC/9SW0zSv0lltD2yDCsDMeY2H3wWO
	xzy5j6sVRnqrxE/wfeUO74Cq6pQxMQ/aYJgq5QoixQkdjjQ2MOuZ0JdIGYDTeu7Eg3Q=
X-Gm-Gg: AYBFou1w01JK3x6tYHtZGGWmzi1Zt4p/2CSKG1JrrIhqff8PQqCzJZ7+iKrN8OLNT0r
	9f3kY+XdC6T98e6r2O4MoEX5THWmdfX37fhiZ5VVLReB25TcmK2HLacvzXnwrjmQ6WepNBhgACC
	H1kLWAP+gYxEu2Q1BCDsxy4OcwZfms8ORyJ6gAPy6SJQ6tpouZ5uO8Ycd1hKW1myadlhw6DYlJI
	ENyzuwRLg0Cf5HSCa/n1CZgOI+BGspqid5e21mrqas/9sZkOg7BPq5VQsjPN0ZGOuQK7qJf8B/R
	7F7uiEaey5/L3iapxmAgY+NMxEkg/TMMKUeryKda8akvW81udmw8xPhz3x/4eU75rvWl+fFuQHJ
	1KnNnm0nwWedoX2sWYMDEWr93ZMC15BEXlJiWa0fL+NufsBJdtTp2HGeKr4IX2cmCvmUI+mSh/P
	tlrNW0ifV6HdWvJ1icoNw0YqGLEIuZSfsz6JTBL3rCs9ScVCtbm18STg8Q9K6PbCPTOiFSOHM+g
	fDi/Jf71Q0Oiv6TcKkifryDqFSzvUNM66317Q6OV7Miim3GaDHm0aNgqTsnH/jDxJkzMVyOwWQJ
	0uigZZn0qZk633YP/uI=
X-Received: by 2002:a05:690c:89:b0:89a:63da:cbe1 with SMTP id 00721157ae682-89a63dacc8fmr20430637b3.39.1789933027324;
        Sun, 20 Sep 2026 12:37:07 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-89a47139db2sm18450487b3.26.2026.09.20.12.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:37:06 -0700 (PDT)
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
Subject: [RFC PATCH 02/46] KVM: arm64: Split demux_c15_{get,set}_val from userspace accessors
Date: Sun, 20 Sep 2026 15:36:06 -0400
Message-ID: <20260920193650.3373435-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
References: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_123708_658152_AB7066DD 
X-CRM114-Status: GOOD (  10.53  )
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

Factor demux_c15_get_val() and demux_c15_set_val() out of demux_c15_get()
and demux_c15_set() so kernel callers can read and write demultiplexed
coprocessor registers without going through userspace pointers.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kvm/sys_regs.c | 48 +++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 44aae52c473d..b873ccf1ab14 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -5496,10 +5496,9 @@ id_to_sys_reg_desc(struct kvm_vcpu *vcpu, u64 id,
 	return r;
 }
 
-static int demux_c15_get(struct kvm_vcpu *vcpu, u64 id, void __user *uaddr)
+static int demux_c15_get_val(struct kvm_vcpu *vcpu, u64 id, u32 *val)
 {
-	u32 val;
-	u32 __user *uval = uaddr;
+	u32 idx;
 
 	/* Fail if we have unknown bits set. */
 	if (id & ~(KVM_REG_ARCH_MASK|KVM_REG_SIZE_MASK|KVM_REG_ARM_COPROC_MASK
@@ -5510,21 +5509,34 @@ static int demux_c15_get(struct kvm_vcpu *vcpu, u64 id, void __user *uaddr)
 	case KVM_REG_ARM_DEMUX_ID_CCSIDR:
 		if (KVM_REG_SIZE(id) != 4)
 			return -ENOENT;
-		val = (id & KVM_REG_ARM_DEMUX_VAL_MASK)
+		idx = (id & KVM_REG_ARM_DEMUX_VAL_MASK)
 			>> KVM_REG_ARM_DEMUX_VAL_SHIFT;
-		if (val >= CSSELR_MAX)
+		if (idx >= CSSELR_MAX)
 			return -ENOENT;
 
-		return put_user(get_ccsidr(vcpu, val), uval);
+		*val = get_ccsidr(vcpu, idx);
+		return 0;
 	default:
 		return -ENOENT;
 	}
 }
 
-static int demux_c15_set(struct kvm_vcpu *vcpu, u64 id, void __user *uaddr)
+static int demux_c15_get(struct kvm_vcpu *vcpu, u64 id, void __user *uaddr)
 {
-	u32 val, newval;
 	u32 __user *uval = uaddr;
+	u32 val;
+	int ret;
+
+	ret = demux_c15_get_val(vcpu, id, &val);
+	if (!ret)
+		ret = put_user(val, uval);
+
+	return ret;
+}
+
+static int demux_c15_set_val(struct kvm_vcpu *vcpu, u64 id, u32 newval)
+{
+	u32 idx;
 
 	/* Fail if we have unknown bits set. */
 	if (id & ~(KVM_REG_ARCH_MASK|KVM_REG_SIZE_MASK|KVM_REG_ARM_COPROC_MASK
@@ -5535,20 +5547,28 @@ static int demux_c15_set(struct kvm_vcpu *vcpu, u64 id, void __user *uaddr)
 	case KVM_REG_ARM_DEMUX_ID_CCSIDR:
 		if (KVM_REG_SIZE(id) != 4)
 			return -ENOENT;
-		val = (id & KVM_REG_ARM_DEMUX_VAL_MASK)
+		idx = (id & KVM_REG_ARM_DEMUX_VAL_MASK)
 			>> KVM_REG_ARM_DEMUX_VAL_SHIFT;
-		if (val >= CSSELR_MAX)
+		if (idx >= CSSELR_MAX)
 			return -ENOENT;
 
-		if (get_user(newval, uval))
-			return -EFAULT;
-
-		return set_ccsidr(vcpu, val, newval);
+		return set_ccsidr(vcpu, idx, newval);
 	default:
 		return -ENOENT;
 	}
 }
 
+static int demux_c15_set(struct kvm_vcpu *vcpu, u64 id, void __user *uaddr)
+{
+	u32 __user *uval = uaddr;
+	u32 newval;
+
+	if (get_user(newval, uval))
+		return -EFAULT;
+
+	return demux_c15_set_val(vcpu, id, newval);
+}
+
 static u64 kvm_one_reg_to_id(const struct kvm_one_reg *reg)
 {
 	switch(reg->id) {
-- 
2.55.0.1082.g2b9226bbc0-goog


