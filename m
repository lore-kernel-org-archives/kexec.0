Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 255BCF588E3
	for <kexec@archiver.kernel.org>; Mon, 20 Apr 2026 14:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uImRWdptQ584i7GlHtwZAdnn1w2zI7sMRH2fpFKWYnM=; b=1BCoOoCMjUe4dZCiTNLQZaYrRy
	oyYr8Uq2JXZRHk2WfA1E09zdFgcBhpeYrhI8IST0hY1ApUUJEORtudyks56Mqz0AasRRtCYovXYh0
	3ZJGTidkO3njINQ3WEKEnM2PrL5tsP3XnIOxae/cQd+ovppCaHptdfcPhkbF3VPr7rFAlAGwsA8Rr
	bugJpibiLIxeWO1eAxAhA3ynAgWpGsYQe3Xhyy2hlO+M3yMKVRniYDwXIbciTYBosOrBReGVcjsyo
	ceLeXnhY08ijiBZsRARjMHVbST1b0gx5QE7TuA5sxYC37cpxR4J+zcTQI/Tmr4TKLAMW7yA1jCHeR
	rFwWo8/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEq4C-00000007Cl8-0kGX;
	Mon, 20 Apr 2026 14:57:40 +0000
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEq49-00000007Ckm-1W4k
	for kexec@lists.infradead.org;
	Mon, 20 Apr 2026 14:57:38 +0000
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-50baafd6c4aso37178191cf.1
        for <kexec@lists.infradead.org>; Mon, 20 Apr 2026 07:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1776697056; x=1777301856; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uImRWdptQ584i7GlHtwZAdnn1w2zI7sMRH2fpFKWYnM=;
        b=aqrCCHdpkCB91r1mddT6rgYGf0GNwf6Noopy4H6mef8pGKgK0Txt7GaEJyC54Vq/LA
         BPRXEUYJuY3U54imypKmix25sh2ddLiEGCs4BEOZVKf/57ySlyawx/HpqM8+OmPW2kUK
         Iqt/vsOAeXzLvAJK7P7D68miqmT/3aEk1OBv2bGJ1r82dCfejP2B/gTH2otQfHA5RtM3
         LofDwyVCqjMAgcf0XGBHNbnScp6d5/gx6XejN6djgS6fkq/cyfyHN1wm7tbeVOg9G5Qs
         2l74Fc6L61hqnE27mWe8Q74QCotKrtRHLvPiwCxYL1wZ6ELpnkhOzGbiABBj+ljxader
         rBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776697056; x=1777301856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uImRWdptQ584i7GlHtwZAdnn1w2zI7sMRH2fpFKWYnM=;
        b=Rk6QJxnkgDSTOGb9qdtW6RQ9jvzqxlYNfLEs1c7behGxgBx81heDgCziU5UFnrToLV
         IldJcdiB4tN56T/G4bhivMZflHEQHMg/4fsSL8X/xrOTM/Mkz1tiBtyss8erLSKdIq9l
         wwmU339KlX/+qc+eKg0GA4DCwPgoy7BA3qB448ZeNq9EYX+fglYMNwdB18QC01PFxbfB
         9f9XPtJA09vmoOvAQHQCdun/tIbum6rKqwbIUtD8xQcDSuZgqvKVHKE+DLZ30SbgavJQ
         hkaS526a4XvWbXMiohwrjzXlaJE4DfM4HmVKYvk98Vj15Ca9EyCA1EE1ipiBvGacP268
         LDUQ==
X-Forwarded-Encrypted: i=1; AFNElJ8QtmBAPjQ2XjDLWBVvw5g+BySyYcLxE0fwFvmLt8Bl5hrJSXtTlLzkJ2XMJcIBZWo4ub+6eQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy6DYjJ+ZZzFiWKVGs7nkx7BJQ39kd6igIa1NvbsTvk4H3flzq/
	bwbedqaV3fTjWrz6w2SXWxYbL5Ohl78p/nFEyDFVLZZMf+hRmUtVcvzqcslEaN7JN+4=
X-Gm-Gg: AeBDietAqPdrRxBq/tNWOhiZBfSwhdpjH0XkebWYzPsntlMbWTMJpLkkVA6f5RtL0hL
	LSdT26PKr9UAFPpSMlQ96StnxFY6y0zYdeiXbnG2XsBLi409m4n/zmSmbrLN+sZLxbSy92+ybfw
	VOkl6qURer8hJYsnspX8ESBts4su4FIvLGLyYEYq+GreXUWiZKkEQBS66Qrv10/xqWPAi9LTINl
	GP5ejpbFm3nSE4uDo1dzmFtttLuN8PUIl1e5DUlkcVAUNBVkQwBPAUAD3qurFcKC+yWpUL3Sokl
	2YBykTrpebDTb5y4sDjCMVGDHfR/ct4s0aYNFoArDVkx4ro2/uZkck5136sWxL4TjfFGdr3Zg3M
	7vKrSBto8vSZrrApdXquCx9vMOGvFeuVJ7i4Kh+hP4igIuRUuMdSGnXtaOhrkRb7LROH7vEQvK7
	mIr5b8DqLUht/bKVHf+yXuHvFxFW6vySnwPbNnPOkw1CgCe7nGqMPQqG7ReFZA
X-Received: by 2002:a05:622a:4c14:b0:50d:9c1f:bbe3 with SMTP id d75a77b69052e-50e36be3a8amr203453451cf.16.1776697055992;
        Mon, 20 Apr 2026 07:57:35 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50fafe9674csm1837191cf.3.2026.04.20.07.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 07:57:35 -0700 (PDT)
Date: Mon, 20 Apr 2026 14:57:34 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Luca Boccassi <luca.boccassi@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org, 
	kexec@lists.infradead.org, graf@amazon.com, rppt@kernel.org, pasha.tatashin@soleen.com, 
	pratyush@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/6] liveupdate: add LUO_SESSION_MAGIC magic inode type
Message-ID: <2furrcrld62f4l4vejskwhzzsj4wxgdt2wmrujlfqnf7ypgkny@yzzftym3vggy>
References: <20260418163358.2304490-1-luca.boccassi@gmail.com>
 <20260418163358.2304490-4-luca.boccassi@gmail.com>
 <20260420-unbeeindruckt-besprach-910fd241c32e@brauner>
 <CAMw=ZnR0uVrHUNzNGu5BtZuSKDJAYmZGUX-HzSw7c4VnoeQgiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMw=ZnR0uVrHUNzNGu5BtZuSKDJAYmZGUX-HzSw7c4VnoeQgiA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260420_075737_404509_5F5BD1BF 
X-CRM114-Status: GOOD (  12.60  )
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

On 04-20 15:22, Luca Boccassi wrote:
> On Mon, 20 Apr 2026 at 13:26, Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Sat, Apr 18, 2026 at 05:28:20PM +0100, luca.boccassi@gmail.com wrote:
> > > +}
> > > +
> > > +static const struct dentry_operations luo_session_dentry_operations = {
> > > +     .d_dname        = luo_session_dname,
> > > +};
> > > +
> > > +static int luo_session_init_fs_context(struct fs_context *fc)
> > > +{
> > > +     struct pseudo_fs_context *ctx;
> > > +
> > > +     ctx = init_pseudo(fc, LUO_SESSION_MAGIC);
> >
> > I'd just call that LUO_FS_MAGIC.
> 
> It's specific for the session fd, so I'd rather keep it as-is. Pasha
> what do you think?

I am OK with what Christian is proposing.

Luca, please wait before sending the new versions, lets discussion 
settle.

Pasha

