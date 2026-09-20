Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCBE8C982E6
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S731x7B1q5+LU0uMImlSdu51MYq8nznsZeZCtyZbDcY=; b=VXHHMesHJAACzzhQ8VN3TfBGoD
	ieoQwexVzF/NuXfQPnmLpsnMFGjjREWxGtc2/68eM5sBQosQdlqUTT5PhHot6tFYuf9KVt7fmpwyJ
	7IWr40/mxP/hno/YWmS8kRDTYo0drgIfJX66fPN0Rv61Ih0oX+CHg5ywHzN9alot0dGrBlRvEPveR
	57AJZs8rMwiSm+g6k5vGlDs+w1V1dgYoFkLEtLauFRiXl56qiikISNJ3aQ5CiJAdvCQreOA2/0ADV
	xwwj7Cc52ndhew6wOxhIodY3a0B3VY7zw2aAq91041ZKbpbfdcbqB7gh957xVoXM4wS95A7DoEbdc
	tnQ+ijkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O4L-00000000MFC-37EV;
	Sun, 20 Sep 2026 20:23:25 +0000
Received: from mail-yx2-x13.google.com ([2607:f8b0:4864:41::13])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8NLS-00000000IFJ-2pbO
	for kexec@lists.infradead.org;
	Sun, 20 Sep 2026 19:37:03 +0000
Received: by mail-yx2-x13.google.com with SMTP id 956f58d0204a3-66e4aae3149so1690614d50.2
        for <kexec@lists.infradead.org>; Sun, 20 Sep 2026 12:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1789933021; x=1790537821; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=S731x7B1q5+LU0uMImlSdu51MYq8nznsZeZCtyZbDcY=;
        b=i3XVpd6P66MWYSyMvsP3f/pJMpSHsXOdOD7heMxN0usKdPTwV94cA358tX6HhVHrIJ
         gu83d4DvErfRstoR2OX5Dejg75MYmOUpeTG9D99DGIiXSI/liq3I+culeef4e3nx2xnH
         eE544cLWfv95Zt/K6Fd7VYhl/0AifMjnbWDhlIgaE4GzRwazeuVqd6Abo3nGjyqygMVv
         jTcO554+/o5AoJZ15qafAnzHGePzlOwNsKVaMRPIkoarSq4wHeOZNp4bB/8EQ3JwssZn
         +jW47535G+4wh141rYI+Jel/2S+0RzkQa0wcUNfL5VmdpeXCDVxEHavM65Gl7w6AwZuM
         xL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933021; x=1790537821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=S731x7B1q5+LU0uMImlSdu51MYq8nznsZeZCtyZbDcY=;
        b=XH9wYI79RgaosXtKN+w5u1OjC2lQxGSbuUN67M2Z/yIXC4H1juUaA/lWMay/rZ9TYr
         Y5eZ/8W+Go2WDaOK0mm7YSKU6Nfufk0G1TAXy0upd2vblynibqKpT4UnBtJF+0yyxuxA
         UpJ4Pl2wth3usMA/zJSpdtlZPDewEd4dGJjY5SAEGzkeosSwQIE59UNFQdKSD+FCZdkU
         yUSlmgBUCC8hHmfDEFpPXBXnd57OpXikI8UGrf7XHZo4PACL5QLi676RL6bYvBQLUkzs
         f/8lAv21m9jGO/jQPoL8JFltqCsAJiBOWKKhx8QrxVFkrEd07JxxbOpTaaVaTiYMXUL0
         n94g==
X-Forwarded-Encrypted: i=1; AKwUvBwOM00Bc8Adi2nkkQknjdFVYpEz/xl37gI363g/BJUxh9J0HlZeUzwKdSeodZyV0ZBTunyYag==@lists.infradead.org
X-Gm-Message-State: AFuF++m2N2dVPAjs8kJMWT0wMYVTw+g9mFkcW/ItZxoduIvWi//AiHPt
	Nmw8f0IjcHuGHQFVx5quieogA64RH4G8pBEVMWV2OThY+4YK+2P84PfgJTUV7wApHYM=
