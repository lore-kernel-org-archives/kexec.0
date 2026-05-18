Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DADBCD4F3C
	for <kexec@archiver.kernel.org>; Mon, 18 May 2026 12:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HcUcaIPN/g+niFeOM76G8kvjbFhqNOUQJ3E0GM4bRDQ=; b=d+IP3kCT5O41NsH/Zj0oUi+WXU
	kyCbiTZvqUyCZeJgxAz/jkOn7WOjGK+KqwHzBULbpMk0ytQ7MLeQpzfutESGrO0yDdiHEzjD3GE30
	jXTtRPssrJ4Gi9+sbMMZDImiu+OmE851rupJc+UAe+qqMlyLcEN11k7whxZoyKrFitQmD51i8KAGd
	5aSrUs8SbAhcdLPtgbrQPQCXl6ieIBiyP71sQTU69ZBZByiFGSf8PbxRkdF/YDBaM6Ujh8TvlLjMV
	7JiaeXz8t2r06SMzEezPEhXpNoLIHU7LlItHXJgtEm1d1JIW/TS8DS+eJ9yXb9SA1WYq5IfyQ0NPG
	qDXez8vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOxGx-0000000Ffic-1TEi;
	Mon, 18 May 2026 12:40:39 +0000
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOxGu-0000000Ffh0-27ZP
	for kexec@lists.infradead.org;
	Mon, 18 May 2026 12:40:38 +0000
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-50e5eb0fabaso32863961cf.0
        for <kexec@lists.infradead.org>; Mon, 18 May 2026 05:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779108035; x=1779712835; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HcUcaIPN/g+niFeOM76G8kvjbFhqNOUQJ3E0GM4bRDQ=;
        b=eEzeEVFmW8sw2DelhTil3kXFHmkcrWjuz+UcTFmisityhXM+xZ54ILLkYi+hJfwJGz
         1X6+Ea9Sch08BbaMBr7lBV4TWXHwyAXSwkKATgVgYhWxoFHJiMz6YY0ahIN7ktwoKt69
         9CX7eG3dSuy3Cf7NO41dDsiTAX3C7/HLXk6dHpciIb9c8rR/FPzO0NVNTkJHzlvz5bCv
         CHB/yk6UjtFukR4He+2dnyTsdMnfRzSIWqjMgq/O/a3bAWs1aZui7RGC0WFLbCT637xX
         FwBs+qVnJQFVEmkyAmw694roJUGtVrgLmi6Ym7EoiCk7ucDu0LEDxtbmO3fQtY/Nc9Hv
         Mtgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779108035; x=1779712835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HcUcaIPN/g+niFeOM76G8kvjbFhqNOUQJ3E0GM4bRDQ=;
        b=hecHjJ+Rsc7JIVqwdAWofguxemw7/QFthayoRQL+5yckxyUQeks+m6N73nz5H2qX7v
         ae2uiwXv5Xi633kSb18Rbw7KclBUaGW044P/Bh2RsVKu0DfQBb+iNnZFtRWkwCAeb7S0
         rYKWnHhI8lKDV9LT0Rpbse+hNY/oTgviy/Ho2uL418Us4+3eZw0zLzKeCq4t0Hge8vbG
         cVuDsX2E/v52xzm8gKWF0GTm0QxopjFJZf841s+XuS8wNUaFldN0hBpLLBn3TOTtgifZ
         vVvfLvSCI3qqMd7todc26aV6E0557+1safIcMTdmK8WgS4ga5M63j05C6FFQrsezpfNi
         NDuA==
X-Forwarded-Encrypted: i=1; AFNElJ8OeiQZJk2/bVlUQ16FVw2EYgLkOs9h2O+FLfL5YlSt16+hvpMp3sVlrA2ZT6+Ohtmv9crTnQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzXUS8psNwf1LZt9qiP6zQw2EiCTQHSicskFwse6dUWzxH66fB0
	oU6rHxMth6IAssDGfeZaGIr3tmOIozTwBHjLZXf5m78K8xhLLAryWZffQ3zP1tR7844=
