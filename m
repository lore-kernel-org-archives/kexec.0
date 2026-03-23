Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9E2F483E3
	for <kexec@archiver.kernel.org>; Mon, 23 Mar 2026 19:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sQbe/0T90bj+nzgvCgx/9AZxqMYkz/Zoay6gt6y1obw=; b=Q7ggjBJDNs7/Txeoas5GsUo331
	5iYs2iYNjBUXLacWA+uRB1fChuSUSZjGesl//1wIm/ZMBxPzwqsPwqTQksFg+Bl52YHueNgkwUzGV
	T0KcpUKWCJ5U0FfG+t4oPQ80Qt97lXiMLlm+1Z0tQ2Rv1SD8oKxK79U0mBafkaWGuWE6UvGUdLLr9
	yA/eXmuMYDSIP8yDkq5ONjey9ZqDX/SycU+mL05MBmnV5vFAe7GFlE0SenMAzvK7hjS1pHo8cx498
	0D0ChBFEK+jCjNDFMJfxEeoFdTsV6qfNqEgIqknvfxmUdnnmiAUtq3aHZYY95Y+xkhVjkkhMYmp88
	chLiLIOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4kX1-0000000HOkk-2kAR;
	Mon, 23 Mar 2026 19:01:43 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4kWw-0000000HOgZ-0xJn
	for kexec@lists.infradead.org;
	Mon, 23 Mar 2026 19:01:39 +0000
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-66966a394ceso3567567a12.0
        for <kexec@lists.infradead.org>; Mon, 23 Mar 2026 12:01:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774292496; cv=none;
        d=google.com; s=arc-20240605;
        b=k8T0q1OtPgBvsxHGAji5C6OGPitfTYgH1H241i6qg79wY5gVRN4yj9PiRtNhnAt4QY
         6DcWnlJRDKIWDF3nOILbe+W6REXmrFS+RZTws2QgRnwIqLaE/4P+auKCUAHei3UNc1YV
         +9VFZ2cXQEcvcIBEhHPVAjkJG6l7azbuuSnBAIsvICQyNK1h8ggn1izBO3hrdLSz0Xkx
         tzkrVvUJyV4MUBDNt8fBeFdn2SxpYxB+LuTwMxnRtRspybmArt3vTQvx3sPlvpOLqDSA
         bwE1gFGe1OduqblIPNlzC1uBwbwjZaihz5qNg+YUARVPMxG66h/YJ84ElMzCZXdpIcE5
         FPTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sQbe/0T90bj+nzgvCgx/9AZxqMYkz/Zoay6gt6y1obw=;
        fh=Xj/kE+FCxhvFPLvWmxz5Lfhwb1bjw09bMFa7aJf1GYU=;
        b=VdNT6VWDSDu13RNwa0i8TsUIJUX43M4zhhZrDQW0RBWd1sqIFKuWH2jX5TaD+KNmL2
         mb0MVISO1/Gt3MbKhF2pfx8sI6FUjM8lYF6LuWCi1RX7PAevyhAn9wM9yasHTKT4clff
         9NyNxmEPDku1S6JHHvrlWkBjqD/+FtXVC1dntGnh9tA1L6DcqOLjPzWKOffnNj0XeQyY
         ZrUsXGpqx5Z2NbppsFTX25xOyM3rFRpPwbqWVsoMVwrF+9ufaOzRoFiEnfGWc3p3R+f1
         unsXJ/2efsqFmd8QXGu29USUbJdDlXjspG5kdmi+c9ik3LqDHgqlcFuhgYlrGh+SH6l1
         Y9dg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1774292496; x=1774897296; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQbe/0T90bj+nzgvCgx/9AZxqMYkz/Zoay6gt6y1obw=;
        b=TjsRv5TCOMmtryGF3KzlvQvkJZcJXiQEg2Hf8ZDwXN1/pH+TrIHsXcoMt+spAZFJSI
         W3Gx/LGs4i+BV+ki730njgFNP7RdbW40YXg6RjX+x443s0P+YVW4h5YZ4rfB2QK/fAsJ
         Cdu9ea4/SIba86VPspQrjj+CD2fAwFv5+H+hy8vHTqgdFrEG0skBiQXGj+7Rt/Ua8AVE
         wdjhrrltwRENsm3kerbBomTYpnzw6TRvK/F9mcDyhhn72h4tQBfsYK38ysgUimAW+5kN
         Jkjk8MUzq1h0GKjM2MsyQuuhO1PB1RTNPq7RCIjKIIOpivQ/clFpsABpHIVGaX+yB0yn
         hM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774292496; x=1774897296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sQbe/0T90bj+nzgvCgx/9AZxqMYkz/Zoay6gt6y1obw=;
        b=R6sGEkg9w8cF4JBb2EBmNYA1sgUuCc7P3harI8zeW3D+y5sWdQkbjNyViLBKN9mufA
         DERIS0e9EXn51dbhjiZSobgSLdm7vsn2mbsLIaFee22eaHgxHKJOSnQRX6g+RPqba1C2
         nBN71t2Mdn94iQ4kT3GS+321VOcyq9Re36+HzbjAcujIiqE6mIOE68SLFgg4zcJMLAep
         wzRfDOQUoSKuvhO0S04MgC7euXo66T5d3tbMXHBlcak8FdGwH1M/3krjirGlcf8UjXk9
         jGSgtc6FgFcze27uxhlH+vDPoJgMMaARzMiGG0d75/b61fg37I3bZx0fqmiwvjEFFELQ
         gfIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWE/oMlTgJvMnMh3Jwrku1MV6XkxZrDOGTB6E5cV+urgXNCjCbtuWsHtTn7zCu8naDqV7vsAw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzNdgWa1wrfcLcUiaKxfIkAY8tV/HycIQNcGzXUbd8yCDtfJLX8
	TjguiqtlyvjiYdlYSFAQT648mO6ZQfuSvaE6OK3q6lZ88TQmXJCR7oRoEU9TRJUmsJ+fmqUGYz1
	ex+gVzj26x0MuwiumtMzv3HTyzEkBnceniRlUmV1bew==
