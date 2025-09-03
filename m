Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E67CA0FED
	for <kexec@archiver.kernel.org>; Wed,  3 Sep 2025 03:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/Tx2jEMYoq+JZmLfU1X2XC0TcFq4rDCnPfS8rv1Co/4=; b=PcI3ISHQNQoBstpjEjH7pSpyF8
	7Gf43AlDhm2V3hyW18BBnyDpTtKVqvNbHqLyg62mY0ad54VOBl7ZVrWT4GBbgQzfsj16jaNitRUUW
	FnC2fLsxWS4sQwWZV3vZAmjXbj9+gdL3+qw2CLyYrlyT4xjTjMZKVl/qVrbtI9MwLqJ99aZglhg4h
	dkgAe2yYIbvE5Ivr5yDUoQRAbl4Hmwe92CVLLBTmEGNofrhH+hMzCnhC0JoiSefZwsSHhT514QoDT
	z3g8YESus3E9aQ0JVzKAJi6F7VFD3uBIfEVEwk5BOkRx0yF4ohLlfCLvaphWTk9k61nGvRB15beMV
	+wpLHmWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utdlb-00000003RA3-2t2a;
	Wed, 03 Sep 2025 03:02:35 +0000
Received: from out-180.mta0.migadu.com ([2001:41d0:1004:224b::b4])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utdlZ-00000003R7N-2GqR
	for kexec@lists.infradead.org;
	Wed, 03 Sep 2025 03:02:34 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756868551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Tx2jEMYoq+JZmLfU1X2XC0TcFq4rDCnPfS8rv1Co/4=;
	b=f9v3HJRtEPoHVtsb36i9AJ/EENH+XT+9tVrfyaZTy3JbfQuhVfbkgVbbAzrPkV3wXlyk9v
	BC8vBd2c9cNKyItzFfSAiyg8WmUd5l2HssYD4wv/w5Hw9J0dO4uWAeSDg18akW9pPSvx6X
	DkBPHzNd+MHZif29SmTlWwaKDS2k8lo=
From: Youling Tang <youling.tang@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Baoquan He <bhe@redhat.com>,
	Yao Zi <ziyao@disroot.org>,
	kexec@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v4 6/7] LoongArch: Automatically disable kaslr when the kernel loads from kexec_file
Date: Wed,  3 Sep 2025 11:00:59 +0800
Message-Id: <20250903030100.196744-7-youling.tang@linux.dev>
In-Reply-To: <20250903030100.196744-1-youling.tang@linux.dev>
References: <20250903030100.196744-1-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250902_200233_725544_AC1A5578 
X-CRM114-Status: UNSURE (   9.21  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: Youling Tang <tangyouling@kylinos.cn>

Automatically disable kaslr when the kernel loads from kexec_file.

kexec_file loads the secondary kernel image to a non-linked address,
inherently providing KASLR-like randomization.

However, on LoongArch where System RAM may be non-contiguous, enabling
KASLR for the second kernel could relocate it to an invalid memory
region and cause boot failure. Thus, we disable KASLR when
"kexec_file" is detected in the command line.

To ensure compatibility with older kernels loaded via kexec_file,
this patch need be backported to stable branches.

Cc: stable@vger.kernel.org
Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 arch/loongarch/kernel/relocate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/loongarch/kernel/relocate.c b/arch/loongarch/kernel/relocate.c
index 50c469067f3a..4c097532cb88 100644
--- a/arch/loongarch/kernel/relocate.c
+++ b/arch/loongarch/kernel/relocate.c
@@ -140,6 +140,10 @@ static inline __init bool kaslr_disabled(void)
 	if (str == boot_command_line || (str > boot_command_line && *(str - 1) == ' '))
 		return true;
 
+	str = strstr(boot_command_line, "kexec_file");
+	if (str == boot_command_line || (str > boot_command_line && *(str - 1) == ' '))
+		return true;
+
 #ifdef CONFIG_HIBERNATION
 	str = strstr(builtin_cmdline, "nohibernate");
 	if (str == builtin_cmdline || (str > builtin_cmdline && *(str - 1) == ' '))
-- 
2.43.0


