Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE55ECD8C89
	for <kexec@archiver.kernel.org>; Sun,  7 Jun 2026 16:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6HrqFsYWh7IgIodQ4s8E7nh3lZZmydvw5nlZkHywms4=; b=U9yeTZhbndErddPhbFrwFt749T
	d4zJ1cq/SgF+Ej1UtGUQVpTf71a/v5N+0EF4aQxSQxQD6qyYBRppxbekftGUkuSpVnEBLYKabmJEt
	ddMN7wcwxJwpvU5uKqVFIClrHP4Gbs46g3gQFxMGwzsQhPAvTEphq3eHy50enWi8yHUyOctQxFua5
	F1/3ueliReyS3CiIZncOhPVfgaevLG12xlRTyNFIzMO07l0g+z0mQ24FUu5sW6N26YMl5Kiro1n2y
	+Pe5HmcMAB9eatnq60XX4oQz+M28Evw8l2clB+4bCqwvktSrIVUWDEj38WKq+vObdMpcCL5I8PUyf
	iPI//aew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWGF6-00000002L0p-1NYg;
	Sun, 07 Jun 2026 16:20:56 +0000
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWGF4-00000002L0M-1KkC
	for kexec@lists.infradead.org;
	Sun, 07 Jun 2026 16:20:55 +0000
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-9159951f05aso431811785a.0
        for <kexec@lists.infradead.org>; Sun, 07 Jun 2026 09:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780849253; x=1781454053; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6HrqFsYWh7IgIodQ4s8E7nh3lZZmydvw5nlZkHywms4=;
        b=ca52apGwlxNIUlfqXwoXiVyzO7jYdK9qS3Izb1BQxaQc83q314li6gg3vdUxMh2+eg
         f8Gng4eERz8rcJROJO3sOP3BhBAkUFt24iqwWrX6NHsTgErNfqBUlOK2P7FCN17Ehtiy
         hkbDCfMVePW8Y/YkKXFaSvA6VoaeIhSNE/9UjfYSdoZuJCA8W+Xlsnol3YocNLRJ+mpU
         jzRxaQrUqNkHtnsLRiyR8DcASDk7W1fL/pfY3YoXhzirYZm4fSJ4Kc+Amcgx+8ybW2b9
         WeVuIreXeXHfI7uHyLxScFxJzY+3e3qYBtZxjXObgBG6XTBcM7U1OMQx5EjUVh3nY2MU
         s0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780849253; x=1781454053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6HrqFsYWh7IgIodQ4s8E7nh3lZZmydvw5nlZkHywms4=;
        b=L9BfJomyNU3Hp96OIspRwLKWpsK6K45/+j+TAkljGACtr1sowpHv2p15Jl6mZyRWhx
         2X7LsPTajwgYLQmqcFbFcQs9IGcxdjmfVuNKHoyyg/sdijuRuD5aK7RvY2b3jSgRjqGL
         Hj2YArtGT7b0XsGObh1ogx82V91ze2tX0UBGvRhk5INmeuDv5goMl+5y5rWIsJV4r4kO
         VmD9ZWnrE3CJriCMJpgRRDDl1Tw2ITgCwF7JgcBDHv4WiEMQx4JTSQbLDBHxTZLWFjGJ
         z/zaBQv1ZERoU2eCMJNDiOKPCt3CMPocxIOHjshkPkP2wj/58E//znhKRc2ZBqgSK2Qc
         GHHw==
X-Forwarded-Encrypted: i=1; AFNElJ9k6SqiMtdVxNiCdyc5dcH0d+m7ayGNFjLxYXfsxw/ijJ3uNALngDpneTlGIwfNPAWTSkfZFA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx4SNiHD5XqLn/6JJxXr6I1176COnSbtspWRxI1dCUWwI/yh3e5
	7Rq+4a6ifJCyrat+dn9G2mpNBLCbTnOtMzJgrv1Hm6CfShvTbcTnpMwDTU+AIPP04aI=
