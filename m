Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D4FE9129F
	for <kexec@archiver.kernel.org>; Fri,  6 Feb 2026 04:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=p5g6IpqTgwpM4i/ryonxaLfvkbirbYDZGuESb01JV4s=; b=DgMO8Gd96Oz67fjpKahzJxCyp7
	cI/rZ6Nb1kj6kSwtD2iT5I6chs8Hq9h7URQLQfUlU4THWKKiMPy8uUrEr10jzkHOBcFWp5E4ckhpA
	DjAKOTEQKPoM3Ar0JE+gb7DKI/EoGLC4gIqGqrdhLVn1ODvqHMeUvfOWnLn3hXxHRGOWiQx6bUOsw
	yx+sotGfkMStBlTNrRnV0vFi0qrhOBuS+fNEdmGdQW4Fa/brUoiOfjLRCfk7pKD3sChiAd/vsnVH1
	/xk+y5i5r8cITZWoaNOdr4hVK95BJPy5yCat4TF1+XTXuNkXG4k3l2LXtRSNnQEKULrHPTUq2YLWL
	893EPRSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voDVb-0000000AquP-2czd;
	Fri, 06 Feb 2026 04:31:55 +0000
Received: from m16.mail.163.com ([220.197.31.4])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voDVY-0000000Aqtj-1E2w
	for kexec@lists.infradead.org;
	Fri, 06 Feb 2026 04:31:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=p5
	g6IpqTgwpM4i/ryonxaLfvkbirbYDZGuESb01JV4s=; b=emJrfbxG1koGmgJPUZ
	o+srUSmbV47kHC0YLIkT1S4RPwS5fTS1qVLPGEU44q8wtCAa0ibiZ5BSwFvu6l3B
	OjuNQJN//qiUHlnSJ0wy8T9Y8TLcww7OZ5ufeD/u40gptVl77I/cHqfY7I3dWRxa
	vRGuYo3PWFQBg5blR+QTfmVw0=
Received: from ubuntu24-z.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgC3sLWbboVpASh5QQ--.27597S2;
	Fri, 06 Feb 2026 12:31:24 +0800 (CST)
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
Subject: [PATCH -next 0/2] two fixes in kho_populate()
Date: Fri,  6 Feb 2026 04:31:19 +0000
Message-ID: <20260206043121.197564-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PSgvCgC3sLWbboVpASh5QQ--.27597S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RfpndDUUUU
X-Originating-IP: [117.176.242.230]
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbCxhx+ymmFbpx-RAAA3L
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260205_203152_670782_18829BAF 
X-CRM114-Status: UNSURE (   4.08  )
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

Ran Xiaokai (2):
  kho: fix missing early_memunmap() call in kho_populate()
  kho: remove unnecessary WARN_ON(err) in kho_populate()

 kernel/liveupdate/kexec_handover.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
2.25.1



