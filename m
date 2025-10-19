Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5972CCD1B0
	for <kexec@archiver.kernel.org>; Sun, 19 Oct 2025 06:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zvmrmv3hPe2oQTJQT8OKmJhhNCe47YQRwxqYt3ifUEE=; b=usiLtzr3lcusybASsm9ACQmUiW
	tbCeH3ECPT/4IpL1h3gKhHYOAnoRSV3XKMLzhsCddqTk2VMvXmW15ZZgIJo/tgASdoZbFP92c4ki1
	ffVIBp4KEH7iPSWJ8s+zyfXPJN72cw3FjldMQztsOgi6KmfG1iJ4MPw5rAaVQ2eBxCN9CSmzu6b8+
	kkn12x9ZItO3H3tJF7m5Dhaz4MRI+Ex858YOCDnDR17Mm7ZWj9J9V5sz+75D7y8EPG7i2/B9OWhv3
	n9vzs0NNYXxZRExMh2GA/xC1EUzf949aDPi30kxxI3bMz/LY760Z7xNNKwvK7HtWIPkv/lXsFj8Y3
	V+qA6ZmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAMj0-0000000Aj4C-0vjy;
	Sun, 19 Oct 2025 06:17:02 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAMix-0000000Aj2I-3PX1
	for kexec@lists.infradead.org;
	Sun, 19 Oct 2025 06:17:00 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-290c2b6a6c2so27665325ad.1
        for <kexec@lists.infradead.org>; Sat, 18 Oct 2025 23:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760854619; x=1761459419; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvmrmv3hPe2oQTJQT8OKmJhhNCe47YQRwxqYt3ifUEE=;
        b=eKJX3gzW0dPYNmfdvDC16LlDmaV4QOokUxzZXe/I2HDyFMobVHpBCLaM2hegoY3Ors
         hbVEZ1kxxxX+Ez5wsnSDHc+4MCsbKQdJiyivpFPf9rYDV9h4tPXchktsPiU5urnu1EjM
         JmTiG9iz2ZdIAGDS5TI1NHAMefbr5Yn9uZlKq/WYI615/iOg884aFjQxhCY/K88NNhvU
         MvMB0oqT/bMEJCurzUDUadJBm/boti+jp/LpSZ1KMvutwVel4rj3pCtXtfLrxyie9Anj
         CV0JiTHnNhLv7bOdsP2l/tTsGNufB/9+7z2zjmGBoXBQ+of/+4kJECey6XOUah/7dbam
         u8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760854619; x=1761459419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvmrmv3hPe2oQTJQT8OKmJhhNCe47YQRwxqYt3ifUEE=;
        b=cp/hZ5rPFvR4Qpn0KwUgGfhWPxhPsUMHDvqa6W0HjpjZmpbe66RXsmpCYTdDBCDk+w
         g7GwTZJumfMByq8BTnjLf7IUZCYLA0NfsGuVp1SAi7G24rH4Ti3Kj7YKGDcgzgwaFNQH
         sKfz/Kq6IENMABWNDNTjeAhDyZBt+KR71LSAbJNBA97Vr819Lb1De5kYHu9XYKFgnCsu
         c5Bt/3p+L9PAjdpBUs5WK2SOjuncHB3EA9n6gu8Z1qyeUaYeRbd7hDYA31MOuGGugQxn
         NXJ94gW0jEQqbL0f785jTzjHjnm2AnlFpD8Vc28/DxCi5FVAnDFmYvOlGhMMB0MPfuMU
         /orw==
X-Forwarded-Encrypted: i=1; AJvYcCU6z7+ij9Ja0BiR7bUbpMeWtjOaKR4Dl8zXLUP21CBnFeDl+kG47UlNfgzOcIIIqsR6PjNZ7w==@lists.infradead.org
X-Gm-Message-State: AOJu0YwZyL9uN9fcnqMTEjTpaLolIvoZ9CIxk3sNrGEkvMNM+vm/8k6Q
	LaK+vxD6kGVfRsmAwZ57LdpvuU8YySRBN/d2Khmr+3pAMJLPHRFC4MCg
