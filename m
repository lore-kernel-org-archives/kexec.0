Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED142CD98E4
	for <kexec@archiver.kernel.org>; Wed, 17 Jun 2026 13:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=EEC0qJTG8OKSyQhpTsBvNB9fPeFKMLfq9Aho3jBcd6E=; b=ScyNuFDP7oN3sW
	WGfh1Vg9oDvuE69fQ/OvM1poEe+hpIYiiSK1p7Qi/DzdG5IwtVZ0Rx9qSK1Lh8+vanW+sRRcPjG74
	n9GCs8WDg2lmsF71llpt3OfDj/E5mye9kckY6Htxe7efKzXc6u2DEvwoU+8TzLMiVjoZNCHHL8JPX
	13wj5uJVCadeLr5aTMRX4/WkE7rcjRCSpN/AI1+iDenuxRS893M3LF37vqinUaGlL1UTJSEEOOC7L
	PwhOn2N0SNVYbAHisz36ROzn/Iy+vb0Hnmb7pj2+KdhKWOaDzT+bIKjVlU4oYEfcRQFdjtty4F5Nm
	vNP7vBpdaAmmYG+Y9xKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZqPG-0000000HQ5D-3csL;
	Wed, 17 Jun 2026 13:34:14 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZqPA-0000000HQ4C-3WTM
	for kexec@lists.infradead.org;
	Wed, 17 Jun 2026 13:34:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=EEC0qJTG8OKSyQhpTsBvNB9fPeFKMLfq9Aho3jBcd6E=; b=X79EW50QThJuRBql8sQN8YZJ2H
	98AcES0FPmYRrraxKzT4B5jkqGVZGJjB0Vem/XnDD76WiFqGXJhNK/6PUYmk5IRVYsPAYn+BN08Bu
	nQmyK67OcbQnzIvePlH/65Ed1Y86u4imScirUM1DzgK8GwyH2GMy3u2Zn4Ze6id2xBvNBVpNTAFbb
	vb49+Qi1f/K72rtKB0OyeKHbWlvjpKe43/dZwpBjoeceNxZIbV521zUH7VH2l6ugcCE8cIj4TORpK
	vet7YpKbaHro5ejhLxWzeyd0ZN6WKXq+Jd/6+2y6sOPJcW00nDStjBUZykKlsBMD1QLDwuI6RJU8y
	YSPsncYg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wZqOZ-00EeV7-1K;
	Wed, 17 Jun 2026 13:33:32 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH 0/2] vmcoreinfo: GHES: track fatal hardware errors
Date: Wed, 17 Jun 2026 06:32:46 -0700
Message-Id: <20260617-hwerr-v1-0-ff131cd6203c@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP6hMmoC/x3MQQqAIBAF0KsMf62QQhpeJVpITjmbihEqiO4e9
 A7wHjRW4YZED5RPabJvSOQMYa55W9lKQSL4zocuuGjrxao2+6H0JYTMQ4QhHMqL3P8zTu/7AZB
 4XRBXAAAA
X-Change-ID: 20260617-hwerr-a28d5d66ae87
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
 Hanjun Guo <guohanjun@huawei.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Dave Young <ruirui.yang@linux.dev>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 riel@surriel.com, caggio@meta.com, kexec@lists.infradead.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=897; i=leitao@debian.org;
 h=from:subject:message-id; bh=4YrNXDncXnmKl+A8s140VbYwKQUDIRjgWGDf6s/6fk4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqMqIkPriB/CZVfySHbrrGgN3toy1kx5+6UP9Cr
 r+0mhO81bOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCajKiJAAKCRA1o5Of/Hh3
 bRGuEACowDrZxGFVCCGdYvWi67J+RKoA46lnaXuiZveyNlTjvUK4ac5KK/6XWnwTf7IxaNUVZ00
 rfodx3caH3nIQplfmvoyFtqX6ufeGoGFzNCfppP0X1MIm0q0I5K1Dcl8gPWTXgpm4JkkZzOCUsP
 T+bMVFmr8XV0uk4k8ccFRVMJBuSMZ8v4VOQi9ei60CtVaFWh3R6LyfJW8CHSeuhvHr7BGG7aZgH
 Kr53FX2fIUmtXhTaoN5A+Sad1/tNB4qH0Rg0XQUKY6/a7ahk4YlZvJKZ1G2oeMvTSzjhTyb8NVq
 MVPE5n2SHv1EuO242m9ijL1tBtWqSI1X3DAmzzjUhE6gW7uc7HPoxBH1sJ1lzQN8q4YGy7ZnIAT
 YmXB1J0+rZVUuuvEqRUzDDOtvQP3sccqvnZXoOO+vlllTpZ1KLQ/uKkRgCunfKnwwl9FgsK3Eg5
 ulJ740rWKgfrq9W/s3Mr6wwPp5wqyTRcDsJjQAKBdy+pFfBILlxBoN++eTGorjxpiUIDgq9igJP
 +7LG5o2QpXy4PhEX0zqP7W6mK08qjiyiFplElUm+Xg5z3QLnkK1DnC+RPbnTk3tsfcgeBWc5e7y
 szvZQkseCF5I0ZQvvR7m9bK6aoBlOCAW/wGra0uRWXlvWd7Cts+9XRho1att4kNnTURoW1ET2y1
 NGBU+0Bc+Ap73rw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260617_063408_892707_629E0517 
X-CRM114-Status: UNSURE (   7.74  )
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

Hardware errors reported through APEI/GHES are recorded in the kernel's
hwerr_data array so that crash tooling can tell from the vmcore whether a
hardware error preceded a crash.

This short series improves that path:

 * The first patch is just a fix.
 * The second adds a HWERR_FATAL bucket that records panic-severity
   errors -- the ones most likely to have caused the crash -- when GHES
   reports them.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (2):
      ACPI: APEI: GHES: fix severity namespace in ghes_log_hwerr()
      vmcore_info: track fatal hardware errors

 drivers/acpi/apei/ghes.c    | 7 ++++++-
 include/uapi/linux/vmcore.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)
---
base-commit: 4fa3f5fabb30bf00d7475d5a33459ea83d639bf9
change-id: 20260617-hwerr-a28d5d66ae87

Best regards,
-- 
Breno Leitao <leitao@debian.org>


