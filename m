Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48467C47074
	for <kexec@archiver.kernel.org>; Tue,  2 Jan 2024 14:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wHidSKbCcbnzsx5SA/R9tPRdXBWoBNlYTNXc/VzM4Eg=; b=hzRLP5lqgyq17o
	KSK3MF32kWHn3g6gnMBJ5x1uq0DmXAyqPXJ7HFXu2j3Wk6RTHVvFPN50BvEwpkzKHVyK55Axu74FS
	ECeawQeCrCw4zCJzihtvwagoCooC2rgzT5vVbt/RxhobH8sUXlJsbaW6hAddN/ZouaaUDYBhJYFGg
	Z3XN2wfNq7m0nOTt45FVk/YIW/tBNkDUeuzYLfge6+KIgSTrwz/b7xugImUccZHPOOc8r0iCjCv3y
	a+5Cxx8t/h0DmBrCWfA+HEV3tyXHYU/Kp1e4GRjMtlJqdAZD+nXwMe5z/ZRyvr6DunubEMpbyNvD8
	U9hJunugd+eGnub24ulQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKg63-008Hz7-2N;
	Tue, 02 Jan 2024 14:50:23 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKg61-008Hxk-0V
	for kexec@lists.infradead.org;
	Tue, 02 Jan 2024 14:50:22 +0000
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-28c467446f0so4159078a91.0
        for <kexec@lists.infradead.org>; Tue, 02 Jan 2024 06:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704207019; x=1704811819; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nx9emZL9ku/A2bkH8s+Myg+EcmBlTQ3WIwd3hli5Dao=;
        b=d8OXKXTAr714UCvJwxehT+15cps4pFo9nzY4gPJFK4rDLvho2arjUOb7e6XWSxel/h
         XlG20FGFH9zMBV0rnsF1CU1Ac8mxkpmjM1u9KFAYIF3q3yMl0HTYM16nCIrgLD7z4DeR
         R8/Dd3Oc2rVW6/OjTNqBHUIXto7czdsXs5L41g+D4zg5am6adhtCVFQ53lM+k4/3nJUL
         aDcv3KDmdhXRrVB/vBAS1zd/z3IwT4U352rPIKVaK99hG7dKLeLGthk7MDGJtmuDha8/
         YnAjZJW0h6Bl//1CXjQA1H+L611XU49zMc6A7JxK/9FwxSlQZKkik51bH3KFsKC0WcdG
         eP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704207019; x=1704811819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nx9emZL9ku/A2bkH8s+Myg+EcmBlTQ3WIwd3hli5Dao=;
        b=A3DAqd2w+KeXQgy9XUXTd7FAnOcwqAWvyY4sNAxCBd/y1JXXRaWb4ZqorKFZLjK1aN
         3yj9tEOZIlKvJ6kqJCCkcBOetdSIwU+859ap2/xdBlIdY5po/jYPGDqmUz2pIxnKaNrm
         6wuJpWrtFrmeAp8W6sd7LnhnF0lG0F5hIQJbXUXopvGU/hRiQuEwr++IcfX7SQMj6dv4
         IcAXP2wLcwU7X4Mcamm9E1nKIgvbkPl75n0uTDpFfks5oFAcDAEWTwpxCBgTHoWjBkG6
         PpVnR69adT7PO/7uoR+21tJITK73WtO039qGcPXvwJIImtTinPryim+y6o7E72k+iptZ
         xVvg==
X-Gm-Message-State: AOJu0YyP2VbmDXZ+eYmXQzPP3Kz2449m9Qh57zyLDtA+EnG76bgUZOvg
	5msC7Ur57lGJAMLqgZ6UOGI=
X-Google-Smtp-Source: AGHT+IH1AtANcoTpV/1fg7LaSPtmB+gncYnvxJC4l0K9bGliRbPQf3qOvwE+k/EciIKWd+fgvtLnfw==
X-Received: by 2002:a17:90b:3781:b0:28b:d31d:bca5 with SMTP id mz1-20020a17090b378100b0028bd31dbca5mr21613623pjb.32.1704207019429;
        Tue, 02 Jan 2024 06:50:19 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id 19-20020a17090a005300b0028be216595csm25836878pjb.4.2024.01.02.06.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 06:50:19 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	x86@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Takashi Iwai <tiwai@suse.de>,
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH v2 2/3] x86/crash: use SZ_1M macro instead of hardcoded value
Date: Tue,  2 Jan 2024 22:49:04 +0800
Message-ID: <20240102144905.110047-3-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240102144905.110047-1-ytcoode@gmail.com>
References: <20240102144905.110047-1-ytcoode@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240102_065021_195932_FA84700F 
X-CRM114-Status: GOOD (  13.96  )
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
Acked-by: Baoquan He <bhe@redhat.com>
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
