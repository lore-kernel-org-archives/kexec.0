Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A7EC35274
	for <kexec@archiver.kernel.org>; Mon, 18 Dec 2023 03:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=bc/xrB53HiFtRqSJSkJXoev7OSkJc3HoaTw4iueBxqE=; b=36wYSNfB/7W7Th
	9iodQYRLPbMWjnTpvvqr2oyU2H8u3zhUMIcIHrF28fr1ByvuYM9cQ/hlC9KUgVT2etM9ILIrt7xnJ
	VlEtKG9LF66qjrZxQ2RiypRk9AkhO3Bk0TbBmbA6jUgMrJfHQfv5psWKFFRTLugrgFVWcLlUoi++3
	bcrQSMX//8hgNfayvmVu6ZKGSRr3mbq2bqKO9EPNCEl6s/QEMe/Ny+ReWmYGiUkbI9f9ddTP3qcgX
	6LYVs+R+qPmwj7E4lh7sOqTebHREouVkF8F+K44HtHrxhCVSeQBZnUXP/3vWdONNgy9NKwMI37MUv
	QTSDTJVbTWjn52U9Go4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rF4Un-008zLY-27;
	Mon, 18 Dec 2023 03:40:45 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rF4Uk-008zKV-2V
	for kexec@lists.infradead.org;
	Mon, 18 Dec 2023 03:40:44 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1d04c097e34so19068215ad.0
        for <kexec@lists.infradead.org>; Sun, 17 Dec 2023 19:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702870836; x=1703475636; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rz8IcWFPrYshTIpMuCdGWLpKzFo5rZN3OabmtrFosFs=;
        b=XNq4M+HXQekommd6t6yng2NSIHQyypXflZeFVF/5P5zDxzQBK2WEg349WtLSTNfMbx
         8iMFFOgurWu19jxwOhZz4KLY4XlAJq/3Hst7K+r/MMXY3i32+lT52hsA34TbHP1HzgfB
         giX1Y6K1FMTXEHa1LKz6JPly/SsMWAo0wf1sduy9i1zWHt/+8Rafr/W7KL5ZyKeAEPjR
         cDBYH1PKdiaF0mZIj7Qlz4xDgCcSvMUvF++UFMdFQi+VKTzZ4H5QiY9e6h0jOZ2nfsw2
         YuvKeKOE2giJDkmMf3N7YqbA+94DvEEz6jknUyBI/sE8U1USfVfoDGremzDpv4G6teO5
         pNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702870836; x=1703475636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rz8IcWFPrYshTIpMuCdGWLpKzFo5rZN3OabmtrFosFs=;
        b=nnrVveCn4jWVPE7lXA6xKrBP5/H3HgR4dJJWF/xPqH2nrId7wuaXeRz70oFEapbU2e
         CyZAvihpRceL3yps6Egkx9IvUZpS5tbUaiPWsil1J0C7ms00BNkaYstI+NREZX48vP/3
         43t+83YJ/gR6XydYTPjurP1VKFgWvZ4BRGpe03cEP3RIxtfpLhY/1xef9ZwqR6KfNtZa
         mLQRxEgGM2usDHNRMPtiKw0Tu/KYbuVCBVzA+nrJGs3VM4DYckv6WTifgM6KV/SoD8wW
         AqHodq5dmb0hLrhfVqpIyZk5JRZkiszOFGwrhWu0ZqgoyTDUtSLdNVMc0Vr2mDt1h2uO
         RP3Q==
X-Gm-Message-State: AOJu0Yzzj23NF5ETjG60R0YJPs4vZt+VI3cMF2AANcUcXoeWL9eHeo+/
	rps1GKOn0EwBCM0tDKwDwhXtZ4rVIg==
X-Google-Smtp-Source: AGHT+IFahCfvx1/CbJczzX01ofVsrnySeJPh7YvA2dXKNATCrPA4pKLR6p82T8cydA88fmMHdz/nhA==
X-Received: by 2002:a17:903:32c5:b0:1d0:6ffd:6118 with SMTP id i5-20020a17090332c500b001d06ffd6118mr19113719plr.58.1702870835855;
        Sun, 17 Dec 2023 19:40:35 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x5-20020a1709029a4500b001d340c71cc8sm8557804plv.128.2023.12.17.19.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 19:40:35 -0800 (PST)
From: Pingfan Liu <kernelfans@gmail.com>
To: kexec@lists.infradead.org,
	linux-doc@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>
Subject: [PATCH] Documentation: kdump: Clarify the default size of memory reserved by crashkernel low
Date: Mon, 18 Dec 2023 11:40:20 +0800
Message-Id: <20231218034020.15341-1-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231217_194042_812851_2C42A048 
X-CRM114-Status: GOOD (  10.10  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: Pingfan Liu <piliu@redhat.com>

The default size reserved for crashkernel=,low is decided by the macro
DEFAULT_CRASH_KERNEL_LOW_SIZE, which is based on arch.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
To: kexec@lists.infradead.org
To: linux-doc@vger.kernel.org
---
 Documentation/admin-guide/kdump/kdump.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index 5762e7477a0c..a021ff155012 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -310,8 +310,9 @@ crashkernel syntax
    region above 4G, low memory under 4G is needed in this case. There are
    three ways to get low memory:
 
-      1) Kernel will allocate at least 256M memory below 4G automatically
-         if crashkernel=Y,low is not specified.
+      1) Kernel will allocate a chunk of default size memory, which is based on
+         architecture, below 4G automatically if crashkernel=Y,low is not
+         specified.
       2) Let user specify low memory size instead.
       3) Specified value 0 will disable low memory allocation::
 
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
