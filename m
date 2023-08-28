Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B1AC71153
	for <kexec@archiver.kernel.org>; Mon, 28 Aug 2023 09:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=3iXG1QRF4oISHM91BOIq+TTTZ+mVdGPW1nAEjSZh5rU=; b=zp4sPdlrI6PPK7
	7FYWXVjPFziBJV+qvliVwrr8AUYHHUXrV1VShRQiSAyY66cNMZ9Nv4TKw0BMp3Mk31vdK1WHO66+Y
	IUz3kUzTrukVXEA0g956CmX0XnNU8EQOcA9FqeBU4COPu8kZNifGDF+auXgrxerrRbnFhaXkArMMn
	BQ+fl5GH91yGjbcjxfqKn7qKigfXjF4VC5E5E+14U9+b0veaE8qzl/BRFgi/Kb2rZoDyPo9FL85GQ
	3sgs5a/GBUSNMbxZ3mZl+3ej7ubq5EB/ytYhRQS8Tk10d57iTy0ezJ5kQqhnhlRWWNVOCqYkZ8fx2
	FvNvHC/qyMKRRVUH/4bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qaZ1J-009Gi1-25;
	Mon, 28 Aug 2023 09:58:53 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qaZ1G-009Ghf-2D
	for kexec@lists.infradead.org;
	Mon, 28 Aug 2023 09:58:52 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-401b393df02so29069725e9.1
        for <kexec@lists.infradead.org>; Mon, 28 Aug 2023 02:58:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693216728; x=1693821528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bT96dmZD0fZy5FTtNyTbk/Q9c5LAI1qIpMtHm5Rlpac=;
        b=fqlQ6QS2SQwOQ/62mjrMv+PfrxelL6S6WvcWNiDsta5r3SCQNbKLruY1esC9084gTT
         vb7H9g+BSJu7NjjjtMcNmYaziOzwSVpiUzCE/rSrn7KTX6pwNd/pGZ4A+mCG7iVmwJ+0
         BfUzn7zek7ih9qX3TJrTI4y8CaeMDJtlFJo1xgQoCxmkhRxkbiuI88M0g9mT45nVoM3Q
         +XwC6MsRIxyz4mFp6MYmCKMi15KlETS63ASjEFck5+aHk+bgLCoyCHmlgG7ok1Vzx8V6
         pGc5bOwAQxvwQuK7/dJW3Q0D5ZXWeMoRdBv9+GyPle7APKy4B/W39/nlOjMxi0d6dIi6
         EI5g==
X-Gm-Message-State: AOJu0YwnAfGgFqhfFO2Jeh6o3098QrbAMs1uJRSCNBRuVz0CMAeXuOZ7
	jacQCeE83GigEB4354Qhj2TFZMPhrVe3cw==
X-Google-Smtp-Source: AGHT+IEJ/Ap3fhgDcTnNk43P7d7hrtPbAiy0aaUfO8w8aUlYN1+Fx2DWS0dgB310PVZaXvkVgwQqOw==
X-Received: by 2002:a1c:f204:0:b0:3fe:4548:1892 with SMTP id s4-20020a1cf204000000b003fe45481892mr18678215wmc.16.1693216727902;
        Mon, 28 Aug 2023 02:58:47 -0700 (PDT)
Received: from rhea.home.vuxu.org (i6DFA5D05.versanet.de. [109.250.93.5])
        by smtp.gmail.com with ESMTPSA id z12-20020a1c4c0c000000b003fed78b03b4sm10136744wmf.20.2023.08.28.02.58.47
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 02:58:47 -0700 (PDT)
Received: from localhost (rhea.home.vuxu.org [local])
	by rhea.home.vuxu.org (OpenSMTPD) with ESMTPA id 8abd3988
	for <kexec@lists.infradead.org>;
	Mon, 28 Aug 2023 09:58:46 +0000 (UTC)
From: Leah Neukirchen <leah@vuxu.org>
To: kexec@lists.infradead.org
Subject: [kexec-tools PATCH] build: fix tarball creation
Date: Mon, 28 Aug 2023 11:58:15 +0200
Message-ID: <20230828095840.595-1-leah@vuxu.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230828_025850_741626_895BA94D 
X-CRM114-Status: UNSURE (   8.53  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

The fix in 41b77edac did not work, bsdtar still complains about
"hardlink pointing to itself".

Simplify the code instead: since the staging directory contains
exactly the files we want, just package it as a whole.

Signed-off-by: Leah Neukirchen <leah@vuxu.org>
---
 Makefile.in | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/Makefile.in b/Makefile.in
index 09bbd5c..3cad22a 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -179,8 +179,6 @@ GENERATED_SRCS:= $(SPEC)
 TARBALL=$(PACKAGE_NAME)-$(PACKAGE_VERSION).tar
 TARBALL.gz=$(TARBALL).gz
 SRCS:= $(dist)
-PSRCS:=$(foreach s, $(SRCS), $(PACKAGE_NAME)-$(PACKAGE_VERSION)/$(s))
-PGSRCS:=$(foreach s, $(GENERATED_SRCS), $(PACKAGE_NAME)-$(PACKAGE_VERSION)/$(s))
 
 MAN_PAGES:=$(KEXEC_MANPAGE) $(VMCORE_DMESG_MANPAGE)
 BINARIES_i386:=$(KEXEC_TEST)
@@ -223,8 +221,7 @@ $(TARBALL): $(SRCS) $(GENERATED_SRCS)
 	$(MKDIR) $(PACKAGE_NAME)-$(PACKAGE_VERSION)
 	$(TAR) -c $(SRCS) $(GENERATED_SRCS) | \
 	        $(TAR) -C $(PACKAGE_NAME)-$(PACKAGE_VERSION) -x
-	$(TAR) -cf $@ $(PSRCS)
-	$(TAR) -rf $@ $(PGSRCS)
+	$(TAR) -cf $@ $(PACKAGE_NAME)-$(PACKAGE_VERSION)
 	$(RM) -rf $(PACKAGE_NAME)-$(PACKAGE_VERSION)
 
 $(TARBALL.gz): $(TARBALL)
-- 
2.42.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
