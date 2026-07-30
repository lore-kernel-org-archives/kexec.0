Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9AFC5516E
	for <kexec@archiver.kernel.org>; Thu, 30 Jul 2026 17:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:MIME-Version:References:In-Reply-To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cF6Glwk5JHPcXFLYP8vDOSrow7Ekc+sBztL/w45l/K8=; b=1wTu0s2EnGNXbPycsmIT+xYEpt
	abEks5ZcAwj9GVX4jgYSctc9dSTXETMRufcwX25qkIlI+xCZ51InEK+2T57G7Cq2Qz0Lg3A6RLKwB
	SfUwkxzZGi8Dyho/y2jkKKjJIn1QiM3kPSo1ZEHlgr5eQoHxYqO2kN1pn97b7SaQctsX/AAPXv2rc
	u2LsXy3Ikhum2H6YssPJf/nJCKDLBhR+G58UhxodnyblxIDkv5ulQhWKLIOUNU7+6ZRqflVxulQDj
	Sie9WxMFx1H+v/m5TqVFH/qJwjBNdRD1y8uLwR/A7UEjmhuVKp0yM6dd3qKOiwW0jke7P/huEjd/+
	/7Q0yB3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpUgm-0000000B69C-2TGM;
	Thu, 30 Jul 2026 17:37:00 +0000
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpUgk-0000000B68R-0mMj
	for kexec@lists.infradead.org;
	Thu, 30 Jul 2026 17:36:59 +0000
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso38823a12.0
        for <kexec@lists.infradead.org>; Thu, 30 Jul 2026 10:36:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785433016; cv=none;
        d=google.com; s=arc-20260327;
        b=aGKx5Ic0DhIodib2N0+tL7PQ9DRhYqeK000+2ODuSip45iZCTNPnjup1er7v+iOKsn
         NnC2ygtiqa2J8cuDzDOLdMKk1mp+Ft6S60KJ9hEi+fP6F3qKJ6V3ENC8bDdTmMwYZiPA
         tc4gJnuio0kiua3IyY+iRvD8vcwQ2lvWiG8Z5t23vovE3Q6jkeGCQyqpIcOnr+yNTPyk
         AfujIjfuyiOVvcLQxl/G4riHrv0K/d3otccEkyKZ9YsRrcDaJI1woAIjvBa6OTu8Ve/A
         lJgqYEjRV9YtwoTaQCC5SnE4LvBTw5pKQP2DiQaSWBqEurnVu/S7L0iCFaCFoE3kZyJK
         Ei6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=cF6Glwk5JHPcXFLYP8vDOSrow7Ekc+sBztL/w45l/K8=;
        fh=3vm2oU1iJx2qNFVsEuZVA0S6CzEI/fpldBT5H+8KljM=;
        b=BpSet+w3A9z7JC0xRqdLydC01jF6AxTZz5f2Vsv2J32/lxQejs6nsaQdTdrhZQVyan
         /PdStV85g/A4uZlJezmQnM46wfznRlpLDN2XoKlIiRbcpXu0qdPrqcckxbRQfvO4cp9t
         x2Uksf3LnJkoHfOGTLF7w6P4fQCwxKZggU/6Xh6UbsBPAJcf7bXayd4hemvDnAL7mmFu
         2J6pqZD0qyPIyesDlIC2OPfhjWlO8L8xMu9ZF4vRq0z7w59DEA5qdhySOx4D8KzP6pcC
         aDLJ8Z0OeE4oaaxKFMyJqulzqwGYw4v8wUOp8XRlY9ZFgsIS3z0i6wnUFsiS2S+WzBKK
         LV6g==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785433016; x=1786037816; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cF6Glwk5JHPcXFLYP8vDOSrow7Ekc+sBztL/w45l/K8=;
        b=BiTfY891t79dSc1PvJboRpD2hPo6WgopcAeZRZ4/hVAEslXJ04P5kRTxecZag/FfZi
         j5u642IvqvVXxn+z2vs2mqIDKnWa9buTVnBJLz82UgAmEjh9u0+PTlXrAJ8Y9pBK+KPz
         lOUeaRnRoYfH2MJlXglCks2pI1n8kxKZUDWwk8D6kNm1EBZON7Ung6Wv4MJOvLnP8k5s
         IdR7rod+YmXlK3N3a6EVwV6xXtbodgVoIw8lSPdW6taDxyPWwp1CMTlRfnwbsnzjqqOZ
         I7aBApnmWDSyQYRBpzma6SuCJnrFhSZ0fnfuD63C+DNnv3YxjAya2cAC60mTUjkROVel
         srrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785433016; x=1786037816;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cF6Glwk5JHPcXFLYP8vDOSrow7Ekc+sBztL/w45l/K8=;
        b=bdmvdH4e1aqLmWQJ7KgrEdDNBelaQN8t8qBu9oXoqDlFZElqsO5mJljiDB6/f34aBr
         BW3LT0tamkTScAggGkHubzJYUvEIr8M7IxbtCFngNJTl0LvS/Z0nNcavnWSKdM1spKID
         EHbpVrokP6JcbUS+FZ4VEfPrN6QkajG/0VumWZp/ZnSsabEs1g8yoC9GeSJMFVhhPkkX
         T+q2ni+p8/Hnu7pnPWi5zVPm8IgkRu/NgxdqHazIdLL2zD+FKuwkwyvDrtkDpBqhTkkO
         lWoTw+/j7SqDCLmJhRAaR3/TKjtrYn7uDOUgCnf6FRK9D/yltfCzPkTH58mHsREINubt
         ejjA==
