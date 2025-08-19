Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72C0CA0EF5
	for <kexec@archiver.kernel.org>; Tue, 19 Aug 2025 20:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dsi3Ol1RzG4r4sd0Kpy+4154B/TF6SyP0rvG/u3iZjc=; b=tGY6v2CPvEUQqeh+KiXUXTmxpx
	RX4qrkb9+rtskx5EhXQnWdVKtp98zgzTnnp7oTORhuLWkd5hWeP2KC9G2X7kp1LTkJNuwONFo/T/3
	9DRlZkQtGAKcudtxO58XHWQE0pyWzk9JElv01Ae1QiJ5Iz7KRXnSCxYAQ6cG0EaQAYO23Dr8LoqSd
	mAFV1w49Syb9ZuZETfZ3UY9RRjoU4jmMPmiIVltjsTFe7v5QE0quTQJ8OYd/aMJ3YKedOEs9EaeUi
	A+OQRYOT/m6j42v0Nzkeb1YXXopGBMbTKTGUX9fvOJnPzzhQXS+4viE9EqEKZv29ZiB2lhnS7Ai3/
	1eFt/Mcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoTAU-0000000BYxB-1XFQ;
	Tue, 19 Aug 2025 20:42:54 +0000
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoRNn-0000000BKy9-2iVZ
	for kexec@lists.infradead.org;
	Tue, 19 Aug 2025 18:48:32 +0000
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-333f901b2d2so42858691fa.2
        for <kexec@lists.infradead.org>; Tue, 19 Aug 2025 11:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755629310; x=1756234110; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dsi3Ol1RzG4r4sd0Kpy+4154B/TF6SyP0rvG/u3iZjc=;
        b=QfZlTtAIHXz6jz/qlVohoe/ohZflOWPVMFAS+Ra63bOaSavKg0tHMUfAZcoqn5MJjH
         zU9T0bZYrAsLyJkCTK7L0hEUJzNRg1c2uDT7b4Qqt6tDTPjIH8IIjqJ20SPqWwkW4+qh
         0wXhFme5XOpR/qels77JGer+ugDh0a9b7SD9HmBImeZg8dPR4yfO6kWFYVYM8XkjXP99
         CW6SDLywwV0xkj5Pf2pjFUnHit1r3TPm7td1YR+IVmdEEzox4R+hQeetwiuC2eFgsmea
         90ABfwGYhY+Gx4m74h+zmkCn/qeYGbn2xYEvnFzfuw1P7RJT/JY+Vn59IFnQj30KI7fY
         IYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755629310; x=1756234110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dsi3Ol1RzG4r4sd0Kpy+4154B/TF6SyP0rvG/u3iZjc=;
        b=pr1D+J82E0QRrmqvWWlzSylrlubjgtzs3Fue4zaJhyU6tAtrWn2Oe5gwIQsIKEUwv4
         lDeUUMnWdr9vLiotpJBVQCKTThDUWHOaV1QC0WzwknMrdJw0mj1fjvlS8/WI4VC4L38n
         HBP52A00OWZ6vzoEznV6KtWsAROh+1qsTRS6ipRSDWiUH1YFYJVLrsJosQ14+/MCgCg0
         SJD97QHPrlgXvMgZIdn0M0UY8fBOfpjXJVKb/LDXb33j5VFFR58nf51p+Y7I8kNtZcue
         KSaFlnwH0erLdEv0rOtkLwzbC2+mqKzPfK6P1QoV88x8qgyYGKVoqr6aUZ89o28TuUjh
         SWng==
X-Forwarded-Encrypted: i=1; AJvYcCWajHBPGMTUj7gfO8z6nsBqRTrzBw5P+FohXYWwua2xCOa/imZZfS5+O5nRu20aD9C6hf5hSQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywt6DZof1qySjV8ZCOE0uufLIN9wU6rpxQonOdr/5OI24Ag1ewy
	fc/5IhUaVFrZbPbqSM7ModxIu0U72Ht/amW/kVlh000y9xlMmO0XQsSzD+ieInPBmGhna7a8hCb
	TTEke2wrodz0/8Y4RtkirKuZ4wDQIZxU=
X-Gm-Gg: ASbGncsPMku86LrsqxxkpvUrbpMJfEDjW2A0wivy+HZ6csF+HNpCkb5ZHADDoSvnLKK
	TOcireAqG6ULiF09Fsmt5CjrGMB4MU4rT4Ulctx1x8I1uSjOx4fofq4HZBe204oSFM2p5qZSvso
	e4ZcWOUMIp2nEQlLGO0m+q4o2K0gJ6tExqoZIjR4UE1Jfq/RRpTlRPgZL19ylnCA34ZSOwW6vgh
	EHbs2s=
X-Google-Smtp-Source: AGHT+IEtsUs/eItuWdqsiccKiHk/sQHy0fwuk6CgwXWzmcvur1Z4O/m7QutGNJewGYA8rdbw+E71pjCo+g6XzYZF+54=
X-Received: by 2002:a2e:b302:0:b0:332:4fb8:6660 with SMTP id
 38308e7fff4ca-3353bcec86dmr468581fa.25.1755629309584; Tue, 19 Aug 2025
 11:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250819090505.647690-1-safinaskar@zohomail.com> <20250819090505.647690-7-safinaskar@zohomail.com>
In-Reply-To: <20250819090505.647690-7-safinaskar@zohomail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 19 Aug 2025 21:47:53 +0300
X-Gm-Features: Ac12FXzDTNaNwT7jQzTMlLy3nWbTnFNq_eUyPpLS1LHOgK2q-Fl3UJP0Euq81Ds
Message-ID: <CAHp75Vdru_Hvpr2TnTQD2tFp2r0F=t0vNxP4jz5rq2=HoXDCJA@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] kexec/arch/arm64/crashdump-arm64.c: remove extra whitespace
To: Askar Safin <safinaskar@zohomail.com>
Cc: Simon Horman <horms@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_114831_683401_C6A98853 
X-CRM114-Status: UNSURE (   7.20  )
X-CRM114-Notice: Please train this message.
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

On Tue, Aug 19, 2025 at 12:06=E2=80=AFPM Askar Safin <safinaskar@zohomail.c=
om> wrote:
>
> Remove extra whitespace

In almost all commit messages you missed the trailing period in the sentenc=
e(s).

> Fixes: aecc554e7ba8 ("Correct string specifiers")
>

This blank line is wrongly located, it should be before the Fixes tag.

> Signed-off-by: Askar Safin <safinaskar@zohomail.com>


<BLANK LINE>
Fixes: ...
SoB: ...


--=20
With Best Regards,
Andy Shevchenko

