Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB52C79FA1
	for <kexec@archiver.kernel.org>; Wed,  9 Sep 2026 00:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lm7BcEa8+Jgt9xkhmMJfF26Iq1SFFXivMsEEThtEiJo=; b=KpKrortYhJxuP8vh/7aS0K+zDY
	C59wwkn245NX4gY2Jk0xPn4hl+8LAwdQ3hJJkAmzIJ+58DBISYhjm8M7bhMghe6KalCeO/B/sznEp
	pxoSuklke5TwTonvq85/saAczOjCAJ2wvBsCh7MQ1TW3YgcsWT28cqNG6YqjAmO6ZuZhy/pi/Gy2k
	gV4hVJpnc4VDM8vKKr8DPC3HlTnMTuOEyHYY4GuYpU3esE+6+Z2FW8HtRtysAJhu24t8/8TyDOu7Y
	4yrlSgu3BeH4/dPSSq0oh+BNL+6jT0LgF+nAg6Mwlor0qMxdz/eVf5lSgEGoUyd+15GyphTs8KL7x
	gE0XRW+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x46Jz-0000000AVqQ-1SIk;
	Wed, 09 Sep 2026 00:37:51 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x46Jw-0000000AVnN-27Rk
	for kexec@bombadil.infradead.org;
	Wed, 09 Sep 2026 00:37:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Lm7BcEa8+Jgt9xkhmMJfF26Iq1SFFXivMsEEThtEiJo=; b=pzxxuiTcBePpcPcXYQKohEvTSk
	p2HLFoJumjYRCddGcCyUIf9cXIIrYU/OdlzEZqfZS5E6k+4yElD5lHE9gXwr4iVTVTnQJFgt0xtyS
	u26LfzHEbk4rb/GDRJkYmAkG02fl0ZmLOzLb46yqAWxzi5U23fRacYjgU1RyrXIYlhmNFeVPlgytW
	UkYUgZgOJBO3cd586zqdxojPHbgV/80X/isnLeGo025dIvAJUQ1NzaOht6N36SmhiXLMznChg73+Y
	ke3VCzolbrVmscHhgAcOzxMQfQ+WDQ4CD2QWN8pIr8oy12Jg5LJ2OFFGOE5AVhcjruKtnXpfJcAzf
	PEx3tliQ==;
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
	by casper.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x46Jr-0000000Flsj-2I8W
	for kexec@lists.infradead.org;
	Wed, 09 Sep 2026 00:37:47 +0000
Received: by mail-pj2-x10.google.com with SMTP id 98e67ed59e1d1-396ccdaea76so683182a91.0
        for <kexec@lists.infradead.org>; Tue, 08 Sep 2026 17:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788914260; x=1789519060; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lm7BcEa8+Jgt9xkhmMJfF26Iq1SFFXivMsEEThtEiJo=;
        b=cRjnH5qCsjXKPt7IODQx96IJrzwrYuZ9+COQJZMCZmnTHSe+RDn0XLGLhp4+gTrTFg
         Ij96wBXPX/VakTNLLeiGM1FW0lpjtbExBo+qxEczfKTpiYcdnFG7zkc/zs9d2Kbc4e2x
         nin63sAVE1VKamMqn/M3k4SVr2QZZZPRLQZEmCRGEWwpcyhidMADaimBJM9wagGu7JIT
         cKouVhSXZqs7pBzF6bAh87XfXlaAiuY3KQ/DGF+Fsa8H56rXCKbIbUpzadf+TAiG11tx
         sv4sLiQTSCbLlKmY1HoFamFs8v4LeF4ffyNdD4Fq6BTOBufVItHA5Vm/NK4Sh98XxD9B
         qMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788914260; x=1789519060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lm7BcEa8+Jgt9xkhmMJfF26Iq1SFFXivMsEEThtEiJo=;
        b=e5BZTdMBe2AXInz4ajzt5iIir5stcp/e3G5vvcPIoJ8OWAxCviDCAHg3UEuEmu4jwX
         G6S87wDJ4NhPQ39wgs3qwfpUJ80a0Sk3nMNe0d6vgfdH9szNL6LUuTPtUooL8z+iJdZs
         LRiYls5P491lwWN5Z6/n3V6OeME39pf7GGjenjlJeI3aVAjceWulwoDhvf0Bwlnmd/mB
         uBmupX5lBgA10piKMo7oo2f7woUApuawnq4iKj+UKWkD8Wz1222NTVZx4bVxFhuVzXzB
         Cs6xZvm1RZit/YWlMJA13FZHmZ4BXaP71KBQv2vCnKDzx2uw5rbCmp1rEG5N2M5JJtIm
         z9aw==
