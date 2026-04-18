Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47013F99C79
	for <kexec@archiver.kernel.org>; Sat, 18 Apr 2026 11:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gl517aJcU4PMdX8eaRxtC/lN2VtLqj0fIdLDkOXnkLI=; b=J/PantsrW1mD8CMA8rKhv8tu2R
	pUiDeZxSgj96FfxQCQhoyob9ooMnvE84loAeMhinxGTdVC5qKUSPLeID3aBCvhVNeb+JMtOiW1Lz5
	HBbW1kucSGtso6cELtZ/O8wp4P9/keFnEhmaDQE3Mk6tKzvWTf9fwM27+RpV7ZiiHgYB9SBDSxUXS
	yBKPF1v2s7fX6xMZk9GSxkVaL56Mqe2oKjVWyy4Zr7s9xk0f6KclAGr/cVeBtovZmNTz8As9ldyki
	po0HJT6ifTEoRQj8YRaknBpNo8pUdWEBtTf4lOwYdDbVTgFOeNJgcwenQmpCsMxFkYaykGXbBvxHQ
	xCffgyxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE42S-00000004x8m-1y4M;
	Sat, 18 Apr 2026 11:40:40 +0000
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE42O-00000004x7s-0Ubl
	for kexec@lists.infradead.org;
	Sat, 18 Apr 2026 11:40:37 +0000
Received: by mail-yx1-xb133.google.com with SMTP id 956f58d0204a3-651bf4a4140so1630459d50.0
        for <kexec@lists.infradead.org>; Sat, 18 Apr 2026 04:40:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776512435; cv=none;
        d=google.com; s=arc-20240605;
        b=IWc5vGAPBbUkZfn00LD5+3IOZb99HMwXIAKIGxp4E8lG67+EC+gT9A9sxz5tWnZKbB
         Q5ARBZ5/2xYhng/faHd1eMWFFR4FUoKI1pyd54+VyrGJnGVkzChImOpx2DGhQKNUEQQH
         6bEI6KXpclkZUTj2ulOkMoamFqDfH246YnrHUpurbHKY6yv1lYcfyr0DIiZzts0i1aml
         LXe0u79nF3CtHbrENiSkmnw+lriSkkyvgCfZAWGr205TQlWYClZa6QN80IpIB+a03exL
         n4eBMxC+38kIshn+GkxcNXMM02kKIhtyQgW98zS+Ue2dy159/BmEOyI816dmadHTO7aO
         9zMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gl517aJcU4PMdX8eaRxtC/lN2VtLqj0fIdLDkOXnkLI=;
        fh=lfpDnHrRrA3hnfLuAB3WY/TkEmve1iZbn8duMFYu5m4=;
        b=TqmjhcQEHRgRWhmJb8tOXTL4OXIU1QWXQNfP67KVDLqxHoJRMKNeFQDB+vhSHLRpKm
         9qDHAIX0P51wlLY8fcVsWl1Oq7BaVauq9+7Gc1ZvJParFGp1bVqrOPun1SSEShzyhYLI
         nTQu1aU6zz5mm9ZW3LhGp/zt2MJODcYolPj9UAAXeoKoOrXX5BgXe3V8KD2knZl3ckrC
         kOQSW9aCOaRr0TPvWxeCbFwJIEykAE8DxR+UnmQjw4dS2L0pwryXeyltC3n/WJ8W2of/
         ArJ61cLrPjQSV3UTBGIJEf7MCfqYpllyBIi9QUS7CN1IlzAgW5mllki/l8W86MIoE8mt
         bR9w==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776512435; x=1777117235; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gl517aJcU4PMdX8eaRxtC/lN2VtLqj0fIdLDkOXnkLI=;
        b=Wx9SKbbhM3wcajKqSD2a8lB1FZSc/SYeDSYUFWsWKxaEX0dFqzCDSxbbilRj6kkOsU
         5G8KAqNHTsaYiVJ7XxFIXokl6KGNSNgH+kLFEX6va9rl7xK1Vr1bUuplX5oCD8jLz+sJ
         ip3CyKTF1egVyC87n/qRzd787xrtBXC15dgDJLhRLFXBnQjLNyzRRVm/kV3IreRRecRT
         Bssl38TA5eEVzUv9JR1OixCcFOuwVct70dXp5UYYLRkCscyz8ZGRPLnXzNJY9IARyB9L
         ylc0Px3Y1m7mAHhAQEhnsQBwd3sXaW1+UaIiis633u+f4oUj+Ch1kSrMoxdKSvuq51bg
         KsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776512435; x=1777117235;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gl517aJcU4PMdX8eaRxtC/lN2VtLqj0fIdLDkOXnkLI=;
        b=kTPM4aH3UssT6+iNrX5VT4ufZDcVNtL9P+vX17P2MPdR2YCKmhAIyten42sF26Q+yX
         w10X/DJoOa+6TgEtL2QjOo0Fc2h1VG4kPcICvnrlIcRkdoGS6lbfGT2asQ45w8VUUkPk
         bNlh2agTgotwVFIS+RqHnm3qgC9hp9sM8FcrYNjusOBJ9O2+2jty2Z0+opcPGyhL2o5D
         9bbx01IlBgBRpDm74geN9YXHaGR9RYrd9V5pCJMtiaaqq83hRd5IgTE9kwJ7pXpzgPKw
         qcQpq+FIj/EvswceWSW8DuF1sPvdzearlDfGOhwfeS0nNRNAvZegY9WhS5gphnW79k0j
         R0SA==
