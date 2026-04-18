Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EA3F99C88
	for <kexec@archiver.kernel.org>; Sat, 18 Apr 2026 16:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=I2DVRbVNhVeR4amNlP7a8lBCjg5uU0/n/18hy85E+D8=; b=IV/V7NPXR+YrLYiqdB+Xc4S012
	gacxM4fFYYGSOAgHth55d/4czR/Bgf9EIg2qgEH4K+MCGOBqL1DBn3Sr+rhW5HLDKEk+Y8GQDf7nV
	pTOEpRcEvyfvJD+J25HclGKQyx5XcXr7a9ThTiEJxYIGDazIr5riZ/uKNDw4bXRvTyt9y8VuwRPyx
	COONihgYfeeZ5MmfnQ61b493UG7qarrcUiILAH2ayOPN5dAdqlQ6kGxiwqcOM3q9yJjLHqb2T9+Zc
	eaDRUf+Y25L8Hg6dHwg8+a8OnMRibL6cUlSpdVLA606ZFjUFaxoh8z5HQ9pWInWBVhBRswIH2GuOM
	X+xb23rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE8ca-000000055jQ-27XL;
	Sat, 18 Apr 2026 16:34:16 +0000
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE8cU-000000055hu-2Lpk
	for kexec@lists.infradead.org;
	Sat, 18 Apr 2026 16:34:12 +0000
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-43fe3e22e33so1059126f8f.0
        for <kexec@lists.infradead.org>; Sat, 18 Apr 2026 09:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776530048; x=1777134848; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I2DVRbVNhVeR4amNlP7a8lBCjg5uU0/n/18hy85E+D8=;
        b=gadkeBTQQhZT4U3we6Te1QOhYBG8nmENy7jmCzOq4i3wKTBgbRZKe42o1uJW7nf455
         joSpD/AOTqZSkr1JYf92WZCF4AcORVvOiZjucXovmcs3v1ij3+OcpncV5ZXKxcVVKQZu
         Xg/UMWKGW2uX+sf4tw25K11HJZprD/zugrWPhWv4A0tmKlIfxC33IgADQOiCLB4fny5c
         S5mm0dZarX5XlN4YWR0jT2vd7Wr2NhPMX5uAjuOVdN9BAhgC+KWMHL2rDBtJdNy7Clx0
         y1CL100+K91qaI+7XR6QjFya9j7q0B2qzja/aWiXtZBbnhk8zlIiha62jYCmorh5MJ/u
         2kyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776530048; x=1777134848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2DVRbVNhVeR4amNlP7a8lBCjg5uU0/n/18hy85E+D8=;
        b=ZxRb6TnIt6Dpck45LXgXUYnk33uRhVtWyrM6RJoVry7H3uh2IuKDqa3gserEGHPECf
         hCY9/yVDjNi8C2RtzDltw/c0KM2CGrjFyEjm6EcSU66Gt/FDM9bu06/WblaLZAdS1VqH
         /YknrgfXPL7Ij4TLv2Rpno81QjlwZ01AwZNFaftu37bHTK6IsISmxpkE+4lBJjqsFsoj
         LcY5gdUzqqQdPZfVdkP8IIcLcasmlS6NZeiJjrX467Kxn8orFZerz+zuPmZKtZLGPZSW
         Bfifb5ICBHpXHG/XGTEPAosZqfTUcolhe4wIokxjv24fG74tek4K51OMKNn7yD6v0fXM
         /xCQ==
X-Gm-Message-State: AOJu0Yz10CWLLvV2oSZRMjxOMtaObQ/EEuZhOLOo3zGrsTnnBO9NhyeS
	gFpVuBS1qes+RlssbX9lwnN4flC+r2bMbizEmJ+KcdtBhFXlwl4zT9SlhoNGiw==
X-Gm-Gg: AeBDieuUTY1iupvdMZ8Bqb4MJcEJD7LVT3cabUOCifdHKCljx3dr+TqTjAvrDIBWZ3b
	rNatTClGbAJkJrhekr/udQu6vEQZXCec4gxYtlyV0USO0fdByakvYf38ZDm2qjQSEolsBCzEz2Y
	XINjPASVn/8MvZj1lvAPji2dExSMjYl8qi7wYyUL5vJAcDYIn7u2qwf/eu58ZtRXzLh0ITgkk+y
	MZlbJ4swOCWxWcNju4AU812FOOsfwxu2hiOXNuM1NAyysfq9YxZdHzBBwqeZzftt0sOfkhKq1IG
	nvuQdBdGfWoup4GzGK+7EwqC/ZgdH7NjXoJt2hUFisXSJtPup632qnqO/AXNnHrWvIg2iy5CRH5
	XrYctFA25O6vQMwLXqTnncTKBnnPMLVJp5lcEO1KUjN229Lkrau6jfiyoX4wFYnge6TTwed3vNI
	l7L0Zqhy4hPfHk5icT9/L9negkdGjhCTdXGNt7koT5PhFn9b9vIg==
X-Received: by 2002:a05:6000:24c3:b0:43d:7868:21db with SMTP id ffacd0b85a97d-43fe3dcc11amr11095356f8f.18.1776530047970;
        Sat, 18 Apr 2026 09:34:07 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:e054:93f2:97bf:84c6])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43fe4e3a79esm16403029f8f.17.2026.04.18.09.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 09:34:07 -0700 (PDT)
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
Subject: [PATCH v8 0/6] liveupdate: new ioctl, change session inode type, bug fixes
Date: Sat, 18 Apr 2026 17:28:17 +0100
Message-ID: <20260418163358.2304490-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260418_093410_659022_5092BD22 
X-CRM114-Status: GOOD (  11.66  )
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
 kernel/liveupdate/luo_session.c               | 106 +++++++++++-
 .../testing/selftests/liveupdate/liveupdate.c | 153 ++++++++++++++++++
 6 files changed, 287 insertions(+), 6 deletions(-)

-- 
2.47.3


