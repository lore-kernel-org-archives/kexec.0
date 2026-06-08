Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E06ECD8C9F
	for <kexec@archiver.kernel.org>; Mon,  8 Jun 2026 14:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5XaEoBFZ0wQN7RayZ7ZGkzrqQNmFAZboLFpyYk5DAFk=; b=5D50x7p6THi8quNuDO2u7P22GP
	29AfxMKc+P3RYSgxRjz+dQoAy0xMD1Al9yXcodzf32YtOlA9fVC6YqbThAUx3rB+7GhrC05Lu1ZpP
	1jkdC4diwxcjH9buJS942qiM885Ww1XchNeN3fC5Rt54O168q0SN9UQb4YcQYfvsPjU23GGAK0dgH
	7lIqJCKAWbGlQn7zNuU+TB/oLFqrjuZcwrUmVmVZJdHxyekaTUqEJ1WJDyuQgYxdCSBL0kzYqQ2LY
	Fyd1OV+pPcviPmd71xIexPXQDv08dIHDGW5N+ubRFCqznLQx/MgdypB9esgBbgT2ccAgduBg0+sBj
	AwEFYWaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWbP1-00000003tWY-3jw3;
	Mon, 08 Jun 2026 14:56:35 +0000
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWbOy-00000003tUQ-3W4f
	for kexec@lists.infradead.org;
	Mon, 08 Jun 2026 14:56:34 +0000
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-5177945a279so47711831cf.0
        for <kexec@lists.infradead.org>; Mon, 08 Jun 2026 07:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780930591; x=1781535391; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5XaEoBFZ0wQN7RayZ7ZGkzrqQNmFAZboLFpyYk5DAFk=;
        b=WKvOd0fzJHAsBqJqyu5DwQUh9x3swNzKqqE0dQMVhYrLDB3qGUGEM3BULrGrtLOrTo
         9njW6mO0YnhVM+Eccwr1W7XaabrVjZQC4JtfM4C25aPWRNdeakjmNKVwkD/Hm1Zb7+2w
         fkgQ6Gvh6L2tFWsBuvEkcI2qwUaWolV6RmXfpHUdRZl2uvCX2lALc7NYP2pWAVOvtTXg
         IuMPHw74L5mnvNWs7r7tDcor/FUfylHR1wFMy1HZkpjTqYwlAPxOmtQfpPEy49iPdUV4
         ygwxu4Mxv36bAT8NWeQoSZ128aXHGDt7VqFXfjGQwzrBRxJSOmxgQsUMo1XXrFlGPp3W
         Fh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780930591; x=1781535391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5XaEoBFZ0wQN7RayZ7ZGkzrqQNmFAZboLFpyYk5DAFk=;
        b=Wop8F7NH1mN2F3bhs8MLUzKR2MrMdi5IBJPfr71NHy3mxjDWjyl/ukV/T78REI/6Al
         V64Ksuh6i54y1sR8mVz8FieC0NtsUCLAyGP2wSyoMAixGSZnzzKFpBL56AHnMUjnwE0/
         MHWCj+956Zkg3v0Jx1oJUjIIfX/amWpTnbaqIDzvOPdNNyAq4uxOcg0NMTM+ZTt9fi0c
         caU5bIdLSKupZSLxFdRFE3/nGQo+PX219w9SXCSyLBYtYKyXlG5ygpDJEP0zJmZ5eo9R
         B7T+fQ/71anSfWksFvZ/BOCa2aQ2Pk9cEECo+aWCw5ieuKBO9074mNfKiVV2Gx90fxXz
         8Kvg==
X-Forwarded-Encrypted: i=1; AFNElJ9kWaCnPTm60wWz/UDZ8Dw2Gtp0QRK1eRrY2I6o/vizxVhj69oQ1n4W15yAPcMkISlkTE2PSw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx8M8t+qYI7xIfnhu6lLdLJl8AX+ktdmgfk8HT2Fqy3N9qwblZR
	zETvXPcEmxHo+lI//vCkhcYFruShc5+CkoSWfs9NdpOIcw4Qu2KvjeNG4WoQm0jUW6U=
