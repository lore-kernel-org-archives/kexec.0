Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA4BCD4F24
	for <kexec@archiver.kernel.org>; Tue, 12 May 2026 20:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DIIRS0CpXrVK8EEE9qFLP9/pCIOhI1EfpJW18IQe0rY=; b=gy3/5Egg1JztjxQAezODYUjcRs
	gpQXvNwu4/u5cRv32eUzLD436j5ZxgXOBScFtzGk8psdElT2gDE8HpuoJKWohD85/OCldWXlhxIMn
	7gAZeXD2spZ5YGkGOsjn+HdBGVistnFiJ0+LUskhW77pV21EKlplXkByc9RZ1URXb1u49/yNP3c7o
	8LY582N5Tz4czdU5Y9pXh/DSEL/Aq0YM+pVUYZDz9rXNWyUPUMlfuDdkjXgVKwl+HWZzc3XmV7ng1
	1a6C+7f+5OY83UlduJd9FqBycpdWMdi+p66pKDqvAw5Ww42Bs+Spc53EhZryy0rIsfHZfskIEyWrS
	hqnMppIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMtTX-00000000IoE-3bSh;
	Tue, 12 May 2026 20:13:07 +0000
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMtTV-00000000Ina-1FRt
	for kexec@lists.infradead.org;
	Tue, 12 May 2026 20:13:06 +0000
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-50fc496c8baso57014731cf.3
        for <kexec@lists.infradead.org>; Tue, 12 May 2026 13:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1778616784; x=1779221584; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DIIRS0CpXrVK8EEE9qFLP9/pCIOhI1EfpJW18IQe0rY=;
        b=NthVwjaDqSIVB7eN10X4OVpI5+KH8+Fifaj//bEFAAscVULaXf+Kw+kJPpBbbJU2Jl
         Jic0lHksVcH81XVDU/9DCFM+g+bqHW6CuK1Q/PRwTKVBmzI7aAKzgwVeN0PyHhMYQ7x8
         4ISppfjX3eTdu6stlAicMS5NPoxmqgjwiNwWj2VncYmZzSeMdnmaHyZ+rUKuzwjLxH2t
         YCn6zZWPmJOm6lvXDdtqLxw9WKN526MFSHFR754SS8b55asivd+3RRNQM9uSJ9FIPGO8
         pKlL1Doxdf16RvBJeudHeRBDJQ+8HsD3+IqEogHv3cmyZHAFvnHhjnXoooA7nJtBDSLb
         T3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778616784; x=1779221584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIIRS0CpXrVK8EEE9qFLP9/pCIOhI1EfpJW18IQe0rY=;
        b=QO31LnC8Zoj7jaMuaUYXLFe0Sc+WixVjC7MyJEBnTvSgUexcHk11xM6bGx6ROuf3BA
         ODu0bZkDiLjvjXaEOvm2MMtNOHJOBIBUnfliKbeL5bcWP8M4CZ/0aTApA1ExDlsykTVQ
         m421j4hHz2aYJ+xvuZkJJv6sEnzuQdLMCxWmgCLWl6ecBGF/0kHc91LzyW8y6tfX8dTN
         BcHSgziBhRxa2U08j/pcX7t6ktpgwP4ILrScRCSEyK790Ppm61m0ILLGsgm9M6I1Az35
         nFaD716a7/f6y0h5hDT14qXfMoSOE/hOf2iw5d4I+jrUC6e2FiXpswc/Xi+zuQnnLNY7
         dbIg==
X-Forwarded-Encrypted: i=1; AFNElJ9FBpjPwoF9WI2rpSKJzTyEM84ALKi5BIK97jhaNPgQHBmq3gUgV56H9H+SNy8VrRZRuICn+w==@lists.infradead.org
X-Gm-Message-State: AOJu0YxKeLcXC/vl3ewMxMO/XXesPOBlwj9ciYlB0IRbrYMpHK4m0G+x
	LwbzT05hxLss5rp4GN5H2Z87VNYj/g1WGTq1LCF1o9J3wyiBYJX1+oXVfh+fP4NeeRU=
