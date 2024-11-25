Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C21DD3B7F6
	for <kexec@archiver.kernel.org>; Mon, 25 Nov 2024 10:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n1NxLTesaxf1CmVmrYGt0DtpmfeNYvqyA55PeXFrYQI=; b=usHLrBPohNdYTyXq0Uan3Y44kk
	H6bo6ybsas+ObHt3RJg1u3NdsdT0lKahdCMJbcj+MEexO/4JrW7WU/498T5M+Ra8D92ztq56YEr/Z
	ji6hA//yLASA+LiUYIkOSlY1H9lnEhmL7MymEl0QBzXoGHOY+PVhPKjJdeGQfLLN4tCDemoHhYcQ1
	KiaQuKa6cOsZh7tfVnmMrsUJk/jD0ky4DtLivOLnIMCvMcVHbkUtENDfw6ibjF6ABn7bwkR8Gkiwu
	CU/jiEiqHiqpA+d4HHQUPPYIazT5FC3zq4ORE25A3SxSELW1NuvveserZJQUDrUUEB5/9XD7/EXS7
	9dDU/Lxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFWB2-00000007jPw-2vYb;
	Mon, 25 Nov 2024 10:18:44 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFW13-00000007gGR-3Z0o
	for kexec@bombadil.infradead.org;
	Mon, 25 Nov 2024 10:08:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=n1NxLTesaxf1CmVmrYGt0DtpmfeNYvqyA55PeXFrYQI=; b=p3ySAKarVWgraIsayXyhAQoqLI
	HYTTmQfTwkADOlKLXFpvV4IhjIzTGqFWJWZNwiyYC5jbhzmKYpNacItSDP2+QIXE4QHHr/dEGuNhM
	xKGlM+v3QAPrXrGlgPh1C/6UBt8h1U5FzQHJxoV6yHOT+oDVR3Axywb1nndgcIFArf7UXgs2bJpoa
	KeWaqhMemP3gNKrAupjra4iQcbYb3ug8wwMzvGCY5nKFS5HLl5ATi8aPjA4gH2mJofMMEbWfZpZzF
	S0D4x9c82M6RZExcTz8lbNN+XU8ZcKK6eIUsnLDDsnGXnUdpSn6KvHsIfHswDbgIhiF0qowbDYnpx
	d6AcmsQA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFW12-000000014f9-16Iq;
	Mon, 25 Nov 2024 10:08:24 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFW0z-000000000lb-3cMg;
	Mon, 25 Nov 2024 10:08:21 +0000
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
Subject: [RFC PATCH v3 15/20] x86/kexec: Add CONFIG_KEXEC_DEBUG option
Date: Mon, 25 Nov 2024 09:54:45 +0000
Message-ID: <20241125100815.2512-16-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125100815.2512-1-dwmw2@infradead.org>
References: <20241125100815.2512-1-dwmw2@infradead.org>
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


