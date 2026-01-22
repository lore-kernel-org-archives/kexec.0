Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D22D6CFA3
	for <kexec@archiver.kernel.org>; Thu, 22 Jan 2026 19:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s7keTxLfsvNLS0EPh8K9+DpG6jqqIVhJos6SbOQ9CV0=; b=VTKaB5PgxHxL/pJl1h9cEvb+7X
	O+yGh7k5zAKk2agvjR9vAUM70nmGvATCs1qDX5c6/jryvt8ZrtRzi53w3qsEKAGvpckFqOo+RiUNK
	GoMq0UlGj/UnWnRI0MiZBugK10/3KHQ54nQqBf7zHCJ4H6MFmNO57+Zm6fzcJYO9QvupnfSq559Yw
	J06O3MUCWr0U17xBzfO4QIryHxRD3IthMWhp+rbIN9e0DDu8AoeQf6j/JmLOi6AaZIj5w5w4bYnfI
	Uqtp2uj7UC7xQeySiWR0Fs66fFYCeG+6fuZqu46ePFqb8ya/kTzT4AIF+xtHSr/Dm6ybNXPyAMbWg
	LDOBaF6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vj06D-00000007gV5-2dlT;
	Thu, 22 Jan 2026 19:12:09 +0000
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vj06B-00000007gUY-3G35
	for kexec@lists.infradead.org;
	Thu, 22 Jan 2026 19:12:08 +0000
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-6582e8831aeso2039897a12.1
        for <kexec@lists.infradead.org>; Thu, 22 Jan 2026 11:12:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769109126; cv=none;
        d=google.com; s=arc-20240605;
        b=UsA5FVUKl9OZNGb3FZ6iwC+F6BvtvGC1jf5Pa0Je2VM1lfSKxwsUmUodA89jB0Gc2M
         YpMsaJ3YM9jwPpzppARQjofeU+8xWUtDQpruUUYT3boF7olOz8B1mXjcCSsiHis4x3Zk
         fRdCdW6KL8JqkhbT1tyqzAA0QkQoD2Z1Nrf6b9B5sOBx70tNz64U/2wGb9e5DLnuI691
         w4rbcEwQUUyK2YehAV3NIsQ7jPx5jNBKPe35QSPjXWC6BKeoOhvLhpbSu6jjbAKI1low
         1jTkKGZ3Ocp+qbtOljcTBE1IN13AMIhJ4AG500Zd3sdcg3V6QtfUQemBb7hlEacpK1xC
         cLdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s7keTxLfsvNLS0EPh8K9+DpG6jqqIVhJos6SbOQ9CV0=;
        fh=+EaPFZDKkXmSSBa6fC6h21JTiZ3o3XgrK7GlFNP9rQ8=;
        b=Ni0ghza7koOYutfF9WwECLKb+GbhNp/rzyhD5FhKHlOJiuKx32avzBwJ/k52S2jjd5
         enRTUd7GGy7WmQvtschOUp7uQ4o6nauIkVw4xauFp3TXSaBp9AhHmwhU+ddleCVZYvp/
         xCGlV7/rAQk6TK/xLIUa7urmT9CXui1XuagNE73VKQ3g54X++5EfWBU7q+xgq66vC8DH
         4eZp6Bj/rCV2JwU0vu0NdO+tFXDhvgGPd8UP6lEOpKqXp0bXF8SzHrNKRn3MLgtVzp7w
         yROWdSZHCpPZYxiY2BA0jCJwOzW/4Y7sJmSvBjb9bmfkqZjrnHU8P/q0HIo2zMO6E0f3
         gafw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1769109126; x=1769713926; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7keTxLfsvNLS0EPh8K9+DpG6jqqIVhJos6SbOQ9CV0=;
        b=RH8MQOKVLIlwZNG1c6B9LY1gl97AoTh27JmACVrNCHzs+EIsOoJ+IGGnlQFi+6Nes0
         CAdjjfJhc54nif/KMSfhwEOouUWON0KXgTL+cLDjqLpII/1iDhQHdytfFMAWEjOwnuUr
         sNyMd36gKfK7F1MXIrufmISuwOY9Io/lZUoZYAt+Ms2FR3L40GbE9OXlbxqvUGjz6Xrx
         jJzq6fV67J0SHgiUFtuodYU16F/b7DgMe4z0/85I4IvaDvMKooUWoOXSvP3xlpgfTF3G
         Rg1g+kLH8Uo9CfFZyHE7y1ksDydd5MyIi1jqUoFlg8aEY7iUSxrF3WsJvlj5pMY7dBBe
         9Dsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769109126; x=1769713926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s7keTxLfsvNLS0EPh8K9+DpG6jqqIVhJos6SbOQ9CV0=;
        b=TwDSTJXwSqm/SjcgUYf6opl3daZd0xHvyXVDN71UX0j+HhjzMXFUie3tta93Gm65dd
         ZjaY7Cq+WXdmYnru1qX/S0RhDtPbN2aRAAMi5BAQkAMgMKq+Q77Nm1Wn+nheg0eHFsI+
         yFOK9dwnDczN6A70Tm2emy9Ymd5L0YLiETwHo9wmgEx9N3Sm9n8naDZYZLey+6SwAs8E
         rVYwVMSVhZQOgOhcmOGMd04qUL04FTCZf0BoI3Jt1QlSyP+Ne87mmTHE/5lYoIRYcZmW
         WUyK/yXkBybhIYgphPHuUL1K4JMSPJYn0917q4gIjAbSlhu0ZNQxVvx4+dw3KF9tqBrg
         h7Fw==
