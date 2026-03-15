Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C812FF3026E
	for <kexec@archiver.kernel.org>; Sun, 15 Mar 2026 15:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tgkBw5OnojBrxNHN+m3w323m1e8OxqpyisbSdD+yjCM=; b=DykpGMBGP0QqP1UgVtHNloxoaL
	aq7vyMxAudtWFVgIzo4s60EEhKbhpNvpE7SISxfG4ANrJz1YrzuUbRrdnksfOr5VNgwqZ2ZYpkt1w
	NuzHAP49WDh5YEZffwna88tAMwiYQE5+eX8yTHXI58NeKMlAe2sQxqB3XMOvxqE36eylJ/IW8OCZX
	fewkLJLfxqttlngRV5tZELVMFB3b7zPJxex76AeBvLMACcQ+GNC5gAjkXTqxnW7Iq4nvA4ceTJFHc
	5O0To58fnSyaOyT5DE4c861D7UI0hrcS+EHxWb371BLaHYcd1327ShWHImPK4tw6bJTJtncxkCObw
	vPSRjXaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w1nXt-00000002hH8-0bxn;
	Sun, 15 Mar 2026 15:38:25 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w1nXp-00000002hGl-226b
	for kexec@lists.infradead.org;
	Sun, 15 Mar 2026 15:38:23 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4853f2826f7so40226845e9.1
        for <kexec@lists.infradead.org>; Sun, 15 Mar 2026 08:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773589099; x=1774193899; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tgkBw5OnojBrxNHN+m3w323m1e8OxqpyisbSdD+yjCM=;
        b=Zh8v/KMLYr4AIireQ5vYvmELQqcvB5dsVxskeuEQM7p0j5Wwwymsoh2epsV6gv3LQa
         oAYthn/svKtVVbalzRf67uNp4xeggHRT9Uwy2t3pyJL7efw+vf3OuFwT4U/6lr3UDtWd
         ARa0hyUZaHIIIWVNdrkOJxB2teZtTNpApp2W57oiJBGiAqMHpwB5mvo76uQ429vHVeJd
         V/Pwcn45amjNSV2bsRuF1BsrPj8/FE1b1OmFq0z36ScXUt8W2dQ71YSyxUCqLmQ0/65b
         zfrffUslMMhkzGQUoW2PaFQtt6kGkaVOxh4k0y+pOos2ZQDvnjQu69bttWiDH7N5nNI3
         Vdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773589099; x=1774193899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgkBw5OnojBrxNHN+m3w323m1e8OxqpyisbSdD+yjCM=;
        b=D6V8JGENFmDOEQDzLrhA6fancEcuA/Jo8hiLUJxOpuKkCQs4l9AvLcVNitY09sD6kX
         h01x816nD23iTrj6YtRexSmZZ1+4n08vej9k+6IbFZV7/D0Y/yEkTD/ILvaa8IrcwrS+
         tdwX9lBS89GIeMPdp6mk7P8Ne5H8wwmBA5tYcaycSiqCIZZs7IvmN+2H/EOmBGz0sxdf
         Qp/eiJ4lyzy/zW9aqiZX0n5AKAdeuHYhzPE+FUsONZ1lRxLaRMXQelpPF9Utvx76AhsI
         qqyr6xDuP6bQq0LaFv2FBsfHXbBfKiPkORRn9fRO+NGN65Uevo0z4LUnp7eZAOV4Eey4
         cbFw==
X-Gm-Message-State: AOJu0YzWMEj26zY03N4E2vhImVgGWmt/QwphyPzgIgq5JwG9AQQN/IeF
	XHqeT+WW/Adf1TMy0APS3vzCoT2GSXafpjvDjFoIfT8vwZTqorskPkh7oRGiydiyLAE=
X-Gm-Gg: ATEYQzzD0CDTsbxr9098j6iN8oJChnmUW4CHYsOdip4zYqLvpxt1BSb7tLlOq0oFkI5
	FluA6xMDyVjUd3un3KObPbVIb5rzCdJKpxUyM9X8Igfv+Etyz3xHOypoj+dVcz6Ger3gD2CflBJ
	U41+U7m4SBHS973T6zvbAy8U6AdpI3PK9TXZcGg+1Y1z/nEeFZHvlLEkvOeXKGC2YvW3LxTm+kE
	zQZa+5UbaimybkLV2OCp294ZMgH8PJfSLC2iReH2Vj23ZxvMm0A4y0mK0GIgYgcZjvx3aX3yOvd
	Ch2AeiZ5AehxssgZWTc5ubDyAyzEYfkIpLM/D9WXTpZrnvA9cgEEqIeOd/kuJpDK5tiRUbxq55V
	X55XJS/ccj6BE5aut8kuo6a4tXmwQreFCofreTQs8J3fdBGlMJJt1UynPlgHcpxn+YjK3y0Nuh7
	05u4kqZkuCcU41LzCIMYkahIFdFKVR7Wjt5e6lI9x3YFKxpySisfBRqvPHXPldZKBr7HNltlU3j
	8adV79ZXnSDUst0tku30ky5jtKpKA==
X-Received: by 2002:a05:600d:6445:10b0:485:35a4:939c with SMTP id 5b1f17b1804b1-4855670c0f4mr119960285e9.29.1773589098938;
        Sun, 15 Mar 2026 08:38:18 -0700 (PDT)
Received: from DESKTOP-TILNSD1.localdomain ([139.47.104.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48557c6e2b1sm68018115e9.28.2026.03.15.08.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 08:38:18 -0700 (PDT)
From: Kit Dallege <xaum.io@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kit Dallege <xaum.io@gmail.com>,
	Claude <noreply@anthropic.com>
Subject: [PATCH] kexec: add missing kernel-doc parameters for ELF loading functions
Date: Sun, 15 Mar 2026 16:38:08 +0100
Message-ID: <20260315153808.49218-1-xaum.io@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260315_083821_562755_EC53A27C 
X-CRM114-Status: GOOD (  13.98  )
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

Assisted-by: Claude <noreply@anthropic.com>
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