X-Gm-Gg: Acq92OG3a1JpTzFPM6HClb1uVWaSmsyuccvsKiEPz3wQVu9WyssM3wzhAKFwXreTVPY
	vHkknzhqzwNgn5d6sRiCDVuMsPRtkmkmQw9aHG/MofICKtXl6V4k5Ikl0wN/LCqBzVIM/aKBs/2
	3MYLJ7q7Qw4lD/r2TIck45QimYVjD6gz4I9Rb/ryHwbr8xVicT+ZokhcMLBhrWZqPmRPXfnRGeF
	RmMxzETdJeke5DBUQzn3m21y9Nl31V8cTajljqwW7VO3QlncVJrPWSCwZw5YdXEH0Wu/tgzZKv4
	AjQm3qTI4PrODvl2g+/DHbUqAfskk+Ee2dqrHryjHnQz+eGcGWXpgodxLPrE3z30G2Ivau8eISz
	hSQrNdcmVbVbecMTgcoZZ4VxixNpbqsiN67OvwCmuYN/XF+iuqBvLb6nNCNfx8VyYDdtynr+bI2
	IFVfHzMOOAYCJj/elwFtGJeHdfJR5LE9V6S/ngRwSHwTTFWqSgIy3Dj60oT4J7cZukOvmgnbD5
X-Received: by 2002:a05:620a:29d4:b0:915:cda5:2803 with SMTP id af79cd13be357-915cda52c57mr287390585a.56.1780849252787;
        Sun, 07 Jun 2026 09:20:52 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a37cab6sm1456344985a.22.2026.06.07.09.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 09:20:51 -0700 (PDT)
Date: Sun, 7 Jun 2026 16:20:50 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	linux-kselftest@vger.kernel.org, shuah@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org, jasonmiu@google.com, 
	linux-kernel@vger.kernel.org, corbet@lwn.net, ran.xiaokai@zte.com.cn, 
	kexec@lists.infradead.org, pratyush@kernel.org, graf@amazon.com
Subject: Re: [RFC v1 1/9] kho: split out radix tree tracker into kho_radix.c
Message-ID: <aiWYZhoSOAruIIM3@plex>
References: <20260605033235.717351-1-pasha.tatashin@soleen.com>
 <20260605033235.717351-2-pasha.tatashin@soleen.com>
 <178083348873.1648214.11020626647820932506.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178083348873.1648214.11020626647820932506.b4-review@b4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260607_092054_365044_362E770B 
X-CRM114-Status: GOOD (  16.74  )
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

On 06-07 14:58, Mike Rapoport wrote:
> On Fri, 05 Jun 2026 03:32:27 +0000, Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> > Move the radix tree tracker implementation from the core KHO code
> 
> It's radix tree data structure implementation, kho memory tracker is it's
> user. Please rephrase to keep the semantics clear.

Yeap, I will update it.

> 
> >
> >
> > diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
> > index eec9d3ae07eb..a3ee8a5c27a2 100644
> > --- a/kernel/liveupdate/Makefile
> > +++ b/kernel/liveupdate/Makefile
> > @@ -7,7 +7,11 @@ luo-y :=								\
> >  		luo_flb.o						\
> >  		luo_session.o
> >  
> > -obj-$(CONFIG_KEXEC_HANDOVER)		+= kexec_handover.o
> > +kho-y :=								\
> > +		kexec_handover.o					\
> 
> I don't see much value in moving kexec_handover.o to a separate line,
> btw, the same is true for luo_core.o, but it's not important enough to
> change.

This is purely for consistency. I wanted to use the exact same style in 
the Makefile instead of having two different ways of declaring the 
object lists.

This:
    luo-y :=                                \
            luo_core.o                      \
            luo_file.o                      \
            luo_flb.o                       \
            luo_session.o

    kho-y :=                                \
            kexec_handover.o                \
            kho_radix.o                     \
            kho_block.o                     \
            kho_vmalloc.o

Or this:

    obj-$(CONFIG_LIVEUPDATE)        += luo_core.o
    obj-$(CONFIG_LIVEUPDATE)        += luo_file.o
    obj-$(CONFIG_LIVEUPDATE)        += luo_flb.o
    obj-$(CONFIG_LIVEUPDATE)        += luo_session.o

    obj-$(CONFIG_KEXEC_HANDOVER)        += kexec_handover.o
    obj-$(CONFIG_KEXEC_HANDOVER)        += kho_radix.o
    obj-$(CONFIG_KEXEC_HANDOVER)        += kho_vmalloc.o
    obj-$(CONFIG_KEXEC_HANDOVER)        += kho_block.o

I do not care which way is chosen as long as it is consistent. Since 
this series adds new separate files for KHO, and does not touch LUO, I 
used  LUO as template, but we can do the other way around.

