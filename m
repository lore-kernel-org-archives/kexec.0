Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D65F588DE
	for <kexec@archiver.kernel.org>; Mon, 20 Apr 2026 14:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2z5FczK/Y5tDTqGOp8EC8XsAyW5tiySofIU9eAYltsg=; b=s8H1KkDSkFOPNteyzoWgoOw/t5
	DeM1uVsopAjkoYkNGTLwP10jfJY/T+VhoiMHqmq5z0EXfLZHNNXr/CJBOOGSr/lEUbxtLg+wQOYiX
	tZEqgI/ShLoo4LplXCE3S3TaNVW0QgvXPZfiNOaEx/sjd8pIvppO3FF0in9oTZgBkm+7BWFkLMcuK
	VSWDCCKdO5kCQDZyQXcqEwu6MFXjcvonZa7O2r7tTxZz644bNpKaGckweTYRwLfQ5+WWh/jGv/H1R
	mu1KJEsAA7M/Mb10WgbO/fhvUm0pDLFuNrReyfv1ICIi8Q1RVd5p7DWFFmNRnHD/jMIUJb1MK4aCd
	cxMiM9zA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEpW0-00000007ARm-1FWw;
	Mon, 20 Apr 2026 14:22:20 +0000
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEpVw-00000007ARL-2WdS
	for kexec@lists.infradead.org;
	Mon, 20 Apr 2026 14:22:18 +0000
Received: by mail-yx1-xb12c.google.com with SMTP id 956f58d0204a3-652fcd5a6d7so3514669d50.2
        for <kexec@lists.infradead.org>; Mon, 20 Apr 2026 07:22:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776694935; cv=none;
        d=google.com; s=arc-20240605;
        b=SwSXv20h7D5RE1mOnF1xhY6sMLYsJu8snEDVLG4KlTkna3xUf4GCKmsgscHnfjeycR
         DbeKgDgrNVg75VsI/4Nzjb0Pe/glAe5LZZuShDwdnh89unMFuRHnkLEiJe8lv+E9AQhG
         ahnihZr4VTsQOKJ+oQ30GCoiiOY5goERamGznixKaynvpuMWQ65t1+jTOgMZHMxVhVhS
         DBiMX/bl6n0ehdMlan8oh3z57KZZva/bVjk4yEE2wvqgzOHLr80GekaK4SMy3OTktEdh
         iF/7crhBaj0ASvfBn5GS2hHWCBuqNp11j+LQyUwJPkSEb/LIWw9dox3sR7n2PaIBTN6N
         tNHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2z5FczK/Y5tDTqGOp8EC8XsAyW5tiySofIU9eAYltsg=;
        fh=h7qEY/SM/e5AtWpjYriXoTdHBow3kZr1iW41mijsXjs=;
        b=Q6jA+/aLclRcYnn7Wii76/JM8rjc5UqwiBpKag8eAGbsh1EfBt+rK+TNG18INLUQIQ
         nNQ7tBJccPCK+i4tNJAuGZYErcJDAl9ZLWzz6LBb4L+7bPa0u+NObjkfKoN6ONhjo1Jy
         BvbI64L+rrg/O2owJM02wIIyym1Ls8q7psYltWNR/MxUVrA9gOcxldi39k1hwWhXmyVh
         z5RURmKifZCkht3miA6DTh/I0hD3cB/X8tdPqRFaDlVTp5OYt2dx9M01J3+RmQHrnERR
         pV0RJq4lIu16Q6VT81+ozdrUI6JhnQuTpCgSRAhrPt55/iMdv1QIPbv7PLnp9Ni7Ikgz
         8AoA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776694935; x=1777299735; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2z5FczK/Y5tDTqGOp8EC8XsAyW5tiySofIU9eAYltsg=;
        b=IK1Dl8fsyNE3NrbaiqULTk2gtPcBEgpwwo/UcdYEE153vLmIHadsweKj76ozgw85ab
         ZO1pdh1Ua8ZgBTVAyeQg2xKTHikMKmdWUw/KNPi15XAScBskIN5Rf2fghT0bD8QMpLjd
         jMTaZEPM2XbJcG9laa10A4jFdLY8HkHAgRmOuftoEPRqzOPyly/P0HqpNjmA3R9b9iyA
         sEN9aJIl3FUE7ikjuvZ8UrT7FwvEOiDrX56FgKITWEUkpbpDRl38fNqcqOyPFzIP6/mB
         gRmCdBbVoMhoWzVNX9nYTa1tE9px4fVVOtkKp7nhRehNV5kesIwtwcvOvGMP+GvQrHGx
         HL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776694935; x=1777299735;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2z5FczK/Y5tDTqGOp8EC8XsAyW5tiySofIU9eAYltsg=;
        b=GxXyYj3dh5gkghh3tLHE+DnZq8uDjq0WYz8L8WDwtcAPR3uvJYthv0o6Vr9xk2Q1Fb
         EoqY6IyyqaHIco7uGkF/I5EQXlqx3+ZtpnOTWG1FEqyJt1UE1xBo20NWhdPRSBJ8v0OK
         GPx1YX/MZhEvFT5AcluComn5qiXej0OnIxMbPw6S+8BYStJAHjn2PnBtmjMJEfmFOWJZ
         RPoIPW1IOwJwsjZvfv1kfUwy1nDmAjLoQtZAl5AxUzzVavYvbW1kuiqMa0/GAwKaniAh
         oMOtLaq0641KhJxw5ZXQhLZkGE/Jc+5djYgqgnGbEspxL2XHsOBK3csiJ67KDByg67/9
         cTaQ==
