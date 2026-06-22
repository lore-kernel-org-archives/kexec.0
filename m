Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A68CDB46F
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 22:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GuqegTQ8Dp22axBp2zLQ2UPTz2GcEz8o9NQNs3L+qeQ=; b=E9MO3LgVAIii4i1czdMWJ+myvy
	IunU9oV6KXwUDnga12tRqF3XzVgCA/gfwMyTI0TKnJDS43vsJ9xtc1nJEru7TGi9f49VfhDbIH8GK
	P/Gck2JvAEo3RVJsgdtbSW9/vrPyZGcBxEKWzpyf6xVav6BVXmVGH01WIAlIEsBl9J72UCuSlKSog
	elA4opMae5Gnk73t5ZolHBpgT9D+KJeDw5umkrWtzXIC0CAq0b9zeFod3TBw1ZxJE/zO05ESIq4Ez
	Vt142DKX8M7ycK15iEhjTymUiWfZ9Jkh6+2HC0/K8CJ1eWUcU3p1LVGcUbmpq/OkhHmvEvRJImsox
	O4AzxpEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbnaJ-00000005S8R-42I3;
	Mon, 22 Jun 2026 22:57:43 +0000
Received: from mail-ej1-x649.google.com ([2a00:1450:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbnaH-00000005S7l-2i1t
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 22:57:42 +0000
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-c081f1976f8so418563466b.1
        for <kexec@lists.infradead.org>; Mon, 22 Jun 2026 15:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782169059; x=1782773859; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GuqegTQ8Dp22axBp2zLQ2UPTz2GcEz8o9NQNs3L+qeQ=;
        b=bcW6580/ptwUbY4cbPyB4eLnyK8ESYjt2YBSqBu1wunlP5gbEsMd4c7l3TGdlS+Kh/
         5OcUzXVMeAFbU6w+oZqAsH7OQdc+ssBYoC0XQ58KcsAagFvkpNVT3jyQr3mwjOdBC+3R
         Iqb9iI3w9+ESok6/sGNXzS3TmjxgEzC08OSbsKiqc5sAT9zKiuL1Ws40aJwWSmEnmB+7
         3JUajukHx3BPZYVWjUsY29+GTnTOyyAM/kBL3jlhsTpir8eHsQ5P69/0tTOpBPMK/h9j
         dd1bSQpBswvqXhLC4k8kMTE3b3wbll5Gyl66J+uVMP5FQ6Kztlqbs5Q8P3iIOxGAO8T2
         3jIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782169059; x=1782773859;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GuqegTQ8Dp22axBp2zLQ2UPTz2GcEz8o9NQNs3L+qeQ=;
        b=H4vcTQv9vE75IQgqpdgyuX9/8ibxpxt5pa+Gnku+5658UA2uuofst7fHnU8f2esEPN
         I8D2yPIOnqAcj2ijx4+Nf2gxWYdxq1iewIBnqcIrkTsNvnwvI5JPibjA/hvfxAB6rpla
         YLXq1BBO6eBohGf7GmGlkmH047fXgG39C2+7j/TWjc/E4RIeeHpZ1oCzyIGM4haFbw7b
         IDXGb/6k8QisDFNX/llFCc0WtBDcPYmvl6BAUphcbUYx2kaI8bTHeBaMaEFIl4t5Php5
         2C6g4iYKgEusOebKpJ1GyBLiQDY8fdcz+9ORdc/UL0K/22L3lqPotGE7irIgKWPJpP3u
         pWqw==
X-Forwarded-Encrypted: i=1; AFNElJ/G8fREGGmt1LR7XLZTupjnw7KdJZhjVADQ1uFGHOZMNsmtdRYzh4Sc+KSpaR2K/GNsixdAQg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxWe+uBMe4TlFYcm/CrYpS6BKzooha4+1c9KoRsk7u9Jkw4eXVD
	iswoPM4h3GnCdlLgwxLWfY51zeFF9hdE8lUSKr0RiUMO5xQyju1F69RC7BIMLZvFSMu34VAq2Ud
	UGLpahcd5WXfaHcAyAg==
X-Received: from edpg19.prod.google.com ([2002:aa7:d1d3:0:b0:695:4008:2b79])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:2345:b0:697:5124:15c6 with SMTP id 4fb4d7f45d1cf-697dbad0f06mr66279a12.3.1782169058595;
 Mon, 22 Jun 2026 15:57:38 -0700 (PDT)
Date: Mon, 22 Jun 2026 22:57:34 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260622225736.2961438-1-tarunsahu@google.com>
Subject: [PATCH v4 0/2] luo: convert serialized ptr to KHOSER_PTR
From: Tarun Sahu <tarunsahu@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_155741_695320_BEA52D75 
X-CRM114-Status: UNSURE (   8.17  )
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

Tarun Sahu (2):
  kho: add KHOSER_COPY_TYPE(UN)SAFE for phys copy
  luo: Update serialized data to use KHOSER_PTR

 include/linux/kho/abi/kexec_handover.h | 11 +++++++++++
 include/linux/kho/abi/luo.h            |  5 +++--
 include/linux/liveupdate.h             |  4 ++--
 kernel/liveupdate/luo_file.c           | 24 ++++++++++++------------
 mm/memfd_luo.c                         | 18 +++++++++---------
 5 files changed, 37 insertions(+), 25 deletions(-)


base-commit: e98a9c61721c14bcd29f11f4802e52e908701f7a
-- 
2.55.0.rc0.786.g65d90a0328-goog


