Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58564E77170
	for <kexec@archiver.kernel.org>; Thu,  5 Dec 2024 15:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n1NxLTesaxf1CmVmrYGt0DtpmfeNYvqyA55PeXFrYQI=; b=CtPatx6PlsV+016fbT3i4DW5G5
	5MZRKAQrodvrdNw291araeZbl2SWDrj8GLXJf6GeP32b8IgoGkx9aLLvk6n/+pcmdj48ruUCM5AJn
	2c3JUnr5je1z7PMb1fTNuh1iMOg2J8d8BtZ5lPLYC2IZKOjsKi/JEgog0L6wbZhPgGWvejvCa6mSo
	bLlXWTK9untlEtmGte7flT8peympS0+zwDbcJtGSNiQX7i7quTpugISB83fYkCRdZjUvixTMOi4zX
	1SpkUUdHgZWd4yY6+wTlm1uIn5EdYLIOao1BXrPnqqN1kPdhDGjMp1UcyM+sUDNOIxTyeFkGIRYbp
	Otp214kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDsz-0000000GZ3v-05QR;
	Thu, 05 Dec 2024 15:35:25 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDrR-0000000GYRw-07Wo
	for kexec@bombadil.infradead.org;
	Thu, 05 Dec 2024 15:33:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=n1NxLTesaxf1CmVmrYGt0DtpmfeNYvqyA55PeXFrYQI=; b=LQwBT1I1tgzvK5VpQKCeLWCjPP
	P1i7QKG/TI5/JWlMSK7zGtWltMMtDmitz0vvv4F962VQsj6BdCFJ/1+YhgIXZLhpIg7dud5x+Tbip
	l7SZjwZnXFWGj+NYsOz8LAdOHo0gYzjXZdjEGwJXnZhgMymq9NQteKWnd8eMXi3KJq0lJnrPgRuv/
	p+uHF7oSahzzf+HodaeW3slwbyGeTsRVfYINYG2yGlakDjLIOQ3VLQb02tnzpVhvFuc2KFuTmXQga
	WGi38rBF8riZKChKNbXb7I8oOgfVkzLadoG1+UhSqMqgtqyEQfhusLBToEcDTPC+dbwg3n2/zcvbt
	MRh42dsg==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDrO-00000002wEz-0j20;
	Thu, 05 Dec 2024 15:33:46 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDrN-0000000DyM8-3AEi;
	Thu, 05 Dec 2024 15:33:45 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kexec@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	jpoimboe@kernel.org,
	bsz@amazon.de
Subject: [PATCH v5 14/20] x86/kexec: Add CONFIG_KEXEC_DEBUG option
Date: Thu,  5 Dec 2024 15:05:20 +0000
Message-ID: <20241205153343.3275139-15-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241205153343.3275139-1-dwmw2@infradead.org>
References: <20241205153343.3275139-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html
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

From: David Woodhouse <dwmw@amazon.co.uk>

This does nothing yet.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/Kconfig.debug | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 74777a97e394..9dde32865a9b 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -56,6 +56,14 @@ config EARLY_PRINTK_USB_XDBC
 	  You should normally say N here, unless you want to debug early
 	  crashes or need a very simple printk logging facility.
 
+config KEXEC_DEBUG
+	bool "Debug kexec transition"
+	depends on KEXEC_CORE && EARLY_PRINTK
+	help
+	  Faults during kexec can be difficult to debug. This installs exception
+	  handlers and attempts to report faults through the same serial port as
+	  used for early_printk.
+
 config EFI_PGT_DUMP
 	bool "Dump the EFI pagetable"
 	depends on EFI
-- 
2.47.0


