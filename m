Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A9F7C54F57
	for <kexec@archiver.kernel.org>; Tue, 28 Jul 2026 12:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9QAs69nEaOS4rmhD2Q9ekgaAb43dU/I2zqcKzZYHR6c=; b=KQQrJkHJxBLqs8MlSTzojRqieS
	ClG7OyU/FofI6f30w3h1W0bDjRX0w/u6jaVL2OMJdgqhrAdlcGJX4SU+B+8GlEphAuLcglACkIfem
	mbGI59IE3d7SogaQBfKVdOvrGeC7kx0ZJmVQtg0SCniw5LYH6trCIiRewVxkus9TB/3sZjZSzGApy
	mSmjjSRWFnUS3MpDgx0GpxvAfJAwyH14ugKtlIQWESxy21Gqgz598qbxnPgcgbHM7Cs31MfU252Al
	bjrUh7tIdOvvnwBhLwMaTNklSKkieDkjx3AOHyqB3DbHswK0BfS0AsC2KSR/wsFJTAS3JL0Y6g78i
	czJL4QhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wogf0-00000005Cgq-0iMf;
	Tue, 28 Jul 2026 12:11:50 +0000
Received: from mail-ej1-x648.google.com ([2a00:1450:4864:20::648])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wogey-00000005Ces-0rTy
	for kexec@lists.infradead.org;
	Tue, 28 Jul 2026 12:11:49 +0000
Received: by mail-ej1-x648.google.com with SMTP id a640c23a62f3a-c15ff68c858so423900166b.0
        for <kexec@lists.infradead.org>; Tue, 28 Jul 2026 05:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785240706; x=1785845506; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9QAs69nEaOS4rmhD2Q9ekgaAb43dU/I2zqcKzZYHR6c=;
        b=hF0oPu+LtTYzHFQrtrbx+SKqN5VpXoYDUKTKbOnikbHMNaZ7jjtpmWL9nq8jt0LG9f
         4DD/xzp3qt2P3C4JAQIgxQQtOSpY4LuWn1R2k4/Sjl97XBC/xpIHtJIeE0/ZTCRNgs6J
         IRGA9WuEWzWtTgksj4W/2ToyuKbYWArWQDsrqksNFP7vFbL/l6VtDc4iuikyG0+nOpPd
         u+hdmlvOpPMpDAlS9Fg4uKOaLat0Xy0efrSez1/23IvT23FoaeGIrI7EN5aMeaVBxqaH
         W8yZyn+Vq54HKQ7dchaOV/dPrxVgSGy0d/7kn3loZ0r7rWigXhZFPPitJVg9bzouLTyM
         rqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785240706; x=1785845506;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9QAs69nEaOS4rmhD2Q9ekgaAb43dU/I2zqcKzZYHR6c=;
        b=HNYsugqCaNN5By+aJCitOmOtqHKSaWrfFaq8X3xWIfnIpW8XqIXEQA1mvtlwxnlMAe
         U7Wv9GZHiNzWhUtFf6jfQyNYo8jpfWrR/Ih+lI/kBjw3+xpZdTqtubHmrYbhFXMPhXZl
         C2UA3rITkpTECCQ/Um/2ITveM+izaGJBaDEK4JB9+WGJ2QDiuwB/v9WfTVVAvSfwBZTs
         a5r0vMtSUM6ikRpyJef7lF30gCtoY/Vj3SQbI/Ht1Au/eqRn98qw4lCLnliiGK7pz/gy
         Pm93BX6xkj0Z+apvbradiSk782E/QGPwojtZ3vZrwwmNfmf2XVQNM/BsTsUZpTXwt2s1
         Sq+A==
X-Forwarded-Encrypted: i=1; AHgh+RqxTsrSyjbVNaRE+QCBskTcKspBIsdXYMRfeNM5qDcmzo5XG4Rtb6bN3OgVa7VYwRy3wQQUmg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzTFUXtL3qRR9vFmuho2t3L7LJOHPVKqx9/7R2vOiLRYSF/sajU
	dohUNw6a6mdrgGVZDj0V3GFFI1N7xundFCEBbGEySJwNZtGRmAU5LqL/OhXkCsFkfGVtBTMB15y
	B5F3oGPqb5236Xquhfw==
