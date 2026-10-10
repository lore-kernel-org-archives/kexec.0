Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE7ECA9EC3
	for <kexec@archiver.kernel.org>; Sat, 10 Oct 2026 13:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dUgv8qU2MJmYgliXxK0C5ED2Eb+oFUrhcbBUDF3fTq8=; b=e98mQ1/Hl8YrcfYIoLBQOWPCpT
	GZ+oHCpaVLxfGM1nW33uOY5oy6o9ot1JIcdKESocQa8s9e340Se7FRxoxabkVK2RWgDsXhecsFQzW
	NJ5JgsH38OxAdAQP5Vao5WEWb1m8JahzEs+V0gp0XwxfCzklhII5MC7Sl3hNrFg3sRkgu4ANeC4Fg
	/N26OXRBm07eVR/ZTR+I4TQ+jugXsStKxacY4KneOPEGWMuTuL26Ri2WRLpnbbnOHLtn0XEup434A
	jFbCVrUfaLyjz3W9LKMPCJFKjwNmWP2X9rGKtqsv8M45KkkjBhvo3cDe84jm7HuC1l9pnBR91/O0S
	HY9KWTng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xFWly-0000000858G-25sL;
	Sat, 10 Oct 2026 13:05:58 +0000
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xFWlu-00000008576-2DFE
	for kexec@lists.infradead.org;
	Sat, 10 Oct 2026 13:05:55 +0000
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-8ad549a2119so3346457b3.0
        for <kexec@lists.infradead.org>; Sat, 10 Oct 2026 06:05:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791637552; cv=none;
        d=google.com; s=arc-20260327;
        b=JDcDmc3DB1YCO9FODln9v51xcv+A1RGkK+r3wcMOPV30639VJhxXY3JZm5Fqc7u1/h
         VzDCXvDYYH/P108OLMNiv620df1k1X6xyLnpqWdISGS5vUH2bOEGCWctxtZW6K1mB1wJ
         HwXra8HF47zlAgYvA3ZYY5sl7E4Qd/WD7VI72BJY1gL9ig1NhOiM8sIaAi+jtrbK/u2Z
         UtQFJs/Z2zoLnEbxIfqhk0j1Sns/w8uja5KgSYKGtkyoKLR+rSgsV7xGhmtjx4r3q/3J
         P3/bHhTJKlBtoLo5SVo/SDP9iig2SgOfK3pa1WxaD1S8Y7YlPoqdMOJUnaEw8HUiyIBZ
         7Gqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dUgv8qU2MJmYgliXxK0C5ED2Eb+oFUrhcbBUDF3fTq8=;
        fh=0dpyS+G1wCJF/4D6bAq27rTt3n8Y+8Rq4csxywDhLiE=;
        b=PLMDSTNWz33TQOZk/h6XvmOw66yzvEeWkzZV306ZhQnb3ZrMy9VlB52Qc2z9vjCcUf
         CJfjFtNBWqMW+gs4qZviiXDDzaGr1DDg5PL2niMBWhdTISDn6V/K5t4a1qgSc462UPWh
         JalcRz+EOFU6WKjYBlEmVEupGSVBinkEIraQ9gYMI7hh32b2waBlVrPmmxSKwQY6829z
         sFeI0WkI9PPLHXs7Ib64CoTUDVrlyO1ifquoImoACNJqWYk4GVPBrG5dTLy42OqH4SeM
         6eC1afzkcFgxmI+VRgd8ycbJW17S8d9ryNOKuKlLyAzTg3M6EleQ7TT5aLA640Z+02dV
         Tbew==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791637552; x=1792242352; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dUgv8qU2MJmYgliXxK0C5ED2Eb+oFUrhcbBUDF3fTq8=;
        b=qbwFBicID+xdbNSOqLzbxJg35ZSY3TS4eZ2D/z8Ep19yHfuuFb/iP9O48+CAORMMJq
         eNzDLqnReF1qNid90vsY8+jhB/DuNH1rk8+POohc0KimGx5sG80Cfu4Abh4J8XMFXuDR
         +Yhxp/w3hwLbEfZEk+hp5HTyajzyeR0Zt6FQqKgqqwBvJtLEvMGzHT7UCuSP8mQu2RP1
         ki4ecqQCRS4BLAWVB7PLnuxcpUxP9y/bYTC/LCjmwNZu76bHtdgnYWeT1gdccvKjyrjx
         KK5rtB6cp4yN6+/qlCksS8N0h2/QqY1O/TV8/FXDP0qR1KiM5OCPwpVbn9ZwR6mHx9X4
         Nhdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791637552; x=1792242352;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dUgv8qU2MJmYgliXxK0C5ED2Eb+oFUrhcbBUDF3fTq8=;
        b=1ZI8lrnIba9RAS01IdJaQhnxnbHI31eDQvO7UpYSTJ0FCi3XaZOr5lkLxQfuMRV4wU
         ACSjx0gIR5Mr1h7+FNfOCFbDZ86fxqsPlIs9L91jQmdMPJBfP1+HiSruGANsQlL8HR15
         yNeIVBoYS3GyK4E0ctkicm14uvbUd0kYSB0Rzm6N0hSYvViWiKYeGbZ4HPTOxyi0H2rC
         0/GlB5QEKdrH2e3DRuSjCmzQQx70MzpDi3SMCrbPzHJZmjW46lWln0TnGp1tM+NKQ/kO
         bVtMiXnf8lNIuwnpD+9qWzDvcZGrRKal04uMHWxKvPtFgkLwc4tjtmY8NU9OnRYKB8Jj
         SjhA==
