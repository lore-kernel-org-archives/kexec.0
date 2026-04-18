Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EEC3F99C8C
	for <kexec@archiver.kernel.org>; Sat, 18 Apr 2026 16:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2oY/tcRSmcBh5sFFcI4oYCHuxEtlx4elQ3E5wFdMf14=; b=Z0ppSoTXIZ9fiSWKBZ6QwEO/JT
	qe8D4gWOBy/BnrPruOs4+Fse+R5hXDkUGrUBd+7J9wgucRIrnHqP80jUo6ZPgjsrWindi//2/xyE8
	T4vCubYcRVxttI2KWFwVnLGWwyhdlEqlhAFdXTtOsQYigh7ZvQPIOezFJWjwKMBBuy3OMOSUOsT0U
	umviKD769cL3SSWixNtgPEuzm4U83BWiZC78hxAgJZTuAHHT/8FbK+EmAH0imjExhXwLCu6HoNFuR
	/PhRC9jUgJEpYKZA8HOdPFD7d+VIymQ2HZ4+2WrxYAkdDAkoo2ZTNn3kIh9m9dgyzrlbthlmCtcCx
	T4WGvIGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE8d5-000000055yA-2uwd;
	Sat, 18 Apr 2026 16:34:47 +0000
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE8d2-000000055wq-0Tms
	for kexec@lists.infradead.org;
	Sat, 18 Apr 2026 16:34:45 +0000
Received: by mail-yx1-xb133.google.com with SMTP id 956f58d0204a3-6501d242e2fso1599038d50.3
        for <kexec@lists.infradead.org>; Sat, 18 Apr 2026 09:34:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776530083; cv=none;
        d=google.com; s=arc-20240605;
        b=JtSKZ4u9aC/tvozCbYIvORFggY2H579iw6EIArK1oP5FKx/qKqjTXqNqEuwTmhQNbJ
         wYflem2o2Tz5bW6BYxLBjJ6V8l4Qk9T9YpvzMyuSz6IpGqJOVG8/dhQI51YvQwLE9SUR
         dZ+v+WMUu2raqrd0gVDad6hEjViwvZtqdlC7p5w7hmKCuXnO0lIFMIaf6x26uirje3Uv
         65WnpulsVnaFcmMoY6H+IIjXXCbhM4VVGxrzHvXfVu32YaAXLsV+318TY9ymdoFFnSRX
         TOoWUbkPYChVixvb9Hl26hOvhnhBaMrXhFH2VHGT/HLrDtUmrUxo2GnvKxBWrTaVQZt8
         0OlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2oY/tcRSmcBh5sFFcI4oYCHuxEtlx4elQ3E5wFdMf14=;
        fh=lfpDnHrRrA3hnfLuAB3WY/TkEmve1iZbn8duMFYu5m4=;
        b=Iu7dCKKZc+gPb1+tC8cN6J5QOXHT7vaSHYPltllXiSCfuBSsFRro76XQg8wiDJr9VG
         vGZZ1KJwm+Bga0uht3bGs0PD3tntrFD95om/mb3zjUbtmekn/2ByhMiH//AMQtOu76Xc
         D4zCkyhbKy/g8Q3ur6mdZwhxDvrJ+412rqqJ0TadSgs0QRz85miq8IZ7mrBo8IBCzH21
         G1d1MiF4+SMeOabB5MZ7yNi0w5Ct3HWfC4lAmOoKDVYxjg2JHNBIOsj7f025OsGCPAib
         l0jKgA8GffshDHOHP5z3M0avgaIFkUCKRs3ow6iwRBIcX/y8H1biIlhbiQeTWgCRBdtz
         sXFg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776530083; x=1777134883; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2oY/tcRSmcBh5sFFcI4oYCHuxEtlx4elQ3E5wFdMf14=;
        b=ohEFNUcFIqmZM+Yt89dJ4I3hWTrCURltgoWG3gx4CqPixB2f/5BmmG0EP6olal7ofg
         KZyZZY+ZZBDoKAfQvK9kvCY1Vg8bfu58TqYiXKb0VdKUy4JPsqh21c4NRpUH0/VqWyl/
         XDyeDlKxQLgAa+z+bwp7eyzndGarwKrtJxAX8S08kHJjFP8Vt9OPLBD5PCfDDMbZB8Jm
         eLqOb4Lof6Jdp8x3Y5Cu95dZ2CGIywVmFOzWPU4EmAaDV90BVXjZ/pmyObUW0Yqg1gfy
         2AdDIU4oA3VQnKN+Lwm0a5iqCJOI2/wW59Mewsob5kAJy+IZywAlyQnjWHBIhhFM5FGm
         nY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776530083; x=1777134883;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oY/tcRSmcBh5sFFcI4oYCHuxEtlx4elQ3E5wFdMf14=;
        b=siQzU66497xg+qoUp+7LHwneKwE/Tj1iWARnQmVBVH/JL7Tg2W9F0DI13VVyCyDh4d
         BSgYUPTCX4n7YGW8lNL+EmvIjnpJL/7TWFLVzFkK1gjJF2LBFHBjE40BfblvwxRj2sfC
         Qu0fc/5CYQoR6wyW1UrHOdeRvbWQ8ToKFTzwbQWWcelL7IlqviryHZGy7eUWiOnuaViG
         Ca25id2two31trUK08yX/XjMZ4xPvck10+uTCGzrFCBvAn2dq5TQZ8b6OpXPv0XajG+0
         3UlbUymmpGq/3iqRwg5A5rSxO8oWOBh2WCS8pKkXlHWFZqWxxH6r6fQz7iI8mSy3YGen
         PxKQ==
