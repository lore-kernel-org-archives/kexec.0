Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F7F606A31C
	for <kexec@archiver.kernel.org>; Mon,  9 Nov 2026 12:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wp20TFat;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=HXEE92jx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=RRwJGffnxpRMl008HsscyREvqQYCgJotMlfMjD+LKCw=; b=wp20TFatFZuqgM
	VmFmNyGJ9mCW4J6Z5v3+6sk7w6ZHggHSRfWu+l0mo/La5604MTY7/CbjPFXBBbfsO+bplmP50fcq7
	cBU501p9iH1aNZBhiXgW41Qf1PVj38TSF/wkmZAsHqNWO3CxWAJ82HPmUHNo8XMGL/CODVxQhfLG1
	ttLLjJHz0luJnOU/+3+3xCqJi00RmIrQ0qGeO6E7Gh9We8FOD2wRJ6zFiLUeSfNTAXlEJrNnb8f5s
	RYu1ID3By+4zhV9VkG9bvSQ61orx1pF2lNFz2WFm11VXTzTbFnI2b4fqU0FPda5i0BISim4naPTdH
	LTtqjzgpVunbe2SKdovg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQOrq-00000000kYo-28Ll;
	Mon, 09 Nov 2026 12:52:58 +0000
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQOro-00000000kYD-1DxE
	for kexec@lists.infradead.org;
	Mon, 09 Nov 2026 12:52:57 +0000
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-99911ead46dso412690241.1
        for <kexec@lists.infradead.org>; Mon, 09 Nov 2026 04:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794228774; x=1794833574; darn=lists.infradead.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RRwJGffnxpRMl008HsscyREvqQYCgJotMlfMjD+LKCw=;
        b=HXEE92jxB2brYw1cfz8XCSvUutcryAAYtlrNgeAXKXfECLZce7bfM8umryiBirjDis
         36yCUjowqIPsrzY9qS80p1MFd6uZyP5+WBQJTD2DykimYuz+LqBruT19TA981DgYz5tr
         7/a3fZl30jskk84AmyFYqO3jJCJ39eZ67bzdFxw4GfRHzxd+TIpZHktr88/qq/W6gBGQ
         Pd+H/NsHLGjSOYFjYrqxV5lWHSFOQCHicYfE4VcAfESTokxYMHdu4xrQydRrcmmA7Ftm
         mRadLhHIeVnv66/k0/kdb+4zrffUblV+Er8dvlWrwnLKX/DOW/c0pXjqmaMQZN9C+6AA
         Xasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794228774; x=1794833574;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RRwJGffnxpRMl008HsscyREvqQYCgJotMlfMjD+LKCw=;
        b=TPucCjZ3CuPYOHyiAC6cMKi1L6y+x5/jjH9fvjJ9mEKlJkStB9cHBlhVTbnBanho+o
         XKQcldrBl8M4OEOHj/9iyjwWuiosQnZtu+zCrWtLTtfKm1aD0XRBzNGuWTYN+EdXqbQd
         1NahipeWSQgyrfrSVdIq6/zHqbZ7nsy003MRdtMDIV+LaxtD2b378uAPlo3JjpQLRZ5B
         noy5NIYSxt31IqI1rg3JHycLvGAnkDVkAWO8v/XxUFBXQyTqWOh8nSh06z4Fa+ICSb1Q
         26f2TVtGQCi4BYugFi1SQcyVRAECefuPql8bvLNKLbZtuWMYyIOv0UD8imygFQwUjhwJ
         6Xyw==
X-Gm-Message-State: APuU4Z9JgEtnRcdVbyK2ifzjOI4HM8rcNtvyMw1mDbb195nly/t9K69e
	Qd9aYXNVQyx3o02kH0c0zs5VF40DA/NvcEnCa8wxuWhYEoJTl60O+/lVHfSh4MkcWPs=
X-Gm-Gg: AYBFou31jYHa1XaoknkXFBzCITTFy9Aq5VY8I9zRdL/UxYIj3udjUG2eAEfYI0uR76a
	5GrIa8NxllSw7jzat20BEToHrCmOpGjmTmR0PPnCzy+GUZbFr7sQBgIROTMtVJbFD8wxrzcgEQ8
	PLfynLCp0DRiLT9AXYHjbrhxw57oF1F/zJ9ajfcUD8g59BLHXFJbStRCHlA3yvHx4l5oNVigEP3
	aF3qgwMRFOB2KzGfzmiGbF7PsX7YHno3/bdP01AP91iw4gzOdEkSvoAygfrCnz+RdmSP42pZpQ1
	Jwt7+Im2EtavgoNKwxS3sSvH2Q0R7nVHyBphiHfpIUpyAd6d8+pzO3KLtxi6FyWCBdjtV4Cl31b
	te95iBp1i7ULityIsuWosHi6IecOpPkubUiDdD37SE7B9jag8BoC7YPnS8jCXeHd3YjYeO4aHUK
	yY3c/duKjEJy07x68WG/m3qwahWB2ZMTTz0MXZr8gzsHxO/YMR5KAab0AaF8fncOqelt4qGuvix
	7hziszZmagR0mLA4txMuc1A/elhe3C7ud+NvwtYSlHQZ5V7RXpkHlpqGbpscr+X6mbPQbkbVliZ
	LzhesTEsCrF/mOINRwyfaM1VVrJVZGo1LUt/lCFRs6pY2balEXzvXE+Aa9Ti8HV0y1I/rEFkxid
	l1eB8IjrsKozx0GTltwcvtOs9onoJIg4=
X-Received: by 2002:a05:6102:2922:b0:7c0:c6e3:3b88 with SMTP id ada2fe7eead31-7d2db26479dmr956481137.28.1794228774214;
        Mon, 09 Nov 2026 04:52:54 -0800 (PST)
Received: from localhost (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c029dc215sm3420373241.5.2026.11.09.04.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 04:52:53 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Nov 2026 07:52:53 -0500
Message-Id: <DMQP0NDPOIFU.2OTZQS1GIHIZG@soleen.com>
Cc: <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove myself as a kdump reviewer
From: "Pasha Tatashin" <pasha.tatashin@soleen.com>
To: "Dave Young" <ruirui.yang@linux.dev>, <akpm@linux-foundation.org>,
 <baoquan.he@linux.dev>
X-Mailer: aerc 0.22.0-39-g5d7784875be2
References: <avFSU0f0aE-amdls@darkstar>
In-Reply-To: <avFSU0f0aE-amdls@darkstar>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_045256_368600_93BF1894 
X-CRM114-Status: GOOD (  13.67  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun Nov 8, 2026 at 11:55 PM EST, Dave Young wrote:
> I do not have enough time to review kernel patches though I still
> accasinally scanning the patches. Drop myself from the reviwer list.
>
> Signed-off-by: Dave Young <ruirui.yang@linux.dev>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0e9fe9c2a39b..7e18fe93d4f9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14145,7 +14145,6 @@ M:	Baoquan He <baoquan.he@linux.dev>
>  M:	Mike Rapoport <rppt@kernel.org>
>  M:	Pasha Tatashin <pasha.tatashin@soleen.com>
>  M:	Pratyush Yadav <pratyush@kernel.org>
> -R:	Dave Young <ruirui.yang@linux.dev>
>  L:	kexec@lists.infradead.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.gi=
t

Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>=20

--=20
Pasha


