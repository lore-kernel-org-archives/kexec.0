Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDC4CC6B30
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 02:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NUNOoS2iIKhfEq8rmR2m7meaweAbFoUqZ53SZ4RiyMU=; b=xaXPEnV48UYl7Q2fRQDWoQhVri
	jLm2BlpnUSD7wbHN1mhFjMGWMsqtHfpF6KsNXV7cIpkBKutTTi2prD1rl2DQ9Z1R1MmnKGF0a9NRR
	aXFXmwDSNCS0PQpHEVXdhFS0dWseSOupgGSHGMg06HIxRTVRSV5lb7Q/sDSYtlBdNtfpVUDK+Fcfw
	U/F4RfXDTHa3iE7fUpzeMslcId3m7oRzlbEooGHUVXZP7PsgDucatG+Ebwygvq4XZ6FGrNmIh7QBt
	Wsma4Sq1xmF313X73eGqdGLdetvR13YVMlVjatrRMTqmheJmHqeCuEZzSWtJeabriA3PdIZ/hQlC9
	unCHqN7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHAoT-0000000Gdl6-483L;
	Thu, 15 Oct 2026 02:03:21 +0000
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHAoR-0000000Gdkj-2Old
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 02:03:21 +0000
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-5e930a11148so2686457e0c.2
        for <kexec@lists.infradead.org>; Wed, 14 Oct 2026 19:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792029797; x=1792634597; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NUNOoS2iIKhfEq8rmR2m7meaweAbFoUqZ53SZ4RiyMU=;
        b=bI9qtm8I/K8X65LwIfSfDb0OFwnZwC1TvpEzazQy0ifG05blxoZ/m0sGGaBADamYzI
         CLibuk4BHGISJC+tVqM7Ymsy6V3KMJJ6xkrUc+KWC+svOnCYTO7PpQCINF4AYYzkTnWd
         ezxtg3GX5o26+rVVaZ5cM6fuM7+8Zpk0XXSFJlyYaEd6vkGDs1KiMvOku5HhCVfI0Vy+
         mspgSBgWxTRXv7SSm7Qva6Ws+YFKh4tGGzIDKudAYaKwTBJuUj/C9bp4KTBVolxTmKP4
         LeNM9HJprxHxMHqrCE3Ouapn9gkzWgh05BGG64c/lgY9XG5cI6X8tAHi3ULnxdMT313M
         eDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792029797; x=1792634597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NUNOoS2iIKhfEq8rmR2m7meaweAbFoUqZ53SZ4RiyMU=;
        b=KagwAHOvLIw4aNoHmsWV6VxMKZ8955UtX1c+H2tyzUg+5ImeRXIG7qLRW+KwSPnvSG
         Xd769YagJZSQ0NPnvhyG2PR81QkGwPlDc+qjjRtuudK9Eu38fTW/0ft7cRvin+LFPisx
         HBGh30j2QjliPwE1J+ZObGG7fo/7NvD1ZY4smoV6LpLewp99xu/+P1oG6p4iM77ymrDT
         8F2Nju+R6Tv9Dg29mCaBqGEWssrOvCCPyE8nq7PNqVX73x1cI4SVMCGIqDhV7yQlwYB8
         7plvlaHpokbY6LvoMTcEGuZQvh1JFVclgLWm8RhYrQw8+P0FVvXzc/sZYe+Maup8yEoX
         wqqA==
X-Forwarded-Encrypted: i=1; AKwUvBxEbps/Z+zzmB76zFOgiFxUlKWPOs3vFu9xfwusIfeJ33e/OhO2xJWQwNARLZnVHODHXkQq7Q==@lists.infradead.org
X-Gm-Message-State: AFq9FYL7quaeX3gTmm7AWIeB8q/N4GcwPqAOhzH44nUIDBmMIb0eYS4M
	iyx8Gq/7/EOkrU+0/GRRzHdO2IncUjQg8RbRimqs+9Jcu/tKi2cGNVmoMoFHYy78CnQ=
