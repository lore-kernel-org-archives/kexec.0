Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC70C3DA6E
	for <kexec@archiver.kernel.org>; Sun, 17 Dec 2023 03:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g83bUuwPNOw2J43aIJQvhqWHxb1Yh1wQT+AXyci7c6E=; b=d2mP3NvxBHwshK
	D1QizIzIrEcaVX0xrsOlnf7BTI9ZrfQYCZ9gnBUfmZId2wHNU5r9xHVW0PUVV5NXO4tNzLkcYYyPK
	CknBClAUZdg1CVHpm5sToyerXosonZFJsMNMSo6BC8uJrn2MUTfj6lCYIRMMVMArUbzIQ3Rkb0/mW
	+5Ult5mnGNrLVF4m11XnkeEWiY5XAzJJVlQ4oPMGWsOTnZOlRATEs8aEi2ib4eGCoJcABVF85Q5Yn
	nihhpIy/lGhgfpdGGux/mLEli6FMjsMp2ZPBhW2Ee9z1kY39miI144YmV77DRScu+X02ADFctv/co
	e2o5x5anYDes4h7O+2Mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rEhxN-0075EL-00;
	Sun, 17 Dec 2023 03:36:45 +0000
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rEhxK-0075DK-1k
	for kexec@lists.infradead.org;
	Sun, 17 Dec 2023 03:36:43 +0000
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b9d8bfe845so1639668b6e.0
        for <kexec@lists.infradead.org>; Sat, 16 Dec 2023 19:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702784201; x=1703389001; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jscYpo84xIlTIrjQEZDT5YAVqLMOQqnP0eOYv7+MbRw=;
        b=Tzyd1TLadhK0XfCzWa4TfgbbC8P57QqRefRH1ZgkZ19VY+XA66lUTJU7H6U0B4FuvE
         6cZg4AdgkkB1bqsL3FGvb+xlwlxIS8rIsE3SbTSUzAkixP07uWEcABAy6jRPxMATm9pH
         tMcRlxNYX2v4l5TV9O4UWiZ1/NFuUqpI20gXWC4iDg2nK/CqJvhlCcIyzuqeRjy7Hr3w
         4rC0Radp1p6AJz7o9vcMXehf7cWwBG0oQz1BxcMBm4W0xlWSt2VD1lq9MhjaLfYZ2LQr
         /Xe9yOP3p7xJ0EE5djGAAzO3koH6lqS3TD6espjt6W1JQ2VjxTpn6ULKslST7axeTTcj
         pnsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702784201; x=1703389001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jscYpo84xIlTIrjQEZDT5YAVqLMOQqnP0eOYv7+MbRw=;
        b=CQG7b5bUokE16F7E5TRfG4RclmtHs1DqYgFEeAxDtKejCwDXZceOzkdJCD1dSMe3mh
         jRufN4R8Fe4k2NwrxB5pnLkeTIBSPGhMmUMFscG6UF96P9peWh8V0aPghiamWWXxtPz4
         JUTC47Fb3znshchKfAdk7m6BTJOL9Jz6kT2xtNSoMhT2BWOO+mG92HPrpGwql8yduZBc
         u/+prg0Iri0x5HXm9DPLCyY86uSORl1ojT+HG/QD07prEf2Jy7cCit7BAZ7BUD7O2iXH
         1oS0IIsOEYD08juKNutqK6Yf71isEKQ5WpX0aetq8zZWo493ZTnIlsHWf8kkS/F5tmXd
         7UsA==
X-Gm-Message-State: AOJu0YxuLs5NVAH/ar4ooxsid4giZ00ltr9Wa/pVLp32DHOKBG9UWRkN
	iOwwPBpUuzqlwDbZzF8Xgpg=
X-Google-Smtp-Source: AGHT+IHxfeJ2/5ZmVlwHFplWezFuqpKI/InwfEnH6Lv71yXTfqFxulFEco7zz2dzTje/5OiY9iM0Sg==
X-Received: by 2002:a05:6808:3197:b0:3ba:18f:62c6 with SMTP id cd23-20020a056808319700b003ba018f62c6mr17936532oib.7.1702784201449;
        Sat, 16 Dec 2023 19:36:41 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id x26-20020a62fb1a000000b006ce48a0b7c6sm15768820pfm.109.2023.12.16.19.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 19:36:41 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	x86@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Eric Biederman <ebiederm@xmission.com>,
	Baoquan He <bhe@redhat.com>,
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH v5 3/3] x86/kexec: use pr_err() instead of pr_debug() when an error occurs
Date: Sun, 17 Dec 2023 11:35:28 +0800
Message-ID: <20231217033528.303333-4-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231217033528.303333-1-ytcoode@gmail.com>
References: <20231217033528.303333-1-ytcoode@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231216_193642_579535_E77199D0 
X-CRM114-Status: GOOD (  12.75  )
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

When an error is detected, use pr_err() instead of pr_debug() to output
log message.

In addition, remove the unnecessary return from set_page_address().

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 arch/x86/kernel/kexec-bzimage64.c | 2 +-
 mm/highmem.c                      | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index a61c12c01270..472a45dbc79a 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -424,7 +424,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 	 * command line. Make sure it does not overflow
 	 */
 	if (cmdline_len + MAX_ELFCOREHDR_STR_LEN > header->cmdline_size) {
-		pr_debug("Appending elfcorehdr=<addr> to command line exceeds maximum allowed length\n");
+		pr_err("Appending elfcorehdr=<addr> to command line exceeds maximum allowed length\n");
 		return ERR_PTR(-EINVAL);
 	}
 
diff --git a/mm/highmem.c b/mm/highmem.c
index e19269093a93..bd48ba445dd4 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -799,8 +799,6 @@ void set_page_address(struct page *page, void *virtual)
 		}
 		spin_unlock_irqrestore(&pas->lock, flags);
 	}
-
-	return;
 }
 
 void __init page_address_init(void)
-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
