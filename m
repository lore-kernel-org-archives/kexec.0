Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F95FFDEE4D
	for <kexec@archiver.kernel.org>; Thu, 23 Apr 2026 23:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Lki0JX5m/qaGqm5DoBE8zLiop+9ooQpoPeZ7HcosWXk=; b=pGtWoR3QNTY47/un3A63qzqKSi
	LkibgQaALntx80U14VUtgJpzI7XjoZLjUee8sxaTpDxAW9RPVJH0hMFiyfOQ1i/YTBusVAaFJjKNE
	Wp59U3gxuS9v/INcNoCZaeaqEx2VDGI/PD9aff0AEheJkwu+asphdzqbZbZ7JJdg6l+vA8bElL6b6
	azcEUYl5NlZmGieIRZ4EIw3RBz/WKjt9PiCm1iNsNdt2ZyUCctABv4YhmJNQX1t6tgFMr4IlhdVJF
	MvrcmuTmydUuNHnNus/1U0DOFS3a+S1bIgWMdCKfSVTrPIMrwOp22Z/QIHWAKQUJ33aySx3X49Zf0
	g0qhMEdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wG3n3-0000000CQ8k-39h9;
	Thu, 23 Apr 2026 23:49:01 +0000
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wG3mz-0000000CQ7x-2ve8
	for kexec@lists.infradead.org;
	Thu, 23 Apr 2026 23:48:59 +0000
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso44144135e9.0
        for <kexec@lists.infradead.org>; Thu, 23 Apr 2026 16:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776988135; x=1777592935; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lki0JX5m/qaGqm5DoBE8zLiop+9ooQpoPeZ7HcosWXk=;
        b=oJchJ8IPcwFzFiDdkorSdYfYtMv7XX6WN5sJM/SEoaVqVArkLS/SWarvU3xL0q0eaU
         zAwSwPxxowvavj/NGZOlBTo+3tbfiSexuVJc0ueMhzuDpkl8QIc/5OPMIC9z4xs+/LLW
         T13e7xStreUHhIkKdVJHfyaUI5r+5U2F5hwjkviWF7hr7jfpqYnMkXLmCbsZvGzgMxoY
         Mugj+rZ7Vw/9V042cqwDok8kdfOcra5KoJCxqrUr3r8lZhftDNqyK5SrTciZmwdAmsq8
         z4zUS1f1nxbDc1Kw/BfjOpJogqb0TdC9cOIrCVd6YWHXtu/GXSPEcy9j9cfYgBd0qRkm
         egVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776988135; x=1777592935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lki0JX5m/qaGqm5DoBE8zLiop+9ooQpoPeZ7HcosWXk=;
        b=czfdBn62ESNLOrrDDih6rpyJkjtr18AyrsYNRM5JZyPkd0slhi6CvRddnmGYLX1/gC
         zpgzjSHfF0DCay6eU6BTx6H3S+kiSS3dgEyQVjvrVP4KeeoFYtBg+JruatCPHvxGvuap
         c6d9eAr/qHaG8S+arTcP0hLc7uKZWzSthSxBiRp53S3of6ulW7gY4FrrnRH/iAwTLW//
         KalSY+K2SSqQFCzXd43tnAFrg/KOCnrpg7Yk58JuO4swYA9vjQapjoTYzZEGXKFzMVtw
         jkn17ITxhSFlgd1nRSs9/7eOe4iqv+gs4bACsX/3zc5+kjU+hKldInH8a8WJEtcmNjT0
         B8Hw==
X-Gm-Message-State: AOJu0YzPeAVz/cD87hfgOAlF5l27OABaSzpsxYGyXceJr1qZ6EWL1RWi
	AvyUWYHly/ScSKO4eb/yOjrJLuhoTWMrUmxMcLgbQDFmxcQU5mk3b+V188tMRQ==
