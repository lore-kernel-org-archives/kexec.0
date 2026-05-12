Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF257CD4F3D
	for <kexec@archiver.kernel.org>; Tue, 12 May 2026 19:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XMGmjrgacA7FJIZhwbjaKrLrnllX5lCbrSfU7CyJlss=; b=pQBd3V2U27eSfHyQzkqT3SEjuo
	8ib++RoLvlAqf8kUK6MEz1pyMmWBj1HBguqfZg4wY0SL/v9egPgmKQLrmJEwWhPRagJjv5QZA+OBP
	qqghTsgfUwGR5YOKHJFxLfTyBNGaAtAQMa0IlLXBlb5KbY5lYxAI8LSDDO2iqy0JbxsvWg2WUCPZW
	xc3SUEX2TjexbCuYjefUxmzlHK+QMS3uNiZ7beGMIT9ydU4dofKwlujfRpD105yVaRRNG9q8OcJa/
	/Miu2zvah31iGEr0kkI0mYnDq8OO9JyTB22/jdB/0u9ZdVD0MJdOiLoD4WXtg+oSTURXg9Ugp5dus
	B5LIjlBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMt8m-00000000Gh9-1UDu;
	Tue, 12 May 2026 19:51:40 +0000
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMt8j-00000000GfR-3U3D
	for kexec@lists.infradead.org;
	Tue, 12 May 2026 19:51:38 +0000
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-82fa1c94b37so6676099b3a.0
        for <kexec@lists.infradead.org>; Tue, 12 May 2026 12:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778615496; x=1779220296; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XMGmjrgacA7FJIZhwbjaKrLrnllX5lCbrSfU7CyJlss=;
        b=G/YaytgKHUswycZA0rOLaY/HMK6e8j1xUy+0CIQ03GnMIbf/LqJcBNIamK/l8DVDAk
         ZSn4aIt1e7N0+fn9lTxDm3Hm7W//wnEuGeo9XbMsn5N4mQM2ChI6uKRBEt2/PgpVqTw9
         lvODqnxsjzS7QlzX0Xo+ZTT3RMDYt8esqJJFbPuPW5KVuG3JXcPOovNYZzrCA8tPap8X
         kfeFBzcFGkEelcQKfbbDQCs/Th3RPePcVZzFYVeyZb2GsmWHRYuknHYiSPlC6Zl7Ikp/
         biXhSYjsFQGSu36yCKEtbJJBO/KJ7CTURYgeKvNOvo8Wzhbnrme4C7jUGQXW2c7HTHzQ
         tO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778615496; x=1779220296;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XMGmjrgacA7FJIZhwbjaKrLrnllX5lCbrSfU7CyJlss=;
        b=UiFvYJAXM12rGbqccuKAtgIQ7DQTPzNxbNuieo8dXyOCza/9qju3XDg2xfe0uO/mgV
         LbM+5X3Q15Zjudadzi/Ji5ojharlm2gSSQymyrONyNVe/Qzn2ENEfEX+8RmikjtxNbpf
         jaRTofNMLfBKXyDShniC47ue4Bic65RIvb5vsjhUJ6K7qxfARSXv8aJmq5yYjMKW9Erz
         Etvci/T3Qn0hLgj37dZ7vPKCJoucfF35AV7aJrmVtX0bvhvdVaXEIb8SHsweJvE1XuFT
         +Gf/IRdDhYVDl1HqA0bLoXXbJhkMQY1cqAKEl8S911LCMS8HufwuZMkMky6VxQ9OCJdZ
         tUTw==
X-Forwarded-Encrypted: i=1; AFNElJ94iMdLSNa8939pv4iuMztX8H1h/ZEE0h+7q/vl/VEf2fcLO4th9NaR1Yuk68HVb3kZztF4Zg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwSc7fuVNEU4lYrOljVgOQVeIaK+hvmRDGtAgF1v3RH1ZvqtmYx
	kYi3dXgqPLJpcxu6G8XRB6/Yq9/UMeP7CFbB0sIrSze/Bxv/6KE3SLlEMkmbpVKXRloDfYULIRz
	JF60GEZKbrLSWHw==
X-Received: from pfbmd2.prod.google.com ([2002:a05:6a00:7702:b0:82f:4183:2832])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2d9f:b0:82f:4725:f6d0 with SMTP id d2e1a72fcca58-83ee83ed7b2mr4983816b3a.29.1778615495829;
 Tue, 12 May 2026 12:51:35 -0700 (PDT)
Date: Tue, 12 May 2026 19:51:32 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512195135.804833-1-skhawaja@google.com>
Subject: [PATCH 0/3] kho: Add support for kunit mocking KHO restore API
From: Samiullah Khawaja <skhawaja@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, David Matlack <dmatlack@google.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KEXEC HANDOVER (KHO)" <kexec@lists.infradead.org>, 
	"open list:KEXEC HANDOVER (KHO)" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260512_125137_872561_93E2F56D 
X-CRM114-Status: GOOD (  11.91  )
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

Samiullah Khawaja (3):
  kho: Add kunit static stubs
  kho: Add helper function to check if pages are preserved
  kho: Add kunit test to verify preserve/restore pages and folio

 include/linux/kexec_handover.h          |   5 +
 kernel/liveupdate/Kconfig               |  10 ++
 kernel/liveupdate/Makefile              |   1 +
 kernel/liveupdate/kexec_handover.c      |  61 ++++++++++-
 kernel/liveupdate/kexec_handover_test.c | 130 ++++++++++++++++++++++++
 5 files changed, 206 insertions(+), 1 deletion(-)
 create mode 100644 kernel/liveupdate/kexec_handover_test.c


base-commit: 9974969c14031a097d6b45bcb7a06bb4aa525c40
-- 
2.54.0.563.g4f69b47b94-goog


