Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC73D3B7F5
	for <kexec@archiver.kernel.org>; Mon, 25 Nov 2024 10:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r3AYqthkhqE/hpsX8OlsrIm8YbRRATEjfUq8IVBi2fg=; b=1zONmVlqy8O/rtvB0L4rIlVNIb
	o9TX2r02AKQ6ry7cbbTIP9pDXoUDg6HBYWKpHc6EzK6nxcvlm5cT7WkilSji2YYwz2FaGqMWkUaiR
	zq4ft350ytfdStVDX3yvoHq9sdS8etFUw05Vn8gpVnpfQDOJVMMSHlTNJ09yRR1DY8g+VKEYE4oYX
	U+UO7kouFo9EGfDts3ywknn/+Fh3rc/ooXbrLS/5XeoC1FFjSRxt4P65LGSTfezfeG7QLnPkQKZD9
	mxuw7zj5h1bKVBLE0115BEMYgBVTq2xOuFkEbni2NS94/6lqyIfHIXtrMZNPRG7R9s2MDe1Gng+hT
	HcRMnFZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFWAY-00000007ipJ-2HGD;
	Mon, 25 Nov 2024 10:18:17 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFW13-00000007gFg-0ter
	for kexec@bombadil.infradead.org;
	Mon, 25 Nov 2024 10:08:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=r3AYqthkhqE/hpsX8OlsrIm8YbRRATEjfUq8IVBi2fg=; b=cPlbXt7MbojLCgi1HbmHUMywkZ
	3Ztr2vZMbMv2CFzcQM/SHPFZpmIpix45Axf71F1GrtnJdWikBoKh/4DdP5hn1BUC9o/xDZEy5wHy3
	cQmK01O9+VKebcksC3HM5ogvJSP2/LI74A6d0/+Ieq98/RjNk9zs/DnCx1Niz3sblnC3yZrpfx+Z/
	49ahvOr4LKTMqSJL2pZY/N9Xee9CDXS0PxORAwd8igspeHSjVRkv0DURK7bRvPQfwAgzSdIxtr8CT
	SIaHLC714fka487MdpZMMqD2t1tEwx776SXU+1nkKrnmoI+rnt7ra539WkUOoUA049x1Kg8KZNYei
	jBNZtYnA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFW10-0000000BirD-1GZt;
	Mon, 25 Nov 2024 10:08:23 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFW10-000000000lu-0KC1;
	Mon, 25 Nov 2024 10:08:22 +0000
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
Subject: [RFC PATCH v3 20/20] [DO NOT MERGE] x86/kexec: Add int3 in kexec path for testing
Date: Mon, 25 Nov 2024 09:54:50 +0000
Message-ID: <20241125100815.2512-21-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125100815.2512-1-dwmw2@infradead.org>
References: <20241125100815.2512-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
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

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 01a31e4a0664..ff8a813a9f9b 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -152,7 +152,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	lidt	(%rsp)
 	addq	$10, %rsp
 
-	//int3
+	int3
 #endif /* CONFIG_KEXEC_DEBUG */
 
 	/*
-- 
2.47.0


