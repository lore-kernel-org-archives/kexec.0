Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBE0CD343F
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 21:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aFOHDGCsOHbtZzrbMRrMDpLy4uq6fKhTRLiSKMVovBw=; b=SMdc1YdK+PDn5P/RXAcjB7oqym
	E3QXJCxPSPdTOBw/V1CB2Ox9OSzfGP5La68oVK2sxF0cgd55UkiGEABnZcL3fHvwntfIHze27NW8M
	gh4i9M8zn3cOrItYXtMVpKbndXNDDJ/u2jVqFNX+vH7H3w5N1wZ8ztXfB9Vd19ptUfVC7sila50zw
	J3+k6K+Cb+E6ECYXfjn2f2Dx4CCBxN1nm+eqdm4aOrUPILe7kF5q1hUQADeN9IbVOJezvW903uQBR
	xQ0i4I4C4cZHKI6V0pT/IjzCVEtSFT742QB7NH1UXZ2SvuiJLRzg4kurOHOL3rQUvVuJTehgUmi/J
	YmnXUn0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzs8-00000009TYU-0iLv;
	Fri, 15 May 2026 21:15:04 +0000
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNzs3-00000009TTv-1lRA
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 21:15:01 +0000
Received: by mail-dy1-x1332.google.com with SMTP id 5a478bee46e88-30246cfd41aso1511261eec.1
        for <kexec@lists.infradead.org>; Fri, 15 May 2026 14:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778879698; x=1779484498; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFOHDGCsOHbtZzrbMRrMDpLy4uq6fKhTRLiSKMVovBw=;
        b=YlnBVfAi6ewdprsB+U/wkuXWm46ULiMtT0WU6GpL+pWwN7IQvx2f6XOX44jX5Zjz0S
         cNqghl15KPi/mtUMzAE4GrMoPlZMfvGWAS+YeR8yyk4DUq2zQnr0mqRqK31Uw8PV6cqr
         gndZAJFgPstQCv1jJvvSvhAywsCupafOLeauxMo++OVnzPKLQkRpcvw2tsCD2b16y1mC
         Oa3KJ+tlAnFqMN8QV1E6DWxA200ovVwpPwkZldwN6JA9VP/lZqdkrPaJcBD/NNlcI50K
         6yDRMYc1uqkeqbdzj3S2Nze1vph26EqdpgWqpQt290HS6nj8ouAF9ZWBCV0YU2Vj8hys
         mdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778879698; x=1779484498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aFOHDGCsOHbtZzrbMRrMDpLy4uq6fKhTRLiSKMVovBw=;
        b=F+rmubqeFhk8dnm+1xf5jO6r8N003lKjQVnYUtCtKdBKwnT6QkUj4sH4J9g9yvOXRZ
         gH9QBmjR2JDg9ndsUPJpDP0HN+Jr4sc0GZNo8sokpSET1bTwZvWUHzhIwWGkhinvVGWy
         cSONM8ZwjIB8ChqqUys4RsnT8O3lE1OQV/0yRALBAGFxG0I046eamPFfzEiHxxCTy/Re
         JdrEIG/EX6H27976c3SidqfgWMHJLZecSq5kIcitu9vOZQAbgTCqTzYdh5xEgukm3EVG
         SelTVMKOcgQDpPWCj7yPaa2lMx4MAW9KB09Mdc2Kgm3s1hEgTfqFcBplKGqQLAE/8WKO
         D0dg==
X-Forwarded-Encrypted: i=1; AFNElJ9v78iXdohUYqzOqQgL40YY4BWYadaAVoL6rw4nA7XfXUpIo7ndncegAFbJS1CiO2gRipIJ9Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YxExbR2EaUPj7+8cMR5PHtGLXjrzj2qlQFyOa9PdvVZ3nlezNog
	FDJzN5ojaQOSCQ0+qdHZ4GrLHeLiksoiA0dfnzbnfoYnPC2/MLpT47cQ
X-Gm-Gg: Acq92OHUpHyKbDA8Y94Cx40wABH4+/h+regGYPnFIWk910RV93reol5O9RJeDwtdP+g
	DhosYff2fvV58VhUx389qt3oWJ5GPediJJGsokeP3/zh553LPgS+UJciqU38kP3GPl4CfuExZXe
	f/OTUMD88rAnBN2BnWa5+DK491y4pLg9CgeU5tir3OwywKZO6/tAnSDBVuJGlyNYwtHNk+3Q/Ov
	nAWYp9jD4hZ8MekgseUALPJR2AyoT8CKI0SRSpQrgZnMVjyREaCOI/T8PsoXKZgTDASIBmU3+xj
	3d8qmP/ijyJL/T1vA6DXK+e9AgSw0uuHBF4QaAMDzc5NhJklEwSHP76OJ0DJDwbFdVwocJLVs9i
	XFlH4FYEaaysUzf2c3nu5/vkOG5J+59urA9oAKBxjQjvkLa6toNxqTh/4lryGmxRKxKx/cCB3gA
	adlmpqxkl2Kie6xOXoI1R4htGITFD/LicGuj9dnWp3NA==
X-Received: by 2002:a05:693c:8386:20b0:2df:919f:ce59 with SMTP id 5a478bee46e88-30398678a48mr2108609eec.19.1778879698427;
        Fri, 15 May 2026 14:14:58 -0700 (PDT)
Received: from mimas.lan ([2603:8000:df01:38f7:a6bb:6dff:fecf:e71a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302973bbd50sm7961724eec.20.2026.05.15.14.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:14:58 -0700 (PDT)
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
Subject: [PATCH v16 16/38] x86: Secure Launch Kconfig
Date: Fri, 15 May 2026 14:13:48 -0700
Message-ID: <20260515211410.31440-17-ross.philipson@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515211410.31440-1-ross.philipson@gmail.com>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_141459_461417_06BD5CD7 
X-CRM114-Status: UNSURE (   8.31  )
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

Add an x86 Kconfig option for compiling in/out the Secure Launch feature.
Secure Launch is controlled by a single on/off boolean.

Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
---
 arch/x86/Kconfig | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e2df1b147184..fd9edb0651d9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1989,6 +1989,21 @@ config EFI_RUNTIME_MAP
 
 	  See also Documentation/ABI/testing/sysfs-firmware-efi-runtime-map.
 
+config SECURE_LAUNCH
+	bool "Secure Launch DRTM support"
+	depends on X86_64 && X86_X2APIC && TCG_TIS && TCG_CRB
+	select CRYPTO_LIB_SHA1
+	select CRYPTO_LIB_SHA256
+	select CRYPTO_LIB_SHA512
+	help
+	  The Secure Launch feature allows a kernel to be launched directly
+	  through a vendor neutral DRTM (Dynamic Root of Trust for Measurement)
+	  solution, with Intel TXT being one example. The DRTM establishes an
+	  environment where the CPU measures the kernel image, employing the TPM,
+	  before starting it. Secure Launch then continues the measurement chain
+	  over kernel configuration information and other launch artifacts (e.g.
+	  any initramfs image).
+
 source "kernel/Kconfig.hz"
 
 config ARCH_SUPPORTS_KEXEC
-- 
2.47.3


