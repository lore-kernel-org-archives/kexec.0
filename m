Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A18E77176
	for <kexec@archiver.kernel.org>; Wed,  4 Dec 2024 12:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QMLpjiP43p31BywTFNffjh3NzCBHssnVGTYWU2BwGcs=; b=0rnmMt6eTmd9K1Qyf5tiBG30PO
	kRCdDUC/raLIdu/eAHDG5fJ+T4PLx5uAcYFn8Ih6llrrP2zZ1I1Nh4QgM7A+h4zsMx7QHyEOIqjzx
	HGGxjlYP4WaAj1FOSWxPsJdR3MoIz5CiZQcD64dBf176ZjhL0M16vv8aG7iUUYjRwTULrqm225UAh
	Bq8eRhGwRXSowCpMOGzUZ/bYpUEgmTSDAwM3HELumxWqrrpLDnWwc9fPjWu5ntYta8bpM+VNMB22T
	sULoKIF75Ycgd3G1bohS/WRf1BXAuMUn2Vtw2G51ue+tSyIghWgpVLKu8q9IQi+on+Uxz6//QlRsv
	83g4WB9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIoxo-0000000Cbq0-112G;
	Wed, 04 Dec 2024 12:58:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIoud-0000000CaHQ-3XqO
	for kexec@lists.infradead.org;
	Wed, 04 Dec 2024 12:55:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733316927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QMLpjiP43p31BywTFNffjh3NzCBHssnVGTYWU2BwGcs=;
	b=HaGf3IlbJ2Adk/Tq/5c69KLVUKaWWX5T2E9knbtsjei6OUKgLBAuWQTcBtqa6bdI5N300B
	A9D1ciSccIg9CZKgLH1M3FsNrCNf1787TymUDqf56oYA0l1gnuj1G+jSm6xO7GeUR+q4rJ
	irpoA3MCINn9MzNGLQQUc+dPJqSh54Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-H1ySCseOMzWzwY4_UbuVmw-1; Wed, 04 Dec 2024 07:55:25 -0500
X-MC-Unique: H1ySCseOMzWzwY4_UbuVmw-1
X-Mimecast-MFC-AGG-ID: H1ySCseOMzWzwY4_UbuVmw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434a37a57dfso55382485e9.0
        for <kexec@lists.infradead.org>; Wed, 04 Dec 2024 04:55:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316924; x=1733921724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMLpjiP43p31BywTFNffjh3NzCBHssnVGTYWU2BwGcs=;
        b=YDAXDAghgTnCxctvF1MjPDFs0gJeEKEc5fdvvLjpFj8z8UlVL3W2TyWve/3HYl73Sl
         Fhi3axV2Bkf+J4qB3mmT2pEirWN76K/vBvQLkPjBKsJRU02ARdMidG1gqAoM08yMpcKO
         kSmwCdNWGh30Y74vahIN/W1a3ej782kGfdC6tvVauSl8WenP/JDmdlcxg8h4IdsjDHmB
         Vu8xZoaGc7LW+HY18WrW3kkHYONSg8ZSo97PRdWQZLGQqiJST2xE9EIhJtrJTID1+KGj
         T5iuSTwYFZjcaBmDPRYb8qDrMnTvhQ7noqNVsWrf2KcZHRopl54C4iek9anN3kQ75CSk
         rAkA==
X-Forwarded-Encrypted: i=1; AJvYcCUMZytRQgFfc1qSBuJj3Ql7ZfjdHvxMhTIhoI5cnBqwFoJRusZk1I+fKhzpQ8XFp5yVpPYwhw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwG6coBA2mINpS4aRqr/3bhOVRh2mx6ko9ACDTuAek8T8npLDAI
	WyfcqcFl7USM/QDjgPKRuGRK3mRsD/MTpLPHSf0MRBje/59cYV4FipTeq0wS+qt6dcK18KSDR9c
	KY8/PtvkzkIPHhHvSRxS75+6chld3lPs1WACPqm2kJZrpD9e56BdMPHlecg==
X-Gm-Gg: ASbGncsWn/pgjTIIi8rSHv43O/dEI0G4RJvqgQVubonl2nPwgAArI/TxVRnmf8UdkDD
	WcI7/OnMnR5g2gev+zKvhfn3XqSUgGBKfXkDMMbVuGJxOUZFbG9EGiFyetUvsH5U6CpCu6brSOx
	dar7MUC5bl0YGYXvCgeCSPCrqWkuBgl3/DwvObMNb6lX9Cb3F5DqzJLCwAyRZCEpjN0gXePB9mE
	C9KtWO6DfMvypY2hYHofvNObA/Zn9Z0GP8abN4xG/db+CnQchecMRdaTTmBndhxBLo/BI4qfkjp
	lOZSCgR66IVci3J8pAtbSqKCFWjgs4B74AM=
