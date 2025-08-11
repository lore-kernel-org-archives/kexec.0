Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD18CA0EC0
	for <kexec@archiver.kernel.org>; Mon, 11 Aug 2025 09:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PElj3O+nt9JkRibcu8eYjPBnu7dzdN2l5hUggEeCVbs=; b=n+Gg8qvJCgLioQtW1idIvPZxdn
	SIB5rVPzDSTqfF5/qsDMowtGLUIC8AF2uYc1XwJEzeTznTwRbhbpiTKvqwRYYOmrpYacRxv2FIp6i
	ah+ZKAekOWbyBKu8O1wuKroGxU8Q8Jude051lkacIepgCKRYBzAXrTkBR18IwQ0LapTUDglg6+2m0
	s7/VG48kT77yPAcLM2FjhJAJnkK/hQnf1pBvA75fNzZPf2J0HRq0U+Bthf4ALwBFJYF52z3r63HKo
	ydtdkDcMweVDc7NcVvWS0MW5n/tIfLnjnHyN0FMHBL7vcl6VSxzfUn8tRlXeNe3amuGtcsGEoJmaO
	72dU7VIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulOpT-0000000770a-3BIi;
	Mon, 11 Aug 2025 09:28:31 +0000
Received: from out-181.mta1.migadu.com ([2001:41d0:203:375::b5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulOpQ-000000076uV-3oQg
	for kexec@lists.infradead.org;
	Mon, 11 Aug 2025 09:28:30 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754904506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PElj3O+nt9JkRibcu8eYjPBnu7dzdN2l5hUggEeCVbs=;
	b=f9RO666z7SlP1Xsw4N01Pdmzbe9xXH7Lu63qZvxV6a48js4Dv6akRmXPYlbeb5dgoAmYOH
	xEfy6DwQoZV2sJdxNl0TlU3UEk9NmLuIMJnEIgCl5FR0fw5twrTZpgOSqQyx+UE9v3coNT
	p3r4GLhYyhaW+b9yhKkSMDsmn9SVRJY=
From: Youling Tang <youling.tang@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH 6/6] LoongArch: Enable CONFIG_KEXEC_FILE
Date: Mon, 11 Aug 2025 17:26:59 +0800
Message-Id: <20250811092659.14903-7-youling.tang@linux.dev>
In-Reply-To: <20250811092659.14903-1-youling.tang@linux.dev>
References: <20250811092659.14903-1-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250811_022829_131508_4A11E991 
X-CRM114-Status: UNSURE (   6.79  )
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

This patch enables config KEXEC_FILE by default in the
loongson3_defconfig, so that user-space tools like kexec-tools
can use the same as the default interface for kexec/kdump
on LoongArch.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 arch/loongarch/configs/loongson3_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
index 34eaee0384c9..6cfea2f37cc0 100644
--- a/arch/loongarch/configs/loongson3_defconfig
+++ b/arch/loongarch/configs/loongson3_defconfig
@@ -45,6 +45,7 @@ CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_PERF_EVENTS=y
 CONFIG_KEXEC=y
+CONFIG_KEXEC_FILE=y
 CONFIG_CRASH_DUMP=y
 CONFIG_LOONGARCH=y
 CONFIG_64BIT=y
-- 
2.34.1


