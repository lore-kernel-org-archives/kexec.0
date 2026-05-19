Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B77CD4F5B
	for <kexec@archiver.kernel.org>; Tue, 19 May 2026 12:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G8XxVjNnm7f5AMUl/j6BlpwBrqGpV03f/LRUGTJZ+9E=; b=ZMLIUvO94qu8Bf7abGzodeoE9a
	JXpjIL8RDwO7qpVCtEfhvNa5j+TlqphRzWDVLna46PJC4RpVTrn0qiS5UTBqU7Sl+p2pzpgqPGPeA
	bjdOuMmbzhn0i9HmxC9KwEdR0LE11jPrvxWa9X3hOBqQslCB/Wy0cIwTb+hxaf6dqiBbe26TF3FrJ
	WDGqvai3dAZ4hmVoiGgE1qXd0IlplqaE+KluCYCQwZdlCqtriASKZs0iD0fP6QgKIH/BvEAu27W4Y
	7zXNWGcCqos6NIhDz6KN7fjXHkUsalp6Wy4P+gx/ucG7Cves5EYiZWSxkpNkp7avXwMUWDgTfvzRb
	PJ9KW2WQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPK2O-00000001ZFQ-3qKX;
	Tue, 19 May 2026 12:59:08 +0000
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPK2M-00000001ZEr-2uzk
	for kexec@lists.infradead.org;
	Tue, 19 May 2026 12:59:08 +0000
Received: by mail-yx1-xb12c.google.com with SMTP id 956f58d0204a3-65dead17c24so3212974d50.2
        for <kexec@lists.infradead.org>; Tue, 19 May 2026 05:59:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779195545; cv=none;
        d=google.com; s=arc-20240605;
        b=Khn9Bi4bTFj5QJN/mErk3fZVyDBmWoDLPyQk7Ci+CxlbW6/QlYSCwo97/x+F7AwV9L
         QTs49QktnvvcbZkgHfkcCyVGzfxNRbU5c/vS8GV9YuF0zqS6tqQI8i3pExJq3cM3N9Dw
         GgNr7rW1wByw8NDfKFtNh9np2qJj5jcqdta6wGlKDHr3EL602J22Q3uF3HskSRqRboEj
         NoS4kr7VA7WZ42KEBKgTKFsz3RLkSCPyKdgcKBh9pVaPqr+xik5lrWVfub/pnCffEZ5N
         Tp9s8sZfeARL0NMa3N3ePKXjab93C9euagr0JdV9ZhKZiOhON68H1RZe1pL+0An7/Z1G
         jAmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=G8XxVjNnm7f5AMUl/j6BlpwBrqGpV03f/LRUGTJZ+9E=;
        fh=vegLnzQxlKJMwPtF/lUijbw+wkNkQjSCvbKxPKdb4Xg=;
        b=i3iVd1MtvKUzt4cuvLsyO4r+gDLoYRn8mkOu62QGi9HvPAsU3yKii1ybkHxAUfhe7d
         nDuBfSzDRBCVvEvIRlSC/t86K7pRa8u0w64hpgu7sDHha4WMmRyIUTZYBjtyPlSJ71e8
         8hhoel1iaxvVLYj7G1tR0XubI13zeYU2lvvvc+q3L7ufly4rgNg6+3vtR5YCt8O/jam+
         sQl49hyJTPT7oltcaX8k2hN667T5SOT2AFK4O/paQdCK1CohLMuoCpkwp/Lit7dsh1rR
         f5ONRlw089NPerOXvVei5B8yDtqgAgZOZ+DJc5VrSrTdzPLcVL6SO7lP92NirchbtlNy
         7gcw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779195545; x=1779800345; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G8XxVjNnm7f5AMUl/j6BlpwBrqGpV03f/LRUGTJZ+9E=;
        b=P/L2pEPHf+ascc+tFCs10aVTMw65uGHOLnhEebqaUu6EkWAuV6pT/ycEz6aI8kj01Q
         SasecPFutW+5JKrdpqm1mKJvCaFsFhONMOyejajngxrBV25Zu+lF2W3xEtlwjeNtOYQo
         lyLhIVU02sM4ti+VMrnXhTZVTNIWFIqHiE7MBvUym2C1CozntjraHqRlYT9N27iOf2d8
         /Z0AC/0yyI06XCkd3rbGmJrhci8VvJ1z4vtxWfXuN4J7/zY/6s//3FLoNyYIcTTLxv5S
         ib65DTG+Z23FqfeglUF42KbnCLT8aKK9y7RcaFZMGQMGN5J1Wfa2laHD93E25c3XNSlg
         xoFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779195545; x=1779800345;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8XxVjNnm7f5AMUl/j6BlpwBrqGpV03f/LRUGTJZ+9E=;
        b=tDpw8k9y4WVpxemZosumLWM3s5SnliZ1XgSpr3ucmI7u37L7RWzz4s1ooDyJ7ysnPD
         RPYJ3Y8CPBK/z5+zNFNBQZnJ6Xnq4lS/SBxFy65NEx8Z/1XHAoTmnCtuczP1hp7s63mU
         c87CsAEGOVtxvzMzuCWwKysxuK+Y2EewgjYRLreyBzagBfiAmWoZa+g7q43FXGcVJvCz
         9WMX1+YzqcTfucqfK+zRnIP1vFd69DENPAnUJgMvZj0j0NAZih7cwOABiwmzAJxbjqPf
         6ekJsRDsv0vKuQoBFuaWgxP0PmXFkDOd5k6BDDq+/HBAEUe4EUe/d7pG6law0+gFQ5Bz
         IBSw==
