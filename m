Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66FDEB4904
	for <kexec@archiver.kernel.org>; Thu, 12 Feb 2026 11:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TZclJqzGvqfgYgzuUOZlJDMXe+pR9LdrFyA+dktDiAc=; b=o/uFhff0djLalaa2DlY02Nqk3Z
	sfbXAvSXEagzC1dVksb8Uv1ZKb6lHNzLx+XiEbdx2ovceeUnE89ELd+TaziiLIIWw3OA7GipzU9iS
	O2c4vv6AOtThBYq6uvxsSD7HkaRKQwXcKoUNbCcIiLbTM/VqVGZ+aOUbKCna2MJd0dVmdWscWtvRF
	ecVa3Stehw8GzU66fxWdoROd1dFJCuOnkhDcGvL+PAZKxbVw7BMcjXntvCehiwASPlG5LJKEpVMfK
	35ncaHExOLpk4owLSMcwu3NCZIyRDve67NbksyvSe9MY6lur4FWOOIN9nnR0ryXAOoXWwMtlg3pOy
	BKw/+zrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqUcs-00000001yaZ-3VHL;
	Thu, 12 Feb 2026 11:12:50 +0000
Received: from m16.mail.163.com ([220.197.31.4])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqUcq-00000001yZm-0Iy0
	for kexec@lists.infradead.org;
	Thu, 12 Feb 2026 11:12:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=TZ
	clJqzGvqfgYgzuUOZlJDMXe+pR9LdrFyA+dktDiAc=; b=mqpPnjefSRBRJvFvQO
	sNaSMHpziZbsP/fk1cSv7Jwxyoui8d9CYPKBwA7e+2b93epwJ6PZ5HW1s81bEzj6
	MSLf+WxsToyix5Zd7HeUws++hsvIvdZFBIaS2vxq4RuMtbcNNxQrqsXPdvZgvnxR
	2QdAcVcEC9I7SalWJy8MJwSA0=
Received: from ubuntu24-z.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCHZLl0tY1ptkijLg--.48890S2;
	Thu, 12 Feb 2026 19:11:50 +0800 (CST)
From: ranxiaokai627@163.com
To: graf@amazon.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	akpm@linux-foundation.org
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ran.xiaokai@zte.com.cn,
	ranxiaokai627@163.com
Subject: [PATCH v3 0/2] two fixes in kho_populate()
Date: Thu, 12 Feb 2026 11:11:44 +0000
Message-ID: <20260212111146.210086-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCHZLl0tY1ptkijLg--.48890S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4R3KsbUUUUU
X-Originating-IP: [218.203.227.87]
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbCxRZIlGmNtXaS0gAA3o
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260212_031248_749974_ADA08EA1 
X-CRM114-Status: UNSURE (   5.07  )
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

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

Patch1 fixes unpaired call of early_memmap()/early_memunmap()
Patch2 cleans up unnecessary call of WARN_ON()

v3
 - rename all the labels suggested by Pratyush

v2
 - Improve code readability suggested by Pratyush
 - collect reviewed-by
 
Ran Xiaokai (2):
  kho: fix missing early_memunmap() call in kho_populate()
  kho: remove unnecessary WARN_ON(err) in kho_populate()

 kernel/liveupdate/kexec_handover.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

-- 
2.25.1



