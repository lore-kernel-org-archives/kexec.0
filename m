Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E56C5DF85
	for <kexec@archiver.kernel.org>; Wed, 19 Aug 2026 17:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:MIME-Version:Message-Id:Date:Subject:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3rl9WRlfF1qhC6KkWtM+soeUVUGORv4VBrHtcu1jow0=; b=juckLEJTkM6Kr6ACSzYgIPS9Ni
	8bkpMsiw5S6Ly8GqT3FfUW1EadDkakUEDnynNhKWkK1nfwILCRuOWcYcK0Mm+J7lYyfYJImLcO3V+
	wt7gHfDMTl/RETZ3ZPr3CKeJrgvz+4FXntDDf61sL7nbjK6Jwp/9IjCRVFgYjkyr8dNuuKSQq0+N4
	V/GwztiVd9J9B4aajSsoK04AUgwa9hZcsfxoQ6W0emUrjjIpBqycD/uS9Lsh1BfjKYm/5qbeqDdih
	8L/W+B1fziK0ldm661LeiiLZNCMEr9/dnGy2O70MLKdO1quzrEUM/XDEYAyAYuadt7BVjSLmiJ0TN
	r+KfBv6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwkOC-0000000AIvB-19a4;
	Wed, 19 Aug 2026 17:47:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwkO5-0000000AIth-0Sg5
	for kexec@lists.infradead.org;
	Wed, 19 Aug 2026 17:47:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787161659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3rl9WRlfF1qhC6KkWtM+soeUVUGORv4VBrHtcu1jow0=;
	b=NzAzb9vgGfvt4oY7L0XCnjwotqC40OkSgE+cxBakWlk4EwMkRVYMn6J7/x7fatJlGHILsn
	LQ328hkz6uDGTqWo5MAcXTA8bfhdbStOEHG7EhA7ogXwZ1igj7TqP5pGOkDDDofRPmseFb
	8QYj95cieCn/SbeBH10Jlj9vewNf34I=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-unkOP6rrMCCvf5wDPVLgTA-1; Wed, 19 Aug 2026 13:47:38 -0400
X-MC-Unique: unkOP6rrMCCvf5wDPVLgTA-1
X-Mimecast-MFC-AGG-ID: unkOP6rrMCCvf5wDPVLgTA_1787161657
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e7b87ce77so3056821a91.0
        for <kexec@lists.infradead.org>; Wed, 19 Aug 2026 10:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787161657; x=1787766457;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3rl9WRlfF1qhC6KkWtM+soeUVUGORv4VBrHtcu1jow0=;
        b=VEJRasnpKcuKa6Qi2eOwT7SomIAHKQrXRfCzE9d8en+eYOu2RkhV3CO1tzn7tbz2Yg
         Cz9BlgoqwUfIVWAyV+cSy7ZsFzUpoDJRaoagkvMsBZv9FkKBUKnMWrDVJKj491hOJQ3w
         k0DhlIryNEpRdO5xKjQzQkE++yU2878NagJfhLZ5P/ywIt98qJ5NVriObiFhUUHJDdJh
         cPo9pMgWNFdF7Wb9cfVv+8Kb20AW01pQq0l3yc8gDd1PgDeMnDwOBXcxiAK1d3MGdxj1
         qUg/8ZbNmgQv91GwVckxwPHYgu32EcDRC0yhe7wRd4WJNxHVaP+XwMFH7CBxPrDEtmCL
         Vbxw==
X-Forwarded-Encrypted: i=1; AHgh+Ro+d2Geq6Oil4H49ZfcUGdKKRMHMtaxjB6boWGMAORcOXLf7BR86t0KTKy05uujr6Tx8cmYNw==@lists.infradead.org
X-Gm-Message-State: AFuF++mqF3Cl0GFIsRA7wGUG/GSKGV1H7sxQ5h3lk9QgytDpJ8TjMYED
	t2Kc54DS0DkQqEFvXNc8RsLYp7zlJugb7YNKlG9jPizmXP8OgCMDefJAVoeb0tLR1HpoZ868Cfq
	0+W3XthDBOcScBmB1Gn0ba+GZFuht4nSl37ySiwX0U1FzHw4F3YQwYjrSjJyr1Q==
X-Gm-Gg: AR+sD12kJxUjwEjR8oyYgwHMr94tBEZZxXTkdR8cP784fcNo3u2u0LRUz7a/m+3SXUL
	m19eIf/ihRo6qAQ9R3wD5rfLGEmPNQS/F8gWffbedLNoM5DFUUe41/sXqyT4cSjP2NTiPL59LHA
	UdyErADgJE4j44FdHKQkKH7G5mojt+WDeb4vqmOWTH9RLkMOHJaaxzj+EQaIZcRngDs5dyZmRVv
	RwIvHu0r0fPi6l3QEbqITfSa7/URRzJxHxl7Hm+PDaNyTFTqX/0llD/I0MP2LGgBZv1/0cqECUH
	wxzE+NiXQW5HIqeaRtqHsIVMYQJEkJP4gV1/62og+0gf/ufJr/uGyyAQLDslX5TIPVUBBXNbD/N
	nJ13Lw0M8rxH0oBBVGMY0PJMvoj8Tl9K8
