Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96814F3026E
	for <kexec@archiver.kernel.org>; Sun, 15 Mar 2026 17:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YRgTtVCfp33nFF3iOJpPBpviRk62A8CIxOCCKEiDg4M=; b=qaQOVeNGqtU8gbOUgoMCW2rKr+
	bEMdeBVGjQKOjY5p2/5WFbWMaryVlrlPN10kenR4G8TiPi/phuw8IR91RvgBmhVonmeU0p4qajuwW
	IFYmxjuHNikZgG262i4Hr4FU4DgJzwQVLttHIlvI5P1WBvS/UY0fNr4MhCV+DgHnTjH5MoUXIWFYQ
	WwoWIOjDUjGB/UiOGb8hyRHzHffrx+M4LsZQwcnCTxz2gm0HqeK6wA9A1eBVymSdLu9HbcqbyltzF
	VVyr8ZY5RFlQsHNgEjEpKJ9fETP/D5i9LXVfLmfbTKtoIwFVRvikLaKaFwntX+/g3vtxgeZfpsocD
	CcTwlItg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w1oyv-00000002kds-3vih;
	Sun, 15 Mar 2026 17:10:25 +0000
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w1oyu-00000002kdJ-0yZk
	for kexec@lists.infradead.org;
	Sun, 15 Mar 2026 17:10:25 +0000
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-483487335c2so36311475e9.2
        for <kexec@lists.infradead.org>; Sun, 15 Mar 2026 10:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773594622; x=1774199422; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YRgTtVCfp33nFF3iOJpPBpviRk62A8CIxOCCKEiDg4M=;
        b=WvsRz5NOL2lYEx7Dk3oQZPw/UMPO5gg2ZiLfU00COa5FLjQryHg0nTjePKsFNetgzb
         z/cVDuMz643C80bf0XjLhSWeD36uf5e4FnEvMeYawhOd6lLpZaBWgxEauOWJed9yLyuy
         QklrdtPDG+cy228MoNFi7wO9VeFsaTb6ElXF81sR6IaRdyuBHnVLEojJj+/fWJXApA6c
         5NhXksxqfeoYbs802ke0tTbxroDBdFN2h4dYUXrCKIneycFhlwdb6GR8ZzwftM59z2xK
         WS1NxvXHrtkbamh5gNMErQc3mKQFC88fNSldOXdZAV/+g+bCL5b88Dz+VpWrtA6NTziO
         jV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773594622; x=1774199422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRgTtVCfp33nFF3iOJpPBpviRk62A8CIxOCCKEiDg4M=;
        b=P1Br7oNmi1mrlnE1rSBbv7AbK9XorlPpo77dVIHuhvfkBevPKIrGTrx+r/dLuPFojz
         aBRg3qd48JoMcXgrzyD/d2iM39sXQ82kusKxDgTI3F8941pDN4M1RFIx3u70NrwHwhBx
         y6ggSW6fXYKCPGxbIfkFqC0csSQ8MDaoLA6QY7NPnWaJmPaXh3U//vVflvZQWZger7es
         ncRVwUJzyweyqP1Z52GhUvLLbDAepv3CYgbzaXX902hC9U2e94q3Md912Md/jMkGQIMP
         ajcb7g2ijOsFz5MHsOW0oRwCBGBqXqD71yIcdaaD5D5XVi1Bn9xf3YBOzlar+CaG48hf
         9XQw==
X-Gm-Message-State: AOJu0YxLGNwBmNPaUc6fKIqoHxfJVJhIiMXC3VRBLq/1y62As8bTvCOg
	JvwJ+iSXuVlMHwtTzxMugv4LCyJKPdmiBUvPHZdsAljhYYb5+mUH7wO6
X-Gm-Gg: ATEYQzz8JnThGP0D5FAmCQEwP44lk0pwE0GAh++a2zJ/GnRaW2ubkurzWW8UCDZ6raA
	j4y4qGAujAKhF4jOzNfEhUt2M9Jx5Gq3+PCgnvpkZp1LG6nqcmyVtSPrTuCChPkaSZDeFC7uFbE
	94dlPUYIRUVM6EXBLxn4/15nE76OinbDzu6VwbcVwjCIQxuvIYYr20hd8HWgNDvJZ2OBmc9JI+8
	mxGxXlVKNngXuxwp4rD3MgHbylWBkFciOaYnqoPpgDYE1bFfILmyBmcG63Lld3EtkTq/fyBz33f
	Ly/U0aGZ6toFpHAnDHtGib9JMyBMZEbq1t2l0edi0hRjmG6QQrACwP9R60vNYIqsL9MAlh27HAp
	gdYJ7DVu/zmigJoP3RIdbmsoPxabkCyy6oUNKCjWCZlG/ZHQbb1ngV6kQ3KNOe30+to6L3lxM1e
	k5e7UwKcoJO/sDYPmX0KX1e4Am5GmwVlRmr5QnXdQVyjRyP+t7zS8HOenzMUtPP3iIjenWi6IFI
	Vof4Ayha/ef5N5sbK+uhzJJproi1g==
