Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBB1C47422
	for <kexec@archiver.kernel.org>; Wed, 24 Jan 2024 05:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uZC4DLpFzZBSbbAm0bFXPhMSK69hia1DMZvIYN0scL0=; b=ZuUWgbN/d8W5wt
	KJGoeNzwbbwgvZYescmLMdihVrygRcg8SNjRJCY/6g0pBr4yJqi4DbB8c+Lj0WCX5DDbKnqqq8fAJ
	jk1XjQruBVxT4YLcT0jLVpQnMwBuV5wlflw0jdhbYvuJwtoPi7macCyD/OhOqOu3GDSQp/pX9yuCr
	PqJurpGVDn3XzP31pOLRRqlX28A69Y3hwPAY7GyM+Q8C9VmIdmcV3zVA9ctP7fAvPvE2W1/EsEOKH
	RiGq2sk8Lruc7yB/FHZzFxJdBMPt1oG4J525swwBYN7NiBbZQRhNCUnaiIUA/ad+WpKVzUguspNw3
	30LRtTg5T/QRXzS4i7Ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSVaG-001WmI-2T;
	Wed, 24 Jan 2024 05:13:56 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSVaF-001Wkq-1Q
	for kexec@bombadil.infradead.org;
	Wed, 24 Jan 2024 05:13:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-type
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=idAf8C8vEaEPhamo8i8Q+7QtJLmbWmmoc+K4mQqU0s4=; b=IEyKlkUF1a52OkSVSAxL+Is0p5
	D86xpongBFHxiizB3TnxJdtLSkIAYJ3J2wSwKLTYoiN2quKPRVvDXloS+lP3In3/pqMeRCjHNVKlE
	lgR/0QRVAuEpzPE/QWbM8NG0IG/YwrQdb20hlzZ3y7FdV5PZ3E2ePjmguvjmxdzfjyHFyT/o6J8yB
	k4J74FQSPI+QPhSLL1Xzq4ZF87FM8XWL/8fQrtQz23EfhMu4l3WRWHYefguZDIHmlyq4ez2pk2F85
	OcwsyuF9R3QciMqjtqDJ1jot1ZF8sizNYksm+OAHjg5yKwvxeKY9IP1GP7GcacpJdCFBybECbws+p
	7c2kZkfw==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rSVaA-00000004FEM-3DOy
	for kexec@lists.infradead.org;
	Wed, 24 Jan 2024 05:13:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706073225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=idAf8C8vEaEPhamo8i8Q+7QtJLmbWmmoc+K4mQqU0s4=;
	b=XfIfF580qNkTbpJdqyRrdHKIN1krMboeXWsGEwWkCTMz35k8ING/Grq9Z7w8ubHeUT9q49
	riRB4N7sntsK/gNRzjMMDamusuejObSXUZ/WsmIDkaUJ2u/q67xRf9z1PM8BSnI+lUhOp6
	i5rsdvF/HClzbI74EIloyfd5wyKhAOw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706073226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=idAf8C8vEaEPhamo8i8Q+7QtJLmbWmmoc+K4mQqU0s4=;
	b=cmDB7FFlTDfyJ21q/mM4jIlxLB27dLRgVefWN1YZ1BebTtnO1Jp04x/MUHucku5rdjss1w
	vOjkYEkTewFl0W6Yajge2O+Qi1CvzqhwVW8eGT6u5FrdDWdJ8m8iyRf6c/G0o6z82JGqo4
	I2nqOvooi7b8kcmSBaD7coB0uSio+WU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-ttLakTbNM3uB_a-svY1mPA-1; Wed,
 24 Jan 2024 00:13:41 -0500
X-MC-Unique: ttLakTbNM3uB_a-svY1mPA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A8E4738212D7;
	Wed, 24 Jan 2024 05:13:40 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.117])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 18A5F1C060AF;
	Wed, 24 Jan 2024 05:13:34 +0000 (UTC)
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
Subject: [PATCH linux-next v3 05/14] crash: clean up kdump related config items
Date: Wed, 24 Jan 2024 13:12:45 +0800
Message-ID: <20240124051254.67105-6-bhe@redhat.com>
In-Reply-To: <20240124051254.67105-1-bhe@redhat.com>
References: <20240124051254.67105-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_051351_042424_AFBFA5D0 
X-CRM114-Status: UNSURE (   8.19  )
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

By splitting CRASH_RESERVE and VMCORE_INFO out from CRASH_CORE, cleaning
up the dependency of FA_DMUMP on CRASH_DUMP, and moving crash codes from
kexec_core.c to crash_core.c, now we can rearrange CRASH_DUMP to
depend on KEXEC_CORE, and make CRASH_DUMP select CRASH_RESERVE and
VMCORE_INFO.

KEXEC_CORE won't select CRASH_RESERVE and VMCORE_INFO any more because
KEXEC_CORE enables codes which allocate control pages, copy
kexec/kdump segments, and prepare for switching. These codes are shared
by both kexec reboot and crash dumping.

Doing this makes codes and the corresponding config items more
logical (the right item depends on or is selected by the left item).

PROC_KCORE -----------> VMCORE_INFO

           |----------> VMCORE_INFO
FA_DUMP----|
           |----------> CRASH_RESERVE

                                                ---->VMCORE_INFO
                                               /
                                               |---->CRASH_RESERVE
KEXEC      --|                                /|
             |--> KEXEC_CORE--> CRASH_DUMP-->/-|---->PROC_VMCORE
KEXEC_FILE --|                               \ |
                                               \---->CRASH_HOTPLUG

KEXEC      --|
             |--> KEXEC_CORE--> kexec reboot
KEXEC_FILE --|

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 kernel/Kconfig.kexec | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 8faf27043432..6c34e63c88ff 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -9,8 +9,6 @@ config VMCORE_INFO
 	bool
 
 config KEXEC_CORE
-	select VMCORE_INFO
-	select CRASH_RESERVE
 	bool
 
 config KEXEC_ELF
@@ -99,8 +97,11 @@ config KEXEC_JUMP
 
 config CRASH_DUMP
 	bool "kernel crash dumps"
+	default y
 	depends on ARCH_SUPPORTS_CRASH_DUMP
-	select KEXEC_CORE
+	depends on KEXEC_CORE
+	select VMCORE_INFO
+	select CRASH_RESERVE
 	help
 	  Generate crash dump after being started by kexec.
 	  This should be normally only set in special crash dump kernels
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