X-Forwarded-Encrypted: i=1; AFNElJ/ugNlGHKSIHPM6DVCDo4SBrr8gGLA+aUC+aE+jRv6w7CSoD5IizbRcf1yF8EZvhi6BwvdHGw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw6Mrdo6XDDiJG3i/mNVJOxtln+cpNU8LyihG+ipmknopJGnRue
	lifCbLfE5hH/RGDdvlWgWGk3j6yTadM9TU9e90n/umOLVNU7cAKb9aWzcxVtQGtMjwzTjABTnli
	QMN78+Mn7EBGfmoplqdKohfrg5c6BlIc=
X-Gm-Gg: Acq92OHReIBUnz3ipRP0l2q6piVJ8Y+0O9tcK5C7qieblnNn3Fugcjz7X9z7UNd1uND
	mhQpQRd0wmWHFl84uqpNRDJbEeW7WIxFpB30/FYIYT5CrUEHsV9btBkiiz6elTbG5qBg95KE4I7
	6g9G8OmSsZngwShftPFvpSW12snHZ3foA5GC9NQoxi6UcFaB7uhvEHxs4vYu6H3vgsTnr0+xVcT
	LHu2gVJjO4KQSLIoPrpgZGoQR+fa5DtfxRS59wYhBzHcN1hicbsMgLygXHG/TAdw0WphwtFF4Qj
	KkyUPACUHo53kau+YbOucrY7pLDDJWTKrKSy8KXxPG1gVWbV73C2rwxev2OUvK4=
X-Received: by 2002:a05:690e:1442:b0:651:ccc1:b4f1 with SMTP id
 956f58d0204a3-65e2261a440mr19937704d50.2.1779195545221; Tue, 19 May 2026
 05:59:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260519125714.2435640-1-pratyush@kernel.org>
In-Reply-To: <20260519125714.2435640-1-pratyush@kernel.org>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Tue, 19 May 2026 13:58:53 +0100
X-Gm-Features: AVHnY4KZP5LxSAGhJdo5NjwgIgRGcQH4ac7CzTxS8cwS1VoU10GwA76yTE3deEI
Message-ID: <CAMw=ZnTotDOXfh=9zHtdRpyt9QRSQ+y=c1N+U1=f1wdzOtJzig@mail.gmail.com>
Subject: Re: [PATCH] liveupdate: document liveupdate=on
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_055906_742114_4078493B 
X-CRM114-Status: GOOD (  14.27  )
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

On Tue, 19 May 2026 at 13:57, Pratyush Yadav <pratyush@kernel.org> wrote:
>
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
>
> While the liveupdate= parameter is documented in kernel-parameters.txt,
> it is not listed in LUO's user facing documentation. This can make it
> hard for users to figure out how to enable the subsystem, since enabling
> just the config isn't enough.
>
> Note the need for the kernel parameter in LUO core documentation, which
> gets exported to Documentation/core-api/liveupdate.rst.
>
> Suggested-by: Luca Boccassi <luca.boccassi@gmail.com>
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> ---
>
> Notes:
>     I think we should take this patch through the liveupdate/fixes branch.
>
>  kernel/liveupdate/luo_core.c | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Luca Boccassi <luca.boccassi@gmail.com>

