Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B0A6E6ADD4
	for <kexec@archiver.kernel.org>; Fri, 22 Nov 2024 22:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qYFRgzDbimC0blaDJOJhby5s1NuEeujIYbn61y3E6GM=; b=1DHWM3wPpC0iuSe5j8WEkcFqL5
	PGBNGLOlSf8OI2nZdjYxTOJalqxxBpt1kgxJt1yjZc29UR0wfyYQmVQ1pl0tgmUyGXO83aSDc8e3A
	oiNWQGMdKr9EasL0bOQyXNK3O3prlCbzGwbUVW5imySt59T7Usp8uvnVY1ENppzz4/7jzlyN11cu9
	R/wF2YZ3Yz7sjke5hBePhJcVcW0O657xyeo/zZkTHMOTbpH+crOA9Z7Myq2WSfAfey2/vGiku9CSU
	rvixPY/vrsFIfhqhAQzHVARFShSJov/57wKze7ZbTaQLmdUGehmesLCp8ancrSPgEix/g1riVv34b
	zmGfON/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQz-00000003RNz-1VyI;
	Fri, 22 Nov 2024 22:47:29 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQv-00000003RKv-49nM
	for kexec@bombadil.infradead.org;
	Fri, 22 Nov 2024 22:47:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=qYFRgzDbimC0blaDJOJhby5s1NuEeujIYbn61y3E6GM=; b=VtJlafzsjOxL1ciibmV+zNF2mD
	jJmOJnM3bMCLXyECAn33h6KmC7anHGDQhnxf54de4TgaQdixwGqRfU5m08YsRuxiONe/8qUh7NQG3
	UUf+PVyb72aQW/l0c2+SfQreYi3jdmOrvLfINByqdzBzoqDXCrb9ezQQ6XlXPOlUivXD+13GDPDno
	DAUDeMuOYkyLG9GbdoQMlSMT5ejfxUOnmqIMMFTd+qcfGhZPgqIXu4hGWsFShlV3KVLkc9IWs2F3j
	GCEY9Rk7VTcQu1Uvv5Nnw8Eia1VP1DQipm1DJrKCkn+W7Djc6qw15WQgeMtielY3kqspM4AAwu+IW
	kq/Dek2g==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQs-00000000ma4-00Xq;
	Fri, 22 Nov 2024 22:47:22 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQp-00000000iiO-0jy2;
	Fri, 22 Nov 2024 22:47:19 +0000
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
Subject: [RFC PATCH v2 08/16] x86/kexec: Copy control page into place in machine_kexec_prepare()
Date: Fri, 22 Nov 2024 22:38:17 +0000
Message-ID: <20241122224715.171751-9-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122224715.171751-1-dwmw2@infradead.org>
References: <20241122224715.171751-1-dwmw2@infradead.org>
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

There's no need for this to wait until the actual machine_kexec() invocation;
a subsequent change will mark the control page ROX so all writes should be
completed earlier.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/machine_kexec_64.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 123e9544506b..60632a5a2a13 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -297,6 +297,8 @@ static void load_segments(void)
 int machine_kexec_prepare(struct kimage *image)
 {
 	void *control_page = page_address(image->control_code_page) + PAGE_SIZE;
+	unsigned long reloc_start = (unsigned long)__relocate_kernel_start;
+	unsigned long reloc_end = (unsigned long)__relocate_kernel_end;
 	unsigned long start_pgtable;
 	int result;
 
@@ -308,6 +310,8 @@ int machine_kexec_prepare(struct kimage *image)
 	if (result)
 		return result;
 
+	__memcpy(control_page, __relocate_kernel_start, reloc_end - reloc_start);
+
 	set_memory_x((unsigned long)control_page, 1);
 
 	return 0;
@@ -334,7 +338,6 @@ void machine_kexec(struct kimage *image)
 					     unsigned int preserve_context,
 					     unsigned int host_mem_enc_active);
 	unsigned long reloc_start = (unsigned long)__relocate_kernel_start;
-	unsigned long reloc_end = (unsigned long)__relocate_kernel_end;
 	unsigned long page_list[PAGES_NR];
 	unsigned int host_mem_enc_active;
 	int save_ftrace_enabled;
@@ -372,7 +375,6 @@ void machine_kexec(struct kimage *image)
 	}
 
 	control_page = page_address(image->control_code_page) + PAGE_SIZE;
-	__memcpy(control_page, __relocate_kernel_start, reloc_end - reloc_start);
 
 	page_list[PA_CONTROL_PAGE] = virt_to_phys(control_page);
 	page_list[VA_CONTROL_PAGE] = (unsigned long)control_page;
-- 
2.47.0


