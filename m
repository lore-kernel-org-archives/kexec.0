Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D657AC982D8
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cf5rLykmCWIC3OsLJKmCN2FyaY3ZIm+gv4og5D7dmSY=; b=tGquG4gWg8IzDPTw6ffq5RPZ8E
	27v4VEPLK8HjrEi9PdG9PAwo5JEIYukiptPg/4u3OGPoAnLWfkLKptQARpUfX9UZc7PK61iZXEdVu
	ir7l25uf8B5j0PRoIdBpM3lAyLK1oDrLujtofBnxe9SnFeeRkbPvip3kKz44o1VvvcwiDvVrJ6ERm
	1zjWycNbMu6ernCgHJDl9hPXkHjDXlsxgF0fZafEp9UhbjckXecuPfHpwbmLt/ru4LaXPWGYZMPn6
	oigLzCxyj9hiGUcBpBPNACEjL9vy7w0hcTDC8h6/ieMlIT8cqLSOTAPhPa7m/QywzxiuvcdDyTbK2
	z1RqToRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O55-00000000O2l-1IUM;
	Sun, 20 Sep 2026 20:24:11 +0000
Received: from mail-yx2-x11.google.com ([2607:f8b0:4864:41::11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8NOE-00000000JEo-2cBy
	for kexec@lists.infradead.org;
	Sun, 20 Sep 2026 19:39:57 +0000
Received: by mail-yx2-x11.google.com with SMTP id 956f58d0204a3-66e4aac9321so2007519d50.3
        for <kexec@lists.infradead.org>; Sun, 20 Sep 2026 12:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1789933194; x=1790537994; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cf5rLykmCWIC3OsLJKmCN2FyaY3ZIm+gv4og5D7dmSY=;
        b=MQgYaG+shBPbDGmF2U0eWnppenaXA5/utQWq/aYLS3YUFuTK3sTH2TNlO3GziarchP
         XRcFVrbliWh89fGtYgzWnIkYaFgYdMRNYsRN4RbQN/oIKucbI4WWjuWJUKWS0oR9g9DL
         IeNB5D5xs5KGYYJPW8pBTWkk9IG4nmTF8WPFgUZReKxjwRV85eZie8CYGUtJ8ZbhB8l8
         rQLnGBMy+nnpwrxpegzAhU9c1vrnHdwPhjenGLDqgAu+OIlX0u8qy1Ih567C1EGLJytT
         Y3idUqSVSW5EPXGwlnNTyOc56ateYkN8alThE6l0WgVlo2LbNuI9o4p9taLVsSaxNmOO
         EY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933194; x=1790537994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=cf5rLykmCWIC3OsLJKmCN2FyaY3ZIm+gv4og5D7dmSY=;
        b=Kp+s2kNnW3lhfSASJPch89VtmQMtOBJH25tIMt004TkH7F1xC4461K88sCy6Ta45Kb
         l/Pce6BmNPF+wHmegp1jUU70UlS7hOevRKSw8DanijeJrF11sgtYjLyQure2mf1JbEsD
         EkWYTLFO+HP0DPuCzuIZe0OrdkTjyGCTcH3k0jk88T77mRGS0Wc3PXUHfVwKYhAtNMsl
         zkKh2P6ANY7/6A3LQ0jJIrLBNDkUWeq3VcpjDS7QCRVlw1xhWGFavafJDi7zGIe/7wM7
         v+CbJGGXVarDK3FDr2WIuRKAONvCDCOjV/mOgpbn03OtvjXwS3xhnQzotkE0rCrgu46v
         5tFA==
X-Forwarded-Encrypted: i=1; AKwUvBxsZ5qVp9UZsohiPxX7cuP3vqesdDAezS/uj5oPHwRA209vHfgjf8nAU/A9VoUeHYs5E8EZIg==@lists.infradead.org
X-Gm-Message-State: AFuF++nAdMszXJsKz7WxIMM+LiMRgNroe5DSno+HryR4jeOI0S6MpvuT
	l/IJGY6oJI3dlTzk/r3nZFDZ9/BFXEGu6Oiy1YU/81hTVd0hjP18ixdJf36IiNre7ew=
X-Gm-Gg: AYBFou2S0UYlBgjWOTwOj27bD3GKpaLzTFfR3buUp1U6ZEIBB3EvJkfO/KtYdaTzDH6
	zpmAbUkVYkzdH9wyLSVPthAkC3rrQaVJeSYOddHivHdkjyAnl5kWQkaeAFc8Opf4O8QSjYc1NDI
	NIFRNxCCPao81dRAYGs5eP1lhU0yJhB/AiWCC9GBGincdl43kp+qeKRQLwjW7h8e9ecD7HxFFJH
	FR2qIRoigkS3XNDX2dhHQeI7ZAQyr3HYmywuXt/c6RjxryIybkdkx2oarM1uruw1tagx4xW/1Na
	ZFRrsvtWc8EgQEcy0JqI+upedIhuD3F86RToueAur3VnWZwAb/pwhdOL1kF+QCKhQyxrbtKfs+f
	zaoNz19iWAYmuI3/WoUU4TadNdYW+K6zVMn4TYzvMUJ+olUdrVlTlY4v6omEHtomDt8dkdk+Sw+
	RkrKrp9t/qS8Qvt16bpCIjR+dNrS6Ur2bLmzcOBPceEpmrfDNEwdJxXb142JqLIZavPgNFhT9zd
	jQWZrg/pJge6CoW2iTrS5XGy4hQRZjFwZLYAj18+aQI67Iiwu/wZ/AfnNRzIzQBlqoM1w61SCnM
	+89MvJpu3e7wRDaEIpM=
X-Received: by 2002:a05:690c:385:b0:81e:45a6:bd53 with SMTP id 00721157ae682-897308fc956mr28724767b3.8.1789933193482;
        Sun, 20 Sep 2026 12:39:53 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-89a45d8fb3csm19035517b3.13.2026.09.20.12.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:39:52 -0700 (PDT)
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
Subject: [RFC PATCH 30/46] KVM: caretaker: Integrate Caretaker vCPU detach, attach, and cancel with KVM
Date: Sun, 20 Sep 2026 15:36:34 -0400
Message-ID: <20260920193650.3373435-31-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
References: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_123954_744205_31CC22D3 
X-CRM114-Status: GOOD (  20.20  )
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

Integrate Caretaker vCPU preservation, re-attachment, and cancellation
with KVM LUO handlers and enable CONFIG_KVM_CARETAKER build rules.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 Documentation/liveupdate/vmm.rst |  15 +++
 include/linux/kvm_caretaker.h    |   1 +
 virt/kvm/Kconfig                 |  28 +++++
 virt/kvm/Makefile.kvm            |   7 ++
 virt/kvm/caretaker.c             | 197 ++++++++++++++++++++++++++++++-
 virt/kvm/kvm_luo.c               |  70 ++++++++++-
 virt/kvm/kvm_main.c              |   7 ++
 7 files changed, 318 insertions(+), 7 deletions(-)

diff --git a/Documentation/liveupdate/vmm.rst b/Documentation/liveupdate/vmm.rst
index b8e8fb2b63c2..a0b54d6f1220 100644
--- a/Documentation/liveupdate/vmm.rst
+++ b/Documentation/liveupdate/vmm.rst
@@ -100,8 +100,23 @@ VM & Guest_Memfd Preservation ABI
 .. kernel-doc:: include/linux/kho/abi/kvm.h
    :internal:
 
+KVM Caretaker (Orphaned VM Execution)
+=====================================
+
+.. kernel-doc:: virt/kvm/caretaker.c
+   :doc: KVM Caretaker Architecture and Lifecycle
+
+KVM Caretaker Core & Architecture API
+=====================================
+
+.. kernel-doc:: include/linux/kvm_caretaker.h
+
+.. kernel-doc:: virt/kvm/caretaker.c
+   :identifiers:
+
 See Also
 ========
 
 - :doc:`/core-api/liveupdate`
+- :doc:`/liveupdate/cpu_preservation`
 - :doc:`/userspace-api/liveupdate`
diff --git a/include/linux/kvm_caretaker.h b/include/linux/kvm_caretaker.h
index 3e89738d7fdf..0d4bdde7b1c3 100644
--- a/include/linux/kvm_caretaker.h
+++ b/include/linux/kvm_caretaker.h
@@ -241,6 +241,7 @@ void kvm_arch_vcpu_luo_pre_retrieve_caretaker(struct kvm_vcpu *vcpu,
 void kvm_arch_vcpu_luo_attach_caretaker(struct kvm_vcpu *vcpu,
 					struct kvm_vcpu_ser *ser);
 
+void kvm_caretaker_vm_pre_retrieve(void);
 int kvm_caretaker_vcpu_pre_preserve(struct kvm_vcpu *vcpu,
 				    struct liveupdate_session *session,
 				    struct kvm_vcpu_ser *ser);
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index fcaf57377e73..165e0c85b8aa 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -125,3 +125,31 @@ config HAVE_KVM_ARCH_GMEM_INVALIDATE
 config HAVE_KVM_ARCH_GMEM_POPULATE
        bool
        depends on KVM_GUEST_MEMFD
+
+config HAVE_KVM_ARCH_CARETAKER
+	bool
+
+config KVM_CARETAKER
+	bool "Orphaned VM Caretaker execution and lifecycle management"
+	depends on KVM
+	depends on LIVEUPDATE_CPU
+	depends on SMP
+	depends on HOTPLUG_CPU
+	depends on HAVE_KVM_ARCH_CARETAKER
+	select LIVEUPDATE_ONCORE
+	default LIVEUPDATE_CPU
+	help
+	  Enable Caretaker CPU preservation and standalone execution for
+	  orphaned virtual machines across host kernel live updates.
+
+	  During a host kernel live update, user space hypervisors
+	  and host services terminate, leaving running guest virtual
+	  machines in an orphaned state. Caretaker keeps designated physical
+	  CPUs running their respective guest vCPUs on-core in a standalone
+	  execution loop throughout the entire live update transition.
+
+	  Caretaker attaches to preserved CPUs via the cpu_preserve subsystem
+	  and continues guest vCPU execution across the kexec live update
+	  without pausing the guest.
+
+	  If unsure, say N.
diff --git a/virt/kvm/Makefile.kvm b/virt/kvm/Makefile.kvm
index d30fca094c42..ae1fcf9861b7 100644
--- a/virt/kvm/Makefile.kvm
+++ b/virt/kvm/Makefile.kvm
@@ -14,3 +14,10 @@ kvm-$(CONFIG_HAVE_KVM_DIRTY_RING) += $(KVM)/dirty_ring.o
 kvm-$(CONFIG_HAVE_KVM_PFNCACHE) += $(KVM)/pfncache.o
 kvm-$(CONFIG_KVM_GUEST_MEMFD) += $(KVM)/guest_memfd.o
 kvm-$(CONFIG_LIVEUPDATE_GUEST_MEMFD) += $(KVM)/guest_memfd_luo.o $(KVM)/kvm_luo.o
+kvm-$(CONFIG_KVM_CARETAKER) += $(KVM)/caretaker.o
+KASAN_SANITIZE_$(KVM)/caretaker.o := n
+KCSAN_SANITIZE_$(KVM)/caretaker.o := n
+UBSAN_SANITIZE_$(KVM)/caretaker.o := n
+KCOV_INSTRUMENT_$(KVM)/caretaker.o := n
+CFLAGS_REMOVE_$(KVM)/caretaker.o = $(CC_FLAGS_FTRACE)
+CFLAGS_$(KVM)/caretaker.o += -fno-stack-protector $(call cc-option,-ftrivial-auto-var-init=uninitialized) -fno-builtin-memset -fno-builtin-memcpy $(call cc-option,-fno-tree-loop-distribute-patterns) $(call cc-option,-fno-jump-tables)
diff --git a/virt/kvm/caretaker.c b/virt/kvm/caretaker.c
index b4a203562727..dac64c466d76 100644
--- a/virt/kvm/caretaker.c
+++ b/virt/kvm/caretaker.c
@@ -196,7 +196,7 @@ kvm_caretaker_should_exit(struct kvm_caretaker_vcpu *cvcpu)
 
 	cpu_preserved_inval(cvcpu->cb);
 
-	st = READ_ONCE(cvcpu->cb->state);
+	st = smp_load_acquire(&cvcpu->cb->state);
 	if (st != KVM_CARETAKER_PAUSED && st != KVM_CARETAKER_RUNNING)
 		return true;
 
@@ -365,7 +365,7 @@ static bool kvm_caretaker_try_stop(struct kvm_caretaker_cb_ser *cb)
 {
 	cpu_preserved_inval(cb);
 
-	if (READ_ONCE(cb->state) == KVM_CARETAKER_STOPPED)
+	if (smp_load_acquire(&cb->state) == KVM_CARETAKER_STOPPED)
 		return true;
 
 	if (cmpxchg(&cb->state, KVM_CARETAKER_PAUSED,
@@ -397,10 +397,8 @@ int kvm_caretaker_wait_for_attach(struct kvm_caretaker_cb_ser *cb, int pcpu)
 		return 0;
 
 	if (!cpu_is_preserved(pcpu)) {
-		WRITE_ONCE(cb->state, KVM_CARETAKER_STOPPED);
+		smp_store_release(&cb->state, KVM_CARETAKER_STOPPED);
 		cpu_preserved_clean(cb);
-		/* Ensure state update is visible before returning to caller */
-		smp_wmb();
 		return 0;
 	}
 
@@ -450,3 +448,192 @@ void kvm_caretaker_post_attach_vcpu(struct kvm_vcpu *vcpu)
 	}
 }
 
+/**
+ * kvm_caretaker_vcpu_pre_preserve - Submit an On-Core job for a vCPU prior to arch preserve
+ * @vcpu:    KVM vCPU being preserved.
+ * @session: Active Live Update session.
+ * @ser:     Serialized KHO vCPU descriptor to populate.
+ *
+ * Submits a Caretaker job to @session before kvm_arch_vcpu_luo_preserve() runs.
+ * If @session has preserved physical CPUs, assigns the job to the least-loaded
+ * preserved CPU and sets %KVM_VCPU_LUO_FLAG_CARETAKER in @ser->flags so the
+ * architecture hook allocates and populates a Caretaker runtime page.  If
+ * @session has no preserved physical CPUs, returns 0 without setting the flag
+ * so the vCPU is preserved in RAM only.
+ *
+ * Return: 0 on success, or a negative errno on job allocation failure.
+ */
+int kvm_caretaker_vcpu_pre_preserve(struct kvm_vcpu *vcpu,
+				    struct liveupdate_session *session,
+				    struct kvm_vcpu_ser *ser)
+{
+	struct oncore_job *job;
+
+	/*
+	 * Submit with no data: the run callback's argument is the caretaker
+	 * control block, which does not exist until the architecture's
+	 * kvm_arch_vcpu_luo_preserve() has allocated it.  It is installed with
+	 * oncore_job_set_data() from _post_preserve(), before activation.
+	 */
+	job = oncore_session_submit_job(session, kvm_arch_vcpu_caretaker_run,
+					NULL);
+	if (IS_ERR(job))
+		return PTR_ERR(job);
+	if (!job)
+		return 0;
+
+	vcpu->caretaker.job = job;
+	ser->flags |= KVM_VCPU_LUO_FLAG_CARETAKER;
+
+	return 0;
+}
+
+/**
+ * kvm_caretaker_vcpu_post_preserve - Activate the Caretaker On-Core job after arch preserve
+ * @vcpu:     KVM vCPU being preserved.
+ * @session:  Active Live Update session.
+ * @ser:      Serialized KHO vCPU descriptor.
+ * @arch_err: Result of kvm_arch_vcpu_luo_preserve() (non-zero on failure).
+ *
+ * If @arch_err is non-zero, cancels and frees any job created in
+ * kvm_caretaker_vcpu_pre_preserve().  Otherwise, installs @vcpu->caretaker.cb
+ * as the job's run argument, flushes the control block to PoC, and activates
+ * the job on the session's runqueue so the preserved physical CPU begins
+ * executing the vCPU.
+ *
+ * Return: 0 on success, or @arch_err / negative errno on failure.
+ */
+int kvm_caretaker_vcpu_post_preserve(struct kvm_vcpu *vcpu,
+				     struct liveupdate_session *session,
+				     struct kvm_vcpu_ser *ser,
+				     int arch_err)
+{
+	struct kvm_caretaker_cb_ser *cb = vcpu->caretaker.cb;
+	struct oncore_job *job = vcpu->caretaker.job;
+	int err;
+
+	if (arch_err) {
+		if (job)
+			oncore_session_cancel_job(session, job);
+		vcpu->caretaker.job = NULL;
+		vcpu->caretaker.cb = NULL;
+		return arch_err;
+	}
+
+	if (!(ser->flags & KVM_VCPU_LUO_FLAG_CARETAKER) || !cb)
+		return 0;
+
+	oncore_job_set_data(job, cb);
+
+	kvm_caretaker_pause(cb);
+	cpu_preserved_clean(cb);
+
+	err = oncore_session_activate_job(session, job);
+	if (err) {
+		oncore_session_cancel_job(session, job);
+		vcpu->caretaker.job = NULL;
+		kvm_caretaker_stop(cb);
+		vcpu->caretaker.cb = NULL;
+		return err;
+	}
+
+	return 0;
+}
+
+/**
+ * kvm_caretaker_vm_pre_retrieve - Stop Caretaker execution before retrieving VM state
+ *
+ * Detaches preserved physical CPU workloads before the incoming kernel creates
+ * the restored KVM VM instance so Caretaker execution stops immediately when
+ * userspace begins reclaiming the VM session.
+ */
+void kvm_caretaker_vm_pre_retrieve(void)
+{
+	int cpu;
+
+	for_each_cpu(cpu, cpu_get_preserved_mask())
+		cpu_preserved_detach_workload(cpu);
+}
+
+/**
+ * kvm_caretaker_vcpu_pre_retrieve - Stop Caretaker execution before retrieving vCPU state
+ * @vcpu: Incoming KVM vCPU being restored.
+ * @ser:  Serialized KHO vCPU descriptor.
+ *
+ * Resolves @ser->cb and invokes kvm_arch_vcpu_luo_pre_retrieve_caretaker() so
+ * the preserved physical CPU stops guest execution and serializes its latest
+ * state into @ser->arch_state before kvm_arch_vcpu_luo_retrieve() reads it.
+ */
+void kvm_caretaker_vcpu_pre_retrieve(struct kvm_vcpu *vcpu,
+				     struct kvm_vcpu_ser *ser)
+{
+	if (ser->flags & KVM_VCPU_LUO_FLAG_CARETAKER)
+		vcpu->caretaker.cb = KHOSER_LOAD_PTR(ser->cb);
+
+	kvm_arch_vcpu_luo_pre_retrieve_caretaker(vcpu, ser);
+}
+
+/**
+ * kvm_caretaker_vcpu_retrieve - Complete Caretaker hardware attachment during vCPU retrieve
+ * @vcpu: Incoming KVM vCPU being restored.
+ * @ser:  Serialized KHO vCPU descriptor.
+ *
+ * Invokes kvm_arch_vcpu_luo_attach_caretaker() after architectural register
+ * state has been restored into @vcpu.
+ */
+void kvm_caretaker_vcpu_retrieve(struct kvm_vcpu *vcpu,
+				 struct kvm_vcpu_ser *ser)
+{
+	kvm_arch_vcpu_luo_attach_caretaker(vcpu, ser);
+}
+
+/**
+ * kvm_caretaker_vcpu_unpreserve - Roll back Caretaker execution on live update cancellation
+ * @vcpu:    Outgoing KVM vCPU being unpreserved.
+ * @session: Live Update session being cancelled.
+ * @ser:     Serialized KHO vCPU descriptor.
+ *
+ * Stops the vCPU on the preserved physical CPU, synchronizes any guest state
+ * updates back into the outgoing @vcpu, frees KHO telemetry buffers, and
+ * cancels the On-Core job.
+ */
+void kvm_caretaker_vcpu_unpreserve(struct kvm_vcpu *vcpu,
+				   struct liveupdate_session *session,
+				   struct kvm_vcpu_ser *ser)
+{
+	if (ser->flags & KVM_VCPU_LUO_FLAG_CARETAKER) {
+		kvm_arch_vcpu_luo_pre_retrieve_caretaker(vcpu, ser);
+		kvm_arch_vcpu_luo_retrieve(vcpu, ser);
+		kvm_arch_vcpu_luo_attach_caretaker(vcpu, ser);
+		kvm_caretaker_telemetry_free(ser, false);
+	}
+
+	if (vcpu->caretaker.job) {
+		oncore_session_cancel_job(session, vcpu->caretaker.job);
+		vcpu->caretaker.job = NULL;
+	}
+	vcpu->caretaker.cb = NULL;
+}
+
+/**
+ * kvm_caretaker_vcpu_finish - Release Caretaker KHO resources after live update completion
+ * @vcpu:    Incoming KVM vCPU (or %NULL on retrieve failure cleanup).
+ * @session: Completed Live Update session.
+ * @ser:     Serialized KHO vCPU descriptor.
+ *
+ * Ensures the Caretaker vCPU has detached and frees KHO-preserved telemetry
+ * buffers in the incoming kernel.
+ */
+void kvm_caretaker_vcpu_finish(struct kvm_vcpu *vcpu,
+			       struct liveupdate_session *session,
+			       struct kvm_vcpu_ser *ser)
+{
+	if (ser->flags & KVM_VCPU_LUO_FLAG_CARETAKER) {
+		kvm_arch_vcpu_luo_pre_retrieve_caretaker(vcpu, ser);
+		kvm_caretaker_telemetry_free(ser, true);
+	}
+
+	if (vcpu)
+		vcpu->caretaker.cb = NULL;
+}
+
diff --git a/virt/kvm/kvm_luo.c b/virt/kvm/kvm_luo.c
index f7e259bef4b7..fe30f2d41eb4 100644
--- a/virt/kvm/kvm_luo.c
+++ b/virt/kvm/kvm_luo.c
@@ -44,6 +44,7 @@
  */
 #include <linux/liveupdate.h>
 #include <linux/kvm_host.h>
+#include <linux/kvm_caretaker.h>
 #include <linux/pagemap.h>
 #include <linux/fdtable.h>
 #include <linux/file.h>
@@ -55,6 +56,45 @@
 #include <linux/kho/abi/kvm.h>
 #include "kvm_mm.h"
 
+struct kvm_kho_folios_ser *kvm_kho_folios_alloc(unsigned int max_folios)
+{
+	struct kvm_kho_folios_ser *kp;
+	size_t sz = struct_size(kp, folios_pa, max_folios);
+
+	kp = kho_alloc_preserve(sz);
+	if (IS_ERR(kp))
+		return kp;
+
+	kp->nr_folios = 0;
+	return kp;
+}
+
+void kvm_kho_folios_unpreserve(struct kvm_kho_folios_ser *kp)
+{
+	unsigned int i;
+
+	if (!kp)
+		return;
+
+	for (i = 0; i < kp->nr_folios; i++)
+		kho_unpreserve_folio(page_folio(phys_to_page(kp->folios_pa[i])));
+
+	kho_unpreserve_free(kp);
+}
+
+void kvm_kho_folios_finish(struct kvm_kho_folios_ser *kp)
+{
+	unsigned int i;
+
+	if (!kp)
+		return;
+
+	for (i = 0; i < kp->nr_folios; i++)
+		kho_restore_free(phys_to_virt(kp->folios_pa[i]));
+
+	kho_restore_free(kp);
+}
+
 static bool kvm_luo_can_preserve(struct liveupdate_file_handler *handler,
 				 struct file *file)
 {
@@ -81,6 +121,7 @@ static int kvm_luo_preserve(struct liveupdate_file_op_args *args)
 	 * architecture that does not implement the hook.
 	 */
 	ser->type = 0;
+	ser->kho_folios.phys = 0;
 	err = kvm_arch_vm_luo_preserve(kvm, ser);
 	if (err) {
 		kho_unpreserve_free(ser);
@@ -104,6 +145,8 @@ static int kvm_luo_retrieve(struct liveupdate_file_op_args *args)
 	if (!args->serialized_data)
 		return -EINVAL;
 
+	kvm_caretaker_vm_pre_retrieve();
+
 	ser = phys_to_virt(args->serialized_data);
 
 	snprintf(fdname, sizeof(fdname), "%d",
@@ -130,6 +173,7 @@ static int kvm_luo_retrieve(struct liveupdate_file_op_args *args)
 
 err_free_ser:
 	kvm_arch_vm_luo_finish(ser);
+	kvm_kho_folios_finish(KHOSER_LOAD_PTR(ser->kho_folios));
 	kho_restore_free(ser);
 	return err;
 }
@@ -150,6 +194,9 @@ static void kvm_luo_unpreserve(struct liveupdate_file_op_args *args)
 
 	ser = phys_to_virt(args->serialized_data);
 	kvm_arch_vm_luo_unpreserve(kvm, ser);
+	if (kvm)
+		kvm->kho_folios = NULL;
+	kvm_kho_folios_unpreserve(KHOSER_LOAD_PTR(ser->kho_folios));
 	kho_unpreserve_free(ser);
 }
 
@@ -165,6 +212,7 @@ static void kvm_luo_finish(struct liveupdate_file_op_args *args)
 
 	ser = phys_to_virt(args->serialized_data);
 	kvm_arch_vm_luo_finish(ser);
+	kvm_kho_folios_finish(KHOSER_LOAD_PTR(ser->kho_folios));
 	kho_restore_free(ser);
 }
 
@@ -217,8 +265,15 @@ static int kvm_vcpu_luo_preserve(struct liveupdate_file_op_args *args)
 	ser->vcpu_id = vcpu->vcpu_id;
 	ser->flags = 0;
 	ser->vm_token = vm_token;
-
-	err = kvm_arch_vcpu_luo_preserve(vcpu, ser);
+	ser->arch_state.phys = 0;
+	ser->cb.phys = 0;
+
+	err = kvm_caretaker_vcpu_pre_preserve(vcpu, args->session, ser);
+	if (!err) {
+		err = kvm_arch_vcpu_luo_preserve(vcpu, ser);
+		err = kvm_caretaker_vcpu_post_preserve(vcpu, args->session,
+						       ser, err);
+	}
 	mutex_unlock(&vcpu->mutex);
 	if (err) {
 		kho_unpreserve_free(ser);
@@ -259,16 +314,19 @@ static int kvm_vcpu_luo_retrieve(struct liveupdate_file_op_args *args)
 	}
 
 	vcpu = file->private_data;
+	kvm_caretaker_vcpu_pre_retrieve(vcpu, ser);
 	err = kvm_arch_vcpu_luo_retrieve(vcpu, ser);
 	if (err) {
 		fput(file);
 		goto err_free_ser;
 	}
+	kvm_caretaker_vcpu_retrieve(vcpu, ser);
 
 	args->file = file;
 	return 0;
 
 err_free_ser:
+	kvm_caretaker_vcpu_finish(NULL, args->session, ser);
 	kvm_arch_vcpu_luo_finish(ser);
 	kho_restore_free(ser);
 	return err;
@@ -276,18 +334,24 @@ static int kvm_vcpu_luo_retrieve(struct liveupdate_file_op_args *args)
 
 static void kvm_vcpu_luo_unpreserve(struct liveupdate_file_op_args *args)
 {
+	struct kvm_vcpu *vcpu = args->file ? args->file->private_data : NULL;
 	struct kvm_vcpu_ser *ser;
 
 	if (WARN_ON_ONCE(!args->serialized_data))
 		return;
 
 	ser = phys_to_virt(args->serialized_data);
+
+	if (vcpu)
+		kvm_caretaker_vcpu_unpreserve(vcpu, args->session, ser);
+
 	kvm_arch_vcpu_luo_unpreserve(ser);
 	kho_unpreserve_free(ser);
 }
 
 static void kvm_vcpu_luo_finish(struct liveupdate_file_op_args *args)
 {
+	struct kvm_vcpu *vcpu = args->file ? args->file->private_data : NULL;
 	struct kvm_vcpu_ser *ser;
 
 	if (args->retrieve_status < 0)
@@ -297,6 +361,8 @@ static void kvm_vcpu_luo_finish(struct liveupdate_file_op_args *args)
 		return;
 
 	ser = phys_to_virt(args->serialized_data);
+
+	kvm_caretaker_vcpu_finish(vcpu, args->session, ser);
 	kvm_arch_vcpu_luo_finish(ser);
 	kho_restore_free(ser);
 }
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index ae91123e1822..4f661c5d2ee2 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4521,6 +4521,11 @@ static long kvm_vcpu_ioctl(struct file *filp,
 
 			put_pid(oldpid);
 		}
+
+		if (!kvm_caretaker_vcpu_is_attached(vcpu)) {
+			r = -EBUSY;
+			break;
+		}
 		vcpu->wants_to_run = !READ_ONCE(vcpu->run->immediate_exit__unsafe);
 		r = kvm_arch_vcpu_ioctl_run(vcpu);
 		vcpu->wants_to_run = false;
@@ -4989,6 +4994,8 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 #endif
 	case KVM_CAP_VCPU_PRESERVE:
 		return IS_ENABLED(CONFIG_HAVE_KVM_ARCH_VCPU_PRESERVE);
+	case KVM_CAP_CARETAKER:
+		return IS_ENABLED(CONFIG_KVM_CARETAKER);
 	default:
 		break;
 	}
-- 
2.55.0.1082.g2b9226bbc0-goog


