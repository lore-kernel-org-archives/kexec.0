Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1B7CCFA00
	for <kexec@archiver.kernel.org>; Sat,  1 Nov 2025 13:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JUhy8B8e0SPVvnGZqFMKkN671bOxkjd/0ClcQZsCqPk=; b=eqObRZIUCN9C22VpKW7v1bBMLF
	yWvyz3YSUYUfQg8F3cqNu2wIzBT57vrX38PCFTKyraA0PDhdMeAe8eQtDi1X53gdKh1uOpbs0XOlf
	j+dKsBwGfhSnYVYvjI9ko9U11GavT4c39LPaW4RCshlVDOA58lISWe42iWRHHswNTQoJTWCX5gEIj
	cNIPJVG1FHMlQ0AWd4KX7uXO3k5OmzaIls1UaDRMQCqcLifT3iLwnCxDEUAByIkFTZk1M0o+CZUPv
	b+95Y5ugD+MHgV0Cu84oQwp5jIS2AFwvTU7/os/n4x2UJxNSy96DPc8OA/u4SyEB4rV82gSc4f+bI
	VIpk5BDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFBzx-00000007oPL-1oIx;
	Sat, 01 Nov 2025 13:50:29 +0000
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFBzu-00000007oOz-0Wuu
	for kexec@lists.infradead.org;
	Sat, 01 Nov 2025 13:50:28 +0000
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-62fc0b7bf62so5236719a12.2
        for <kexec@lists.infradead.org>; Sat, 01 Nov 2025 06:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762005024; x=1762609824; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUhy8B8e0SPVvnGZqFMKkN671bOxkjd/0ClcQZsCqPk=;
        b=GjMks1eRwzorWlp5BY0D4/aImx+flSk/IdHwdwqHRJ9i3wsL5LZckg6Qmc4dS6WD42
         PIiaLmLY9XtG+kA1iwXFCo5dh7lqMOK9POwI4ohgaIVzbObjhj5lBLPjiPNsBSoXkumm
         auJHOhAfG0bcci4I+cgpJOO9WmQbBPNI2QdoHONfjlctZLP3tufIJu57PasQo4ppA45a
         NGbomZ4++G+vUFt+WM4B31T7SVekuERGnMCZaq1OIc2bbTh89f2edHe4KJeL5b1nBpW4
         PMo8CLShb541u+vDRw9J/2eQrpI4L1cTAyC50dimzQJKDQ7RaCzHuz+0cxQctUCzOCR9
         gxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762005024; x=1762609824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUhy8B8e0SPVvnGZqFMKkN671bOxkjd/0ClcQZsCqPk=;
        b=RYfe2ImZg1xkuikWtPVI1Tp6JRB3FR0q0YANxwqs8bCB2tUtcQzhgcydQbAIqj67ME
         pULnv1d57qNr0UI3r8tcaxrBwKDxvtF7lzt61hCkxMSZfeZAowl7soPlbK8j1GBTcEh8
         C6Pi9jP9Tpl4/f/NOTr6M3EwvFGyF9yKs9jl+qQRGz1FbZks5hfGtMJmKmhH8BsvIxrU
         GFYBLFkMXuf4MTrh4hj7QupFaCCQKzojWas3OOvZdJKQgTU+Zeg3/ewL99d2RFE/ExXU
         c7+tyRb43eXfCzfXKuZ1QMKTbd9xg0/+9QYmFQZ15Flf5537OgPVonAv8EaLxlmeLoO/
         +BLw==
X-Gm-Message-State: AOJu0Yzn6G3yBMFFYehrunv9OdT4TAYdkW07uIkDHimmEJHdPzLbpJef
	XAEKYqhpmxhzsaomBO1O5KjK0f6NiND6rZ5oiFck0rHkmLuDno9HUCm9koiVtnP4npmLUQyJ7V9
	A1XlnKdO5+q5xOppMi7PCP/KeZofbj+MFOnObLWmGpA==
