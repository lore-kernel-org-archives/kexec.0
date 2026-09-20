Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5823C982DA
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GOyD94xneAEU7+yzaxi3P4vCBB/CkWgVuLYMi+o49fI=; b=pf6GzOYLv/IVSKANpXCHlxtjcC
	xQvegUjQC7Ba9Hddwryx/t3sNq8lSfVx0tXzyKNliT6WyOIQlhY2QdWr8ngAjDRxLO/CD5fcUVqac
	41LYr7kOeRpLbKfhnDssnIs3DS2XInEPVKeeqDIHwgYbmdO4IAOr7G2E2vpo8YhxeA1sZQG/OCv0t
	aFDMWJh59nC58cBHhHFAU2s5yNcMbJ5mZI6zNAWnVWlPnXW0jG/S+rm7ZMdR6ZU5yUeC5+s32Gmbs
	6d6aFtUx8oxPlcYEZHp1vLl0LbYE6m+77a6HaEZ5zwVSpz99pBCeYXML76FF0ZF+uLCStea4o0Pvk
	aTKiyxnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O4v-00000000Nir-45mp;
	Sun, 20 Sep 2026 20:24:01 +0000
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8NNd-00000000J4a-3trz
	for kexec@lists.infradead.org;
	Sun, 20 Sep 2026 19:39:19 +0000
Received: by mail-yx2-x10.google.com with SMTP id 00721157ae682-85d440939e3so14291707b3.0
        for <kexec@lists.infradead.org>; Sun, 20 Sep 2026 12:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1789933157; x=1790537957; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GOyD94xneAEU7+yzaxi3P4vCBB/CkWgVuLYMi+o49fI=;
        b=A7w3ozFW7SOiXTYPnRicdVNiZhZAAlAAnzlVrIKzC32MmDx1kCaoaFAQwH1SgI0312
         wKbsmoGp+UwdL2HAEsy9TZNBQidAL//f0TrcyFI9zyhX1g0EmJ0SPCg0ZLzmF6Fr1Jc5
         cLLoWP5pe8bQd+bLNj25RxKBY4MHUon3wL8icC7ExDJBhMf0XhM8y3bx6EAXvovAU9H3
         CCaD680AFkdtLk0V7ApVefw9/6dUGZ8QAlgvC0sejLPzR1Ro8KAEoZd0aAK6LTQQaSWA
         xnaynjIENSlRy/3WPJsFPQMN0XyXCE7UnV+3jnMJFXCN0nDEMfAcqzzK05Rpmv3MGYW+
         cvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933157; x=1790537957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=GOyD94xneAEU7+yzaxi3P4vCBB/CkWgVuLYMi+o49fI=;
        b=YWzjkkDH2TjWvyWF1LImEnLgXoLvdE8YXQYOQUY99VZ7zsgSbAgN/oiwyH/jIvABRQ
         HOZCuvaoHpdQT7to+bPjr+Zn+IV1UCaKTPy4ixU5W9i3FTRkqSXIoP8EMYFhsXotxtAD
         r0pHI5uZ0F3x2f7vSqsLWOzW1zfmYdcClODNK2VT6AqON5kUUz9iNHuttd3qhB6rryo6
         GgmYI+AHaFoZi/f8PHDTqDwBMOgiujXlOH36AuMnjyflZwkIHIZLgiWXED5pukQ/zor0
         jNFjfYXFF0pZDHrKn18Zrl4fcUmbyukl1baRKCYo+Jqnim7k6Qdbpix8hrVHxUeVWUhc
         +Dxw==
X-Forwarded-Encrypted: i=1; AKwUvBxPA3x1rUqSCze7maLoGj175rWL3Bt+Wmn13N2xH9ytkxJhuV5sR1Q6PBdjXum0oxG0TrbFog==@lists.infradead.org
X-Gm-Message-State: AFuF++njo57bpbVFVFjZ4aylZ+WEOu/QzsVN8/mb5s8Igva5Rhd///d1
	Hx5+RT/3FomvU1vrU2jLiot7uEECu0YneFtw9ea4L9cfKpKVCsmsyyxh/s0wUGe/roU=
X-Gm-Gg: AYBFou36t4mOeOhbUsuVu5F4XvY6eGHhlKgphQ753lqq+YuZZ9500K1ia3aWod8vBiI
	56zu0DZvGxciA/LJAz1GnkovtU3PiPeN664ES5V/UBG3hoS95D8HgtrkLl4kIIW0SRCjcgnWeNb
	UyEzW0vkpd5D0mAT+H3q6kYG7E9Q3+DGbWugB6xt0vtkUwuhtgyeYWlYR6hH3JoRo9eLvcTNWTq
	We4mGKu339XEuasPVdlo75pUGGu3vVKWdpVfDxLtGkJtVrEg5sXr8ue6BtyE84QbmiSVRm4593F
	PeJ0Kjrk6SBHquVyUkHQQgQXQzgBARGirYNMy6wd8pboQ0xovsfEXRu3FWtdd/S1NMrnVniowGS
	e+ji62O47FcLnJm1dwlTWIV9WRjy5230cfYSLr3P/O/4T3d0L7If45ruNSZh8sqRU7cmgVUFNuK
	6d1/xpV4QuPWQBic9YCEucHW1kREGyGxD9nVOE+vhwZ1bEOss0pSheS8zUSLbq4e3IPPYQ4jWcd
	ot8WngFHl1hsK6SvGhtetFBTQDzKFzBVLQN2QlSXrBXgwFUGphBlMDugKi9qzP8TuQIHLo8ctdw
	YViB9YbhhNaFub9MwwQ=
X-Received: by 2002:a05:690c:e3cf:b0:845:ddf4:a399 with SMTP id 00721157ae682-897308f89e5mr31680887b3.11.1789933156801;
        Sun, 20 Sep 2026 12:39:16 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-89a4761747asm18686667b3.30.2026.09.20.12.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:39:15 -0700 (PDT)
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
Subject: [RFC PATCH 24/46] MAINTAINERS: Add entry for KVM Caretaker
Date: Sun, 20 Sep 2026 15:36:28 -0400
Message-ID: <20260920193650.3373435-25-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
References: <20260920193650.3373435-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_123917_978792_ECE75963 
X-CRM114-Status: UNSURE (   7.25  )
X-CRM114-Notice: Please train this message.
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

Add KERNEL VIRTUAL MACHINE CARETAKER section in MAINTAINERS covering
Caretaker headers, architecture backends, and core execution files.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 23f332cfbd16..86806245041e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14296,6 +14296,17 @@ F:	tools/kvm/
 F:	tools/testing/selftests/kvm/
 F:	virt/kvm/*
 
+KERNEL VIRTUAL MACHINE CARETAKER
+M:	Pasha Tatashin <pasha.tatashin@soleen.com>
+L:	kvm@vger.kernel.org
+L:	kexec@lists.infradead.org
+S:	Maintained
+F:	arch/*/include/asm/kvm_caretaker*
+F:	arch/*/kvm/*caretaker*
+F:	arch/x86/kvm/mmu/kho.c
+F:	include/linux/kvm_caretaker.h
+F:	virt/kvm/caretaker*.c
+
 KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)
 M:	Marc Zyngier <maz@kernel.org>
 M:	Oliver Upton <oupton@kernel.org>
-- 
2.55.0.1082.g2b9226bbc0-goog


