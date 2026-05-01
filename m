Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E15FCD3427
	for <kexec@archiver.kernel.org>; Fri,  1 May 2026 23:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=p/ZGZZ16eChdLsInwwR1Iu8Lt9cp6vxX5Ri5Z7cydws=; b=2ln0g0UGcTmCckhUXRnjWeeY2f
	oIMC2O6qyumIRqSBY3MGCVgBvy+pnxncXaH4NCHqHu6cZ6EvTLY8F5OcCXaND+Nfhh11cx3EzMaPD
	qkis1Q1SsFG7i97UzBGM0jpng1oTCWNg4gtwFv11C1acO9BTBAfUHj1Yc9zNo+pQmTK9NCGeeorc2
	5o/acGKNvQTsHGabf3pNz+qRmGqPzz50rVWU7pt8OBISkrdVFfKj/Ci2rH0TTmVxgLHEW36u2J+/I
	ytAylVwgpQ2ULOMIGwTinrjaOb6npTmPGNKtrypWe7qiWz5+l/ONyemtGKDpHe4d1+4hugWPjtAd9
	3TKlfK3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIxWV-00000007qU8-2pCg;
	Fri, 01 May 2026 23:43:55 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIxWS-00000007qTW-1nZp
	for kexec@lists.infradead.org;
	Fri, 01 May 2026 23:43:53 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2ad21f437eeso15213085ad.0
        for <kexec@lists.infradead.org>; Fri, 01 May 2026 16:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777679031; x=1778283831; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p/ZGZZ16eChdLsInwwR1Iu8Lt9cp6vxX5Ri5Z7cydws=;
        b=iTnfzJhMpdF/hdX6p1QBItCKstSYYSp1nBSkK0Pp+0Zjm6ONUwQ+TeMEy/ZGuiFikV
         a0UjOB/h2/U2jQhczx8KOc8+NsMY+f0hyG+ZzVxZD+R40zovMkNQ398ScAa1st3UYF+t
         x4mCEAYq5cF4blFHonCPg61qBF5xAxjzDTEONwhhP6jOz6jto6jWxSed3jh8WoFO1DcX
         IdflrJAeLYJA3YvwhQKKZ6C1s6M1nG5EwJ2EXH1KGTyjOtC4NilMv+0wdkCu7JRJBvk+
         iOc0/BqQiJLcSnI0gr1Ab4pYsB6p1jKhWeFG1zvV8IB9uIx5qpgHoSZEITA8L5kPw1sO
         cuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777679031; x=1778283831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/ZGZZ16eChdLsInwwR1Iu8Lt9cp6vxX5Ri5Z7cydws=;
        b=e+I5QnaDxWWgnZtHYxNJ1xCsQmOIMdnkhUVjW90SkOYvXwzodpAfK/b1VaWWibOVWh
         4DFayRMHFDvgJf+EVT5zmnFH7a8umF1kUApjBWlTLEcKJM2uCVUj2bwgNoZTVssP704C
         bmOr/Ovi71vlzOydSo60Qneb6u8UW16YjH5dqWaGtpU7F0RSChWFBT5LIAU/1SYhz6GX
         vRNmYUbsWo9ucANCkPJHAAh9kmA0zUGuTvSmL37kqhiI+0oaGNw1k96JsczLmv0h5o+L
         ey47+grtatgtcQMh34CtNSTr13HMH6RrrRoHbvmsYMiwcDsENwlFidmGEzG47/B+G5WO
         PjmA==
X-Gm-Message-State: AOJu0YyH7Gyyngeox3zhdbHOl693wOcQzG8xXhTUpE9GzEApUP6d6o6f
	MGQQZV58rutrlSay4OudsPo7xDn/W5RSfeoCOUk5LU6b3cMpkReRnxSLKORttEkFyVg=