X-Received: by 2002:a05:600c:4f8b:b0:485:3e6c:aa84 with SMTP id 5b1f17b1804b1-4855670f7d3mr167790935e9.33.1773594622123;
        Sun, 15 Mar 2026 10:10:22 -0700 (PDT)
Received: from DESKTOP-TILNSD1.localdomain ([139.47.104.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5e9179sm354997525e9.3.2026.03.15.10.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 10:10:21 -0700 (PDT)
From: Kit Dallege <xaum.io@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] kexec: add missing kernel-doc parameters for ELF loading functions
Date: Sun, 15 Mar 2026 18:10:11 +0100
Message-ID: <20260315171011.66068-1-xaum.io@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260315_101024_284029_546F7F7A 
X-CRM114-Status: GOOD (  14.71  )
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

Document all missing parameters across 6 functions in kexec_elf.c:
elf_is_ehdr_sane(), elf_is_phdr_sane(), elf_read_phdrs(),
kexec_free_elf_info(), kexec_build_elf_info(), and kexec_elf_load().

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Kit Dallege <xaum.io@gmail.com>
---
 kernel/kexec_elf.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/kexec_elf.c b/kernel/kexec_elf.c
index 3a5c25b2adc9..48f7c0677e87 100644
--- a/kernel/kexec_elf.c
+++ b/kernel/kexec_elf.c
@@ -58,6 +58,7 @@ static uint16_t elf16_to_cpu(const struct elfhdr *ehdr, uint16_t value)
 
 /**
  * elf_is_ehdr_sane - check that it is safe to use the ELF header
+ * @ehdr:	pointer to the ELF header to check.
  * @buf_len:	size of the buffer in which the ELF file is loaded.
  */
 static bool elf_is_ehdr_sane(const struct elfhdr *ehdr, size_t buf_len)
@@ -180,6 +181,7 @@ static int elf_read_ehdr(const char *buf, size_t len, struct elfhdr *ehdr)
 
 /**
  * elf_is_phdr_sane - check that it is safe to use the program header
+ * @phdr:	pointer to the ELF program header to check.
  * @buf_len:	size of the buffer in which the ELF file is loaded.
  */
 static bool elf_is_phdr_sane(const struct elf_phdr *phdr, size_t buf_len)
@@ -244,6 +246,9 @@ static int elf_read_phdr(const char *buf, size_t len,
 
 /**
  * elf_read_phdrs - read the program headers from the buffer
+ * @buf:	buffer to read ELF file from.
+ * @len:	size of @buf.
+ * @elf_info:	pointer to existing struct which will be populated.
  *
  * This function assumes that the program header table was checked for sanity.
  * Use elf_is_ehdr_sane() if it wasn't.
@@ -315,6 +320,7 @@ static int elf_read_from_buffer(const char *buf, size_t len,
 
 /**
  * kexec_free_elf_info - free memory allocated by elf_read_from_buffer
+ * @elf_info:	ELF info struct to free.
  */
 void kexec_free_elf_info(struct kexec_elf_info *elf_info)
 {
@@ -323,6 +329,10 @@ void kexec_free_elf_info(struct kexec_elf_info *elf_info)
 }
 /**
  * kexec_build_elf_info - read ELF executable and check that we can use it
+ * @buf:	buffer to read ELF file from.
+ * @len:	size of @buf.
+ * @ehdr:	pointer to existing struct which will be populated.
+ * @elf_info:	pointer to existing struct which will be populated.
  */
 int kexec_build_elf_info(const char *buf, size_t len, struct elfhdr *ehdr,
 			       struct kexec_elf_info *elf_info)
@@ -379,7 +389,11 @@ int kexec_elf_probe(const char *buf, unsigned long len)
 
 /**
  * kexec_elf_load - load ELF executable image
- * @lowest_load_addr:	On return, will be the address where the first PT_LOAD
+ * @image:		pointer to the kexec image being loaded.
+ * @ehdr:		pointer to the ELF header of the executable.
+ * @elf_info:		pointer to the ELF info struct with program headers.
+ * @kbuf:		pointer to the kexec buffer used for segment loading.
+ * @lowest_load_addr:	on return, will be the address where the first PT_LOAD
  *			section will be loaded in memory.
  *
  * Return:
-- 
2.53.0


