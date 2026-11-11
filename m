Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A40060A261B
	for <kexec@archiver.kernel.org>; Wed, 11 Nov 2026 07:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=M6gSyX8f;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=xRXXZ9y2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=pnMzGzAa5g0/2fGWNckudlYHrRY4wmAMpp2a4sY0JEw=; b=M6gSyX8fyyUshaimeHrNItwnqp
	8z9ZsU3D1YJk5c9Nqx4GoTYgzSwfHqBdOiUx0YdVGA9zkg/OcUkRE7Wbb7Q1A8GuGgXS3Ix3Bky06
	zndSVbW6Wfic/rd2qHhz95Efmsx3bmZFaPyH0KFrCCZHfguSxjAtNV4CGz44tXOTFJyr94OcATJwg
	8ekgg+UdvELYhqg3TQiXQIoCuWHIAS3za3U4IiVyLrhGnat1u6c3kDnIPLHS6M7xNREiMda2S+C22
	9DXxb8WsouBDmTzf9gNoUxhsAID611O5gvNM4XQVPh8zlTZFngqATUDGXlbGE4irKr2fuY6r/se6g
	n7beClzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR39A-00000005xxe-38ke;
	Wed, 11 Nov 2026 07:53:32 +0000
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR398-00000005xvj-30lr
	for kexec@lists.infradead.org;
	Wed, 11 Nov 2026 07:53:31 +0000
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4a35db1f202so22534955e9.3
        for <kexec@lists.infradead.org>; Tue, 10 Nov 2026 23:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794383609; x=1794988409; darn=lists.infradead.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pnMzGzAa5g0/2fGWNckudlYHrRY4wmAMpp2a4sY0JEw=;
        b=xRXXZ9y2i8nE0ub9TT+z3hCqiJzZKpdAD0AO++IHd8xeu9rh8ht9/+1Fxpk9A4Bnku
         TvONnwDQAt133kiX8FW4kHPwXGqZPs0gZ96jq8xYdt+e4Z7E3/uqP/1MNU4MKobUI/97
         GcMgMy1puII2d+0Jm/BUhVe7jDSFoHQmXwUNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794383609; x=1794988409;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pnMzGzAa5g0/2fGWNckudlYHrRY4wmAMpp2a4sY0JEw=;
        b=IUFlot6cYm6hkqg6qSWGbL+KH4GLHih+ZwUdm2zFyNyrfbW2y7XqkP95xtXZIvUnQV
         7un7HhLzxTLy5w02ka5NE8iqN9r50pzbcJXUbqYVEzBC3MhxDwd7oHfq9u61WS1O51yi
         WTSK9iYQWUPZqU35v+kM//afwLsGrv8G2OsIf/wtXhP2UulsNFJPCiOw/nPzvuNZ52TE
         uKnCkqU/i3y/VjPCWyi8Mzmo3Mu7jGGVx8C4cNysJzJY5UAe8f69lYW3Bq7z4eWzw1OO
         ajrtWxov9G/s9dkjs8ZIP0KYo7iz9JFYLCx5Zl042gClegYTWzKL5pZBQeAopnbgZhod
         xgWQ==
X-Forwarded-Encrypted: i=1; AL+hErH5dqjSWmG1Ouzr7LRTv7rru3WeIHfpZTTKhaI1W8+CUkX1pytKc5hzBB/2bZGGUdNc3KQoDw==@lists.infradead.org
X-Gm-Message-State: APuU4Z8HROIung7fQ6oTpLqe6WjSpowa2tgNPPQe1UzMvGhv870S3Yea
	TziPdwzu1njPIvYXEAnSyPTEYTCYtEyIXCGfZN8EtMO80ca6hJWr9klmEay+fXUeLDk=
