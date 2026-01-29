Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E3DD73E90
	for <kexec@archiver.kernel.org>; Thu, 29 Jan 2026 21:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=idHpW3SDccKJdv6+7GcWw8jBEpKmDKEMPgP0EwwfxqU=; b=44utzQrzN0BfqbNU07iqS3fYbP
	mUiwvb0bcRX8rQN34eBIGTs/KE8G6IBsNr3TrFzLly+HCW3EdykAUuQCWN3m0zHEhTRrOxxspyZSA
	Obu8eMcMam2cMzygOvBWdnjEnCPq4mxXJvzTUtt8VMSPUFAJKrT39AUsT+i2gTiQ1wK5PhPHAl48w
	6vcpmEnmSpyLUmCya28jmUKsbWXClzEqS8madNYBS5I6Pg+Pb3w99wOnBsKv/0zQMSiW2NAfEp0g4
	e11vChFtmuya2H+bCri73V9VOHgbrpayR47mJ4kQJbftQC1uGkT6lc6nct5jeY9MHsT5vViXySX46
	GP7h6+AQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlZWf-00000000fTT-0aVF;
	Thu, 29 Jan 2026 21:26:05 +0000
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlZWa-00000000fNY-3R4N
	for kexec@lists.infradead.org;
	Thu, 29 Jan 2026 21:26:03 +0000
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-81f48cec0ccso1322074b3a.0
        for <kexec@lists.infradead.org>; Thu, 29 Jan 2026 13:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769721959; x=1770326759; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=idHpW3SDccKJdv6+7GcWw8jBEpKmDKEMPgP0EwwfxqU=;
        b=WsO3Mv+Qm1wzaAA482GVpj5ySSNSElqiJzPQg2CUQu1QvhkeBaxD1SafmEG9I+0Bs9
         q4DlfzdDRT+WIRLcCPTSORsD3DFn3b+Me6ODUZahdK7UT8Tvj9cysVLQ51C4c+1EVZU5
         SGlOoWWv2MJSy2W5fDaYpumkiw57rKfE9Z+eGbW+Rh+TNQEZYoZXT2jWzuxuYrvBa685
         5SRMdr4VtflA3Tm7NFTMvb0NmAesnr1KdJl9pvtcfU0sS6qBxKBteiNEiW/CWJ5c68bH
         qg1M7xetTGrk+LkE3j309wLFhqyKw60X+T9IiWqVFOZZbVuXsp9bgN9wKKxW0mqrl2EB
         8Jqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769721959; x=1770326759;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=idHpW3SDccKJdv6+7GcWw8jBEpKmDKEMPgP0EwwfxqU=;
        b=t0mnxlHsUVAEJMOW0IpbbNu5xqv407NeiFI3rTPhwD/El9cbUNvzOiizKV91citCsf
         WRAiUl090YNQUT/hJPfctyH8eb4C4HIA+uX+2MazNc5NEFV0FBODqDVT1fibUfd+Ysw2
         izDK/PmUV5i/31grULeD8AJh/KhDc4lDMY58Qn09AWQxXY6grTAXkTjhgQFNOMnIm6zR
         ehVhsbUGdaEXaNTprYDl7xhCRECz6M92mWfpPblcAKN6/QwaSNtFWhnnBB18ShqGKLf3
         5LovwDFg9JfBs/xsIKdwI21H1Wh7XNzrPMyrhmi9LraU4Xx+JNTC5Yi+1Ijafdv6mW1w
         MQUw==
X-Forwarded-Encrypted: i=1; AJvYcCVlbNrt3ABhG3NsdYNZ3nLCT0tgwyjNdE0iw594mGPiMxqx79t0s+WWxJKXTGoaacD9yLxubQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxjIwypRixcXedILigaCgz0NZ3uowwoi7Chx995ThbruNS385Mc
	17YPGHRNUVBMKsdPRH7hHt2RlIOTkcrtcw/oAA85LzBr3QHyiWRSVxpVktDvLNd7x1EPjeqEmAL
	dgSigvBVza/m/Ww==
X-Received: from pgdj29.prod.google.com ([2002:a05:6a02:521d:b0:c5e:d16c:917e])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3392:b0:366:581e:1a11 with SMTP id adf61e73a8af0-392e0148145mr472290637.57.1769721958852;
 Thu, 29 Jan 2026 13:25:58 -0800 (PST)
