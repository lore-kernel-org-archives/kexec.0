Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 001B9C54F55
	for <kexec@archiver.kernel.org>; Tue, 28 Jul 2026 12:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gzckiEC4GSPBVnzwnF4qvKlP6HAv3vDKnOlfEZZeHDM=; b=WuFkuzW2JEqFYlTN0Mc6/3XdyG
	Yc0hS5tx3dYir0eDe2amN70RqW49FQLjIxa9Q9gZ6MxskXjcyfK8sxA++zSaN1LqhuFTMereT1ImZ
	nvHYGQLV7YImowrpKMi/fev8JgkhrQ5nRCtNnkhDZaiCvNHa6aco5Izt9BbVJqWyVtZYMo0kDczJS
	6/NovBBYRcxNiFOIvIn9xomMbjaCwoM+CnI3eKVxXIo8DfYg37NEGXbTjQzrKsAZCTzoSKzqUfQUf
	w+05xwejkLQsd6Q7tiyWB6uLGNUuYgrZudzmqXpIaN/ExF5yo8y4fJ4q2kRWQv26wthL4x6NsfVS+
	jFPtIS4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wogez-00000005CgP-3ydM;
	Tue, 28 Jul 2026 12:11:49 +0000
Received: from mail-ed1-x545.google.com ([2a00:1450:4864:20::545])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wogew-00000005Cds-2f2P
	for kexec@lists.infradead.org;
	Tue, 28 Jul 2026 12:11:47 +0000
Received: by mail-ed1-x545.google.com with SMTP id 4fb4d7f45d1cf-69e97ea7b5bso4372359a12.0
        for <kexec@lists.infradead.org>; Tue, 28 Jul 2026 05:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785240704; x=1785845504; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gzckiEC4GSPBVnzwnF4qvKlP6HAv3vDKnOlfEZZeHDM=;
        b=rzZNLYWLXDjvPQvQqmP0Maw34F/8zKxcVbr47YZ+6nrXaS+IQ22/7M9NA5R6ujSNTg
         mKeFa+7FVas5xSRTDpZEflX415Ty+McgiFPDy+2w505KBvWfml6obY6ypfj043gEC8OT
         cZFgvp4PB55Uz9C4r5KtLt8ThSy53OxOX/PRUlr+LfpCbNUF70vOLidRKMy/oEGnkXZo
         ttO1ovZSW67uFfBv1swpy67nDGewMr2dpXQWM/wfxwXlZYgJ1jTEgEjNhod6/WAPVQPd
         htODxkX8YVl3PcoJDYZ4jb0fIxSiQE80zMjwaAx1PZ4FojOJwWQQXPf7LHArkAVENdJT
         keYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785240704; x=1785845504;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gzckiEC4GSPBVnzwnF4qvKlP6HAv3vDKnOlfEZZeHDM=;
        b=XX4qk4i0OOq1nmwUvbW0pqNcLjpbaDtqYC0mvezgcQYf6bIc+2C+V75VzzFIRfPv4S
         Dp60/CDpHfPo22MypyTbaMu6Ze0j08OfZklMiFp0mhehepRN6/zugQovVX789A12c7mF
         kmcu8wP7VEFjabaKc5H1aVvJW9TWzZ2ntJ4oN994y6RVe4zTFbDKRB1KuPZow4tsgN6h
         UGrlVSB7qIfRVdvisWqD41n3kMd4O8ft/p28+1NfqcqZan8wm7BWR2JX48l7dsXpJsPE
         IHh6xaIQUAs9aYMXaiW3nQEIG8MpWgdFkBSoxkkeodYsIMfbG3YROKEcKIR8QGV+9n9c
         jlfg==
X-Forwarded-Encrypted: i=1; AHgh+Rq6VHYw0hr7HcSXKst9GKG6sDJ41aLXTAqmRCIBT+HcaEDj5HFPgRxK1Vx4YxhznqtSY4Jd3A==@lists.infradead.org
X-Gm-Message-State: AOJu0YyetNEJnMcuARgmSfIuDGwnsIIl4ryXr2aE7lsv3XRj4O8ra0o3
	2iNO8p30CLmH/OaNCzMw0iDCzyyLEDlqnCz4xaZ1Q7E7ineX/0HDfdRmx8aNN/FKKfbIyYalP5M
	3Uc3IceLtK/qRHjiTMQ==
X-Received: from edwv27.prod.google.com ([2002:aa7:cd5b:0:b0:69a:306f:a69])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:194e:b0:691:7054:8c6b with SMTP id 4fb4d7f45d1cf-6a034a9e9demr1065056a12.19.1785240703362;
 Tue, 28 Jul 2026 05:11:43 -0700 (PDT)
