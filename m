Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA06CCA476
	for <kexec@archiver.kernel.org>; Mon, 13 Oct 2025 04:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3eGY0AcUThBIod555E4HhcocUKebMojSUCKc4CiUKOE=; b=wjuHIjKLwEZIVqFYN9XcopYbOn
	XUns6U3fu2sn1Px/I/RbJYW6TYAkSZp3MbbdcRlogO8+5by5xnKJy+lBLlcfSWOJn8zpC/dg8JPtZ
	Z/TD+KOfCsjP5vcn0sTLfoQ6VbjOXaA1UreL7+O2F8Ba1u1oKdSAjUWZI4DFUQZmsvP2cpu6AaIJE
	+TYA5QCfQ8YUQCU9JO3TIWckE2hVgN/DTYukPU7SrG7aNPFM726bPHl88t6at/NbPyJFli2haERtO
	47SqpyzeznH+k5JGWbfOT1KSShl1eXyrNalJEkpEbBNKIujge0AVL41EVjbIimZgi98A+yUrcilaV
	L6Zww/xQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v89nE-0000000CBeY-0j7c;
	Mon, 13 Oct 2025 04:04:16 +0000
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v89nB-0000000CBe9-1NW8
	for kexec@lists.infradead.org;
	Mon, 13 Oct 2025 04:04:15 +0000
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-3761e5287c9so35226721fa.2
        for <kexec@lists.infradead.org>; Sun, 12 Oct 2025 21:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760328247; x=1760933047; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eGY0AcUThBIod555E4HhcocUKebMojSUCKc4CiUKOE=;
        b=h+nv0YFmFhId5nZwfwT3UOGrVvu6F4MZWbUelplun10sGUnA3BKabbntjm/JqD1hUB
         b2nnuBBgjQp1pNVoXFapvlEXbN/Bko6+UZ8bd8gY/+6MJh4M9zDZxbbfmrxCPNzii2vI
         YKWw+ubJpARJh1flcOxAkBWpJIP1qC2C60yLlJDbgKRd8ehpD2lcqK46wEOixyCX9UyG
         Il3wryZ3KbmUr9p0nZgwIw8BEjTTiwHmpwxiEpeG9Ju/owDGC4+xPrketkaZH8apHwyM
         kAiFsZg5dPdvI4CkXPyU4j2EpbeSUYvWhsq5HpOP2SVkHmEK1PRlfCZOYS/NFC9wCcVo
         GWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760328247; x=1760933047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3eGY0AcUThBIod555E4HhcocUKebMojSUCKc4CiUKOE=;
        b=C45E7u1tmFoSvJlcbwn8d8LJKstaUpyklB8TQLevuP4eKsJrXy/XX0tAJsd4cBt3mb
         m37Ud1rI5lwlJ+C5+fYXdWdTfMOKtT0LNOtr6DFbC8w4/qDzCoUsIa3Ex785py0fMvI/
         ixaLBg8wR4xAhdWudqvj2v08ES/ueOcXvnH8NAWiBLmMRWSgT1rUVBXgfNG9q7x3pbGE
         1gRO1NpCuAa8YZZSk4e+0uFz+u2sevZhy1K2OEFq1o+LjWa9UMV5uFGJhGLXEzlv/iNI
         GoyGuDpFL01T/3BYIrZ/2vXVlnGt9TxRNoiDE7ynvU17gPIYW/Cd6E5jtyBAxCRa5oxH
         2mPA==
X-Forwarded-Encrypted: i=1; AJvYcCXfVakFQv7tvSKuPQTa3y/UyLQ4SYBVDZ2qBHC/Wjtn5LUnfGe/spw+HsRt4z6bDddebL3Hbg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxT5VjiDGvpMIJWKwOOB4Re0zFvTobUt6cEVDXILmk11Yxf5qAK
	wOiVdiZ/4hdjcCY0mBKiWuSn1NFNhOspZCwsAuR3cKyUu5/Nd0QSaj2JmHavQ/LtW37Ah+QOXQz
	BH7RLBBArf9Fzw2C2usJz0azQBc5bTJ+1vPJVrtCJog==
