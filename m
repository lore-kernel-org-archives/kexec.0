Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D7EC25B10
	for <kexec@archiver.kernel.org>; Thu,  2 May 2024 21:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8l9lCiB8RiVGIm7vwN6tkUsXHPKYe1xjz8TUtq5dcIM=; b=kOXDSsdr1uKQZA
	Vh3MeYgbqypAdG3EcjKhg/6jM5aSfN7rZg0MdUcvMbtSMRUvFrSGp7qh4W+QLmjebREtsERj2BBOJ
	znzbZEMoazGr9nyIYl4DWdcR2m1KMLC84oE0G4+rub0XPatiaqsXQHK7tR9Xpw632Vf0U8tuLmyhj
	WkDjpiJxReR0ZVHnxXdfPYdkZRtISJIAakUZB02JX4yyLIKPEwoEQQFYg7LBwK0hElUiggh4dHHpx
	aKZ4m6YMTIEP15B5N4RASFsS01CQxgMnuoHgYf79VHYEbab+Az6e38rmkqEv4eMtmGR5RdgMBNiPr
	t4Aw3j1PbbPYBRz2uCDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2dxM-0000000DxuN-2a9F;
	Thu, 02 May 2024 21:27:08 +0000
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2dxJ-0000000DxpZ-0drH
	for kexec@lists.infradead.org;
	Thu, 02 May 2024 21:27:06 +0000
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a58fc650f8fso699927466b.1
        for <kexec@lists.infradead.org>; Thu, 02 May 2024 14:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1714685221; x=1715290021; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfhcsvhSsmt38RwfQsVzDR+KRnJI3LFvmZGFu2ShhZs=;
        b=upgLV94NjDw2NkzEI9u1K6pkqJcgREazz8YFhvkaGz6V+UIGlia7wBEQ7a8FHR2/KS
         nuGoPt4T7JSsHBpbG9b5rVNmcDpZr2VbmhawxEP+PEN3m2PYVRmDs1Ebku32SZ6CQxKw
         hh/6H9E86W1Rogh1g/AjGEiKxYDFeY/anNbnTGH1Hb1zC5e29e3y08/jvBk4HiqXATlD
         NE/1kCW3N2fLVNv03VS0uhWAGWAFM6bHiO8dxJe8+lpsm0X9k9RYj/NpAYjxrdITBgzR
         Yh7tBt/wvCY266EGsYfEtSlrxc6B6fFSIpEicFjckoD5pWYbZYBtZj+D0+1tTrsE5D+M
         LjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714685221; x=1715290021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NfhcsvhSsmt38RwfQsVzDR+KRnJI3LFvmZGFu2ShhZs=;
        b=YAXuWsuahGPU1dEmuFPU8VDDIvYncNptUu1J9ziuu6RKJoB2YSUSmRRQZPX5IMJnKX
         3mYxYC8ojiApF8nVS04yQaMjDZ9BibQKoaEyuxoqQWp8gHYVhFyodkBT5cC984kX8c75
         ibNLheVyxR+8Aa3SK1bcqsVmTZvE9r0K4Xcxt7evc3lSXzx6Lu14hYQ6jKXaUko0LKwZ
         xUMSaacQxluXyqL7jq6QFpt2q8k019y7V57ktm25C/bKyNO+JW3r1AkBEbiCuHvyhfOp
         BVbdB4SSS4WcTC3JFzDufNdn6j/RFT17MuLYWGAoXnxGXBKniY1L3JwiTnzR8dvkU+iJ
         RpeA==
X-Forwarded-Encrypted: i=1; AJvYcCWXrFPvdm1lLWf2xRQBY6iBJTWAXWhhvpzg+wL3uemTGSVpopKwLQw36woKAPUFyj8GJ0u9p3x+gPvXyN1w/3P9ZwNxjEFSsYGX
X-Gm-Message-State: AOJu0Yw4OYY9MHaQfLjyO/8ruFnufriWoK6GF4BaOz1vCOyFsbpmyYWb
	AWT5QtY4VOufjnlFqDmYslwiPuoNCyi+SQmptcvJ2wJjgVlg0JBVNSNV3MwoUTU=
X-Google-Smtp-Source: AGHT+IHsnl7RJpj3ymJ81i/nNwARVNtUdevH3erTDDDAwNmlYmS3UuIDG1Pd4ArMQB2iLnX4wSe1VA==
X-Received: by 2002:a17:906:fcb3:b0:a55:5ba7:288a with SMTP id qw19-20020a170906fcb300b00a555ba7288amr430875ejb.33.1714685221271;
        Thu, 02 May 2024 14:27:01 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id my37-20020a1709065a6500b00a5981fbcb31sm354886ejc.6.2024.05.02.14.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 14:27:00 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	kexec@lists.infradead.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH 3/4] overlayfs: Remove duplicate included header
Date: Thu,  2 May 2024 23:26:30 +0200
Message-ID: <20240502212631.110175-3-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502212631.110175-1-thorsten.blum@toblux.com>
References: <20240502212631.110175-1-thorsten.blum@toblux.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240502_142705_293284_9F6C417F 
X-CRM114-Status: UNSURE (   9.60  )
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

Remove duplicate included header file linux/posix_acl.h

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/overlayfs/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index c63b31a460be..35fd3e3e1778 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -8,7 +8,6 @@
 #include <linux/slab.h>
 #include <linux/cred.h>
 #include <linux/xattr.h>
-#include <linux/posix_acl.h>
 #include <linux/ratelimit.h>
 #include <linux/fiemap.h>
 #include <linux/fileattr.h>
-- 
2.44.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
