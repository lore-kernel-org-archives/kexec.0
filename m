Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC31C982EF
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qTv8uFL1FYxhccWvDyiinfq9K+eUMO7fyy31bgvC6E4=; b=O/NiT79MpjD+kkp+DQrbmqyTWW
	rseVQJBkCpr9tzZMOjDl0OjJviD82Pb5Mg9KPtpzZvD5aA1HUEwDF7s9E3UfnTd4qF3vcJ8f/gSrz
	l1L0haA58r/OsCydHy6LgSGadQL4Q1ot/jqUSb4aJcG6PPXBogH5GaO+T/CT8zEEKTljas6fAL22q
	ASuw0+gFwAom00o9mtFT+VMZx2RUUrMvucsHSv6WvM2Ba2bu0IjyjFG0R6lOdMVT2tdeIRuDa4hLO
	TUx22yQ4U2zKUL0fvkpI8i9iw8ZSrwGR/DQ0SxL1xvQAjbTEBhRkb8G1AfbuKPdqpYJrdCev2YwVd
	MQ7El4bQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O4M-00000000MFp-2GOx;
	Sun, 20 Sep 2026 20:23:26 +0000
Received: from mail-yx2-x11.google.com ([2607:f8b0:4864:41::11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8NLv-00000000IRP-05Xp
	for kexec@lists.infradead.org;
	Sun, 20 Sep 2026 19:37:32 +0000
Received: by mail-yx2-x11.google.com with SMTP id 956f58d0204a3-66e4aae3149so1690796d50.2
        for <kexec@lists.infradead.org>; Sun, 20 Sep 2026 12:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1789933050; x=1790537850; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qTv8uFL1FYxhccWvDyiinfq9K+eUMO7fyy31bgvC6E4=;
        b=BqotU9A19IL5EJbLEYHrMK3WSb2onO7n3fqKJg8lzvXMCeOLLPM1MHzI02proCCEbn
         XEwRneU7yxqAXju7FuWZSPRWxnGyU7AWS+Tv4Twm5Alhe4JTC612LGwJfiEkAy2rM2Zr
         0zO0lRI1nN64OFaTUEtDqPWzfzgkCQLA/GnzmP5Rexcm6XRtIXMRIuISgD3mXxkq0vaD
         pcIam9tPCx8ueItnITcVm5qkaqhoQ1ExZzdCLlh9SgbwshkdbzixRa7t6F0GUowU5/ec
         a/VULdcgKMBYF8z2Zr/UzwIC7UHDkPsNhtYfaScFwvVCv5Xek3BFS9X4+43aUHEFZCez
         z6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933050; x=1790537850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qTv8uFL1FYxhccWvDyiinfq9K+eUMO7fyy31bgvC6E4=;
        b=Uv1YTSsd2PixXnlO/FKrifgMyt8vdj+05FbGdbKQ3Nr0Xezj/eIQxZWGBVwIzXiV6O
         /zl2L3zcbY8Pg6COdiBRpe0sSY4OAnnGVHqEvY6MFPYSXHs0BQUz4ZxB5hs4unb4Lgk2
         0C/trmHT5Tl8KUFgwtw+Y/nAVVRbHk0ez3bDPi7hCQqytVIjKYRBUzp10MCSEaJ3xk3P
         +nEtopyf5CGEIop/OMbqA8Lz+K9eeCto1DVZZVdaLCzkz+Up0nCecgM7E5CiKAaXnlY6
         au9syknp4366GFYFrpFgmPloC/v/+0gZh72kRHQOgaxJkbVMlKeaXySiuFWf3IkHC/6c
         Cvag==
X-Forwarded-Encrypted: i=1; AKwUvBz4GQuHl9ugQ1cUKXbzgsPcKJ7WEeWo0pBuE7mmpm5NGMRZYmDgt4lNUAGHADmU6L1ZnSsB0g==@lists.infradead.org
X-Gm-Message-State: AFuF++l34CLdk2zFTiw1y7nA4ZXh+aEfP/wtqpoTUiAjyITvckOiHB9y
	dA7TJdH6V7xYAlKVjGr3zVWbeqlxG7cx3ByA61Da28gryNtkPplcl/8oli3iDfmUnbo=
X-Gm-Gg: AYBFou3K90ha6amCENlnhjzQy1gd+nb+KTDQr/HSBc/ubnKIOhFhtuz5+/VwOEvD7Fn
	lFr80ZpWCf27FUdc3eiGGA07jeEDzuI2fyzasSlhHhqEzDoCVvuBqOXcgGYTJafSJEbkbfLr3on
	bEy0LPo1/n4FB5tc1ZoH8SVYGxqQfYvoQTJECCAfT73laEmANCm4ivU2/N7vyK82Bbrih5UizvA
	glYfwB+2jMTbA6YxEsHENqkmxiVRc2WWzk/xO4Eeqi6C1QT6q55UXUVO4OPoG+1yCt4UeJFm3se
	SVg7wuRy18Q/iiacFJrL6G+G9E9oS9mWtJ4rhVboC18pGMz5PfZpHdT5gdBUHBernTjryChmg2y
	HNncX+htAQmE20Dw+QyXm3Xoq2QDyhavWh3Pug4cfjz5tdKJnE8fCRq9HYmn+WXD1R76LnRLWJE
	KD4tB18/ubYGBuU7MZXckg9AP8mgXq4w7PqHLP+M16ANK4lnmSpn3p6QHgNdXNHUkUPgIXXEmOm
	ZRYWy+LX4cT/weeZhZSiUr3LbmEc7gPCHSIA/kTdYDkOemqAjnc9pK15j3q3u1rOdsLpmES5L//
	LQOEeslrBb1rKcdCUqYR
X-Received: by 2002:a05:690e:134b:b0:671:70d1:d6e5 with SMTP id 956f58d0204a3-6717fe597a3mr2639510d50.87.1789933049997;
        Sun, 20 Sep 2026 12:37:29 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67298f64c7esm2656294d50.2.2026.09.20.12.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:37:29 -0700 (PDT)
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
Subject: [RFC PATCH 06/46] x86/smp: Skip offline CPUs for REBOOT_VECTOR in native_stop_other_cpus()
Date: Sun, 20 Sep 2026 15:36:10 -0400
Message-ID: <20260920193650.3373435-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
References: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_123731_072564_2E347CCB 
X-CRM114-Status: GOOD (  10.37  )
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

In native_stop_other_cpus(), cpus_stop_mask is initialized to
cpu_online_mask minus the calling CPU. However,
apic_send_IPI_allbutself(REBOOT_VECTOR) uses the APIC broadcast
shorthand when enabled, which delivers the IPI to all physical APICs
including offline CPUs.

Use __apic_send_IPI_mask(&cpus_stop_mask, REBOOT_VECTOR) so that
REBOOT_VECTOR is sent only to the target online CPUs in
cpus_stop_mask.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 arch/x86/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 985103cab16c..2449d15c6667 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -192,7 +192,7 @@ static void native_stop_other_cpus(int wait)
 	cpumask_clear_cpu(this_cpu, &cpus_stop_mask);
 
 	if (!cpumask_empty(&cpus_stop_mask)) {
-		apic_send_IPI_allbutself(REBOOT_VECTOR);
+		__apic_send_IPI_mask(&cpus_stop_mask, REBOOT_VECTOR);
 
 		/*
 		 * Don't wait longer than a second for IPI completion. The
-- 
2.55.0.1082.g2b9226bbc0-goog


