Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 462CEC27C53
	for <kexec@archiver.kernel.org>; Fri,  7 Jun 2024 12:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0fYG8RZKcW+X+Wg56apRMt7amgshrPBgoB44ZJ4vrcM=; b=rrMIgAGIc/9tD9
	fKpWQct4rxdeW3aXGfI/6IoSTMR+blHi6MGcnT0577974AC6a9cIKSudfZXWiioWyWbyDTfZvVnfC
	7NNjCCKOHC406CVnA9g8w+vBjZ9sWRfBgvRi7HaJ8GMGTNcyi3hoeRbZVU43gQkIpyWX2PbVPFww7
	S8VLohZr2USjr0bJ9psCEKYC/0bm/8mcEzc3c9Ht/MH42GyC2NVGntDwQFWxoGygxtXN+Qyh4w9Th
	RnXPKd9e5RCOTL7F1NWFasE4Zoijc5d+1skqqZhU3CyyDf/xoHwrTzYXxD+ZSKKBFAThu9uiIzPS4
	x72dPOhBobg4ZZXecXYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFYgc-0000000DuvF-3QnB;
	Fri, 07 Jun 2024 12:27:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFYgZ-0000000DunC-32Qd
	for kexec@lists.infradead.org;
	Fri, 07 Jun 2024 12:27:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W4ZPJMKNqAKs+WSkD3sNi4S4EfGxm9XkiKd+CksFrl0=;
	b=L/0drqJyBNDOULicHLwYgpv1LY4ZgLKQa6EgT2TeQN6AtzuEJTxJgxltZnIL9dsLgMgsJH
	pmv3Dl61oriU0a7sRU6zcVeCQ6cMBm1Uh0xu+RLyLZmbU4OHOPD0bJZrseQ8Fub7N/8Gxz
	hh7PZTGAR1LAVX4FWGyjV0jm4tC2a8I=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-z1c_UdI0PzKSdKxn6kGIZg-1; Fri, 07 Jun 2024 08:27:07 -0400
X-MC-Unique: z1c_UdI0PzKSdKxn6kGIZg-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-374a2ada068so17500905ab.1
        for <kexec@lists.infradead.org>; Fri, 07 Jun 2024 05:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717763226; x=1718368026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4ZPJMKNqAKs+WSkD3sNi4S4EfGxm9XkiKd+CksFrl0=;
        b=ojR7vJKjZFb3aMlkfsIIacrIF2u1CC9yFsUJX0dBmltW+dEXB8u2ZX6E1k/iE7EUDf
         +Slx6gIVKFFIO7SBPidBr1m3QqDtN5R9Kxla3Uyu+XXFj69FjhmoJbdUy5Z0l1Y5YZvE
         sbwSlJkaRCfmJrSYGFAvYA28xu1qBOo7nvLh6kXoYOPu5shi1ZJDQLroRZIy0wJ8W61d
         lqAT0WvwOYZMQyykVnqWaOM41ivzDWoAYf2QDVBE+HsOsffvDn71POcIorH6FD9bNSyh
         y8rLTS6zLUm0qM791EQO828RXTLUACeXZ8gX+0NtY4dM7KRZYFG1oBSDbNp5/P3/Q/nt
         D3mg==
X-Gm-Message-State: AOJu0Yz8cEUsrnFMPLPbPDN7Fby5O0zNnJgG/UJyjRRZKBSZMC+tp8V8
	HsQJB/2cNjhiICFPiwR8csmZfvif5rC5boi7iPkYIwCEKZOp1+BJSMVQGzxzS8YsCVwKFw+VWgU
	e7RExqRZ4OxBvkcfM0aOTmu5xx26cPZdpqJqBlc1QOodG+PIP8KD5AtaeT0JfEZ7lzDztm/NFyV
	AB2CX4p0xzeIi3FQkdCUGSryekcJ/NsZRQE6PF0OHInlz7
X-Received: by 2002:a05:6e02:1b0f:b0:374:a738:818c with SMTP id e9e14a558f8ab-3758030b7a4mr31967765ab.12.1717763225568;
        Fri, 07 Jun 2024 05:27:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8pU+tOy6cV80EfkDwgc4VbW/L5pJTETaDXD3l4vJiIFc665Y5KIiucld1brAK/XJ5qcivgQ==
X-Received: by 2002:a05:6e02:1b0f:b0:374:a738:818c with SMTP id e9e14a558f8ab-3758030b7a4mr31967195ab.12.1717763224612;
        Fri, 07 Jun 2024 05:27:04 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e4d8db18c2sm397294a12.29.2024.06.07.05.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:27:04 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v5 7/7] x86/crash: make the page that stores the dm crypt keys inaccessible
Date: Fri,  7 Jun 2024 20:26:17 +0800
Message-ID: <20240607122622.167228-8-coxu@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240607122622.167228-1-coxu@redhat.com>
References: <20240607122622.167228-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240607_052712_169721_B044148F 
X-CRM114-Status: GOOD (  11.74  )
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

This adds an addition layer of protection for the saved copy of dm
crypt key. Trying to access the saved copy will cause page fault.

Suggested-by: Pingfan Liu <kernelfans@gmail.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/x86/kernel/machine_kexec_64.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index b180d8e497c3..aba50ec641e6 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -545,13 +545,35 @@ static void kexec_mark_crashkres(bool protect)
 	kexec_mark_range(control, crashk_res.end, protect);
 }
 
+/* make the memory storing dm crypt keys in/accessible */
+static void kexec_mark_dm_crypt_keys(bool protect)
+{
+	unsigned long start_paddr, end_paddr;
+	unsigned int nr_pages;
+
+	if (kexec_crash_image->dm_crypt_keys_addr) {
+		start_paddr = kexec_crash_image->dm_crypt_keys_addr;
+		end_paddr = start_paddr + kexec_crash_image->dm_crypt_keys_sz - 1;
+		nr_pages = (PAGE_ALIGN(end_paddr) - PAGE_ALIGN_DOWN(start_paddr))/PAGE_SIZE;
+		if (protect)
+			set_memory_np((unsigned long)phys_to_virt(start_paddr), nr_pages);
+		else
+			__set_memory_prot(
+				(unsigned long)phys_to_virt(start_paddr),
+				nr_pages,
+				__pgprot(_PAGE_PRESENT | _PAGE_NX | _PAGE_RW));
+	}
+}
+
 void arch_kexec_protect_crashkres(void)
 {
 	kexec_mark_crashkres(true);
+	kexec_mark_dm_crypt_keys(true);
 }
 
 void arch_kexec_unprotect_crashkres(void)
 {
+	kexec_mark_dm_crypt_keys(false);
 	kexec_mark_crashkres(false);
 }
 #endif
-- 
2.45.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
