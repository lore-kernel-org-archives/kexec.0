Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B93DC53219
	for <kexec@archiver.kernel.org>; Tue, 28 Jul 2026 12:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MlhSbTxVjdyQy53nJTV53rS/2kuy2sPn8hGnbbTr+U4=; b=uJMMkUzdH1luGJg+9FAoxXxfaZ
	3kfvLvgbKzgNBSqNp9Lw73DdOI5TVxKc/JQIoEanD1M2pIcJLnQ/7uPi+OeDqt6ZKf9Vv2FYchEhP
	T4C0GrbAvWCcsqG5QAYeKuVv2L5Mz1PfvWvsUMdUwW1/5ZaHY/hWdILeINJ1H8bExwT/xEUNcrCDN
	1C0wZiExcbMgCEQft8MaW44KXtLMz9ScHRmT18vVgaSjQFnlGKlx2uv6pj/qVFbJHzJFcug8Wdmlf
	D2UA8MHSwKCpCA533Ie1Xbhl57VJV1bzeN7lWwEmUK8NTbL0Nb6OT/Ob+TN/sFxIsF46HC5evVbOm
	p/3lnEMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wogf0-00000005Cgc-07pv;
	Tue, 28 Jul 2026 12:11:50 +0000
Received: from mail-ej1-x648.google.com ([2a00:1450:4864:20::648])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wogex-00000005CeL-2EKG
	for kexec@lists.infradead.org;
	Tue, 28 Jul 2026 12:11:48 +0000
Received: by mail-ej1-x648.google.com with SMTP id a640c23a62f3a-c15c32294e1so363706366b.3
        for <kexec@lists.infradead.org>; Tue, 28 Jul 2026 05:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785240705; x=1785845505; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MlhSbTxVjdyQy53nJTV53rS/2kuy2sPn8hGnbbTr+U4=;
        b=k6PCQ6ZqJkyiiwErLKJY9ZOflQhKjFb+wiF+JP70+lz6RgroX+SB+9n1h1aBM0d4u/
         C0pjflgUVl9ytB9h7M6QyMCJRuajKsuoTq8mnO5qw5padUnSpyQNBXeqBDPzZNzG+jMV
         LF7OvRgBW+2U5BpCPBUiv4MN1tfouwi/x9DFmhWdcWTlNkhUxdGJguGcepXME0+Vxbvg
         SIuJLjuJtnWLnwDm2zvZ7in/snEJxtfKI4Y39nCR8sQ7/j/4DpnkPzJDJceUDVfqc5dm
         pKa80Pu+3DQniEqUh7WNuGvmwaC9SKFbfXLKDgh+oYgq7wrlV7B1K9NIiSV9i2Esum2e
         YKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785240705; x=1785845505;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MlhSbTxVjdyQy53nJTV53rS/2kuy2sPn8hGnbbTr+U4=;
        b=YLV7J86ke2wUVGaEvDST6NcqmPYJ7LPdBTcFZpx0cRRIEUqXWRQ125X4M3RiujlCwM
         AtfLVPk9MPBsfiyhXAVpAESQXLdsRapLds7qmWHvIQbYnWQsB70bKmh7yHuhfUmAkqpf
         xoeqD99giddI8JKtYhFvxhOorCjHfqaIfv3PKfSvrvdjOxPl0k+LR4L3cBYphoVg2TO5
         CZ2dwiYLkZeM1Mv0mpDt2x+01IV09jpsdQ6LQIRYxNNbsnY2OXwYdZP0NBHaf7vEg6mY
         hQDMatPOkMKmsrJtFkBo8oaN63DFOqxUfoG0+9uM5rqs5DoR5geSJduGWdUO4Wl9w2Gj
         Uwfg==
X-Forwarded-Encrypted: i=1; AHgh+Rqv9j+fAC8eMPBICPYl0bHDIY1C23YtVhIGttriF3va+yF+TfnpoVZSF22r1VQR8VwAoMPNpQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwVDEQsXK1Npzlbm+F9+qHg52Iht7TVFADWBIMiQ4mPy5r1fxcg
	8U9SRITexaxF8f3OINOWMPmhl4uEtwt1hxmoxZB1Q9Q5bFZ9Tlcvex3YEBur4yS/2Uano4IHze5
	I2yj6IC9YCWs4p1/Itw==
X-Received: from ejqm4.prod.google.com ([2002:a17:906:5804:b0:c12:3a41:5220])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:1c0a:b0:c12:8b1c:454f with SMTP id a640c23a62f3a-c1f71cf9b88mr103366866b.2.1785240704443;
 Tue, 28 Jul 2026 05:11:44 -0700 (PDT)
Date: Tue, 28 Jul 2026 12:11:30 +0000
In-Reply-To: <20260728121138.1103610-1-tarunsahu@google.com>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260728121138.1103610-4-tarunsahu@google.com>
Subject: [PATCH v4 03/11] KVM: Export kvm_uevent_notify_vm_create()
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
X-CRM114-CacheID: sfid-20260728_051147_596051_D925584F 
X-CRM114-Status: UNSURE (   9.89  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

- Export kvm_uevent_notify_vm_create() to allow triggering KVM event
  notifications during VM creation.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/kvm_host.h | 1 +
 virt/kvm/kvm_main.c      | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 79b084887cdb..d9908c19e42f 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1076,6 +1076,7 @@ void kvm_put_kvm(struct kvm *kvm);
 bool file_is_kvm(struct file *file);
 struct file *kvm_create_vm_file(unsigned long type, const char *fdname);
 void kvm_put_kvm_no_destroy(struct kvm *kvm);
+void kvm_uevent_notify_vm_create(struct kvm *kvm);
 
 static inline struct kvm_memslots *__kvm_memslots(struct kvm *kvm, int as_id)
 {
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 3339b8fcd59f..701d4596a91c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -6348,6 +6348,11 @@ static void kvm_uevent_notify_change(unsigned int type, struct kvm *kvm)
 	kfree(env);
 }
 
+void kvm_uevent_notify_vm_create(struct kvm *kvm)
+{
+	kvm_uevent_notify_change(KVM_EVENT_CREATE_VM, kvm);
+}
+
 static void kvm_init_debug(void)
 {
 	const struct file_operations *fops;
-- 
2.55.0.229.g6434b31f56-goog


