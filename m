Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C79CD98CE
	for <kexec@archiver.kernel.org>; Fri, 12 Jun 2026 17:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0ifKMUC6sFpR43pSlkSu8t/hrhXmnCH8Plz+P3dkdA8=; b=rQOW/+SPTurqY7GOJpd6DPJ0LR
	VH9dyX0YNGi5wtOsN4Zzq4yPaTyZmyJuwS1Gf2nMWYvxXGrgQ0e7QT+ImvOyKDRkpUO2ry+KZ2Cn3
	UR9p9s7Kkhmw62clRJ6rRcVfoNQ13PYLTRR9xuLnApnoODaIpLkASG8JW/OIVL4hQzGHGA2t2Z1ig
	WfRDV+l+eMYvlOVN94x7y4K9Z0c9smox4Mc5g8DsM9GfkDU0eznbk3OJL2yIr9kBi//vMG8qdu00m
	lE3yt7kuKF8RWgxsT9CyuK7yX9vzSexbVuwa0YPlHfE/RFqCKXFw7mcFiwUTsCAgG7Wgok8+gRXx3
	qissnvvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wY5mD-0000000BM1l-1Gb1;
	Fri, 12 Jun 2026 17:34:41 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wY5mA-0000000BM1Q-30Sn
	for kexec@lists.infradead.org;
	Fri, 12 Jun 2026 17:34:40 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2c0b1a48855so6125ad.0
        for <kexec@lists.infradead.org>; Fri, 12 Jun 2026 10:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781285678; x=1781890478; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ifKMUC6sFpR43pSlkSu8t/hrhXmnCH8Plz+P3dkdA8=;
        b=ZYofhnwAm10/XXU19jBhI58SwOEyWhYrwDweIg1QcYUcbkVZid1QhadojD9WW8dnYg
         LPkumi5icsxL/MLZnGCOT1L+c2970Ev6smJJE9yLuds90k5s4dcaIKVqoLPFOBx+jXuk
         c+oitUrI3WCw6XVfjzGV9jcu3xphtAP8I48AMc+xjFlkN0hNKHzZfnDetmjiHnVP7wNf
         ebvvXcQBrO9OtPKSNsTtuHgODYfGqlXUuVfV+xxsVO2VRyJT1GRjeE4ESROxqwKZ0KhX
         XUkQd1ejfuHguyYKm743Yuyr9uEdzJlOPeolOpblgjvikX6ghEwGTLtnSM9xaYmcITIy
         wA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781285678; x=1781890478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ifKMUC6sFpR43pSlkSu8t/hrhXmnCH8Plz+P3dkdA8=;
        b=CPd21nJVoMMVcpC/j6EUZhSTXy69u9fXBGeejrucAUYebCl5+DTxe66V8BPXCy6uwo
         Fb0Cxn0hH1ADh3HSlpXbpkxHcXOKTdtzZild5GzaI9FaoJ2PhJQ6zGZhe++wwN9EyZsm
         AgKLhXwo24Vza8JkKG35cDtMVj7DfasAYO75Ei7YZO6FYDKTYJp4/jGF0DtLIkD7SMdb
         Fs5tNBbHOCHYMN1Kz5FHckC9wG79nkSSqAYHEM48+LoqWkcPLW/0BdHgeSt2SM4Pi2hr
         DejJ43gLZ+wE3HsRcIHtGRAIyb+b1L5yzExKWM0OXhY7iJEIYIQWL8Olvlmb27TD+TkX
         F5Lg==
X-Forwarded-Encrypted: i=1; AFNElJ/xMD8GKtNfC5PeQocZVO1MZhmwGd+8zTs8HQJz0gwq3yK0PfrD1qL0wBZR/Tduw62g70xdGQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw79gHS9IBYB8CgLyZCXiWhF/ir+tvH6QGHos5Iqg0MZdUX1TSo
	HET+bttt+PFKgI92Z/QeUyw1RWZC3Qb2cATK+hG8q3s97zFaERWZfDwZP5Q8Dq1cnw==
