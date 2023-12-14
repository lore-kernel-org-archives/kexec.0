Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B212C4332F
	for <kexec@archiver.kernel.org>; Thu, 14 Dec 2023 16:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iP6g2mAKg/rahChNGtOaRln8olvo7s6GvNSPf/B7XzQ=; b=WZ/NJdEarWLSMO
	61oWqoRFjH4HLFgc3vDxLTXanZ/KvGRobQXLNHeKMncR3VVL6zVx8fbchViPZq8JthH0Kaw0MR/CT
	50MUr+p4Ytaye3L+WJDn4c5zGoxgcGkrJ2Dm/7Cu74hj/o3h8VjprP4MpskPXCYX5t1jxFxy74ao3
	wKBy06vk/W/wOKm4Fdmoz5BKsp0oNUXBF6bLflckNZWfh1lMSYdWPEi31x6bOKUAG+n1wNLa7CUWB
	GGyBOn2FWsZ4E1zcTxhYF6mxc1Q5ob1x3UdNlbc90Uz7uexIpOddC5fzs76SjQmu073zDdONPqRx1
	WBSStve9ZDBASeToFCjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDolO-000pkF-0j;
	Thu, 14 Dec 2023 16:40:42 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDolL-000piz-1a
	for kexec@lists.infradead.org;
	Thu, 14 Dec 2023 16:40:40 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1d3448937ddso19071065ad.2
        for <kexec@lists.infradead.org>; Thu, 14 Dec 2023 08:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702572038; x=1703176838; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRn1DTbbmWGLB1nxG36xstbG89fQMD3XiAVHtLkUKlI=;
        b=TO/z4Ze8q9Rp92UfG4V2I96X9OasVlWQSsGHLzWZgNA25X/84R9uhXs+woxkR/kXuC
         m9tmUCxKU9SrOhEkwUyaTRjKrAG0rfPGfTFcJNhIyvQU4KcmaT7IDkk2h5SO+d0guWsS
         Xuu7nL5wIVLrxVtIYq7uRePOa+hjmRO/tn3NTUsNArWQOL9iBJvZU57CGf9itj7I1RoC
         5GsuJZHJFoexVuQCJn8IToWBILeC9i7WvWFvBOoeSmQ5SbGbWM6vzvpBtnZMUsXVxvw7
         RaC0sXVqRof8nq7Vo5XQXItLFsrIaM4ue06BzRDtaqoUZUXiv51Zv9OQAxzn0nRnCRx1
         nFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702572038; x=1703176838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRn1DTbbmWGLB1nxG36xstbG89fQMD3XiAVHtLkUKlI=;
        b=djN/v8DQn5RncycP430F/xoa/e/tqpFazVGNVTwQjPd73+dlvRPBdojSnqTKT+vu/l
         MEBZGUHIgr1DRPWrlx4Fp0143DmVXmS/kzTSF667ViI2cxgrlUbNlJLMPASp3wDXQGdy
         OULDiKWBtDZK/QRvTAtl8bEOEtLIbNFJ4Zy9CI6pfBPzJpYomiyPSArWtF11eEWNP1dJ
         MjPdrYoYWcmFiRtjh3EMCkY64qd1TfEkSwfASVsYhOzXO6b0GHAWHN0VLVszGBo2aJO1
         pc+5kaf0vEmodr98nCvTp1UjvbE1tV58xxAfZkUedi5OT+irm3WD2NHPrVhKvTZU9OIo
         AoLQ==
X-Gm-Message-State: AOJu0Ywb2ftpJSxffarQnLIf70c/VKTlARFDzfQMZvUIXqxyRW/Wk+tE
	9J6z8G0LW+/QwKwT3vycbAw=
X-Google-Smtp-Source: AGHT+IESkQlL7JhHRaVr6xofo//eAXSa64RW84yr+T6FldHHTCobQXcxJcnZQDwsiYeR88Wr3ZnhTQ==
X-Received: by 2002:a17:902:c3c5:b0:1d3:64dc:e9d0 with SMTP id j5-20020a170902c3c500b001d364dce9d0mr848917plj.26.1702572038411;
        Thu, 14 Dec 2023 08:40:38 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902e74c00b001d0b32ec81esm12595897plf.79.2023.12.14.08.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:40:38 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Eric DeVolder <eric.devolder@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Takashi Iwai <tiwai@suse.de>,
	Lianbo Jiang <lijiang@redhat.com>,
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH 2/3] x86/crash: use SZ_1M macro instead of hardcoded value
Date: Fri, 15 Dec 2023 00:38:41 +0800
Message-ID: <20231214163842.129139-3-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214163842.129139-1-ytcoode@gmail.com>
References: <20231214163842.129139-1-ytcoode@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231214_084039_532595_E1527A43 
X-CRM114-Status: GOOD (  12.80  )
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

Use SZ_1M macro instead of hardcoded 1<<20 to make code more readable.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 arch/x86/kernel/crash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 792231a56d11..249b5876e7ec 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -170,7 +170,7 @@ static int elf_header_exclude_ranges(struct crash_mem *cmem)
 	int ret = 0;
 
 	/* Exclude the low 1M because it is always reserved */
-	ret = crash_exclude_mem_range(cmem, 0, (1<<20)-1);
+	ret = crash_exclude_mem_range(cmem, 0, SZ_1M - 1);
 	if (ret)
 		return ret;
 
-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