X-Gm-Gg: ATEYQzzUP6zNQhwkOKGpC+ASYIKDdeWfV2WrHpSRTWvjYtEKBZqH9Kpw8gASt5UO8/b
	OaJIy/PV5/auwD2kLucD5CPOfglpa8yW2aFNUmXdguYac25D8APq+wuE520wSgruaj8sQMxwKns
	yXR1Bzq6EbF0dql1+7ksArtFukwBEEw0SEUYhypNpIJP9GYBks+M/NOf3IztRHuhqx9z9vD9U6e
	E8iPHX5rvftfc4Iw1wT3RGzQYqwB4wGXmmlkwyYd6ljcWxuzTg12V3K4wZi8cn10fvFIdjjutDR
	3IgXO292Wr2waEcKRHiNZCvFQk2P1bmW0FH8aw==
X-Received: by 2002:a05:6402:4348:b0:667:a5a4:6f9e with SMTP id
 4fb4d7f45d1cf-66a340afccbmr567400a12.13.1774292495934; Mon, 23 Mar 2026
 12:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260321143642.166313-1-oskar@gerlicz.space> <CA+CK2bAfPSKfV=_Sw20oqF56+H3a4k3x+47i6-EUK8mLV-i2+A@mail.gmail.com>
In-Reply-To: <CA+CK2bAfPSKfV=_Sw20oqF56+H3a4k3x+47i6-EUK8mLV-i2+A@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 23 Mar 2026 15:00:59 -0400
X-Gm-Features: AQROBzDtETpQsj-AecoLaywrsY7V3QWBPfaBQyfivtfzpdS2l3t8Zk-_O4mTPN0
Message-ID: <CA+CK2bC8o2p_poLb0yfp6mAAwR42Vg_99Yh_HLK1iJZrCrsVig@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] liveupdate: block outgoing session updates during reboot
To: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
Cc: Mike Rapoport <rppt@kernel.org>, Baoquan He <bhe@redhat.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260323_120138_314522_75FDB55F 
X-CRM114-Status: GOOD (  29.41  )
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

On Sat, Mar 21, 2026 at 6:28=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Sat, Mar 21, 2026 at 10:38=E2=80=AFAM Oskar Gerlicz Kowalczuk
> <oskar@gerlicz.space> wrote:
> >
> > kernel_kexec() serializes outgoing sessions before the reboot path
> > freezes tasks, so close() and session ioctls can still mutate a
> > session while handover state is being prepared. The original v2 code
> > also let incoming lookups keep a bare session pointer after dropping
> > the list lock.
> >
> > That leaves two correctness problems in the reboot path: outgoing state
> > can change after serialization starts, and incoming sessions can be
> > freed while another thread still holds a pointer to them.
> >
> > Add refcounted session lifetime management, track in-flight outgoing
> > close() paths with an atomic closing counter, and make serialization
> > wait for closing to drain before setting rebooting. Reject phase-invali=
d
> > ioctls, keep incoming release on a common cleanup path, and make the
> > release wait freezable without spinning.
> >
> > Fixes: fc5acd5c89fe ("liveupdate: block outgoing session updates during=
 reboot")
> > Signed-off-by: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
> > ---
> >  kernel/liveupdate/luo_internal.h |  12 +-
> >  kernel/liveupdate/luo_session.c  | 236 +++++++++++++++++++++++++++----
> >  2 files changed, 221 insertions(+), 27 deletions(-)
>
> Hi Oskar,
>
> Thank you for sending this series and finding these bugs in LUO. I
> agree with Andrew that a cover letter would help to understand the
> summary of the overall effort.
>
> I have not reviewed the other patches yet, but for this patch, my
> understanding is that it solves two specific races during reboot()
> syscalls: session closure after serialization, and the addition of new
> sessions or preserving new files after serialization.
>
> Given that KHO is now stateless, and liveupdate_reboot() is
> specifically placed at the last point where we can still return an
> error to userspace, we should simply return an error if a userspace is
> doing something unexpected.
>
> Instead of creating a new state machine, let's just reuse the file
> references and simply take them for each session at the beginning of
> serialization. This ensures that no session closes will happen later.
> For file preservation and session addition, we can block them by
> simply adding a new boolean.
>
> Please take a look at the two patches below and see if this approach
> would work. It is a much smaller change compared to the proposed state
> machine in this patch.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/tatashin/linux.git/log/?h=
=3Dluo-reboot-sync/rfc/1

Oskar, I made a few more changes to avoid returning an error if
get_file_active() fails. This prevents a race condition where the user
might call close(session_fd) right before calling reboot(). I
force-updated the above branch. Please let me know if you want to take
these changes and use them to in the next version.

Pasha