X-Gm-Gg: AeBDievCkRyJU9pIJ3AA6Yc6/XVQSLNSpfxYpTdzFb+Np+vzPgzxsYD1CTfN4v+y1fF
	1MBGF3H1oNMAgO8ROY79iJTteuU6Bmef0DvOsfvtdM8cQcePxk0/8Lixtvn9VkhtnWCytBoeCpR
	yHwbVGmYWb2hBAQKWekwuc30Mzgv7dz1sSRF39V2wwutxXAFGAfgV7AJwQbN6mxvKwEieojGgTU
	fnKyAhjLEfJN2G0v8ddrZ5edxHRlAOxZ/dvr0xSGpJfXS8QO7T+gwlVb/dEl8eopTPCtep/iEDB
	FeZIRo+fSZaAjsYX8xQW6JtBS//3ZBK/Oh/+nd6+KqpKYYPtakBnVZtRJQolwtAzJHjkGCfiRa1
	kBOnhgEdxi62DXFEPH1x8hUFvDx3eqcdIuxNr4EWg7e0ndb2POSSvueOyg6qdqg96E2OIXqyOwv
	wPDtSr/AbJvfmgL6d/ACuoJYNcUVqiEw==
X-Received: by 2002:a17:903:8ce:b0:2b4:68c9:302a with SMTP id d9443c01a7336-2b9a44bec2cmr76434235ad.17.1777679030842;
        Fri, 01 May 2026 16:43:50 -0700 (PDT)
Received: from localhost ([121.237.249.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae0f0acsm31219135ad.38.2026.05.01.16.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 16:43:49 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: kexec@lists.infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Dave Young <ruirui.yang@linux.dev>
Subject: [PATCH v2 0/9] Bug fixes and enhancements for kdump LUKS support
Date: Sat,  2 May 2026 07:43:29 +0800
Message-ID: <20260501234342.2518281-1-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260501_164352_499573_833B7D4A 
X-CRM114-Status: UNSURE (   9.83  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi all,

This patch set brings some stability fixes and improvements to the
recently introduced CONFIG_CRASH_DM_CRYPT feature [1][2] (which is to
support LUKS-encrypted device dump target),
  1. resolve dumping failure when there are >=5 dm-crypt keys
  2. address several memory management issues
  3. fix race conditions like configfs writing happens concurrently with
     kexec_file_load syscall
  4. improve configfs handling
  5. update documentation 


v2
 - A different way to address potential double and UAF issues
 - Address several issues [3] scrutinized by Sourabh based on
   Sashiko's review feedback [4] on v1 patch
 - Other improvements like logging fix and doc updates

[1] http://lists.infradead.org/pipermail/kexec/2025-February/031850.html
[2] https://lore.kernel.org/all/20260225060347.718905-1-coxu@redhat.com/
[3] https://lore.kernel.org/all/972b9a73-d066-4a38-8a4b-fe7d1ba2944b@linux.ibm.com/
[4] https://sashiko.dev/#/patchset/20260403100126.1468200-1-coxu%40redhat.com

Coiby Xu (9):
  crash_dump: Release reference to a keyring at correct time
  crash_dump: Fix potential double free and UAF of keys_header
  crash_dump: Disallow writing to dm-crypt configfs during
    kexec_file_load syscall
  crash_dump: Read the number of dm-crypt keys from reserved memory
  crash_dump: Free temporary dm-crypt keys_header buffer in kdump kernel
  crash_dump: Only use kexec_dprintk during the kexec_file_load syscall
  crash_dump: Improve readability of config_keys_restore_store
  crash_dump: Disallow configfs/crash_dm_crypt_key/reuse if
    CONFIG_CRASH_HOTPLUG enabled
  Documentation: kdump: Add arm64 and ppc64le to encrypted dump target
    support list

 Documentation/admin-guide/kdump/kdump.rst |  13 ++-
 include/linux/kexec.h                     |   6 +
 kernel/crash_dump_dm_crypt.c              | 131 ++++++++++++++++------
 kernel/kexec_file.c                       |   2 +
 4 files changed, 111 insertions(+), 41 deletions(-)


base-commit: 08d0d3466664000ba0670e0ef0d447f23459e0d4
-- 
2.54.0