X-Gm-Gg: ASbGncugy669VH3Ukgkj5QWUpv/ne21NN7I/mwE9QGSzKitzxGD5rQxi8KMCLF+7WFu
	ja+WRsLEb9wGY7HQ86HoqzQ4n52sF/7Bj71gfiuC8jQpnNR4wUALG7VsCDC2kOhuPmmw4/+qZQp
	VQtcDbM86bMunByxzXp7Awe0ZiSmIFzUqjLff4szDOpeIk8LFYNwtcjVgM2xEOuEVigRA522MC1
	7GdfbaTmdpiyIcwKMyP9QbtYLHt7/SCDslUEjeIyPzfQvvM+3gHwKe6TGp+AajgZJPAWRW5oYoH
	6+xyv3u7Ae05TGAEb+heZkRJbD9f
X-Google-Smtp-Source: AGHT+IEIO7PvHjnJQ62KO0r3gUSccSfXRQY2A86NcnBt2N+segjhBecWOfFmRqh0rMurQ5aFXaviqq5czfpYfbaRUOE=
X-Received: by 2002:a05:6402:5347:10b0:633:7017:fcc1 with SMTP id
 4fb4d7f45d1cf-6407704fd5dmr4625184a12.14.1762005023728; Sat, 01 Nov 2025
 06:50:23 -0700 (PDT)
MIME-Version: 1.0
References: <20251016200320.4179702-1-yanjun.zhu@linux.dev>
In-Reply-To: <20251016200320.4179702-1-yanjun.zhu@linux.dev>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 1 Nov 2025 09:49:46 -0400
X-Gm-Features: AWmQ_bnZsvumh2bpEqN2i1Lq7WYeKAVK8RN5_qMjSNkRfeRKZmWCf3eNLlzvj1M
Message-ID: <CA+CK2bCHCw=5MaOVpm4VzJ0rHtuTVJ5JWECZQxc128djt3i0XA@mail.gmail.com>
Subject: Re: [PATCH 1/1] kexec: Use %pe format specifier for error pointer printing
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, graf@amazon.com, 
	rppt@kernel.org, changyuanl@google.com, akpm@linux-foundation.org, 
	bhe@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251101_065026_190422_F96B4ACF 
X-CRM114-Status: GOOD (  16.50  )
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

On Thu, Oct 16, 2025 at 4:03=E2=80=AFPM Zhu Yanjun <yanjun.zhu@linux.dev> w=
rote:
>
> Make pr_xxx() call to use the %pe format specifier instead of %d.
> The %pe specifier prints a symbolic error string (e.g., -ENOMEM,
> -EINVAL) when given an error pointer created with ERR_PTR(err).
>
> This change enhances the clarity and diagnostic value of the error
> message by showing a descriptive error name rather than a numeric
> error code.
>
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> CC: graf@amazon.com
> CC: rppt@kernel.org
> CC: changyuanl@google.com
> CC: akpm@linux-foundation.org
> CC: bhe@redhat.com
>
> ---
>  kernel/kexec_handover.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> index 76f0940fb485..77af377022b0 100644
> --- a/kernel/kexec_handover.c
> +++ b/kernel/kexec_handover.c
> @@ -1095,7 +1095,7 @@ static int kho_abort(void)
>         err =3D notifier_to_errno(err);
>
>         if (err)
> -               pr_err("Failed to abort KHO finalization: %d\n", err);
> +               pr_err("Failed to abort KHO finalization: %pe\n", ERR_PTR=
(err));
>
>         return err;
>  }
> @@ -1142,7 +1142,7 @@ static int kho_finalize(void)
>
>  abort:
>         if (err) {
> -               pr_err("Failed to convert KHO state tree: %d\n", err);
> +               pr_err("Failed to convert KHO state tree: %pe\n", ERR_PTR=
(err));

The problem here (and in some other places below) is err a not an
-errno, but fdt error:
see: scripts/dtc/libfdt/libfdt.h

%pe ERR_PTR(err)  will output garbage, and make the debugging even harder.