X-Gm-Message-State: AFuF++nxecNLXI27OE+AAtsbL8+nhipXpix0by5OYhWH1Y6sfuvP5/zg
	yu3ApJh8WyAwBBVRmZSaTJSLJ7QSSrsZwpSfe/ughs3p29dHy9b2bCdNjgeMnG1z
X-Gm-Gg: AYBFou27t8py5UwkeMz9+cS2uabeVdOFM28pY654NZOB6qF6Xg5+y5QfW0XIfcypVU/
	e26gCaX24pyAol2Iuq1+9UfnusAnEvg1oCUmDQj2c10s39cTmJAuD9MvdVLI0EkSm+L/yus5zej
	Mv+c9cqr7kb+Udv/y8Thj499flEhgkmjcnfDEqRMh0dSOAHIrw4bFYET+5e9myDnxkyv/73VV83
	imxpUQ9mYLXBaiMta8D2WHeV3SyeR2gH99UjoFIxQj6GBAGjoUGJFB5LSwrVOgLP622w8Df63As
	jBSON9lp2qEU059zObSdGp3KtxMJmZOQisPnLljnYmuz75r5/+J+xQTCfAjLyd/g/vNY68giVe1
	feZgVTlJw7SzM8sRsTaBoBcsA0ihFToCUPTTnk15neqBF/NvHpbuxZvZhQhBUHNENB9/yAMCJsc
	nkSBK7p+gtg+yOJmdegUzSLB3YdQv2ja5/tEWgW1df1wzA3mTlMfv6dEjEMwPr
X-Received: by 2002:a17:90b:58eb:b0:398:ceef:edde with SMTP id 98e67ed59e1d1-39b8bf497edmr7501490a91.15.1788914260009;
        Tue, 08 Sep 2026 17:37:40 -0700 (PDT)
Received: from localhost ([2400:ac40:62f:1b67:ddd8:990d:9d6f:13b8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08d0d845sm35551055a91.17.2026.09.08.17.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 17:37:39 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Dave Young <ruirui.yang@linux.dev>,
	Pratyush Yadav <pratyush@kernel.org>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 9/9] Documentation: kdump: Add arm64 and ppc64le to encrypted dump target support list
Date: Wed,  9 Sep 2026 08:36:51 +0800
Message-ID: <20260909003657.1570544-10-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909003657.1570544-1-coiby.xu@gmail.com>
References: <20260909003657.1570544-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_013743_592754_3F38A189 
X-CRM114-Status: GOOD (  10.83  )
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

The encrypted dump target support is now extended to arm64 and ppc64le.

Fixes: e3a84be1ec2f ("arm64,ppc64le/kdump: pass dm-crypt keys to kdump kernel")
Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 Documentation/admin-guide/kdump/kdump.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index 0bf2eb100a05..36ad6125c670 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -572,8 +572,8 @@ Write the dump file to encrypted disk volume
 ============================================
 
 CONFIG_CRASH_DM_CRYPT can be enabled to support saving the dump file to an
-encrypted disk volume (only x86_64 supported for now). User space can interact
-with /sys/kernel/config/crash_dm_crypt_keys for setup,
+encrypted disk volume (only x86_64, arm64, ppc64le supported for now). User
+space can interact with /sys/kernel/config/crash_dm_crypt_keys for setup,
 
 1. Tell the first kernel what logon keys are needed to unlock the disk volumes,
     # Add key #1
-- 
2.55.0


