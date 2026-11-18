Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EFB606A336
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 01:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ocPsX0T9;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kOeEl9X+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=V9EREMneO4XizL3Clpv5CY8sfTjFH2UvufjSaKqXPZM=; b=ocPsX0T9u3z4off1lJ01XX53K4
	pVUeNcNizoI2G/y9lIFLwvTv2zCvTpty+5DDO6XyRrerl+NFjDJc+mvd22rjcTabZ7o8Pm8WlodwU
	OM9ZY35HZzqc/k2kg/G2IPZv22BucwHuotr7Z0rekuWwYi0qy9Mh7Pc4giX7kFGCYsJ2U3fo46AGX
	MOplWspDAFOBqhTYxWl3JZmmXisxmQQCArMNA2IBjJ+VokH4CkYcRIU4YlLB9XgwkoHAOn9YGgy5+
	H+lC3X6Czu0A9RnhZDJX74lJQaX0LOTWE/doKYVxk9FVl6L+taFEI/3v9OjnBOYD+DtVrNoPNcdKI
	ELZMgrJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTUcD-00000007SsR-0FMc;
	Wed, 18 Nov 2026 01:37:37 +0000
Received: from mail-dy1-x1333.google.com ([2607:f8b0:4864:20::1333])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTUcA-00000007SrY-1DEC
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 01:37:36 +0000
Received: by mail-dy1-x1333.google.com with SMTP id 5a478bee46e88-381d542bc29so954180eec.1
        for <kexec@lists.infradead.org>; Tue, 17 Nov 2026 17:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794965853; x=1795570653; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V9EREMneO4XizL3Clpv5CY8sfTjFH2UvufjSaKqXPZM=;
        b=kOeEl9X+KBzaJPycJplqRZmSXBFm3P3yTaWpKatq0wKya+GWuGnWDezNj78+csof+4
         /NNki8vlYvIj5hge5PQc7ucg9hgyZLqXSgu/0WjSHAqJctrJv9LcZ5vqH00kLmLRPKVb
         Vrw3+NkwAzJwEXNMXJm1QzHb7J2574bv7OEQ4WQvk6IqpxEH95UASJShN+b9IrFzPpUS
         scLDN4Ftg4n8WFxkc/HNuU49H17GLx2EQ76LHINto79sBouTgK7O2OaJC8L4qCvDAazC
         6Xi1yraWd0IoiV9VGDzQedE/zt48b+k+9zEMTqC8pcHg7a7sqkq3jRxTXjXWgmPW3lbG
         HoxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794965853; x=1795570653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V9EREMneO4XizL3Clpv5CY8sfTjFH2UvufjSaKqXPZM=;
        b=ecykwXZ8vBm6v5nK8M+C9YPXk70hmxhHX+0aBlUj13k0H4YWQDEEJCMPNCeU932Nhz
         dOuspqGfLQYaAmeFbtBso5887p7FF6GuHPgtlhNvUgbasHtR5mJ7u/VV45zX+y+3HDGJ
         250UyZ2rSfd1PQVuSLiKHy9CV8RUktH50ESPCsgvv21uxXeY7EaKKTJqZ11bp76kLF+y
         kl/jlB5o4wyrr9cxFzkLchpNYhAM2NQyQe65lqr7l38VG84OZLewonjt2JwFgkGo7Ucj
         O3AguobIwfj3h1D0PLWQFXcTX/w27RRzNx/nEwoasN7Azz0AScLyw1V751EIBsQvc4FW
         LlqQ==
X-Forwarded-Encrypted: i=1; AL+hErGRM/GSHWn0E7Xr7iv+pMsiwu1kuLRfZiTglahMobMZR70q40mE82OdPvR5kbv3RrmwKzAIbQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z/o8Rs3smLwRtl7aSBkh8qIQLSrK3egTfayuD06Gi2EJY2XBD7C
	YL63qfUh2iiKs8v+IlgcxCz0Pn6kU6Yg1HxTdJpSf0dJc6XklzZrkkNW
X-Gm-Gg: AZFdTZcpSAXsjqGBvVcvHMMoj6BYwKVX4cOT40lb/mDwTr5Cn0lPKYkidDp9z+/DxVA
	9CZwk6irNkRdIFfQAu0yewP6DC6nglL1k/z6BMnprHERZf9SyIqIjRQAKV6mrEOJJY0Oedo4Kqu
	7VPBHPoyd8xmLElaTeYxX/9OIv4AU65imNjyJ2V7bHblpnc2ulDIUHi02RQfiSx4TgICHKKrZ5n
	teg14SFNK3hjVOne2YIJ1XFsa9PWX1HE8EKikdFRgyilxuCBiFM8vFZM5heObi6mkG67SW65J+b
	zJ2geMgsTCY3BGb5ibEUzj0iqI2eopoSHFuHXh7Ew6hCSBOz0QHSpss46h3r37Ko9DFyE5mybNE
	UTsJSTYX/WjYas5VHVyZM5KvVJRKhBF10eYywIEO8ymPt+3+5BmfhEugcf1ykB4V+50/S6eCZYp
	+2ha16zSR6OqXktOeRi0um1EHfAum5Cf71DLn6DQYbbI3tfD3WFTaJobCcRmafugCYkAilOY4EW
	Sd+mfIWh6XnCPG8S2lIHvtbyJcZ5W+jD0huwJVBr+qIuDcmv0kdsT1/i52yaRsvnvj/ZQFOQIgR
	RrShI+S05hqu5iYsO2c07PuxtRJZ9I3cM8gNgcZDI90xJugjs4JqFDn+Tr2BjIEBvCO1InUpt0A
	H9SMHKGGuy0H5YBLZlW0l8c1wh5QT90U7Fg==
