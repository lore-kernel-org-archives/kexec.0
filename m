Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8960CCDB470
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 10:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+N+IZZBBGfHHVcpbuDlZE6lMJRHVBCZgw8qCBfTHFu4=; b=4hOpPgzxT+Kes0bOg7TNT8/l0+
	Y0F9KZtcJrctv3OEQCzx/i7e9jfZmW6WuxxeiLjVThoI9NkD3qpwAhNyNToC6WTWgkLrxtiyiO0jH
	lrY4/DsacY9i9Fohl6HZBprp7PFE71A9LOolYWb9H9c5mYA7KNhCr+C+Rq0chJcPaVLN+FIso/zfj
	AKf2N9g2o1cc23Y/cShIk2w8KZSVG2AqihWfv9rXRdeQBZGdFdoQYauJgGf0KJFcAqMgqD4vAW3VQ
	gKVsxf8Rmdq/OkpkZCyUbp/X3ON7+eeXOGN3raRJelUsWfS39DKSTTk9w5dM4ZGDspCJFuzFWu+iH
	h/FNgJ/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbbyX-00000004q1W-0ECe;
	Mon, 22 Jun 2026 10:33:57 +0000
Received: from mail-ej1-x649.google.com ([2a00:1450:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbbyQ-00000004q0i-2WgJ
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 10:33:54 +0000
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-c0cd278cd17so195690766b.0
        for <kexec@lists.infradead.org>; Mon, 22 Jun 2026 03:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782124428; x=1782729228; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+N+IZZBBGfHHVcpbuDlZE6lMJRHVBCZgw8qCBfTHFu4=;
        b=Ydh5yC+nztQV/TnxHm3vOlvVtzBOycQXJsRPm99MCBLSD6cjfN4wDb44ort6KOStHc
         u4qNGxdvqv9IbknNvpsx+CNPm5kLy661b6tFbMG7W8+yLxj1rrEjQ0nwhhbZY28F5u6p
         VoV6coOx5QXDI3CmpFKutdW3BcN7efx5yL8CDXVL8Na9YmNhaNOiSD3sIb8X9IbpJIn/
         q7guB5zNGWqUth8FUvLN4oQRuYqFv1PhvugC1pBXxzurG0MBbKh2wjFQvxS3KYpAvVQH
         IBMCmBwzgeavx478Rspx0+ppnpctIuYrt/bBvZG+83lZ/QJkHoVj1iL5LLT7iuOaGAaV
         f2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782124428; x=1782729228;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+N+IZZBBGfHHVcpbuDlZE6lMJRHVBCZgw8qCBfTHFu4=;
        b=YcxzzTxub3m1OIlMhxsvhnqTSlxmC8PCLStSmAbPwpnd/q4SNoVkNj1V/muA2R3fzS
         TO8iMCqtbbgZ+EsEK7nrP3CR2z9NkBS5NBh0OW03N6IhucwQ7QxX3WGI3KfwrEkGKT8D
         eHS3DiWZpDJ/9e+QEc+F3RpA0tGUSP7LsQQ/+vO09XH1xRIOTjDLGkLnhkEHtuYIC0eL
         2s62LZnZB2JlH7wohpLd1s11sMTC/qnMHngNnANHenGKSF2o3aDgeKuR9B0YUBqdc4W7
         sgdBk9USl4uarF3+dFoeIUQnACPqGV1IdW3zuBdpV+rreyOBxXVvItFvfGmhvTeanUGB
         dPkw==
X-Forwarded-Encrypted: i=1; AFNElJ+63if7RbFYQMFToF2hPPt4kCzQUIY/1a+pxT89LE0j+C8Isz7zv3WzdcPa11J6XoLYTyRetQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzwTBrDXJfx9lsVE/8TV8aHoQJ1xOFFOusnJRJ7M9jzXVNMwvhs
	yiSot0CknXCGSqEG40Pdi0UgUbYENsA+hEai/2tRTIMCzwMJ6qHusBS71WYicDHNG2Fciw1gcmQ
	khH2w/+gIEqHSGJ5PXQ==
X-Received: from edvd21.prod.google.com ([2002:aa7:ce15:0:b0:68b:3197:253e])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:6c0f:b0:c0d:9172:c8bc with SMTP id a640c23a62f3a-c0d9172cdd5mr322007166b.42.1782124427905;
 Mon, 22 Jun 2026 03:33:47 -0700 (PDT)
Date: Mon, 22 Jun 2026 10:33:43 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.738.g0c8ab3ebcc-goog
Message-ID: <cover.1781863524.git.tarunsahu@google.com>
Subject: [PATCH v3 0/2] luo: migrate serialized_data to KHOSER_PTR
From: Tarun Sahu <tarunsahu@google.com>
To: Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_033350_681241_D5573F9D 
X-CRM114-Status: UNSURE (   7.54  )
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

Covvert raw serialized_data to KHO serializeable pointer (KHOSER_PTR).
This series also takes care of resolving the bug with memfd preservation
of using phys_to_virt before checking the args->serialized_data value.

REBASED on top of liveupdate/next.

Tarun Sahu (2):
  kho: add KHOSER_COPY_TYPE(UN)SAFE for phys copy
  luo: Update serialized data to use KHOSER_PTR

 include/linux/kho/abi/kexec_handover.h | 12 ++++++++++++
 include/linux/kho/abi/luo.h            |  4 ++--
 include/linux/liveupdate.h             |  4 ++--
 kernel/liveupdate/luo_file.c           | 24 ++++++++++++------------
 mm/memfd_luo.c                         | 18 +++++++++---------
 5 files changed, 37 insertions(+), 25 deletions(-)


base-commit: e98a9c61721c14bcd29f11f4802e52e908701f7a
-- 
2.55.0.rc0.738.g0c8ab3ebcc-goog


