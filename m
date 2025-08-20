Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F90CA0EFC
	for <kexec@archiver.kernel.org>; Wed, 20 Aug 2025 05:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tSX6B0M/ECg+25VESJMFTz+rvOMGoiNHgeaxc9XIWxk=; b=rwt3BBCV7wSoTB9dWyvDBFohGe
	DpQMIRBQjgIWBujhnmRu8C74Gqj8fgy092tUO40Dff2nCBrb7EaYs5R8zbJCz23Sb5mRYX9sFJhv8
	Ui2zpE6bjyAMZ5KOlV8ds6HsfswPzs88do9LgDZLjeSlzRVmyhVMb7iumxTi0/rGWaRNKAj7S5r1T
	R7j0SzhoLYWBSqLihlso7rEPEX3OKwA4w1n4Zi4gQt8EEgTT+gSxNAud4SCTCAy5KD2CLTmJvKADg
	RrGR7bzRf6Lry1vGZrgWltT3T1HyE6dF2K8a2jYJ0M911/o1r29oNmH85lqkr6f+H1X+c2hXBN7a5
	zLtKGr/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uobde-0000000CRg6-0e5M;
	Wed, 20 Aug 2025 05:45:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uobUw-0000000CQIQ-38ix
	for kexec@lists.infradead.org;
	Wed, 20 Aug 2025 05:36:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755668193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tSX6B0M/ECg+25VESJMFTz+rvOMGoiNHgeaxc9XIWxk=;
	b=VPbJC8Jh9IhbYBGdxZKwU8FBEIL8yxBDDLalb0uHOYEIoT3MuJ+YaFOTx4jRzzJ0zlwIrd
	JSwJHv3XVFzBbt8d3SipR4F5LvcARUaXQYwyw2JZXW15EgepMlcDkhUziIMqBn0gpJd3Hh
	lBgKIn7NBHUsQdgTNiZrU21zgXIoYjA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-GaD0GWmKPR2v39dZ-bWOUA-1; Wed,
 20 Aug 2025 01:36:27 -0400
X-MC-Unique: GaD0GWmKPR2v39dZ-bWOUA-1
X-Mimecast-MFC-AGG-ID: GaD0GWmKPR2v39dZ-bWOUA_1755668184
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6107180047F;
	Wed, 20 Aug 2025 05:36:24 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.99])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BF69119560B0;
	Wed, 20 Aug 2025 05:36:16 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-mm@kvack.org
Cc: ryabinin.a.a@gmail.com,
	andreyknvl@gmail.com,
	glider@google.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	akpm@linux-foundation.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	sj@kernel.org,
	lorenzo.stoakes@oracle.com,
	elver@google.com,
	snovitoll@gmail.com,
	christophe.leroy@csgroup.eu,
	Baoquan He <bhe@redhat.com>,
	linux-riscv@lists.infradead.org
Subject: [PATCH v3 08/12] arch/riscv: don't initialize kasan if it's disabled
Date: Wed, 20 Aug 2025 13:34:55 +0800
Message-ID: <20250820053459.164825-9-bhe@redhat.com>
In-Reply-To: <20250820053459.164825-1-bhe@redhat.com>
References: <20250820053459.164825-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_223634_850367_DB388C86 
X-CRM114-Status: UNSURE (   8.60  )
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

And also add code to enable kasan_flag_enabled, this is for later
usage.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: linux-riscv@lists.infradead.org
---
 arch/riscv/mm/kasan_init.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index 41c635d6aca4..ac3ac227c765 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -485,6 +485,9 @@ void __init kasan_init(void)
 	phys_addr_t p_start, p_end;
 	u64 i;
 
+	if (kasan_arg_disabled)
+		return;
+
 	create_tmp_mapping();
 	csr_write(CSR_SATP, PFN_DOWN(__pa(tmp_pg_dir)) | satp_mode);
 
@@ -531,6 +534,9 @@ void __init kasan_init(void)
 	memset(kasan_early_shadow_page, KASAN_SHADOW_INIT, PAGE_SIZE);
 	init_task.kasan_depth = 0;
 
+	/* KASAN is now initialized, enable it. */
+	static_branch_enable(&kasan_flag_enabled);
+
 	csr_write(CSR_SATP, PFN_DOWN(__pa(swapper_pg_dir)) | satp_mode);
 	local_flush_tlb_all();
 }
-- 
2.41.0


