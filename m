Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 233DFCA1009
	for <kexec@archiver.kernel.org>; Wed,  3 Sep 2025 17:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+3/FvEb2tmp04THrfe7Q6R4Z9tV9DSLFC8M+VKKCGW8=; b=OXaKXTt7C0MRu+eZoe1JcCFoox
	bDdZuKkuBQaLkedM9em5UYrhyEVZCagv8ynzhp/aSZEvfJJk0ivTEW5TGIMmQcPAdkUq4TT3D+Qej
	X+IBVvFm3Sy6Fxy37JoK4E0qsIkUT2Onrb9QFQcWTa+WeSAb7YtZyvXS9FuJxJnJ8k8UieOSZyhKr
	5yLn9E0Z027yOPU0L5evrrKlD/KyIRSJldoh6PkVtgJMVcgHfaObAuH9l87K8dxWF7PWqV0iD8mbl
	8bxfvQWr8VnUIUUI8UjUHTThCyjNzL/xwpPFr8BuESZBnqTDzCujNrJjl/tk0q+r5DQYU2kqssOAB
	3aei18eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utqzr-000000078hg-2xlI;
	Wed, 03 Sep 2025 17:10:11 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utnRT-00000006ZkW-1bUO
	for kexec@lists.infradead.org;
	Wed, 03 Sep 2025 13:22:28 +0000
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-45b88bff3ebso23317925e9.3
        for <kexec@lists.infradead.org>; Wed, 03 Sep 2025 06:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756905746; x=1757510546; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3/FvEb2tmp04THrfe7Q6R4Z9tV9DSLFC8M+VKKCGW8=;
        b=l6jNjfxeazZiX5mvVX64urhKHqGX63PqdHi4/guI6XPNov+N6SBM2Ho479TvzCWzQO
         TDLv/ELREEbamt+1bxrP3YLfa34V+DJXLBbPoWuxgPkqtiIineakS2pTVRrzc0rTesbl
         j40P04fQt51Cp0tm/2H3njl75IFheJZIoL2kkty4NH2qi623zugm/Q+AaZsznGyNQ5XX
         UIlusaeMSUBbEd1BSVdoKaZ3TfMeVRFIsBcZqh7R8sFMZxuuqa7wQddNnF8nu5ACIoi+
         +qOogKIASd5OO9l6UivIX9sKUxqHDBDzVjPVwJaa1/TLLJC5ICdrqbH9Ndb3FXHCCtk2
         5Yjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756905746; x=1757510546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+3/FvEb2tmp04THrfe7Q6R4Z9tV9DSLFC8M+VKKCGW8=;
        b=wWrQtCuqTe13em8qz3NRXh+nEtEYfHvNLBDFnYUUOJv8ChKBskMLwicIdv9xKaqd9c
         74Su7BmqzpqomnsWU0PTyhoJxVs92PaI+Ff+dW0M2LgySAW9u6Y5PWz7phG6cc9tr0Al
         kB2C7wgHS07dRse2gWI/vDvgcjeWTijeLE6Z0iy26ikGTsu6B/LhE1Fiitd5SWR24pjT
         P8/6KsL7xmI2BxW89YTvvlalNkgCKEQNU3xK+wHwXz7FFBW/qvWUFWsnS0yw5P8zaxHY
         gNx3RT+W0YV5GzMpeH+Nw0WIv4iX2QkqrKagToubzb5W4RCNDJeaqU/Os8XmItzFuU8n
         7whA==
X-Forwarded-Encrypted: i=1; AJvYcCUap819mrtB54RRTAPo1lH2QL6YRwS7W2onmxuNWPY/Ic65vi+PGjG/X1y8IGxpEy6KtekfoQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyjT8KyJoR5d8YlKKo/JIrrQNrRbdudZmzO/z1+M4kKnvBzcisE
	u2IJb4LCH4z651FDQcR6COnvuVmf08+Z0or+OqeoH3W07L4HbPcMOIeAAeC9VO8c5g79KP/7m+p
	qY9O2TRPePVaI36KNH5tcLJGXlV0bIZI=
