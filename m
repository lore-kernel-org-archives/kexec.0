Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50669C53219
	for <kexec@archiver.kernel.org>; Wed, 29 Jul 2026 03:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DS0IrsM44kZUGaGhytP8PP823NCCJwpZY9n5wWxfSk0=; b=JEvzT9roYjd0uYxPIe62L2QHaK
	fn75IEVPr5Ckv5VA1krOYIlQUDnBoKNSd3kzNo6lSjyNAg+uMd6kGs95cedTn6PsRWU4qHY8d8ff3
	S5RHmeofmLeZNLnt/BbcdayJ9S9Bs3+b8Rzts+VTW6BWT9veo/A7uRAFAlr2mIo6iob11QFWXI38K
	uubLRCltv6fBuc1d7D4n5MRoZL2u3TuGoB34U9aQRmTR0eAKgG6w21OZMu1If5kCNaSZ3lLjxbJUi
	wM5XCvBiWYIadixVP+FBLAbOpQsQPhJ0Ml6l//V5t6/BgOrXMydVC3YaYogg69bnJY8xFRncX4XpI
	I1I0cfdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wov71-00000006lfC-16Jd;
	Wed, 29 Jul 2026 03:37:43 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wov6z-00000006ldu-0A1E
	for kexec@lists.infradead.org;
	Wed, 29 Jul 2026 03:37:42 +0000
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso389532a91.3
        for <kexec@lists.infradead.org>; Tue, 28 Jul 2026 20:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785296260; x=1785901060; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DS0IrsM44kZUGaGhytP8PP823NCCJwpZY9n5wWxfSk0=;
        b=GKYhsl9zuEqEheeB8AQFeKjn9XFrxfdYV6GsXxUOLzzfQ0w5LxB91KKFEXAzeVKNQc
         RP54/QgVAf1Yo0zLzs76lS0q9yVE39VyHbqtPSN3OmA3/mBk2tpncKiX5x+Fx4mcLGsq
         4SNyy3udvrhdkbDlpahYndhEkRUAkY/6c/iS+cMkz/564WLJnjlODIZEYufHGv77xM9c
         FxQMI3arkNP5zOQsAHkcAFavJZlJSyzPqC2RVNMqp0r6IlAryvIkiuOJpSTOJL4n2BzO
         W9CUBUBG6mrz3zcGKjVrSfcDqLaa9ZcX202ZzfJOggpFVekZCrYctDrzKJ/kuVHNl4Xu
         exzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785296260; x=1785901060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DS0IrsM44kZUGaGhytP8PP823NCCJwpZY9n5wWxfSk0=;
        b=Vmu/p8hmSyA0IgiPGJgd3k7l3N3KZbo6YhOH5Ad3L7R4qdoy2YVt1mM0wC64hRic/B
         SeP4grbyTWfNsg7HSz9ozpEFFWEALPq/H/C/73xSraFZ5u1BhONSEweAVwX3JeziNTlf
         Ig9guLMxUjPNLDZDNU09b1glCdKUA+tkFGmDyyXyX8m7qSEARegip79R/VvUKyT7G9U9
         AMKcMcJDbLo9a+0AKDGZ5q8bK8LUe0xf50XapE5guvHla7AFxQTpILJ20qD1TDY7VAnq
         MIvyNflDv9z2jri6A5nu5ZwutiN63Ak5g2PAeGfJ2Nyj953nn5bdLcI1KWHCwyCe2QP8
         9USg==
X-Gm-Message-State: AOJu0Yz6voVIczn0HQcCITPyyzzST38MyXHhSLCo1OSsLW2+f4+KERRU
	OilCtLsfs0uN3sk1wDgYP0s4ZpaHOIwEOie7TDPeDdrEomPRKD0NTlfWdua7WpncxH2rJg==
X-Gm-Gg: AR+sD11LaRrxKwnKurdO6PngybrVWl40u22IANXPa7oRGlMjCEYE1Pu0R3xqkc0ADA/
	eS3R4wEZI88or5KAc88O6ivaCiBX86NzVWtPsVZsJn4pkgya/wGsp8TmODAS0htfRuwrHpD0OQ4
	X/VcHr4sTQHNhHpY9ZcaT3auJWtUMHJ96fWya1TvR/SPGj5FbPWsZ0h0cPZGIemhc7+J6MEKBxR
	YdlwSCmBa8+RPum6BKSdJkFiNvyXq4rNT+mG9pM+7ST2I7V19+HVg4Kl4oHVwlV47HK99UOV4el
	LO8eGeahTUgRIEJW9KDys4LnCOjJg+drvLNA2X9YWfctLfvn5O0xpxqYAdFfUnEJNmLjtsJ/eF4
	/4oDiZe8lNw5I1zYgEVZN41V94D4Z6eYovMicnf4KBbgqW74d8z5gAjXA0J8xrf6J3p4jcB1vzk
	EHg9r75MVB/xbwB67I2XMa5NFFn8QADWQo/EhxNQ5ULp4=
X-Received: by 2002:a17:90b:38c8:b0:38f:240d:b857 with SMTP id 98e67ed59e1d1-38f6a440bf9mr4959403a91.2.1785296260083;
        Tue, 28 Jul 2026 20:37:40 -0700 (PDT)
Received: from localhost ([2a09:bac5:42f2:1e1e::300:30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f6411189bsm2045726a91.3.2026.07.28.20.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 20:37:39 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Dave Young <ruirui.yang@linux.dev>,
	Pratyush Yadav <pratyush@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Coiby Xu <coxu@redhat.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 10/10] Documentation: kdump: Add arm64 and ppc64le to encrypted dump target support list
Date: Wed, 29 Jul 2026 11:36:50 +0800
Message-ID: <20260729033654.311541-11-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729033654.311541-1-coiby.xu@gmail.com>
References: <20260729033654.311541-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260728_203741_094310_B9C54586 
X-CRM114-Status: GOOD (  12.21  )
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


