Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04717C5AD7B
	for <kexec@archiver.kernel.org>; Tue, 11 Aug 2026 05:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1U4C7aa6hlRlxc8VgQ9o9mfmkNC5txByo1x4mRrukHU=; b=G0KgpcVjg4VEGIRG988kVUBDTX
	d/O6b+s2cXO3wZBYa49tc9ZLLU52CjXUa81/oua/mJVk7BOmpJhzk0GMjAVb7Z9U+T080JjByR/42
	w1a82QqBxzhwvgHrt4LuSdqo8MStk1ahi4l0pGl2ESaRDtATkJ6EnTwIar+9P/Dj8ErRfpk/74zlY
	xlufVEOGs1T/xwlqD/O+u29nEYP6yXu5K8aL51bdSE3nbrptZDARcFH4559xOC7X7CR1e865H2+cn
	9DqFKNHnTpydFhaMFqUJL2O6jQOabsrsPRK4ca+QQDquqXOrd2bONwyk8DFHyAv0/xA6W+jZudkCY
	Ppd4svwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtfWJ-0000000DM8f-3DBy;
	Tue, 11 Aug 2026 05:59:27 +0000
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtfWH-0000000DM86-2ws9
	for kexec@lists.infradead.org;
	Tue, 11 Aug 2026 05:59:27 +0000
Received: by mail-yx1-xb12c.google.com with SMTP id 956f58d0204a3-66898920476so268753d50.3
        for <kexec@lists.infradead.org>; Mon, 10 Aug 2026 22:59:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786427964; cv=none;
        d=google.com; s=arc-20260327;
        b=HYUPoxuZUkY4SpsBpovq6TxYFf96OlcGBXbj2cRLvlUlm15gPT/kQt9x4ArRGJ/hPI
         c0fj9rAqdVS/luo26HYVss3OsxwYf1JqoQklCHXXB+OEvdm3k7gLLTxStVq4JbadKNWN
         En3dU3VTKCgBv+D96eC5Tam2tjZ+d2V1iHnlxH76WE3QA7KtfHDmw9LTkF1iKEjIotDs
         /VS/D1a6vHkgaLbobJhucEZA91AjBvawHnPTCWumBDey0dSkbH13Z3Hb1KfukgWQnAsf
         sYNLsQN2seVM0mh5ESHnuAd6PT1cJKYF4vQu7F16JcJyR+m1Cud2pdeoOxl9ibDSYFcZ
         qe7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1U4C7aa6hlRlxc8VgQ9o9mfmkNC5txByo1x4mRrukHU=;
        fh=XX/suAkw+BxqaAEZ1LReaLjRbwqyQ/QNHiWsFn5Ablw=;
        b=OuIHRDAnrw/PLgkNQoFvewlFhHGO1Ox5k4aEgB3MmLttTvJ5aj1OJ/IT5DVE7oOaFA
         o7EcPaHevMsgqLPktWXohdhJLhGHS4/Y2MYLCBDMO4sTt9lNvO8OXjzsqKDRxZC+bbWY
         h6aAQVYSDr4VKQbr5rl0nMghSXqHZ441RfU13slj8irDsSUmIs02r63BreTYohpXVooc
         bhVIojX4QlDUWbqYuZll+lDT9iBNNZ1yor+d2+gNscF2Dfn79rO7moEReEHUe7VhElUT
         xpkxgjbfjs8brEQMSdJf03mtW6cdzVEXc3SNiJRhziUuFlHGCqOm6Qm+Nz00dzLkz+al
         NEog==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786427964; x=1787032764; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1U4C7aa6hlRlxc8VgQ9o9mfmkNC5txByo1x4mRrukHU=;
        b=nN1cgPMCgZcO7/wGSaOehFLDhTbjXEK85A2GSYvVYYHeU5L6YcC3C+n/e9YCbDxEvh
         3gu8ULsPSE9hqb8qhzk2tjy+usfEohtvy13vJEeH39SY9JuQnwx52ZLYbquvGe7fwao2
         LChsiTEoB9IPevDUyIZkqDciLv2QZehNdvpo72rssXGqn3eAbmWElPtrWogVcx824xkM
         HUkI1ZcmFt3+jzNi7ZcU9oU2quij1DwjlXH0gYgbVv4gYx4bP8leUh6zHSaTgz/kmy5N
         qZp4emP5q7PK++IfA2sQe1dzXmbJNEko0msqw8vKxctYcwgmPs2MqB8neER3l50USZEW
         6lsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786427964; x=1787032764;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1U4C7aa6hlRlxc8VgQ9o9mfmkNC5txByo1x4mRrukHU=;
        b=A2pVs41bh8urOWDb8qr77YkyTpkH8lSyBKv9d/qbHqyNZ/boxpdOWxKPaJezaEu3BA
         lnUDEzaZqL/PLd1XDrAEPuWIS2mlgFsuZzdzThAr1HWx637RI6jVmH5WRf/O9V1BpsBd
         79jnQagaJoVdbTV348DUG9D6I8kgccmbU6/1J4gAFNeG0seuSxzJp6BeCdk3FPXMBScZ
         7fYXDbpXDtIdkvkOAvnG/2kMXMJT9iJZAQsEcmIMyXmmRbMyZzKQSRH8e+Z+ur2Z5IfL
         Js13lf5f0jXqI7b9wknJDJ8GBI6EQLZ/bboskidkah5kNoa41M4iE6W2VuoWUTBhsxV8
         t22w==
