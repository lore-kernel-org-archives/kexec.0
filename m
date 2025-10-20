Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88601CCD19F
	for <kexec@archiver.kernel.org>; Mon, 20 Oct 2025 22:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yx6+i/WS6c7p8CvWZ9absyc9GuZXU0PHZ9/0avBhiZI=; b=LHuIqXtqgv4xRMPEA7SbPDjp9v
	lYUlFdN3KUj1xzpGCtArdNd/Bx1pivElPUjMQ+U6gDV5eymmOO5HNk8cEPJKXtt17H/kuW1V4wbxD
	5qGnFA9297kTfvh8oAQo0T7IDZXQjtym8iuSPJa892TZRYEnYXhHkmji0sl5QwAJakVmy0pUU5pDl
	gF8PGycyxyr8y9GOos/G0hk/GfgMq23/IXU/fKzGVParRDfUGrQktT+w12rw3/wNFgZUpOEJY2Op5
	oxEmIECrXsKflpnr1nBTX4RD3NhbXQZELm5zFG9mBcdLtMD8GME431aOaSojMwWp2KUwogOSPpusu
	COXnzKkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAyMp-0000000FBeW-3NG3;
	Mon, 20 Oct 2025 22:28:39 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAyMo-0000000FBe0-2pqv
	for kexec@bombadil.infradead.org;
	Mon, 20 Oct 2025 22:28:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=content-type:Content-Transfer-Encoding
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Yx6+i/WS6c7p8CvWZ9absyc9GuZXU0PHZ9/0avBhiZI=; b=H0qwbGBExMqQguNGzOj3hDuDkU
	e+3wkduxb3xEo7Y0H70/EbJID+PNVMtTAL+CyVq4u5XkaZCjXxNhaEOxNRVFLByA77WsTcHicyOrq
	gAUPGOiIOYzT+6D7jPvfqJdeHzwGP92AO7V4adyFtINX+UGWvOgKEKDc6yB8T3QyIjkLfslNp/evV
	0r08WoU2o5WqfwBoKiPN8V3pSdeF9oflrPQ3DrOaMj9KIYCWVzk5BvhYN9J77pKfX6VEbp52uVlVL
	GdmPriU17Ej5Mmrsr3ixVsC1nxsfT28BKyQSNkh/N4VR1F/8cnFnJgSFVyX/O+9ZxJqJ7ge7xuMuM
	H3Vw4R0g==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAxTt-00000000Ikk-3xFF
	for kexec@lists.infradead.org;
	Mon, 20 Oct 2025 21:32:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760999221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yx6+i/WS6c7p8CvWZ9absyc9GuZXU0PHZ9/0avBhiZI=;
	b=HRM4vhnzR+DAb/vmH9MPk+9lwvvxCdD9p2c8/7Uayip8y6caQfMr1EKQhhg7KK4WrPhD3o
	9/LmEhe/WwB9TooqohqKbTdoiTxSW7kfKaEUoBpa2Mkr7sLalZOjwiTxfs8unN/+7UGy8L
	ztd/382WAaeBTSR/BBX4ifF0FszaMOw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760999222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yx6+i/WS6c7p8CvWZ9absyc9GuZXU0PHZ9/0avBhiZI=;
	b=C6RQ6LWQEnfRg2YpSr6Pho2w0ZmmNv/cvgQdBc0R6x8pkdrl2ied6YwBQhAVGyGYK3ydly
	oFJElgEZdsDwjoHazJMSmc7ICFtJnCCsaQtfE9K8w2/NMnvbuJ326fm2jdyZ3odiWGTuBv
	ADCQQDS99m0nGWZM6pABhKC4YEiCRBQ=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-JDHIFsMoOJentw1O8QtP6Q-1; Mon, 20 Oct 2025 18:24:45 -0400