X-Gm-Gg: Acq92OE49ARpKbWzEZUraiajUmQQqzyOjO6i4TWeL6Vc6rF2EHBDBm1TG6OFrp/JW5j
	1mEMnDMcd5fu+0y7OsmCp7T0kznCVI9xKB8KtxAhwJir35/8YOBQoMFEtvwRydeXFvpb9OoR6Aq
	z/3c9ulakH+GHxFtWD6y/KIEuxxT66CzBIxo1ghLzhdJHWiBOlCQHcUW4egC5cPpFkQUTnylnsP
	r8kqgvPgRqYqimhYywE0QuMvrnEhf0VxGX5n72n6DLO5E76YIxQoHnMse4Wx2RlfnDEva9Qtw/n
	P+Vh+dhIWKc1xyQjU7NOuANJOOFbnawpaL8YNke+hP1unquerPNypeK89bYj6z8jQ4TVrdDoSB1
	KkQ6KUtHDtl1orm60yiR/ggXv181stXfIjapBdMwyHg/SAtMP2pb1qVphcW55/2si1VpKdO5JN+
	L3oKh83W6XjT5lReNOFvV863jJmLErQOkQ326fFx/JNYLxTFK5vAU=
X-Received: by 2002:a05:622a:92:b0:514:9ece:a15a with SMTP id d75a77b69052e-5162f5fedb6mr2218391cf.45.1778616783708;
        Tue, 12 May 2026 13:13:03 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e675b9csm125582881cf.11.2026.05.12.13.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 13:13:03 -0700 (PDT)
Date: Tue, 12 May 2026 20:13:02 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	linux-kselftest@vger.kernel.org, rppt@kernel.org, shuah@kernel.org, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, dmatlack@google.com, 
	kexec@lists.infradead.org, skhawaja@google.com, graf@amazon.com
Subject: Re: [PATCH 3/5] selftests/liveupdate: Test session and file limit
 removal
Message-ID: <agOJui6EOiJR3cgn@plex>
References: <20260414200237.444170-1-pasha.tatashin@soleen.com>
 <20260414200237.444170-4-pasha.tatashin@soleen.com>
 <2vxzse7wafmo.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzse7wafmo.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260512_131305_348131_F959C2AE 
X-CRM114-Status: GOOD (  24.75  )
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

On 05-12 16:04, Pratyush Yadav wrote:
> On Tue, Apr 14 2026, Pasha Tatashin wrote:
> 
> > With the removal of static limits on the number of sessions and files per
> > session, the orchestrator now uses dynamic allocation.
> >
> > Add new test cases to verify that the system can handle a large number of
> > sessions and files. These tests ensure that the dynamic block allocation
> > and reuse logic for session metadata and outgoing files work correctly
> > beyond the previous static limits.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  .../testing/selftests/liveupdate/liveupdate.c | 99 +++++++++++++++++++
> >  1 file changed, 99 insertions(+)
> >
> > diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
> > index 37c808fbe1e9..0eaf97b19267 100644
> > --- a/tools/testing/selftests/liveupdate/liveupdate.c
> > +++ b/tools/testing/selftests/liveupdate/liveupdate.c
> > @@ -22,6 +22,7 @@
> >  #include <fcntl.h>
> >  #include <string.h>
> >  #include <sys/ioctl.h>
> > +#include <sys/resource.h>
> >  #include <unistd.h>
> >  
> >  #include <linux/liveupdate.h>
> > @@ -386,4 +387,102 @@ TEST_F(liveupdate_device, prevent_double_preservation)
> >  	ASSERT_EQ(close(session_fd2), 0);
> >  }
> >  
> > +static void ensure_nofile_limit(struct __test_metadata *_metadata,
> > +				long min_limit)
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
> > +			SKIP(return, "Insufficient privileges to set RLIMIT_NOFILE to %ld",
> > +			     hl.rlim_cur);
> > +		}
> > +		ksft_exit_fail_msg("setrlimit to %ld failed: %s\n",
> > +				   hl.rlim_cur, strerror(errno));
> > +	}
> > +}
> > +
> > +/*
> > + * Test Case: Manage Many Sessions
> > + *
> > + * Verifies that a large number of sessions can be created and then
> > + * destroyed during normal system operation. This specifically tests the
> > + * dynamic block allocation and reuse logic for session metadata management
> > + * without preserving any files.
> > + */
> > +TEST_F(liveupdate_device, preserve_many_sessions)
> > +{
> > +#define MANY_SESSIONS 2000
> > +	int session_fds[MANY_SESSIONS];
> > +	int i;
> > +
> > +	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
> > +	if (self->fd1 < 0 && errno == ENOENT)
> > +		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
> > +	ASSERT_GE(self->fd1, 0);
> > +
> > +	ensure_nofile_limit(_metadata, MANY_SESSIONS + 10);
> > +	if (_metadata->exit_code == KSFT_SKIP)
> > +		return;
> 
> Nit: This is strange. Why not just return errno in ensure_nofile_limit()
> and handle the skipping here? Same below.
> 
> LGTM otherwise.

Good suggestion. Done.


