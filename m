Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE068CDB466
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 08:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hYK5Qpvd9EY88WoCrO0RzLvyGBW/Zs8Pl1ZmnAQD11Q=; b=jsvJkV6j3oFZKCwy45qbTFYcv3
	zW8Ry0rZBESmBMZddNwG3DLF2ZdeCktHxUxouOnXeZUIm0Mwq9chk/OTksNckLe5zGnYw5cEyKq1G
	onpij9jenohtZDK+eCl08Dm/Eup45PNrfXvnQLaIvdq0S/aZu14ypgFnnk9lvaSPAlsRWhsTd4QS6
	3RHx406tYw3iDDyPT32mSgMkl8TJhe8NoDZVyJQpnq3bMRhuEiGFSLQupcr0X6kZfucPQhVNXLxap
	QaJYgsDTETSBukd+/jSx8gYnRS/NuQbpIst7PiupJjLiIKF6Ov9O1FPAvc689TO+p+qxwcxAHS4Fq
	qdpSH6vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbaMq-00000004h6B-3MRU;
	Mon, 22 Jun 2026 08:50:56 +0000
Received: from mail-ej1-x64a.google.com ([2a00:1450:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbaMo-00000004h5H-0v6D
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 08:50:55 +0000
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-bf4ba05fd18so452934166b.1
        for <kexec@lists.infradead.org>; Mon, 22 Jun 2026 01:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782118251; x=1782723051; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hYK5Qpvd9EY88WoCrO0RzLvyGBW/Zs8Pl1ZmnAQD11Q=;
        b=RQX2ty5tVAmQx6Oh+OlY+DuaWd+D/lTHCVTHAlOr64xw25NwXdNhYRv4Qdl1u5Aapr
         1MnJcUf4WtZMUIt01HkVDi4OqDRcfO/SVzQC3NWBSA/lN5O8H2v8rngNIc0Fl4x+Sacj
         c6Q4GSoiDAKdHZzGMvGcUL8U8PY8bSXJ4TXt1t0czO2zhZ7vyGvWzfDI8fT94BbwtozZ
         rX7yJ4Ga8VlqjIi9aKKZjEuJnMu1+VmUSsgmbCzX2F+05IupZ1MW/WYV6KF6E7sO9pmK
         XQ395+Ttn5tw27uqPO32cH/zhE6T7AuAIPrctsBQZPXT4foJ3WZCTh5zqYjhoXExvgxh
         snYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782118251; x=1782723051;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hYK5Qpvd9EY88WoCrO0RzLvyGBW/Zs8Pl1ZmnAQD11Q=;
        b=ASpuX1voDcyu4bM/FQ21eqzdV48aTOU0IGTpO1qQMF2AJnjh09ebhrb5JyFxVrD1aJ
         yxe+V4DpimSf6g68phMZ6TM8eRCeAtnY9xfphjC1Nmytz4CrjzbInC9OakAZW8Dx2xR+
         BikhwkwNUfj8xSCFSGmCDCxKASpeUQw5WlTiI+1Jopxkvm4CwD2cO3s1F46LueAwwHl6
         HJHZhRi3QNSBVaxtyvi9X59CK2GJZzmRTD4W2RwTSAEpbLWGHnU+7LBH7uGEpR6/gKQ8
         KgboIzmwHFLIiIXtdmzJMuZzXmaz31TUl262FV65LKSxkoTKywwAxND2YY8AHOufv/Xn
         3VCg==
X-Forwarded-Encrypted: i=1; AFNElJ906GGFtQP81Fl7aquezISQRbNpXDOQh7lFkmPcdva2Cv5ugymcDkh0dAgbcbvVHt1kplFnbQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz4qgqyG4IhOvjFtrTBUDZY4fXapRuuwy0hHb8IFP+4PVnUjeow
	GWFRbQYl0zVkfOpK0aB9BVRui82qfN3OIQyhFlfO3BL5djOxb4fa7Rrt/39sR2N6O9hNgVbkwNf
	e2mSHbTPqy+M5Voh7Bg==
X-Received: from edtg14.prod.google.com ([2002:aa7:c84e:0:b0:695:b06e:adc4])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3d4e:b0:c08:df94:69d8 with SMTP id a640c23a62f3a-c0b601ea81fmr594723366b.1.1782118250865;
 Mon, 22 Jun 2026 01:50:50 -0700 (PDT)
Date: Mon, 22 Jun 2026 08:50:49 +0000
In-Reply-To: <2vxzmrwqoc17.fsf@kernel.org>
Mime-Version: 1.0
References: <cover.1781615759.git.tarunsahu@google.com> <9huzv7beloza.fsf@tarunix.c.googlers.com>
 <2vxzmrwqoc17.fsf@kernel.org>
Message-ID: <9huzcxxj3qmu.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v2 0/2] luo: migrate serialized_data to type-safe KHO pointers
From: tarunsahu@google.com
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_015054_262788_725607C0 
X-CRM114-Status: GOOD (  14.33  )
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

Pratyush Yadav <pratyush@kernel.org> writes:

> On Fri, Jun 19 2026, tarunsahu@google.com wrote:
>
>> +Mike, +Pasha
>>
>> This is currently rebased on top of mailine, also can be applied to
>> liveupdate/fixes with no conflict. I would like to know which release
>> cycle we are targeting for this, so That I can rebase it accordingly?
>>
>> As for liveupdate/next, it needs some conlfict resolution.
>
> Base it on liveupdate/next after the merge window. Since nothing is
> actively broken (as far as I can tell), I don't think we should take it
> via fixes. We should do it via the 7.3 merge window.

This is gonna be used in guest_memfd preservation as well. Next version
(V3) Should be based on top of it. And if we delay this (as it is gonna
be with liveupdate/next) it will delay the review cycle of guest_memfd
as well.

~Tarun
>
>>
>> Tarun Sahu <tarunsahu@google.com> writes:
>>
>>> Covvert raw serialized_data to KHO serializeable pointer (KHOSER_PTR).
>>> This series also takes care of resolving the bug with memfd of using
>>> phys_to_virt before checking the args->serialized_data value.
> [...]
>
> -- 
> Regards,
> Pratyush Yadav

