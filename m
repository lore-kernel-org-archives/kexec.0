Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62BF5CD4F3D
	for <kexec@archiver.kernel.org>; Thu, 21 May 2026 19:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jj2uKcpS/Lnn6/o0vTIHKLE80CeHYkd6tam2XF0iGgs=; b=XoXDPqc4gbz1fYM+eMUJ7RAou2
	/KZLMHClMp27g7dYMh/keSJeRpD4svvz7Ldg9jKw7xbTqyeDcuq9CxeIklarLE6GqlIShJ8NW8DL4
	rqqyhWDh/HZXXxnCdEAjKrYo9NeFAAHBmRniq6l5vy0DYfpORndgX/xFSfgLbBhxUbwwFjms0sFiz
	iK+vKKLoa0ZD/up2cnH3WwzkBNfFUJrf2wdZ7vYsnuTLHqfo/ylXrTszXkJfnwsnImtD9c/peIB3W
	OC9V0en2c0V1B/hDUEof+mKp26kz6D+rHaAL/epC7xcBtXo0x+nsnks4izCuK+1AZ2FJLTqye7Bu+
	STYpRhgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ97m-00000008uuq-3mnI;
	Thu, 21 May 2026 19:32:06 +0000
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ97k-00000008utx-2Piz
	for kexec@lists.infradead.org;
	Thu, 21 May 2026 19:32:05 +0000
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-c828ab3b033so9169636a12.3
        for <kexec@lists.infradead.org>; Thu, 21 May 2026 12:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779391923; x=1779996723; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jj2uKcpS/Lnn6/o0vTIHKLE80CeHYkd6tam2XF0iGgs=;
        b=n3mji+q4pmV07qEse5fuWsjt1CkGtywZG1KEej2U3Or54MhAmwtAVk2o6OreOOFZTd
         mnw25wS0PJQvYSqGhNKxFahCstO9Tfje1GawdvRRGKefXaEIFaiSuM48zN/ONLBoyiwF
         4SkcZuwsoJBWlExU3IvrXRfHSHGMJ1uFwDe7Di9E1tIJjT0s3H6zzuwurOzKrx71tmzu
         PnRvm5RqglUDwQ/j7Ab0tncDW8Kg7m/evBaT/VobUwGA3WCJWMJdeAXeyc1YEKeo/+2d
         lIRgdaEbwfP0vv2AIkgKFA9swdze9hQ8lXe4nfU6M/n8O8L0c4h3HtYDAyiRSc9XvHJ5
         aheQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779391923; x=1779996723;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jj2uKcpS/Lnn6/o0vTIHKLE80CeHYkd6tam2XF0iGgs=;
        b=A+z74lzw7ZeAR+JmvMMvjPcMVSNIxs3VNwCaFqE2pAn2cSS8fEz5W+t0p9ZYydikQs
         T7ddNdUyurxqaFhkydq/4dhlcor9KwnQrAnPixLhhmyR04vN00uLdYEnXbj/bPls3Jit
         qY22gdbNynGbSm0c0LJQHbZWYaLtrr0f8eIBqGZrVr947Ive7ahjrR99qN7tHCKA8m4j
         EsHGcf3CDVQiD219dofP38vgjkUgjtH0VRvyl+e2l9VOEiyezKOjkDrdA3aR4L0iaV1m
         HL5YTbGjuQOvdb9EcYnvj7N1H98KsVv9GKjC2WupWXJkSiHjMnxBDoyOnxJxmbtOa9Dw
         oixw==
X-Forwarded-Encrypted: i=1; AFNElJ9u+fe7fYMANl8eBnDrN75QoeUWADtj/T+3o9bxRmG0zvAYtVQFMflGHCJ1vhsn8D7UnpVS9A==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy2e4EgVoL0UUcPeSC7TkbEz9Rd9SMW+86bms6h3a/7seroaS/N
	GaASOXzTev1yvP7J3Z5Iy2CKa9UVTmyDCSWlGHeLz/EzCknqnhHUU4VqpeHuG34VcErpiW0peTs
	zk+fK3jJ1+FPpLg==
X-Received: from pfbdu2.prod.google.com ([2002:a05:6a00:2b42:b0:82f:4d28:b8c5])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6d85:b0:3a2:c685:f9af with SMTP id adf61e73a8af0-3b328fc0643mr327670637.50.1779391922774;
 Thu, 21 May 2026 12:32:02 -0700 (PDT)
Date: Thu, 21 May 2026 19:31:59 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260521193202.746810-1-skhawaja@google.com>
Subject: [PATCH v2 0/3] kho: Add support for kunit mocking KHO restore API
From: Samiullah Khawaja <skhawaja@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, David Matlack <dmatlack@google.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KEXEC HANDOVER (KHO)" <kexec@lists.infradead.org>, 
	"open list:KEXEC HANDOVER (KHO)" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_123204_653838_CC0E1C39 
X-CRM114-Status: GOOD (  12.64  )
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

To write kunit tests for preservation and restoration of liveupdate
state in various subsystems without triggering the actual kexec, the KHO
restore API needs to be mocked by the test writer. The mocking is done
to allow testing of the individual components or functions in isolation.

The patch series adds the following to support kunit testing when using the KHO
API:

- Add static stub hooks to mock the KHO restore API so the restore path
  can be tested without triggering kexec.
- Add helper function that can be used by the test writer to check if
  memory is preserved in KHO tree.

Finally, it adds a KUnit test for the KHO API that verifies the allocation of
preserved memory, and the preservation/restoration of pages and folios.

KHO Kunit test run:

 KTAP version 1
 1..1
     KTAP version 1
     # Subtest: kho_test
     # module: kexec_handover_test
     1..3
     ok 1 kho_test_alloc_preserve
     ok 2 kho_test_preserve_pages
     ok 3 kho_test_preserve_folio
 # kho_test: pass:3 fail:0 skip:0 total:3
 # Totals: pass:3 fail:0 skip:0 total:3
 ok 1 kho_test

v2:
 - Move kunit header includes above linux header includes.
 - Use the __kho_preserve_pages_order() to get the order of preserved
   pages instead of open order calculation math.

Samiullah Khawaja (3):
  kho: Add kunit static stubs
  kho: Add helper function to check if pages are preserved
  kho: Add kunit test to verify preserve/restore pages and folio

 include/linux/kexec_handover.h          |   5 +
 kernel/liveupdate/Kconfig               |  10 ++
 kernel/liveupdate/Makefile              |   1 +
 kernel/liveupdate/kexec_handover.c      |  63 +++++++++++-
 kernel/liveupdate/kexec_handover_test.c | 131 ++++++++++++++++++++++++
 5 files changed, 209 insertions(+), 1 deletion(-)
 create mode 100644 kernel/liveupdate/kexec_handover_test.c


base-commit: ec4084bc445027a52f600e30a976928be1ba1950
-- 
2.54.0.746.g67dd491aae-goog


