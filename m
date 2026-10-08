Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE3EBCA600C
	for <kexec@archiver.kernel.org>; Thu,  8 Oct 2026 13:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oVijSUeLpdQWnKER+UijEtgCAKGDAc7/NKc7zbp415Q=; b=MXOgrD1RZqdpPXewRrWlpoqiTo
	KZp7roWL4/pWlKSRwKABhqmSXpaVnIDIPKHZDaWIaJ07B0GYkqVVLHWyx6yW7uWoyXsI/sO5DiEyv
	5lkpM4urXsoXj4e2z67Nq/addQoQaaVZAM/Q0AAEIlFc05a/xKEdi3p14SC8GRYHosHpn1xzMDARF
	2B+68GhUiWvB8olvlo6d5Ptzof8Q9awkchM+SW9773xJoIkiq5aZJK8DxEaTluZCL+HOrdDifitAd
	/Xs+AVzb+0wjvqAE+y/kewBsCxjXyYA2pVdd6JhNHyEPXa8dowUrOc31tNgmHWu+M1a4loQkrDhf2
	wSGhgzwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEoAY-00000004SfI-2MN8;
	Thu, 08 Oct 2026 13:28:22 +0000
Received: from mail-pj1-x1047.google.com ([2607:f8b0:4864:20::1047])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEoAV-00000004Sen-3hyd
	for kexec@lists.infradead.org;
	Thu, 08 Oct 2026 13:28:21 +0000
Received: by mail-pj1-x1047.google.com with SMTP id 98e67ed59e1d1-39533bb224cso6229404a91.3
        for <kexec@lists.infradead.org>; Thu, 08 Oct 2026 06:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791466099; x=1792070899; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oVijSUeLpdQWnKER+UijEtgCAKGDAc7/NKc7zbp415Q=;
        b=ZbH4HTY+2I8+UD21x0VvM7mQJmOYYcf0AdbG657s4AX2xVbd+4ndVZ3bTjP5gA9EEJ
         4HwUwDs8W7YVrW1aWfi86l//bL99k6cpAXPZj+HQhTprTYA/J7lYAX9ZA25wMjmSc/uG
         xdpny8bD/DY9bJFn/zFsjLXfj7XCjE2AAEqJ2jhbPq0W1PlWryrua2WoyyF9TYEFB2C5
         8Ju2Nc57LMUKA7yD81vfvb/ubSJeRLZWyliBDn4ss6OCucYrQZH0ESbvNsOZoXkUJZ0t
         243RFo9X9893Qa2vJRupNdzkhxUGfERo9Z5wT1U2aZlLIy3egVE4gHLs/cuL2/vkxP01
         H/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791466099; x=1792070899;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oVijSUeLpdQWnKER+UijEtgCAKGDAc7/NKc7zbp415Q=;
        b=umMva9Z47VHbGQNnvFoDeuUctftgXRjHC7BiNoFRLv84UbPcJvM57/POIQSuIKl3QL
         LSRSANEA0PyoqEemOoUSWPzsabQgXUTlMbwYE55qJ76YrYp8PE5F+EGN/pqQx3cSiwLu
         ZCx4GaDVxkMFf1DbIOARHCgyMh2+qZOFdI6qR1FFkTzrLA9GwPGG4ZmZ5PAmAPqzWYKi
         EXL7Xw3Gnx+toEcm0JUs49v/7pG9NJ+IKnfXhtnmPqU9zmGjFuLTE+aVpmv/weLb+Zd7
         Of2Ntw7gB3iJ2kC0XE0N6bNJ9ooZCKH24iyyJMf0X+XKLS6RkjEm0A//d9GlI83oiJG/
         +eow==
X-Gm-Message-State: AFq9FYKEt1IoBvoUUc9wLhvpbeq97APce5uw6ir7LYz+pwlkiOiHrDhh
	MH8FmFiyT73VryJre9wtOUa9KYEQB3+iLWRj/fbbtvqHaqLfHbHDXL1qvjg54SztbX9CDMpp4g0
	eQvvZ44ai/ULI2CYmlq6VUQrqBWtjfIhEC/0DroaymXh+wGo2Hn6zpst9KJftqh9pX88gs+5Xh+
	IDWaQHmXPGQK5Ropn20nvmLnMUdNtDBcBmOcYmU9icUPmwDVVqVXs=
X-Received: from pgbd22-n2.prod.google.com ([2002:a05:6a02:64d6:20b0:cc7:ec41:d571])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:578c:b0:39d:efa9:cd1a with SMTP id 98e67ed59e1d1-3a8a04d48a8mr4379961a91.4.1791466098010;
 Thu, 08 Oct 2026 06:28:18 -0700 (PDT)
Date: Thu,  8 Oct 2026 13:28:13 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261008132813.1966023-1-dmatlack@google.com>
Subject: [PATCH] selftests/liveupdate: Prefer KVM and HVF over TCG in vmtest.sh
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Jordan Richards <jordanrichards@google.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261008_062819_954542_4665CD83 
X-CRM114-Status: GOOD (  11.61  )
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

Pass the -accel options to QEMU in the order KVM, HVF, TCG, so that
vmtest.sh prefers to use KVM and HVF over TCG when they are available.

QEMU uses the first accelerator in the list that initializes, and TCG
always initializes, so the tests currently always run under TCG, even
though the commit that added vmtest.sh describes "automatic accelerator
detection (KVM, HVF, or TCG)".

Fixes: 89dd1421c554 ("selftests/liveupdate: add end to end test infrastructure and scripts")
Signed-off-by: David Matlack <dmatlack@google.com>
---
Tested by running run-vmtests.sh and then observed that arm64 correctly
fell back to using TCG after trying to use KVM and HVF, and that x86
reported no warnings.

arm64:
  qemu-system-aarch64: -accel kvm: invalid accelerator kvm
  qemu-system-aarch64: -accel hvf: invalid accelerator hvf
  qemu-system-aarch64: falling back to tcg

x86:
  (not warnings)

 tools/testing/selftests/liveupdate/vmtest.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/liveupdate/vmtest.sh b/tools/testing/selftests/liveupdate/vmtest.sh
index 64fd2ab55b76..69beda6c961d 100755
--- a/tools/testing/selftests/liveupdate/vmtest.sh
+++ b/tools/testing/selftests/liveupdate/vmtest.sh
@@ -180,7 +180,7 @@ function run_qemu() {
 	echo "# Serial Log: $serial"
 	timeout 30s \
 	$qemu_cmd -m 1G -smp 2 -no-reboot -nographic -nodefaults \
-		  -accel tcg -accel hvf -accel kvm \
+		  -accel kvm -accel hvf -accel tcg \
 		  -serial file:"$serial" \
 		  -append "$cmdline" \
 		  -kernel "$kernel_path" \

base-commit: 80cf37169daef112b6bea9ae7d9808355a045475
-- 
2.56.0.360.g66cac248cb-goog