X-Received: by 2002:a05:693c:88d7:20b0:36e:aa5c:7851 with SMTP id 5a478bee46e88-3828141dd08mr1114681eec.27.1794965852612;
        Tue, 17 Nov 2026 17:37:32 -0800 (PST)
Received: from pop-os.tail4adac7.ts.net ([2601:647:4084:777d:b8c6:5c98:d786:f7f1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a72eb2f3sm2171733eec.18.2026.11.17.17.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 17:37:31 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: linux-kernel@vger.kernel.org,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Mike Rapoport <rppt@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org,
	kexec@lists.infradead.org,
	Cong Wang <cwang@multikernel.io>
Subject: [PATCH] riscv: kexec_file: Verify the signature of Image files
Date: Tue, 17 Nov 2026 17:37:29 -0800
Message-ID: <20261118013729.576325-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_173734_337224_509C6DC3 
X-CRM114-Status: GOOD (  15.52  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Cong Wang <cwang@multikernel.io>

kexec_file_load() on riscv cannot check that the kernel it is given is
trusted. KEXEC_SIG is not selectable, so a kernel that is locked down
has to refuse kexec_file_load() altogether, and there is no way to
restrict it to kernels signed with a trusted key.

With CONFIG_EFI the riscv Image is a PE file, the same as on arm64, and
can carry an Authenticode signature added by tools such as sbsign.
Verify it with kexec_kernel_verify_pe_sig(), as arm64 does, and let
riscv select KEXEC_SIG, KEXEC_SIG_FORCE and KEXEC_IMAGE_VERIFY_SIG.

KEXEC_IMAGE_VERIFY_SIG is no longer specific to arm64, so drop "(ARM)"
from its prompt.

The ELF loader has no signature format, so a vmlinux is rejected
whenever signature verification is enforced.

Tested on QEMU virt with KEXEC_SIG_FORCE=y and a test certificate in
the built-in trusted keyring:

  signed Image                    loads and boots
  unsigned Image                  -ENODATA
  signed Image, one byte flipped  -EKEYREJECTED
  Image signed by an unknown key  -ENOKEY
  vmlinux                         -EKEYREJECTED

This is needed by multikernel, which loads its kernels with kexec_file,
but nothing here depends on it: it applies to any kexec_file_load() user.

Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 arch/riscv/Kconfig              | 12 ++++++++++++
 arch/riscv/kernel/kexec_image.c |  3 +++
 kernel/Kconfig.kexec            |  2 +-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index e7891a2a89da..f47bca71aa35 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -1122,6 +1122,18 @@ config ARCH_SELECTS_KEXEC_FILE
 	select HAVE_IMA_KEXEC if IMA
 	select KEXEC_ELF
 
+config ARCH_SUPPORTS_KEXEC_SIG
+	def_bool y
+
+config ARCH_SUPPORTS_KEXEC_SIG_FORCE
+	def_bool y
+
+config ARCH_SUPPORTS_KEXEC_IMAGE_VERIFY_SIG
+	def_bool y
+
+config ARCH_DEFAULT_KEXEC_IMAGE_VERIFY_SIG
+	def_bool y
+
 config ARCH_SUPPORTS_KEXEC_PURGATORY
 	def_bool ARCH_SUPPORTS_KEXEC_FILE
 
diff --git a/arch/riscv/kernel/kexec_image.c b/arch/riscv/kernel/kexec_image.c
index 963a25f5b55b..b1cec911adc5 100644
--- a/arch/riscv/kernel/kexec_image.c
+++ b/arch/riscv/kernel/kexec_image.c
@@ -93,4 +93,7 @@ static void *image_load(struct kimage *image,
 const struct kexec_file_ops image_kexec_ops = {
 	.probe = image_probe,
 	.load = image_load,
+#ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
+	.verify_sig = kexec_kernel_verify_pe_sig,
+#endif
 };
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index a97ed9605602..24c28978f21b 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -69,7 +69,7 @@ config KEXEC_SIG_FORCE
 	  the kexec_file_load() syscall.
 
 config KEXEC_IMAGE_VERIFY_SIG
-	bool "Enable Image signature verification support (ARM)"
+	bool "Enable Image signature verification support"
 	default ARCH_DEFAULT_KEXEC_IMAGE_VERIFY_SIG
 	depends on ARCH_SUPPORTS_KEXEC_IMAGE_VERIFY_SIG
 	depends on KEXEC_SIG
-- 
2.43.0