X-Forwarded-Encrypted: i=1; AHgh+Rqb2T3DyT8o1WUqpqMay3youJ3MOhT8hkKpejlLEbA4OPg++0Q4xqCIp6WIyWzzgtQc+sjuHg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxhqLz3mEioIlOuXdwHeFEKDlUsxJ9X73uc3EVMZVROSg3V2x8f
	AD0f6maVgg8W5htummZ79lc+fSXW5LGFixy5OHk5w4mHj+0CI7CsZEvw3HNsS9adstPm+qan+iQ
	w7Esthb46m/vzEHSPyNI+2wdJFgi1T1Cs3JjhGRs=
X-Gm-Gg: AR+sD11TUWQNr+gvYK1V8yqq3VxI7Re56FgWcrUiRaqucgdnke6XBjVJ6Si+od0rEK8
	COgQKU3Ss8w610Dx7NUIsFeIPfMFN4nHHb6zGunLcwXMCy9mEAL0vdP721bDnRSZkx3el8MU6hH
	8zrrF3U0lxRbMsZYeNsNYBkJ+6RtswD758dzH4EP6sm0b9wZwpk0cvXrRTjVZuILeqzcWzVxJ3f
	TLbj34OEEd0Ckxs0pFo7n2qvGhxW3FWvlSubi1hQi0TfMDerU8gYMYc8w+YNOTGm8ScWaekGhvD
	cegveVYrUkoIh4InEPj/Hx8LeRm/G+idJxjRlGiecl7S7RtWoeKWp4eZLqcdxsK6NjRTL7r3odj
	UTLcLtv9rVsQ56w7taL/4WKAzCT4/KduwkmyJoiQb8RPJKAnPeG93RNCKbMo=
X-Received: by 2002:a05:690c:e3cb:b0:7ba:f0d0:5e9b with SMTP id
 00721157ae682-82f2a23c205mr3831507b3.2.1786427964217; Mon, 10 Aug 2026
 22:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260806100543.138902-3-giorgitchankvetadze1997@gmail.com> <2vxz5x1h6eqs.fsf@kernel.org>
In-Reply-To: <2vxz5x1h6eqs.fsf@kernel.org>
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Date: Tue, 11 Aug 2026 09:59:13 +0400
X-Gm-Features: AUfX_mzCRqYoBKGa8DDL-lqpnRc6U3cbNHCT5o2avTyr_B3psZ5m3uL7vd5nGsI
Message-ID: <CAE7dp2r4ky6mcJeBEoE7ELW58Zvtu57+13dLYNr72tZ-UhsYBg@mail.gmail.com>
Subject: Re: [PATCH] mm/memfd_luo: use real folio index in retrieve error logs
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	"open list:LIVE UPDATE" <kexec@lists.infradead.org>, 
	"open list:LIVE UPDATE" <linux-kernel@vger.kernel.org>, 
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, Giorgi Tchankvetadze <giorgi@tchankvetadze.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260810_225925_746312_1D3A305B 
X-CRM114-Status: UNSURE (   6.87  )
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

On Mon, Aug 10, 2026 at 9:56=E2=80=AFPM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
>
> Why the cast here? u64 is always printed by %llu. See
> Documentation/core-api/printk-formats.rst.
>

Wow, the cast really is unnecessary. Thanks, I'll drop it.