X-Gm-Gg: Acq92OFfYl+SuPN+Tl3F2W3kwBlTCdHjrpfaVKslp/337JNGR+n0DlUGCohoXyVnD9H
	oai8UVwgY8zskuJlMrYWMipYyQc1Ov7yX0p6+Df3wZuV8T50ITFsyCY8w8gmcaeA+xqHsecPiHH
	3t8towWYkgO6s8J1BNhzqE2PJWSx0ryTeJU9b5by3BgCzSgf5H1l42qmLuxZVraAR9x9KahxSFT
	mOJZY6Fl2yOSY3a/iC3X/H074TruC9QjbotU6qilocNaOOyTAUIlpHAz5vR5ixFd3XNEV7ZawFV
	lWZMlfkzkFfPoaP8aAJ01DpE3KpgdshLAGR2RDiGSP309xCm0KzcId3Bu6oWY0Jn9piIVrNAqWR
	32Xpm1zCZyopRmXwjUOA1BjTjXyRpEMvCV14mkbFunL0JvlR4JoCA76Bl+oi1wo/3oRmrNPAH5K
	xAgiNati/G7hLeM2Grw/jKIjKsduO7kcgPGRySeMb4lkEFiJOiobRPWD3C7+zPBw==
X-Received: by 2002:a05:622a:1648:b0:517:6d75:a2cf with SMTP id d75a77b69052e-51795c5a18fmr245549391cf.43.1780930590664;
        Mon, 08 Jun 2026 07:56:30 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775dbd2c9sm158664971cf.23.2026.06.08.07.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:56:30 -0700 (PDT)
Date: Mon, 8 Jun 2026 14:56:28 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	linux-kselftest@vger.kernel.org, shuah@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org, jasonmiu@google.com, 
	linux-kernel@vger.kernel.org, corbet@lwn.net, ran.xiaokai@zte.com.cn, 
	kexec@lists.infradead.org, pratyush@kernel.org, graf@amazon.com
Subject: Re: [RFC v1 1/9] kho: split out radix tree tracker into kho_radix.c
Message-ID: <aibX8oS4toOVaCqm@plex>
References: <20260605033235.717351-1-pasha.tatashin@soleen.com>
 <20260605033235.717351-2-pasha.tatashin@soleen.com>
 <178083348873.1648214.11020626647820932506.b4-review@b4>
 <aiWYZhoSOAruIIM3@plex>
 <178085518028.1648214.13339471022594901667.b4-reply@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178085518028.1648214.13339471022594901667.b4-reply@b4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260608_075632_884581_41A76218 
X-CRM114-Status: GOOD (  16.18  )
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

On 06-07 20:59, Mike Rapoport wrote:
> On 2026-06-07 16:20:50+00:00, Pasha Tatashin wrote:
> > On 06-07 14:58, Mike Rapoport wrote:
> > 
> > > On Fri, 05 Jun 2026 03:32:27 +0000, Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> > > 
> > > It's radix tree data structure implementation, kho memory tracker is it's
> > > user. Please rephrase to keep the semantics clear.
> > 
> > Yeap, I will update it.
> > 
> > > I don't see much value in moving kexec_handover.o to a separate line,
> > > btw, the same is true for luo_core.o, but it's not important enough to
> > > change.
> > 
> > This is purely for consistency. I wanted to use the exact same style in 
> > the Makefile instead of having two different ways of declaring the 
> > object lists.
> > 
> > This:
> >     luo-y :=                                \
> >             luo_core.o                      \
> >             luo_file.o                      \
> >             luo_flb.o                       \
> >             luo_session.o
> > 
> >     kho-y :=                                \
> >             kexec_handover.o                \
> >             kho_radix.o                     \
> >             kho_block.o                     \
> >             kho_vmalloc.o
>  
> I mean this:
> 
> luo-y := luo_core.o		\
> 	luo_file.o		\
> 	luo_flb.o		\
> 	luo_session.o
>  
> kho-y := kexec_handover.o	\
> 	kho_radix.o		\
> 	kho_block.o		\
> 	kho_vmalloc.o

Got it, I thought you were against making the consistent :-)

> 
> 