X-MC-Unique: JDHIFsMoOJentw1O8QtP6Q-1
X-Mimecast-MFC-AGG-ID: JDHIFsMoOJentw1O8QtP6Q_1760999084
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-780fb254938so4059264b3a.0
        for <kexec@lists.infradead.org>; Mon, 20 Oct 2025 15:24:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760999084; x=1761603884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yx6+i/WS6c7p8CvWZ9absyc9GuZXU0PHZ9/0avBhiZI=;
        b=i9eZbxVXxjuw41oZhU6Xfw6zmIS958JEjs4iPlQz0AqdlpwzeKL2jSbU/tztZzjBO6
         YXBwQwcorSD9dWOUAzx5Px4AKdzLr/T7NHNG+9xlpJ58uikJc6rK02vOvqTe+Ygu4C+k
         56cYBbU7kEkW1AizAei0oUzvFdxHyqOjkMtihxQVhV46tFPF0/wc0Jz1oEMP4eKOxMi7
         zOfo/epqp4vW75DPyKJHOY1t6o2w4Cqqy0wDwffVHaDdWHJf1oD9KJNfyBQhMHZ3QdMT
         /+V45Ny55nAeATX0eyighSICR8CzB7/yTDZam7d33k4ybhKbObSxHlp5d8idfx8oYw0R
         8YQg==
X-Forwarded-Encrypted: i=1; AJvYcCWu0ACz0F0hQiVKMXrDs5phBK+22XhcD7Vhq6nOyDkNA0eQKz0M3nlcwLzzkEDGPVIelKgRTA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxyOslaTUtdyU3fybETEDu7hjqGowiOIvYHDN9AktkgWEnVdFCi
	GtqolGoBuwu27nYg9a5cptKHvZLOkwOROuEnnMTr2kcHRc6yvo1+Ow2SE0ud6uBrF8246aHLhbA
	X2X9dT3a0hsHkjs5SKYTG9pCGjr01kByL2eJbHlZP30uoTZkcJB+xhpo6g6R8jQ==
X-Gm-Gg: ASbGnct03NU+LD7rtmddYZgeSfz1nADU4d+yol5JnxFhV4JBCk0UJ3f82cjqj1LUszv
	bo+oftVsiDtY279zhdIQy39jd0Biu58RuUKhGoZwXTpEuQdHlK9RakTBbF+Zam/4aYBlPlR0Zef
	aQ1TeduVMUstfeSWealJ2id5tgcGAMjADQopuXpddyfNu8t07BN2zY0nEHaxod5njBRhsURRF4m
	s7zlG7O4vG0DGpyICmk9fOiV7dzEj8MiFXWBewBW5R6Rr3OooL3RkdlLt54HCi52RyBJEL9mncE
	MqH4XJdREv7nBF7bbt+CV92AHbMPriEV9Y0XDGaaaY7qs9784CodT1AMTXi02eeu1zMTodi5CnO
	y5ZhheByeCtDMDx8jHLj1LfD5KD4O3z4vGbze6vkv5V8=
X-Received: by 2002:a05:6a00:a8f:b0:792:574d:b2c with SMTP id d2e1a72fcca58-7a220acbcabmr20940158b3a.15.1760999083970;
        Mon, 20 Oct 2025 15:24:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEN7KfBUY3hcYFPaWw1BEZ2irgDJsMO28AfLPINnrktmI+YJEt9a682TK0XWt75Nyf3SzPaXQ==
X-Received: by 2002:a05:6a00:a8f:b0:792:574d:b2c with SMTP id d2e1a72fcca58-7a220acbcabmr20940137b3a.15.1760999083570;
        Mon, 20 Oct 2025 15:24:43 -0700 (PDT)
