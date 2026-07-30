Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0258FC5516D
	for <kexec@archiver.kernel.org>; Thu, 30 Jul 2026 18:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:MIME-Version:References:In-Reply-To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BcSk1/y4fhEYP1oDWtEyRtQmE44YyXI71BVE0scYBk4=; b=psfWzkDsnxOdwsCkQs8PVnu8Cl
	p9GeDLq6Lkqj9U8AO3BKRuCHzB4GAo52eMbx2OwT/5dKWeMs+Ql2Y3dPjI3T/Ue1pPFIMZbIV4jiZ
	Fv5DZhnBVTIFwwJu/5H5AbZE/1ZYheYERjt9RGr7Sbz5vuJnBjk7fUXmuOE8kodXmXHjru3i2z1L1
	uwLphOIOVHPxqlY3CpTdVIVigFThEcF1yD8qVSBVcaeBmvUC1XrmkXhPt1x4iRIyZlV5aNE+W1cD+
	vbazDsXC9F4vj73by9f2OLOoyyceu+mQZFtnNrh4WySPU8B/oi4UR7ozRmBRlYskTCL6RqviCV1jF
	MW5YDPnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpVLF-0000000B9M6-2eLQ;
	Thu, 30 Jul 2026 18:18:49 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpVLD-0000000B9Lj-2fIe
	for kexec@lists.infradead.org;
	Thu, 30 Jul 2026 18:18:49 +0000
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-38dcbade417so186239a91.1
        for <kexec@lists.infradead.org>; Thu, 30 Jul 2026 11:18:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785435527; cv=none;
        d=google.com; s=arc-20260327;
        b=SSlXDP1ehcvuyDjzueCfjpbB/v7p1nsHKjHyhE34ol4Fjr7rQanwPmJXFSJQg6TttT
         9uUB+011ge/AaHCFGaBodZ+gdE6w8PE/QPGYqpRSK3pTDLL+dBkTM5qbqVtWYZ8zvtA9
         3rjDLlMvCnzHnqwBEAppY3fuqln9npqVmgSMPMstFNn85Oof11ouaFCRRB3ncY1+7KmB
         2kuOUVNaVovJsrzFkkmI84/JJiQZMhED81ZL9uL7WWSqA07FNHbIKw+YC+8HsO64wSmX
         oCEBTfwAocAFgrYfIxKG/cO11NwHrKYZttUVjj3tdoI6QJdw+aLPtsWIMHXMLJYoSGOj
         PLJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=BcSk1/y4fhEYP1oDWtEyRtQmE44YyXI71BVE0scYBk4=;
        fh=fpv0yt0kyjiaZoVU4HMIpVgGDYckdv0FWP+RhM0ATUE=;
        b=LUtj48imBFPVYfGWe3Q2TA+1Au5eBkiK6V5U+0dpTYoL2UF8H3komc00eo6FGrszAG
         Prg3Ee716RO06FqbZIspx63tXT3GeSiXQy6dBXib87hpaFx4OQHaM6sQX4vBfz57miab
         nbqtT0LJhKPTv5wc+qTgzvIAhTXkkZCePGns4FI4F0c6jTHtVrRdlHzN7lU2sNwF0bSh
         AoKwBUUgY3B7EuJZzbJLudyZDLJl//12sSAq/AUAk2iSxPLL2w0TtpmzUsy5K/AqkUSL
         KRw1tpZdIKljxU2UQ4l/caidQjb+kvYoVvngPiwjOSxq6AkMwlsThELWSOPzVCmIRg3t
         NXQg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785435527; x=1786040327; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BcSk1/y4fhEYP1oDWtEyRtQmE44YyXI71BVE0scYBk4=;
        b=PM3mSYbT8XRRB91qL6ACpJ4VGAaSQ/UafTCfUBt4qGGSZ6POEVLUh0WlELc1+fYTOb
         zTn9whZd0UMZz7QXiMzigCi23n5iSiLBVuaqrIjV2Pg4qn2ww0KpWut6Mwh6IW0cOVlg
         xHew3URCI3ZtEx9hrG9om9cApaNK+9vCIJj+gQoBGg/9M6QlcqAs6ltag6kFLT0Cam44
         0yyPiw8BApO1O39UY4UeB8Fve9I/eiCzMZdFG9607juXEKqeNCbGc7ttYavK8ot8Q+4y
         jm1BT5rXZ0zyOprig8+qQYRkjwkXm3C6TYMrPMRsX+DuGznmtuwjeLtQYIFsW20csO5v
         Gi6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785435527; x=1786040327;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BcSk1/y4fhEYP1oDWtEyRtQmE44YyXI71BVE0scYBk4=;
        b=MBznDwMX38U3lWU87SrDi0TZCH59x2ddLt+zdL9F0+zGHm98ZIuDogMz98umpBWTuK
         Z39GspZZHA1kckkcDP3PQH8RPFJusyI7sfjqwbUy5C0p26c9wfEF+sLL/qIZODT4iT5r
         dwufZpuRe+Y1QAcMOpawxFpwJhMcWU+cNTO3Ovru1aY6M7ILADxCMf4VVN1FPR7mcnQo
         L6d+4W92uPULfiZLBqf3bSe518VUQMqhhbkz69m5BC+OK1KoJzd5PHI8mDDGJjZA39tb
         QIOufe13YinwrcDppgjaP1eQMMSDj0ieatPpe7ZHPBATc+K/0vArr4ZWxQRz8mIP2HjI
         LOZA==
