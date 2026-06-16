Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB0ECD98E1
	for <kexec@archiver.kernel.org>; Tue, 16 Jun 2026 13:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bZH1+Yyqz6xQZNsOX4wfP6dQl35j3VE/PV0SUnY68BY=; b=dpM0y2+nZqhtygKEz766Y5A4q0
	KaV4hAb1G3EVPxreBaSYmLYkditZ/jWx06aBifHkzR3ZOYO4g+NabYBrq6PONkVcjSM7IpqvsgOih
	wu7RWcSmcmso6eqK5yTlpSjX1S/sn5H/5jCioSzpVP0ubGNWsqh7nh1fjmJW734fS/1tgG74TX+tO
	V5CRJhQgfcY5ng/dImfauiOT36ha5xmTZOuxrWbD195RnL4t+Zw1LkJBeDi4FyRI4osjpfXydgJ5T
	v+IMjksRzEHKSrQeAAj/JVvm11VEiz6XOh3zUicKnJqpOF1FxK4WtZDVp9BLwUlo7JWKY6R6rwp8Q
	/FCnIu/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZTlm-0000000FpgI-0ngY;
	Tue, 16 Jun 2026 13:23:58 +0000
Received: from mail-wr1-x449.google.com ([2a00:1450:4864:20::449])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZTlk-0000000FpfZ-27rS
	for kexec@lists.infradead.org;
	Tue, 16 Jun 2026 13:23:57 +0000
Received: by mail-wr1-x449.google.com with SMTP id ffacd0b85a97d-45efa2f7009so3145989f8f.3
        for <kexec@lists.infradead.org>; Tue, 16 Jun 2026 06:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781616234; x=1782221034; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bZH1+Yyqz6xQZNsOX4wfP6dQl35j3VE/PV0SUnY68BY=;
        b=kDx2XWi5Sq9YyBKRWXgeStVo+ANK+0OTAUMP5b2KQ8S5tbTEojQDRe9lAp2aNbJW05
         c817XUb6IaIG48eXiTo6ko6DonNPTMadWaWUBoQ8nQSS6gHdbx+Yn9CnhfcxyAJGUtW5
         81m1TsW3NRNyh5UDf8XTCGb1z3oQZOid0s2jHiB2nXqyTC2iK/WtoyEivQsZ01B5leQx
         iKq5xcPS0CmENBoFI/+t0LdrufrEJZg+M7DyAMN2wMOELXHNNfIG+GcXdFojQYgNfWQS
         pu7BGDFLST43fkX/I/5Q7Nf0+uEjYNPJ6lpNRmoVAk+1pBngzz6HAM5LoX2M2m2QxTVN
         yEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781616234; x=1782221034;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bZH1+Yyqz6xQZNsOX4wfP6dQl35j3VE/PV0SUnY68BY=;
        b=Bgt+AiWqxnH4Qu+UrCv1zkhOxGa1v9f+9QMnvAo4HNKVZxBym/8ST1+ujcVfsOxO3B
         rewz0zaVJvpMiUsHiRCWTDKmP0bqEkBeLp1J6CC00KzL8HdJH5O9T0gd4JuXwddRVM3T
         +KGeiEvBKhdsVoIzuQe4h8XbZyBOnTr5d2yD/yWfXjYZ+FUSXvB/EDL3VUgJq8bNHUG+
         67GvUdoAt7RZyWzwebkphWnIzC17kUAkRBPxufwfW3sGxS57D2u10/7RCzdlyWtmaWl8
         fSHx7AaOuQYVFEKv5vz643os3+vsephwsfGBSXYTPsKkTmH/XWq2V5BWTg6mzs1Mm+CB
         y6NQ==
X-Forwarded-Encrypted: i=1; AFNElJ8+wSu5fRzcCGI2BpDwLuz77LO/3YMGwvxPZY40S54OHwVutvawICEaBVtxx0HMpNh0nglZaw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzUqbrOR3Tvu1vpoKo+Vj+m7NvUNjsuAE04Z+VdT3xWNotLvj+5
	hPsxVx0SHYcHvNEHE2LSkN3i21ggWB6HqJp1/PJz2NkgrT1bqj3xAQ5svF0ozLTn5sASTZCJidf
	g1cBrWunW8PjRlbE8/A==
X-Received: from wrcl8.prod.google.com ([2002:a5d:5268:0:b0:460:18c0:dfeb])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2584:b0:460:1967:abed with SMTP id ffacd0b85a97d-4607eaf7cfemr19334284f8f.39.1781616233699;
 Tue, 16 Jun 2026 06:23:53 -0700 (PDT)
Date: Tue, 16 Jun 2026 13:23:49 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <cover.1781615759.git.tarunsahu@google.com>
Subject: [PATCH v2 0/2] luo: migrate serialized_data to type-safe KHO pointers
From: Tarun Sahu <tarunsahu@google.com>
To: Alexander Graf <graf@amazon.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kexec@lists.infradead.org, Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260616_062356_721934_010AEFCF 
X-CRM114-Status: UNSURE (   7.30  )
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
This series also takes care of resolving the bug with memfd of using
phys_to_virt before checking the args->serialized_data value.

Tarun Sahu (2):
  kho: add KHOSER_COPY_TYPE(UN)SAFE for phys copy
  luo: Update serialized data to serializeable pointer

 include/linux/kho/abi/kexec_handover.h | 12 ++++++++++++
 include/linux/kho/abi/luo.h            |  6 ++++--
 include/linux/liveupdate.h             |  4 ++--
 kernel/liveupdate/luo_file.c           | 24 ++++++++++++------------
 mm/memfd_luo.c                         | 18 +++++++++---------
 5 files changed, 39 insertions(+), 25 deletions(-)


base-commit: 0e0611827f3349d0a2ac121c023a6d3260dcecdb
-- 
2.54.0.1136.gdb2ca164c4-goog


