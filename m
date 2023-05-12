Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 832CDC7EE22
	for <kexec@archiver.kernel.org>; Fri, 12 May 2023 02:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	Mime-Version:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=CkTenjqGmcRz3jJtuYq5FO7ay+CBSgtiCEK4MHiLKII=; b=1+C
	8BcomdDWSTX6CWFK9ODF7boLbMH1X5QtU58QB2Mc09FdbHbloka5GcEBmibQh+CAPkAlx9x++fwOm
	Rivg8N1a2MAMhPNHj2Eegl1Ko+iq2IAnjwBFPXaG+LNFJUO12i8qJquXIoub8unX8ae4hm32yjYkt
	wJVT4VTs2joF4rVa5sUY9JJpMwkx3gvFZfegCWhL7P8bTdmrVb3UpQ2syUcUXYuzzTF8KbamvjrQc
	ik9vNth9uQCJ3rqitj+zL8OfeHL6qGppvPeZDvLdKMnNfQCIhSyd/I7Yd/159dyyax6cbRG3ABqr2
	VZocaG/on2ljx1j2azOl/+3lRlh628g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxITd-00Aj6s-2l;
	Fri, 12 May 2023 02:25:49 +0000
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxITa-00Aj47-2O
	for kexec@lists.infradead.org;
	Fri, 12 May 2023 02:25:48 +0000
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba6939e78a0so10147741276.0
        for <kexec@lists.infradead.org>; Thu, 11 May 2023 19:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683858336; x=1686450336;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dVrdsQc/biAwpt188V4iZWfS19eaXCE07QPOY9kbdyc=;
        b=GQ8UVH9IygDETvgeENJQeoTFRl8IK6C71cn0eEf8SRe+fcNkVbogqZTEV5spZj3AYl
         QZY1fCTKrPPA3LJqQI2S73wLreGYzUHXWf6jF0T3V0Qu2J4n42ehYtbxn6HfNim8BzQ1
         XB9T4j5TtAct937a1GogPDZ/VyvmPySCrq9ascVSC6HrVysL7S+Dup0RfS+TdHzyffYu
         +BWPKv5kR//I9uGLkkmM1C3DClzHSfgrHLothXTbfzQ5CPksh3m7s891AsCXvqTXm/Y2
         A1ieQSQhQR+UsriiFUS5QNIen/0Zzln7A3aNqNaK8dDOFZlLywHR3jGaZiAOcllmGMaW
         5X+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683858336; x=1686450336;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dVrdsQc/biAwpt188V4iZWfS19eaXCE07QPOY9kbdyc=;
        b=WA27iLhpE0MhyiLbOjlGfwBtra4y0NR2Iad1/i9jRVtD4uukmF0f/K2L7ELFiZ3ZLT
         6/7+6aWFHpFFlr+g4i9uYDeqviXpvrd329Fn882MM4mac96LFnuDAikKqWaK55XlFwSV
         uEQ/mm7/D+ZWkatiBxERAk6KmYQT0odV+2paMyQsw1nXfv+uhD1p9Tah4wwQ9CUv0+l3
         +/yvGUi2JlVq0e0qngkHHWf8uNCWV8x25aOI/q1dRxMBsxLvxJcOJfSlrH9m1AO33Pvt
         mO22Gyj9zqufrVdMMf3Gvj4nUlTRoHv0QDOXWPiGLLqr+4EIP4EalCpP0kD9bMvlVpI4
         LUZg==
X-Gm-Message-State: AC+VfDw9OafbqpguHonh0QHTdPrkurJromHD+G5aOTnezZbeECWHzJY9
	rvLPAF/RI7gpNJpQtH9P4SuTmxUBxFKu
X-Google-Smtp-Source: ACHHUZ6PjgAnQ4yHVTWsepQlN0qPo9uDN+LDYTHYcGjsv2wb8UltmdJTc0fhG08ccIWbq0MSRLcoxeq80x19
X-Received: from meowing-l.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3eba])
 (user=maskray job=sendgmr) by 2002:a05:690c:10c:b0:55c:a5db:869 with SMTP id
 bd12-20020a05690c010c00b0055ca5db0869mr19325168ywb.4.1683858336753; Thu, 11
 May 2023 19:25:36 -0700 (PDT)
Date: Fri, 12 May 2023 02:25:28 +0000
Mime-Version: 1.0
Message-ID: <20230512022528.3430327-1-maskray@google.com>
Subject: [PATCH] coredump, vmcore: Set p_align to 4 for PT_NOTE
From: Fangrui Song <maskray@google.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>, 
	Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, 
	linux-fsdevel@vger.kernel.org, kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Fangrui Song <maskray@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230511_192546_780135_87FABBFA 
X-CRM114-Status: GOOD (  13.06  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Tools like readelf/llvm-readelf use p_align to parse a PT_NOTE program
header as an array of 4-byte entries or 8-byte entries. Currently, there
are workarounds[1] in place for Linux to treat p_align==0 as 4. However,
it would be more appropriate to set the correct alignment so that tools
do not have to rely on guesswork. FreeBSD coredumps set p_align to 4 as
well.

[1]: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=82ed9683ec099d8205dc499ac84febc975235af6
[2]: https://reviews.llvm.org/D150022
---
 fs/binfmt_elf.c       | 2 +-
 fs/binfmt_elf_fdpic.c | 2 +-
 fs/proc/vmcore.c      | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 1033fbdfdbec..44b4c42ab8e8 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1517,7 +1517,7 @@ static void fill_elf_note_phdr(struct elf_phdr *phdr, int sz, loff_t offset)
 	phdr->p_filesz = sz;
 	phdr->p_memsz = 0;
 	phdr->p_flags = 0;
-	phdr->p_align = 0;
+	phdr->p_align = 4;
 }
 
 static void fill_note(struct memelfnote *note, const char *name, int type,
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 05a1471d5283..d76ad3d4f676 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1269,7 +1269,7 @@ static inline void fill_elf_note_phdr(struct elf_phdr *phdr, int sz, loff_t offs
 	phdr->p_filesz = sz;
 	phdr->p_memsz = 0;
 	phdr->p_flags = 0;
-	phdr->p_align = 0;
+	phdr->p_align = 4;
 	return;
 }
 
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 03f5963914a1..cb80a7703d58 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -877,7 +877,7 @@ static int __init merge_note_headers_elf64(char *elfptr, size_t *elfsz,
 	phdr.p_offset  = roundup(note_off, PAGE_SIZE);
 	phdr.p_vaddr   = phdr.p_paddr = 0;
 	phdr.p_filesz  = phdr.p_memsz = phdr_sz;
-	phdr.p_align   = 0;
+	phdr.p_align   = 4;
 
 	/* Add merged PT_NOTE program header*/
 	tmp = elfptr + sizeof(Elf64_Ehdr);
@@ -1068,7 +1068,7 @@ static int __init merge_note_headers_elf32(char *elfptr, size_t *elfsz,
 	phdr.p_offset  = roundup(note_off, PAGE_SIZE);
 	phdr.p_vaddr   = phdr.p_paddr = 0;
 	phdr.p_filesz  = phdr.p_memsz = phdr_sz;
-	phdr.p_align   = 0;
+	phdr.p_align   = 4;
 
 	/* Add merged PT_NOTE program header*/
 	tmp = elfptr + sizeof(Elf32_Ehdr);
-- 
2.40.1.606.ga4b1b128d6-goog


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
