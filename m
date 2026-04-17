Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 594D3F99C65
	for <kexec@archiver.kernel.org>; Fri, 17 Apr 2026 21:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3Me/r6y+WzPcCjVhGDh2HGIPNUwQfElYLMiSVWgNDfI=; b=uJWerffiCy0qplo/1LM9Cb72Oj
	2oVbCj8YvJtVU4l/kZhLNTDzck9kb8Bn+rhPSMLLMyCAGsI7jpO9a7uRA5wOLplpLx4nSjwLtuw+P
	1Np0GwbanCpCN8HIQ2BF++xCWzbGXerCLBGBMRUA+KGypKngh2hIaKWmCBNQqImgCo4AWf83FmPbt
	eK/Crudot8bfkKewECCEJxbCpeT+A542F5MORKPMvCvVJrv1fhOUv7SeVdFqHYSR8MJSyaab6aUM2
	zvvsx7sEG/TQjdWE2LytxPvo4z1CIGqIFw5J44jfRg4tZbz3rh/MXU5mXooORsiaWhD0z6i0vBZdf
	6vUS77hQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDqON-00000004TQQ-1e2r;
	Fri, 17 Apr 2026 21:06:23 +0000
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDqOK-00000004TQ3-3x1d
	for kexec@lists.infradead.org;
	Fri, 17 Apr 2026 21:06:22 +0000
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-8d68f702851so146300785a.0
        for <kexec@lists.infradead.org>; Fri, 17 Apr 2026 14:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1776459980; x=1777064780; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Me/r6y+WzPcCjVhGDh2HGIPNUwQfElYLMiSVWgNDfI=;
        b=KOYKNXVubqd52Q/bB2Koab5gjTTnNGee9D3Py6NDovr0xijiKGeuaPXJRHFXu5527c
         XRpHK5tpdutdXNvUW/0WW6P6mN3zx+zOJr167vEDxNMGYm93IPHdQFr5RbsQoGMn5a7B
         j8ls56auE4mfDLIIy/wX6r62NZ5zDULUqlgeIurK7s1BMIJJRCNbPwThfr1fVUVDqOxL
         /XNYWC8IZsg1P+/eZesOXz+N8PJRLvzy/Rmdfb7jZx/8iCZQjExzJW26u/5ZQLnBJpsn
         JbRZ12Gbq1xk/7Jcr4MHhBvKf9HbMR0bBe7bKmOyuwBq68JokbBJPRow4cv3qRD44OKk
         WrAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776459980; x=1777064780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Me/r6y+WzPcCjVhGDh2HGIPNUwQfElYLMiSVWgNDfI=;
        b=YpiV+2HcFw3wNz5zolrczdJbnm4z7+F/PhzUXR0f7MmanTDfi62BJsOfBYZXehCN2g
         kY2uAD704USY5OlcZc8QOlLqEa/N3qhFTpLzaiNo+hJko/un4tnu4kHM11nFVDcbbGCs
         m5Hv53bIOutB6gqy5QOWYxrQ1VI3uIuCs8lMg36eRxOcjqxA90LVqYz4VvcDZFWBAPXJ
         L9rAP+4gIQPDTOsfsdCu/5PUAjZs4LkzcSVHKOtIzj1g3qAgA1laBUV6IRe2cnhd86C4
         4ioyvf6J9aJdgs4qqJwUZrWaPceSLIbmTEKYB15yldyFajbCISG1p4a95S/jUz2vYmFL
         E2qw==
X-Gm-Message-State: AOJu0Yyn5niC7luTNA5dmjoqfB2g1tOVFv3uXOj1IMiZuWqApV1mCR81
	maTgZGTbo3aOYDJsjgIr1zzG03iUruCS6rKHTL9UHU5WjV4GkasLs0lKUYlB8QJg52Q=
X-Gm-Gg: AeBDiev1ayv6+kw9L/+F70UTZ83Utm4TT+iJUejMo7zYSNJ8xuJHe8vjVZYmszdzazd
	OGQGoNqGhHHoaCTnOg8X6bwxpnWWMPkc/4eoxcPC54uGdHQOQNzedVuqropOzySkvfRyjIPjPPg
	gnOFkrHiafXYYxLV0/h9BXDPPbk9yi2poJT5JJSaNzYxbtp88JEjT3DlKLrW/XcJKYthtPsTAAi
	fp9p9U5rEvdtBA56knEUGeOfhVGa9/d+aTf2BvVO0qHEn+Tu/R3tuQcS//3k6Y5uDQ7FLJ/J3aG
	WBKFySTG1Zp+zy3WlskzF0fxrh6EKpDrOn5OnlI78XNYAsOu8nXz258cCJHis36gtfDtdAOIuBP
	TudKkunKK9fOCjTcybjrTse1Bs9cyNeEnCgbFdFa5AdhSSOOlUiJPfMJgSoD2qIEfG2SVmdswu3
	rV0LnUpZH0F3mNEOZYqPHC2jiEqeGhLIKAFbot5qXQS4CbAXaHy1c0G9GS193U5G0T+M35Xgg=
