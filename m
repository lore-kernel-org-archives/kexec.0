Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4704AC2D0CD
	for <kexec@archiver.kernel.org>; Sat, 17 May 2025 14:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XP98VUjPlVFdkM5YIwU/G78ZibDz0+CgSoPoHCaILcQ=; b=IdNe+P/L2trC4kxQfiL3OpI6by
	PCVU15tW6Zw7ZABXL5M/SeRaxCliq8lkWkaZIKtORzuFslyhgr5w0dyf520IPYLPYhXdePDq3MOZK
	uWqfzFLeEXQ2j2BWBJPqjDJr8gT9fMvLLKOar3DcyO34r23cjk2mlRHokLGI0l1RNjY+Bg6fnWTey
	1okMlXCnd6fViP2McgxAAwuOuj4mDZ+uwFoF5kFu/bh+0rGUnnBSPXhFVqMUnF1ND3DBLbwbCvnqm
	xnwdN24WVLJjDsSdrV9NTFStsMP7efU57fJGHop5mlp8bndNpZCLII6So6rXzA2pMCXM5rlo1h7WR
	dD6lEd2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGJ0O-00000005ru3-28qC;
	Sat, 17 May 2025 14:59:16 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGJ0J-00000005rtf-3lsk
	for kexec@lists.infradead.org;
	Sat, 17 May 2025 14:59:13 +0000
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-742af84818cso1233194b3a.1
        for <kexec@lists.infradead.org>; Sat, 17 May 2025 07:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747493950; x=1748098750; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XP98VUjPlVFdkM5YIwU/G78ZibDz0+CgSoPoHCaILcQ=;
        b=QWTjQg0tGyvTMD6JwacSfPXP1472Hh2UYqM2rroufBm1aAw1qfKYQBdvjeQr9XxHvt
         OeY2nFpL43+r22/M8HAWY5oRJ0RrHJ9v2/6njWGO1D5MnddGbcvUBQJ78aWYkbAbr3XM
         llFi9VDmFY1AA2ZlFSaBM8c+tbWmCsN9L5vPlFRYtvnckDgttplqxKgidN+4O+9DWsOa
         fFJnsiT+gyfyGmJI/EVAK8DeZpfjDbGtx6HQCVr9hKwN7hpKQqfip/GQNztifc6CJnZ7
         u3hphYWu9/dwpQot1YoQJuHmVcuJy4amOOrp2t+unD6s684PepGodsniS2qrUQfzVQQ6
         jWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747493950; x=1748098750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XP98VUjPlVFdkM5YIwU/G78ZibDz0+CgSoPoHCaILcQ=;
        b=c48v4v4ats0PC69TljGXZHFgariRiRDoC4iVKKeyBuGal4lgGGcoYg7vJvJt2R6p77
         pv5hO+n61aKKJaSmW218MR/Z9RE/bJPNCmGTc0B0jF/t8te7o3ho0kJdmIGXK25RBCz0
         PvsR0506Fww6jOBANOBKmaz6NxsW7Ezwfrwz2itrxY0NBdKfWPe+87gj87TqDm70bNBH
         fSb5wDvdGvpAj9PqeJTlIMx0xKllCoHbom0aXwGblBfrCRsFmUBebGWENpOZtkI/jb/T
         Lg+UOEbBLnY5Vf8vcjM9whLBTtA2NqGndVAsoYxfYl0zNJwKMiFakA1/nucIf7zNP8Dx
         Rmig==
X-Gm-Message-State: AOJu0YzkZz0UjM5EmD5lvIAYSJrQAIbcexpGDc3FHOImE2W7q05/G+kE
	XkgOPkZg6vc7K28HdZZiKp9tCESaYJ/TWD4mvmqI4db/KI35BNc6hBAJ8b4hIBmg
X-Gm-Gg: ASbGncvOBVdNS3jdb2HfTRLunT0TF/+PJ+sgXPioKA9G9hMg/JpWF73BRhESNhetxUs
	0Xcfvs27NpgeF4yci8LqS8HQTxQfil8uEINBFBy4w6OGgeAT378L1UTMs4j0Eu7x86Qxjwtbd3y
	Im5DhuS9j6gQfGD6ObOsUoEA68aOF2a0kb/WWeV6h0InHXRXX06sHmCDyvsIVHZvk7Rt/0NdzEm
	hbSo3nlZT9NPSHcYWJZodidtTaDTcKTDFVCQY73IJeUZOwB/qkiwjZrTjkMI72+Y5nslQtCr/av
	5qDL7IrciXZrCA+dW9EDljmAfCbkSxHH6ROGoaV2dxA=
X-Google-Smtp-Source: AGHT+IGsJjkE5oOY2KfQmSYLymKp3bV0IXDrJORItWzeMqvdYSlmNwc6MFdhSFpXLJGfRm8elcO66g==
X-Received: by 2002:a05:6a00:91e0:b0:740:b394:3ebd with SMTP id d2e1a72fcca58-742a97ad507mr10415674b3a.7.1747493950276;
        Sat, 17 May 2025 07:59:10 -0700 (PDT)
Received: from apollo.localdomain ([2601:646:8201:fd20::5209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a96de11csm3264692b3a.31.2025.05.17.07.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 07:59:09 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: kexec@lists.infradead.org
Cc: Khem Raj <raj.khem@gmail.com>
Subject: [PATCH] ppc/fs2dt: Match function signatures
Date: Sat, 17 May 2025 07:58:52 -0700
Message-ID: <20250517145852.2488183-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250517_075911_938276_2117D674 
X-CRM114-Status: GOOD (  10.30  )
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

The prototypes of function pointers is analysed and
compiler finds the signature mismatches and complain about it.

../kexec-tools-2.0.31/kexec/arch/ppc/fs2dt.c:338:44: error: incompatible function pointer types passing 'int (const void *, const void *)' to parameter of type 'int (*)(const struct dirent **, const struct dirent **)' [-Wincompatible-function-pointer-types]
  338 |         numlist = scandir(pathname, &namelist, 0, comparefunc);
      |                                                   ^~~~~~~~~~~

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 kexec/arch/ppc/fs2dt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/ppc/fs2dt.c b/kexec/arch/ppc/fs2dt.c
index fed499b..4952bfc 100644
--- a/kexec/arch/ppc/fs2dt.c
+++ b/kexec/arch/ppc/fs2dt.c
@@ -292,7 +292,7 @@ static void putprops(char *fn, struct dirent **nlist, int numlist)
  * Compare function used to sort the device-tree directories
  * This function will be passed to scandir.
  */
-static int comparefunc(const void *dentry1, const void *dentry2)
+static int comparefunc(const struct dirent ** dentry1, const struct dirent **dentry2)
 {
 	char *str1 = (*(struct dirent **)dentry1)->d_name;
 	char *str2 = (*(struct dirent **)dentry2)->d_name;

