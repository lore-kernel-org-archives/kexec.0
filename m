Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35E0CCD187
	for <kexec@archiver.kernel.org>; Tue, 14 Oct 2025 07:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N6sm8UVcZLRMA4oI+f1r4FSpf8cY6fiaDo/3CXat7ck=; b=xyNxnO1qElBZYTl8SWHcT913uS
	06DqdKapfEtOtehFWPUu9kszGGLgwsWzim650hD52IhNgUTyBCY1pFknzt+I+sDm9RLD1RQky2R1y
	7SyPecir6iXeXQ1za7c43McwjjDxs3qJa+OBEpjcO2TTVPAkVBOn6Fs1I44Ek+WuJ5yMalBJG1Tzt
	vJNF9LQLozp8N7ktjVkUbs9jw2I+gOsDW2MUPavW1/959ujk0QiaZ+9fvGBn2n9cQe/pvGvLxPjTf
	TBimLUVirmgP+VlHke/Xgvyd4TdiN9NlI6q7f5g7HjYwOYAR5GnEo/0aUhdCudcO5RBA3P5qnFcYP
	5EsDQ/Nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8ZbG-0000000FTkp-0p0n;
	Tue, 14 Oct 2025 07:37:38 +0000
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8ZbD-0000000FTjW-2Jm9
	for kexec@lists.infradead.org;
	Tue, 14 Oct 2025 07:37:37 +0000
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-579363a4602so5926066e87.0
        for <kexec@lists.infradead.org>; Tue, 14 Oct 2025 00:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760427450; x=1761032250; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6sm8UVcZLRMA4oI+f1r4FSpf8cY6fiaDo/3CXat7ck=;
        b=HeTRZCRQcdfGEwblNs6Zox1OhMw32wYbqd9TZ6ahU2empwWNhpxtkyaEJyWx+mZ8/W
         5p0phflMKTGAZp22mYba0d15uWwjFc4QYYr/y/G/M0D1yQuKcbfTX7F3gw20X3CGTWRF
         qHbdaK9uVCYDM/9B3+Yli0g6S3lWkHc6npEA0oGpl+E/PL8Zs0dd69n32RETYdAcMgs7
         Zo+bz63oleTm/P6vdjgDleFuj+Dd22OUVEAgWz4JLwu1adksCZXrU9FGTJJZ1JeseWwf
         0MRsAsQAfDxUYsbwd6okpsDzGDF8ADvFJUp3zLE6xCNG0Y2As+ItsrHXocVJi6nx1sUw
         Hs6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760427450; x=1761032250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6sm8UVcZLRMA4oI+f1r4FSpf8cY6fiaDo/3CXat7ck=;
        b=WZAWuPERmKTPB2U+9FP6Zrp+haLSMfudUg6H6Xl1yU/KEgLZi/i2P1ldxovG6VVmLz
         6Ogc7iSeKBQ8MKDbuo2+ZY8qUcLwqkGBGqh/R6e2Go9RGwvdCViRaGJHdaZv36wnzYp8
         8T0kqRhGUrCABsMWcaM/7RwdEF6CPjt6KiflSv9VR8to8wxBVuRjKnfFKMNYZ26uoCBy
         gvWFW4xoWinQk/XVcVwFG0vM1WUBYT7oVlG5Lz/sC8DQGp50cH3EQHn/BWFGec4KgUhd
         ng10amW4WjljcGf6NOKNBl9Q88KMcthYbOM6qxon3bLEhGbq9ENhWzhnabA6a4R1bv++
         P7FA==
X-Forwarded-Encrypted: i=1; AJvYcCUo1GANGT7NN5UcQvhRZX9TCiKcegvhTv4l6hoQFcX6QeAaGhqHLhoUifHPUFO5OPEIxj6JDw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzvMS+NmAfFDY87CjDmJPuD/NloqG9dLRq6qxsaxdvv88T5som/
	12yaY+qHEslQXGJOmXlA5QMMEadjR4aRUl7leImv9Qxpm01iBz2kIvymJo4MQAbuS1X5ldK4n3W
	KlY+lfSNjCSea1CuyHbu3z8sN6tXyqBBL7nuDI5xQhA==
X-Gm-Gg: ASbGncte5hwnwvama55wHwy6jbntvsxKM79KxdYudHx6mk2WJAKQ3SpL3xuJvg6RqIY
	hW/vvlAKOhVZU2c/sCTtr5sN7rF6Av4R2Yh7xYfG+WiFmUARUEqiOm5MUh4Q/CK/YWrpQHuz+yu
	IEWqVCE49fsz/O7Hmq6wKbxyOKF4WGxwqYc9Zxiq2m1fBMdH8PNSCeK8QmW/Zs8AhFlInYuhk8E
	A89CnrjwU0eLurOZ5aavdB5v10QjULP3sCJGVOzfQKb7A==