X-Received: by 2002:a05:620a:4612:b0:8d4:aa50:686b with SMTP id af79cd13be357-8e7911ce9cdmr646446785a.31.1776459979750;
        Fri, 17 Apr 2026 14:06:19 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac68e76sm19709696d6.11.2026.04.17.14.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 14:06:19 -0700 (PDT)
Date: Fri, 17 Apr 2026 21:06:17 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: luca.boccassi@gmail.com
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, graf@amazon.com, 
	rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, 
	brauner@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] selftests/liveupdate: add test case for
 LUO_SESSION_MAGIC
Message-ID: <amspd2iat2hzjf77en5d55wbmau6xyaa4mmxbzjxl5nw5tlqma@lellpiqvrgb5>
References: <20260417205810.1831923-1-luca.boccassi@gmail.com>
 <20260417205810.1831923-2-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417205810.1831923-2-luca.boccassi@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260417_140620_991633_9687402C 
X-CRM114-Status: GOOD (  17.31  )
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

On 04-17 21:57, luca.boccassi@gmail.com wrote:
> From: Luca Boccassi <luca.boccassi@gmail.com>
> 
> Verify that fstat works as expected after the switch from anon_inode
> to the new magic number.
> 
> Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

> ---
> v4: split test case in separate patch, reorder variable declarations
> 
>  .../testing/selftests/liveupdate/liveupdate.c | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
> index bdc1cedc4f944..3c21352f023a7 100644
> --- a/tools/testing/selftests/liveupdate/liveupdate.c
> +++ b/tools/testing/selftests/liveupdate/liveupdate.c
> @@ -22,9 +22,12 @@
>  #include <fcntl.h>
>  #include <string.h>
>  #include <sys/ioctl.h>
> +#include <sys/stat.h>
> +#include <sys/vfs.h>
>  #include <unistd.h>
>  
>  #include <linux/liveupdate.h>
> +#include <linux/magic.h>
>  
>  #include "../kselftest.h"
>  #include "../kselftest_harness.h"
> @@ -416,4 +419,41 @@ TEST_F(liveupdate_device, get_session_name_max_length)
>  	ASSERT_EQ(close(session_fd), 0);
>  }
>  
> +/*
> + * Test Case: Session fstat
> + *
> + * Verifies that fstatfs() on a session file descriptor reports the
> + * LUO_SESSION_MAGIC filesystem type, and that fstat() returns consistent
> + * inode numbers across different sessions (shared singleton inode).
> + */
> +TEST_F(liveupdate_device, session_fstat)
> +{
> +	int session_fd1, session_fd2;
> +	struct stat st1, st2;
> +	struct statfs sfs;
> +
> +	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
> +	if (self->fd1 < 0 && errno == ENOENT)
> +		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
> +	ASSERT_GE(self->fd1, 0);
> +
> +	session_fd1 = create_session(self->fd1, "fstat-session-1");
> +	ASSERT_GE(session_fd1, 0);
> +
> +	session_fd2 = create_session(self->fd1, "fstat-session-2");
> +	ASSERT_GE(session_fd2, 0);
> +
> +	/* Verify the filesystem type is LUO_SESSION_MAGIC */
> +	ASSERT_EQ(fstatfs(session_fd1, &sfs), 0);
> +	EXPECT_EQ(sfs.f_type, LUO_SESSION_MAGIC);
> +
> +	/* Verify both sessions share the same inode number */
> +	ASSERT_EQ(fstat(session_fd1, &st1), 0);
> +	ASSERT_EQ(fstat(session_fd2, &st2), 0);
> +	EXPECT_EQ(st1.st_ino, st2.st_ino);
> +
> +	ASSERT_EQ(close(session_fd1), 0);
> +	ASSERT_EQ(close(session_fd2), 0);
> +}
> +
>  TEST_HARNESS_MAIN
> -- 
> 2.47.3
> 

