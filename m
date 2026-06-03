Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E77CD6E4A
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 03:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AkUPkSV1yVhPwfuKkUdfLaMgLJzqLtKdtBHH9XilSKA=; b=t3fTDxznFcT6OyvsIAZPdlU9O8
	3l4mPXoOAB7ZZ2ntUl9NgKZUOZG43nF949OAQNQXkJzhuWwSLmCZ3TQzurZZ6vAWT5+MdxDyIKQ8c
	kqgVo3Pdu283xbPPq5quwDX2mQchlcMy8qA15UZpu9mAEr5/Kj65JgE5fSYXj8s8ba8pVM1JfhN2D
	r7T5MbecK/7bSy6bassnFiPRv62fgZ1pvZvUvbC7TkNWZqabY5PxW+LpHndpgiMKntOoiypN/HiH+
	PO+46QutgMYSIYg57EMYkR1suFQmxA6liuZ/A3+hxdQYAorxT9DSPEqrjfEGx5ecULOscAfh7xAMx
	HV0t+LDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUc0D-0000000E9qk-3F6X;
	Wed, 03 Jun 2026 03:10:45 +0000
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUc0B-0000000E9pr-3D3y
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 03:10:44 +0000
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-5177945a279so4025381cf.0
        for <kexec@lists.infradead.org>; Tue, 02 Jun 2026 20:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780456242; x=1781061042; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AkUPkSV1yVhPwfuKkUdfLaMgLJzqLtKdtBHH9XilSKA=;
        b=JL7bRocFTeuHiqyIc63bEsDGalrRGJtdraukfxYxYKcgy5GLHbC79OoYfWe8Qx3uJF
         3oMaPITHuwnTj/4j1qX9TkDx282eBnrChm0RNbjwKfXh6YDKY314CNQOZXDzz7qf3qRt
         H6e/fdoHLXTfOgzmdWQiZl0BKHT/VjsRYy1yDb7rYrmMXoQ0pwKVYYMlRo666u34FxzP
         fo2mX6TZrnj9jysoT6330SGze/cEnc2++94WfM/RbaIBwTNYQ+Yajc5zEe4E1tJQaRX9
         f4MjrCZYQtQBeiPiFfE8tARqWZ7aisbN1VLiNt02G6XmuHCuNeGIv9ESOAwfdsaClMCi
         f0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780456242; x=1781061042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AkUPkSV1yVhPwfuKkUdfLaMgLJzqLtKdtBHH9XilSKA=;
        b=V4emC4l3kmWjXyRZiPHRpt0OUafBL0oyBqyjUE8X5p3patO1GcOt6W0s3o9ssbxduh
         WAoopToiVDIrU53CKxUiIcWUqI3pz/ysodn60AGCEsmNKifpAnituOKjz85LEioHdl2y
         NjNYzCTZSgWwyGGBheh2ACxVnhZCEYr1xPsF+3RX7AN8gSy5CFLFCNDjiOvuch3Y+2Z+
         yJlIFIfTFS4/ni/VghzdBydolUVMIXCGfn2qQWZTobIKy4QfTEudfPXDQu0Bih5YAvKu
         OnF2nQQu4JEEwbgAroUlmYlUVXIBo1BQjBIGKbictx1m4Uog47aFhsDQxKtkPoJFjCBi
         PgCA==
X-Forwarded-Encrypted: i=1; AFNElJ8gm944WS4g/ZJbkU4S9hcUNAiDVkZkLLrc7WLr0+VL7ArTMiOxI4nrXPgeCLNSz7ZcwlZxVA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy5XDAaDFSdjY7h+ejcR2Qb62iPmGXWooAVQ15EQU3kndJgGLxk
	F8xaDTMVmw7ENwyoeCfVigf2HGpWvdy0h5kxrtCrAo3b3lb/nEPjHYgoRcEBolBS5Gw=
