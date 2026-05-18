Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E4D6CD4F56
	for <kexec@archiver.kernel.org>; Mon, 18 May 2026 12:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dRrqC16L/kKiIkGaL/cKBFQ/71JkkFCJM96Mq+OGi8Q=; b=Ng5ITzB3CQpnCSDvKpDjPUMc3g
	swcWwkPLEYA6PaYXYve5U35RFZJ0ivFnWlrHvFfJ3SSH9MR6AEmDA2PPZCetH62mnCkkmkqoAAJpK
	AKqK5YTqoeHukdnzdf6CeJNUJ0Rdv6P26jhEP48ntDq4v6ltxWs2PLldCCmoMSf7p70+oJP99Weo2
	dholSttDdbs4t8tjQl7Plju/tuZj0XSFMkpIpLbUBPtxU0COU1nz7gDVsMnCBbeVoZSZEjKEpSsPD
	taVF03nJ7xSunHwGgkF2PJcsb6PHZZL0tkS3phLp4ym86X92tk+OZLXDDQpHsSvRp7vm2IJwALHlu
	ILZDlo+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOxV3-0000000FiNk-1K06;
	Mon, 18 May 2026 12:55:13 +0000
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOxUz-0000000FiJZ-2hVy
	for kexec@lists.infradead.org;
	Mon, 18 May 2026 12:55:10 +0000
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-8ca12973e15so35118066d6.1
        for <kexec@lists.infradead.org>; Mon, 18 May 2026 05:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779108908; x=1779713708; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dRrqC16L/kKiIkGaL/cKBFQ/71JkkFCJM96Mq+OGi8Q=;
        b=VAAzGt8kCzgM/JvAxKJd676qbg0vO2e7+3GGT+/62UQ8Oa62oWYhZjCZuclHhGlYRf
         Mflxv9tS7CpVw6apjG5JdLFev0d2m/OkEoOCHlOGykWbzF96JUbn7Llvt0IjemTMIdES
         i9o7c3w7eOBeZCwhKok60V68cVv7wxyYc5tAEB0bZC6V1NhqAeiNga35pDofZoCEldPF
         WEMNR97BEFbxcgFL/owm98xITGHyVZAoQGUOUFfwouFhf9QhQwxsn3ErvbV18LqEhPir
         cdtuZ1z+eBRFIgupNoFGjzjTP6En9LEDjoAJNW11+mOuUMY+VHWkFtcZQnIZC7zcTwOb
         oEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779108908; x=1779713708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dRrqC16L/kKiIkGaL/cKBFQ/71JkkFCJM96Mq+OGi8Q=;
        b=ChjyI5NNBmarpMkOxX0o+DRkbEIoWaRj2+h51b5lBrRfuZmv7fGw1alpuZGajWtoS1
         ElfPR76dOICTDzkG6KUWVKYtPkSEMeRmFNzTociQEc/548hdbIeGFv6eATj0P5Mtp3F8
         PJW4POhK7pfE8I1i35KTwkiSlRst2ZSWzfAe0F4sokhnthGcNIvf94xyS6tX12NX0YHT
         cY3G12t9JqlYqKK9IpLOGXvk0bHufjUdFQHPP8EE7YAngE458B6zM9fU3l2l5R409LRQ
         sdpo8ekONZGV41DKo3yE/Xxwg2C7v3/AjzeAJKCUvr4wZZyAOuHnCsopr2phdgx2+RQp
         5U3A==
X-Forwarded-Encrypted: i=1; AFNElJ/kSSx1Dxs7ReCbtsyeLHcCj53MFT219R52IMQX3e97Mia0N0U0kodHQX9IkaXG5RXDcOIb0g==@lists.infradead.org
X-Gm-Message-State: AOJu0YynuEmmjpetW998wIxsKFsh3s0e27HzIfyF0omMzt047PVZCIrY
	uFyCnW2sf9d9AUzWft8RECkeUJAWhifRoxILY49kJkDQNS1f9LCQBArF3ii535hVJFA=
X-Gm-Gg: Acq92OEF+K/QHgm28kAGZKiekB6/GxWdv7haP6C/i3MFY0iO6hS2Em2b72VTQc7AThG
	ZEHRAAeXvJBlyMm+vBgRQdKCOYsx6PvFdpoaz9FeI6QoTqSPg58wdLaPVG3vKm6igzPzDSmq7AW
	DbQe9bld6z3K5oUXvLdj8+kCxaGH1MLHNDJBvjZpG3pNVG5t5UDFzfUHOOF/nV1ChuGTgSmjQAM
	wSBWbNUIZQRBZuTxaW3MylPByBLaXrU5E0deTKYPIw4PkfbUgvHn0yIQfQHuyAbsNeD0zPcUdLe
	GWvuFxmHoEW5c7U8CIkO30evl1RyVDLqu/Aonxi5IA3Vf3aDDFK5tWnBAnwAogPgtJM2oWsH2sP
	2BKB5r0JC0lH3QCPMmdQRzu3OCm8VwsQaNs0AvDfcm5zRtIUk/dLqx7+0llMy//XRJEqc6yolPZ
	IdhcQ6ZtLDpk2L45iCKHCCf4mb9PoqTcsVItulY/hDwJQNXkDAvaBJN1R9yuCcGQ==
X-Received: by 2002:a05:6214:2a4d:b0:8c6:2245:3f49 with SMTP id 6a1803df08f44-8ca0f6a898cmr245726476d6.32.1779108908391;
        Mon, 18 May 2026 05:55:08 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca3608c1desm54511756d6.2.2026.05.18.05.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 05:55:07 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: rppt@kernel.org,
	sourabhjain@linux.ibm.com,
	jbouron@amazon.com,
	akpm@linux-foundation.org,
	bhe@redhat.com,
	linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org,
	pasha.tatashin@soleen.com,
	rafael.j.wysocki@intel.com,
	piliu@redhat.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	skhawaja@google.com,
	graf@amazon.com,
	mario.limonciello@amd.com
Subject: [PATCH v5 5/5] liveupdate: Remove unused ser field from struct luo_session
Date: Mon, 18 May 2026 12:54:59 +0000
Message-ID: <20260518125459.1092373-6-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518125459.1092373-1-pasha.tatashin@soleen.com>
References: <20260518125459.1092373-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_055509_710512_BEC9B68B 
X-CRM114-Status: GOOD (  11.25  )
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

The ser field in struct luo_session was intended to point to the
serialized data for a session, but it was never actually utilized in the
implementation. All serialization and deserialization logic consistently
uses the pointers maintained in struct luo_session_header.

Remove the dead field to clean up the structure.

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_internal.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index 875844d7a41d..dd53d4a7277e 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -59,7 +59,6 @@ struct luo_file_set {
  * struct luo_session - Represents an active or incoming Live Update session.
  * @name:       A unique name for this session, used for identification and
  *              retrieval.
- * @ser:        Pointer to the serialized data for this session.
  * @list:       A list_head member used to link this session into a global list
  *              of either outgoing (to be preserved) or incoming (restored from
  *              previous kernel) sessions.
@@ -70,7 +69,6 @@ struct luo_file_set {
  */
 struct luo_session {
 	char name[LIVEUPDATE_SESSION_NAME_LENGTH];
-	struct luo_session_ser *ser;
 	struct list_head list;
 	bool retrieved;
 	struct luo_file_set file_set;
-- 
2.53.0


