Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE59EB4904
	for <kexec@archiver.kernel.org>; Thu, 12 Feb 2026 11:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n+rpPjxDD+Z5fIPDrZeUxPDcng3MFwzbjG+nEfu3iEU=; b=emA5/vdRKhhSOtbaU3yNh/4KdE
	AAUqHmLU/NH9aUvFw2n9Wuui07r61+F3QFo38lr4N632TS+qQabdniexa7unj52V+wCT7DwIUvZ7S
	BJjCzHHzl/SGxODQaMWaUISTsQTOkXkkoA4EYJHayNameAwcazQmpw3asw54dX+euSZeAWMfxyWv5
	fnYbLDmH6KubCaIoqiGyRr0+Oiofl3O9ulscNQLvO4MPZbH3khPA8yqkFmCghtPLaUbg2iUOYVoIa
	32qKiH6Gv3TYXQybs1VDk+XKCWvBrrTi1OtYNW1sorSKoSdrTkir0kMuw27ZtD+2PsOhylnKSh19E
	4SEUNzdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqUcw-00000001ycD-1ODW;
	Thu, 12 Feb 2026 11:12:54 +0000
Received: from m16.mail.163.com ([220.197.31.3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqUcu-00000001yag-1vSf
	for kexec@lists.infradead.org;
	Thu, 12 Feb 2026 11:12:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=n+
	rpPjxDD+Z5fIPDrZeUxPDcng3MFwzbjG+nEfu3iEU=; b=FVCG87nMyScfOr2n5l
	gVJn1xmndnPEpSJOd1HeBD+VoNDjwqFhPuIiZs02qMOAur+ctfVt2Di422iUdDMf
	acEY50DaM1RBFpPWIZj4G1ixY6QE4YGIgJnl42SgEhGOziay12m+KwPV4JWbCSJZ
	XyIDiF6ryBnXOyP1cbIXHzMFk=
Received: from ubuntu24-z.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCHZLl0tY1ptkijLg--.48890S4;
	Thu, 12 Feb 2026 19:11:53 +0800 (CST)
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
Subject: [PATCH v3 2/2] kho: remove unnecessary WARN_ON(err) in kho_populate()
Date: Thu, 12 Feb 2026 11:11:46 +0000
Message-ID: <20260212111146.210086-3-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260212111146.210086-1-ranxiaokai627@163.com>
References: <20260212111146.210086-1-ranxiaokai627@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCHZLl0tY1ptkijLg--.48890S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw1xXw17Cw4DGFW8XF4Dtwb_yoWDKrc_WF
	4xtw1vkr4qvrn0vr1Yk39avFWrKw40qFyqv3W3JFyxt3W5tayj9a9xZr4DAFnxW34vkryD
	Arn0grZ8tr4fWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRAJ5rDUUUUU==
X-Originating-IP: [218.203.227.87]
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbC7RlJlWmNtXkzNQAA3G
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260212_031252_807134_21A00B26 
X-CRM114-Status: UNSURE (   8.94  )
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

The following pr_warn() provides detailed error and location
information, WARN_ON(err) adds no additional debugging value,
so remove the redundant WARN_ON() call.

Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/kexec_handover.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index af82d8862dd7..95601623b4d6 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1507,7 +1507,7 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 
 		memblock_add(area->addr, size);
 		err = memblock_mark_kho_scratch(area->addr, size);
-		if (WARN_ON(err)) {
+		if (err) {
 			pr_warn("failed to mark the scratch region 0x%pa+0x%pa: %pe",
 				&area->addr, &size, ERR_PTR(err));
 			goto unmap_scratch;
-- 
2.25.1