X-Google-Smtp-Source: AGHT+IHq34YNSItovnVows3bsMiARXLvNd6BOzu5f7l3lU09pBJe/LSEkG0WHJOjzrh9jsv+lnLXQC4kAkrLgb7asKo=
X-Received: by 2002:ac2:4e15:0:b0:591:c379:69d0 with SMTP id
 2adb3069b0e04-591c3796b4fmr196177e87.5.1760427450348; Tue, 14 Oct 2025
 00:37:30 -0700 (PDT)
MIME-Version: 1.0
References: <aEqnxxfLZMllMC8I@dwarf.suse.cz> <vojlxf5pelxlr6omsfsccd4e4cdzn5qyxpgiqajorkgmgd7ruh@e5wwhkmvntpb>
 <26ae6b04-3beb-47e9-9639-b081003dc9bb@redhat.com> <f7x2flir2c5zpkusgiyk7qnrdqo4dek3iksyldw6w22r55s4vy@4b47lrcv3fag>
 <2e35b6dd-56dd-47e6-8dac-54f446f763f0@redhat.com> <aOSO/e68pZ7FGKm1@MiWiFi-R3L-srv>
 <ctrpw2ppozwtsj7544jx45kpexmaackpzzyeyhkqsjrf7cz2tc@7fmuzvy7uwec>
 <CACSyD1N0fb1H3_ssEyaAMh=2shQy-64gG_t3MqkedwfOLEExEA@mail.gmail.com> <e28a62ae-5482-4bda-bb00-fd8a5083fb31@redhat.com>
In-Reply-To: <e28a62ae-5482-4bda-bb00-fd8a5083fb31@redhat.com>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Tue, 14 Oct 2025 15:36:54 +0800
X-Gm-Features: AS18NWBwgtHhcLP0kbUd5HKwhmUQyrzTwXsVnpcaLzBMmrL5fLJbX1wcOLzAGBE
Message-ID: <CACSyD1M1AEbww_07KPd_AAv9RV--XsUOChGE5O+HM5CV+J5=WQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 0/5] kdump: crashkernel reservation from CMA
To: David Hildenbrand <david@redhat.com>
Cc: jbohac@suse.cz, Baoquan He <bhe@redhat.com>, kas@kernel.org, riel@surriel.com, 
	vbabka@suse.cz, nphamcs@gmail.com, Vivek Goyal <vgoyal@redhat.com>, 
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, akpm@linux-foundation.org, 
	Philipp Rudo <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>, Pingfan Liu <piliu@redhat.com>, 
	Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org, 
	Michal Hocko <mhocko@suse.cz>, Muchun Song <muchun.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251014_003735_617971_102D4813 
X-CRM114-Status: GOOD (  29.80  )
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

On Mon, Oct 13, 2025 at 4:01=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 13.10.25 06:03, Zhongkun He wrote:
> > Hi folks,
> >
> > We=E2=80=99re encountering the same issue that this patch series aims t=
o address,
> > and we also planned to leverage CMA to solve it. However, some implemen=
tation
> > details on our side may differ, so we=E2=80=99d like to discuss our pro=
posed approach we
> > have tried in this thread.
> >
> > 1. Register a dedicated CMA area for kexec kernel use
> > Introduce a dedicated CMA region (e.g., kexec_cma) and allocate the con=
trol
> > code page and crash segments from this area via cma_alloc. Pages for a
> > normal kexec kernel can also be allocated from this region [1].
> >
> > 2. Keep crashkernel=3Dxx unchanged (register CMA)
> > We introduced a flag in the kexec syscall to dynamically enable
> > or disable memory reuse without system reboot. For example, with
> > crashkernel=3D500M (a 500M cma region), cma_alloc may use 100M for the
> > kernel,initrd and others data. This region could then be reused for the=
 current
> > kernel if the reuse flag is set in the syscall, or left unused for dump=
ing user
> > pages in case of a crash.
> >
> > 3. Keep this CMA region inactive by default
> > The CMA region should remain inactive until kexec is enabled with the r=
euse flag
> > (or fully reused when the kdump service is not enabled). It can then
> > be activated for
> > use by the current kernel.
> >
> > 4. Introduce a new migratetype KEXEC_CMA
> > Similar to the existing CMA type, this would be used to:
> > 1)Prevent page allocation from this zone for get_user_pages (GUP).
> > 2)Handle page migration correctly when pages are pinned after allocatio=
n.
>

Hi David,

> It will be hard to get something like that in for the purpose of kdump.
> Further, I'm afraid it might open up a can of worms of "migration
> temporarily failed" -> GUP failed issues for some workloads.
>
> So I assume this might currently not be the best way to move forward.

Got it, thanks.

>
> One alternative would be using GCMA [1] in the current design. The CMA
> memory would not be exposed to the buddy, but can still be used as a
> cache for clean file pages. Pinning etc. is not a problem in that context=
.
>
> Of course, the more we limit the usage of that region, the less
> versatile it is.

Yes, I agree.  I=E2=80=99ve already noticed GCMA, and I hope it can be merg=
ed upstream
in a more lightweight manner.

>
> [1] https://lkml.kernel.org/r/20251010011951.2136980-1-surenb@google.com
>
> --
> Cheers
>
> David / dhildenb
>