X-Gm-Gg: AYBFou1Zaiy6Em2XoSY7bDNbtUlPEfiu/wjtuLFKs6OHGkeAoploh65gnMyjOsBWwzQ
	TVPIlb5Zj0ensmKpdalavuBzaI1cWgIqScHLnPmJXGDW/W17hZIkKAPsMB1tGMtmShNt/D1t9KN
	1G66ZlzkTs+1rVWrPOHjTwxHn62ePlSq5ESXCYjM5xm43jJ2fnKOL68VDng+LsYXV68icdivj+y
	T6KYn1Gyipyd6fgkwncfVmBru6IgClVrfQJuvD+C1XQLwHmwx0tqOBmcHeXydgWsxyTnMlGT11G
	HWj5vXFUTIbZnjrekUKujfTSX1ju1T629KT4eFIJbIM5ZrKtPRXzPsFaZVxNmzWAPLtnTNWn98m
	8JUJ9yECzb9Fg/3P31AFJ5ueq1D/OqzRba+AeizvhE9whJTewnXaZgVRzAej/hdoVK7Qhbnz+VE
	DNZoloCrgVPwHiiOGaVC2NGqtwlZtzd/Y6mWG983YBh1IZHPSFC6avn0RtomN/Q0+EPDPYsEqh1
	TpwYAZ1uvRY4+P51nN3J4MX975NmDzqUGKvNHfnAHx1wIZ00zdk1ZmgpolCAS7ZnThs0Ex7jeQp
	lk0e99oyFyjodcMC8uzz7zq222tlj6gwpMdOFgZxxVpOUlwz9/RDftPjrkP/OWSZSRzJuLwGq8W
	asxcal052M9BsmpsVABue7saocDNa5LlHYkwcfjDiPG8ofVS03PMWQvPwDHs7P4rN4nUhWz7QXb
	ovzxhZKyNK4NT0RivOm6cD3aWOxotfBoBO9Ns/1yOGVa9uOMWJDTXa
X-Received: by 2002:a05:600d:16:b0:4ba:4395:56c9 with SMTP id 5b1f17b1804b1-4ba439561a5mr11281775e9.26.1794383609006;
        Tue, 10 Nov 2026 23:53:29 -0800 (PST)
Received: from localhost ([199.201.64.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49842f2a1f9sm9790339f8f.15.2026.11.10.23.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 23:53:28 -0800 (PST)
Date: Tue, 10 Nov 2026 23:53:25 -0800
From: Chris Down <chris@chrisdown.name>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Baoquan He <baoquan.he@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 5/9] selftests/kho: Catch missing or zero bootmem reports
 before kexec
Message-ID: <2edf50f498070047a363420b890cb7ff0294b87b.1794383544.git.chris@chrisdown.name>
References: <cover.1794383544.git.chris@chrisdown.name>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1794383544.git.chris@chrisdown.name>
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_235330_779611_CAAD4492 
X-CRM114-Status: GOOD (  13.79  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The KHO vmtest can pass even if the bootmem size is no longer visible to
userspace. Let's fail if /sys/kernel/kexec/kho_bootmem_size can't be
read or reports zero on the KHO-enabled boot.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 tools/testing/selftests/kho/init.c    | 24 ++++++++++++++++++++++++
 tools/testing/selftests/kho/vmtest.sh |  1 +
 2 files changed, 25 insertions(+)

diff --git a/tools/testing/selftests/kho/init.c b/tools/testing/selftests/kho/init.c
index 88a41b6eba95..ca9297d896d3 100644
--- a/tools/testing/selftests/kho/init.c
+++ b/tools/testing/selftests/kho/init.c
@@ -18,9 +18,30 @@ static int mount_filesystems(void)
 	if (mount("debugfs", "/debugfs", "debugfs", 0, NULL) < 0)
 		return -1;
 
+	if (mount("sysfs", "/sys", "sysfs", 0, NULL) < 0)
+		return -1;
+
 	return mount("proc", "/proc", "proc", 0, NULL);
 }
 
+static int check_bootmem_size(void)
+{
+	char buf[32];
+	ssize_t len;
+	int fd;
+
+	fd = open("/sys/kernel/kexec/kho_bootmem_size", O_RDONLY);
+	if (fd < 0)
+		return -1;
+
+	len = read(fd, buf, sizeof(buf));
+	close(fd);
+	if (len <= 0)
+		return -1;
+
+	return buf[0] == '0' ? -1 : 0;
+}
+
 static long kexec_file_load(int kernel_fd, int initrd_fd,
 			    unsigned long cmdline_len, const char *cmdline,
 			    unsigned long flags)
@@ -61,6 +82,9 @@ int main(int argc, char *argv[])
 	if (mount_filesystems())
 		goto err_reboot;
 
+	if (check_bootmem_size())
+		goto err_reboot;
+
 	if (kexec_load())
 		goto err_reboot;
 
diff --git a/tools/testing/selftests/kho/vmtest.sh b/tools/testing/selftests/kho/vmtest.sh
index 1e86ffcc3a79..e3e99cfe3ac1 100755
--- a/tools/testing/selftests/kho/vmtest.sh
+++ b/tools/testing/selftests/kho/vmtest.sh
@@ -95,6 +95,7 @@ function mkinitrd() {
 dir /dev 0755 0 0
 dir /proc 0755 0 0
 dir /debugfs 0755 0 0
+dir /sys 0755 0 0
 nod /dev/console 0600 0 0 c 5 1
 file /init $tmp_dir/init 0755 0 0
 file /kernel $kernel 0644 0 0
-- 
2.54.0