X-Gm-Message-State: AOJu0YwPNFs5kKA2Lv3+xMfc0bI1e2cCwyoJfht2xKDJ+TsJwwm4oczV
	WIpO8vceg2gC31815Vmn9+JnZVZHzpqsYbmiguMkTrz5qIJVMjqYQ16CwktTCWLZZhw3eYesBE8
	l6odVTtut3BiAflhPF8f7zUE7SUdj/pW9hA==
X-Gm-Gg: AeBDietxhNVkdIKkUnx+Ns7EihqIN81zTerOo8U0wHPxRK1L5cHOQvXKDLJvU/6vdsN
	7dkOJZcBmOKCQP9mrzRQypXD7sf+VfVeFdDyOyMxmRbST9XZteqxh5E/4uEQwPF7iV0jbEiWpVz
	bLrubgTOoeNK2ivmPnTly3HqMuNn/M25Z+OuiwJ63ov2P7E7Onnpf7erSq4U9yOuLt16048MZJw
	JiulossUAX+UaS4wVjqRy6H9l0cSyDtpAfiD4M4zbehNiaAWDK9Xa6PA8nAcOXCxgO9maVezcOj
	2pSsCfJJX9zLyXS0SfAlu0bvlyi5PJokoIMdWBsoRRqpvcTjB2dU
X-Received: by 2002:a05:690e:1349:b0:651:c128:54a5 with SMTP id
 956f58d0204a3-653107ca180mr6315370d50.4.1776512434971; Sat, 18 Apr 2026
 04:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260417220831.1934945-1-luca.boccassi@gmail.com>
 <20260417220831.1934945-4-luca.boccassi@gmail.com> <qwztxisl7vf3ukjqrv62msq6iaavnru2kyays6ye7rspg2uej2@62cwrsshdxfu>
In-Reply-To: <qwztxisl7vf3ukjqrv62msq6iaavnru2kyays6ye7rspg2uej2@62cwrsshdxfu>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Sat, 18 Apr 2026 12:40:23 +0100
X-Gm-Features: AQROBzBTqS41n0peew3A6sLX8jfBm27PBzQwb6HocYnw3czGZM1VNVC-vDu5Icc
Message-ID: <CAMw=ZnRXYjjuqVBbNOn5aQM9MTmXsizz1ZgfebnunMadPTc4tw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] selftests/liveupdate: add test cases for LIVEUPDATE_SESSION_GET_NAME
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, graf@amazon.com, 
	rppt@kernel.org, pratyush@kernel.org, brauner@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260418_044036_185728_8C8CDD64 
X-CRM114-Status: GOOD (  22.69  )
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

