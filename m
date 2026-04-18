Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F04CCF99C79
	for <kexec@archiver.kernel.org>; Sat, 18 Apr 2026 04:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cP27zeRun5nCnbgqutW/rz1GusWQaq6Mzm9A44tQDsk=; b=sQCY96JiaZkjg0tglTfr9RyZ3c
	NhFzHqlbhfSucDpPfbCtYfC+t+yO7oNwekBneNUsScpFrurpK6C78tdMa/uJ711E7rZMPh1/ZOI8o
	aSXtE8CTk7kzFFebD1iEQKnhhwJMT0iXu9F6Q702/BWzxWlIwN4kIvs+xAa3bjvuztAMz1dQs9FdN
	e5Hb9MLYUNk1e/MWIxa+lW2ccY8PRcmZb/O0jpYpHFFO8zHhSXHWQGtjKck4cLeCyryMRQ+8HQ/mT
	H/nbLVaJFGG6fB/YwONdrZ79Khhbh4v+1BVHpCnO4SRYcmrUOEkKCG9FjJLoBDnn/nMvGwrlthQ83
	eLN0EkRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDx7l-00000004j3w-1tJH;
	Sat, 18 Apr 2026 04:17:41 +0000
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDx7i-00000004j3R-2hCZ
	for kexec@lists.infradead.org;
	Sat, 18 Apr 2026 04:17:39 +0000
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-8acb3daf2aaso21623146d6.0
        for <kexec@lists.infradead.org>; Fri, 17 Apr 2026 21:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1776485857; x=1777090657; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cP27zeRun5nCnbgqutW/rz1GusWQaq6Mzm9A44tQDsk=;
        b=I62NVKMBl6C39AEmer+oFaHX8CEA0kY7StEg4yG1khaBNusjxKFEfdgiigvfDzvewT
         pWR8we3yzJqSaU0XLiofWyIFm4UofrOs+9D2pNGg/YVJHCZNEH9CBkCyEB4GDF54d+YX
         kGx40p/HCBhx1QXjikl7wlCcjBxGrXIWpwrULNwIukcci1QVKTZJeGVGe9cZWMqwwIbD
         2S81+RCVRxZPNgkqaMy8jP9SjIMQOQNe0E7Ud9t5AI7kVaIJ2m+kDrh4/1VeVFupEfOe
         wjMyOlgdOBRarjiefbs/PxDpG/bwuRNpnrWZsRmjVcir9uHbbmLkIB6PY61JXR5f0Cxn
         +dgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776485857; x=1777090657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cP27zeRun5nCnbgqutW/rz1GusWQaq6Mzm9A44tQDsk=;
        b=P29Uw8tg5uHRIc3MyN5plThHVOTU89DCJSkIubo8WLzB3sg8XxKMy94n8NddnihgB2
         B3gp8WxzL0LLPwfHs1RGJ6FUmXOth9+FOlYLtVNM9UeFRpqJxYnhXVFX0UJa/vhlKeQ7
         FVLwwGktQarDnaLY4EbEhlmHPcwAMC1EIHt1R8sdLzBr8NMCTctmYiYWaKap3PT9a5z8
         DY94Q/NO7J2LJRsobtIvSLXIvLocYlP0kqO+JXi/Jw/m9Ec2uAEXssWC2au2e8RcW8If
         pXzGFbTpf1UDfJmbkTXvxwTzBcZBWWQeNoLFWnEwMELej4kcumNCIygwL3Cb4Q1dsP3s
         FVYA==
X-Gm-Message-State: AOJu0YwJNubiPI0qck6uvpCRjhXu/nJ7jVeHNyzPBxIfjZQeeJVqvDyV
	n3ZiwDhh7EFB0XOnWmauZMPavz9QyvLJLYdgnxIH4kTXOiiyTqZFaKbGCkJdH9MBsxA=
X-Gm-Gg: AeBDieuGlRzAo7n3Iy9OjuFWERvQkCqcxj/SbW9yyfZLHG2CeC267GR5B8TlhsH43pv
	lr+9ijIaTOm2RbEOQoEIbCWhDv7iK3vgHH15B3bViHGHyrgBRee6OASKI088dHQvlbXRU+Nkjuq
	LggpgF3e7IuDKaVdg6a13bTBVEKBY79qEPc4JeNrPY1Ov+oq9HX0LobaB4EAF8uKgns+W8K2oV0
	BT+q+kFVuB2HFwe1CV8NQUz55KRYtba4gGdvfRI4I82ludZarSpym4AsYOZHoSHae+BoT6m6EBU
	1CbDIL/QZm6kI3kGe/28gN3TsoNsjkT3Eau9sn8oLTmsIyvhahLyZu/tCG6L4Eqqogd4pdnFBXU
	N5UlvagO56QdcP0iNhYmVdVSEZSWICc1H9UnLYDVrKKbTGWkmOdh+tqVDkbjdn4yTzHT8koHLZI
	i643bQ2uw0+kD4wzcHGC7NoYE5rgZ5yS+83Ex68TLVscsB3Djm5YNoFoYQQSax
