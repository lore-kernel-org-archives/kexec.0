Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CC4D6D229
	for <kexec@archiver.kernel.org>; Wed, 27 Nov 2024 19:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r3AYqthkhqE/hpsX8OlsrIm8YbRRATEjfUq8IVBi2fg=; b=YLtchR0D3rHyRzEEJM+9uWXZDP
	V/uuDBfgw+K6wSfEmHPP4Hf1fIdO7/zzk/vg/7MdvGTfHptzX16u4vewPzLqHUmMn+goMgSf2po+S
	Wo6ydRWlDjrIuRa2R6F0rvmAkQO7ckuuUD1CVuQelLQUbWokDskIaBl1eouQWmgn32lLHtPdVqCa3
	OUW1DsBMPKHHjhHdwdgBde14VpFZBTU0QrwhhHpvstGidOyoD7Y9ARh6SBeJSVsyD1DFsyAlnJlin
	3akcNGd+fTwwvL3PrCTLcXu+d8Run1/U7iK+9YbiDUCpQ7FzZvA6EnWa49ipM604BUN779xoi9RzT
	g9597zGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGNKN-0000000Dt6M-25i2;
	Wed, 27 Nov 2024 19:03:55 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGNKJ-0000000Dt0w-33qP
	for kexec@bombadil.infradead.org;
	Wed, 27 Nov 2024 19:03:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=r3AYqthkhqE/hpsX8OlsrIm8YbRRATEjfUq8IVBi2fg=; b=c6yI3hXuTHaVrvxd1yVnHBVNij
	96A37jM/iCQUDKVKAlMQN8W8+Yr5+O/MCkQEvvGDHyzlceX95tnVQ54UTGjTo95FsiCzt8tHlqxjc
	c7qG6T1XRoLA4sUABomX1yNBJDmi7TQO5p1nmcSXdtWaeC40ulDx7Om9isCCmryt1PDt9CFinKN6D
	unqbwGZsLVdRZlU1D5ss+qnhvrbroS/4iJgXIL6lrH23QI6ZibbR1wH16QYsNmVFcgNrYbypb3sVK
	etkrF/ftkKgYc/ACKnfRrGfJFJ1B6aUf/mUu/cX/rfcI0BSjIRQHATtN5B0LP33wtqiSTfY2TMOKx
	wN42K1VA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGNKF-00000001Sul-17l5;
	Wed, 27 Nov 2024 19:03:47 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGNKE-00000000BjT-3JcL;
	Wed, 27 Nov 2024 19:03:46 +0000
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
Subject: [RFC PATCH v4 20/20] [DO NOT MERGE] x86/kexec: Add int3 in kexec path for testing
Date: Wed, 27 Nov 2024 19:00:34 +0000
Message-ID: <20241127190343.44916-21-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241127190343.44916-1-dwmw2@infradead.org>
References: <20241127190343.44916-1-dwmw2@infradead.org>
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


