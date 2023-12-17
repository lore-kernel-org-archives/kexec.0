Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23256C3DA6E
	for <kexec@archiver.kernel.org>; Sun, 17 Dec 2023 03:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Zkf1TXo/cTEGsxR4jMX+BBCXanUcc6azqdHV5FJ4e9c=; b=PwVVEvqfY0Kfsj
	SYpQYp/8ONzdIqwAnSniKkBh691faSssaYOTjZgS60PWmThts1+m33Ms3Ljz/at3Iw9YhZJUh5gSa
	Ur3nXsTsFTOlGw6dd0tE6TDkg6PLq31sXcbfVe3n7ZiFugXzzPsqHgil9tXKmrrn+BuscQbhWEDyX
	d717n6y6lPitaUkrPkYdst4lD6nO4T0af70+uc5PZQaukfHZ0xfil0K0ebKSA1qsER7EI9Ue75FhJ
	+J0n+1DtlnMvNwVEUuqVlU30JdgI07rmxvqTAX5nn8NGQC/EsH5JNZNpBfth25+Ev19h06kiYJnhh
	7s6SMgtogg2Qe7KQma6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rEhx3-00757U-2U;
	Sun, 17 Dec 2023 03:36:25 +0000
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rEhx1-00756l-0A
	for kexec@lists.infradead.org;
	Sun, 17 Dec 2023 03:36:24 +0000
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3ba2dc0f6b7so1723586b6e.2
        for <kexec@lists.infradead.org>; Sat, 16 Dec 2023 19:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702784181; x=1703388981; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y332qFsoRQKdpXL92Uln91AUNhn2wyVaOfQwWysNPZU=;
        b=QyWyaml/9iLWZZzghc84f0O+5ZDuIHZ5NrMTTM4uJz8TkhaAndUIPiBrxc6SKzJQtG
         wjKyawyu5OlKCKGygAVgX986C54K6aP3SyzDPDwS33XLkpOcnN/fU+NL4cMPqmoiFv0C
         W0bSdt/DijyLgbrFCAJCxcVdyWMjK1mS0/HuMdmYuJwMMvvxw9qPMqPz+ZYzZMeIhMJ8
         5lstZIf/iPIaTQEK+elw6TeJFWrJ2aGe+Yu31mN047ncnBQ7A72SCKE2nHlp6PzLLMhj
         TlfBAbpvhxrcLBpAwzNhTNbqAhtpybsLxIwtCvX+3l+QLEEEG7niFc+UL7hgKT8L+H18
         Q+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702784181; x=1703388981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y332qFsoRQKdpXL92Uln91AUNhn2wyVaOfQwWysNPZU=;
        b=L0LG+GTPAswH8emy2ERfAZEBCo6O7TVhkUeukN//LGu/ejvhNrsKMq57R1qK3SCP2w
         ODh5qk63n/++PRrsnJA7QtUKSYb78rlWP85XHekeEl/ZONoGIGkeENtg4KBh4NGHAOcH
         Tit8yiu85NI860U61ll91nm8OM7iuRTDnzRxyfxxhre/tgTPevi+hHL5iezRRov6VnFF
         aCwHYMS11WO8+UBtY0HwafSz84wvXP9GZS4iXkfWJUziH0tTNfPmDf+fV8ZRKPOAR1Nn
         bPAMganYV+NV6N5VkvoLKyalYtDqGUJgfEko7kmLLNGkoffLECgqg6+GM/hsOXSd25kb
         R7mQ==
X-Gm-Message-State: AOJu0YxB9ZMedWdoLIHIsbIoFiYHmmOIiTqqSgunI+F32LiSPRY5I1fZ
	j9FevgFQoCB7jNjKi+6hdgrqVdMrrA4=
X-Google-Smtp-Source: AGHT+IEjJ8N4V5XA4bRG0VYVvyRzhuKfCCXL3djeU4y8vjw2MXbt49MKL11iX0GlJANcSSrP3LWRyg==
X-Received: by 2002:a05:6808:2f15:b0:3b9:f725:d92 with SMTP id gu21-20020a0568082f1500b003b9f7250d92mr22080726oib.99.1702784181512;
        Sat, 16 Dec 2023 19:36:21 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id x26-20020a62fb1a000000b006ce48a0b7c6sm15768820pfm.109.2023.12.16.19.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 19:36:21 -0800 (PST)
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
Subject: [PATCH v5 0/3] Some bug fixes and cleanups related to kexec
Date: Sun, 17 Dec 2023 11:35:25 +0800
Message-ID: <20231217033528.303333-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231216_193623_106130_9F62B902 
X-CRM114-Status: GOOD (  11.09  )
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

This v5 series introduces no changes to any patches. I just reorganize the
patches and repost them.

Yuntao Wang (3):
  kexec: modify the meaning of the end parameter in
    kimage_is_destination_range()
  kexec_file: fix incorrect temp_start value in
    locate_mem_hole_top_down()
  x86/kexec: use pr_err() instead of pr_debug() when an error occurs

 arch/x86/kernel/kexec-bzimage64.c | 2 +-
 kernel/kexec_core.c               | 8 ++++----
 kernel/kexec_file.c               | 4 ++--
 mm/highmem.c                      | 2 --
 4 files changed, 7 insertions(+), 9 deletions(-)

-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
