Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1655EFF8875
	for <kexec@archiver.kernel.org>; Wed, 29 Apr 2026 21:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iD+JgyZ1kFui708npPl3N3ndnfNMh1rEfRmYOE4MJj4=; b=N/MuT8DhAujERxgp9Ozl0upXEK
	qMf0mLhgc1p/KBQjLEtDOqqCnZb4ZBMyiU9yTMjXSxRnHnz/EbICS9EBrDYWMKTE/CTarZUUPLr1o
	/xZreonJkVlRDjeCitzu3qNV5yUf5sz0Su1VI8yfP0d+tazqoFf2iY77+zdpRsZxYw+OGfTkhgMlk
	R++GZOI9uordpa7uQyfJu61+eq3zjy2vEdtM3rpHEi46OwhtNpfDBQJUhw/bDshy7EplWrI0j7/5v
	eMb73ZS5c3wTanohvfzdwETjeW1vWZBu3vklaA6u854E9L2c7AglOu5eNTX3JdHjw7R+7RDwu3k5S
	vOH5WW+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wICNO-00000004EeR-1eeY;
	Wed, 29 Apr 2026 21:23:22 +0000
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wICNL-00000004Edl-0yh2
	for kexec@lists.infradead.org;
	Wed, 29 Apr 2026 21:23:21 +0000
Received: by mail-yx1-xb133.google.com with SMTP id 956f58d0204a3-65c0bda7f15so224249d50.0
        for <kexec@lists.infradead.org>; Wed, 29 Apr 2026 14:23:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777497798; cv=none;
        d=google.com; s=arc-20240605;
        b=a/7KPx6LpyzmfIAuUhQgOK13H72ejzf8UDM2x9Ux3lwrSMf6hCB9jlx9eU+hjP89JY
         zCLAwGuZzUhvJtGLO0/fGkpxmiM3MMnwnC6MdX3Fnl/IK6tdO8k1/0UDzgXFhTTTJSsu
         6Zgdt+3y2sA9NwkyxzVDBA8IJhGc0SYL4QgfkO3hnmLDx+fqNqjopRn0qJsbrjUaGKg4
         BTWCKszgqMPlYPER33MxbVDOlySuXonz1I1BYvxr8ue3sPt3Xb0xjlg/QOirStFNOyLO
         B9jeai7L/QXAdmdEPyoIk0Djd6HtqQVuomCYOcv4cCP/Bmb4HbA83Bla0kdcxkwSL+74
         hWIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iD+JgyZ1kFui708npPl3N3ndnfNMh1rEfRmYOE4MJj4=;
        fh=LY4yzD4hTHKbPiBUqpWX+5Mwu4/djjfrqkBvM1hEdRc=;
        b=g7TYu0HLDJylaKXtSNgdT9rR4s7MsU/zc0EalJMgiCepFWujGTa85hSFixFhYeGmLx
         cV5eWlM9PduC/62lh/JrWsVCNJscBhLpgYX3JYMef1UU2mPTFFPlC8OMwjJv45ny7v+4
         gxwjktNiQCpBrM802BITAO079gOnOdnNJv1XJDDPgn0WVxqMpIQ2lvn7qmHzwIenIvRy
         cmf/POBohkcCYKcfOfNWdUHKtLOaTZv06sA5Uw//ISJQOfo1FVDFuQBAHfst+bUKbU5F
         OB1FYd6SLsvc0HTusfBubigDjB1uc3oZ7qIbdf3lQj/qJ04ZTzlz1Kj4sDwunNGuSY/+
         WEcg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777497798; x=1778102598; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iD+JgyZ1kFui708npPl3N3ndnfNMh1rEfRmYOE4MJj4=;
        b=GDZAQSKdgODFO/ETrxBGRwo0PV+iANeYVVnSkTlzqmNWAlr9jhFwKCBvqucR0DZGI9
         Rr8Nqy1QX8T4DqDoM797AwsSG4XGIhxgVJck4C4GaoUaEDlLeMamWHjoV+/xKJDbzzUS
         OXrkMBDRSH0bnlL4nDEZpVugK7AvY/e0LWjMShctn5Oqm8btVmaCihWH1h+eKckGE/Np
         2WgzooPWNiB+qQ3DFsC4P46CeBUBbm97RpnrtWHLUzM0DRN0HNc1KCjduYpPE0ENBpWO
         D5+MAoN0snN/E4ffQT5Pe/39pI0OuPbxC9IXnTl82gMKqv/eQvDVeEhlrGc0lSLHpIq0
         Y9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777497798; x=1778102598;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iD+JgyZ1kFui708npPl3N3ndnfNMh1rEfRmYOE4MJj4=;
        b=ghiB10qb8WKqQ3+1xYyEA/ZeCZrw4wAOO9XdV+s1jT+fEoJSRAIkGaTYXKuQUDS8Ef
         WB68UwglUvXg6rXb0YDR+3MCrNR8m4FH96B4mzHnq7uyc5liDZfNlzq0reGKnPgdTl7L
         Ydb2WZRik7E0frd8gDwFP+BHdAf5/o6yJ6ChqiA0PDr4yYwMRfeJwOKZqA1iK5Ttp74U
         VntPXQ0lxOZwQPuX125XW614d6hrtwYrf8V8xcrdjJqYgljNIpgcwymbUKcLmNOEH7iX
         eXOn85d9dnAe1J+QC5zPO0gGndeX/GMtEULgZ66X5fvD0m2JzVBfM21DsurVYJdGKBSw
         Mulg==
