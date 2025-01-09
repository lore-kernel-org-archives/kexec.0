Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F6EE7719D
	for <kexec@archiver.kernel.org>; Thu,  9 Jan 2025 14:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=h57faAuSzAxCss48S50xg8gyErd3bJ9VneT8C0mRQ4E=; b=OKsVmk4I7F4n7wFfkimpWThxEB
	GRLgmyC42ryLIL8KslbuvtgBydD3/uJ0qYHKoCgpKEL7jT9H3lOXtHSh7q8bLAW+HVT/ah2ak9VkF
	MOtH3ryStUI6blOEEZp5wmUYRwnzixSFNDzNwu69dfZwxPn4XGzYoQg5A2z5aFdxVmV2YBq12tB8T
	PscGMnrcu/kF1+Jkc6fYNGFRPuddzU/8AV+V9Azg9Vla5ra7VO+y1IyeRAbpOLJxGiZjBsMFnNedQ
	ahRVG/WHZgoSVmjMbxRFCJl1tsc7LNOs28Q6jcyEyF7i45LxLrzv9OUhaEqwZiC2TtZrFjD54kpxS
	DD5jxBlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVtDw-0000000CB57-1p2W;
	Thu, 09 Jan 2025 14:09:24 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVtCh-0000000CAfV-15Bk
	for kexec@bombadil.infradead.org;
	Thu, 09 Jan 2025 14:08:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=h57faAuSzAxCss48S50xg8gyErd3bJ9VneT8C0mRQ4E=; b=pzgG0B5egMmevfyW9B7KzovKlY
	nDiT/uE4u35xPzfDnqp3dF+4gd8pryKZxPd/BgDCP18nxRlJSNRMp0SAaO+buL2yWH5YakeG3nIdi
	0b/mB/7nLzSx27mvTezJ66rkrUzsqi7alw4rCF/qkLPJf84O+Q2AyetJEZKwsFu2gRYLvpka/QP2u
	UQxvQM81TOroDTE6pPVXhdn+T0jd+AH+IOhlWdGBZLNz4ZiGpUeI9opUk0Teco9Bk3ZXvDwPdADfB
	3gLC8rbpHnoccsvLu/mxvoQ05la17BCQycP5orUIFyccLo5mFkgNZ0VpQq171P28vtHHzwiUXnms7
	NnFJmP5Q==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tVtCa-00000009Zhe-3Db8;
	Thu, 09 Jan 2025 14:08:01 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tVtCY-0000000Bx5j-1vs9;
	Thu, 09 Jan 2025 14:07:58 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Yuntao Wang <ytcoode@gmail.com>,
	David Kaplan <david.kaplan@amd.com>,
	Tao Liu <ltao@redhat.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Rong Xu <xur@google.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	bsz@amazon.de,
	nathan@kernel.org
Subject: [PATCH v2 0/9] x86/kexec: Fixes for tip/x86/boot
Date: Thu,  9 Jan 2025 14:04:12 +0000
Message-ID: <20250109140757.2841269-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Fix a few bugs introduced by the recent rework of the relocate_kernel()
code, and one which has been there in the kjump code from the beginning.

 • Global read-only TLB entries made relocate_kernel() crash when writing
   to its own page after the %cr3 switch should have made it writeable.
 • The preserve_context flag was lost when invoking swap_pages on the way
   back, causing pages not to be swapped.
 • The wrong page was being used as the swap page.
 • The ABI for the kjump call asks the callee to put its entry address for
   next time at %rsp+8 before returning, but we set %rsp to the top of the
   available page, such that the entry address is at the start of some
   other page.
 • The relocate_kernel() function lacked Clang CFI information, but is now
   called via a function pointer, leading to a crash¹.
 • The relocate_kernel() code and data could end up being linked into the
   wrong place for a LTO / -ffunction-sections build.

Thanks to Nathan for reporting many of the above.

Also a few minor cleanups, including a comments-only patch from Rafael
on the suspend-like part of kjump as a prelude to actually cleaning that
up.

¹ Fixed by just adding __nocfi. Actually providing the CFI information
for relocate_kernel() will need a bit more work, so let's just do the
simple fix for now.

 v2:
 • Rebase
 • Save a whole byte on a 'movq $1, %r11' instruction.
 • Fix duplicated word in comment.
 • Avoid absolute relocations against __relocate_kernel_start

David Woodhouse (7):
      x86/kexec: Disable global pages before writing to control page
      x86/kexec: Ensure preserve_context flag is set on return to kernel
      x86/kexec: Use correct swap page in swap_pages function
      x86/kexec: Fix stack and handling of re-entry point for ::preserve_context
      x86/kexec: Mark machine_kexec() with __nocfi
      x86/kexec: Cope with relocate_kernel() not being at the start of the page
      x86/kexec: Use typedef for relocate_kernel_fn function prototype

Nathan Chancellor (1):
      x86/kexec: Fix location of relocate_kernel with -ffunction-sections

Rafael J. Wysocki (1):
      kexec_core: Add and update comments regarding the KEXEC_JUMP flow

 arch/x86/include/asm/kexec.h         | 26 ++++++++--------
 arch/x86/kernel/machine_kexec_32.c   |  7 +----
 arch/x86/kernel/machine_kexec_64.c   |  8 ++---
 arch/x86/kernel/relocate_kernel_64.S | 57 ++++++++++++++++++++++++------------
 arch/x86/kernel/vmlinux.lds.S        |  4 +--
 kernel/kexec_core.c                  | 23 +++++++++++----
 6 files changed, 74 insertions(+), 51 deletions(-)