X-Forwarded-Encrypted: i=1; AHgh+RqsVXuLgjuzm8Y7VdMdQEJMy9y/IBK+jux7kvLCMJ5Uw+ZrIYShkTB1VL9f9NLyeP4vad8JkQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzqFdD/oHuU0pFOMZZyZTupaNhokR6OqS16Spfwb6/YzjL8INlg
	Cg2fTYKBn2TsStoQFYJ8C4FUsQgoaQ5kSxhBSNGNFO5qHjMqcKxuymlHfCbpV34ZxI6Jq1UGQjd
	ZUa+pPCe7x3PIwddDoiqV6dzd3Lq08p3D+3aHl5a2
X-Gm-Gg: AR+sD10qXh/aBCtXYrar42856fvSql7ALLm1zzp5xndTeXne414tFbICp6b42n2pxhV
	2YshfczNHfxD0p5DcVf0ZAWm320sck9T4m4YVcZ9AmBkBI2YIZFY2Qxs/0yFfgi8U8sU/aygIuJ
	Uc0iSm/2dj1iFGS+VtsiGjZ/QBUs+acbCNVce1kq0g5JvWF12tDr/KjJU9ozpBdPfA7rHywQfac
	Ev/BC+846VzwkTK1wexhVqpXxDa4Q60ie+9zMF/2x5DyLzPzUVnzbPLLw9YQCbYpeIOdDmJEABS
	nl+SCVzyId2bVj9zulVwN4gCCYALkKnYMk7E5+KvdYA9L5coi/1r9sv7mwPD+U60qJP0rB/G9sJ
	NnXfrr6K4vo7bDC+2YuYEFcIP1Odz4UGSaw==
X-Received: by 2002:a05:6a20:d805:b0:3c3:8651:b302 with SMTP id
 adf61e73a8af0-3c90072a2acmr3423693637.28.1785433015659; Thu, 30 Jul 2026
 10:36:55 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 10:36:54 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 10:36:54 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260728121138.1103610-3-tarunsahu@google.com>
References: <20260728121138.1103610-1-tarunsahu@google.com> <20260728121138.1103610-3-tarunsahu@google.com>
MIME-Version: 1.0
Date: Thu, 30 Jul 2026 10:36:54 -0700
X-Gm-Features: AUfX_mwFoYwitx3VhlqJDH1-k0l0ItJ6i-x625ej1dYBsVgzkh7R-MZiFMgMH5w
Message-ID: <CAEvNRgGazT2D-G7sEem4RD5nUEj7dmcg8vx2=3bpatS_o5uE+g@mail.gmail.com>
Subject: Re: [PATCH v4 02/11] KVM: Introduce kvm_create_vm_file() helper
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
X-CRM114-CacheID: sfid-20260730_103658_279253_5BFEFA5B 
X-CRM114-Status: UNSURE (   4.86  )
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

Tarun Sahu <tarunsahu@google.com> writes:

> - Move ITOA_MAX_LEN to kvm_mm.h for reuse by upcoming kvm_luo code.
> - Introduce kvm_create_vm_file() to wrap kvm_create_vm() and
>   anon_inode_getfile(), providing a unified VM file creation API.
>

I think these should be 2 separate patches.

>
> [...snip...]
>