X-Gm-Gg: ASbGncs3LN3/FDMvlj0vx1DHaKeVKmb6CDTiFWcLfDf+LR693rd9F7nJAl//qBn8t1R
	TGCMrpQ75k2zHD3PsTfSku0Vyup8N+yBAbeIu11m7gAALM5ev3RYkawm2hM6uxq0IyWlskwv8ot
	oCBDu70Gj9xoB4FIuiDgNuDHWIlgu49f3zxCUzzg4WK7i+9LZmQK3g5n95RKzGZ5tf3bGg+5r5B
	c5rv5+G
X-Google-Smtp-Source: AGHT+IHTlltZP/PiYSefk4BiHHXMLghkkMyukGhjP2TxeCsHmSWWTRuInnnO1putZr6sen4D8zESFOr8o1LvNPk4oE8=
X-Received: by 2002:a05:600c:c8f:b0:45b:7ce0:fb98 with SMTP id
 5b1f17b1804b1-45b85528677mr134028325e9.5.1756905745452; Wed, 03 Sep 2025
 06:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250820053459.164825-1-bhe@redhat.com>
In-Reply-To: <20250820053459.164825-1-bhe@redhat.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 3 Sep 2025 15:22:14 +0200
X-Gm-Features: Ac12FXx6JqZw2o7u1Ppz_iF81kfxsSp5T4xMMmvHYDtA-FZpsjtY5aXsfqZMrYM
Message-ID: <CA+fCnZdfv+D7sfRtWgbbFAmWExggzC2by8sDaK7hXfTS7viY8w@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] mm/kasan: make kasan=on|off work for all three modes
To: Baoquan He <bhe@redhat.com>, glider@google.com, dvyukov@google.com, elver@google.com
Cc: linux-mm@kvack.org, ryabinin.a.a@gmail.com, vincenzo.frascino@arm.com, 
	akpm@linux-foundation.org, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, sj@kernel.org, 
	lorenzo.stoakes@oracle.com, snovitoll@gmail.com, christophe.leroy@csgroup.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250903_062227_421266_62B5BB53 
X-CRM114-Status: GOOD (  18.95  )
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

On Wed, Aug 20, 2025 at 7:35=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
>
> Currently only hw_tags mode of kasan can be enabled or disabled with
> kernel parameter kasan=3Don|off for built kernel. For kasan generic and
> sw_tags mode, there's no way to disable them once kernel is built.
> This is not convenient sometime, e.g in system kdump is configured.
> When the 1st kernel has KASAN enabled and crash triggered to switch to
> kdump kernel, the generic or sw_tags mode will cost much extra memory
> for kasan shadow while in fact it's meaningless to have kasan in kdump
> kernel.
>
> So this patchset moves the kasan=3Don|off out of hw_tags scope and into
> common code to make it visible in generic and sw_tags mode too. Then we
> can add kasan=3Doff in kdump kernel to reduce the unneeded meomry cost fo=
r
> kasan.

Continuing the discussion on the previous version: so the unwanted
extra memory usage is caused by the shadow memory for vmalloc
allocations (as they get freed lazily)? This needs to be explained in
the commit message.

If so, would it help if we make the kasan.vmalloc command-line
parameter work with the non-HW_TAGS modes (and make it do the same
thing as disabling CONFIG_KASAN_VMALLOC)?

What I don't like about introducing kasan=3Doff for non-HW_TAGS modes is
that this parameter does not actually disable KASAN. It just
suppresses KASAN code for mapping proper shadow memory. But the
compiler-added instrumentation is still executing (and I suspect this
might break the inline instrumentation mode).

Perhaps, we could instead add a new kasan.shadow=3Don/off parameter to
make it more explicit that KASAN is not off, it's just that it stops
mapping shadow memory.

Dmitry, Alexander, Marco, do you have any opinion on kasan=3Doff for
non-HW_TAGS modes?

On a side note, this series will need to be rebased onto Sabyrzhan's
patches [1] - those are close to being ready. But perhaps let's wait
for v7 first.

[1] https://lore.kernel.org/all/20250810125746.1105476-1-snovitoll@gmail.co=
m/

