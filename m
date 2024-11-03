Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E820EE6749D
	for <kexec@archiver.kernel.org>; Sun,  3 Nov 2024 05:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=bbxK2bNyaBR5rGn/m+7uzQXh2yd4c4Fr6ESPsa9w07g=; b=QCbLvHwWkZY29O
	SbzkXcNdnE12Ay3o9SaZaIk0/jbxP1e/nRAANodEzbB7LyuSkZg2F8MUJiMfFe7AZDpGHkqPbYeMV
	kAcTuT9owj/1qZBFIsy/BQP8kmvyAlvRR+v5CHDVQ21Q0PaFrfhLp/NPoqAVdmI6DTclZ/ao7XdZM
	jZ+AF6ivAttYfafWE8zJZ9posWmAtSQco7frN0et9godM1SG+x1t6jHPm/FqC0A7eCX4fHCs33XsB
	uUlSocdc9mgZfAeAcF1xVpacmyihw7lv496ppCalZJpOdswtXLPGakf68zvMCi/nLyhBc5OXcQW7i
	d3v3O9kJr+hvpAymVTJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7TLm-0000000AzXj-2atA;
	Sun, 03 Nov 2024 05:40:34 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7TLl-0000000AzWt-0jEm
	for kexec@bombadil.infradead.org;
	Sun, 03 Nov 2024 05:40:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=00LBfdePtVjoMz5Goiqj3TfM6d1ERcfKYUF+vI7ZIfk=; b=ZhOnLPscHbI4A3YfoBJDDqT7L5
	LiKex09k9Y8n51FyefJ4Wh87pP9OJJVORyZW3FPqmqttlNCZc44eKYAgpC0lf6ZTwyOUfWlEGc27c
	1x0vrOfb2MOOAuqh7/9x8cgOd5GpYbjMVP0QNuTc9oqQM4Tvagkpwj+hzr61o84NLVtvsTR+YykFT
	CCioXSDzqcEdqhLp6G1DUHnTRxaNFF61Lp8DKrYTclRGFlQ1hKyuk+50C8lAqvmotZVSZMsCvKh6D
	LcPGX4VuTZviCLqEQw4mzBn4HbD6uToP8v7/onJ9Fqh65abb7vlZRLSj/GYw9w9GmmW8bGaiKDNhA
	/h8dAFsQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7TLb-0000000B4NT-41Fo;
	Sun, 03 Nov 2024 05:40:28 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1t7TLa-0000000FvL6-2v0A;
	Sun, 03 Nov 2024 05:40:22 +0000
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
	Simon Horman <horms@kernel.org>
Subject: [RFC PATCH 0/7] x86/kexec: Add exception handling for relocate_kernel
Date: Sun,  3 Nov 2024 05:35:25 +0000
Message-ID: <20241103054019.3795299-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Page faults in relocate_kernel() are extremely painful to debug. Provide a
basic exception handler which will just dump the exception information and
registers to a serial port.

It's disabled by default and has to be enabled with #define DEBUG.

While I was at it, I also stopped swap_pages from actually swapping pages
in the case of a plain kexec without preserve_context. Unless I'm missing
something, that's just a pointless waste of time.

David Woodhouse (7):
      x86/kexec: Clean up and document register use in relocate_kernel_64.S
      x86/kexec: Use named labels in swap_pages in relocate_kernel_64.S
      x86/kexec: Only swap pages for preserve_context mode
      x86/kexec: Debugging support: load a GDT
      x86/kexec: Debugging support: Load an IDT and basic exception entry points
      x86/kexec: Debugging support: Dump registers on exception

 arch/x86/kernel/relocate_kernel_64.S | 265 ++++++++++++++++++++++++++++++++---
 1 file changed, 246 insertions(+), 19 deletions(-)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
