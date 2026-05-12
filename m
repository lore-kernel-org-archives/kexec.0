Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F809CD343F
	for <kexec@archiver.kernel.org>; Tue, 12 May 2026 20:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Sq67mJ1Mle/Wjax+ZhdINyyVrcamDgHQ2bN9yr1Zbf8=; b=Ab4F2E/AVjHFiGdhHtszcGNfXa
	sZ9gOHGzCrtwm6kArZWJjgenq/ZlmCdeXt/xWKFtcJboq+X7VTIGhRzwuwStok3htxjx5UPQzM+Gy
	WpZVZwyjyAj9X4n5G7EjsBY9oeaxwci6NqHUi8fOcxVFsXAI23zFlVbog2wQqk8gs4W6ZO62z4D16
	cWErB3ENkz63nz2jBNvnjOy/gEq6PyRSaDKGyQFiOxt4xF+okWg3WcrLDhYjjZTXZxDYMfuKObOhF
	pbM+b0PU1Z5R/Dv5zCr7CsobyEDzedW9F7J1NrKAcTaGXQOrdZc3v29zbXVBr3FZmkFXsdqREzQCg
	1KcoJHnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMtux-00000000MlQ-2U1A;
	Tue, 12 May 2026 20:41:27 +0000
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMtuu-00000000Mkq-2sCk
	for kexec@lists.infradead.org;
	Tue, 12 May 2026 20:41:25 +0000
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-8ec37d52c0dso839509285a.0
        for <kexec@lists.infradead.org>; Tue, 12 May 2026 13:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1778618483; x=1779223283; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sq67mJ1Mle/Wjax+ZhdINyyVrcamDgHQ2bN9yr1Zbf8=;
        b=RI2N2WJlrc/HHcauOvPa8rVx6o6YIKlVSmifvhwDz/qntlh1+1fYiJJN/TnLjKbAcV
         ahIqY5OLu544jqMYY7WRO5WmGuyzI0UbdOYXvXQuZDdt35iewpecsjHxzdyoImN+IDUM
         f3q/9u8NhnLKSJGFVOzeo1J+lfcGdykBfDhA8NSN2h3rDDXTMjpAbDgLInbSh1hCpiWU
         WiVP5vJmKLmwHOct7QD/i0J+Oz1r4lfY29OYyPirR4mn5xmsoKYxE33mhy1Lqzdh2/pG
         BPT/hsREzX8Vj26eZvfInbJHpXRkl8B5Mzn7yd8YYxwW26lWqBx31dVkZIOUTi7MR4Bo
         fBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778618483; x=1779223283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sq67mJ1Mle/Wjax+ZhdINyyVrcamDgHQ2bN9yr1Zbf8=;
        b=EkxpCPm22zt56XF5lkySVUw+NpVgCOScGvSF3z3jhi4sBw+H8nTW8TdmyXHhTRAgCH
         QUYf56zZU5XbmJf8EZcZKBajMws2PWl0yUlMgryKmQdpbN/1B1s6YzOzo0RstAVUL2pw
         PECTUVp9e2r0DEaT/JXWlJ6yeqv9ADXtpS7Odg6+PGMLDVkd2LWXo+pKX0zn6c5xkkgK
         Fx0cFYmDlqaBoiGcTYouhXEb0cDP25jn99U8DoZ22VfTEhJfPU33IUkJ6ZIB+x402b+Q
         kwXAfN5zi9cfX/0LDkvo4At37JDFbZPEj3NrmUlRyBVoc/QwE+MYtQkLsBIxNw3VjBoU
         iv9w==
X-Forwarded-Encrypted: i=1; AFNElJ+EuVeLVrXC1XuQcAGnjmQ/IysU5A+wW1iqX0+0ynzANdg9HQlK4kgCgIQL1FR/PbX90zDePw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxjkuz4ywXCbDvQrffDfFF0q3RddXw1ua9oqoeKIqMCmxwIiVYD
	LGapetNaPCYA8+eIXPdEAXLPnyMtDl/ZQmQlJCiLtZn9fjscY7SmKsyggNcHUH1j/Mg=
