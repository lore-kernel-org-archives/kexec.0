Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 756F3C41535
	for <kexec@archiver.kernel.org>; Wed, 20 Dec 2023 03:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=emVTWKel8F5E5Q1trKvKi9lMpCUZLoM0EsXk/CGKFC4=; b=hsXWwQbMmT9AIv
	cpJOCwzCAP+NlhUwl+gNmKfSDFYJ8xEkerP8pKNEdFI1WCeuXjE7nTwAEKZwJyaCCOBHXBwlX6/X8
	kDb0++yU77lZ7ztKFz0K9VR0BePi76y5oqU2hOqNhkqHryb5vKkLp+yPB1VAxB2/lOhkfMbUsmWjN
	ugYjqnhcu7dJcrS7rytkAgReXDw/5waKbzefBSyhEuvX/MSHSQJ4FseECZ9UpCStfTKYukQ8p7jpL
	bCXNHzoY0wn5OrZL8qkCIdmliwlf/4K+wn0pRAlojqAMQC31AxUHi/L7kzEzaqt4SorVZKbNycnGR
	7ab7SZBxWeiDBhwLPEFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFmq5-00G1B0-04;
	Wed, 20 Dec 2023 03:01:41 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFmq1-00G19z-20
	for kexec@lists.infradead.org;
	Wed, 20 Dec 2023 03:01:39 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1d3ed1ca402so2327225ad.2
        for <kexec@lists.infradead.org>; Tue, 19 Dec 2023 19:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703041296; x=1703646096; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDcGZt780N7cf+8KzhOequQQWw83UVMubMF6UVq890A=;
        b=grKwROFhmQRvL8id7RTMyr55h2QsjGtMkNZiSRvfT3ind8Zt4EPdcE92R5jox5Nchf
         dq7Wjs0WbQvKaoC8Eyx0u+vJRwIcbWU42RgwyjDfAzoYYf3+JpnIsieis1zNuwX1ZFdw
         Pbgs9b6QlLVS8hn+yXfpPEu4/6aWXr3aiBtVcgtptI6sMXZ/h/1gVdjSPtooazgZqp2M
         ZPWuVdmxomhp1RWM/lTcOStRuwOivZ7sPx8hyt4ca3P3uUhD67Nl1PnBpo6pP4EjRXU6
         V8sBU2lQnIPFLEy4c1lLql1BIROBbA4ZDbtk/01lhAmDMWQ/XMv1ucx/jMyaBpLV9M5W
         NERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703041296; x=1703646096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QDcGZt780N7cf+8KzhOequQQWw83UVMubMF6UVq890A=;
        b=gb70cIK3bqENhpzwbsjfWqzE6Je8CR7zxQXYOpaIWzTwGb9PRFc2IfN5LaRcEY8y4e
         WQdYT9XB1HUvWT4CJcPDlMMOu68VjeTa2AqUnz2C/UOCedg/TWPweooyWXad2YWqxI68
         7NZyO4s1U8qckekMs+DKQdFq64MpsdVDQ4Pn7ZGjiIKi+mrGult/f8CuqWD7x2hcX5bv
         cmbEwp0GhRLk9cvU+BppW9+Qxd0gUy15HS0OsH85WwhpQPsvlH+dnoVOKOgv//xL4Lms
         p34JlYGvvzdq8+TOOO4qFERVGRCDDpffO20rlAwREY4Plh/U9GvqOkN6xULEwPNSxXlH
         Ij9w==
X-Gm-Message-State: AOJu0YyV3pqSe7+nLlpGQPD7f8/W1meVOmEQfHqJhBmaG5F323GHckW1
	7ENoRYLLrs/SFWRQvx827t0=
X-Google-Smtp-Source: AGHT+IEDTnad5cVvWJ4zCxN1KdcFYYIzAX5inlXZMrowaBwcuL22z2qHYQWCeJlX6qAI0qKDn09DlQ==
X-Received: by 2002:a17:903:234c:b0:1d0:c418:1758 with SMTP id c12-20020a170903234c00b001d0c4181758mr23877565plh.66.1703041296453;
        Tue, 19 Dec 2023 19:01:36 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id w10-20020a170902e88a00b001d38410aa13sm8752200plg.192.2023.12.19.19.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 19:01:36 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: akpm@linux-foundation.org
Cc: bhe@redhat.com,
	bp@alien8.de,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	ebiederm@xmission.com,
	hpa@zytor.com,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	tglx@linutronix.de,
	x86@kernel.org,
	ytcoode@gmail.com
Subject: [PATCH v2] x86/kexec: use pr_err() instead of kexec_dprintk() when an error occurs
Date: Wed, 20 Dec 2023 11:01:24 +0800
Message-ID: <20231220030124.149160-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219122151.aa4ae562537abf74067588fe@linux-foundation.org>
References: <20231219122151.aa4ae562537abf74067588fe@linux-foundation.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_190137_654034_A8692F0D 
X-CRM114-Status: GOOD (  12.88  )
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

When detecting an error, the current code uses kexec_dprintk() to output
log message. This is not quite appropriate as kexec_dprintk() is mainly
used for outputting debugging messages, rather than error messages.

Replace kexec_dprintk() with pr_err(). This also makes the output method
for this error log align with the output method for other error logs in
this function.

Additionally, the last return statement in set_page_address() is
unnecessary, remove it.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
v1 -> v2: Rewrite changelogs

 arch/x86/kernel/kexec-bzimage64.c | 2 +-
 mm/highmem.c                      | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index e9ae0eac6bf9..4a77d5dd4bce 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -429,7 +429,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 	 * command line. Make sure it does not overflow
 	 */
 	if (cmdline_len + MAX_ELFCOREHDR_STR_LEN > header->cmdline_size) {
-		kexec_dprintk("Appending elfcorehdr=<addr> to command line exceeds maximum allowed length\n");
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
