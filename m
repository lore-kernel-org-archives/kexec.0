Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6A0C4332F
	for <kexec@archiver.kernel.org>; Thu, 14 Dec 2023 16:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BUER//9xu6Oo/DhYymxG+dTjqJukto7gLYcWBBncy2w=; b=BBtkKSv99K6WoH
	YfLi62MPPbCqHlfv1N+QzIHuwmV3shwdP+TdE/uFpoi1vwiuYjSXbdABrQ+hSM1dV2t7QAzMFfSdF
	rQJgtOJf2mnR00L4d+QUomCBLCAiKePPM+Uo0NgtTl5iiz1t7dFM7cwxoqqMcVseft1xoGp8JkDWH
	wg7cugjcGNuIpEFkAQH++H/GMklEgIwVo1+jet2pwsdGAuLVwgRsd4PAwVKwajaD3R5Q1STIfu9Ga
	hTru+jLNdtHwC1De4QUBALsbDO0pXcFAAlHcvoPTCOh0+kYfKGN6m+bru5v9f5pxS7W7nhVF7ZvZ/
	cD4YNVKBFHsVJGMHpXnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDolG-000phH-1o;
	Thu, 14 Dec 2023 16:40:34 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDolE-000pgN-01
	for kexec@lists.infradead.org;
	Thu, 14 Dec 2023 16:40:33 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d34a6b3566so13745805ad.2
        for <kexec@lists.infradead.org>; Thu, 14 Dec 2023 08:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702572031; x=1703176831; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQ3Qdqt0V+ZhHZ5PlObynzpb2Nb+bXeilCmC71DhFUE=;
        b=E8Kh9/49AuaowT3eW3tni4IJ5PSWmOiTtusDbIkC4SFOulwvcLyrbuC9qdX/xDlfh+
         LPFcfocBxw/dKq7Lg/H7v2DniQIqY3DwtDtfmYlH/wfC/ieEPZfhuOCnVyxS6k5+mykP
         zaAYwiZe8V8TCg0jwM/VI2GRqRprjyyN52Rhvj1RRoJFIwLCybnuCZ0rz+gVFaSP6Thv
         en5sZtuO7p/1eXu5z3KkoYn1KJgfvuf/b5dQljDvK6q7+0pzK5JArGK3RPHTbSrNnKKX
         +AqQITrl+eFjimvVRWJ9yizOMfPRDNmASDX50QFwlyOUvR82rXEHdlzPX8fAnHHNmXVz
         agsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702572031; x=1703176831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQ3Qdqt0V+ZhHZ5PlObynzpb2Nb+bXeilCmC71DhFUE=;
        b=TjV+0Rb6TObH+3+NnyrLoBoShkzt7SgtWlynRmFmzveolM7N7Wb8yz3urBFdgZh0aX
         IjYkkAn1C0bT63y+pUv4z9fVn/6wXhCM8YO/7UmPv/NCP414mXtRJT1lVNdTzjVhQc85
         mrxR71Y5XDbBV4tBowzwgjTNF0YbTN5lagkt98Wi8sUS9cdqUc0ZYVDsYW80BhtNzMtY
         or4FA/jpkNyMQDNCmEB4Uyi04PaghjbO7tSnG/1MLrV4sp8v01E3NFZwugd0mzld1WXQ
         51IHSs0wyYcrncmekf7VJkhGcN1WOZqDa+gcc6lJae8KV3F+OemYy3WpWeFlvcKj5g5T
         35WA==
X-Gm-Message-State: AOJu0YzrVhgQyVLhUG040xF4PkxDRWwCMBvIcABZweH9dbgEpB029hbd
	M2kCV8UPjoFudiVXnn5Yalg=
X-Google-Smtp-Source: AGHT+IH2DfA4x6xKySy2o3svU4hSncEcqlwcYRSA4lqR7ptqakTKaNBJD+2zF0pkzhSr+P6S1sAA7A==
X-Received: by 2002:a17:903:22c8:b0:1d0:6ffd:adfc with SMTP id y8-20020a17090322c800b001d06ffdadfcmr6419298plg.99.1702572031036;
        Thu, 14 Dec 2023 08:40:31 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902e74c00b001d0b32ec81esm12595897plf.79.2023.12.14.08.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:40:30 -0800 (PST)
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
Subject: [PATCH 1/3] x86/crash: remove the unused image parameter from prepare_elf_headers()
Date: Fri, 15 Dec 2023 00:38:40 +0800
Message-ID: <20231214163842.129139-2-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214163842.129139-1-ytcoode@gmail.com>
References: <20231214163842.129139-1-ytcoode@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231214_084032_046533_496886AD 
X-CRM114-Status: GOOD (  13.77  )
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

The image parameter is no longer in use, remove it. Also, tidy up the code
formatting.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 arch/x86/kernel/crash.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index c92d88680dbf..792231a56d11 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -198,8 +198,8 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
 }
 
 /* Prepare elf headers. Return addr and size */
-static int prepare_elf_headers(struct kimage *image, void **addr,
-					unsigned long *sz, unsigned long *nr_mem_ranges)
+static int prepare_elf_headers(void **addr, unsigned long *sz,
+			       unsigned long *nr_mem_ranges)
 {
 	struct crash_mem *cmem;
 	int ret;
@@ -221,7 +221,7 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 	*nr_mem_ranges = cmem->nr_ranges;
 
 	/* By default prepare 64bit headers */
-	ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
+	ret = crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
 
 out:
 	vfree(cmem);
@@ -349,7 +349,7 @@ int crash_load_segments(struct kimage *image)
 				  .buf_max = ULONG_MAX, .top_down = false };
 
 	/* Prepare elf headers and add a segment */
-	ret = prepare_elf_headers(image, &kbuf.buffer, &kbuf.bufsz, &pnum);
+	ret = prepare_elf_headers(&kbuf.buffer, &kbuf.bufsz, &pnum);
 	if (ret)
 		return ret;
 
@@ -452,7 +452,7 @@ void arch_crash_handle_hotplug_event(struct kimage *image)
 	 * Create the new elfcorehdr reflecting the changes to CPU and/or
 	 * memory resources.
 	 */
-	if (prepare_elf_headers(image, &elfbuf, &elfsz, &nr_mem_ranges)) {
+	if (prepare_elf_headers(&elfbuf, &elfsz, &nr_mem_ranges)) {
 		pr_err("unable to create new elfcorehdr");
 		goto out;
 	}
-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