X-Forwarded-Encrypted: i=1; AJvYcCUe7DZeNjSY8x0YnbLNLIWlt2sO72yDsl+RDrB2biwbljZaqpA0rEjswLFQMVvRqXjk4HRgbw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwWq4ATZEaBdYRiGTh94ocDBT7tPh2Fuvw44PuhWp6AnHAkmr0c
	XiFP3PvCGSJbFPZgsgsZksYuBcaZ6TfT5xnQefcm2bQ0M8xQ09hWYbQSOEblyjCbeuB6ipMnHRI
	kDO2WX0hirdBjDHIICeweH6dJqI6AwimazUpjv0Euaw==
X-Gm-Gg: AZuq6aLz+vCM4E+S2T0npbWk6JNxqYhdd8W9q34qWtwERWP/YToOww55zQrOUMkHhbL
	bk1LP0fBVcbnZXnUAhpbGssHdAcBp860M7upDHq/lUY9UbiXXNsCzlxOhaBteyMky/FSH2LD0gS
	I++mSaf2qcWeLhAFvKw9xNL1nBVpDGnTGF7Y5f105FgZfRczWBBqVgOvdl0i20APWb+8J6Z5pyT
	mfy2dDLpoXkoyKRkEkzFgWaLiIWIGLrS2+ay+K1N3dkyrAgoD6PNKK9cEJXc6M+6mnKOA2PRU6+
	7GjwFkomcX1qzcOdKCgOTJ8WiA==
X-Received: by 2002:a05:6402:3647:b0:658:2ee0:66a8 with SMTP id
 4fb4d7f45d1cf-658487a11ffmr332902a12.18.1769109125806; Thu, 22 Jan 2026
 11:12:05 -0800 (PST)
MIME-Version: 1.0
References: <20260116112217.915803-1-pratyush@kernel.org> <20260116112217.915803-3-pratyush@kernel.org>
In-Reply-To: <20260116112217.915803-3-pratyush@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 22 Jan 2026 14:11:27 -0500
X-Gm-Features: AZwV_QgAlu9tv78e6zZyKDfrOb0ic14yXrXnuRshKsxxfWgKKxJ9Gk9Gedsce3w
Message-ID: <CA+CK2bCTT5Chn+i0ZxDBsn2WwZTx0qC0q-2PbkW+4xSbQa=GOg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kho: simplify page initialization in kho_restore_page()
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Graf <graf@amazon.com>, 
	Mike Rapoport <rppt@kernel.org>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260122_111207_835380_E8758C38 
X-CRM114-Status: GOOD (  12.59  )
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

On Fri, Jan 16, 2026 at 6:22=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> When restoring a page (from kho_restore_pages()) or folio (from
> kho_restore_folio()), KHO must initialize the struct page. The
> initialization differs slightly depending on if a folio is requested or
> a set of 0-order pages is requested.
>
> Conceptually, it is quite simple to understand. When restoring 0-order
> pages, each page gets a refcount of 1 and that's it. When restoring a
> folio, head page gets a refcount of 1 and tail pages get 0.
>
> kho_restore_page() tries to combine the two separate initialization flow
> into one piece of code. While it works fine, it is more complicated to
> read than it needs to be. Make the code simpler by splitting the two
> initalization paths into two separate functions. This improves
> readability by clearly showing how each type must be initialized.
>
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>


Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

