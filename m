Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C2DCCFA03
	for <kexec@archiver.kernel.org>; Tue,  4 Nov 2025 03:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9IbHveQXdCOKrhg8/yH3Q8ZWYjLMu4TJQ7r3l3p1ZWQ=; b=BKB0rXS9QKIEJ3VvrNgGFFGsds
	YPutjxypjWDsxWXCT0zmV4HoLX+2j62/prchC2Phm1NLdOerEMqUzMZ8L7c6LdcUjZ/p2ve4XiVqw
	THxGW+HmsxlyyQYq1W/LlrrVXtVb7OQNrXH7FP5r6LY1Wamx8N3u1WRvjM9PNksd9+nvTWQpA4STi
	BmvAsCrS6xQzPaP87YgiZzmxiHi2PmY6rcCByis/qZCNq1hYBoAHU28ys2/zhh5fPD3YzxmuUxJxc
	zNChGqo+emPLmxLMumcGHa5ip5LcCkW0FgjpC4Rl9lDsNqw1UiG4xnF8h8x68RJOhkrp13J5Awtz4
	BmlSLDlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG7JK-0000000B0hn-2sI8;
	Tue, 04 Nov 2025 03:02:18 +0000
Received: from smtpbguseast3.qq.com ([54.243.244.52])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG7JE-0000000B0gM-1iw4
	for kexec@lists.infradead.org;
	Tue, 04 Nov 2025 03:02:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1762225301;
	bh=9IbHveQXdCOKrhg8/yH3Q8ZWYjLMu4TJQ7r3l3p1ZWQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=ckjljjrPuefNJNx60LIFVUUo+zEjTWU+/AiaO5KpW2GHI0gPpCL98l7b8PlmRXw4U
	 bS20mO1mEIrJtp2EdnYyeU/ll3EAW8fpz9MHR4yKxIgpgapPLt0ckIfkWVUEvOQAoY
	 lTRvrFbp948Qo4Wl8nsB7WoPN0bd6IxboSklNz4w=
X-QQ-mid: zesmtpgz1t1762225298tc1c145d1
X-QQ-Originating-IP: EBx/SNC8mUu8/iQ9NdWMDEqIwMb8ji3rfFBXziNw54U=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 04 Nov 2025 11:01:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11730253889305556711
EX-QQ-RecipientCnt: 4
From: Qiang Ma <maqianga@uniontech.com>
To: kexec@lists.infradead.org
Cc: horms@kernel.org,
	bhe@redhat.com,
	Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH] kexec: add kexec flag to support debug printing
Date: Tue,  4 Nov 2025 10:59:59 +0800
Message-Id: <20251104025959.1948450-1-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: N4WhQbLQyIqSqumKJB3Mx/uWjPm5ivf3FyXHK4nhXg64238SFcTNSD5Z
	XOv/lojbTaRSEhhijOxHSBe6n4gAfIfRYGEEowgZmSDi9NULtfyyBpEL283Z4CnrqXEgGI7
	IUD2of5VFDOObIY1mkJokdeAEItynqJkY99hUr4BwFEVQuhfTMdcJIVepUNgEH2ohaCv3Iw
	lYjMYoTk6LFmM6lAB2zGKEGghscYc9qs6JJfhV15tZK7dYSTteBpfbj4LeSKfRizzrzv+rg
	n9SYaBfn1VhtmNpMLLRoKB22a4PewPs3wwwUvE/RZVDq98cpq7nAyIMdAYVlUaw8khES+Df
	42ubNSZKu8luqU9o2ln5aEErsQYWCQT/tDJsP5KZxL5LCjLFX9IA2zeZ5DdMVu7X5tayg7k
	vYKupEANwHTzZ033esCrQbSnvz/2eRN2/iB/mkmN9gky4NrN5OrU/jpuCQct7c9FvK/Sz+r
	xzCA0wMjg3yoE6HtZ8CKC3PcwySCAN14SGAXFe647yfLIpOuphMSv1EMV//9OWLMcGx5Ivx
	cjC3UcjPy2AvJbndccTMZTInX3gAWvsgQPZ1G/zsSp5SJ/buEHBv1pyDN2aJ1szJKf8wOyk
	fuR1Zaaj3CpryHR0Uak5UTB2torZsRZqnVZf4VyHRXGxSi/mrwxnDJ2/FM/ThS3FDKtdBH9
	h6bCiUtVN7nse/2Vn4xgeOhS75QSGYkItiVh2WHm1cQL1FVAHzwEdE0GKQzEos+SQK7j8uL
	lcTBdmuEReLgchM8IQ6J3Vdk7dMRiYQwkDhgTGCjlX1cJNkqj6RJ4//WkO40MnkbXzpIwLI
	pOJSpKLeUyPhw8i4NKNWyUT4OlxLFifcOIC3PWN4uEHsU2Jv/sBv+NzKsh8+/RQ4aYVUKZp
	VfYUqEOny+rn+aVmutVHbpys6vwzzrkQ7oX7cO1IEW7aTnOueR6CjAEPF7JjTZ1ZJ+LjDoa
	c+wsjxy7Sn4BLTTbNWXnMFADSGnVQIWbRnudE92Vj8NeUxQEovowAhC+9xknZYo4ZHeqVxD
	3Ux2i7yDVYg3QvYc3j8xzJTo3bk7UiFVOiC5Zjvw==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_190213_232602_BE20B15E 
X-CRM114-Status: GOOD (  10.35  )
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

This add KEXEC_DEBUG to kexec_flags so that it can be passed
to kernel when '-d' is added with kexec_load interface. With that
flag enabled, kernel can enable the debugging message printing.

This patch requires support from the kexec_load debugging message
of the Linux kernel[1].

[1]: https://lore.kernel.org/kexec/20251103063440.1681657-1-maqianga@uniontech.com/

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
---
 kexec/kexec-syscall.h | 1 +
 kexec/kexec.c         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
index e9bb7de..b60804f 100644
--- a/kexec/kexec-syscall.h
+++ b/kexec/kexec-syscall.h
@@ -120,6 +120,7 @@ static inline long kexec_file_load(int kernel_fd, int initrd_fd,
 #define KEXEC_PRESERVE_CONTEXT	0x00000002
 #define KEXEC_UPDATE_ELFCOREHDR	0x00000004
 #define KEXEC_CRASH_HOTPLUG_SUPPORT	0x00000008
+#define KEXEC_DEBUG		0x00000010
 #define KEXEC_ARCH_MASK		0xffff0000
 
 /* Flags for kexec file based system call */
diff --git a/kexec/kexec.c b/kexec/kexec.c
index c9e4bcb..f425422 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1518,6 +1518,7 @@ int main(int argc, char *argv[])
 			return 0;
 		case OPT_DEBUG:
 			kexec_debug = 1;
+			kexec_flags |= KEXEC_DEBUG;
 			kexec_file_flags |= KEXEC_FILE_DEBUG;
 			break;
 		case OPT_NOIFDOWN:
-- 
2.20.1


