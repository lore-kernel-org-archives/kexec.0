Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A50C4725D
	for <kexec@archiver.kernel.org>; Fri, 19 Jan 2024 14:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=m/X0tYI04icLsaYIeAELHQy4WlvOOSipLe8hWJBViyU=; b=owAvGhjYmZEMzQ
	nQM24eWNW7ZpNw6Dr8BwXdbuMNvuBVPB72k3/wc78p9cEeMxz3rAAGl8i7Sj4B961v9Q2P0LKLIa2
	a0UpYdpGe7winssdxw5+Wd6FLEscAL+3cjzyHO6qNFeZPTxJyMZhKhPEjJVLNe75a62BCpPCwv9bX
	5MSsldAdGJixveTPB5axtnezpilJE8Pv8DjrNtbgAs26nHFrRIG/CgTf30FMGhzXYZnKHIsRkwXJT
	FNHwI4A/XrUbL0LtAqZ89wSKixVqGUU1cGNNlgGTwpkqCS5h336S2LUim2DNiF/wzTCCPS2EpH8Mq
	2a/5Nr9LR8GnmY5KK47A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQqGt-005ugD-33;
	Fri, 19 Jan 2024 14:55:03 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQqGk-005uWA-0C
	for kexec@bombadil.infradead.org;
	Fri, 19 Jan 2024 14:54:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-type
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=jDvYJxBJvZegSwo4Kk9zAYMdDY4WlX7FhACBVJ8AwnU=; b=CzEBAOFW13qp4KHc8tiUTZOfgP
	X9NmIUmw1EOvaCs1dA/WyqGCotIqcpCwt8VcFnARDJTkKmlfORMWjBp1jiaKIldEntJIWV8hPNZIe
	h9mD5b9fK9WklDVwjBlSxsoAlRa0bn9brTBbqBxn3z6CIURtVhoNxmIoIHkExcCo9cueLCpRAYIwE
	YHQDiefQLf6DUJ/fEzUmlPDnzQW1EQU6jl/6Esgi5k/DnIr1MyzvFjyHC0CCQfBbKPu6nD4bRZQ+Z
	ChTXtGVZC4/CdjpGBGMIafew3Fx1P1AzDUp551fivZsvNH3isHjPX/LVhveBaWIpmogBfPBWVZaeC
	SKNwNtfg==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rQqGa-00000001cUk-3eAW
	for kexec@lists.infradead.org;
	Fri, 19 Jan 2024 14:54:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705676083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jDvYJxBJvZegSwo4Kk9zAYMdDY4WlX7FhACBVJ8AwnU=;
	b=ORzIrdUDBWYLF9AqgtgaMPMQ9Yhp3mVzOU1mE7ijFBU4mEE6PX5aOme9tVYAg5Siolf+DC
	lOttDUw+hps91o/Bqvzr0KQDw3kBflN2GN/O2/0KbeEmIBUzTfg1NjtKnpIFeQxGHJjTbU
	2XML8XKPwkIvPhJDfCnfmlPNsYUcK04=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705676083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jDvYJxBJvZegSwo4Kk9zAYMdDY4WlX7FhACBVJ8AwnU=;
	b=ORzIrdUDBWYLF9AqgtgaMPMQ9Yhp3mVzOU1mE7ijFBU4mEE6PX5aOme9tVYAg5Siolf+DC
	lOttDUw+hps91o/Bqvzr0KQDw3kBflN2GN/O2/0KbeEmIBUzTfg1NjtKnpIFeQxGHJjTbU
	2XML8XKPwkIvPhJDfCnfmlPNsYUcK04=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-osoDulHkOveZzpDk9NGWvg-1; Fri, 19 Jan 2024 09:54:38 -0500
X-MC-Unique: osoDulHkOveZzpDk9NGWvg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 12C54868A02;
	Fri, 19 Jan 2024 14:54:37 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DBA8251D5;
	Fri, 19 Jan 2024 14:54:30 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	loongarch@lists.linux.dev,
	akpm@linux-foundation.org,
	ebiederm@xmission.com,
	hbathini@linux.ibm.com,
	piliu@redhat.com,
	viro@zeniv.linux.org.uk,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 14/14] loongarch, crash: wrap crash dumping code into crash related ifdefs
Date: Fri, 19 Jan 2024 22:52:41 +0800
Message-ID: <20240119145241.769622-15-bhe@redhat.com>
In-Reply-To: <20240119145241.769622-1-bhe@redhat.com>
References: <20240119145241.769622-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240119_145446_428310_D149C64B 
X-CRM114-Status: UNSURE (   9.49  )
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

Now crash codes under kernel/ folder has been split out from kexec
code, crash dumping can be separated from kexec reboot in config
items on loongarch with some adjustments.

Here wrap up crash dumping codes with CONFIG_CRASH_DUMP ifdeffery, and
use IS_ENABLED(CONFIG_CRASH_RESERVE) check to decide if compiling
in the crashkernel reservation code.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/loongarch/kernel/setup.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index d183a745fb85..61f88dd97947 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -258,11 +258,13 @@ static void __init arch_reserve_vmcore(void)
 
 static void __init arch_parse_crashkernel(void)
 {
-#ifdef CONFIG_KEXEC
 	int ret;
 	unsigned long long total_mem;
 	unsigned long long crash_base, crash_size;
 
+	if (!IS_ENABLED(CONFIG_CRASH_RESERVE))
+		return;
+
 	total_mem = memblock_phys_mem_size();
 	ret = parse_crashkernel(boot_command_line, total_mem,
 				&crash_size, &crash_base,
@@ -283,7 +285,6 @@ static void __init arch_parse_crashkernel(void)
 
 	crashk_res.start = crash_base;
 	crashk_res.end	 = crash_base + crash_size - 1;
-#endif
 }
 
 static void __init fdt_setup(void)
@@ -468,7 +469,7 @@ static void __init resource_init(void)
 		request_resource(res, &bss_resource);
 	}
 
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_CRASH_RESERVE
 	if (crashk_res.start < crashk_res.end) {
 		insert_resource(&iomem_resource, &crashk_res);
 		pr_info("Reserving %ldMB of memory at %ldMB for crashkernel\n",
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
