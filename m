Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE36CD343F
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 21:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d0sYZnhQeLyzvjO7vpNeSMDXaPgGF/81BOZ3a8GGZZ8=; b=JP5akpAEkQh4r1lAPTo9SoHLv8
	9lmWqhFzJxytUlqIKCM50U/Gg4vn8NCReoS4Iy2m9PqsJhWKk03KZvXuZ6akcc2E8IQRq+Oq1zZ14
	JZbdv8squCsmQhI01XMSagHKKdrW8jTppenMj1hsHBNGZFSeHdnFdvA+oZnwHKFuhFQNzBEhWsIkI
	D/dT9pAQxFyOHW+OtQjMktDV3izKd/To8J3gVGcQfdgCXmmoORrOi0Z32xOdV0D7P1Zyz7h6xL1Vp
	ja8m4C0kX9qZG+EsjO2a3nHLT72yE3QqJ7JDW/o2dVzT4v4iZDTuFhnaqIukADR2pi1RqWP0iJ+tw
	JrhBPusA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzsy-00000009ULF-3xyk;
	Fri, 15 May 2026 21:15:56 +0000
Received: from mail-dy1-x132e.google.com ([2607:f8b0:4864:20::132e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzsv-00000009UIA-194K
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 21:15:54 +0000
Received: by mail-dy1-x132e.google.com with SMTP id 5a478bee46e88-30246cfd41aso1516324eec.1
        for <kexec@lists.infradead.org>; Fri, 15 May 2026 14:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879753; x=1779484553; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0sYZnhQeLyzvjO7vpNeSMDXaPgGF/81BOZ3a8GGZZ8=;
        b=e8EOWGfCJjfpCpLoKvhPmyCbALgrksVb8YVN7N0/gAB2U4oayO6O3u28Fzsnn191ii
         bhlbVIceyxW2q4cXz4sOifwbXNdsE0pDempCoZPbUMm5ANJWZLpB6gPPszBc3WyXsPQn
         iKAtBd9CM6HS4hNO14VpKSTIBIB1eVRzczta3zttG5JUCceegdOfFA0dG7lecx1KWzNf
         S/gY1SuCUcyAYgf17xf6W8ccIeg7WS4pTfQhypxLP1edMJcAXqH8lEOyqaD9u9Bwjz+O
         wjB2NfDAszQZYcA81Ocl6Ov2kCIWs/BsyMfdhWdrQ/ZoDELxQynjDaM1NLCIVj61Y9hr
         nrHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879753; x=1779484553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d0sYZnhQeLyzvjO7vpNeSMDXaPgGF/81BOZ3a8GGZZ8=;
        b=cCMTvIjnkFrChrmqOXAqjtb701ZOxP7gvy7fMD3AVFL/zgpn2dINdkopCTKZXVjke/
         kqwk0pZUtICWLL7r3D6WXkvWN4GVXL0cyj8c7F5Llq7/iYrUtNzmxC1bNdiu84KpQ2A1
         VuqVko/J76AKALLvsIDpgt1G79PNUtAObrQr2OekIzad6MGb3IrNbE4jTuQ+CeENFvkj
         WST8rNWwGZ7OEboLzCeBFGO+SBuCTpaBHEc1nWUOSf2rP6ycJO8YKrMn6WQ7lBgeIEw0
         wHzs1CloJBXyRBIx2c6t4KxvgdGFQ2Sc9qdP8EYV/o7qZAjng/hM3Xbb4PL8kOs7hpvG
         RW8Q==
X-Forwarded-Encrypted: i=1; AFNElJ/MqW6CrolLZIbiClTeraNvY1VzTM/UiAgLvwh11bz9ZRUVGpjO239lKf5ys9UqFbgd0YvRAQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxCF0ggHNpt0jMTDJwWtBP3/9SjlcM/tlq3GEthcYotsloB6/tq
	6QZfzwO5n4UOPEqxrumUzcE8IUwEds1ZEwo7fti2fG97ckCMfZCZfHOa
X-Gm-Gg: Acq92OG16axS6sDNZxGg2UHKUEgV8X60Whv1JoavxJwzyHfbMdy38y53Kgf4LQhXhYy
	2Qd2ZxUCmHyHUQ2STEN8TkJfrMWBc9T3TqW3vJXeBISQN2tVwZ5GR0BnWsgHzwdMSshuOFA/fFO
	ixy+8nokpS3c7KC1OSy8itmKeS24iKUKXvKHKPI8N3YWUYVS/0fJ+G798xTkztmmqq7p9uGQOZO
	hBigKqSuo2ysHNfq0TPMj/bux5cp5gg0iDS0a4b93CZwzNXuv6sCJY6uAUBDq4Ka6EFZnO9+O3M
	LeGuMVoZjTRt47T2lDI8jvpiAFz0px/Ok1hqAkMjnSLTaZ5Ht/UXFWtYCuqvxogJ4Sz1dCAzF0N
	N+OS1WxvtvpHWMGOGQVHOSjxnm/fObCkiXbOivVZgFdTFaJrd7Rw6K2ZqOtyEJKiR9fwQ7n9VG9
	6jT+zmsj0MflAkXI3lizj0HMSYx49zWRKA0ZBrNny/yQ==
X-Received: by 2002:a05:7301:290f:b0:2da:7e33:9261 with SMTP id 5a478bee46e88-3039869b7b3mr2853046eec.27.1778879752504;
        Fri, 15 May 2026 14:15:52 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30297bbc9a3sm8132550eec.31.2026.05.15.14.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:15:52 -0700 (PDT)
From: Ross Philipson <ross.philipson@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-efi@vger.kernel.org,
	iommu@lists.linux.dev
Cc: ross.philipson@gmail.com,
	dpsmith@apertussolutions.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	dave.hansen@linux.intel.com,
	ardb@kernel.org,
	mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com,
	peterhuewe@gmx.de,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	luto@amacapital.net,
	nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	corbet@lwn.net,
	ebiederm@xmission.com,
	dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	kanth.ghatraju@oracle.com,
	daniel.kiper@oracle.com,
	andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: [PATCH v16 35/38] reboot/slaunch: Secure Launch SEXIT support on reboot paths
Date: Fri, 15 May 2026 14:14:07 -0700
Message-ID: <20260515211410.31440-36-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515211410.31440-1-ross.philipson@gmail.com>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_141553_316335_E3973787 
X-CRM114-Status: GOOD (  13.18  )
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

If the MLE kernel is being powered off, rebooted or halted,
then SEXIT must be called. Note that the GETSEC[SEXIT] leaf
can only be called after a machine_shutdown() has been done on
these paths. The machine_shutdown() is not called on a few paths
like when poweroff action does not have a poweroff callback (into
ACPI code) or when an emergency reset is done. In these cases,
just the TXT registers are finalized but SEXIT is skipped.

Co-developed-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 arch/x86/kernel/reboot.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 6032fa9ec753..87835706bb4f 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -14,6 +14,7 @@
 #include <linux/pgtable.h>
 #include <linux/kexec.h>
 #include <linux/kvm_types.h>
+#include <linux/slaunch.h>
 #include <acpi/reboot.h>
 #include <asm/io.h>
 #include <asm/apic.h>
@@ -779,6 +780,12 @@ static void native_machine_restart(char *__unused)
 
 	if (!reboot_force)
 		machine_shutdown();
+	/*
+	 * The comments for slaunch_finalize() provides the explanation for the
+	 * conditions required to do the SEXIT op reflected in the conditional
+	 * parameter do_sexit.
+	 */
+	slaunch_finalize(!reboot_force);
 	__machine_emergency_restart(0);
 }
 
@@ -789,6 +796,8 @@ static void native_machine_halt(void)
 
 	tboot_shutdown(TB_SHUTDOWN_HALT);
 
+	slaunch_finalize(1);
+
 	stop_this_cpu(NULL);
 }
 
@@ -797,8 +806,12 @@ static void native_machine_power_off(void)
 	if (kernel_can_power_off()) {
 		if (!reboot_force)
 			machine_shutdown();
+		slaunch_finalize(!reboot_force);
 		do_kernel_power_off();
+	} else {
+		slaunch_finalize(0);
 	}
+
 	/* A fallback in case there is no PM info available */
 	tboot_shutdown(TB_SHUTDOWN_HALT);
 }
@@ -826,6 +839,7 @@ void machine_shutdown(void)
 
 void machine_emergency_restart(void)
 {
+	slaunch_finalize(0);
 	__machine_emergency_restart(1);
 }
 
-- 
2.47.3


