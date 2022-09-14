Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C85ECAAD8
	for <kexec@archiver.kernel.org>; Wed, 14 Sep 2022 01:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=48dUe9AqHy0tLaVMLhg3nhUgukZGqEI3AiG58McU4aA=; b=4yMCwzzeia+sa1
	M5YUtcESiWfIhVDdlvJScLfzrq49v/g4XuXGsq8ImzZPb9r0nrdDwhXt7B2hV7gE78dqEGLDMJNRu
	rpdTt9K7+I2HqxeOo/orUJ80CoEl2NvwNso/aXZ/nKfpZECPQlGc6BDDM0hxmPN0DT//vFMpRfTwB
	0brJNM7zumBPK1VKGaHT4Tq8/quRXxcoIB7HqVZSPURP//j43PDrZ20cjKRJfbEu8HWlmH+GD0vSu
	0Yfatk87CY2Yj9fEhGk+7R1ynBXp0USlV5NZ0/nGk2NIpUWisUO0XA06uKUvmhZp1iRGEJUPsUPUB
	sxBEWx+c9m4wbPBqr0qQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYHHR-003bEh-Rs; Wed, 14 Sep 2022 01:33:33 +0000
Received: from mail-m971.mail.163.com ([123.126.97.1])
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYHHN-003b68-66
	for kexec@lists.infradead.org; Wed, 14 Sep 2022 01:33:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=KqodM
	YrOFpEVlmPN5U59wZd+Mb7IJb+e/Mld+L/PKCU=; b=CPZrAAyhnjpBuCstJMvKh
	ZWhHoSdrtYuYC0g6TuPzYYyQUsQ1YKD2qcroJOZJm2tIrpIh+IbeAbDipJzDSblJ
	DVeRAG88NcK0/hEtbhRUFKjmG+Bg3soE576TdBTIlXBKoZxfFiNj5mqHayfwqJfr
	7mzrcEbwn97/q2ym+oqxME=
Received: from localhost.localdomain (unknown [36.112.3.106])
	by smtp1 (Coremail) with SMTP id GdxpCgDnUuVXLyFjD05gcg--.57701S4;
	Wed, 14 Sep 2022 09:33:25 +0800 (CST)
From: Jianglei Nie <niejianglei2021@163.com>
To: bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH v2] proc/vmcore: fix potential memory leak in vmcore_init()
Date: Wed, 14 Sep 2022 09:33:10 +0800
Message-Id: <20220914013310.6386-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CM-TRANSID: GdxpCgDnUuVXLyFjD05gcg--.57701S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrWUtFW5Gw4xXFWfXr17Awb_yoWfZwb_Aa
	18tF4xXw4rJan3GrWUKFy5tw4akr1j9rs8XF1fGF9rGFyrtwsxW3s7ZrZ3Ar97XrsYvry5
	uwsakFy2934rGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_sqWUUUUUU==
X-Originating-IP: [36.112.3.106]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbiFQZ8jF5mMjllDAAAs5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220913_183329_739303_BA3F5A32 
X-CRM114-Status: UNSURE (   8.87  )
X-CRM114-Notice: Please train this message.
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

elfcorehdr_alloc() allocates a memory chunk for elfcorehdr_addr with
kzalloc(). If is_vmcore_usable() returns false, elfcorehdr_addr is a
predefined value. If parse_crash_elf_headers() gets some error and
returns a negetive value, the elfcorehdr_addr should be released with
elfcorehdr_free().

Fix it by calling elfcorehdr_free() when parse_crash_elf_headers() fails.

Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 fs/proc/vmcore.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index f2aa86c421f2..74747571d58e 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1567,6 +1567,7 @@ static int __init vmcore_init(void)
 		return rc;
 	rc = parse_crash_elf_headers();
 	if (rc) {
+		elfcorehdr_free(elfcorehdr_addr);
 		pr_warn("Kdump: vmcore not initialized\n");
 		return rc;
 	}
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
