Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1376EB595E
	for <kexec@archiver.kernel.org>; Wed, 11 Feb 2026 03:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ORVMZK9TTKMl+jFhx+5kZzvswRYg3GhA/r8yrkv73eE=; b=4SNhP5mxIjRXYRl9H5Ts9Wi0AM
	QAuCUT11iBMH0mE9Bz7Id8Pdelu92YMQOKMt3q9rEnj7KctZmda25Cu+fVlpP1DOTvykwiLgebwNU
	/ZmqRW/q8asqQCd+cLRosatGCkaVGYXLOsllqcFVC2hCAp+oolEudJqjDmoGjZ+Kmih/Hz6xRvHoj
	MjcbNeU8xVhoWOan3G8pRXfiLzlf0nXwsP/KoDJ6n2MO4f6wsRThEqozFn/Cv9pZYgLEkqEnxaPaA
	ak7wGN2yGiNChV2pelTCjurvDrpSmnBoaczRROgJESogQXfj026m47rVjR651gwD+uxtO6uHb8WRh
	0EmzNsJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vq0vk-000000009jS-3ZSa;
	Wed, 11 Feb 2026 03:30:20 +0000
Received: from m16.mail.163.com ([220.197.31.2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vq0vh-000000009hx-1dMb
	for kexec@lists.infradead.org;
	Wed, 11 Feb 2026 03:30:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=OR
	VMZK9TTKMl+jFhx+5kZzvswRYg3GhA/r8yrkv73eE=; b=Vx/PWKIPqvGfFelh/g
	KfFjktTZZm9TEtVUQeXkFYUO2aQlZM+uQwAIUZMjUcLhCq2LVsIP6O+esfL3QYVZ
	my8xCJRgIrWl2aNHNts4LZ77merEU1LF/uR9WM8mSi1Fai9gH00SZLvkomwfSo4S
	KAw0+FtvoH3dBRBzspho2KudQ=
Received: from ubuntu24-z.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgC3f96j94tpMZp0RA--.2981S4;
	Wed, 11 Feb 2026 11:29:43 +0800 (CST)
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
Subject: [PATCH v2 2/2] kho: remove unnecessary WARN_ON(err) in kho_populate()
Date: Wed, 11 Feb 2026 03:29:37 +0000
Message-ID: <20260211032937.208353-3-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260211032937.208353-1-ranxiaokai627@163.com>
References: <20260211032937.208353-1-ranxiaokai627@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PSgvCgC3f96j94tpMZp0RA--.2981S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw1xXw17Cw4DGFW8XF4Dtwb_yoWDKFc_WF
	4xtw1Ikr4qvrn0vr1Yk39avFWrKw40qFyvv3W3XFWxt3W5tayj9393Zw4DAFn8W34qkryD
	Ar1kWrZ8tr4fWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRCHq2DUUUUU==
X-Originating-IP: [117.176.243.201]
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbCxgdksGmL96fAXQAA36
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_193017_746984_72E29A11 
X-CRM114-Status: UNSURE (   8.62  )
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
index 3c705b08a489..eb87d23e8da6 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1507,7 +1507,7 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 
 		memblock_add(area->addr, size);
 		err = memblock_mark_kho_scratch(area->addr, size);
-		if (WARN_ON(err)) {
+		if (err) {
 			pr_warn("failed to mark the scratch region 0x%pa+0x%pa: %pe",
 				&area->addr, &size, ERR_PTR(err));
 			goto err_unmap_scratch;
-- 
2.25.1



