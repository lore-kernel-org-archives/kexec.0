Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D6C7C282DE
	for <kexec@archiver.kernel.org>; Tue, 11 Mar 2025 02:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zxNqfzIJOq+aes44VAuh3ND6XVrERi5tX1yWJumykVc=; b=JG5jRK6bQvyY4t7G3JvqHmVfzM
	Zk0VRKCpDewquYNX5d6EuS4x/siCdLaIUZe2iUxaQMoIZiaWSTqZx0KPJgB6QKO44xB4sKOEj7MUR
	fnTjp5Xu15gts5SGS8b5pU8mXMDTGBFTcDJavS7U7veu5bO+W/tNdlZ5eARzpVMQwfVXKjOlK6vud
	30LQg91+AMny6ddOxxgfKsb+pj7oL+0kIz9RaU91GjcqhpdJiB5GhkAvqWY+z4WCN+n4i2lI4i2UE
	xyAwF/4dQJ+SNBItlxOFAvs9+No1L7txf73ejFpp/V24hH6kW/KYFPLqYMOrXLDVD9hviS4MfYcil
	mPJHgShg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trpMk-00000004QPZ-32wy;
	Tue, 11 Mar 2025 02:29:10 +0000
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trpLN-00000004QCs-1FQ9
	for kexec@lists.infradead.org;
	Tue, 11 Mar 2025 02:27:46 +0000
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-860f0e91121so6121006241.0
        for <kexec@lists.infradead.org>; Mon, 10 Mar 2025 19:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741660063; x=1742264863; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxNqfzIJOq+aes44VAuh3ND6XVrERi5tX1yWJumykVc=;
        b=KzMpx0y149Ok60e1Xvw939hwonmyLtc8lvNTuBEYEy4O7eRbLFXIs0afoepcnB63VP
         XUijhwtNkFZFSbAHxdjYyrnyjUFKX7j7adI9CGPuNbr38O1zpW8DgRI8CIaljPQ7eMlC
         ocs1APKvHE48efsp9G8IZhsNUqSAatWvAaJmjp4Mck5qg9hSNIIKaSoyR3cZKVd6aktr
         Ot5awmz0LWJaQzyrVoF6jcQI+Ijtjipq/gzwe+cm12XjzIhUbeGswv6USAtrw++kicls
         jN8zo/tbe9QmcZPQ/LDuZIukzeEUp3gatYVjhU+3mfDVhgSxd7D44Bh0WTIuKHqhvT6F
         0tjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741660063; x=1742264863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxNqfzIJOq+aes44VAuh3ND6XVrERi5tX1yWJumykVc=;
        b=EHvJYFQb1kLGn2nzBKP6hJL4Oq8/N3usxuzS66Fz6GW/YGsw+PcecxGNhV1HQXD7uv
         C+vBnKuo/uJGPLOttOawME6g4XbyMFy4luiC8X984eHfMVHhP0Xaf1CkAGoQ8M3ZOLRq
         7wBY8tlildpoRrbmFbe3JpG7xCKm96r7rp+6OArB8eTEQ4JMGkrUPo8amlbobaKyzzwv
         u7RUPmUNGnbC1WYiIlBqHe7D37gsV3qosO5JF1RUHFnL5M8050yL7/EPyFukhL0rQLlz
         P6ESNcPtiEk0+3aOQvrxWzm7NTNIYGa3Ix0dS1AwIFnvrb8qhLB/h645ns0zLMEo2ksW
         SYCQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3BGK39lK6PiWXfP9kxbFxkdINPZL/OqBd3RszkymK122ujHUkFCcgMXlvCPeHSNT5gLcR4Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YxfIf5ZtYqLfUGBK59uQOXMtjhOPMZc7yz+ceJS0pryim2dgVsw
	9hCtA6CW7+xNuPXCD5IsP/ALiN3Fz8hvwsw71gSOrp3g7XQtW0C4O8DSJDjw+MGxrC3xr/Sr0Tr
	hOCQNMCP+1knfzXVw88LdK0mHBgc=
X-Gm-Gg: ASbGncsKv6Vp3yq4hDeAdr/l8d5mnt9+wDHCd7/uFH9ngx52P2MnqUEs0K35Dl7orFi
	wfVNHlyCG0hQDZ/TwNyMrVwZ1yZdnNq3gSlnkprTDhjwx2cOmvxwye5stmjyFq6rui17ma/Ygzu
	dldnwWWHfmQR8cx4Gg1TdDbnxG1MpGBqdr9eUoIbvWkF/D3mpig8BQfbA+nYI=
X-Google-Smtp-Source: AGHT+IG44geEMd0Z6SABW33WxFehbT6i/WdOyVfr4nc5G+zHM4c/PKakIo/IjEflXjSp6/1T6K8T3kBOaH/9O5k/D1k=
X-Received: by 2002:a05:6102:e10:b0:4bb:baa0:370b with SMTP id
 ada2fe7eead31-4c34ddb2f0fmr1009145137.7.1741660062740; Mon, 10 Mar 2025
 19:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250310120318.2124-1-arbn@yandex-team.com>
In-Reply-To: <20250310120318.2124-1-arbn@yandex-team.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Mon, 10 Mar 2025 19:27:31 -0700
X-Gm-Features: AQ5f1JonvmzKODfnS3VtcEwv6mX0Gms85-MMFdGxuU8lY-5TIICcfA8gPgKEOBg
Message-ID: <CAM_iQpWewprQzQgMWk0yMr=LCFUCGztJ4+G-NFt8gqe81XuUcg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] KSTATE: a mechanism to migrate some part of the
 kernel state across kexec
To: Andrey Ryabinin <arbn@yandex-team.com>
Cc: linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>, 
	James Gowans <jgowans@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, 
	Pratyush Yadav <ptyadav@amazon.de>, Jason Gunthorpe <jgg@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250310_192745_352142_D26C921B 
X-CRM114-Status: GOOD (  14.28  )
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

Hi Andrey,

On Mon, Mar 10, 2025 at 5:04=E2=80=AFAM Andrey Ryabinin <arbn@yandex-team.c=
om> wrote:
>     Each driver/subsystem has to solve this problem in their own way.
>     Also if we use fdt properties for individual fields, that might be wa=
stefull
>     in terms of used memory, as these properties use strings as keys.
>
>    While with KSTATE solves the same problem in more elegant way, with th=
is:
>         struct kstate_description a_state =3D {
>                 .name =3D "a_struct",
>                 .version_id =3D 1,
>                 .id =3D KSTATE_TEST_ID,
>                 .state_list =3D LIST_HEAD_INIT(test_state.state_list),
>                 .fields =3D (const struct kstate_field[]) {
>                         KSTATE_BASE_TYPE(i, struct a, int),
>                         KSTATE_BASE_TYPE(s, struct a, char [10]),
>                         KSTATE_POINTER(p_ulong, struct a),
>                         KSTATE_PAGE(page, struct a),
>                         KSTATE_END_OF_LIST()
>                 },
>         };

Hmm, this still requires manual efforts to implement this, so potentially
a lot of work given how many drivers we have in-tree.

And those KSTATE_* stuffs look a lot similar to BTF:
https://docs.kernel.org/bpf/btf.html

So, any possibility to reuse BTF here? Note, BTF is automatically
generated by pahole, no manual effort is required.

Regards,
Cong Wang

