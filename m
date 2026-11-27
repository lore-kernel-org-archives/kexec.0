Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EF1606A323
	for <kexec@archiver.kernel.org>; Fri, 27 Nov 2026 10:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hu/kFCxa;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=YlyhPKv6;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=NpzGw6+M
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=HVSl6b5c2ppW1s1gs/r7uBuxxOLF4+FVkqsE8xMgcNA=; b=hu/kFCxacsP8BENULEBYfPgKor
	S/Y9DfH0PTaPhi7TUr24ZYZyenzUrXgMfua9u6/aB9W4KsE1Y2iKCKJX8H8j8S9B3/UOuXDV9OxsL
	pS4gAhLymo8wqYaj2kSyyC3Oasj6eIYIuivZ6ktV6IbtsT9M4rqRWdIQMds98gera9jPdnk2QhB+k
	1Gd706d3CfZn7JQ8j0ejYiT4eW9vSzkRtCPBNMsYErVkiR2sbX5qYb8DrSS7MMRbL/ThWlvWeGJPr
	kC0EFV9YTF2WIJZ0r8KpEiC43t5urY52f0YgbhW1+pMjTcY1CHLjN8bxXide0nWUGqqihWzi0gWuI
	DUgSvOxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWsuJ-0000000FXEz-10g4;
	Fri, 27 Nov 2026 10:10:19 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWsuA-0000000FX3X-3lbm;
	Fri, 27 Nov 2026 10:10:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Content-Transfer-Encoding
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=HVSl6b5c2ppW1s1gs/r7uBuxxOLF4+FVkqsE8xMgcNA=; b=YlyhPKv65/8dEG3zJX5N6uum33
	SPZxddmGAgVQbfpv9dF46O+yybYdAlifU27ObW9cMkkTpW12oDHwbS+UcLJ1xlgSGObT3cxS8Nz+Z
	TaV5+XQz2yjN7jY4wLPx+J5CDR5ncs7tAMZOu319+V/1qLRhPg4u0n4BjWjFUoW4uBsG1EFXdZwEV
	Mp6rIgiKk0Ga+kHnA8pHobAxfdi1w1E5qQ078/dJlVTTkfDS7G1kDXi77z4U6rqJ+KUrsd3/k53Y5
	o33MZXu8iOAYfbgq/agHtPnhgqi9Nqoe7kvWmEITcIuVNP1XkhDF5s90fIYilb9H7WQ7HmATgLlr+
	3oAJdXIA==;
Received: from [113.46.200.226] (helo=canpmsgout11.his.huawei.com)
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWsu6-00000007Yqj-0ySz;
	Fri, 27 Nov 2026 10:10:09 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=HVSl6b5c2ppW1s1gs/r7uBuxxOLF4+FVkqsE8xMgcNA=;
	b=NpzGw6+Maniy/c5MFunJnf7wYcJsTElQBOF11nkTDHOYpouatcIxn5TFiqapwtGxM9OjZyrR1
	TjAEvlfSdFw+Eht4lbqYKdx5cVBPVpmFaS4uJrWbfyerOyiQmo7VA/zEJ3wsz3dYt2x3UKAuBRS
	2WydvfmGfe+/sQQ/ctn39Lw=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4jbTfW6jbpzKm98;
	Fri, 27 Nov 2026 18:09:23 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id D818B40586;
	Fri, 27 Nov 2026 18:09:43 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 27 Nov
 2026 18:09:41 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <pjw@kernel.org>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <robh@kernel.org>,
	<saravanak@kernel.org>, <akpm@linux-foundation.org>, <baoquan.he@linux.dev>,
	<rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<ben@cressey.dev>, <leitao@debian.org>, <mpilaniy@redhat.com>,
	<yeoreum.yun@arm.com>, <coiby.xu@gmail.com>, <Yeking@Red54.com>,
	<prudo@redhat.com>, <bradley.morgan@linux.dev>, <sourabhjain@linux.ibm.com>,
	<blum@kernel.org>, <hbathini@linux.ibm.com>, <qirui.001@bytedance.com>,
	<hui.wang@canonical.com>, <sohammetha01@gmail.com>, <guoren@kernel.org>,
	<gaohan@iscas.ac.cn>, <ionut.nechita@windriver.com>,
	<vishal.l.verma@intel.com>, <seanjc@google.com>, <ardb@kernel.org>,
	<arnd@arndb.de>, <tzimmermann@suse.de>, <kas@kernel.org>,
	<rick.p.edgecombe@intel.com>, <mhklinux@outlook.com>, <piliu@redhat.com>,
	<shradhagupta@linux.microsoft.com>, <thuth@redhat.com>,
	<ebiggers@kernel.org>, <me@linux.beauty>, <mclapinski@google.com>,
	<graf@amazon.com>, <tangyouling@kylinos.cn>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v9 01/11] kexec: Free the elf core header in kimage_file_post_load_cleanup()