X-Gm-Message-State: AOJu0YwwJ2kZHsewT84yEDQtDUqp3NLuG2mfiLPUnw+uhTVeZf3SON1K
	UnyqASafiDGF9zuXCLiv5TaGfIWFrvUBLJKBm3t1pU4NkAoTte80YIAmiYcUZ4P3HUNYUSeKGB0
	Bm7YEvs16ZnmanPWuqs7eObmyPfwcumI=
X-Gm-Gg: AeBDietxLf3tOCRJUb7u1QfcFFKyycN227u7eRG64NsSTeRAs5uyIjB1srJDNomMqgs
	IBZMR0CBeTp11K4mL9U2XgJb+M6zAPI3TosaVw+wX9NNfpzsM2ab6Wqypjk2HAk6dyKHoNlKQTd
	McfqNP+Zw3y2zvjC/XZX/H0KpxWcOU5e6ZH5oi9wdF2EKB6c0NBaYWLwLaGIQI8aJe177xyltz0
	y8+zPlUHypXohtpaDaENaHOOUPifb38vCMjiG4FqxUh+jDnVvaDse5BUrvzY8XOKJ6CHakDSOHa
	qdi8c6woZ0xfLrjae9TPeV4AEVvKhe2hkzNnm3Ua2I5EXgGEWQrofp1Cc91cg48=
X-Received: by 2002:a53:b446:0:b0:651:d0a5:ce2 with SMTP id
 956f58d0204a3-65310a8a93fmr4803705d50.60.1776530082712; Sat, 18 Apr 2026
 09:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260418141123.2193917-1-luca.boccassi@gmail.com>
 <20260418141123.2193917-4-luca.boccassi@gmail.com> <a4jd64pkvamnwuwzu5k762rgn6sgzp6ldcoknkwhuddsrwcbyv@vxwdpp66x7bl>
In-Reply-To: <a4jd64pkvamnwuwzu5k762rgn6sgzp6ldcoknkwhuddsrwcbyv@vxwdpp66x7bl>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Sat, 18 Apr 2026 17:34:30 +0100
X-Gm-Features: AQROBzAFi32dl83y4vi-iHBtoXR9NASEP_4UGJj7Oe0Bi3My32Y9WO4b3xObtKU
Message-ID: <CAMw=ZnS4+TjxYN2KB4sejwwU5n95O4TBVRESq0PxbbdiSP3iKg@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] selftests/liveupdate: add test cases for LIVEUPDATE_SESSION_GET_NAME
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, graf@amazon.com, 
	rppt@kernel.org, pratyush@kernel.org, brauner@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260418_093444_173166_EC268BCD 
