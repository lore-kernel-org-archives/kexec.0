Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D36DCCFA13
	for <kexec@archiver.kernel.org>; Thu,  6 Nov 2025 22:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Tx61RuKbwaGoy8WCkWWJa+EGKVyM66y7AQYoEIU/68k=; b=GM6Kn08istfnIBZzP/B8fOtH6l
	m7czcK8ooSyGHXBum3I5aE16ruhTm17lITi2Jr5pTO380/Z9P8WzPnRKyJc2edDIpSm41mUygxn5O
	psoQ3mob9WXyKW0zKefRZ2ABHzELre8ZentwyAhGf0R+mOJudrZZFkl8w33hEUbRCUjfKg2AZ8ECa
	Li0tqhkJqkWCoL7O+8Sp9AhlfxsVAOB02u/ZslOYEiQQpbUGlTyIiRD1kIkuhsmLStg8t4ftzvzKK
	ofBB1CEQ7vWxCacFxpl+ff2iredvGyix5NuZb0d+6xSGKff4FbnBE03ALK7NsXWZzRIJk0TWHo6dt
	C7t0K1Iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vH87x-0000000GIMV-0pFt;
	Thu, 06 Nov 2025 22:06:45 +0000
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vH87t-0000000GILl-27bO
	for kexec@lists.infradead.org;
	Thu, 06 Nov 2025 22:06:44 +0000
Received: by mail-yx1-xb12e.google.com with SMTP id 956f58d0204a3-63fd493ea10so192700d50.0
        for <kexec@lists.infradead.org>; Thu, 06 Nov 2025 14:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762466800; x=1763071600; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tx61RuKbwaGoy8WCkWWJa+EGKVyM66y7AQYoEIU/68k=;
        b=IKX83IPTgSduA+gydj2LSJO48atLpOku2tZdgTA6wckoA8TlyWHx2TuMOWsHL96w5B
         BB3CLooPRNeam9+p+D47ww4nGKBI++tM8Szm/3msSyt73fQj565ehKF+2n0KcLgUtOSv
         /6tSjc+QpkO5VPH/NYylf4wmdFFt/AsdSITN2xupTrvWvpBcVZoFvXJF5SoI4EKbBIe7
         WmjyQXQMIQshI70r6jFthGx4TKiU2iI/hWNWbociunfaNCyZk/9HrHHIUnUiFy3ZceAo
         L2sdCROjjrWnJ3Oek6jisu12+zM2HRmAqjuwGsJxRW8ysl4hCXPETn3a3MRTDwiCgfhq
         F22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762466800; x=1763071600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tx61RuKbwaGoy8WCkWWJa+EGKVyM66y7AQYoEIU/68k=;
        b=ZFDBXTNWqVx/PS7m0svzL1cHtMIwSFjEmQI0i6KJ9y1zyXlz8B2iHyVoBLDZUopGte
         tdI3goEa0JLCNty7Z+qzdinSlhZ34OG/dIjgq0izUOev/p68EZ272V2OwWQd+Nj5Na5X
         zKQk/LLWoU7rbiU8o0ao3G7i1fpkqHc6vI7Oj16fMNPEkZ4WBpXEs0053qJyLUxxU/fa
         aR0/GYbbMGW1RhRaqYJqozEM2qryYML2yqYLzFcjGXMfc5bKnp0dkPnLl7c15IeoBfff
         iJISGSW4ckqjasuQFyZrmzrRFws+Nzy8PhogsrBdgaB1JlnvItIppU7svfE4tzG/mER5
         0/ag==
X-Forwarded-Encrypted: i=1; AJvYcCUidWDGNbKs7a08yTRLeaT//xqRoSfDEx8om8+KadMzl2GIIiemo7cKRN9hSfxLWL2kr0478A==@lists.infradead.org
X-Gm-Message-State: AOJu0YysXYbu3xNV1kqRL8rN2IAyVqsdpMQL/Mg+Vq8GtgjRmvjZDqP7
	9iCGTqJYgGqJkDdzUslV+npYPj/jWSIHIQ5e2nkz47t2vOOPw/9340906P5sq8HUR8w=
X-Gm-Gg: ASbGncugtxpag78bLeplTFbOqbzSXx74FK8jR4VvIZKL9CCrj3s6+UNC0L4bfSeCwfv
	nm9lgtpdxqiSIxDZnWjkTJIEwbxxx7OsLTCztuHll6Fhfz4dhNhPygthrRMnLGG+jg+Sn7DwHIL
	d0jrdafUR0JFPPlzCd+wO2bMxQyCuELFGTsGDUTYsdeQ4oBU+Z1LoGFlu0zv30eBpgXgZVFqZZi
	qS9Lth15C1OR1OJ4nbk0j0CFVcgLFq4s5s9jlCnOTCjzHTplZx4froCPklRDH7xl//tAT90v5mj
	iBahFnsg20r0ybGtuYQl2tTl0fyfMLiCWw1wlayalOdq9It25aLfYLzCYJ2rhDfCthDDc9c61CN
	aTmi7XL8mEuMH6SYZN8YR4gFykkS07EYvs3lngW1O1RMid3CsIiRbBbJvhWY4qCAcEo9qfTha57
	epGtpL9sX3qjeQ+Eb9UA7IKCLZpN9wlcbzZU7unKT6xkEEIk7gS++gl5aDDbq8sw==
X-Google-Smtp-Source: AGHT+IEbyZ3CyxYgGJMLSh8rMnJR+LBiZyLUDpUrBs2zL1yi+A/d0cUDNA5K5afagLqiMYLBA96mhg==
X-Received: by 2002:a05:690e:1904:b0:63f:7c9d:d378 with SMTP id 956f58d0204a3-640b53db770mr3942118d50.5.1762466799959;
        Thu, 06 Nov 2025 14:06:39 -0800 (PST)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787b1421493sm11743027b3.25.2025.11.06.14.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 14:06:39 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	graf@amazon.com,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	pratyush@kernel.org
Subject: [PATCH] lib/test_kho: Check if KHO is enabled
Date: Thu,  6 Nov 2025 17:06:35 -0500
Message-ID: <20251106220635.2608494-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251106_140641_557970_BA7E2621 
X-CRM114-Status: UNSURE (   9.19  )
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

We must check whether KHO is enabled prior to issuing KHO commands,
otherwise KHO internal data structures are not initialized.

Fixes: b753522bed0b ("kho: add test for kexec handover")

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202511061629.e242724-lkp@intel.com

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 lib/test_kho.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/test_kho.c b/lib/test_kho.c
index 025ea251a186..85b60d87a50a 100644
--- a/lib/test_kho.c
+++ b/lib/test_kho.c
@@ -315,6 +315,9 @@ static int __init kho_test_init(void)
 	phys_addr_t fdt_phys;
 	int err;
 
+	if (!kho_is_enabled())
+		return 0;
+
 	err = kho_retrieve_subtree(KHO_TEST_FDT, &fdt_phys);
 	if (!err)
 		return kho_test_restore(fdt_phys);
-- 
2.51.2.1041.gc1ab5b90ca-goog