Date: Tue, 28 Jul 2026 12:11:29 +0000
In-Reply-To: <20260728121138.1103610-1-tarunsahu@google.com>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260728121138.1103610-3-tarunsahu@google.com>
Subject: [PATCH v4 02/11] KVM: Introduce kvm_create_vm_file() helper
From: Tarun Sahu <tarunsahu@google.com>
To: ackerleytng@google.com, fuad.tabba@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, seanjc@google.com, dmatlack@google.com, 
	Shuah Khan <skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, david@redhat.com, 
	Tarun Sahu <tarunsahu@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, sagis@google.com, Paolo Bonzini <pbonzini@redhat.com>, 
	Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: linux-kselftest@vger.kernel.org, andre.przywara@arm.com, 
	michael.roth@amd.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	will@kernel.org, vannapurve@google.com, maz@kernel.org, fvdl@google.com, 
	kvm@vger.kernel.org, oliver.upton@linux.dev, kvmarm@lists.linux.dev, 
	alexandru.elisei@arm.com, skhawaja@google.com, aneesh.kumar@kernel.org, 
	linux-doc@vger.kernel.org, David Hildenbrand <david@kernel.org>, yan.y.zhao@intel.com, 
	kexec@lists.infradead.org, suzuki.poulose@arm.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260728_051146_716982_08606108 
X-CRM114-Status: GOOD (  16.92  )
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

- Move ITOA_MAX_LEN to kvm_mm.h for reuse by upcoming kvm_luo code.
- Introduce kvm_create_vm_file() to wrap kvm_create_vm() and
  anon_inode_getfile(), providing a unified VM file creation API.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/kvm_host.h |  1 +
 virt/kvm/kvm_main.c      | 48 ++++++++++++++++++++++------------------
 virt/kvm/kvm_mm.h        |  3 +++
 3 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index ab8cfaec82d3..79b084887cdb 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1074,6 +1074,7 @@ void kvm_get_kvm(struct kvm *kvm);
 bool kvm_get_kvm_safe(struct kvm *kvm);
 void kvm_put_kvm(struct kvm *kvm);
 bool file_is_kvm(struct file *file);
+struct file *kvm_create_vm_file(unsigned long type, const char *fdname);
 void kvm_put_kvm_no_destroy(struct kvm *kvm);
 
 static inline struct kvm_memslots *__kvm_memslots(struct kvm *kvm, int as_id)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index e44c20c04961..3339b8fcd59f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -67,9 +67,6 @@
 #include <linux/kvm_dirty_ring.h>
 
 
-/* Worst case buffer size needed for holding an integer. */
-#define ITOA_MAX_LEN 12
-
 MODULE_AUTHOR("Qumranet");
 MODULE_DESCRIPTION("Kernel-based Virtual Machine (KVM) Hypervisor");
 MODULE_LICENSE("GPL");
@@ -5477,11 +5474,34 @@ bool file_is_kvm(struct file *file)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(file_is_kvm);
 
+struct file *kvm_create_vm_file(unsigned long type, const char *fdname)
+{
+	struct kvm *kvm = kvm_create_vm(type, fdname);
+	struct file *file;
+
+	if (IS_ERR(kvm))
+		return ERR_CAST(kvm);
+
+	file = anon_inode_getfile("kvm-vm", &kvm_vm_fops, kvm, O_RDWR);
+	if (IS_ERR(file)) {
+		kvm_put_kvm(kvm);
+		return file;
+	}
+
+	/*
+	 * Don't call kvm_put_kvm anymore at this point; file->f_op is
+	 * already set, with ->release() being kvm_vm_release().  In error
+	 * cases it will be called by the final fput(file) and will take
+	 * care of doing kvm_put_kvm(kvm).
+	 */
+
+	return file;
+}
+
 static int kvm_dev_ioctl_create_vm(unsigned long type)
 {
 	char fdname[ITOA_MAX_LEN + 1];
 	int r, fd;
-	struct kvm *kvm;
 	struct file *file;
 
 	fd = get_unused_fd_flags(O_CLOEXEC);
@@ -5490,31 +5510,17 @@ static int kvm_dev_ioctl_create_vm(unsigned long type)
 
 	snprintf(fdname, sizeof(fdname), "%d", fd);
 
-	kvm = kvm_create_vm(type, fdname);
-	if (IS_ERR(kvm)) {
-		r = PTR_ERR(kvm);
-		goto put_fd;
-	}
-
-	file = anon_inode_getfile("kvm-vm", &kvm_vm_fops, kvm, O_RDWR);
+	file = kvm_create_vm_file(type, fdname);
 	if (IS_ERR(file)) {
 		r = PTR_ERR(file);
-		goto put_kvm;
+		goto put_fd;
 	}
 
-	/*
-	 * Don't call kvm_put_kvm anymore at this point; file->f_op is
-	 * already set, with ->release() being kvm_vm_release().  In error
-	 * cases it will be called by the final fput(file) and will take
-	 * care of doing kvm_put_kvm(kvm).
-	 */
-	kvm_uevent_notify_change(KVM_EVENT_CREATE_VM, kvm);
+	kvm_uevent_notify_change(KVM_EVENT_CREATE_VM, file->private_data);
 
 	fd_install(fd, file);
 	return fd;
 
-put_kvm:
-	kvm_put_kvm(kvm);
 put_fd:
 	put_unused_fd(fd);
 	return r;
diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
index 7510ca915dd1..624161793fec 100644
--- a/virt/kvm/kvm_mm.h
+++ b/virt/kvm/kvm_mm.h
@@ -6,6 +6,9 @@
 #include <linux/kvm.h>
 #include <linux/kvm_types.h>
 
+/* Worst case buffer size needed for holding an integer as a string. */
+#define ITOA_MAX_LEN 12
+
 /*
  * Architectures can choose whether to use an rwlock or spinlock
  * for the mmu_lock.  These macros, for use in common code
-- 
2.55.0.229.g6434b31f56-goog


