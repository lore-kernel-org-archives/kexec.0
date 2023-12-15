Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4131C4167B
	for <kexec@archiver.kernel.org>; Fri, 15 Dec 2023 08:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=rampqVbfVAkRn0IsmJehLPfAw/w9B0+xHNxxclXPPfo=; b=zmIvYksuV0+lcJ
	LkChEFk9nmElVmcnS9rKusQUzz6kH4wpB2a/iUl73U3XwGY/J6MlkCufsLg3taHoC8NQAdOf6DMj/
	WAGE8e8QYBTgBBjthgjPY5+2d0fhm3za/WH1FPDW7X2bKFbE0zOc6og8sN3ibFvUS4paV9kpyBRC6
	PEBI2u3AhRhejUwIc5y7A8kJkFdP1G7vJrj37V2iJrrumg/KYEne72+Ah8SMLxjNxDtXycoXwgejR
	QuHQUmM92VvQU/OlPspMfq1emx1dJHT44y4V6POe9NxbILgjWf36DOxDqdV2f/8ENoMFgBqT2AuA2
	zXpUufSimBXH8nC2PQ8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rE3Gd-002PnP-1P;
	Fri, 15 Dec 2023 08:09:55 +0000
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rE3Gb-002Pmk-15
	for kexec@lists.infradead.org;
	Fri, 15 Dec 2023 08:09:54 +0000
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3ba10647a19so352343b6e.3
        for <kexec@lists.infradead.org>; Fri, 15 Dec 2023 00:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702627792; x=1703232592; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JzWG/4o64FumP+WxSPc2A7cmnMu0/YsLnKZOkOhpCVs=;
        b=bM525D1vf84thjNTxv2JUNLhB6ldSYENfunfnIMHMxOidXLniuU9IMMZASgdfKy9KA
         63bHkqWq/PrWsYR+AugngnIdaFb7QrdSAup97vPl9IV0+rU+qgMbfeHdNLwM60/dy7AD
         rAQL7+ZlXFq8qemduDpi7hSfLhA+bVGEa9httGSKEmOR1klZKZd7o6cBav3UiD7W3G0x
         +i8S3EnYSuaALCnhyI2X7XtAvHpMOugPpij1YtkDanTLEJUHUkcIXo74VHri9ls3N8V5
         zIfn2FJITeptGVcyP1fwRsLtlXi1ISPz1kss70gADDOO4rB4nLY4D+nyIJGXhnmFORwx
         dZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702627792; x=1703232592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JzWG/4o64FumP+WxSPc2A7cmnMu0/YsLnKZOkOhpCVs=;
        b=IwbdD1l+oVQyQ7TKRo5Wpm95O2fUbcLADX056lB2Z5B2KhWTc9wfIDslV0ZemR9v7+
         gKhPzPqIaILBAIsoyUpRU0Oi6qrjOAJX7R+IGL3Tw3mHqCb9hpoEeDxdvhjMXApx5CJ9
         6+qNivLlVCapkasfQ2L+fpWzYph8v1PaM2ehMUAbN8bUm5rJmyVzZgpDUZWs0FJf3UuR
         cdZEUoZ+7QQK/gkEtCya5mg7x+SblUiDZh/o3AZF9kVtF1k/Qaed7r72rel1o2NOI8Cc
         7cN2dmL7nd6CFyd4paAxoDBiTrYJMrgCo/R/XXFGBALvnpGMcppn0fAnjHIEKdhM6qiW
         b/bg==
X-Gm-Message-State: AOJu0YxnW7ZBazNg/RFfkcwXSlvEOfMGgl9eSf1P0iVIW/VFNy/Yb3/K
	kkN6zVTYVPqHTMBcZexpJBo=
X-Google-Smtp-Source: AGHT+IGE16L21W9Z8Yghq0+NK6xWNe+I8Jqlktd8OWrpaTQXHjURACmAmFHMQwBOREtClGZ6QFw/PQ==
X-Received: by 2002:a05:6808:14c9:b0:3b8:b063:6ba5 with SMTP id f9-20020a05680814c900b003b8b0636ba5mr14884916oiw.84.1702627792007;
        Fri, 15 Dec 2023 00:09:52 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id d8-20020a056a00198800b006cee656cb35sm11783792pfl.156.2023.12.15.00.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 00:09:51 -0800 (PST)
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
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH 0/3] Some bug fixes and cleanups related to kexec
Date: Fri, 15 Dec 2023 16:09:07 +0800
Message-ID: <20231215080910.173338-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231215_000953_374347_17977AF0 
X-CRM114-Status: UNSURE (   8.68  )
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

This series includes some bug fixes and cleanups for kexec.

Yuntao Wang (3):
  kexec_file: fix incorrect end value passed to
    kimage_is_destination_range()
  kexec_file: fix incorrect temp_start value in
    locate_mem_hole_top_down()
  x86/kexec: use pr_err() instead of pr_debug() when an error occurs

 arch/x86/kernel/kexec-bzimage64.c |  2 +-
 kernel/kexec_file.c               | 11 +++++------
 mm/highmem.c                      |  2 --
 3 files changed, 6 insertions(+), 9 deletions(-)

-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