Date: Thu, 29 Jan 2026 21:25:00 +0000
In-Reply-To: <20260129212510.967611-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260129212510.967611-14-dmatlack@google.com>
Subject: [PATCH v2 13/22] selftests/liveupdate: Add helpers to
 preserve/retrieve FDs
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
X-CRM114-CacheID: sfid-20260129_132601_845351_6DD05D99 
X-CRM114-Status: GOOD (  14.45  )
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

From: Vipin Sharma <vipinsh@google.com>

Add helper functions to preserve and retrieve file descriptors from an
LUO session. These will be used be used in subsequent commits to
preserve FDs other than memfd.

No functional change intended.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
Co-developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../liveupdate/lib/include/libliveupdate.h    |  3 ++
 .../selftests/liveupdate/lib/liveupdate.c     | 41 +++++++++++++++----
 2 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h b/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h
index 4390a2737930..4c93d043d2b3 100644
--- a/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h
+++ b/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h
@@ -26,6 +26,9 @@ int luo_create_session(int luo_fd, const char *name);
 int luo_retrieve_session(int luo_fd, const char *name);
 int luo_session_finish(int session_fd);
 
+int luo_session_preserve_fd(int session_fd, int fd, int token);
+int luo_session_retrieve_fd(int session_fd, int token);
+
 int create_and_preserve_memfd(int session_fd, int token, const char *data);
 int restore_and_verify_memfd(int session_fd, int token, const char *expected_data);
 
diff --git a/tools/testing/selftests/liveupdate/lib/liveupdate.c b/tools/testing/selftests/liveupdate/lib/liveupdate.c
index 60121873f685..9bf4f16ca0a4 100644
--- a/tools/testing/selftests/liveupdate/lib/liveupdate.c
+++ b/tools/testing/selftests/liveupdate/lib/liveupdate.c
@@ -54,9 +54,35 @@ int luo_retrieve_session(int luo_fd, const char *name)
 	return arg.fd;
 }
 
+int luo_session_preserve_fd(int session_fd, int fd, int token)
+{
+	struct liveupdate_session_preserve_fd arg = {
+		.size = sizeof(arg),
+		.fd = fd,
+		.token = token,
+	};
+
+	if (ioctl(session_fd, LIVEUPDATE_SESSION_PRESERVE_FD, &arg))
+		return -errno;
+
+	return 0;
+}
+
+int luo_session_retrieve_fd(int session_fd, int token)
+{
+	struct liveupdate_session_retrieve_fd arg = {
+		.size = sizeof(arg),
+		.token = token,
+	};
+
+	if (ioctl(session_fd, LIVEUPDATE_SESSION_RETRIEVE_FD, &arg))
+		return -errno;
+
+	return arg.fd;
+}
+
 int create_and_preserve_memfd(int session_fd, int token, const char *data)
 {
-	struct liveupdate_session_preserve_fd arg = { .size = sizeof(arg) };
 	long page_size = sysconf(_SC_PAGE_SIZE);
 	void *map = MAP_FAILED;
 	int mfd = -1, ret = -1;
@@ -75,9 +101,8 @@ int create_and_preserve_memfd(int session_fd, int token, const char *data)
 	snprintf(map, page_size, "%s", data);
 	munmap(map, page_size);
 
-	arg.fd = mfd;
-	arg.token = token;
-	if (ioctl(session_fd, LIVEUPDATE_SESSION_PRESERVE_FD, &arg) < 0)
+	ret = luo_session_preserve_fd(session_fd, mfd, token);
+	if (ret)
 		goto out;
 
 	ret = 0;
@@ -92,15 +117,13 @@ int create_and_preserve_memfd(int session_fd, int token, const char *data)
 int restore_and_verify_memfd(int session_fd, int token,
 			     const char *expected_data)
 {
-	struct liveupdate_session_retrieve_fd arg = { .size = sizeof(arg) };
 	long page_size = sysconf(_SC_PAGE_SIZE);
 	void *map = MAP_FAILED;
 	int mfd = -1, ret = -1;
 
-	arg.token = token;
-	if (ioctl(session_fd, LIVEUPDATE_SESSION_RETRIEVE_FD, &arg) < 0)
-		return -errno;
-	mfd = arg.fd;
+	mfd = luo_session_retrieve_fd(session_fd, token);
+	if (mfd < 0)
+		return mfd;
 
 	map = mmap(NULL, page_size, PROT_READ, MAP_SHARED, mfd, 0);
 	if (map == MAP_FAILED)
-- 
2.53.0.rc1.225.gd81095ad13-goog