X-Received: by 2002:a17:90b:5289:b0:38e:70d5:b12d with SMTP id 98e67ed59e1d1-39580aa5d7cmr13092162a91.6.1787161657002;
        Wed, 19 Aug 2026 10:47:37 -0700 (PDT)
X-Received: by 2002:a17:90b:5289:b0:38e:70d5:b12d with SMTP id 98e67ed59e1d1-39580aa5d7cmr13092025a91.6.1787161656348;
        Wed, 19 Aug 2026 10:47:36 -0700 (PDT)
Received: from mpilaniy-mac.redhat.corp ([122.171.22.116])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957f96ca41sm3319861a91.4.2026.08.19.10.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 10:47:35 -0700 (PDT)
From: Mukesh Pilaniya <mpilaniy@redhat.com>
Subject: [PATCH v2 0/2] kexec: fix probe error codes and error propagation
Date: Wed, 19 Aug 2026 23:17:21 +0530
Message-Id: <20260819-mpilaniy-v2-0-95e929ede0e5@redhat.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22Nyw6CMBBFf4XM2po+jFVX/IdhAe3UjhFKWmwkp
 P8u4NblSc49d4GEkTDBrVogYqZEYVhBHiowvh0eyMiuDJLLM78IxfqRXu1AM3Ou48ZcpVFCwaq
 PER199tS9+XF6d08007bfDE9pCnHev7LYvD/ZLJhgWmt7shwVd7qOaH07HU3ooSmlfAFPzfzOs
 wAAAA==
X-Change-ID: 20260813-mpilaniy-ffb0cc92c313
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Tao Liu <ltao@redhat.com>, 
 Philipp Rudo <prudo@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, 
 kexec@lists.infradead.org, Mukesh Pilaniya <mpilaniy@redhat.com>
X-Mailer: b4 0.15.2
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: U2LuWJbGxUcdVmzANoOq63ae3x6KgX5NNJWSOQtDdew_1787161657
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260819_104741_229799_C9733B84 
X-CRM114-Status: GOOD (  14.23  )
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

While debugging a misleading error on s390x where kexec -s reported
"syscall kexec_file_load not available" instead of the actual EINVAL
from a kernel command line that exceeded the architecture limit, we
found that some kexec image probe functions return -EINVAL instead of
-ENOEXEC for format mismatches, and kexec_image_probe_default() has a
bug where it returns whatever the last loader returned rather than
always returning -ENOEXEC when no loader matches.

Patch 1 fixes all probe functions to return -ENOEXEC when they do not
recognize the image format.

Patch 2 fixes kexec_image_probe_default() to distinguish format
mismatches (-ENOEXEC) from real errors (e.g. -ENOMEM), propagating
real errors immediately and only continuing to the next loader on
-ENOEXEC.

kexec-tools patch:
https://lore.kernel.org/all/20260814075329.30203-1-mpilaniy@redhat.com/

Signed-off-by: Mukesh Pilaniya <mpilaniy@redhat.com>
---
Changes in v2:
- Added patch 2 to fix error propagation in kexec_image_probe_default(),
  as suggested by Pratyush Yadav.
- Link to v1: https://patch.msgid.link/20260813-mpilaniy-v1-1-777d4d0e30f7@redhat.com

To: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
To: Huacai Chen <chenhuacai@kernel.org>
To: WANG Xuerui <kernel@xen0n.name>
To: Paul Walmsley <pjw@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
To: Albert Ou <aou@eecs.berkeley.edu>
To: Alexandre Ghiti <alex@ghiti.fr>
To: Andrew Morton <akpm@linux-foundation.org>
To: Baoquan He <baoquan.he@linux.dev>
To: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
To: Philipp Rudo <prudo@redhat.com>
To: Tao Liu <ltao@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: loongarch@lists.linux.dev
Cc: linux-riscv@lists.infradead.org
Cc: kexec@lists.infradead.org

---
Mukesh Pilaniya (2):
      kexec: return -ENOEXEC from image probe functions on mismatch
      kexec: fix error propagation in kexec_image_probe_default()

 arch/arm64/kernel/kexec_image.c   |  4 ++--
 arch/loongarch/kernel/kexec_efi.c |  4 ++--
 arch/riscv/kernel/kexec_image.c   |  4 ++--
 kernel/kexec_elf.c                |  4 ++--
 kernel/kexec_file.c               | 12 +++++++-----
 5 files changed, 15 insertions(+), 13 deletions(-)
---
base-commit: dd8c49a14f169d58e7a07a2c96fb588f3456efa0
change-id: 20260813-mpilaniy-ffb0cc92c313

Best regards,
--  
Mukesh Pilaniya <mpilaniy@redhat.com>