Date: Fri, 27 Nov 2026 18:09:15 +0800
Message-ID: <20261127100925.3019877-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127100925.3019877-1-ruanjinjie@huawei.com>
References: <20261127100925.3019877-1-ruanjinjie@huawei.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk200008.china.huawei.com (7.202.194.74)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261127_101006_802539_4BCA1C62 
X-CRM114-Status: GOOD (  13.44  )
X-Spam-Score: 0.4 (/)
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The elf core header buffer is generic state, but arm64, LoongArch,
RISC-V, x86 and powerpc each free it in their post-load cleanup.  Move
it into the generic cleanup, which also gives the loader a helper to
release it on error.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/kernel/machine_kexec_file.c     | 4 ----
 arch/loongarch/kernel/machine_kexec_file.c | 4 ----
 arch/powerpc/kexec/file_load_64.c          | 4 ----
 arch/riscv/kernel/machine_kexec_file.c     | 4 ----
 arch/x86/kernel/machine_kexec_64.c         | 4 ----
 kernel/kexec_file.c                        | 9 +++++++++
 6 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 14f453dd0946..097ee397e949 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -32,10 +32,6 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	kvfree(image->arch.dtb);
 	image->arch.dtb = NULL;
 
-	vfree(image->elf_headers);
-	image->elf_headers = NULL;
-	image->elf_headers_sz = 0;
-
 	return kexec_image_post_load_cleanup_default(image);
 }
 
diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
index 0fe60907b97f..f16d9ab14726 100644
--- a/arch/loongarch/kernel/machine_kexec_file.c
+++ b/arch/loongarch/kernel/machine_kexec_file.c
@@ -28,10 +28,6 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
 
 int arch_kimage_file_post_load_cleanup(struct kimage *image)
 {
-	vfree(image->elf_headers);
-	image->elf_headers = NULL;
-	image->elf_headers_sz = 0;
-
 	return kexec_image_post_load_cleanup_default(image);
 }
 
diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index bd80c5fb1b1f..0cf03cee35a7 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -841,10 +841,6 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	vfree(image->arch.backup_buf);
 	image->arch.backup_buf = NULL;
 
-	vfree(image->elf_headers);
-	image->elf_headers = NULL;
-	image->elf_headers_sz = 0;
-
 	kvfree(image->arch.fdt);
 	image->arch.fdt = NULL;
 
diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
index 26cd2a8bd0cd..1d67fb42617a 100644
--- a/arch/riscv/kernel/machine_kexec_file.c
+++ b/arch/riscv/kernel/machine_kexec_file.c
@@ -29,10 +29,6 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	kvfree(image->arch.fdt);
 	image->arch.fdt = NULL;
 
-	vfree(image->elf_headers);
-	image->elf_headers = NULL;
-	image->elf_headers_sz = 0;
-
 	return kexec_image_post_load_cleanup_default(image);
 }
 
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index c3f4a389992d..0a66cc268ee7 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -600,10 +600,6 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 
 int arch_kimage_file_post_load_cleanup(struct kimage *image)
 {
-	vfree(image->elf_headers);
-	image->elf_headers = NULL;
-	image->elf_headers_sz = 0;
-
 	return kexec_image_post_load_cleanup_default(image);
 }
 #endif /* CONFIG_KEXEC_FILE */
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index b668ce8d68ee..1f128c6e6fa3 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -102,6 +102,13 @@ int kexec_image_post_load_cleanup_default(struct kimage *image)
 	return image->fops->cleanup(image->image_loader_data);
 }
 
+static void kexec_free_elf_headers(struct kimage *image)
+{
+	vfree(image->elf_headers);
+	image->elf_headers = NULL;
+	image->elf_headers_sz = 0;
+}
+
 /*
  * Free up memory used by kernel, initrd, and command line. This is temporary
  * memory allocation which is not needed any more after these buffers have
@@ -120,6 +127,8 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 	kfree(image->cmdline_buf);
 	image->cmdline_buf = NULL;
 
+	kexec_free_elf_headers(image);
+
 	vfree(pi->purgatory_buf);
 	pi->purgatory_buf = NULL;
 
-- 
2.34.1


