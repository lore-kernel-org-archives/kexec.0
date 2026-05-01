Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E82ACCFA13
	for <kexec@archiver.kernel.org>; Fri,  1 May 2026 23:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YSkt0IgO6XQZhRPy2KITLo59XmAjRdZGt/7hKEGvBXQ=; b=PZ2ulGrfxUi0ziwyxcwGpHjv7p
	FwGeRIEXtXeGgozHeMaQR5o/3l4SxDuR0Ct3dFd7RZRMcyoLMiliE/qOMoPt43PvqP+L3ldFsuy47
	BrzC0uxxzovumH4oCg3+lwA/38JTOlKaGfs8J/P8lALcZsPAhPr2vUZR22Ao6z26MiGQeqO4Kylyp
	9iF74G4HZhYCNFq430F/ToYW3R6ljdoQ31gauIxiQho88GTOx83BHUnjKhDSz4Diadl+5EmGdzGDw
	isAUTNOdBDTZl6Ia2A+gdHXznJre2b+XllcjweBZpfGRwXYw0ou5rZO5YGYg6hyDWKYXJz4pZE+4C
	yhxBmWvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIxWv-00000007qbk-3Nz4;
	Fri, 01 May 2026 23:44:21 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIxWt-00000007qau-0fce
	for kexec@lists.infradead.org;
	Fri, 01 May 2026 23:44:20 +0000
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-834f1075805so1734428b3a.2
        for <kexec@lists.infradead.org>; Fri, 01 May 2026 16:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777679058; x=1778283858; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSkt0IgO6XQZhRPy2KITLo59XmAjRdZGt/7hKEGvBXQ=;
        b=lXBUlk/y0VVR0DqyWUokeJE/v5kHH/JFrTLZ7yFey8CU7IFanJ0Ce9S0g+d/yNwbF3
         FBtqTp+eFHgtMRpjncTRNbDTAPXlyH+VraUwJvJ5wJEsHTbXnjaKMERXe2ADyiVGmzsx
         TlZ/vtMxLCZHFCj6kY42bWsztEghPLlvJK5eAU9PRlxDsxD2Dl4pCwqoe1MCaFTob2Fn
         ubPuYV4FEPtrQ0FrI7jckb8G9Jpj6wfWiaYbL2bTvIfD0BHFUl3dCLjV30tH4qAeAnh3
         By3pYKvLNHpvznh2+gMJADfHYGPhBQmjJnnwCunr03+FrSzNOCNYADiGN3bAiUMMIEG5
         jksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777679058; x=1778283858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YSkt0IgO6XQZhRPy2KITLo59XmAjRdZGt/7hKEGvBXQ=;
        b=Z1ipjIg5khL/ZaVxOYjjf7q1ce7dnzw1dnx3PqV0MVmgRm8FgXUaenokbiR0cEaPrT
         GJoDej39PuStzpJk7UolzTeXQZV2UbxOZfZ5ixpNGX+krXX25FvDDBc9Wegmyiw1imM4
         CQwpFBQH5xfAQ1nZqZ4xt+nvbx5UeBcFWm901yEa9teA0C72ng9pby+9DFCF7kk82UXG
         LQ5vpi8UaS+pKSbbw4aQDTjXawR1nmL41zNz2+3YdnGoF3xlppdhGGiaF0NWA6vl2TcF
         ME5rHorJZToZPIRbrKfcwN4BgoVlE9KP9kG5z0yePSB/ERN7YgHaJZ1orkC7lCHHSgPf
         DL4Q==
X-Gm-Message-State: AOJu0Yx3b5Ns1YiXaWJ/7FlbiaFjVEYD1dkHmCZIAEzNg+QMQqAswWWG
	gg5E8M8jCDpBSzSMIEkb0lP130FkM4NteueV2wQZI289M7/3P26egcJVQgsnj0mnyOxZfw==
X-Gm-Gg: AeBDieuOWqbuFgp/d5jHcNqGMYVu6Xr5n2AtYjY4fycSYUfKhUUds2SQMk2njs4BotM
	GvE2nEBTaxdFk3OUlX+w+exE8NhSYiydEibpESd6Xzu6qltRw1+6gB+HPvPkR2Qt0WDV0zTVYaX
	75Bojl/dePpKlrp3626XApAkrBGeD8pHaQ/xJ+MRfaMR9pL19YUhL15D/HH2Ijn67M5aIVQPIeS
	v7cTPuDedFsVYo+KPowZ7cG6xyUhJaiHGKBto4NmtFYIU9O4rIYu+C6p7bNqWed6Y68K4zYMI5f
	4JzbzdJafFhDvMxwcBvL+SBY/hcijsg/Y1ZOtVR7gEIPPNHgnp3QPH3hnZZjT/xeAf1zOSrtDjL
	K+zf3emrTyR3tLbLIY7Y906if6pluZBt6yiZZPjeFP4PPPUO17LRicVZIDflk21GfIHIBXAXR7J
	uo4Y8b5v2WnXTVCq6cst0ukc7UHr1+pRyL0b/WVi28
X-Received: by 2002:a05:6a00:883:b0:82f:6dad:7b75 with SMTP id d2e1a72fcca58-8352d25e95fmr1094470b3a.33.1777679058180;
        Fri, 01 May 2026 16:44:18 -0700 (PDT)
Received: from localhost ([121.237.249.41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515893f14sm3876795b3a.17.2026.05.01.16.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 16:44:17 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Dave Young <ruirui.yang@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Coiby Xu <coxu@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/9] crash_dump: Disallow writing to dm-crypt configfs during kexec_file_load syscall
Date: Sat,  2 May 2026 07:43:32 +0800
Message-ID: <20260501234342.2518281-4-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260501234342.2518281-1-coiby.xu@gmail.com>
References: <20260501234342.2518281-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260501_164419_200812_61D8B34A 
X-CRM114-Status: GOOD (  11.19  )
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

If writing to the configfs group happens concurrently during
kexec_file_load syscall, it may lead to the following issues,
  - buffer overflow if dm-crypt keys are added after allocation
  - stale total_keys if dm-crypt keys are removed during iteration
  - keys_header will not be freed if config/crash_dm_crypt_key/reuse is
    set true

So hold config_keys_subsys.su_mutex for the entire sequence during the
kexec_file_load syscall to ensure a consistent snapshot.

Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in kdump reserved memory")
Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 kernel/crash_dump_dm_crypt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
index 4d8a3331bbe7..6377ee86ec50 100644
--- a/kernel/crash_dump_dm_crypt.c
+++ b/kernel/crash_dump_dm_crypt.c
@@ -429,6 +429,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
 	};
 	int r = 0;
 
+	mutex_lock(&config_keys_subsys.su_mutex);
 
 	if (key_count <= 0) {
 		kexec_dprintk("No dm-crypt keys\n");
@@ -479,6 +480,9 @@ void kexec_file_post_load_cleanup_dm_crypt(struct kimage *image)
 		kfree_sensitive(keys_header);
 		keys_header = NULL;
 	}
+
+	if (mutex_is_locked(&config_keys_subsys.su_mutex))
+		mutex_unlock(&config_keys_subsys.su_mutex);
 }
 
 static int __init configfs_dmcrypt_keys_init(void)
-- 
2.54.0