Received: from localhost.localdomain (115-189-93-209.mobile.spark.co.nz. [115.189.93.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010e265sm9229263b3a.52.2025.10.20.15.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 15:24:43 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v2][makedumpfile 07/14] Implement kernel kallsyms resolving
Date: Tue, 21 Oct 2025 11:24:03 +1300
Message-ID: <20251020222410.8235-8-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20251020222410.8235-1-ltao@redhat.com>
References: <20251020222410.8235-1-ltao@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6GiBiBk53sbnw_GmFkT1OHQEQYYGKr-aVlkr5n2mbAM_1760999084
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251020_223217_276171_46824B33 
X-CRM114-Status: GOOD (  26.36  )
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

This patch will parse kernel's kallsyms data, and store them into a hash
table so they can be referenced later in a fast speed.

Signed-off-by: Tao Liu <ltao@redhat.com>
---
 Makefile       |   2 +-
 kallsyms.c     | 266 +++++++++++++++++++++++++++++++++++++++++++++++++
 kallsyms.h     |  22 ++++
 makedumpfile.c |   3 +
 makedumpfile.h |  11 ++
 5 files changed, 303 insertions(+), 1 deletion(-)
 create mode 100644 kallsyms.c
 create mode 100644 kallsyms.h

diff --git a/Makefile b/Makefile
index 18d3a17..2bb17f9 100644
--- a/Makefile
+++ b/Makefile
@@ -45,7 +45,7 @@ CFLAGS_ARCH += -m32
 endif
 
 SRC_BASE = makedumpfile.c makedumpfile.h diskdump_mod.h sadump_mod.h sadump_info.h
-SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c sadump_info.c cache.c tools.c printk.c detect_cycle.c
+SRC_PART = print_info.c dwarf_info.c elf_info.c erase_info.c sadump_info.c cache.c tools.c printk.c detect_cycle.c kallsyms.c
 OBJ_PART=$(patsubst %.c,%.o,$(SRC_PART))
 SRC_ARCH = arch/arm.c arch/arm64.c arch/x86.c arch/x86_64.c arch/ia64.c arch/ppc64.c arch/s390x.c arch/ppc.c arch/sparc64.c arch/mips64.c arch/loongarch64.c arch/riscv64.c
 OBJ_ARCH=$(patsubst %.c,%.o,$(SRC_ARCH))
diff --git a/kallsyms.c b/kallsyms.c
new file mode 100644
index 0000000..116f857
--- /dev/null
+++ b/kallsyms.c
@@ -0,0 +1,266 @@
+#include <stdint.h>
+#include <stdbool.h>
+#include <string.h>
+#include <assert.h>
+#include "makedumpfile.h"
+#include "kallsyms.h"
+
+static uint32_t *kallsyms_offsets = NULL;
+static uint16_t *kallsyms_token_index = NULL;
+static uint8_t  *kallsyms_token_table = NULL;
+static uint8_t  *kallsyms_names = NULL;
+static unsigned long kallsyms_relative_base = 0;
+static unsigned int kallsyms_num_syms = 0;
+
+#define NAME_HASH 512
+static struct syment *symtable = NULL;
+static struct syment *name_hash_table[NAME_HASH] = {0};
+
+static uint64_t absolute_percpu(uint64_t base, int32_t val)
+{
+	if (val >= 0)
+		return (uint64_t)val;
+	else
+		return base - 1 - val;
+}
+
+static void *get_syment_next(void *entry)
+{
+	return ((struct syment *)entry)->name_hash_next;
+}
+
+static void set_syment_next(void *entry, void *next)
+{
+	((struct syment *)entry)->name_hash_next = next;
+}
+
+static unsigned int name_hash_index(char *name)
+{
+	return hash_index(name, NAME_HASH);
+}
+
+static void name_hash_install(struct syment *en)
+{
+	hash_install((void **)name_hash_table, NAME_HASH, en, en->name,
+		     get_syment_next, set_syment_next);
+}
+
+struct syment *search_kallsyms_by_name(char *name)
+{
+	unsigned int index;
+	struct syment *sp;
+
+	index = name_hash_index(name);
+	for (sp = name_hash_table[index]; sp; sp = sp->name_hash_next) {
+		if (!strcmp(name, sp->name)) {
+			return sp;
+		}
+	}
+	return sp;	
+}
+
+uint64_t get_kallsyms_value_by_name(char *name)
+{
+	struct syment *sp;
+
+	sp = search_kallsyms_by_name(name);
+	if (!sp)
+		return 0;
+	return sp->value;
+}
+
+#define BUFLEN 1024
+int parse_kernel_kallsyms(void)
+{
+	char buf[BUFLEN];
+	int index = 0, i;
+	uint8_t *compressd_data;
+	uint8_t *uncompressd_data;
+	uint64_t stext;
+	uint8_t len, len_old;
+
+	symtable = calloc(kallsyms_num_syms, sizeof(struct syment));
+	if (!symtable)
+		goto no_mem;
+
+	for (i = 0; i < kallsyms_num_syms; i++) {
+		memset(buf, 0, BUFLEN);
+		len = kallsyms_names[index];
+		if (len & 0x80) {
+			index++;
+			len_old = len;
+			len = kallsyms_names[index];
+			if (len & 0x80) {
+				fprintf(stderr, "%s: BUG! Unexpected 3-byte length,"
+					" should be detected in init_kernel_kallsyms()\n",
+					__func__);
+				goto out;
+			}
+			len = (len_old & 0x7F) | (len << 7);
+		}
+		index++;
+
+		compressd_data = &kallsyms_names[index];
+		index += len;
+		while (len--) {
+			uncompressd_data = &kallsyms_token_table[kallsyms_token_index[*compressd_data]];
+			assert(strlen(buf) + strlen((char *)uncompressd_data) < BUFLEN);
+			strcat(buf, (char *)uncompressd_data);
+			compressd_data++;
+		}
+		symtable[i].value = kallsyms_offsets[i];
+		symtable[i].type = buf[0];
+		symtable[i].name = strdup(&buf[1]);
+		if (!symtable[i].name)
+			goto no_mem;
+		name_hash_install(&symtable[i]);
+	}
+
+	/* Now refresh the absolute each kallsyms address */
+	stext = get_kallsyms_value_by_name("_stext");
+	if (SYMBOL(_stext) == absolute_percpu(kallsyms_relative_base, stext)) {
+		for (i = 0; i < kallsyms_num_syms; i++) {
+			symtable[i].value = absolute_percpu(kallsyms_relative_base,
+							symtable[i].value);
+		}
+	} else if (SYMBOL(_stext) == kallsyms_relative_base + stext) {
+		for (i = 0; i < kallsyms_num_syms; i++) {
+			symtable[i].value += kallsyms_relative_base;
+		}
+	} else {
+		fprintf(stderr, "%s: Wrong calculate kallsyms symbol value!\n", __func__);
+		goto out;
+	}
+
+	return 0;
+no_mem:
+	fprintf(stderr, "%s: Not enough memory!\n", __func__);
+out:
+	return -1;
+}
+
+static bool vmcore_info_ready = false;
+
+int read_vmcoreinfo_kallsyms(void)
+{
+	READ_SYMBOL("kallsyms_names", kallsyms_names);
+	READ_SYMBOL("kallsyms_num_syms", kallsyms_num_syms);
+	READ_SYMBOL("kallsyms_token_table", kallsyms_token_table);
+	READ_SYMBOL("kallsyms_token_index", kallsyms_token_index);
+	READ_SYMBOL("kallsyms_offsets", kallsyms_offsets);
+	READ_SYMBOL("kallsyms_relative_base", kallsyms_relative_base);
+	vmcore_info_ready = true;
+	return true;	
+}
+
+int init_kernel_kallsyms(void)
+{
+	const int token_index_size = (UINT8_MAX + 1) * sizeof(uint16_t);
+	uint64_t last_token, len;
+	unsigned char data, data_old;
+	int i;
+	int ret = -1;
+
+	if (vmcore_info_ready == false) {
+		fprintf(stderr, "%s: vmcoreinfo not ready for kallsyms!\n",
+			__func__);
+		return ret;
+	}
+
+	readmem(VADDR, SYMBOL(kallsyms_num_syms), &kallsyms_num_syms,
+		sizeof(kallsyms_num_syms));
+	readmem(VADDR, SYMBOL(kallsyms_relative_base), &kallsyms_relative_base,
+		sizeof(kallsyms_relative_base));	
+
+	kallsyms_offsets = malloc(sizeof(uint32_t) * kallsyms_num_syms);
+	if (!kallsyms_offsets)
+		goto no_mem;
+	readmem(VADDR, SYMBOL(kallsyms_offsets), kallsyms_offsets,
+		kallsyms_num_syms * sizeof(uint32_t));
+
+	kallsyms_token_index = malloc(token_index_size);
+	if (!kallsyms_token_index)
+		goto no_mem;
+	readmem(VADDR, SYMBOL(kallsyms_token_index), kallsyms_token_index,
+		token_index_size);	
+
+	last_token = SYMBOL(kallsyms_token_table) + kallsyms_token_index[UINT8_MAX];
+	do {
+		readmem(VADDR, last_token++, &data, 1);
+	} while(data);
+	len = last_token - SYMBOL(kallsyms_token_table);
+	kallsyms_token_table = malloc(len);
+	if (!kallsyms_token_table)
+		goto no_mem;
+	readmem(VADDR, SYMBOL(kallsyms_token_table), kallsyms_token_table, len);
+	
+	for (len = 0, i = 0; i < kallsyms_num_syms; i++) {
+		readmem(VADDR, SYMBOL(kallsyms_names) + len, &data, 1);
+		if (data & 0x80) {
+			len += 1;
+			data_old = data;
+			readmem(VADDR, SYMBOL(kallsyms_names) + len, &data, 1);
+			if (data & 0x80) {
+				fprintf(stderr, "%s: BUG! Unexpected 3-byte length"
+					" encoding in kallsyms names\n", __func__);
+				goto out;
+			}
+			data = (data_old & 0x7F) | (data << 7);
+		}
+		len += data + 1;
+	}
+	kallsyms_names = malloc(len);
+	if (!kallsyms_names)
+		goto no_mem;
+	readmem(VADDR, SYMBOL(kallsyms_names), kallsyms_names, len);
+
+	ret = parse_kernel_kallsyms();
+	goto out;
+
+no_mem:
+	fprintf(stderr, "%s: Not enough memory!\n", __func__);
+out:
+	if (kallsyms_offsets)
+		free(kallsyms_offsets);
+	if (kallsyms_token_index)
+		free(kallsyms_token_index);
+	if (kallsyms_token_table)
+		free(kallsyms_token_table);
+	if (kallsyms_names)
+		free(kallsyms_names);	
+	return ret;
+}
+
+/* Hash table utils */
+unsigned int hash_index(const char *name, unsigned int hash_size)
+{
+	unsigned int len, value;
+
+	len = strlen(name);
+	value = name[len - 1] * name[len / 2];
+
+	return (name[0] ^ value) % hash_size;
+}
+
+void hash_install(void **hash_table, unsigned int hash_size,
+		  void *entry, const char *name,
+		  void *(*get_next)(void *),
+		  void (*set_next)(void *, void *))
+{
+	unsigned int index = hash_index(name, hash_size);
+	void *sp = hash_table[index];
+
+	assert(index < hash_size);
+	if (sp == NULL) {
+		hash_table[index] = entry;
+	} else {
+		while (sp) {
+			if (get_next(sp)) {
+				sp = get_next(sp);
+			} else {
+				set_next(sp, entry);
+				break;
+			}
+		}
+	}
+}
\ No newline at end of file
diff --git a/kallsyms.h b/kallsyms.h
new file mode 100644
index 0000000..35bf89e
--- /dev/null
+++ b/kallsyms.h
@@ -0,0 +1,22 @@
+#ifndef _KALLSYMS_H
+#define _KALLSYMS_H
+
+#include <stdint.h>
+
+struct syment {
+	uint64_t value;
+	char *name;
+	struct syment *name_hash_next;
+	char type;
+};
+
+int init_kernel_kallsyms(void);
+int read_vmcoreinfo_kallsyms(void);
+struct syment *search_kallsyms_by_name(char *);
+uint64_t get_kallsyms_value_by_name(char *);
+
+unsigned int hash_index(const char *, unsigned int);
+void hash_install(void **, unsigned int, void *, const char *,
+		void *(*)(void *), void (*)(void *, void *));
+
+#endif /* _KALLSYMS_H */
\ No newline at end of file
diff --git a/makedumpfile.c b/makedumpfile.c
index 33fad32..cdfcfeb 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -27,6 +27,7 @@
 #include <limits.h>
 #include <assert.h>
 #include <zlib.h>
+#include "kallsyms.h"
 
 struct symbol_table	symbol_table;
 struct size_table	size_table;
@@ -3103,6 +3104,8 @@ read_vmcoreinfo_from_vmcore(off_t offset, unsigned long size, int flag_xen_hv)
 		if (!read_vmcoreinfo())
 			goto out;
 	}
+	read_vmcoreinfo_kallsyms();
+
 	close_vmcoreinfo();
 
 	ret = TRUE;
diff --git a/makedumpfile.h b/makedumpfile.h
index 944397a..cc474ad 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -257,6 +257,7 @@ static inline int string_exists(char *s) { return (s ? TRUE : FALSE); }
 #define UINT(ADDR)	*((unsigned int *)(ADDR))
 #define ULONG(ADDR)	*((unsigned long *)(ADDR))
 #define ULONGLONG(ADDR)	*((unsigned long long *)(ADDR))
+#define VOID_PTR(ADDR)  *((void **)(ADDR))
 
 
 /*
@@ -1917,6 +1918,16 @@ struct symbol_table {
 	 * symbols on sparc64 arch
 	 */
 	unsigned long long		vmemmap_table;
+
+	/*
+	 * kallsyms related
+	 */
+	unsigned long long		kallsyms_names;
+	unsigned long long		kallsyms_num_syms;
+	unsigned long long		kallsyms_token_table;
+	unsigned long long		kallsyms_token_index;
+	unsigned long long		kallsyms_offsets;
+	unsigned long long		kallsyms_relative_base;
 };
 
 struct size_table {
-- 
2.47.0


