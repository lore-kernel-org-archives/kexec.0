Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76FCEF532C2
	for <kexec@archiver.kernel.org>; Mon, 23 Mar 2026 23:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2Zq8TWEDbszxKidgDH4WcoGu6pRsZKEzAg4VfsbVeec=; b=siiscAJV5n8HkCWquDx9FGK/q7
	m/wvzWoS/DN7HVkJviHffZ+SD2vHrIwgrlnitnFeOEd8PxnrmYDshwUC+QbEQDvxgDjCtABSW1Rfp
	8oKWVmx2dM3U46ZXQ4N7zV78ob16I3+prBu9kEyhcnM3dcwgPyz/zJJimIvFR/9sF7rEiz4GACDvu
	TUQdQ+eIi6XY3LSPg/TISBrDXfrMC0QJwX1vEeuyPFO+DX87L1AcyAentJvKwVusOUJBERb5B01zY
	g1qlTKzrpK0E6VdSPvVo2eD1gPXbrUx65Q6pfGk/2SgpVdBN5kP9BDGXG+R0qPNmaQR+MVsgZHDHk
	mkffgqMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pAS-00000000BGG-2jmL;
	Mon, 23 Mar 2026 23:58:44 +0000
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pAQ-00000000BEv-0qcr
	for kexec@lists.infradead.org;
	Mon, 23 Mar 2026 23:58:43 +0000
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-2b064884a7cso335538745ad.3
        for <kexec@lists.infradead.org>; Mon, 23 Mar 2026 16:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774310319; x=1774915119; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Zq8TWEDbszxKidgDH4WcoGu6pRsZKEzAg4VfsbVeec=;
        b=b7jSUJc8C02WBdgsY1GE5qDM2GqAjn79R6P+Ryd19Gx1rS8hVszrPNjKxHhVtBUjWi
         YA9KvNhTJ/JDzVgvuplnNvVqdmInhZ4lPp9xjLucE4w1OdB7cNXlZZZs//IO7lra2QNK
         Y0FkgKG8qLRn+da2Hj1Em3ZImb//TSOTXlxrRI0y27vNgIl44YeJ21PRdsO/md2r0ten
         skYxKGHO8X0it6dyf6b/lGgz1nPN9J/E1f5uQ48Yft2QVkPx5O3gVk3D3aMBq1kDEmht
         PP4kGP+uAF9Q0JWF5FX8412z9CL2bANUqrmmDqp3cK3/OL8cRFPExaRN28kiUTMXDP3R
         bvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774310319; x=1774915119;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Zq8TWEDbszxKidgDH4WcoGu6pRsZKEzAg4VfsbVeec=;
        b=A9xslLnKMWKJK9AUagjKrZMN2bG/r5+jXrETfBVbxBemZDV/b29qoyHJSuWN8n13G0
         bXwZJ3anb/sDlD/4A3rNCo+VsppxagBf4UqroqqxMUsSQeQcPI4uLedOFlj7q1a6zhkv
         NPOJIBjjrN6idKhrQNnXJzWC1WpCdmjdimafq2Omr0qm5uF86vPcezA1acPmtffjfpEs
         e8Apnq1hxHvVJoiyHfE0AramH/2f5iV7nB4xlKPqsJoJhe3Jn4P7/YsvIKSr92lpXcLR
         IPVjC4MXlTX6bpDKVtEe8Shn0YTUHjB76VnN/betZCI8KtZKuLwkKy703EuhIY50XCKv
         SPYg==
X-Forwarded-Encrypted: i=1; AJvYcCVCDTKxvWqrl/dT7KmbvujMEpOuH68WphO/WvUcUg20LODgrC775BXiB1wcxfEYs1j6wqPXVQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx856l90A8SjVz80dshl3kGI6Q6V0RYkQAHyXuHLLgB40LbE8A4
	oV/QE0PW04G8EUk+ikcx+rey64pjArF/p8S9ZmulJ4kXAh03rstYAdl6HGMixP9gOGx3kyh6sB/
	NfTeQokVoJYwo6Q==
X-Received: from plbjz7.prod.google.com ([2002:a17:903:4307:b0:2b0:5cee:2504])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:dace:b0:2b0:62dd:3a80 with SMTP id d9443c01a7336-2b08271a32emr137995625ad.17.1774310319196;
 Mon, 23 Mar 2026 16:58:39 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:57:53 +0000
In-Reply-To: <20260323235817.1960573-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323235817.1960573-2-dmatlack@google.com>
Subject: [PATCH v3 01/24] liveupdate: Export symbols needed by modules
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Mastro <amastro@fb.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ankit Agrawal <ankita@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Askar Safin <safinaskar@gmail.com>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Chris Li <chrisl@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Feng Tang <feng.tang@linux.alibaba.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	Li RongQing <lirongqing@baidu.com>, Lukas Wunner <lukas@wunner.de>, Marco Elver <elver@google.com>, 
	"=?UTF-8?q?Micha=C5=82=20Winiarski?=" <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260323_165842_258297_B61FBE86 
X-CRM114-Status: GOOD (  10.59  )
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

Export liveupdate_enabled(), liveupdate_register_file_handler(), and
liveupdate_unregister_file_handler(). All of these will be used by
vfio-pci in a subsequent commit, which can be built as a module.

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 kernel/liveupdate/luo_core.c | 1 +
 kernel/liveupdate/luo_file.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index dda7bb57d421..59d7793d9444 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -255,6 +255,7 @@ bool liveupdate_enabled(void)
 {
 	return luo_global.enabled;
 }
+EXPORT_SYMBOL_GPL(liveupdate_enabled);
 
 /**
  * DOC: LUO ioctl Interface
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index a38ea4975824..cdc48d49e5e5 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -866,6 +866,7 @@ int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(liveupdate_register_file_handler);
 
 /**
  * liveupdate_unregister_file_handler - Unregister a liveupdate file handler
@@ -884,3 +885,4 @@ void liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh)
 		list_del(&ACCESS_PRIVATE(fh, list));
 	}
 }
+EXPORT_SYMBOL_GPL(liveupdate_unregister_file_handler);
-- 
2.53.0.983.g0bb29b3bc5-goog