X-Gm-Gg: Acq92OG57LgRhslBDuGXrEBME1bSWxSoMGlVW6XcDlo1hvMu1liZw8+apodm3WByCAw
	bBCQwgMe9s+VdMNznvFEmz1qmSTufZWY8eCWx/09NsGufBD2SnnfRHzllCQmbGOQYx6lkjh/9XJ
	jPEnpv7BHFt3i0Zdz1P4S9QetjxRjC1SKBhrd7/yA81/FqLj5lX5TC6u02f50Tg+l0Mwt1/qISx
	LdiCbxR6+GbnTRhmn1JsT7+DN8KIwjWFYBk8tD9xs8fbMd8uwKhA5IdR+b5Eislmvkc8CUhJqG+
	4N/pFrcsN9QVWUvxFxHYfHxns1GfaDFOajrYnYMOJsK8G3lO/5EgZ3cGTWdlwD+TQu/EwSEk72L
	0hr8aHrcwuuB16EnFhOqB3VbvlZqRV3XVwQwk+ZAPVwJnvCGH0gHds7NDaWpOuDPP1BDk5JG9J5
	Pnz0tNjCdE5qKtTjx1A8RMX6nL891XE4CUUzL8rbNsD8noxxFqQH92xQNK9yWaZ9Ecs1ZuH8DZ
X-Received: by 2002:a05:622a:2487:b0:516:510f:2dd5 with SMTP id d75a77b69052e-517786c83c7mr29904991cf.28.1780456242538;
        Tue, 02 Jun 2026 20:10:42 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775c07f0dsm14637641cf.3.2026.06.02.20.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 20:10:42 -0700 (PDT)
Date: Wed, 3 Jun 2026 03:10:40 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	linux-kselftest@vger.kernel.org, shuah@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	corbet@lwn.net, dmatlack@google.com, kexec@lists.infradead.org, 
	pratyush@kernel.org, skhawaja@google.com, graf@amazon.com
Subject: Re: [PATCH v4 02/13] liveupdate: avoid mixing cleanup guards with
 goto in luo_session_retrieve_fd
Message-ID: <ah-YOeu5PYa4d8xe@plex>
References: <20260530221938.115978-1-pasha.tatashin@soleen.com>
 <20260530221938.115978-3-pasha.tatashin@soleen.com>
 <178038801485.119771.9514973100282773342.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178038801485.119771.9514973100282773342.b4-review@b4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_201043_815497_4DE8F645 
X-CRM114-Status: GOOD (  15.68  )
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

On 06-02 11:13, Mike Rapoport wrote:
> On Sat, 30 May 2026 22:19:27 +0000, Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> > diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
> > index 146414933977..8d9201c25412 100644
> > --- a/kernel/liveupdate/luo_session.c
> > +++ b/kernel/liveupdate/luo_session.c
> > @@ -291,25 +291,24 @@ static int luo_session_retrieve_fd(struct luo_session *session,
> >  	if (argp->fd < 0)
> >  		return argp->fd;
> >  
> > -	guard(mutex)(&session->mutex);
> > -	err = luo_retrieve_file(&session->file_set, argp->token, &file);
> > -	if (err < 0)
> > -		goto  err_put_fd;
> > +	scoped_guard(mutex, &session->mutex) {
> > +		err = luo_retrieve_file(&session->file_set, argp->token, &file);
> > +		if (err < 0) {
> > +			put_unused_fd(argp->fd);
> > +			return err;
> 
> I don't like piling up error handling inside if (err) statements.
> 
> As we only need the lock only for luo_retrieve_file() I think it's better
> drop the guard and use goto:
> 
> 
> 	mutex_lock(&session->mutex);
> 	err = luo_retrieve_file(&session->file_set, argp->token, &file);
> 	mutex_unlock(&session->mutex);
> 	if (err)
> 		...

ok, done.

> 
> -- 
> Sincerely yours,
> Mike.
> 