X-Received: by 2002:a05:600c:1910:b0:434:a962:2aa2 with SMTP id 5b1f17b1804b1-434d0a178d4mr49286655e9.33.1733316924469;
        Wed, 04 Dec 2024 04:55:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFzA2SYKI5zve6AhLcTcIqYEQR+M/xeFfejA5VMHPdifDyO5ycBtXVIAK8EC4IQe7u0N0Ewg==
X-Received: by 2002:a05:600c:1910:b0:434:a962:2aa2 with SMTP id 5b1f17b1804b1-434d0a178d4mr49286335e9.33.1733316924087;
        Wed, 04 Dec 2024 04:55:24 -0800 (PST)
Received: from localhost (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-434d52c0bc7sm23531055e9.35.2024.12.04.04.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:55:22 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kexec@lists.infradead.org,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 12/12] s390/kdump: virtio-mem kdump support (CONFIG_PROC_VMCORE_DEVICE_RAM)
Date: Wed,  4 Dec 2024 13:54:43 +0100
Message-ID: <20241204125444.1734652-13-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241204125444.1734652-1-david@redhat.com>
References: <20241204125444.1734652-1-david@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hf_MEd3WIprF_iE2EFNHgag67rBEUBVTJOKLBdVydes_1733316924
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241204_045527_953632_6409EE1F 
X-CRM114-Status: GOOD (  15.32  )
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

Let's add support for including virtio-mem device RAM in the crash dump,
setting NEED_PROC_VMCORE_DEVICE_RAM, and implementing
elfcorehdr_fill_device_ram_ptload_elf64().

To avoid code duplication, factor out the code to fill a PT_LOAD entry.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/Kconfig             |  1 +
 arch/s390/kernel/crash_dump.c | 39 ++++++++++++++++++++++++++++-------
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 0077969170e8..c230bad7f5cc 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -240,6 +240,7 @@ config S390
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE	if PCI
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK
+	select NEED_PROC_VMCORE_DEVICE_RAM if PROC_VMCORE
 	select NEED_SG_DMA_LENGTH	if PCI
 	select OLD_SIGACTION
 	select OLD_SIGSUSPEND3
diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index cd0c93a8fb8b..f699df2a2b11 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -508,6 +508,19 @@ static int get_mem_chunk_cnt(void)
 	return cnt;
 }
 
+static void fill_ptload(Elf64_Phdr *phdr, unsigned long paddr,
+		unsigned long vaddr, unsigned long size)
+{
+	phdr->p_type = PT_LOAD;
+	phdr->p_vaddr = vaddr;
+	phdr->p_offset = paddr;
+	phdr->p_paddr = paddr;
+	phdr->p_filesz = size;
+	phdr->p_memsz = size;
+	phdr->p_flags = PF_R | PF_W | PF_X;
+	phdr->p_align = PAGE_SIZE;
+}
+
 /*
  * Initialize ELF loads (new kernel)
  */
@@ -520,14 +533,8 @@ static void loads_init(Elf64_Phdr *phdr, bool os_info_has_vm)
 	if (os_info_has_vm)
 		old_identity_base = os_info_old_value(OS_INFO_IDENTITY_BASE);
 	for_each_physmem_range(idx, &oldmem_type, &start, &end) {
-		phdr->p_type = PT_LOAD;
-		phdr->p_vaddr = old_identity_base + start;
-		phdr->p_offset = start;
-		phdr->p_paddr = start;
-		phdr->p_filesz = end - start;
-		phdr->p_memsz = end - start;
-		phdr->p_flags = PF_R | PF_W | PF_X;
-		phdr->p_align = PAGE_SIZE;
+		fill_ptload(phdr, start, old_identity_base + start,
+			    end - start);
 		phdr++;
 	}
 }
@@ -537,6 +544,22 @@ static bool os_info_has_vm(void)
 	return os_info_old_value(OS_INFO_KASLR_OFFSET);
 }
 
+#ifdef CONFIG_PROC_VMCORE_DEVICE_RAM
+/*
+ * Fill PT_LOAD for a physical memory range owned by a device and detected by
+ * its device driver.
+ */
+void elfcorehdr_fill_device_ram_ptload_elf64(Elf64_Phdr *phdr,
+		unsigned long long paddr, unsigned long long size)
+{
+	unsigned long old_identity_base = 0;
+
+	if (os_info_has_vm())
+		old_identity_base = os_info_old_value(OS_INFO_IDENTITY_BASE);
+	fill_ptload(phdr, paddr, old_identity_base + paddr, size);
+}
+#endif
+
 /*
  * Prepare PT_LOAD type program header for kernel image region
  */
-- 
2.47.1