X-Forwarded-Encrypted: i=1; AHgh+Roh9X+44SBh+ImGJtriqOuemJzB3maoQc1SNryZ/E6B8odKUaCMXqMgIavdeyHj23Xx5srAeQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwTZGLly9/K+hpEtxYLeLExPS23ZG66HQO6W+NOPCsLXqXdIjre
	+9XlHasQ1u485AzlhWP8ljifrOHjUlXO8nvj8aTaj8apePKJLziqLxXTYUf6c/oAVWGJJ82Rt3m
	3yO78L0oYr2AexEl05K0Nt4EDM8A1SbDHXUbPa9dU
X-Gm-Gg: AR+sD11vw52pZUEfWYbbd41kZxRwzzZJTPIicsDqTebJjAP5vnbz5lhN4Div8Hvb0em
	cos+RrFyA3KAEK8O+e6Hv58rJiEBLeujiaEjJvJv4ppgmaQntmQUtWj7mEjKqAz7TbjE6u28cCY
	Wsxf0o+blAbkfsA3cAeqW9YPf+UsJbtwllFa0LuNkm1LpitLBjxVPrgA5KhACQeX/VicoYGGlvb
	xjY4oF6T2U1XAHUblTX+HiZYnQqbU/AZ3Z4la4Orcl6UtcKODB4zcrl/iUHQTMInCUYhIO06L0W
	zjxk4jw6m7OmFuAwunEOn+OzwjD+SocP8I8kyVqhWFiR6o9BDl0eXo3X1czC11xpY9LXl3UTb6Z
	irtUDQen5xvq73/LGJUxb66FeHbPU1Bt+vA==
X-Received: by 2002:a17:90a:d007:b0:37c:6130:7a5b with SMTP id
 98e67ed59e1d1-38fa7dcb036mr912482a91.8.1785435525974; Thu, 30 Jul 2026
 11:18:45 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 11:18:45 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 11:18:44 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260728121138.1103610-12-tarunsahu@google.com>
References: <20260728121138.1103610-1-tarunsahu@google.com> <20260728121138.1103610-12-tarunsahu@google.com>
MIME-Version: 1.0
Date: Thu, 30 Jul 2026 11:18:44 -0700
X-Gm-Features: AUfX_mzurojFzFl7kQ4jInKyqzMda986c-EWBvJn_4YyREdNQpyHfl__fqR3AfU
Message-ID: <CAEvNRgEbS06snhyHznPSqxnUrdudVEKUuOpPwnU+AJATWFBRBA@mail.gmail.com>
Subject: Re: [PATCH v4 11/11] KVM: selftests: Add guest_memfd_preservation_test
To: Tarun Sahu <tarunsahu@google.com>, fuad.tabba@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, seanjc@google.com, dmatlack@google.com, 
	Shuah Khan <skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, david@redhat.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, sagis@google.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: linux-kselftest@vger.kernel.org, andre.przywara@arm.com, 
	michael.roth@amd.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	will@kernel.org, vannapurve@google.com, maz@kernel.org, fvdl@google.com, 
	kvm@vger.kernel.org, oliver.upton@linux.dev, kvmarm@lists.linux.dev, 
	alexandru.elisei@arm.com, skhawaja@google.com, aneesh.kumar@kernel.org, 
	linux-doc@vger.kernel.org, David Hildenbrand <david@kernel.org>, yan.y.zhao@intel.com, 
	kexec@lists.infradead.org, suzuki.poulose@arm.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_111847_684159_2AC2A8A5 
X-CRM114-Status: GOOD (  13.03  )
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

Tarun Sahu <tarunsahu@google.com> writes:

> Add guest_memfd_preservation_test to verify that KVM VM state and guest
> memory backed by guest_memfd are preserved across a kexec reboot via Live
> Update Orchestrator (LUO).
>
> This test includes multiple tests
> - (A) Test to preserve non-guest_memfd, non-memfd which must fail (/dev/null)
> - (B) Test to preserve guest_memfd with no INIT_SHARED flag which must fail
> - (C) Test to allocate the guest_memfd memory after preservation because
>   preservation makes the guest_memfd frozen. Which must fail as well.
> - (D) Test to verify guest_memfd with INIT_SHARED flag preservation across
>   kexec: Below is the details of stages in this test.
>

I think we should split this into multiple patches, where each patch
introduces 1 test.

>
> [...snip...]
>
> +++ b/tools/testing/selftests/kvm/guest_memfd_preservation_test.c
> @@ -0,0 +1,357 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026, Google LLC.
> + *
> + * Author: Tarun Sahu <tarunsahu@google.com>
> + *
> + * Test for VM and guest_memfd preservation across kexec (Live Update) via LUO.
> + *
> + * NOTE: This is a MANUAL test and is excluded from automated CI/testing
> + * frameworks because Stage 1 daemonizes into the background to pin resources
> + * and requires a human operator to manually trigger kexec before Stage 2
> + * is executed. Running Stage 1 automatically would leak the background daemon
> + * and cause CI runners to falsely interpret it as a passed test.
> + *

Usually there aren't many printfs in tests, but since this is a MANUAL
test, maybe that's ok?

Would like to know what Sean thinks of this, and printfs in general.

>
> [...snip...]
>