X-Gm-Gg: AYBFou1VZTQcNkEQo45MyW+vSllns/0ovFfC0d8i4znzfZxHmkOMuxiXSRwO0FdfgNK
	bNa39lODpsBKzzA39Zcib+Ooc3PlWc0L4pH/IyyifDnS0C8hn7AoA0KkFPr6M6F2d6CWbdShJ0F
	DZ6jKZF/6rsjWzdau7g2XOq3G3oD6fRCWDy4zPw/BJ66xdmnbOwgbWbJLTy+I9AsN/NrkgIq8HH
	S4/ukTYBkloTxMbArGscCwQYrNML+NE4pVhIEfshnN0TX6RCaGvdJyTa95XqWfCe63xSY/app9j
	sHuUkEi7jnq1PAOoov5srR7IJdEkS5NkVJ6IbUB0Zv1J5fuQNuSxK/5JupNMIw03M0eXhheUpGh
	cutmSsdOMb4t4CFxKeRXrBNBXfZqtgjZGC2OfdnI5MHCCNBd190PYj4beOkoZEwy5b7Rigti/lw
	w0XZdTZxyIsDo88ARp3I1z5HKdj2iwe0I4uS2vVzPh14qA/rGIT/4JG0TIui8cI/CKldcHi+q60
	Frmld8NWSSlwj4p9mz4K1Gpngm31L+2J5C9fXwbuCX7GboQyP+wHs11Aayv2AySG2ADtQINKeiF
	T+ngkaTgoC0/I3f1ULg=
X-Received: by 2002:a05:690e:11c7:b0:672:a2ee:6155 with SMTP id 956f58d0204a3-672a2ee6b7cmr1008959d50.45.1789933021253;
        Sun, 20 Sep 2026 12:37:01 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67299146eb0sm2607555d50.21.2026.09.20.12.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:37:00 -0700 (PDT)
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
Subject: [RFC PATCH 01/46] KVM: luo: Delegate VM creation type to kvm_arch_vm_luo_preserve
Date: Sun, 20 Sep 2026 15:36:05 -0400
Message-ID: <20260920193650.3373435-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
References: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_123702_740943_AEC83477 
X-CRM114-Status: GOOD (  14.20  )
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

Remove the architecture-specific #ifdef ladder setting ser->type in
kvm_luo_preserve(). Leaving ser->type zero by default allows
kvm_arch_vm_luo_preserve() to populate the architecture-defined VM
creation flags without referencing unexported architecture symbols in
generic KVM code.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 virt/kvm/kvm_luo.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/virt/kvm/kvm_luo.c b/virt/kvm/kvm_luo.c
index 025b53151b6a..b3bd9bebe17a 100644
--- a/virt/kvm/kvm_luo.c
+++ b/virt/kvm/kvm_luo.c
@@ -73,16 +73,13 @@ static int kvm_luo_preserve(struct liveupdate_file_op_args *args)
 	if (IS_ERR(ser))
 		return PTR_ERR(ser);
 
-#if defined(CONFIG_X86)
-	ser->type = kvm->arch.vm_type;
-#elif defined(CONFIG_ARM64)
-	ser->type = kvm_phys_shift(&kvm->arch.mmu);
-	if (kvm_vm_is_protected(kvm))
-		ser->type |= KVM_VM_TYPE_ARM_PROTECTED;
-
-#else
+	/*
+	 * @type is the argument the new kernel will pass to KVM_CREATE_VM, and
+	 * only the architecture knows how to spell it.  kvm_arch_vm_luo_preserve()
+	 * fills it in; leaving it zero here is the right answer for an
+	 * architecture that does not implement the hook.
+	 */
 	ser->type = 0;
-#endif
 
 	args->serialized_data = virt_to_phys(ser);
 	return 0;
@@ -115,7 +112,6 @@ static int kvm_luo_retrieve(struct liveupdate_file_op_args *args)
 	kvm = file->private_data;
 
 	args->file = file;
-	kho_restore_free(ser);
 
 	kvm_uevent_notify_vm_create(kvm);
 	return 0;
@@ -147,11 +143,7 @@ static void kvm_luo_finish(struct liveupdate_file_op_args *args)
 {
 	struct kvm_luo_ser *ser;
 
-	/*
-	 * If retrieve_status is true or set to error, nothing to do here.
-	 * Already cleaned up in kvm_luo_retrieve().
-	 */
-	if (args->retrieve_status)
+	if (args->retrieve_status < 0)
 		return;
 
 	if (!args->serialized_data)
-- 
2.55.0.1082.g2b9226bbc0-goog