X-Gm-Gg: Acq92OFU2JbSXkxBr6X2L068BuYT4oCfdm6ybGaHFGg5wBB+rAT9+d8gI6xw+WKq//D
	tEhwCcx/XJ+zviD+oHlE2RrXza9SLQn2WH4zBJ1YXtMLbifUHwun15wxcojXbphVnoKswxjTCcP
	Uxtr1oQJB2dJR+q8MBquCa5bgqKS1DsqaiAlJ8nVaXkUfV7n6bg6EHYkwk7SNiFdwWpOd/EbNXi
	jyAa4iqyfVRPnA9QrEq228ADZGbPzh7gTME27vKd4/dOhNL8TIYE9ebZ9po83jSfuwizeuU2Jbf
	pJacGZOk05TTFT5LTrXDRz6uZxTpfeks5mIkNYTMLAY2lpLHkWPWl6J/Ebt3siPdmdvxOwE1iyp
	TCibddAgpUuKJS7Vw1+b1sBeSYHQ8rd7QKJUnsrTha/2m6KephT63yKUWujmPF8hdajXY8R3tKO
	pROsS8SKCmhfX2N508XVFdIPxzxVtyK82BTL01xNsXP4PznMuSG5o=
X-Received: by 2002:a05:622a:5a9b:b0:50f:d5c0:7f38 with SMTP id d75a77b69052e-5165a0ccb68mr197726121cf.34.1779108034984;
        Mon, 18 May 2026 05:40:34 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51645688bd9sm129855651cf.6.2026.05.18.05.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 05:40:34 -0700 (PDT)
Date: Mon, 18 May 2026 12:40:33 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, sourabhjain@linux.ibm.com, 
	jbouron@amazon.com, akpm@linux-foundation.org, bhe@redhat.com, 
	linux-kernel@vger.kernel.org, dan.carpenter@linaro.org, liaoyuanhong@vivo.com, 
	rafael.j.wysocki@intel.com, piliu@redhat.com, kexec@lists.infradead.org, pratyush@kernel.org, 
	skhawaja@google.com, graf@amazon.com, mario.limonciello@amd.com
Subject: Re: [PATCH v4 3/5] liveupdate: block session mutations during reboot
Message-ID: <agsIsQLQR8i1sF_A@plex>
References: <20260517192650.1019314-1-pasha.tatashin@soleen.com>
 <20260517192650.1019314-4-pasha.tatashin@soleen.com>
 <agrQaP22pgxOkR_j@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agrQaP22pgxOkR_j@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_054036_915072_1ED4F069 
X-CRM114-Status: GOOD (  22.67  )
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

On 05-18 11:40, Mike Rapoport wrote:
> On Sun, May 17, 2026 at 07:26:48PM +0000, Pasha Tatashin wrote:
> > During the reboot() syscall, user processes may still be running
> > concurrently and attempting to mutate sessions (e.g., creating,
> > retrieving, or releasing sessions). To prevent this, introduce
> > luo_session_serialize_rwsem to synchronize mutations with the
> > serialization process.
> > 
> > All session mutation operations (create, retrieve, release, ioctl) take
> > the read lock. The serialization process (luo_session_serialize) takes
> > the write lock and holds it indefinitely on success. This effectively
> > freezes the LUO session subsystem during the transition to the new
> > kernel. If serialization fails, the lock is released to allow recovery.
> > 
> > Fixes: 0153094d03df ("liveupdate: luo_session: add sessions support")
> > Reported-by: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  kernel/liveupdate/luo_session.c | 27 ++++++++++++++++++++++++---
> >  1 file changed, 24 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
> > index 59b37d17db6b..6099213275d8 100644
> > --- a/kernel/liveupdate/luo_session.c
> > +++ b/kernel/liveupdate/luo_session.c
> > @@ -385,9 +394,12 @@ int luo_session_create(const char *name, struct file **filep)
> >  	struct luo_session *session;
> >  	int err;
> >  
> > +	down_read(&luo_session_serialize_rwsem);
> >  	session = luo_session_alloc(name);
> 
> We can alloc outside the lock, will make error handling simpler.
> 
> sashiko complains about mixing down_read() with scoped_guard(), for this
> function it would make sense to use plain mutex_{lock,unlock} around
> luo_session_getfile()

Done. Thank  you for review.

Pasha

> 
> > -	if (IS_ERR(session))
> > -		return PTR_ERR(session);
> > +	if (IS_ERR(session)) {
> > +		err = PTR_ERR(session);
> > +		goto err_unlock;
> > +	}
> >  
> >  	err = luo_session_insert(&luo_session_global.outgoing, session);
> >  	if (err)
> > @@ -398,12 +410,16 @@ int luo_session_create(const char *name, struct file **filep)
> >  	if (err)
> >  		goto err_remove;
> >  
> > +	up_read(&luo_session_serialize_rwsem);
> > +
> >  	return 0;
> >  
> >  err_remove:
> >  	luo_session_remove(&luo_session_global.outgoing, session);
> >  err_free:
> >  	luo_session_free(session);
> > +err_unlock:
> > +	up_read(&luo_session_serialize_rwsem);
> >  
> >  	return err;
> >  }
> 
> -- 
> Sincerely yours,
> Mike.

