Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBDFD73E8C
	for <kexec@archiver.kernel.org>; Thu, 29 Jan 2026 21:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iXsfpp7fYjSPi1nIw2ScrDnrjqTlWGi7ZArDWIRjDgk=; b=X8vyQeqjCbbmxWGiPlW3bwNYTy
	mfDG/AUBPBiPi5RWyFhi3996btmSwfJbe2RuHVs45z0lxV4IK0J2+x4dnYbw/22veqzPADC8zi6IJ
	25LqVNTCOBUng/8/07KOY+BRsSIlT8Z0lxa4vy2BAhZ5Yc9+spsLDiDRazBSTYU6XGDoFW68SibkN
	dKKs4IdVlqJmQFaFFUL9GJjj+owoIJc/Bo7FV+OGReTVbpixYjEBa6QdE8dFgFyyBLla5xtC7cFFY
	Fu1tLAetjSo/CfGA6kfnyUAOdf4UQ+/4DFVsTnaXd5V747nS10qgbVvCyToZ6HCIWeUsMbE7nMH7h
	4R0FuChg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlZWL-00000000fCO-2PA5;
	Thu, 29 Jan 2026 21:25:45 +0000
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlZWH-00000000fAs-0eC3
	for kexec@lists.infradead.org;
	Thu, 29 Jan 2026 21:25:42 +0000
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-34ab8693a2cso2888695a91.0
        for <kexec@lists.infradead.org>; Thu, 29 Jan 2026 13:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769721939; x=1770326739; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iXsfpp7fYjSPi1nIw2ScrDnrjqTlWGi7ZArDWIRjDgk=;
        b=akE8MRJSPa7GCfGwZFE3WFhth8x7yhUP4Y+DHmiQAC2A4m2SM0LER4qrlLJ07A6J36
         sw/ZNPx9QW1eHzac+5WUnZr/QvcIYMQZychNMg+uQaZhEHL7tT7NXJNojyGagbVw2W/7
         JgRR/8K4IVqSdkQ7oskC6MpyBzjsSmEZz0D1jo4JUV34Vp8eFkDT11oMWqV6u2bXstBc
         85eVdSzQpbAT//KOdTpKmdYah1uMCRHfuWn5ksgxMI4Qm7iYy0OOMWFssW7CAc6IDw3X
         107FB91bEYY1wYus28SJLGLr9pfkIy6Gu+/EfeIRpT6m65IIGi0RFrp6tQxJfVr0KasN
         Wrwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769721939; x=1770326739;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iXsfpp7fYjSPi1nIw2ScrDnrjqTlWGi7ZArDWIRjDgk=;
        b=MewuRMF443D9QkkzdSHJR5rEXe17BZvay5gayY2yh+YqgHidv0SI0A6SNAb+8WbAyA
         Pu5F7F6XnTS8v7ozlQqnBThUgF5XH1Aqh0latXYYwis5nGsepDc5I1MHWFM08cRVblK7
         +QkdOUnAXFeUlDbHkfRXcvJORkMBgcSe3+ClReefSKMjmpskQsfN1UMUycRX38QW9c7i
         uHO3DVQE3vK8kYtH3u6NYDLE92MBulgwhvM0NU1OeYCL+G4+gGjqixS8Q4Yv4g+IshD0
         uSfyXSbYhNpLOkW+QhSIBfLNca0rF1KzMwnJsxWizwrnXyk+9d6sP68/G5T6EbHjt1kQ
         FPMA==
X-Forwarded-Encrypted: i=1; AJvYcCVLRjydn9UmPZ8NavTBCLxCpUWkTefJHAKR/D5nrBsrkhLCz/Ogk/1p9UqwvztzP+fUsWCm3g==@lists.infradead.org
X-Gm-Message-State: AOJu0YyM7ue4IIICfcMSpYD/IC9xV3+zHy52EHi8HsxEYIkLIPEZ9eUQ
	qLSxKr2kIlv0/NcAe/AQ49prFfN5Pq2+tQ3dp027PqSriQI8JNwFYiFb2dlJySQo5gGaWvefSme
	Ns1ulkYaY6lYOSA==
X-Received: from pjyu17.prod.google.com ([2002:a17:90a:e011:b0:353:454:939c])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:17c9:b0:353:356c:6840 with SMTP id 98e67ed59e1d1-3543b31688fmr768863a91.14.1769721939368;
 Thu, 29 Jan 2026 13:25:39 -0800 (PST)
Date: Thu, 29 Jan 2026 21:24:48 +0000
In-Reply-To: <20260129212510.967611-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260129212510.967611-2-dmatlack@google.com>
Subject: [PATCH v2 01/22] liveupdate: Export symbols needed by modules
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	"=?UTF-8?q?Micha=C5=82=20Winiarski?=" <michal.winiarski@intel.com>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Raghavendra Rao Ananta <rananta@google.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	"=?UTF-8?q?Thomas=20Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>, Tomita Moeko <tomitamoeko@gmail.com>, 
	Vipin Sharma <vipinsh@google.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260129_132541_192786_2514AF8D 
X-CRM114-Status: UNSURE (   9.26  )
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

Export liveupdate_enabled(), liveupdate_register_file_handler(), and
liveupdate_unregister_file_handler(). All of these will be used by
vfio-pci in a subsequent commit, which can be built as a module.

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
index 35d2a8b1a0df..32759e846bc9 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -872,6 +872,7 @@ int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
 	luo_session_resume();
 	return err;
 }
+EXPORT_SYMBOL_GPL(liveupdate_register_file_handler);
 
 /**
  * liveupdate_unregister_file_handler - Unregister a liveupdate file handler
@@ -917,3 +918,4 @@ int liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh)
 	liveupdate_test_register(fh);
 	return err;
 }
+EXPORT_SYMBOL_GPL(liveupdate_unregister_file_handler);
-- 
2.53.0.rc1.225.gd81095ad13-goog


