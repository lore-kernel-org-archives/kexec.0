Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DADACDB47C
	for <kexec@archiver.kernel.org>; Tue, 23 Jun 2026 10:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CTCz4sMSsafNhU5kYM2pwCVlzIjBwvspLMJZApXNuTI=; b=qd/EZEDfQlJu/Zeqk0q0tRLltU
	rAg1ZrvCDU2hMrzqtIAuSOzmlPF4bVOWhpuj/Wu8SIYFSrZ0be/dR1fvme4sm9UEw8b8KDPKy/Wnv
	3kbxLKhJR4QNpMgHJjy1wjGruwmljk0vJptFlfqP/oKkvolFuKQ2fFgKF5cWaNby5F70DNSrOI71m
	FsSwftdL4+a5oJdaUXk4ODB1ksGKYrfgq0oLmJyWm1bCI5Vb0U5vvurhRA4SXxFuKhuZ0l6xr0LS9
	wwBfMKXArlHMbMCeu7FmGgoa/5wdCzcTzxgAD0Md10kshFKvgXMa72OsnQMUaPGZC4PN7F/S8jCUp
	/+rgYCqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbyjg-000000066zO-3o11;
	Tue, 23 Jun 2026 10:52:08 +0000
Received: from mail-ed1-x54a.google.com ([2a00:1450:4864:20::54a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbyjd-000000066yG-3VvV
	for kexec@lists.infradead.org;
	Tue, 23 Jun 2026 10:52:06 +0000
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-696bf062625so4393943a12.2
        for <kexec@lists.infradead.org>; Tue, 23 Jun 2026 03:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782211923; x=1782816723; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CTCz4sMSsafNhU5kYM2pwCVlzIjBwvspLMJZApXNuTI=;
        b=I7L8Jdw4b+iGtfBLOqh5F8BzrLukF7hnpeJ9T59VnVWLpX60qCadYgoEoKOHnb0oYz
         x25oWlG4j7lO0XL2ipTq2guwLawBxNVtafhTByCsfL6TPKL4Yg2pgrMXmoVOQwcrG80U
         IQ3HLsj5KAUj2KUV3cZ4wXruABh/KkuxRFXUjg/rwz5ukKGTuuPzpJszuA22QeA8TmDp
         ++HnyY3oOoiARPs865OPfNkph633uJzCygupl+wJjzPeQJ22kLgMuHT3yuOWUK6ydM/G
         Bh/OUyfEKvBpItQAVRdgqj7xWPDJ5OZfbDoWU1nDnnDaHXqybv2/zShl5x7xoVkQeta3
         hc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782211923; x=1782816723;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CTCz4sMSsafNhU5kYM2pwCVlzIjBwvspLMJZApXNuTI=;
        b=WexPNZFxzGEwW7WvkiBMw3GtFDzDDLYFYJDzMdwfvwOdOypNJLAn01I4pFlRp1GCDW
         GuDmMfOvuRv0yv4Z4qMeU4xTQ9JSTeDs0WjjL4+/o91Zm96RSDrPd3tXTi0LoygeAQKX
         Vnavi2WidAks+9SmB/wfUc96MMGi6Pf7IAogJuZqEIxlHx9yAy5N8E6LJDQTCWBqX/RI
         02GUVbpk9BzQuBidn/xNRn9JMaavvA1abvOX04qHwBZc8sPtcgEa8IsSy5M8ap1wmfcC
         8+QLNS5ScyuqunzvNBPVmRHpsC5CbpDOQ+h/ewIzk8RhIhDbV8ElxiRVzFOfVdO2W2QZ
         Ajpw==
X-Gm-Message-State: AOJu0Yz0kIWUIzbLrW6b7c8WzBZdLGUts35xeMHTH+hEeRZ6JlbdUZU9
	wx7mKn0GPZZCnSjJxlrhbGWQbjGxva8ZqzNJJWMjdfudbByUcMMOZQTOFO8Atn6/FPdkCpqQNUy
	Ql7PsBaLRtyHbhEASgQ==
X-Received: from edvl5.prod.google.com ([2002:a05:6402:285:b0:697:de18:6de9])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:2803:b0:691:a8bd:981d with SMTP id 4fb4d7f45d1cf-697dbad110dmr1143090a12.4.1782211923249;
 Tue, 23 Jun 2026 03:52:03 -0700 (PDT)
Date: Tue, 23 Jun 2026 10:51:58 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260623105201.3724592-1-tarunsahu@google.com>
Subject: [PATCH v5 0/2] luo: convert serialized ptr to KHOSER_PTR
From: Tarun Sahu <tarunsahu@google.com>
To: Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Graf <graf@amazon.com>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260623_035205_886266_6BF61A3F 
X-CRM114-Status: UNSURE (   8.21  )
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

Convert raw serialized_data to KHO serializeable pointer (KHOSER_PTR).
This series also takes care of resolving the bug with memfd of using
phys_to_virt before checking the args->serialized_data value.

v5 <- v4
	separate the memfd_luo fix in a new commit to allow backport if
	needed.

v4 <- RESEND V3
	use only KHOSER_COPY_PTR and have compiler time check for type
	excluding void * types. Remove TYPE(UN)SAFE variants.
RESEND V3:
	Sent incorrect thread format earlier, this one is with correct
	one.
v3 <- v2
	Rebased on top of liveupdate/next
v2 <- v1
	Use KHOSER_PTR across liveupdate files instead of only memfd_luo

Tarun Sahu (3):
  mm/memfd_luo: validate serialized_data before conversion
  kho: add KHOSER_COPY_PTR to allow phys copy of serialized ptr
  luo: Update serialized data to use KHOSER_PTR

 include/linux/kho/abi/kexec_handover.h | 11 +++++++++++
 include/linux/kho/abi/luo.h            |  5 +++--
 include/linux/liveupdate.h             |  4 ++--
 kernel/liveupdate/luo_file.c           | 24 ++++++++++++------------
 mm/memfd_luo.c                         | 22 +++++++++++++---------
 5 files changed, 41 insertions(+), 25 deletions(-)


base-commit: e98a9c61721c14bcd29f11f4802e52e908701f7a
-- 
2.55.0.rc0.786.g65d90a0328-goog


