Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1072CF9D0C9
	for <kexec@archiver.kernel.org>; Tue, 14 Apr 2026 13:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zkOkAYK7gq1LO+D5/7TtSm6e4EzH942k3LK3140UMXM=; b=KOPauc3SXQc1yOnKh65ZEdOtoS
	Gqzbc2caAbjCXp7xLLTxhLdLNIIVBtKGrw7tX3aAADBsDxsr5lQ7vOfms+OvBQgBMKC5L/gfkc8Py
	lQ36Sh2fiR2gszy901eOCFnmmnfbocDSsf+BPsS9MuWiFOqrT6YUaGoVN/JDcNhFYMFRZ+t5/TNB5
	XTK6eGqk375Pk0rbrJ/Fqy5tqW8z38mDVoVH6n8P5MjkQql0zACswyf0xi/PGlsrvIno4tH29d0uT
	9ml8v0MpwIwaobbMCsyjYU+30wEfb7Yi4rJKO6EP3OjL5eL5sRVvkMvrYC1y6xvwZg5u9xfS0+c6E
	gqzUjfsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCdR6-0000000HL9t-2WZn;
	Tue, 14 Apr 2026 13:04:12 +0000
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCdR4-0000000HL93-17nT
	for kexec@lists.infradead.org;
	Tue, 14 Apr 2026 13:04:11 +0000
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-6714fa8b955so3915620a12.0
        for <kexec@lists.infradead.org>; Tue, 14 Apr 2026 06:04:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776171848; cv=none;
        d=google.com; s=arc-20240605;
        b=UyWnkmQ2PmAYrQQNI4hpibgnVMu6xYaM6bm212wbH00UPkWCipARXSJ7PjHp+CraJx
         WkTt44gqSTlKBzmApQdQBvSjc87JYKV6ZzMLfMtWC8ZsoTkMEY3px2Eqb+EhwBx/9WgQ
         tsjoea4bJIMMING4JUlgIHLpguaCSGN5AueUk40V1I9AgrBjeG1ubgmcob5MIg0yQplR
         QBKHkC/zwSYQW8AC76ZotHV1bSNJTcKoDZsy91OY1q/UlM1hyXAaV/nJlJgkb1jJ3bIS
         zDTY77qgLGv0uMrA21zvuSFkYslGzIbhXItadEdIha6cjnCYepnTkOWBpuzhbNf92P4g
         96DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zkOkAYK7gq1LO+D5/7TtSm6e4EzH942k3LK3140UMXM=;
        fh=jUyx4TU1/bqaYHrnCYgd3okmuvoq4wCOMb6ykSfXG+I=;
        b=TTCxJbe0sYxjd6UgvaxNAlRzy5bEtVfVxlhlqPAToK9UB2lIXwfVC/NMc3YE+8+W1Y
         akZ7AWLcNO2A3tSnz6f5EoGghaJNJ67YHAsI7l4kGggpjnmhmRrZ7KCVZlE68mKNXXM6
         1RIpgzUlb1p7rkSwzj8WmHBOT8hoVlYz0XCBgBoRUWrjgUmYhFVIJL5L5ZOjG6ixJpcb
         eFT5MKOOTyHx04fqltw8fABQeXLaDdjoHMR9sITzMql6lEyVuGkqP6H7I5YXnVfZOtil
         M3tej8pjDf2/hpBh2uDklpWSGXcbG/p86nHhsJRgaGtqZ0vX/XWfkt7Q+wG5tIjvYJV7
         fvWQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1776171848; x=1776776648; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkOkAYK7gq1LO+D5/7TtSm6e4EzH942k3LK3140UMXM=;
        b=ePSzHhKntaciERES7JKeyADhluZ3EvS1momSR5Pcru8XB5Wrm52W2/KTKsZTwJ/6PE
         0ez//yavPSOmIC/yOinPbqsRW7GIGWIGqvXE2IuZUgjxw/plzzi5POc8D5kOx1A1pZFC
         JCzUvVd2ex0eGurpRclkWOe/NZKfh++IjjemaxF/S/kXTvdq9VCXPfja/HZF08N1RDpA
         j0hOfVIYOcM+qihremZqfnTRItjtLa9aZIxlS9DFeYoZmc76XwV8s5sHV4EAoDHCFbcV
         caxi3zQ9eoMo3GDgvtTIB8xUu2AlbF5du/+cs4j1eKmAF7saJ9Pd77U1niccb5l/pFdF
         0srw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776171848; x=1776776648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zkOkAYK7gq1LO+D5/7TtSm6e4EzH942k3LK3140UMXM=;
        b=fLOGVjFSFt0NY7Iszq50WvyT0AQIqIqsFXkbMQLzRLDDi+9FJKPJvaKmcZPZwarYvB
         pw4iS82e3SSamxEszLiU9tobiczmhkb0yzFcA17oAqGNmgtokV9nLq/3BK0TvJlpRyW7
         xwypWojRPGqHHXUOlLZvkYzyy2KnBBGExRuRijzbtWNnSQZCCbFxEtt8Y8BP5iB2rRMx
         fPZp4Cx/X335xzvgwxA7RTnNFGYyIKlfqcDCWS8ZGIZefjlOfOnJcGJ+403/SGcx9gE1
         0JHzsyHt8kuKGn1GPynKqB2C+2Y7mtsuy4SnuPYV7IS8q1311NtTYBT5OklruVK6mPYt
         FH4w==
