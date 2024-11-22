Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07264E6ADCA
	for <kexec@archiver.kernel.org>; Fri, 22 Nov 2024 22:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YMX4hA6TET2DRs4mytpddGAuD8BkAw4cael/oyJ3CzM=; b=BGeBBvx3BoWfL/xpo/83kCA9m2
	U53armL9VyahYD53pyCZYSmXRL8oJucfEfa3PxoFBU1zolfLWEqj/iKmAEPIVsDnrhC99/DMWtsa8
	RUXsLTBkPLo0UT7fFzjJ4K/SS1dEmqI9QILiUuc0LvL6Xwn/IgywxQvR80ZiV6zuhzNQ9PK5HVa58
	m5C8eEPS9FDppAB6X3VUy3LrscFK1S+UGd77kuYr29DNDoZmgFlMa8UiwsB6oIElhMQOXIIxJ+ILG
	8w8GaEl9v53P7oGv7VsCsaTdJCpyKsafFZCKIOLXoQuFXQ1cbnj5Ui+/UgN5xepiIzPjPn5Oy408v
	KoKijnNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQx-00000003RMN-2l03;
	Fri, 22 Nov 2024 22:47:27 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQu-00000003RKP-3VH4
	for kexec@bombadil.infradead.org;
	Fri, 22 Nov 2024 22:47:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=YMX4hA6TET2DRs4mytpddGAuD8BkAw4cael/oyJ3CzM=; b=j5eGqunufmPhasYy2LK3CUUVYV
	FMuL2WPvLJfDxgVpWHdc6ZNz9HzCGNJ6GJ7aIvw7CZYCEF6EMCdja/ezLz4UbLm5d/bGjiH9QPWym
	ie+6CZewJaSFrjYaDhevFCk6HQqdjZ40crIiHTKq5x4AYfW/kWIqONSXADQ3yM7eJfe0qexsDRYnS
	DXML8O7v6WHh7lwwylGeWvWpjcpFLil0W8/i1fvWCnJbjK2/JLk00Ob+3cNwq44+KLoZ7PYoylsk+
	GY9n4kJG71+jK2U+4P+UFEqPxo3dnJZalAzXi/eSb0BgnExDBkc9lK3nub4xKvJqqu4+lKNO+AD1A
	wCzb0c6A==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQp-00000008PHT-2E7k;
	Fri, 22 Nov 2024 22:47:21 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQo-00000000ii9-3zyd;
	Fri, 22 Nov 2024 22:47:18 +0000
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
	jpoimboe@kernel.org
Subject: [RFC PATCH v2 03/16] x86/kexec: Restore GDT on return from preserve_context kexec
Date: Fri, 22 Nov 2024 22:38:12 +0000
Message-ID: <20241122224715.171751-4-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122224715.171751-1-dwmw2@infradead.org>
References: <20241122224715.171751-1-dwmw2@infradead.org>
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

The restore_processor_state() function explicitly states that "the asm code
that gets us here will have restored a usable GDT". That wasn't true in the
case of returning from a preserve_context kexec. Make it so.

Without this, the kernel was depending on the called function to reload an
appropriate GDT.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index ca01e3e2f097..ed2ae50535dd 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -252,6 +252,11 @@ SYM_CODE_START_LOCAL_NOALIGN(virtual_mapped)
 	movq	CR0(%r8), %r8
 	movq	%rax, %cr3
 	movq	%r8, %cr0
+
+	/* Saved in save_processor_state. */
+	movq    $saved_context, %rax
+	lgdt    saved_context_gdt_desc(%rax)
+
 	movq	%rbp, %rax
 
 	popf
-- 
2.47.0


