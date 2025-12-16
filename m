Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1514D5E12E
	for <kexec@archiver.kernel.org>; Tue, 16 Dec 2025 10:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v4YTM5ziaIOOYraDYhOZYgWKHK+M5tUDa1EwJkxHyTI=; b=xn+6rQr/aIdoSzIBbMikNr7gtM
	zOPwifuAWfzx4PuzF55rcH4QFg+s3CHnQFkwO+tqHGAgYKbQYxjAmT6cDjObkSC7L5gvfLycluu1w
	9iTPk2oZZB/NsgTseYEypZF1r0QI7OUg8ThjLV06YZZDg5JZRRDI9jGVeYDX4I37M9tC7qkXCsiX5
	0dIqo81DVP4U2mBfCZCf0+2jr4yhZd65lW/qLb4DJO/9BRYeadXc5c2acgc3LKFeeB/SUIfE45kij
	DT2+/74q0epodBUR4fy6fU/dUKWwbBJJqXljaDq7NKTzMUvFC7oG7bdXQuLMlqWpyBmsFsvKl6Qe5
	CDntP0Ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVSjs-000000054f3-1Syq;
	Tue, 16 Dec 2025 10:57:08 +0000
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVSjp-000000054e3-3g1w
	for kexec@lists.infradead.org;
	Tue, 16 Dec 2025 10:57:06 +0000
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-6492e25cd7eso2696051a12.0
        for <kexec@lists.infradead.org>; Tue, 16 Dec 2025 02:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1765882624; x=1766487424; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4YTM5ziaIOOYraDYhOZYgWKHK+M5tUDa1EwJkxHyTI=;
        b=QMTTjpyTzcV71fCDpwut2BG7SmYLXYDjQz6PJ6gR+eQRhiJF0vbWICKkYBSujQaCqS
         NywL+ZwaciqXocUc+6F/c/TyosPjvLb61RISVeEqoGjc9Te24DtO4RjghWt0NUjj1wSB
         ytBik9vyNJS2K8Gp58hGHmpRYGBQikZth7UO0zuLHKiocEMBxMX66vyzWNXv/E7+xtZJ
         VYJIVWqL0mw8Is5u0c0MVMGF4TORpUeVRMKWYZx478ZxpviQEah0la+FssIZRx048RrO
         +9RCXBwsAu42vXanugPrzzy//yb8RUzpW1tYYVKnHuoJ2Mc2N3gZB4184ZlC2fpWMgwy
         3EKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765882624; x=1766487424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v4YTM5ziaIOOYraDYhOZYgWKHK+M5tUDa1EwJkxHyTI=;
        b=BKuEO8WXGl4kjVdn4twOen0I4pQ8ioFUw+x8ckNMAZMXbzsIWC8P4XEcpV9R3f+8+z
         4giFshjbnfShIr46H6FIt0NcSDaBYZpDBuoKa6HA8dRfycn8hCQy+jyaznBOvCPj/Axf
         asZI8LIrAXD5PSwYFaB9o39/FaywytRf9HkWkMqz/nURW1jj/sEFsj/rZVakpN8U5Hwm
         9byE+2D3hTxOPye5b3HCMcO+fn4Sw1NYO0i7aYYu49z5zbYOK9xfz7VsDfPtkQN3WrGa
         l5dLqVbEjkT3W0k/8FVHBgn4iZCA2/VhXnrcvTqWThmG00eQN0yJccwlAvEm429JM18i
         jOyw==
X-Forwarded-Encrypted: i=1; AJvYcCUX7VIAh6jJJKrYWwl/4n3kxqvcnZ3xhRlhdpYZzw4dnd8BAG1gwSfWxvVTbR1aPj6bmdQCiA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxHvo093/E/nhNDsHpaKLvdPpiIh1FwaZ0wUi83clwDvwmNG/+t
	ZXQe8nHuykQXP5CSZ2ux6a8FxYt0RpZzqDZmhYgr+/VNiKu119DgKLi90pqreJ/j3PUjxPcsRJA
	5QA6DPDnzEQ9e18Vt1Yl3bDwLmQ93ATy3vrVXTWjcOg==
X-Gm-Gg: AY/fxX4AXX+6wjCet2wgMXPRl5OU7OJ4VF3KPMSRfun8xo4HbD0+oVfAunr9J0Tz3WL
	piF9TP/L9pPR5jIqLggqHEhJpDe9ZSjl0QQVilt/dZbITkX1yurwho0W7YduTuiorQEmZKC02Ef
	OX1Ecgdi6H0wEPHbkWq2W7dYkAKEN54ymGeWHumEw5xDw5i91oGRFjX3PLAIo/YrI57j84fB+eM
	hVoohkAQlKiwdPbhohhx4wq3C5c9tBRU92ytperwJCfPUicp4gN9XoS4hS0AzEUZN+bV9FhYTMc
	NwjcBmGc4oQWxcIclMLDCbkE
X-Google-Smtp-Source: AGHT+IFBhO7lE4EKXlZe2u4YeG+WeUJE4DvyxMzToTPEQ7xdmib3BrCV7t/nup4j/dCwNV2xxCID7pup5fDv54S7Nys=
X-Received: by 2002:a05:6402:893:b0:649:81d7:581c with SMTP id
 4fb4d7f45d1cf-6498744875bmr12537223a12.1.1765882623873; Tue, 16 Dec 2025
 02:57:03 -0800 (PST)
MIME-Version: 1.0
References: <20251215091150.4094334-1-longwei27@huawei.com> <20251216064520.1529635-1-longwei27@huawei.com>
In-Reply-To: <20251216064520.1529635-1-longwei27@huawei.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 16 Dec 2025 05:56:27 -0500
X-Gm-Features: AQt7F2ruBzw9tVqvm1Bp3rdZ0Yk8-pcfP9mBghdN5ziQLr2J0U29LGeM3KBzb4A
Message-ID: <CA+CK2bCyqOKo1oA32TPnL3u+w8VT6MF+pb+Wps57C_P6v2C9ZQ@mail.gmail.com>
Subject: Re: [PATCH v2] kho: Remove duplicate header file references
To: l00580197 <longwei27@huawei.com>
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, hewenliang4@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251216_025705_920460_893CD725 
X-CRM114-Status: GOOD (  13.93  )
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

On Tue, Dec 16, 2025 at 1:45=E2=80=AFAM l00580197 <longwei27@huawei.com> wr=
ote:
>
> From: Long Wei <longwei27@huawei.com>
>
> Changes in v2:
> - Fixed the malformed commit message header (removed duplicate 'From:' li=
ne).
> - Added module prefix 'kho:' to the subject.

Please move changelog into stat section, so it does not appear part of
the commit log.

>
> kexec_handover_internal.h is included twice in kexec_handover.c.
> Remove the redundant first inclusion to eliminate the duplication.
>
> Signed-off-by: Long Wei <longwei27@huawei.com>

With the above:
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

> ---
>  kernel/liveupdate/kexec_handover.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec=
_handover.c
> index 9dc51fab604f..1962b6052840 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -24,7 +24,6 @@
>
>  #include <asm/early_ioremap.h>
>
> -#include "kexec_handover_internal.h"
>  /*
>   * KHO is tightly coupled with mm init and needs access to some of mm
>   * internal APIs.
> --
> 2.43.0

