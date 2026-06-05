Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D624CD6E7C
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 17:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mUNSpB3dfOvSGnAPr0UW6nHYEMpqSvyWhzAeEo+qvXw=; b=jnyfe4kg89lL/ejOFRpaSvzWQ9
	6O53xzTpCea3d+eKyNA3ZJmDcuZQkiDtC1s/vuzjT1P2uwHmkYKtcgKfshjXpvG8PN0ItSKFH2D7V
	XpsbtuYvhjsoANjmMMSPWBAeP+Y4icg0SsGpcNoxiPaAm93sYQogc1ycgyGPbDcL0z1+qRK6+R+KJ
	6uajd2lL/wMwtfgIPvMdgSXlI/gHWpb8BFYXYg7P1q79kOdYo4VapCfQvlHSW3juZ7nvwfUqLFGi5
	modOYAYWEYuhxDflH1Xy765OP+zNv8GrFnjiShZktTX5Z2dvqqMtrbKRTR5T4eAMmkLvCv4dE00Ly
	sBm/EiRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVY2M-00000000xDC-0XSI;
	Fri, 05 Jun 2026 17:08:50 +0000
Received: from mail-ej1-x649.google.com ([2a00:1450:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVY2J-00000000xBS-0QKl
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 17:08:48 +0000
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-bec440e6b9fso906966b.0
        for <kexec@lists.infradead.org>; Fri, 05 Jun 2026 10:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780679324; x=1781284124; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mUNSpB3dfOvSGnAPr0UW6nHYEMpqSvyWhzAeEo+qvXw=;
        b=K0zAzURaZkJjYIwTQWSpW3qzqzkVxubGU4sOyHbvedzLMXj40SXEO9pFerofHeD/ET
         JOK2VELOzuP8wlFKZwDLV8MzGPijfSuMv75sGJWEeUXi6nDrbAYROx0WrcB1p1MTHuzS
         HfdneXey5ZCS3rkEwqFYh6o3veLktBgpym0gCcGl+dCgAbOtzBd0KBDF1F29nsyZTxSe
         1VoFabTicO26BrcrCDNR+0oKXzWzwhio2d0neowIU9PQb/HudJrHsDHzXrvgFVEEFx9S
         zAWZQpiEFD8vB3kliTH0O4e73/fVkaixwpzuk+NNGERWBuP5P2qUHfiO8L61FTn2TV1j
         6hkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780679324; x=1781284124;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mUNSpB3dfOvSGnAPr0UW6nHYEMpqSvyWhzAeEo+qvXw=;
        b=KKzmrlXhpFziwkLtNhWUx+yN342pymIRztMvP+xcZQX0lvEKXSE4VtmZqXseKXkdzO
         5zpoxBkBxNH9zP91jnJ8onEBzGn4jsBDuJRhkhfdTTioclQEQ/5b8AfmmHS0HU6J++FC
         oJvfLO7+oS2meyten4CgNp80DWE5IFA04x50xpQTcvSUkexw/TGH9ISGlhzcORLTzHAE
         y/ENPe8/mFFSME6k95wTomR1ACSRAaqIatiWBcsRN2wLLYYCGJYOZJ9pZslo6bT3K8/C
         IoAvwRwf0v58u3eydbRJf9RbfjeRpjsHgOVmTa8NTzXC2hkHdwLLfrv6/dIq/A1g5bxz
         zctA==
X-Forwarded-Encrypted: i=1; AFNElJ8ZX0ua8VDPGs/Y1USAIM2aDJspJGypzVlOQRLR8Y/hV3xxrgW82YA67T49RIIC4bVFWoDFXg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyjPyhuqPnFNmGyhqPq5zcXuvjLmx6hFfhZIyuy7d4NF/XdJ1ie
	T8Hqysj+w5ob9FeaPJZTMeZcLV1k5LcLE5eqq330xZ0BZv+FsJzqWYxj7ooqvExTc6ZZuh8YhBq
	7nDk/9gqzT/s6KZqy9w==
X-Received: from ejbzc9.prod.google.com ([2002:a17:906:9889:b0:bc1:3569:5260])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:9812:b0:bec:18d5:ddec with SMTP id a640c23a62f3a-bf37311392cmr242121166b.41.1780679323496;
 Fri, 05 Jun 2026 10:08:43 -0700 (PDT)
Date: Fri,  5 Jun 2026 17:08:27 +0000
In-Reply-To: <cover.1780676742.git.tarunsahu@google.com>
Mime-Version: 1.0
References: <cover.1780676742.git.tarunsahu@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <c17394cb12c805a7026047beda2563c7bad44a61.1780676742.git.tarunsahu@google.com>
Subject: [RFC PATCH v2 02/10] liveupdate: Add LIVEUPDATE_GUEST_MEMFD config option
From: Tarun Sahu <tarunsahu@google.com>
To: Jonathan Corbet <corbet@lwn.net>, vannapurve@google.com, 
	Tarun Sahu <tarunsahu@google.com>, fvdl@google.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Shuah Khan <skhan@linuxfoundation.org>, sagis@google.com, 
	aneesh.kumar@kernel.org, skhawaja@google.com, vipinsh@google.com, 
	ackerleytng@google.com, Pratyush Yadav <pratyush@kernel.org>, david@redhat.com, 
	dmatlack@google.com, mark.rutland@arm.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
	seanjc@google.com, axelrasmussen@google.com
Cc: linux-kselftest@vger.kernel.org, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260605_100847_151670_19491FDB 
X-CRM114-Status: UNSURE (   8.26  )
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

Introduce the LIVEUPDATE_GUEST_MEMFD Kconfig option. This option
enables live update support for KVM guest_memfd files, enabling
guest_memfd-backed memory preservation across kernel upgrades.

Currently this support only guest_memfd files that are full-shared
and pre-faulted.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 kernel/liveupdate/Kconfig | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
index 1a8513f16ef7..0bbc4037192e 100644
--- a/kernel/liveupdate/Kconfig
+++ b/kernel/liveupdate/Kconfig
@@ -88,4 +88,19 @@ config LIVEUPDATE_MEMFD
 
 	  If unsure, say N.
 
+config LIVEUPDATE_GUEST_MEMFD
+	bool "Live update support for guest_memfd"
+	depends on LIVEUPDATE
+	depends on KVM_GUEST_MEMFD
+	default LIVEUPDATE
+	help
+	  Enable live update support for KVM guest_memfd files. This allows
+	  preserving VM Memory backed by guest_memfd file across kernel live
+	  updates.
+
+	  This can only be used for the guest_memfd that are fully-shared
+	  and pre-faulted.
+
+	  If unsure, say N.
+
 endmenu
-- 
2.54.0.1032.g2f8565e1d1-goog


