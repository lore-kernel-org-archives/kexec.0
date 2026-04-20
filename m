Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CACEF588E0
	for <kexec@archiver.kernel.org>; Mon, 20 Apr 2026 14:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5HAgeJOZaSUjQDMERltKw7poLkmLCttGsEyTv6VLp9I=; b=hB6BYCFSA49WvXfuRo2wL0hOKs
	AxU88kRrrHV5Wl6wmR6E79rAnCbHXcplLSoPmtlGhAjWaBvY2/pC9hQcfzvq+y66JYgTMZKMvmBzb
	mXFi9tA24t1BEcSbcmxp6FdLvcxV3Cm1AGL+tbeAwJscGqj1Ifv8OWfJEFVAMYRmKaec9JoWEJvq7
	7gKXGldarsVeOI4J/bxnJlKgj8/vSaPlfhnvnn8W11Ck96Bb305W2dk9llaG7IU999G7Hgsk1bi6S
	HRq6j/bJk7dU7vH38wbV4asZZAuezmgdaoAt8cu1VRxBa/Ta6EBtP6qQCBg9qxsdwIgoukxvbmBDO
	pQpjqgpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEpRf-000000079r5-0Gtf;
	Mon, 20 Apr 2026 14:17:51 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEpRb-000000079q2-3Czn
	for kexec@lists.infradead.org;
	Mon, 20 Apr 2026 14:17:49 +0000
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so9838095e9.0
        for <kexec@lists.infradead.org>; Mon, 20 Apr 2026 07:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776694665; x=1777299465; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5HAgeJOZaSUjQDMERltKw7poLkmLCttGsEyTv6VLp9I=;
        b=DfzvPI064O2MPg0RXWHWouV2a1XFijNG0RA18sltJxgX30e0mEoPjedYj5bEw77D3d
         d/Ra5w4uakVqG6xUWVxrqvrFxLcT0vKQjs5B7Hvb8m6PEEzCVPczeBSXqzeLJ50+/QKh
         1dcHQAbnt0diAUvItZYXyx/rXgiNjMYX/FzQTWcD/Voo5+Q/oFZANmqlFbm9Y0wefoHE
         25d0GgCNPTD8INHVXJocP0F3buhwXLn+YtaCwSdIZ9DaU5KnxWZs8HPFmncn9JYRX7pQ
         YpfkXQdgCU2gS6QoQutfVcSCdsSxrVUWORkkirFjCIlGPTSv0bQXGeKj8zOPzx6Xd4xc
         sNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776694665; x=1777299465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HAgeJOZaSUjQDMERltKw7poLkmLCttGsEyTv6VLp9I=;
        b=iotL+mOXeF4bOzmQNNQGUFObKWduUalKmjQLshMRLbAt702TIPUP1KwInEI43yfecB
         nJICvpiVaIwILw5sD+tyGRaslmV6Zs7/W2jpOoRq5cxJLl7D5Ujx3z6biMPX2JOAdH/r
         dmMD6QkMcPItByOxsPYSNMooNuiW1CSA1cCTS+6E+oNwopHi6fzfZ9KEp8E+NIxRT7Pe
         K0ynDnjZo0IBjzxFPobT2yyj6a0Q2VPD3GccS9L8zACYfiArp9KGyMNpZwMNbGKQaPU9
         oP4RhjMNspnG1QeB7+f7O+GepcNuiJQKBJKqPA4/Zdkcw0oWMQxDxajfHarF+UYw0TW6
         KlPw==
X-Gm-Message-State: AOJu0YwuOXwZxljAS8GsY7V2MqoibQpXiHpR8Cgsu6M6XFcU3jLczyVf
	lRK0jCTWKCSY9+EkvqlMdDNBvOcJtmxBzTZVTT/eph9DkpKChUEOmqb8rGcKbA==
X-Gm-Gg: AeBDievU3vDEc3ZqD2eJEP1srYXFmuU+CyQ88Nwk0BnORQh03Ble0AndST32GvMu+kD
	gCf/D8nrMxo1gNPdlInUt4fwAPAUFUE7gTvdeo9Sd+hdbDITKx3ZKFLXpN8c73X2oQQjzL8nkBu
	M0mgzIdpLHdLqpXaUsPiF7S8RhiaU7saygSwjKF78PdMnaB7Y1FE+i6oH4oIlq6qyN7o4F9cwsN
	0GEpYUWp4dT5a6AApMDNvoDQiQOXm7GR1prYRY42WiOkuRaa/zF2WagkPCicSayuj64JvoR+5pU
	kQlxSZOR0BoOAbJfNY7RVII+/W4hY43o8h/YCGu/Skm1LncOdrIwh0fs1EJO1abq6Ii5QGa7/Wq
	AJmhz/CW2m7HOwmGJoT17xzVhoCiPnYDPtpmxAy0ygaSLcg/890nnTZkyFrP54p21Oa/fS6JXmk
	mzjW3johYPnVGBsxP04YyQk8EMRhr4rd0jhuJFZvY=
X-Received: by 2002:a05:600c:859a:b0:48a:53ea:13eb with SMTP id 5b1f17b1804b1-48a53ea15bdmr3192745e9.5.1776694664793;
        Mon, 20 Apr 2026 07:17:44 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:355d:3be4:308b:c943])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-488fb77b001sm131753195e9.3.2026.04.20.07.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 07:17:44 -0700 (PDT)
From: luca.boccassi@gmail.com
To: kexec@lists.infradead.org
Cc: linux-mm@kvack.org,
	graf@amazon.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	brauner@kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Boccassi <luca.boccassi@gmail.com>
Subject: [PATCH v9 0/6] liveupdate: new ioctl, change session inode type, bug fixes
Date: Mon, 20 Apr 2026 15:15:08 +0100
Message-ID: <20260420141741.2688371-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260420_071747_821521_E407DB81 
X-CRM114-Status: GOOD (  12.16  )
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
- change inode type of session FDs to a new singleton magic number,
  so that userspace can immediately identify them without string
  parsing in procfs
- add new ioctl to retrieve session name from FD, so that userspace
  can query it without string parsing in procfs

All changes come with a follow-up patch add test coverage via the
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

Luca Boccassi (6):
  liveupdate: reject LIVEUPDATE_IOCTL_CREATE_SESSION with invalid name
    length
  selftests/liveupdate: add test cases for
    LIVEUPDATE_IOCTL_CREATE_SESSION calls with invalid length
  liveupdate: add LUO_SESSION_MAGIC magic inode type
  selftests/liveupdate: add test case for LUO_SESSION_MAGIC
  liveupdate: add LIVEUPDATE_SESSION_GET_NAME ioctl
  selftests/liveupdate: add test cases for LIVEUPDATE_SESSION_GET_NAME

 include/uapi/linux/liveupdate.h               |  21 +++
 include/uapi/linux/magic.h                    |   1 +
 kernel/liveupdate/luo_core.c                  |  10 +-
 kernel/liveupdate/luo_internal.h              |   2 +
 kernel/liveupdate/luo_session.c               | 108 ++++++++++++-
 .../testing/selftests/liveupdate/liveupdate.c | 153 ++++++++++++++++++
 6 files changed, 289 insertions(+), 6 deletions(-)

-- 
2.47.3


