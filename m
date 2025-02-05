Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A70CC02192
	for <kexec@archiver.kernel.org>; Wed,  5 Feb 2025 16:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=m9zEItUpZOnlTrWDpqNfuvQizDFcyBJT9ipgz4nC9Sg=; b=QcPWaELHdPLVXF3uFzWhMyeXzK
	gWLr0XiK2arjeLa/xEOepb/Huhuu/Dhgxw7X9Gru99PQoxW0Ay2J9fgtLD2aDkexGLGl8+Kyy4V6n
	zqYWDYKYeK910ZzGaBy9OBmAgBzJ+CxYgX6WNiMYfIb3qwxFcqEZTj/KpsNT9QFrgU2wu8l/5FNoa
	F8EyqNdtWYFRkqMEcOV5YilMUqqo7VuHp5C6iVEiigCxBDrWbVmIwdReDaTOGxRPqZZXk9FdZlovp
	R2G3/wPToZ1BNXdSvl7lbPRO00X+fBNlfXTNMRZsZl19htgHtnJ5prJYt9fUmNo0AtMILmuT7e+l2
	mgfDYL5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tfi61-00000003wVH-2dm8;
	Wed, 05 Feb 2025 16:17:49 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tfhvf-00000003uMx-2oXW
	for kexec@bombadil.infradead.org;
	Wed, 05 Feb 2025 16:07:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=m9zEItUpZOnlTrWDpqNfuvQizDFcyBJT9ipgz4nC9Sg=; b=OkbC9Udv7rGG5wXWFx/ZEx88vY
	bQeTjoKz7A/pbcG/uu2PCmGDTKfMEjkG8IDNilDn8ydw5KtwpdqGVcpqlUsgbjwxR2fv7U8IbBhZm
	AWpZ737LFXpMR3u9p1ipTX4ogs19ouqCKzvuMXV63PiK+vDlpHDoT3SHAh2uz86G4UKr9VQKHNm88
	GwrxZT/JUB7VP52X3Nq0VFIiJ8K8NyDsvAlq+6+ahG87qjf6mIFjfJjC7N3i4GY+h7HVQtamuBkQW
	Sslhz+7+1qQXSd/X6j5dFI2m31oS1cIaja4xQ2s4eBd7XP3oOM1cS8yznHQX/7AkmFG75XvVDqAX/
	hkgk717A==;
Received: from dfw.source.kernel.org ([139.178.84.217])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tfhvc-0000000Ggii-0YVp
	for kexec@lists.infradead.org;
	Wed, 05 Feb 2025 16:07:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E3EC95C4B56;
	Wed,  5 Feb 2025 16:06:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025E6C4CEDD;
	Wed,  5 Feb 2025 16:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738771620;
	bh=fdaBYMhNywx3SBQczSGppmG5pefI/VXyodeBWOMusZI=;
	h=Date:From:To:Cc:Subject:From;
	b=rmJCzdWSdeO/MZyuaGwpd3jRF4Q7jUka+PZeP49a22TpzZIKQBxOWeNTrxRVzF71r
	 V8cJdZ9EWOL1BmPdt2MwvMKLkjtM7JwRiP5Gf9yKXTCLQi/XGNgf/u2TrHWnCZekMs
	 KcnR/4aFUNtySkDVs/QdAPjDdL4eOJD+qPlLcdju2mvIxQZvlapbjwGmQsPKFtP/DT
	 j2CkRdt+yuULeZ7J0auOX45nDI4eIN4QBns9+uFaj5ZTCnVUJ1pc4TPoJEUQqvAxJD
	 mrB4B9L1UmziRtJnfUOKo+FV7ymUCTH4T7WcVd9qGBuOvdhKT6IBEsdMgfbN3AIA3S
	 CTy3ep8u3Pyeg==
Date: Wed, 5 Feb 2025 17:06:56 +0100
From: Helge Deller <deller@kernel.org>
To: Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Sven Schnelle <svens@stackframe.org>, linux-parisc@vger.kernel.org
Subject: [PATCH] kexec_elf: Fix some trivial kerneldoc warnings
Message-ID: <Z6OMoCQridWMs0at@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250205_160704_660065_99D374DF 
X-CRM114-Status: GOOD (  13.44  )
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

