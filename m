Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9FF3CD5BC9
	for <kexec@archiver.kernel.org>; Thu, 28 May 2026 00:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8XqGfPBcF9bFjDUhWCxrpIIXmVyxEM9VuCw6U3fAvno=; b=YDDL4ob8iu/ci3XS5oPMFf+f7z
	a+dxtlN4e2FQixYxRXitzoLbTxq4UXmzj1lHfjFB0JUHqr9iYlb2/75BEoSVyXcHZWTnV4yPmbdKZ
	brI6vNVoKjKXXODvZ5dv4cgfw1DmZS88IRW9lVm+tkXt/Uq6e2mYoXCSUy1PTIFK7C73tLx32BWN0
	cgb+pR9vy0kwaIhjhct1HJ4RK+AKr4l5FjlBrqzgx7zoNi6Qkd/XIWpqNXOIp0Z6Udtwl/zNdQCn1
	TDv0464hT/jnaHnaIMO4lef/v+iKihecQh7Hs58zMuNT849GrOo9EKJLKfVFT6+95Xa1vUCm2cICp
	xufYdFCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSOqG-00000004tFS-2HGI;
	Thu, 28 May 2026 00:43:20 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSOpa-00000004sL2-3M0a;
	Thu, 28 May 2026 00:42:41 +0000
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id F1B1220B716D; Wed, 27 May 2026 17:42:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F1B1220B716D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779928947;
	bh=8XqGfPBcF9bFjDUhWCxrpIIXmVyxEM9VuCw6U3fAvno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W9kAPBs8LwEWBV0ebKB/ahPWQuFzeLJ6xNmCYxKujyhsamuhvAAWjEe9z72dZsEtP
	 kUds189D7aKJHbd3LE6QYUtwgD6foSF58eDpH1+s1/eKnLq5WuYzt8Hoz7lXKZV2Ts
	 rilWfX9z+RcPy4AxdmmGO1/QNhU4PO6QOAMxD7Qo=
From: Jork Loeser <jloeser@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-mm@kvack.org,
	kexec@lists.infradead.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Jason Miu <jasonmiu@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Baoquan He <bhe@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kees Cook <kees@kernel.org>,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>,
	Justinien Bouron <jbouron@amazon.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Pingfan Liu <piliu@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>,
	Jork Loeser <jloeser@linux.microsoft.com>
Subject: [RFC PATCH 19/20] kexec: export kexec_in_progress for modules
Date: Wed, 27 May 2026 17:42:01 -0700
Message-ID: <20260528004204.1484584-20-jloeser@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260528004204.1484584-1-jloeser@linux.microsoft.com>
References: <20260528004204.1484584-1-jloeser@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_174238_869709_7E9E4E99 
X-CRM114-Status: UNSURE (   8.99  )
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

Modules that register reboot notifiers may need to distinguish a
kexec from a regular reboot.  Export kexec_in_progress so they can
check without requiring a built-in wrapper.

Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
---
 kernel/kexec_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index a43d2da0fe3e..68efbba52fbd 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -53,6 +53,7 @@ atomic_t __kexec_lock = ATOMIC_INIT(0);
 
 /* Flag to indicate we are going to kexec a new kernel */
 bool kexec_in_progress = false;
+EXPORT_SYMBOL_GPL(kexec_in_progress);
 
 bool kexec_file_dbg_print;
 
-- 
2.43.0