On Sat, 18 Apr 2026 at 05:17, Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
>
> On 04-17 23:05, luca.boccassi@gmail.com wrote:
> > From: Luca Boccassi <luca.boccassi@gmail.com>
>
> The commit log is too empty. Please explain what this patch does.
>
> > Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> > ---
> > v5: merge with LUO_SESSION_MAGIC series as they both change the same
> >     unit test file, to avoid merge conflicts
> >     split into separate patch
> >
> >  .../testing/selftests/liveupdate/liveupdate.c | 71 +++++++++++++++++++
> >  1 file changed, 71 insertions(+)
> >
> > diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
> > index d132b4685f767..f81201b363cc1 100644
> > --- a/tools/testing/selftests/liveupdate/liveupdate.c
> > +++ b/tools/testing/selftests/liveupdate/liveupdate.c
> > @@ -105,6 +105,22 @@ static int create_session(int lu_fd, const char *name)
> >       return args.fd;
> >  }
> >
> > +/* Helper function to get a session name via ioctl. */
> > +static int get_session_name(int session_fd, char *name, size_t name_len)
> > +{
> > +     struct liveupdate_session_get_name args = {};
> > +
> > +     args.size = sizeof(args);
> > +
> > +     if (ioctl(session_fd, LIVEUPDATE_SESSION_GET_NAME, &args))
> > +             return -errno;
> > +
> > +     strncpy(name, (char *)args.name, name_len - 1);
> > +     name[name_len - 1] = '\0';
> > +
> > +     return 0;
> > +}
> > +
> >  /*
> >   * Test Case: Create Duplicate Session
> >   *
> > @@ -385,4 +401,59 @@ TEST_F(liveupdate_device, session_fstat)
> >       ASSERT_EQ(close(session_fd2), 0);
> >  }
> >
> > +/*
> > + * Test Case: Get Session Name
> > + *
> > + * Verifies that the full session name can be retrieved from a session file
> > + * descriptor via ioctl.
> > + */
> > +TEST_F(liveupdate_device, get_session_name)
> > +{
> > +     char name_buf[LIVEUPDATE_SESSION_NAME_LENGTH] = {};
> > +     const char *session_name = "get-name-test-session";
> > +     int session_fd;
> > +
> > +     self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
> > +     if (self->fd1 < 0 && errno == ENOENT)
> > +             SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
> > +     ASSERT_GE(self->fd1, 0);
> > +
> > +     session_fd = create_session(self->fd1, session_name);
> > +     ASSERT_GE(session_fd, 0);
> > +
> > +     ASSERT_EQ(get_session_name(session_fd, name_buf, sizeof(name_buf)), 0);
> > +     ASSERT_STREQ(name_buf, session_name);
> > +
> > +     ASSERT_EQ(close(session_fd), 0);
> > +}
> > +
> > +/*
> > + * Test Case: Get Session Name at Maximum Length
> > + *
> > + * Verifies that a session name using the full LIVEUPDATE_SESSION_NAME_LENGTH
> > + * (minus the null terminator) can be correctly retrieved.
> > + */
> > +TEST_F(liveupdate_device, get_session_name_max_length)
> > +{
> > +     char name_buf[LIVEUPDATE_SESSION_NAME_LENGTH] = {};
> > +     char long_name[LIVEUPDATE_SESSION_NAME_LENGTH];
> > +     int session_fd;
> > +
> > +     memset(long_name, 'A', sizeof(long_name) - 1);
> > +     long_name[sizeof(long_name) - 1] = '\0';
> > +
> > +     self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
> > +     if (self->fd1 < 0 && errno == ENOENT)
> > +             SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
> > +     ASSERT_GE(self->fd1, 0);
> > +
> > +     session_fd = create_session(self->fd1, long_name);
> > +     ASSERT_GE(session_fd, 0);
> > +
> > +     ASSERT_EQ(get_session_name(session_fd, name_buf, sizeof(name_buf)), 0);
> > +     ASSERT_STREQ(name_buf, long_name);
> > +
> > +     ASSERT_EQ(close(session_fd), 0);
>
> May be add a few more edge cases: i.e. no '\0' termination name, or empty
> string session name?

All fixed in v6, thanks

