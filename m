Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46E5C83F04
	for <kexec@archiver.kernel.org>; Wed,  2 Jul 2025 16:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HD+xgnYDji4Msf7wrsJXB90TJgJt6pJI4Z6MoS60Mb4=; b=hXne1tzeTyPk1sbieygETkSzoT
	6LH5Yzb+94ENm1cUOELYZIyHM7bNnl/dj1r4nCFkNj039Vtc2/GPBImX4PGeSwJK5nXNc5oEJ2UYt
	0Hd31apoUws7bq2HM45qZ45Qk5gMWlfqWngdRfuiAMvVqQdQhW9Iny0hqtVrwIh0OQI+vEdDtEv+j
	keEG/NWFCvIZgayLFNPNtezG2LkQNmdVAYjovt1vU9dejkXB040K8o3bDmpt2je08Tea0fP90yPhS
	lYYa1u5VNTlLGbb3wlXmfjOoJc+JxeWd0h6Z9eVIdFSWVfC48x/jZ0fw9VXu3HIXO8IdW63M1qaPu
	cD+JnLWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX0Zs-000000090I4-3zD1;
	Wed, 02 Jul 2025 16:44:56 +0000
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWzzv-00000008toq-4B9v
	for kexec@lists.infradead.org;
	Wed, 02 Jul 2025 16:07:49 +0000
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-e8259b783f6so3955739276.3
        for <kexec@lists.infradead.org>; Wed, 02 Jul 2025 09:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751472466; x=1752077266; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HD+xgnYDji4Msf7wrsJXB90TJgJt6pJI4Z6MoS60Mb4=;
        b=UhJqldsTfRtncyQHjxjCp9ZO4mkdiXXP+sMeZhcSxZn/h7kSHWv4tf+k0hY2qE+DWZ
         GuEN8GySZWI72YUhMVQnPf32YCQ+tkYOb/12LG/X5tk2MFedupmAQUnN9mFJaYQSyDER
         D4iidJ+WjXrzakKQU/QCCh+BQxU8nsIbWK8NXhJcFfgpeqpy1oiht07hxdToxIR8KTkM
         cipXEBqAWwUF67sZNwqUGQPW64w+gEoJGOYn5qjNyasQzrZ28Kgt5jsH657SjO5v1M95
         nFBBaO84kRlNUeBNLMAojsRKdDlXp1AYn2aUj482kTgdunLfXdI3U60GTexS2tBYO62b
         /fvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751472466; x=1752077266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HD+xgnYDji4Msf7wrsJXB90TJgJt6pJI4Z6MoS60Mb4=;
        b=KTD/bYo1E55yGKWvRmamxsI+R4722aMhs8Al37h+MnEhqHwbP8+vjQ3Nbu3tW0Mij4
         /EXM98rAxTXrtXG0XEm1sFgzfxrfuLzvhJ70Ixikgy+KoHFVNQ7/RLKFcqs3LpNGltwU
         DSyEHeJcKq4ucDnNByEvH0x8FbJPZboU8pTJFRKs0bbEB6YeZQiFYIci/BYrPB8JzWFI
         h7HkfipaJqHvqspSBoqeKPLjz0LN+g4VdzoSXeaD5grLBIr0jq89OWt8M68yrGFAiSmu
         VfKMoGHpgXp7jgJ9MCkn7GR6urSJ7HVFTCPajaxlc1fvOyljte+R6EypGXrGg1kEt06T
         HxGw==
X-Gm-Message-State: AOJu0YyGDP8kbidozd3n7rBVRJ6Z8PbLs9Jl1CxRl1sLIYetbBmzvl89
	qKvATrzbgPZGqG+TT67EXr7m3JjR7DmHvoaLfSWe/7H86jpgcprWEXwLAB/xUXAkxcJekLl8Zrk
	N2T0J9AHfBoLHEIrY4VlwgewaJ+AOVXk=
X-Gm-Gg: ASbGncunX4vGJana+zw7R4gyERiw8Ty5iPNDswo6Cid/7XKQAFh0VEIljg6oM0NEd5e
	8amT/Iqa72T99gmhHoLGmOXJWYxHgBzsjTrxObp0BxQNW/0PWq4vbEc5q9q2yq1ujx5Sx0s66O+
	v1V7JgnDGPyRJHbHix+qS1dPDa6OM2RZJrH+3IA60JxXafrWm7d2WydhUQvUqeQ1MlT4CEElueR
	r3gXJp+QGb1/Ks=
X-Google-Smtp-Source: AGHT+IGJlgMebHeafPhpvXNEnuwrkCWG7XoVPlNbjrpQZw1BfOjYrG9vvzbLo5wAqGetaoboXNjnvUJBf0NJewO55f8=
X-Received: by 2002:a05:690c:fcc:b0:709:197d:5d3c with SMTP id
 00721157ae682-7164d2c7e12mr49580597b3.11.1751472466302; Wed, 02 Jul 2025
 09:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250624201438.89391-1-moonhee.lee.ca@gmail.com> <744bd439-2613-45d7-8724-5959d25100aa@linuxfoundation.org>
In-Reply-To: <744bd439-2613-45d7-8724-5959d25100aa@linuxfoundation.org>
From: Moonhee Lee <moonhee.lee.ca@gmail.com>
Date: Wed, 2 Jul 2025 09:07:35 -0700
X-Gm-Features: Ac12FXwoDxTwwqAXE8JcpNRXiozFERVYFVPE9rjvlkt3rV15dPoHwueD88FdyYo
Message-ID: <CAF3JpA72DWF8=2HF+_HMsH4DuOg5aVYZdgyhmJisDG-WxL=uYw@mail.gmail.com>
Subject: Re: [PATCH] selftests/kexec: fix test_kexec_jump build and ignore
 generated binary
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: kexec@lists.infradead.org, dwmw@amazon.co.uk, mingo@kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250702_090748_036149_B26556ED 
X-CRM114-Status: GOOD (  10.85  )
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

Hi Shuah,

On Tue, Jul 1, 2025 at 12:53=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
> The change looks good to me.
>
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>

Thank you, Shuah. I'll carry your Acked-by tag in v2.

> There is another patch that adds the executable to .gitignore
> https://lore.kernel.org/r/20250623232549.3263273-1-dyudaken@gmail.com
>

I missed that patch. Thank you for pointing it out.
I'll drop this change in v2.

> I think you are missing kexec@lists.infradead.org - added it

Thanks, I=E2=80=99ll add kexec@lists.infradead.org manually in future patch=
es since
get_maintainer.pl didn=E2=80=99t include it.

$ ./scripts/get_maintainer.pl --scm tools/testing/selftests/kexec
Shuah Khan <shuah@kernel.org> (maintainer:KERNEL SELFTEST FRAMEWORK)
David Woodhouse <dwmw@amazon.co.uk> (commit_signer:1/1=3D100%,authored:1/1=
=3D100%)
Ingo Molnar <mingo@kernel.org> (commit_signer:1/1=3D100%)
linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
linux-kernel@vger.kernel.org (open list)
git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
git git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

Regards,
Moonhee