X-Forwarded-Encrypted: i=1; AFNElJ9l9PAHBgRd+YfCtYsZhfauegH/ETlLJEg26O3kngiL8LfVfFC+/IdBpi8d6Jl56fCz4qqATw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxaOd7e95k1K+YZEbBOnSOKkh6REkxg24GENg2qAUR0bEJroL19
	j44PTNbnhIiQcxfIe2oISZzL3xKF6Z50USAydMggHBhaHY8zabTjxdmGExZdx3FHel5w7Linv4D
	+mQ8IC/dL3RJ2Lm6bgrnJUmTYBESpxWs=
X-Gm-Gg: AeBDietv5s/ZDk89yNkQBtYY74cOiPZ//eQUZ8l/jboR9MohKSTP7DRB6O2r56jP3Cx
	oyiaEpu2oKtjNfPxwlQ8Jfyd4DRJvmYrydyOycvvOHJby6ap/BK6N3YgfvoN28yjt7xHdQ4wRm/
	RyZ0pZ7SY9DpjdNI666BlcrvpZVr8l3k/XIASaTeJXr8K8i248PtNCh6vjo2+rh8afMAXP4KsbT
	iAvcOJ3EWLklM7VUUH4nZzYzRIHjWdvQmciAtTnNxhUXR695deHC8kgSmHcRp/9xQMjiRofA9Wk
	pBBOjgWIYQaHg2YDdGTq+9iSEJomSmMYcQ61PZ0USYcr5hFndf+j
X-Received: by 2002:a05:690e:4808:b0:651:87b5:2cfb with SMTP id
 956f58d0204a3-65310a2bd67mr8432622d50.36.1776694935371; Mon, 20 Apr 2026
 07:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260418163358.2304490-1-luca.boccassi@gmail.com>
 <20260418163358.2304490-4-luca.boccassi@gmail.com> <20260420-unbeeindruckt-besprach-910fd241c32e@brauner>
In-Reply-To: <20260420-unbeeindruckt-besprach-910fd241c32e@brauner>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Mon, 20 Apr 2026 15:22:03 +0100
X-Gm-Features: AQROBzAClrvsk3HyTqUc5DWxyYAnhGz9RpPk9svUhuaCPDSANrlVJfet0hJyIb4
Message-ID: <CAMw=ZnR0uVrHUNzNGu5BtZuSKDJAYmZGUX-HzSw7c4VnoeQgiA@mail.gmail.com>
Subject: Re: [PATCH v8 3/6] liveupdate: add LUO_SESSION_MAGIC magic inode type
To: Christian Brauner <brauner@kernel.org>
Cc: linux-mm@kvack.org, kexec@lists.infradead.org, graf@amazon.com, 
	rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260420_072217_322755_693B3037 
X-CRM114-Status: GOOD (  20.65  )
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

On Mon, 20 Apr 2026 at 13:26, Christian Brauner <brauner@kernel.org> wrote:
>
> On Sat, Apr 18, 2026 at 05:28:20PM +0100, luca.boccassi@gmail.com wrote:
> > +}
> > +
> > +static const struct dentry_operations luo_session_dentry_operations = {
> > +     .d_dname        = luo_session_dname,
> > +};
> > +
> > +static int luo_session_init_fs_context(struct fs_context *fc)
> > +{
> > +     struct pseudo_fs_context *ctx;
> > +
> > +     ctx = init_pseudo(fc, LUO_SESSION_MAGIC);
>
> I'd just call that LUO_FS_MAGIC.

It's specific for the session fd, so I'd rather keep it as-is. Pasha
what do you think?

> > +     return 0;
> > +}
> > +
> > +static struct file_system_type luo_session_fs_type = {
> > +     .name = "luo_session",
> > +     .init_fs_context = luo_session_init_fs_context,
> > +     .kill_sb = kill_anon_super,
> > +};
> > +
> >  /* Create a "struct file" for session */
> >  static int luo_session_getfile(struct luo_session *session, struct file **filep)
>
> Luo is going full anti-pattern here. This whole return via a function
> argument completely messes up the later codepths. We don't do manual
> get_unused_fd_flags() flags and then file in new code, and then fail
> in-between:

This is getting a bit too complex for me and it's all existing stuff,
so I'll leave it for Pasha and the other maintainers to look at later,
they are CC'ed

> >  {
> > -     char name_buf[128];
> > +     char name_buf[LIVEUPDATE_SESSION_NAME_LENGTH + 1];
> >       struct file *file;
> >
> >       lockdep_assert_held(&session->mutex);
> > -     snprintf(name_buf, sizeof(name_buf), "[luo_session] %s", session->name);
> > -     file = anon_inode_getfile(name_buf, &luo_session_fops, session, O_RDWR);
> > -     if (IS_ERR(file))
> > +
> > +     ihold(luo_session_inode);
>
> Right, you're now sharing the same inode among all luo sessions. So
> you've gained the ability to recognize luo inodes via fstatfs() but you
> still can't compare two luo session file descriptors for equality using
> stat() which is a major win and if you're doing this work anyway, let's
> just go the extra step.

I'm not aware of any use case for this, it wasn't even discussed, so
I'll leave this out for now, if the need comes up it can certainly be
revisited later. A singleton is nice as it saves some resources.

