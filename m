Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E87BF532C4
	for <kexec@archiver.kernel.org>; Mon, 23 Mar 2026 23:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d5dX1H4XkIVUdogReT0P+xEIybXWqypp015VM5/RpRc=; b=FX/1IdWZkge7h1Tt03uXh0Ez11
	IqCymC05vNrHUJHMp1coFRV7lwVsuaQxTCd7bNWvBYhyrGY06jK4Ajish1rO2Q9qJPJt2b6atoh58
	0rRmKOP8/sV055bE7oIsSaWlHAZvVFcsI/VwfTbXzAc3SAXG9yKV3ltH9e6Xr+0kVjIEdP4okIgNE
	FtupywPuMx7mmfgUPoHTAb3Yg+1uQb5IGcRXTUg4+CqNzro+dfj6UA2tYLpc9xdO6V2L2KnlMRRzz
	5RdtzjTWjQlzGKL1H2VSXLKLtM6S5WaCeO4zOd88bWQyNo+tQShTWGpo2o/mvjpX3CAJh4qO7ehDn
	d/ANSMPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pAr-00000000Bk0-2lBF;
	Mon, 23 Mar 2026 23:59:09 +0000
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4pAn-00000000Bdk-1qzj
	for kexec@lists.infradead.org;
	Mon, 23 Mar 2026 23:59:07 +0000
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-2b0554888cfso9524955ad.3
        for <kexec@lists.infradead.org>; Mon, 23 Mar 2026 16:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774310344; x=1774915144; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d5dX1H4XkIVUdogReT0P+xEIybXWqypp015VM5/RpRc=;
        b=HkH7/bpa+4dU8PXHNN0TTj/gmLmWq9cPh3qX2AvyBpdmIVFRNpbxntR5Tx5qo60ZFa
         ej5wvsEv0J/IkfAYyvrRyxXDwUmEapFiM58mgR6Flg1qU9gg5xnWsjBrk3YnlnKOZ3Zb
         i/vYzkwAcOe4cAzU/RnPhFvkCnXr61/ROuBZJ8zd3sKuTm7RMIrB7wgyr3NLWint+IO2
         8pJbbEvGhcZ4EOlHkLDeNC7zTCen78n8NRQ4ZeMjUeQuAa8oThNz+FMUgEr4fySNeUEh
         fJFjo8leqNMhXFdpnCDkpXsttQU2D6cQo2ozt7qtieY1wMIHcciNdti0PwOAGEO5TdS7
         p10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774310344; x=1774915144;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d5dX1H4XkIVUdogReT0P+xEIybXWqypp015VM5/RpRc=;
        b=PKeu0AqIhC4aYyLjLcZdXpvZEOfTHiSlwf3H92n2B52GOU9Dos/iQDiWCrSQJwAcUe
         +4PuSkVaDLEz7T4jBe+r343QxputJUlSnsiK2odvo31C/THWEuwnTX5WqAAwyuLOFyYt
         IkVabgudqviOEOAidQum4WaL905IuPJOJ54lW/aLD5hdsHpv3RkdV1PsnjVP9hQiMbDN
         7NF4z1RsKKIejQ16R4ng33efSDRyh/mMCdmJcw7ClOsLVslSIv/Ma4RrFeB9hvWlt9FC
         sjY7C7uJKsjwTc13GiPts8mrB/F1FvWSLD7ALFnDn02D+1KyILJohReN4k5j7VWPyHtF
         BPtw==
X-Forwarded-Encrypted: i=1; AJvYcCViSQ40DI/+UBP+sclsC9Oey+fRpwoR23tROaPxrogFRJqDq0ffqpq3MNOnaOBVmOsFgsLhaQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwhHIFPPXtCD9KLeHV+6zkbL+MUNP3PoZi/5qFy+VRiAqBpvQsu
	p4H1ovClANExopYxG6ngxK8lZGkkTdfCwwrGJPfACn2Zb5WaIYcok2pC5Ag49Jz7VQpQnDqwo9e
	UpEor5fR9iEYmhw==
X-Received: from plpn15.prod.google.com ([2002:a17:902:968f:b0:2ae:c5aa:fcd7])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:124f:b0:2b0:54dc:62c with SMTP id d9443c01a7336-2b0827c9a7cmr151447295ad.48.1774310343811;
 Mon, 23 Mar 2026 16:59:03 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:58:07 +0000
In-Reply-To: <20260323235817.1960573-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323235817.1960573-16-dmatlack@google.com>
Subject: [PATCH v3 15/24] selftests/liveupdate: Add helpers to
 preserve/retrieve FDs
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
X-CRM114-CacheID: sfid-20260323_165905_541027_1EFD6F22 
X-CRM114-Status: GOOD (  15.11  )
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
index 4390a2737930..2b04b3256382 100644
--- a/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h
+++ b/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h
@@ -26,6 +26,9 @@ int luo_create_session(int luo_fd, const char *name);
 int luo_retrieve_session(int luo_fd, const char *name);
 int luo_session_finish(int session_fd);
 
+int luo_session_preserve_fd(int session_fd, int fd, __u64 token);
+int luo_session_retrieve_fd(int session_fd, __u64 token);
+
 int create_and_preserve_memfd(int session_fd, int token, const char *data);
 int restore_and_verify_memfd(int session_fd, int token, const char *expected_data);
 
diff --git a/tools/testing/selftests/liveupdate/lib/liveupdate.c b/tools/testing/selftests/liveupdate/lib/liveupdate.c
index 60121873f685..3e070975a3ec 100644
--- a/tools/testing/selftests/liveupdate/lib/liveupdate.c
+++ b/tools/testing/selftests/liveupdate/lib/liveupdate.c
@@ -54,9 +54,35 @@ int luo_retrieve_session(int luo_fd, const char *name)
 	return arg.fd;
 }
 
+int luo_session_preserve_fd(int session_fd, int fd, __u64 token)
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
+int luo_session_retrieve_fd(int session_fd, __u64 token)
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
2.53.0.983.g0bb29b3bc5-goog