X-Gm-Gg: ASbGncu7Wbn942tnN6ZathDTkIZDaSWYUN4f6tvANTsZa9trrs+j0874sFjBOaMGo12
	PuFTgi8STClDsNpwI7SI44Jn32viMdrYa8zjaNBwVMdZPKqK7gbcrSHiC0xODVqecLWxH5zDwXh
	8CqZs6KEw5OiNCoDTAek6g4lie95iLJ9y9RWBrthYw0hPcgB5afcS1M6gNywKl4Os6bw4ezqnoO
	lchdIWQbu3sExAeFNdqn/6x14kkEpMwaLE41KqKxWeDylEnVmMHJ7X8Dg5Wlxp8kZ6MC/jJVFpt
	mVn9SGuKtYLj9nlXA5KJmkyUuJ3LhlTjFF1lI/DxsQpFcK1FaevqBLJKhUEKwhl//EXct7dQNza
	TNvztUMPkNTAlqaozdEaeIljMpEvKfrN2bS3BJ7De137ItwyhhWvVw3oMTvi0K9lKwmRAANFknt
	WjJyMvJnMAl9bniVI=
X-Google-Smtp-Source: AGHT+IGr/O8zk+3lAXEyhTOS21GeRIQ7WsMW/dXKVowLJ0bFIrZpOFcNFSeyeDuMLrkyPKnaIvg3BA==
X-Received: by 2002:a17:903:298c:b0:27e:eabd:4b41 with SMTP id d9443c01a7336-290c9c89eabmr108602405ad.7.1760854618954;
        Sat, 18 Oct 2025 23:16:58 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:bc87:d8fe:3e55:7ffb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b6f302sm4332032a12.38.2025.10.18.23.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 23:16:58 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: jiri@resnulli.us,
	stefanha@redhat.com,
	multikernel@lists.linux.dev,
	pasha.tatashin@soleen.com,
	Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [RFC Patch v2 05/16] x86: Introduce arch_cpu_physical_id() to obtain physical CPU ID
Date: Sat, 18 Oct 2025 23:16:19 -0700
Message-Id: <20251019061631.2235405-6-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019061631.2235405-1-xiyou.wangcong@gmail.com>
References: <20251019061631.2235405-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251018_231659_861136_58A715B4 
X-CRM114-Status: GOOD (  12.51  )
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

From: Cong Wang <cwang@multikernel.io>

The tranditional smp_processor_id() is a software-defined CPU ID which
is only unique within the same kernel. With Multikernel architecture, we
run multiple Linux kernels on different CPU's, hence the host kernel
needs a globally unique CPU ID to manage the CPU's. The physical CPU ID
is perfect for this case.

This API will be used to globally distinguish CPU's among different
multikernels.

Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 arch/x86/include/asm/smp.h | 6 ++++++
 arch/x86/kernel/smp.c      | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 1a59fd0de759..378be65ceafa 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -40,6 +40,7 @@ struct smp_ops {
 
 	void (*send_call_func_ipi)(const struct cpumask *mask);
 	void (*send_call_func_single_ipi)(int cpu);
+	int (*cpu_physical_id)(int cpu);
 };
 
 /* Globals due to paravirt */
@@ -100,6 +101,11 @@ static inline void arch_send_call_function_ipi_mask(const struct cpumask *mask)
 	smp_ops.send_call_func_ipi(mask);
 }
 
+static inline int arch_cpu_physical_id(int cpu)
+{
+	return smp_ops.cpu_physical_id(cpu);
+}
+
 void cpu_disable_common(void);
 void native_smp_prepare_boot_cpu(void);
 void smp_prepare_cpus_common(void);
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 59658fcd9037..e2eba09da7fc 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -288,6 +288,11 @@ static int __init nonmi_ipi_setup(char *str)
 
 __setup("nonmi_ipi", nonmi_ipi_setup);
 
+static int native_cpu_physical_id(int cpu)
+{
+	return cpu_physical_id(cpu);
+}
+
 struct smp_ops smp_ops = {
 	.smp_prepare_boot_cpu	= native_smp_prepare_boot_cpu,
 	.smp_prepare_cpus	= native_smp_prepare_cpus,
@@ -305,6 +310,7 @@ struct smp_ops smp_ops = {
 
 	.send_call_func_ipi	= native_send_call_func_ipi,
 	.send_call_func_single_ipi = native_send_call_func_single_ipi,
+	.cpu_physical_id	= native_cpu_physical_id,
 };
 EXPORT_SYMBOL_GPL(smp_ops);
 
-- 
2.34.1