X-Gm-Gg: AeBDieuRLOHZEjbmGhPCRowt7TTxvlL9+slRgfz/xVuaFKy4lk1nsmCUHn/UOsl7XCs
	e2rm7Q+v4GhT6oRpRGV4T2j+VW3qejXuvYbUSfc9MKvpYJD8Sj9NsKMxbooDQ8HhLcxg2D05OdU
	t98y9TTwv3X0m5ij8vewCFujkYjjif0iC7kMxoqdH/8ElXLYxcDtdp8CSeSF4H0KpVggGtTsNqB
	vdTalJIBahQ8R+WQ3OT+5LRkpw8WP9s3CCOldVB7VLf/1SgtpE8avMafg1OONkvp1b35gaplpBp
	00VAcxXf/SdYR50qW3X2c2chVGPlg/lriopRJ8x0ky96RfrzGDmg+h+TQibko1PP2WJU5swBkSO
	GDJeseSMXRSynHYH10i6QwwKOuRdsEGvUwQHuRBtg81rHn+UnbLO6gMK0Qm/2+zcU8kagvoECPB
	O9CDtqvBLHmxN/ebAvRDMuZsrdcRKJqiKSP4M2BRs=
X-Received: by 2002:a05:600c:4e4c:b0:48a:58ae:9938 with SMTP id 5b1f17b1804b1-48a58ae9f69mr190862345e9.19.1776988135082;
        Thu, 23 Apr 2026 16:48:55 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:e8d7:434e:1f34:2cb6])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48a5c4b9e8dsm40476485e9.7.2026.04.23.16.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 16:48:53 -0700 (PDT)
From: luca.boccassi@gmail.com
To: kexec@lists.infradead.org
Cc: linux-mm@kvack.org,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Boccassi <luca.boccassi@gmail.com>
Subject: [PATCH v10 0/4] liveupdate: bug fix for session name and new ioctl to read it
Date: Fri, 24 Apr 2026 00:44:19 +0100
Message-ID: <20260423234753.3873095-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260423_164857_805126_9A963696 
X-CRM114-Status: GOOD (  11.77  )
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

From: Luca Boccassi <luca.boccassi@gmail.com>

A series of patches matured while implementing LUO support in userspace
in systemd.

- reject session names that are either empty strings or too long
- add new ioctl to retrieve session name from FD, so that userspace
  can query it without string parsing in procfs

Both changes come with a follow-up patch add test coverage via the
existing selftest.

v2: apply one fix from bot review about cleanup on error path:
    https://sashiko.dev/#/patchset/20260415184536.1155220-1-luca.boccassi%40gmail.com
    the other comments are invalid: luo is not a kmod, and the write hooks are not set up
v3: add test case to liveupdate selftest
v4: split test case in separate follow-up patch
v5: add r-b tag, merge series with LIVEUPDATE_SESSION_GET_NAME ioctl
    as they both change the same unit test source file, to avoid merge conflicts
    add '__u32 reserved' to the UAPI struct
v6: add more test cases as suggested
    more verbose commit message
    fix docstring
v7: apply suggestion from review bot to stub out setattr ops,
    like it was done in 22bdf3d6581a
v8: add new patches to reject session names that are empty or too long
v9: fixes following review comments on LUO_SESSION_MAGIC
v10: split out LUO_SESSION_MAGIC patch as it is undergoing more discussions,
     and the other two patches are independent aside from adding test cases
     to the same unit test source file

Luca Boccassi (4):
  liveupdate: reject LIVEUPDATE_IOCTL_CREATE_SESSION with invalid name
    length
  selftests/liveupdate: add test cases for
    LIVEUPDATE_IOCTL_CREATE_SESSION calls with invalid length
  liveupdate: add LIVEUPDATE_SESSION_GET_NAME ioctl
  selftests/liveupdate: add test cases for LIVEUPDATE_SESSION_GET_NAME

 include/uapi/linux/liveupdate.h               |  21 ++++
 kernel/liveupdate/luo_session.c               |  17 +++
 .../testing/selftests/liveupdate/liveupdate.c | 113 ++++++++++++++++++
 3 files changed, 151 insertions(+)

-- 
2.47.3