X-Forwarded-Encrypted: i=1; AFNElJ+Jz3fJzxQAGoSzig1EsoNuUMkUfGq6ujQf2mt1fjFu5U8sT/6GtNuQZbE9ooW0qNsMs0Qk2g==@lists.infradead.org
X-Gm-Message-State: AOJu0YyVAlnt8IifFoi21lnWVQcp3cS+OskkRsYXO9rdtuOfeHa4PeRX
	6/+Rp1PA2QRbaANC4y4tZEkIyGjO4+XdSPBwz/whRQOGRv6O8gVJyEa6uCTbVYPnYSj8JuhrK3J
	SYPwqobKq/Tb8y+dPwjs2m2Pyi7ZY4rTjFHnPJZTTRw==
X-Gm-Gg: AeBDieun5QPXJzDQdgES135N3JgOYJ4IxFu0g2qTgwRwEFhNkNmYVsawkQPc73k50RY
	VozB9jdQsjt0OnWYQwUYdqdijEKGwM/fK3k6hpPObxpzoU7D/GIKqKmYe1T0C9yino9c1qal2Z9
	MMxb7VVCNxo+oNKUNoRyzz7ro+Y6PQV8k6A7C1CaUs1K3FC6PBuWu/aiPz/SPlWiruejx+x43JE
	A0XhJ6zG0QcNg3lrECxSlyJhmsrczjiVtzg0Sk8m/FR79gD7Q6aMOoMeUyu5dLoba0jPNCnvMHM
	76+kUP5RIpOGt0E2JnV2kyt16OVisTbFAhGfnw==
X-Received: by 2002:a05:6402:2c1:b0:670:8b38:5717 with SMTP id
 4fb4d7f45d1cf-6708b3857c7mr4839756a12.24.1776171846855; Tue, 14 Apr 2026
 06:04:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260414121752.1912847-1-pratyush@kernel.org> <20260414121752.1912847-2-pratyush@kernel.org>
In-Reply-To: <20260414121752.1912847-2-pratyush@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 14 Apr 2026 09:03:29 -0400
X-Gm-Features: AQROBzB2bM2at0OaKzNEBGSOyKgK53SL0x6pBDEFAv3Or8zLZ3D54mcFt45gF8Y
Message-ID: <CA+CK2bDtA7fQp1mnQ5utnqFH_V5uKcjBiSXS46kwpr=byFxMBw@mail.gmail.com>
Subject: Re: [PATCH 1/3] MAINTAINERS: update KHO and LIVE UPDATE maintainers
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_060410_402390_98BDEFC9 
X-CRM114-Status: GOOD (  17.93  )
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

On Tue, Apr 14, 2026 at 8:18=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>
> I have been helping out with reviewing and developing KHO. I would also
> like to help maintain it. Change my entry from R to M for KHO and live
> update. Alex has been inactive for a while, so to avoid over-crowding
> the KHO entry and to keep the information up-to-date, move his entry
> from M to R.
>
> We also now have a tree for KHO and live update at liveupdate/linux.git
> where we plan to start maintaining those subsystems and start queuing
> the patches. List that in the entries as well.
>
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> ---
>  CREDITS     | 4 ++++
>  MAINTAINERS | 8 +++++---
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/CREDITS b/CREDITS
> index 9091bac3d2da..9173508b4e03 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -1456,6 +1456,10 @@ N: Andy Gospodarek
>  E: andy@greyhouse.net
>  D: Maintenance and contributions to the network interface bonding driver=
.
>
> +N: Alexander Graf
> +E: graf@amazon.com
> +D: Kexec Handover (KHO)
> +
>  N: Wolfgang Grandegger
>  E: wg@grandegger.com
>  D: Controller Area Network (device drivers)
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 915f074c3577..97820188a600 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14109,13 +14109,14 @@ F:    include/uapi/linux/kexec.h
>  F:     kernel/kexec*
>
>  KEXEC HANDOVER (KHO)
> -M:     Alexander Graf <graf@amazon.com>
>  M:     Mike Rapoport <rppt@kernel.org>
>  M:     Pasha Tatashin <pasha.tatashin@soleen.com>
> -R:     Pratyush Yadav <pratyush@kernel.org>
> +M:     Pratyush Yadav <pratyush@kernel.org>
> +R:     Alexander Graf <graf@amazon.com>
>  L:     kexec@lists.infradead.org
>  L:     linux-mm@kvack.org
>  S:     Maintained
> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linu=
x.git
>  F:     Documentation/admin-guide/mm/kho.rst
>  F:     Documentation/core-api/kho/*
>  F:     include/linux/kexec_handover.h
> @@ -14802,9 +14803,10 @@ F:     tools/testing/selftests/livepatch/
>  LIVE UPDATE
>  M:     Pasha Tatashin <pasha.tatashin@soleen.com>
>  M:     Mike Rapoport <rppt@kernel.org>
> -R:     Pratyush Yadav <pratyush@kernel.org>
> +M:     Pratyush Yadav <pratyush@kernel.org>
>  L:     linux-kernel@vger.kernel.org
>  S:     Maintained
> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linu=
x.git
>  F:     Documentation/core-api/liveupdate.rst
>  F:     Documentation/mm/memfd_preservation.rst
>  F:     Documentation/userspace-api/liveupdate.rst
> --
> 2.54.0.rc0.605.g598a273b03-goog

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