X-Gm-Gg: Acq92OGpQ/2P29OETX3hkc4y9B4CqGC9Xnhnr5js28vD2NiqMTDDuzf4KZqcIL0xI9f
	qs5QN/POB2IcjOh76Zm098Q8SVjP1agBhWAzT3f+0y/5BMhDAdQhDlCa5hwfYY2Hbsup5iC/H5j
	vP2C+xI6CG/DnSilAp6dHHXnPrU+3y7cvtOCGqF09OA7BsV7vBOlsJU/hPN6nM9Lmlj6Evs22F1
	cNDiARO5iz29Jy68sIQXyV/sDIcwbKP+3xTtltfnsKOjo7QoaqSIpjvb5HCed/Mqlt10NiP5N/P
	fdJOw8sj8+D3+ZtT0A0WROyw49Y9/57e/pgvyjLwRasa8agfG5D6kESefC+bGxsgD6woW1N5CHM
	H0ZCOWVu7g6yaV8M/xpWSipJedLmYp3eWZCrgTvvIQ0bglR5UUnNAUOrRyc4yUnLLzfbubgiwru
	ry+pAPehgG9v9LUzfIEy7vAkPLJZ0nkDN6yNJEWOYnyymvZc2pcbA=
X-Received: by 2002:a05:620a:4593:b0:8da:d152:b7e2 with SMTP id af79cd13be357-90f88f92e19mr94041885a.25.1778618483528;
        Tue, 12 May 2026 13:41:23 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-90cd7a6c35csm354234285a.42.2026.05.12.13.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 13:41:23 -0700 (PDT)
Date: Tue, 12 May 2026 20:41:21 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	linux-kselftest@vger.kernel.org, rppt@kernel.org, shuah@kernel.org, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, dmatlack@google.com, 
	kexec@lists.infradead.org, skhawaja@google.com, graf@amazon.com
Subject: Re: [PATCH 4/5] selftests/liveupdate: Add stress-sessions kexec test
Message-ID: <agOQa0aGZMVRlCu2@plex>
References: <20260414200237.444170-1-pasha.tatashin@soleen.com>
 <20260414200237.444170-5-pasha.tatashin@soleen.com>
 <2vxzlddoafel.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzlddoafel.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260512_134124_736772_B1ACA6DE 
X-CRM114-Status: GOOD (  21.12  )
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

On 05-12 16:09, Pratyush Yadav wrote:
> On Tue, Apr 14 2026, Pasha Tatashin wrote:
> 
> > Add a new test that creates 2000 LUO sessions before a kexec
> > reboot and verifies their presence after the reboot. This ensures
> > that the linked-block serialization mechanism works correctly for
> > a large number of sessions.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> > diff --git a/tools/testing/selftests/liveupdate/luo_test_utils.c b/tools/testing/selftests/liveupdate/luo_test_utils.c
> > index 3c8721c505df..37c330b9bb36 100644
> > --- a/tools/testing/selftests/liveupdate/luo_test_utils.c
> > +++ b/tools/testing/selftests/liveupdate/luo_test_utils.c
> > @@ -20,6 +20,7 @@
> >  #include <sys/stat.h>
> >  #include <errno.h>
> >  #include <stdarg.h>
> > +#include <sys/resource.h>
> >  
> >  #include "luo_test_utils.h"
> >  
> > @@ -28,6 +29,30 @@ int luo_open_device(void)
> >  	return open(LUO_DEVICE, O_RDWR);
> >  }
> >  
> > +void luo_ensure_nofile_limit(long min_limit)
> 
> Since you are adding this to luo_test_utils anyway, I think you should
> do it in patch 3 and use it there too.

Done

> 
> LGTM otherwise.
> 
> > +{
> > +	struct rlimit hl;
> > +
> > +	if (getrlimit(RLIMIT_NOFILE, &hl) < 0)
> > +		ksft_exit_fail_msg("getrlimit failed: %s\n", strerror(errno));
> > +
> > +	if (hl.rlim_cur >= min_limit)
> > +		return;
> > +
> > +	hl.rlim_cur = min_limit;
> > +	if (hl.rlim_cur > hl.rlim_max)
> > +		hl.rlim_max = hl.rlim_cur;
> > +
> > +	if (setrlimit(RLIMIT_NOFILE, &hl) < 0) {
> > +		if (errno == EPERM) {
> > +			ksft_exit_skip("Insufficient privileges to set RLIMIT_NOFILE to %ld\n",
> > +				       hl.rlim_cur);
> > +		}
> > +		ksft_exit_fail_msg("setrlimit to %ld failed: %s\n",
> > +				   hl.rlim_cur, strerror(errno));
> > +	}
> > +}
> > +
> >  int luo_create_session(int luo_fd, const char *name)
> >  {
> >  	struct liveupdate_ioctl_create_session arg = { .size = sizeof(arg) };
> 
> -- 
> Regards,
> Pratyush Yadav