X-Gm-Gg: ASbGncv/8UV6kTikiXzQl9kknfMpTKd85WFBoneNyPnvjWiSedDhTF6EIFlyf3Zp85O
	aKt/jBNTgSPtXQipGdsln2bYfzZtWxLBFhEM3ZZC0gYTQQ9q7O7lTjPjcfwOTNAoTforg3qOSjN
	YgimPPjyZ6spEcoxbzoCv+ZEqDUbvB6Oy8fLikEe4NVot+RQrMeHeOYGzhwlDX8iASmbz/D0Fbw
	1dMOR9G+QM3jVyLND2VdLbR3eySmYZjbe6Uu/652IxApg==
X-Google-Smtp-Source: AGHT+IE0rggG8rwZ9a1p14VnFxT/ZqFMnmZQQUmYWuoCAqef6nge1SXll1x478ZdTK1vw0muIbu/il7UNi3O/2Lgi+0=
X-Received: by 2002:a2e:be0d:0:b0:375:d4ab:b297 with SMTP id
 38308e7fff4ca-37609e9236amr48527381fa.40.1760328246874; Sun, 12 Oct 2025
 21:04:06 -0700 (PDT)
MIME-Version: 1.0
References: <aEqnxxfLZMllMC8I@dwarf.suse.cz> <vojlxf5pelxlr6omsfsccd4e4cdzn5qyxpgiqajorkgmgd7ruh@e5wwhkmvntpb>
 <26ae6b04-3beb-47e9-9639-b081003dc9bb@redhat.com> <f7x2flir2c5zpkusgiyk7qnrdqo4dek3iksyldw6w22r55s4vy@4b47lrcv3fag>
 <2e35b6dd-56dd-47e6-8dac-54f446f763f0@redhat.com> <aOSO/e68pZ7FGKm1@MiWiFi-R3L-srv>
 <ctrpw2ppozwtsj7544jx45kpexmaackpzzyeyhkqsjrf7cz2tc@7fmuzvy7uwec>
In-Reply-To: <ctrpw2ppozwtsj7544jx45kpexmaackpzzyeyhkqsjrf7cz2tc@7fmuzvy7uwec>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Mon, 13 Oct 2025 12:03:29 +0800
X-Gm-Features: AS18NWCowNR5GjE4I1fPqkrYdc53m-GbO09yFPHSPoOFxHc1tTSHu_k2a0vqpdU
Message-ID: <CACSyD1N0fb1H3_ssEyaAMh=2shQy-64gG_t3MqkedwfOLEExEA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 0/5] kdump: crashkernel reservation from CMA
To: jbohac@suse.cz, Baoquan He <bhe@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: kas@kernel.org, riel@surriel.com, vbabka@suse.cz, nphamcs@gmail.com, 
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, 
	akpm@linux-foundation.org, Philipp Rudo <prudo@redhat.com>, 
	Donald Dutile <ddutile@redhat.com>, Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>, 
	linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.cz>, 
	Muchun Song <muchun.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251012_210413_648022_A64E1401 
X-CRM114-Status: GOOD (  11.67  )
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

Hi folks,

We=E2=80=99re encountering the same issue that this patch series aims to ad=
dress,
and we also planned to leverage CMA to solve it. However, some implementati=
on
details on our side may differ, so we=E2=80=99d like to discuss our propose=
d approach we
have tried in this thread.

1. Register a dedicated CMA area for kexec kernel use
Introduce a dedicated CMA region (e.g., kexec_cma) and allocate the control
code page and crash segments from this area via cma_alloc. Pages for a
normal kexec kernel can also be allocated from this region [1].

2. Keep crashkernel=3Dxx unchanged (register CMA)
We introduced a flag in the kexec syscall to dynamically enable
or disable memory reuse without system reboot. For example, with
crashkernel=3D500M (a 500M cma region), cma_alloc may use 100M for the
kernel,initrd and others data. This region could then be reused for the cur=
rent
kernel if the reuse flag is set in the syscall, or left unused for dumping =
user
pages in case of a crash.

3. Keep this CMA region inactive by default
The CMA region should remain inactive until kexec is enabled with the reuse=
 flag
(or fully reused when the kdump service is not enabled). It can then
be activated for
use by the current kernel.

4. Introduce a new migratetype KEXEC_CMA
Similar to the existing CMA type, this would be used to:
1)Prevent page allocation from this zone for get_user_pages (GUP).
2)Handle page migration correctly when pages are pinned after allocation.

We would like to discuss the feasibility and potential implications of
this approach with the community.

[1]:https://lore.kernel.org/all/20250610085327.51817-1-graf@amazon.com/

Best regards,
Zhongkun He