X-Gm-Gg: AYBFou2ZD5OVHNIXwBjJI+Ff+Z2hvYM0veCuB4viaPrpbU4F+8zqOfaTH25BDWQ19nM
	NC8SkxBDDqzWxYwqWOcRV4oJ4k2wjOxMSYkiyswINkWBjquEvCUFxKg1hJWZaDCDAcNXLALoiMm
	Rgunh9gJCeoZkoV7uNjU8SGjSpNNc1YnFk3UMj8FFOveCO636MvDf6gH4DnMM8nXqbfw0FPTaZN
	P2//zskPeat6aSxpqprNAAZry04f05mO0gCuwA/YR4oXY1qcxt2vmGXTifXR671687ua0yxLj7L
	pErMiBCFCS/YYz664RHUHzKElwR8uUoquI/gbqwCHTy0o28qOfXlj/go1DNSu76G3iwEMewkYPO
	sayN33NITqlqjSqVowSbEuoa5qgI01XgFCR0RqF87dl+paFJu+v2qXp1W4wXtHDUbtSsYbm71UZ
	cHPOTz6u9zJm+V+SUscAlzSfIkthpGKxBrj/urnAPcpnW+xtLFwZb+oORWytqOsR5xvR83YbOEb
	2SeKna+Ohk4JUHOUGdWAKYIzY2jNRUzQp7ZVOFhpo83CFM3DtDB3hKVOxniZ0RZmDSvOhiB7wyL
	vuxN6Nkq2a0NQZst4RfsYg==
X-Received: by 2002:a05:6122:e213:b0:5de:655e:4056 with SMTP id 71dfb90a1353d-5e91f3f5ff1mr6177997e0c.6.1792029797642;
        Wed, 14 Oct 2026 19:03:17 -0700 (PDT)
Received: from soleen.c.googlers.com.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5e91cb3e435sm12477115e0c.10.2026.10.14.19.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 19:03:17 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: rppt@kernel.org,
	tudor.ambarus@linaro.org,
	mchehab+huawei@kernel.org,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	pasha.tatashin@soleen.com,
	aleksandr.loktionov@intel.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	rdunlap@infradead.org
Subject: [PATCH v1] docs: xforms_lists: Handle DECLARE_KHOSER_PTR() struct members
Date: Wed, 14 Oct 2026 22:03:13 -0400
Message-ID: <20261015020313.946940-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_190319_641001_ABCE35C7 
X-CRM114-Status: UNSURE (   7.98  )
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

KHO ABI structures declare their preservation pointers with
DECLARE_KHOSER_PTR(name, type), which expands to a union of the pointer
and its physical address. kernel-doc does not know the macro and does
not see the member: it warns that an unnamed member is not described
and that the description of the member is excess.

Translate DECLARE_KHOSER_PTR(name, type) into "type name", as is done
for DECLARE_KFIFO_PTR().

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 tools/lib/python/kdoc/xforms_lists.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/python/kdoc/xforms_lists.py b/tools/lib/python/kdoc/xforms_lists.py
index e3dda2fe8a537..e81d8a7702cbb 100644
--- a/tools/lib/python/kdoc/xforms_lists.py
+++ b/tools/lib/python/kdoc/xforms_lists.py
@@ -45,6 +45,7 @@ class CTransforms:
         (CMatch("DECLARE_HASHTABLE"), r"unsigned long \1[1 << ((\2) - 1)]"),
         (CMatch("DECLARE_KFIFO"), r"\2 *\1"),
         (CMatch("DECLARE_KFIFO_PTR"), r"\2 *\1"),
+        (CMatch("DECLARE_KHOSER_PTR"), r"\2 \1"),
         (CMatch("(?:__)?DECLARE_FLEX_ARRAY"), r"\1 \2[]"),
         (CMatch("DEFINE_DMA_UNMAP_ADDR"), r"dma_addr_t \1"),
         (CMatch("DEFINE_DMA_UNMAP_LEN"), r"__u32 \1"),

base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
prerequisite-patch-id: 557b4f406b7530b8be07d3e3aa6015ad89ceaa6d
prerequisite-patch-id: c0430a4f0096e4be93a6200aa4e8a1d392238ca5
prerequisite-patch-id: 524c71eab38a9175f9920f38717c8ed3b157299f
prerequisite-patch-id: 61cfc274edef2fb23a1b867c9e0d063578387c45
prerequisite-patch-id: ac022b05628f8e495a224216352aa037a022aae4
prerequisite-patch-id: 50668baf257da9873190d08f21538ddc453261a8
-- 
2.56.0.385.gd3acb90ef8-goog