X-CRM114-Status: GOOD (  31.21  )
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

On Sat, 18 Apr 2026 at 16:50, Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
>
> On 04-18 15:09, luca.boccassi@gmail.com wrote:
> > From: Luca Boccassi <luca.boccassi@gmail.com>
> >
> > Verify that the new LIVEUPDATE_SESSION_GET_NAME ioctl works
> > as expected via new test cases in the existing liveupdate selftest.
> >
> > Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> > ---
> > v5: merge with LUO_SESSION_MAGIC series as they both change the same
> >     unit test file, to avoid merge conflicts
> >     split into separate patch
> > v6: add more test cases as suggested
> >     more verbose commit message
> >
> >  .../testing/selftests/liveupdate/liveupdate.c | 138 ++++++++++++++++++
> >  1 file changed, 138 insertions(+)
> >
> > diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
> > index d132b4685f76..ffbcbd465c9b 100644
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
> > @@ -385,4 +401,126 @@ TEST_F(liveupdate_device, session_fstat)
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
> > +}
> > +
> > +/*
> > + * Test Case: Create Session with No Null Termination
> > + *
> > + * Verifies that filling the entire 64-byte name field with non-null characters
> > + * (no '\0' terminator) is handled safely by the kernel. The kernel's strscpy
> > + * truncates to 63 characters, which we verify via get_session_name.
>
> [...]
>
> > + */
> > +TEST_F(liveupdate_device, create_session_no_null_termination)
> > +{
> > +     struct liveupdate_ioctl_create_session args = {};
> > +     char expected_name[LIVEUPDATE_SESSION_NAME_LENGTH];
> > +     char name_buf[LIVEUPDATE_SESSION_NAME_LENGTH] = {};
> > +     int session_fd;
> > +
> > +     self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
> > +     if (self->fd1 < 0 && errno == ENOENT)
> > +             SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
> > +     ASSERT_GE(self->fd1, 0);
> > +
> > +     /* Fill entire name field with 'X', no null terminator */
> > +     args.size = sizeof(args);
> > +     memset(args.name, 'X', sizeof(args.name));
> > +
> > +     ASSERT_EQ(ioctl(self->fd1, LIVEUPDATE_IOCTL_CREATE_SESSION, &args), 0);
> > +     session_fd = args.fd;
> > +     ASSERT_GE(session_fd, 0);
> > +
> > +     /* Kernel should have truncated to 63 chars + '\0' */
> > +     memset(expected_name, 'X', sizeof(expected_name) - 1);
> > +     expected_name[sizeof(expected_name) - 1] = '\0';
> > +
> > +     ASSERT_EQ(get_session_name(session_fd, name_buf, sizeof(name_buf)), 0);
> > +     ASSERT_STREQ(name_buf, expected_name);
> > +
> > +     ASSERT_EQ(close(session_fd), 0);
> > +}
> > +
> > +/*
> > + * Test Case: Create Session with Empty Name
> > + *
> > + * Verifies that creating a session with an empty string name succeeds,
> > + * and that creating a second session with the same empty name fails
> > + * with EEXIST.
> > + */
>
> For the two cases mentioned above, we should implement a fix in the
> kernel:
>
> In luo_session_create(), we should verify that the name is at least 1
> character long and at most LIVEUPDATE_SESSION_NAME_LENGTH - 1.
>
> size_t len = strnlen(name, LIVEUPDATE_SESSION_NAME_LENGTH);
>
> if (!len || len > LIVEUPDATE_SESSION_NAME_LENGTH - 1)
>    return -EINVAL;
>
> This change should be submitted as a separate patch in your series.
>
> Additionally, please include a cover letter in the next version
> explaining the overall series. Once the cover letter is included, you
> can remove the individual patch versions from the stat areas.
>
> Pasha

Ok, all done in v8, thanks