X-Gm-Gg: Acq92OFjrA9Gw4FmaN9TFMI8vg93/uXYzvmD494sH3DHpSqLoPjhgk33E4eFjtNMNKK
	xXaFQt64ZOEJiA5I+xCQC/H0ljchEoGuy8lrklRvWhcS4X2XMLiw/Ancgf6CDYq4H3HBORnkgW7
	3ZAXqJZ5X2A4S/sbdsCTuWSAMIqPkbTF9V/dxJ7GrnKRk3kfFfUSouswMNupr1HtJzXOXMJ74Fe
	1d5IVeyEke1lz4rCwL4Gg11d+Qxu8IODhgCt9MnrLTB6/uvdMxtggG2fFXlgmPEDRd0Cuiiwim4
	PjK5Ie7zry/J5j3sqPF9tfCl3CLe2Vwwpq5heLFj37u3vZoC9QNa+rA4DVaGwYHn37nsGgQt4+y
	knwVEzQT3nfSU/aeT4+hhXHTiPYxRy6wr4KXmXs7KuUyMThMpscE+OzyrExCKjLgU8JA4zXDJG3
	S8pPPFl0dDwR+Y8v39KGI2jbCJhyvvFcOjoR9y4lQpFY3tb3bQWk4VA1zRFomT
X-Received: by 2002:a17:902:ea0d:b0:2bd:63cb:c5be with SMTP id d9443c01a7336-2c665175772mr102415ad.5.1781285677239;
        Fri, 12 Jun 2026 10:34:37 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42fbb5411sm27322505ad.32.2026.06.12.10.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 10:34:36 -0700 (PDT)
Date: Fri, 12 Jun 2026 10:34:32 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: rppt@kernel.org, pratyush@kernel.org, tarunsahu@google.com, 
	skhawaja@google.com, shuah@kernel.org, dmatlack@google.com, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/2] selftests/liveupdate: Add helpers to
 preserve/retrieve FDs
Message-ID: <20260612173145.GB40404.vipinsh@google.com>
References: <20260610230909.876546-1-vipinsh@google.com>
 <20260610230909.876546-3-vipinsh@google.com>
 <178123377287.908199.15268768789704684712.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178123377287.908199.15268768789704684712.b4-review@b4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260612_103438_765088_FF7F893C 
X-CRM114-Status: GOOD (  13.99  )
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

On Fri, Jun 12, 2026 at 03:09:32AM +0000, Pasha Tatashin wrote:
> On Wed, 10 Jun 2026 16:09:08 -0700, Vipin Sharma <vipinsh@google.com> wrote:
> > diff --git a/tools/testing/selftests/liveupdate/lib/liveupdate.c b/tools/testing/selftests/liveupdate/lib/liveupdate.c
> > index 897c200f3845..961a732b541d 100644
> > --- a/tools/testing/selftests/liveupdate/lib/liveupdate.c
> > +++ b/tools/testing/selftests/liveupdate/lib/liveupdate.c
> > @@ -78,9 +78,35 @@ int luo_retrieve_session(int luo_fd, const char *name)
> >  	return arg.fd;
> >  }
> >  
> > +int luo_session_preserve_fd(int session_fd, int fd, __u64 token)
> > +{
> > +	struct liveupdate_session_preserve_fd arg = {
> > +		.size = sizeof(arg),
> > +		.fd = fd,
> > +		.token = token,
> > +	};
> > +
> > +	if (ioctl(session_fd, LIVEUPDATE_SESSION_PRESERVE_FD, &arg) < 0)
> > +		return -errno;
> 
> We do not return positive values on success either, so !ioctl() would 
> be a tighter check, but < 0 is also acceptable.
> 
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

I have to send v3 for other feedbacks, I will address this also in that
version.

Thanks!