X-Forwarded-Encrypted: i=1; AKwUvBzjCcTj7hDlqldxuhdkFYdPxjArUlZPt0SCJcQEUHA0PN5JzcGAx/Tn25818glLDPL9hzHgmQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYI9ZTlfan2znVrb6XhYsUWs0O3QdNwkU8vppggiydeX+/Sudz2b
	ldYBs//J1ctMW6uEU1BtLAumNjBIuj/Lei/tBMipdhb38SBlU4wzSIseHUfl7Fv9KaNJ0Cv0kcJ
	rwqy06R+VG3gnM1A1S57wftqgDAnjs3g=
X-Gm-Gg: AYBFou17gXcb+93wFBeCjv07FLuy/rFVAJNIuIixOBJ1E2ylzHxlmtSu+YF+B4UHooW
	l/vb0TdkpHvdgQY2onojoe4dYEh/3QIebbFgdUIYjgK314ELwkBp7HaALO4BKcmPppJYQljwAef
	pFtVskTcPOHkS0XqF5ezcYn+FWyFsQYC+bKPFRjHeCPcqLrRmHnCKTQo+jNjxT93Niw+xXemsZn
	klOnLgI/hCW+zr7jEITvml97jkkuccmblgmRwswrEd25kTB40yqg5KP+e/DXMc6Macvvznk/CMK
	/sI++lA+v0IsQieQpTUjEidb+bfv1KYbyGnWonGZLJRmulQwYgZXH5gF
X-Received: by 2002:a05:690c:85:b0:882:31:3af9 with SMTP id
 00721157ae682-8b07ebe12aamr14950917b3.9.1791637552107; Sat, 10 Oct 2026
 06:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <6ac99eb9.6b935c14.1905ce.7c50SMTPIN_ADDED_MISSING@mx.google.com>
In-Reply-To: <6ac99eb9.6b935c14.1905ce.7c50SMTPIN_ADDED_MISSING@mx.google.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Sat, 10 Oct 2026 15:05:40 +0200
X-Gm-Features: AclHuK_ZZxWO5VOmv-dijVsfp5Dirw-cleU_Ss5a_ua-hVf2p2vv9lQol9MPm7Y
Message-ID: <CAMw=ZnTTUxO2ZCobEDTQUY7OZxmyJUQxg4DkhC9gTWXaDaK1dQ@mail.gmail.com>
Subject: Re: Question about obtaining LUO session FD for non-systemd-managed service
To: Chenghao Duan <duanchenghao@kylinos.cn>
Cc: jianghaoran@kylinos.cn, avagin@openvz.org, linux-mm@kvack.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	systemd-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261010_060554_592385_36DD7635 
X-CRM114-Status: GOOD (  19.30  )
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

On Sat, 10 Oct 2026 at 04:11, Chenghao Duan <duanchenghao@kylinos.cn> wrote=
:
>
> Hi Luca,
>
> I watched your excellent presentation from the LPC conference in Prague.
>
> I have a question I=E2=80=99d like to consult with you.
>
> I am currently working on the `memfd_luo` feature in CRIU. My goal is to
> leverage the LUO capability to store checkpoint images inside memfds.
> After a kexec reboot, the image data will be retrieved directly from
> memory instead of from disk.
>
> Here is my pull request on the CRIU GitHub repository:
> https://github.com/checkpoint-restore/criu/pull/3152
>
> In the PR discussion, avagin suggested using systemd as the CRIU daemon
> to centrally manage LUO sessions and access to `/dev/liveupdate`. I have
> watched your talk and read parts of the systemd source code.
>
> From my understanding, systemd currently provides a unit=E2=80=91based so=
lution
> where child processes can inherit LUO session file descriptors. However,
> this approach requires the target service to run as a child of a systemd
> unit. As far as I know, CRIU does not run as a systemd=E2=80=91managed se=
rvice.
>
> So my question is: for services such as CRIU that are **not systemd=E2=80=
=91managed
> child services**, how can they obtain LUO=E2=80=91session=E2=80=91related=
 file descriptors
> managed by systemd?
>
> Thank you very much for reading this email. My knowledge of systemd is st=
ill
> limited, so please feel free to correct me if I have misunderstood anythi=
ng.
>
> Thanks & best regards,
> Chenghao Duan <duanchenghao@kylinos.cn>

Hi,

At some point up in the stack, everything runs as a systemd unit, so
it's only a question of figuring out in your setup how to pass the
FD(s) up and down the stack.

