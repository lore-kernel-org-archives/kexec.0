Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13EA8C5DF87
	for <kexec@archiver.kernel.org>; Fri, 21 Aug 2026 13:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:MIME-Version:Message-Id:Date:Subject:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FxYBqvqfSfMLOK6E3WTT29SXyr6Pc7OT1nYn+VS1dSk=; b=VuoMklTejY7kbXiku5Toyz9UrT
	8EQLv5EbBGRBuw7RboCnJAhMdwE8bFU22Utn6v79q1Mg1xPqBHKDUpZWd8CRMU1qEcxrbRpZrJqgz
	AZqIPE5fHx1nX5FjCwH542ZH17xcY4gcuqs6pyndEzNI33TWut6BbwgZou9ibfEX41F+H3kYZGkv3
	PmNIAuXx7dFEb1gIKByftclXwIyq/gTzs5FBG7+rw2/QoVnqiGCohmjZGSnoULeUX6wq/nuZM/H3Z
	zjxOlKeEZUnF6j+cSW6CL0Hm9zJnCZ/9WwintFzAN0yOMAy2vll4xP4a+MGuIzJDUDEMAduzdXrzw
	XcgR8jlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxPdU-0000000DSTb-38cp;
	Fri, 21 Aug 2026 13:50:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxPdS-0000000DST0-0DMS
	for kexec@lists.infradead.org;
	Fri, 21 Aug 2026 13:50:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787320217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FxYBqvqfSfMLOK6E3WTT29SXyr6Pc7OT1nYn+VS1dSk=;
	b=Xuu50gXOOIn+pTbi08Q2z8+CBj+UQQAsKSQDDtra8kvFSItupBoqUd4pwMbFlwSoB6TPaB
	cg0i6v8z1NplqT5vzu4ZU1/l8yvAx8IYKCjw2FZW9woao5ythyq7ZwoXET9u7b06+cw4Pt
	pxfPzaa3IDgnvpLrGQei5CKaoFjB1mE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-Q1H5RQNWM8WbMT1IliIxZQ-1; Fri, 21 Aug 2026 09:50:15 -0400
X-MC-Unique: Q1H5RQNWM8WbMT1IliIxZQ-1
X-Mimecast-MFC-AGG-ID: Q1H5RQNWM8WbMT1IliIxZQ_1787320214
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38ea32e57e2so1963180a91.1
        for <kexec@lists.infradead.org>; Fri, 21 Aug 2026 06:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787320214; x=1787925014;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FxYBqvqfSfMLOK6E3WTT29SXyr6Pc7OT1nYn+VS1dSk=;
        b=MUBrjb8SBjONwshaJ6UVeTRSjw0z733/AyzQQkwNHxnVlz+4vqN/1xR/mUk6YkWXV0
         um4nyrYQAR+q/EBVbiu3vUHOeSWGJluzEOgGogOuiNkTshu5mAnDUDA71XP5c8y716ex
         ZtSRPYNxrw8Z592AcMsHioXZsulrvirjVghnFqF9ggK9hjMI21gJSLb1eQdkRKwxDIrk
         KV/orOqWRaxVMi9zBsR/HN3ah2VRbGN4dCNRJRlE25Vtv20hcW2cN4FIgtrSllXA86GW
         TXpD4j+eY/1YEnhcxK6SavJY4cXVSMIxF7U7QuRmMTmQTaLrdgLzFEUiNs+CZNpP6ANq
         QUHg==
X-Forwarded-Encrypted: i=1; AHgh+RqIacg8z2cdwW+cHrFsdgYTaHqiVfKxpI+eMpZQKA4UHQZBYvBjYNcfbsscJ75wn4VOSsBBXQ==@lists.infradead.org
X-Gm-Message-State: AFuF++mi5QHOrPmsL0tlP0wr0gh5r2nSAys750ocCCxMgknjTQhBdjdA
	u/vnfsbNZAu6WV6P6pK/RdrzSLOzHGtSsRZdkC+weZKm0ww0D3cngebZwt1PLxhrZGVs9n1R+uk
	21wFjBfWcvJyTagndeCbEwkcgJ4mXhNlXSn85fM1o6XXq98gEHPJjvpXiNsyMuQ==
X-Gm-Gg: AR+sD1368tbAnT1qHvs6gBtqJ5L531oTPcb2+9ssLRPY5LknAeUdezh3u1i/qJiSCfJ
	4EffLv8onZvLe80bc8k1wscYh6361A0P6VhwHQMm6O2dq8k+nASeTbb3NH2Y0B9vyvXN4yAuMb6
	w4n2qX/MItUbo5LdAKLoYp2rOa3FWUZOPq8MZPWzNpfM33ZJr9buncbBb75f62tK8wn92tjU6w/
	vOU5WygN1sa/Dres3/Ev+197YZ5y6GkjfVpTWLK9YqLELdDzWsHBZNdSc+gzYkqzhlZqsNzVVhx
	k0QBsLNr1+ZhivwJj2gp4G3QUaQUbzmSMZGk1C/coukKOI0AvlcVVzJsE6hvPo4yZhiY0sIwwA7
	ds0iG7o278pnWx7w7pHd+EKvM9do5bSn8
X-Received: by 2002:a17:90b:3ecc:b0:38e:ad9d:1161 with SMTP id 98e67ed59e1d1-395c2f9fa9bmr10834154a91.0.1787320213435;
        Fri, 21 Aug 2026 06:50:13 -0700 (PDT)
X-Received: by 2002:a17:90b:3ecc:b0:38e:ad9d:1161 with SMTP id 98e67ed59e1d1-395c2f9fa9bmr10834046a91.0.1787320212881;
        Fri, 21 Aug 2026 06:50:12 -0700 (PDT)
Received: from mpilaniy-mac.redhat.corp ([122.171.22.116])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c4c194d2sm3300502a91.15.2026.08.21.06.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 06:50:12 -0700 (PDT)
From: Mukesh Pilaniya <mpilaniy@redhat.com>
Subject: [PATCH v3 0/2] kexec: fix probe error codes and error propagation
Date: Fri, 21 Aug 2026 19:19:56 +0530
Message-Id: <20260821-mpilaniy-v3-0-76b355399d2e@redhat.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22Nyw6CMBQFf4V0bU0fYq0r/8O4gPZWrpFCWmwkh
 H+X4gYTl5OcmTORCAEhknMxkQAJI3Z+AbkriGkqfweKdmEimDiyE5e07fFZeRypczUzRgsjuST
 LvA/g8L2mrrcvx1f9ADNkPy8ajEMXxvUr8bz7k02ccqqUsgfLQDKnLgFsUw1707Ukd5PYmnpjC
 sqoLkELDRYYlD/mPM8fdp454+0AAAA=
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
 kexec@lists.infradead.org, Mukesh Pilaniya <mpilaniy@redhat.com>, 
 Bradley Morgan <include@grrlz.net>
X-Mailer: b4 0.15.2
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0m6LM6jM6hfDV2fmz-o9veXFcEKQ8OiA1ZdzQoxPC98_1787320214
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_065018_187868_BE51098C 
X-CRM114-Status: GOOD (  13.49  )
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
Changes in v3:
- Patch 2: rename ret to err and change ret == 0 to !err as suggested by Mike.
- Link to v2: https://patch.msgid.link/20260819-mpilaniy-v2-0-95e929ede0e5@redhat.com

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