X-Gm-Message-State: AOJu0Yw0qrCcXBv4MZx+tWn2rli++HP3nuHVI2ubrKPY6c55SKBTyU7u
	PvEuycTsHlFqvPXeHDvqLahMWfdppNLVl1HS/CsCalSKpt+ohsXWGsVJ8efa6UmDy8h9bfaG+zb
	8hU9nXDWOa2gaxDu9bXWr24/NWG9URgo=
X-Gm-Gg: AeBDieuyZ/oQyLwb/M52X/Z77eHHYNiTZd+fx9a4TaCxRVfTxWRvvw80lH6xUlDPbVP
	nZLKOmMAMBaX6k0fU9W9jVHO0m6DkB7S1pEUJ+qK7YLXNmNFKxeHEl2IHRvUEDnOP8WK2CAxk68
	hhOjPzBkhzMn8myAG6R47kE5R48pmQqz610rrVE7ZXeeu++4sGlBAWQeVmuy2iRcJ6e6/axBDWI
	apebbCA07PKm52CyuWSrjs0xSgEqUtGsptgEEShN3JHAL8NGBi6lzucaOnF//JaD9pWwKA7NS+2
	4y8K5g9XhDWf76vOVghq/7fxVxiHmJUtBBDfxRgi20KI5Ao0WfNDIULi3a5W8n8=
X-Received: by 2002:a53:d059:0:20b0:657:e42c:ed01 with SMTP id
 956f58d0204a3-65c18f47ddfmr17777d50.50.1777497797960; Wed, 29 Apr 2026
 14:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260423234753.3873095-1-luca.boccassi@gmail.com>
 <20260423234753.3873095-4-luca.boccassi@gmail.com> <2vxz1pfx4yxk.fsf@kernel.org>
In-Reply-To: <2vxz1pfx4yxk.fsf@kernel.org>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Wed, 29 Apr 2026 22:23:07 +0100
X-Gm-Features: AVHnY4Ivtpx7aa0gXmToc851I5UQ09wVjAcX9BsvF4cWKvg3LGIFCeYqlWO3iFc
Message-ID: <CAMw=ZnTbAZh0t3djk7F49z8fDRZLMtPbBVchh_rJAq9aQ41H7Q@mail.gmail.com>
Subject: Re: [PATCH v10 3/4] liveupdate: add LIVEUPDATE_SESSION_GET_NAME ioctl
To: Pratyush Yadav <pratyush@kernel.org>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, rppt@kernel.org, 
	pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_142319_279083_8F3AC768 
X-CRM114-Status: GOOD (  24.30  )
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

On Wed, 29 Apr 2026 at 15:35, Pratyush Yadav <pratyush@kernel.org> wrote:
>
> On Fri, Apr 24 2026, luca.boccassi@gmail.com wrote:
>
> > From: Luca Boccassi <luca.boccassi@gmail.com>
> >
> > Userspace when requesting a session via the ioctl specifies a name and
> > gets a FD, but then there is no ioctl to go back the other way and get
> > the name given a LUO session FD. This is problematic especially when
> > there is a userspace orchestrator that wants to check what FDs it is
> > handling for clients without having to do manual string scraping of
> > procfs, or without procfs at all.
> >
> > Add a ioctl to simply get the name from an FD.
> >
> > Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> > Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >  include/uapi/linux/liveupdate.h | 21 +++++++++++++++++++++
> >  kernel/liveupdate/luo_session.c | 13 +++++++++++++
> >  2 files changed, 34 insertions(+)
> >
> > diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupdate.h
> > index 30bc66ee9436..3a9ff53b02e0 100644
> > --- a/include/uapi/linux/liveupdate.h
> > +++ b/include/uapi/linux/liveupdate.h
> > @@ -59,6 +59,7 @@ enum {
> >       LIVEUPDATE_CMD_SESSION_PRESERVE_FD = LIVEUPDATE_CMD_SESSION_BASE,
> >       LIVEUPDATE_CMD_SESSION_RETRIEVE_FD = 0x41,
> >       LIVEUPDATE_CMD_SESSION_FINISH = 0x42,
> > +     LIVEUPDATE_CMD_SESSION_GET_NAME = 0x43,
> >  };
> >
> >  /**
> > @@ -213,4 +214,24 @@ struct liveupdate_session_finish {
> >  #define LIVEUPDATE_SESSION_FINISH                                    \
> >       _IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_SESSION_FINISH)
> >
> > +/**
> > + * struct liveupdate_session_get_name - ioctl(LIVEUPDATE_SESSION_GET_NAME)
> > + * @size:  Input; sizeof(struct liveupdate_session_get_name)
> > + * @reserved: Input; Must be zero. Reserved for future use.
>
> You need to enforce this in luo_session_get_name(). Otherwise some
> userspace might try to get clever and stash some data here. Then if we
> ever put something else here it will break that userspace.
>
> With this fixed,
>
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

Sure, fixed in v11

