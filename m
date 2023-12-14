Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3166EC4167D
	for <kexec@archiver.kernel.org>; Thu, 14 Dec 2023 16:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=mkdq1vnRpxEvllZfob9P/qwU/CWyT+NFVX7sMjWhI8c=; b=ZzURrqEZ2t6WTs
	so/NgHE2AUduC8/O2uAlHcXZN8jzCc5XGvVdkqTNgtfGRQ2eQmIfaVmLsp/CpHR8WrcktaWYnu9NU
	Wr+HpZirZCH8dxKo99o1Kk5T08FvabtOAIVT9k4NksHvncibUuPpTUlTfBS8sJqlxcO4EkhxNK5i9
	grlSCEK3rYp51jdtA1ThHfxREVJkIuNdgwOsjsJWkLC3fa7nMhtf/sWUjchOSrC17Y9t8li36Q5Im
	2iV/3QSRu2P0Eh/pBtPTnFZHW59JlXow6LWe7UrBuhWe7BE8vXiD1wFRyZfKXlMpVkBtxn9hT22FE
	wlbucY+tuA8UQTY9KbVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDol4-000pdd-2h;
	Thu, 14 Dec 2023 16:40:22 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDol2-000pbz-38
	for kexec@lists.infradead.org;
	Thu, 14 Dec 2023 16:40:22 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1d35569b8c6so11689695ad.3
        for <kexec@lists.infradead.org>; Thu, 14 Dec 2023 08:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702572017; x=1703176817; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AOk13I10R4lBKheCrtggrgfT1riocLOootjug+SJCQs=;
        b=ev+6AtKlJSFljALexf59OzjHNsYRf9eg7Fdwd00b6sK2DpylUXA6/kHDbVB1GhxWJH
         iG38UNLhMhXdc2GhYFrV1n9SMun7sRNxhtQdhDEV8dpYkQ7GT5gd9cj+pCUVrkzojP7f
         QjGP+EwxOArFVAz6SilIZTOGI2SPpZUI7SB6O36ixx0g7OrZfYHbd/miH9Kcgp5lNeBB
         7P55hj9tmlC3nK13ixBDRCT4nxt/czpd2ihjoAb7rQQlqbXNvros/GUpFl7c1YUcNra5
         ygI3bJ+71xrFAxJuQOHULAjfhk8OswJt19houAp1/fSlFawLg+5BEFQCy830e0k7H+UY
         eH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702572017; x=1703176817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AOk13I10R4lBKheCrtggrgfT1riocLOootjug+SJCQs=;
        b=WZWjYX2bSDO0cGzKtR3zdw550+/EdI8rF4m38QoUzqXBBTBlLW3ZWAA7ottITtfrIE
         ZfnDEoAZiSHMwCooKCpzIUm84Dn0C+wvpsSOL0KhFumE/QZj/wpVwMPVXsMAETKJr1ax
         SQpQNCmx+9rALPoUxINNbOLpYzaCWSuV2r0SAkn9XnuQmBNpp08p+gvCR8GjYGjdQkxD
         33G1RktOcu5EKExRnh9oLmA2CPKSZkyeWfAMOl3j6Km94gaOhheTIGpdkea01485kJ9u
         gLkh6H7oSHztsUX9eEtpYm7BnwpaKjLPJJy0tFTYTLZummf4rs+9CqLu6eJNYs6KYxKO
         Ddhw==
X-Gm-Message-State: AOJu0YzBRu+kIFxKwbncJoTcs9qXw033AXpkr4Ycf0Sb1rWUNKFSuCne
	/P6/FcGj2B+W83ubsUC6Ks8=
X-Google-Smtp-Source: AGHT+IEv15T3vbTNgPRePzSi1Gr4nq/3Kcrr/A6XNLKzJvGz7deF8k+16E00KoU+/YCEenGeKgwwrg==
X-Received: by 2002:a17:902:b197:b0:1d0:c345:c1d7 with SMTP id s23-20020a170902b19700b001d0c345c1d7mr5503759plr.77.1702572016721;
        Thu, 14 Dec 2023 08:40:16 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902e74c00b001d0b32ec81esm12595897plf.79.2023.12.14.08.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:40:16 -0800 (PST)
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
Subject: [PATCH 0/3] Some cleanups and fixes
Date: Fri, 15 Dec 2023 00:38:39 +0800
Message-ID: <20231214163842.129139-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231214_084021_008910_95E48502 
X-CRM114-Status: UNSURE (   7.81  )
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

This series includes two cleanups and one fix.

Yuntao Wang (3):
  x86/crash: remove the unused image parameter from
    prepare_elf_headers()
  x86/crash: use SZ_1M macro instead of hardcoded value
  crash_core: fix and simplify the logic of crash_exclude_mem_range()

 arch/x86/kernel/crash.c | 12 +++----
 kernel/crash_core.c     | 70 +++++++++++------------------------------
 2 files changed, 25 insertions(+), 57 deletions(-)

-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