X-Received: by 2002:a05:6214:4f02:b0:8ac:74d7:dd14 with SMTP id 6a1803df08f44-8b028167980mr85768556d6.34.1776485856935;
        Fri, 17 Apr 2026 21:17:36 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02aea5ebcsm26638176d6.44.2026.04.17.21.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 21:17:36 -0700 (PDT)
Date: Sat, 18 Apr 2026 04:17:34 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: luca.boccassi@gmail.com
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, graf@amazon.com, 
	rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, 
	brauner@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] selftests/liveupdate: add test cases for
 LIVEUPDATE_SESSION_GET_NAME
Message-ID: <qwztxisl7vf3ukjqrv62msq6iaavnru2kyays6ye7rspg2uej2@62cwrsshdxfu>
References: <20260417220831.1934945-1-luca.boccassi@gmail.com>
 <20260417220831.1934945-4-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417220831.1934945-4-luca.boccassi@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260417_211738_725181_D93A91D6 
X-CRM114-Status: GOOD (  20.34  )
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

On 04-17 23:05, luca.boccassi@gmail.com wrote:
> From: Luca Boccassi <luca.boccassi@gmail.com>

The commit log is too empty. Please explain what this patch does.

> Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> ---
> v5: merge with LUO_SESSION_MAGIC series as they both change the same
>     unit test file, to avoid merge conflicts
>     split into separate patch
> 
>  .../testing/selftests/liveupdate/liveupdate.c | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
> index d132b4685f767..f81201b363cc1 100644
> --- a/tools/testing/selftests/liveupdate/liveupdate.c
> +++ b/tools/testing/selftests/liveupdate/liveupdate.c
> @@ -105,6 +105,22 @@ static int create_session(int lu_fd, const char *name)
>  	return args.fd;
>  }
>  
> +/* Helper function to get a session name via ioctl. */
> +static int get_session_name(int session_fd, char *name, size_t name_len)
> +{
> +	struct liveupdate_session_get_name args = {};
> +
> +	args.size = sizeof(args);
> +
> +	if (ioctl(session_fd, LIVEUPDATE_SESSION_GET_NAME, &args))
> +		return -errno;
> +
> +	strncpy(name, (char *)args.name, name_len - 1);
> +	name[name_len - 1] = '\0';
> +
> +	return 0;
> +}
> +
>  /*
>   * Test Case: Create Duplicate Session
>   *
> @@ -385,4 +401,59 @@ TEST_F(liveupdate_device, session_fstat)
>  	ASSERT_EQ(close(session_fd2), 0);
>  }
>  
> +/*
> + * Test Case: Get Session Name
> + *
> + * Verifies that the full session name can be retrieved from a session file
> + * descriptor via ioctl.
> + */
> +TEST_F(liveupdate_device, get_session_name)
> +{
> +	char name_buf[LIVEUPDATE_SESSION_NAME_LENGTH] = {};
> +	const char *session_name = "get-name-test-session";
> +	int session_fd;
> +
> +	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
> +	if (self->fd1 < 0 && errno == ENOENT)
> +		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
> +	ASSERT_GE(self->fd1, 0);
> +
> +	session_fd = create_session(self->fd1, session_name);
> +	ASSERT_GE(session_fd, 0);
> +
> +	ASSERT_EQ(get_session_name(session_fd, name_buf, sizeof(name_buf)), 0);
> +	ASSERT_STREQ(name_buf, session_name);
> +
> +	ASSERT_EQ(close(session_fd), 0);
> +}
> +
> +/*
> + * Test Case: Get Session Name at Maximum Length
> + *
> + * Verifies that a session name using the full LIVEUPDATE_SESSION_NAME_LENGTH
> + * (minus the null terminator) can be correctly retrieved.
> + */
> +TEST_F(liveupdate_device, get_session_name_max_length)
> +{
> +	char name_buf[LIVEUPDATE_SESSION_NAME_LENGTH] = {};
> +	char long_name[LIVEUPDATE_SESSION_NAME_LENGTH];
> +	int session_fd;
> +
> +	memset(long_name, 'A', sizeof(long_name) - 1);
> +	long_name[sizeof(long_name) - 1] = '\0';
> +
> +	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
> +	if (self->fd1 < 0 && errno == ENOENT)
> +		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
> +	ASSERT_GE(self->fd1, 0);
> +
> +	session_fd = create_session(self->fd1, long_name);
> +	ASSERT_GE(session_fd, 0);
> +
> +	ASSERT_EQ(get_session_name(session_fd, name_buf, sizeof(name_buf)), 0);
> +	ASSERT_STREQ(name_buf, long_name);
> +
> +	ASSERT_EQ(close(session_fd), 0);

May be add a few more edge cases: i.e. no '\0' termination name, or empty 
string session name?

Thank you,
Pasha

> +}
> +
>  TEST_HARNESS_MAIN
> -- 
> 2.47.3
> 