Document missing parameters of various functions to avoid warnings
when compiling with W=1.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202502051744.Bjxxm10L-lkp@intel.com/
Cc: Sven Schnelle <svens@stackframe.org>
Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/kernel/kexec_elf.c b/kernel/kexec_elf.c
index d3689632e8b9..f71448ac27c6 100644
--- a/kernel/kexec_elf.c
+++ b/kernel/kexec_elf.c
@@ -58,6 +58,7 @@ static uint16_t elf16_to_cpu(const struct elfhdr *ehdr, uint16_t value)
 
 /**
  * elf_is_ehdr_sane - check that it is safe to use the ELF header
+ * @ehdr:	pointer to ELF header to be checked.
  * @buf_len:	size of the buffer in which the ELF file is loaded.
  */
 static bool elf_is_ehdr_sane(const struct elfhdr *ehdr, size_t buf_len)
@@ -180,7 +181,8 @@ static int elf_read_ehdr(const char *buf, size_t len, struct elfhdr *ehdr)
 
 /**
  * elf_is_phdr_sane - check that it is safe to use the program header
- * @buf_len:	size of the buffer in which the ELF file is loaded.
+ * @phdr:	pointer to elf_phdr struct to be checked
+ * @buf_len:	size of the buffer in which the ELF file was loaded
  */
 static bool elf_is_phdr_sane(const struct elf_phdr *phdr, size_t buf_len)
 {
@@ -244,6 +246,9 @@ static int elf_read_phdr(const char *buf, size_t len,
 
 /**
  * elf_read_phdrs - read the program headers from the buffer
+ * @buf:	buffer to read ELF file from
+ * @len:	size of @buf
+ * @elf_info:	pointer to existing kexec_elf_info struct which will be populated
  *
  * This function assumes that the program header table was checked for sanity.
  * Use elf_is_ehdr_sane() if it wasn't.
@@ -280,10 +285,10 @@ static int elf_read_phdrs(const char *buf, size_t len,
 
 /**
  * elf_read_from_buffer - read ELF file and sets up ELF header and ELF info
- * @buf:	Buffer to read ELF file from.
- * @len:	Size of @buf.
- * @ehdr:	Pointer to existing struct which will be populated.
- * @elf_info:	Pointer to existing struct which will be populated.
+ * @buf:	buffer to read ELF file from
+ * @len:	size of @buf
+ * @ehdr:	pointer to existing elfhdr struct which will be populated
+ * @elf_info:	pointer to existing kexec_elf_info struct which will be populated
  *
  * This function allows reading ELF files with different byte order than
  * the kernel, byte-swapping the fields as needed.
@@ -315,6 +320,8 @@ static int elf_read_from_buffer(const char *buf, size_t len,
 
 /**
  * kexec_free_elf_info - free memory allocated by elf_read_from_buffer
+ * @elf_info:	pointer to existing kexec_elf_info struct which will be freed
+ *		and zeroed.
  */
 void kexec_free_elf_info(struct kexec_elf_info *elf_info)
 {
@@ -322,7 +329,15 @@ void kexec_free_elf_info(struct kexec_elf_info *elf_info)
 	memset(elf_info, 0, sizeof(*elf_info));
 }
 /**
- * kexec_build_elf_info - read ELF executable and check that we can use it
+ * kexec_build_elf_info - read ELF executable headers from buffer and
+ *		check that we can use them
+ * @buf:	buffer to read ELF file from
+ * @len:	size of @buf
+ * @ehdr:	pointer to existing elfhdr struct which will be populated
+ * @elf_info:	pointer to existing kexec_elf_info struct which will be populated
+ *
+ * Return:
+ * 0 on success, negative value on failure.
  */
 int kexec_build_elf_info(const char *buf, size_t len, struct elfhdr *ehdr,
 			       struct kexec_elf_info *elf_info)
@@ -378,9 +393,15 @@ int kexec_elf_probe(const char *buf, unsigned long len)
 }
 
 /**
- * kexec_elf_load - load ELF executable image
- * @lowest_load_addr:	On return, will be the address where the first PT_LOAD
- *			section will be loaded in memory.
+ * kexec_elf_load - load an ELF executable image
+ * @image:		pointer to kimage struct of file to be loaded
+ * @ehdr:		pointer to the ELF header of file to be loaded
+ * @elf_info:		pointer to kexec_elf_info struct of file to be loaded
+ * @kbuf:		pointer to kexec_buf struct which will be used to
+ *			load the ELF file
+ * @lowest_load_addr:	when the kernel was successfully loaded, the address
+ *			where the first PT_LOAD section was loaded is stored
+ *			in the variable pointed to by this pointer
  *
  * Return:
  * 0 on success, negative value on failure.