X-Received: from ejit16.prod.google.com ([2002:a17:906:3e50:b0:c15:8b2e:2c2a])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3f96:b0:c12:96af:acf7 with SMTP id a640c23a62f3a-c1f7215156cmr114258866b.43.1785240705336;
 Tue, 28 Jul 2026 05:11:45 -0700 (PDT)
Date: Tue, 28 Jul 2026 12:11:31 +0000
In-Reply-To: <20260728121138.1103610-1-tarunsahu@google.com>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260728121138.1103610-5-tarunsahu@google.com>
Subject: [PATCH v4 04/11] KVM: Track weak reference to vm_file in struct kvm
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
X-CRM114-CacheID: sfid-20260728_051148_260252_BB9723F1 
X-CRM114-Status: GOOD (  14.08  )
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

- Add a weak reference 'vm_file' in struct kvm under
  CONFIG_LIVEUPDATE_GUEST_MEMFD to enable reverse file resolution
  without circular lifetime dependencies.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/kvm_host.h | 12 ++++++++++++
 virt/kvm/kvm_main.c      | 26 ++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index d9908c19e42f..8da9589425ee 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -874,6 +874,18 @@ struct kvm {
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
 	/* Protected by slots_lock (for writes) and RCU (for reads) */
 	struct xarray mem_attr_array;
+#endif
+#ifdef CONFIG_LIVEUPDATE_GUEST_MEMFD
+	/*
+	 * Weak reference to the VFS file backing this KVM instance. Stored
+	 * without incrementing the file refcount to prevent a circular lifetime
+	 * dependency (since file->private_data already pins this struct kvm).
+	 * Used exclusively to resolve the file pointer back from struct kvm.
+	 *
+	 * Written/cleared via rcu_assign_pointer() and read locklessly under
+	 * RCU (e.g. via get_file_active() to prevent ABA races).
+	 */
+	struct file __rcu *vm_file;
 #endif
 	char stats_id[KVM_STATS_NAME_SIZE];
 };
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 701d4596a91c..14c32541ae34 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1346,6 +1346,19 @@ static int kvm_vm_release(struct inode *inode, struct file *filp)
 {
 	struct kvm *kvm = filp->private_data;
 
+#ifdef CONFIG_LIVEUPDATE_GUEST_MEMFD
+	/*
+	 * Clear the weak reference of the vm file.
+	 * In case vm file is closed by userspace, but kvm still has
+	 * other users like vCPUs, clearing this pointer ensures
+	 * that we don't have a dangling pointer to a closed file.
+	 *
+	 * Cleared via rcu_assign_pointer() to ensure proper memory visibility
+	 * for concurrent lockless readers under RCU.
+	 */
+	rcu_assign_pointer(kvm->vm_file, NULL);
+#endif
+
 	kvm_irqfd_release(kvm);
 
 	kvm_put_kvm(kvm);
@@ -5488,6 +5501,19 @@ struct file *kvm_create_vm_file(unsigned long type, const char *fdname)
 		return file;
 	}
 
+#ifdef CONFIG_LIVEUPDATE_GUEST_MEMFD
+	/*
+	 * Weak reference to the file (without get_file()) to prevent a circular
+	 * dependency. Safe because the file's release path clears this pointer
+	 * and drops its reference to the VM.
+	 *
+	 * Written via rcu_assign_pointer() because the pointer can be read
+	 * locklessly under RCU (e.g., in kvm_gmem_luo_preserve() via
+	 * get_file_active() to prevent lockless ABA races).
+	 */
+	rcu_assign_pointer(kvm->vm_file, file);
+#endif
+
 	/*
 	 * Don't call kvm_put_kvm anymore at this point; file->f_op is
 	 * already set, with ->release() being kvm_vm_release().  In error
-- 
2.55.0.229.g6434b31f56-goog


