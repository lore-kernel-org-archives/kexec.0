Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA46CCD8C9D
	for <kexec@archiver.kernel.org>; Thu, 11 Jun 2026 18:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mAfkkS3+scBAS47m7nRCqu6b0ti3VWHtbY2WD+mN2LI=; b=t2jPa5oNmbUaQ4hq/hw47ik50c
	A+j1DeuqUBhUSOmWFAiWj5l84laAG/XTIZ2MnP0KkdmUID5mLkjBmuCByIRAB1dmc25uK7lE2BabN
	RmqbyrR9vaXWpho1qRvKPz4aPI+ZxhfFjLCnJGsG9IsHYfEYahJB5VlcoDcph7+JLhKXFXzbCqKEs
	MAFOZiBsE0GmYSniZggYT3ohjF8GzLgGg+SRd4s6qYdEqIPd9y/fVCI5h7X3qv/dSBwo1dw4jiLUy
	Tqh/g/KMHvk8FrwLAUrJnLGuCBg3j44HsBZJE1kgsebPNraQ31K0EXpV3XwjxTr205XyTemOoPtVy
	3zEUlv/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXjuc-00000009sbU-2PE5;
	Thu, 11 Jun 2026 18:13:54 +0000
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXjua-00000009saO-0Fvg
	for kexec@lists.infradead.org;
	Thu, 11 Jun 2026 18:13:53 +0000
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-8cceaa6f75bso2608036d6.0
        for <kexec@lists.infradead.org>; Thu, 11 Jun 2026 11:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1781201631; x=1781806431; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mAfkkS3+scBAS47m7nRCqu6b0ti3VWHtbY2WD+mN2LI=;
        b=T+OlEZW2XW5TQuOAFaB0mQZKTtOhptI+hcI3dEjHDW364LBahsVce3PbZMEufr9u+K
         jWl1A6jPm/akynPyW9AbQiP2rVw2Evj6SwOZlef8siObvmSoS27oZ1jRMl+r/fs77ww0
         ruwCveKVjuEvDV1GE20bnSHjG/dShg49/NNA/LnBDMnoUGIhtwf7VUdqVc3B4OWwJJGY
         UUT/06xg+ipyS7U/wRT1oKaDhhmEaEYrNrDGaurpMLhAdN+lnyrnl9DDg2hTyqL61XMr
         Um57PxGTiPCY/zN0NkRonrmQFsTOVM7TiGjW4zd7dw3nFMlhx2ciyhDej+wms9zxo9Hp
         KoIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781201631; x=1781806431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mAfkkS3+scBAS47m7nRCqu6b0ti3VWHtbY2WD+mN2LI=;
        b=Zz+WQ8CA3ROmH3NQg/vHINh2qpLR1MjTjwbRiz6L43S/sknOW+yM6mxNFX1U6Dh/MA
         dGhGdvXr7eFOUqdK1LIZhZho7rE0xU2PEMtTos5M5MzS1tIo95gtZFy/53YEuZiu8g/i
         8loUId9EiBN9WAli03afyzdhF+YpUqMqlxA5iAif8EvlCKuP1qoF4Q1Dg/rE8Dc65mjD
         wotCnwh202jbo56/zGQ4jF7Tn0E1vM71O5NKMFFf8cHlknQLnZDrjXx6lspKwU4m8VvE
         6YlEkBsEmdRZQYYSdtsfIdJwy8qn4kePdgXz8/4Xm9qTW2HSezQCI2OQupUJOvVZwX7J
         S2aw==
X-Forwarded-Encrypted: i=1; AFNElJ9L8emZRkrM/IIP2TNCpiKZ91jxovJ5oqT9v9Susj4/29Ryj+iO+mHrs85lvxuZnEnD/eHsqA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxDl3iFq8nSEC4abrjWl9R86AWXHIpuMDmlkT0SuN20i/iW1Ski
	heqTPKIEI7yNow+qLTL3tBybld9SuMxoWtgyF86BJ2wSgh0/bed/0sc1jw79OQ64ZWk=
X-Gm-Gg: Acq92OE6TlX4VieQNinpWYQ70emv6aanS1E3cReFd7vdoLkhRZljsGhH42EEkyWgjGF
	4GahMJDgoDwFTWFNeWje5v5bINecGKeC4+hd17lSovyCp7nroh1/VikruFcQ1mjUDHFQiXnvBUn
	1+32XKbf2vihzGUlcO7YKeuwBYimDLm6LQr5Yx4m7k5+zuXzqjO0iVk9HC9K0NodMKBFO5viNOc
	lAHs4EhrKkP1cX3xVevZ+oHLN+7phRePQpKflX2IcPqmeAgz9ig7ItQ/1nkHoFDe2iPoqhXywnP
	GMv6ZDNMPIM1JTVourtJ5tlSg4YyS2J9XQ85VDViec/2VNopfN9o1WyggDyRJdaly4Y/DAofHoT
	bkzA+9LYgOAcBZlj4tzxH9PP1H49xfoJJcuNv+c53Wyb4/kVJgWdMr9/9K54RIud584CJlVfEw9
	2wcbI4M1NZBXm7xmIr3vPadewBIL5YbV6BhQ0a/Y9wLeq3b2yJ5hw=
X-Received: by 2002:ac8:5ad1:0:b0:517:29f6:cee5 with SMTP id d75a77b69052e-517ee3d0f71mr61109421cf.49.1781201630614;
        Thu, 11 Jun 2026 11:13:50 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517ef658c7asm23569101cf.26.2026.06.11.11.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 11:13:50 -0700 (PDT)
Date: Thu, 11 Jun 2026 18:13:49 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Tarun Sahu <tarunsahu@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, 
	linux-kernel@vger.kernel.org, vipinsh@google.com, kexec@lists.infradead.org
Subject: Re: [PATCH v2] liveupdate: Document that retrieve failure is
 permanent
Message-ID: <air6nKKX0FGs7Bwu@plex>
References: <faec5df2a3e90240cde5897bae2250cd7d44aeac.1781170056.git.tarunsahu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faec5df2a3e90240cde5897bae2250cd7d44aeac.1781170056.git.tarunsahu@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260611_111352_101137_AAF64C9C 
X-CRM114-Status: GOOD (  15.57  )
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

On 06-11 09:30, Tarun Sahu wrote:

Please include at least a sentence in the commit log.

Otherwise,
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com> 

> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
> ---
>  include/uapi/linux/liveupdate.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupdate.h
> index 30bc66ee9436..d06aa24350b5 100644
> --- a/include/uapi/linux/liveupdate.h
> +++ b/include/uapi/linux/liveupdate.h
> @@ -168,7 +168,9 @@ struct liveupdate_session_preserve_fd {
>   * associated with the token and populates the @fd field with a new file
>   * descriptor referencing the restored resource in the current (new) kernel.
>   * This operation must be performed *before* signaling completion via
> - * %LIVEUPDATE_IOCTL_FINISH.
> + * %LIVEUPDATE_IOCTL_FINISH. If a retrieve of a token fails, subsequent
> + * attempts to retrieve the token fail with the same error code. Failed
> + * retrieves are not retried.


>   *
>   * Return: 0 on success, negative error code on failure (e.g., invalid token).
>   */
> 
> base-commit: 2d3090a8aeb596a26935db0955d46c9a5db5c6ce
> -- 
> 2.54.0.1099.g489fc7bff1-goog
> 

