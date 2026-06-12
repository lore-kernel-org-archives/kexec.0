Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037EDCD98CE
	for <kexec@archiver.kernel.org>; Fri, 12 Jun 2026 17:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=loLLkK8YFj2RX3MISH+YVtNr5164MIZqNzHdzscYBKE=; b=bg/z5LLmoa+oA7kOuIeG3sBC3F
	J+rGNZOSUIbTxzmr0iJRtvTKZKDl9UywznVLLfoWeF4/pNc4TC4+O84RG5g5RKZPCrZTCv2Y6vq23
	XbaoqF/EvVlaXxph3v1rnJvTOBb23kStXnbVPWax68q/lZbTtEYDRr+1wxf36uAKYLbi8EoDXDSX2
	zp5nR2LTpNBTqQPP97eKOalX9iEcFhTid6n9/KPGGbaNa7jZy6ZJGv/EKVpFdu/xrd6Z6Ts9/Kld4
	HDpulM6XGi6ywXEO/VxL6odIbvocyE0M2Cd5aO61GYdwBlJPze4Hz9+NM9Rv5hJFsPBQn6haFp3nT
	6aj0Ywvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wY5gv-0000000BLqx-3Cwd;
	Fri, 12 Jun 2026 17:29:13 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wY5gs-0000000BLqM-3zmL
	for kexec@lists.infradead.org;
	Fri, 12 Jun 2026 17:29:12 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2c0b1a48855so5455ad.0
        for <kexec@lists.infradead.org>; Fri, 12 Jun 2026 10:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781285348; x=1781890148; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=loLLkK8YFj2RX3MISH+YVtNr5164MIZqNzHdzscYBKE=;
        b=X26PX1NP7IeI9CDQxugjmuDtqriRxrCfDSSm1cgEy1m5i8IUhWBYDDOELOWszK8Egj
         kJoRNmWXJr/0oJC/aBblNn7x9TTPQ/SXpB20j3bWI9sfYwj/Y2YWuGMQwjyOs+td3QIN
         6n8UyelEPQxRm3AuK8VbsICeESQcd8X35Z/Lzy1GTsX/JY8cdS0G71E4Xsj5Ri4rafnR
         u5F1Rb1eM+dGqbRuZyk97Et+IKtRsK4DX/sBhZOqS2edMGnRt7VrfeNhaVbSWGMuDWli
         zi26+YccYH1wtd3HUdK6LmIv/Dufh6ygWDG7iEzVDHzjt0Jz+/1CVcMroe6lCKuCoW3m
         a7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781285348; x=1781890148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=loLLkK8YFj2RX3MISH+YVtNr5164MIZqNzHdzscYBKE=;
        b=oeJmIzd8gj79WWhZwHYvkwjjjhxuIb64cWDAf3HhiO0BvCIxBKOYk9bvytOVwKjTdh
         Ejk8xsD0I8WlCVtYQvPCduYErb5voA2Pe7UT+b8xWpuVGVedoZnK3SZWBTnmuRFcFPu7
         3LT0u3LGc7FY1nYDZuTC2UGPNPnfGJAHCQim9fl+oY1mrYxjXr2K1hoysjjbWU9g6Qmd
         iHWLmg2LiWO3zVDupVQs8TedvXMo0P6KKTGZcLhCzbhbbRT76Dw5eErWeCwCLOuc2sVK
         UfS3DImt/BKx8iD+rfNiMfwW6cccL60MC3ISTwhQCqVopGTYE55jBAYeux2luXvCuwvO
         Wqig==
X-Forwarded-Encrypted: i=1; AFNElJ+OHBvZKnfqA/zFFYN8REddzowzYwlSTm85ItbOT5CyJ0+BzCQYn9TGvc+VHBAMw7eD+OnyzA==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywqv+Ghy5kkUTU6j0/P7ynjKbX+2o4hv3YkpJSbBFOPZhdjDSuP
	J4Cl8gLc8lSnniSlnlxaS4l+ob+jLo2ghwJgoOxp2/2mVxxWxaEwQSE/bOwCUb7by4cHlsd1CL0
	NjQWoOw==
X-Gm-Gg: Acq92OGEX2fM0eFx1MMvYGHQrnCm8WpLju6Dul/zhVsZ2Yx9iwQciqQdLJly2JI3QS+
	jo8Lyz0xhxZmUnUVC0M/uDk/APdTrdAJBkvQE2oLs0ecYTXQPgPZt1JglBKZDKbWyQjejBLF3rl
	qpcquxQgSz37IlboI8+sqz7wuPQk0+YTmfyeFA4382JWzd0nu1HYN0YdFN+TFCnZuS2nx1pugfU
	aZycQIKO/5Qf7rqDVE0VhTYkLhpc2O0K0GfmTEunOVoEa/YR/5uhsqqVQU1q8I8vB3158LnxGqJ
	tfvnD460ygiGGdaD2I/G6fQx2e7Kx76rhMXvFf1Wu1myjalWi+ss/puw+UUuEsVxn0GGzjzEFJz
	qo0noKEfr/RaX5S1nHI10ViXhJEBCJdBw7ST0wxxF50Rwt8vdbu3MgPBm1hO4jnaOQv8rGMzaM/
	XepFmWunmPpGOaXo3quOxHqxIrGVdrlxdzGwmZZXfvAqkWrPF/lQV6KSzrBw==
X-Received: by 2002:a17:903:4b4f:b0:2c1:ee6e:be1c with SMTP id d9443c01a7336-2c665136d6fmr88905ad.26.1781285348004;
        Fri, 12 Jun 2026 10:29:08 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afc8a90sm2766871b3a.28.2026.06.12.10.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 10:29:07 -0700 (PDT)
Date: Fri, 12 Jun 2026 10:29:02 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: rppt@kernel.org, pratyush@kernel.org, tarunsahu@google.com, 
	skhawaja@google.com, shuah@kernel.org, dmatlack@google.com, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/2] selftests/liveupdate: Move luo_test_utils.* into
 a reusable library
Message-ID: <20260612172349.GA40404.vipinsh@google.com>
References: <20260610230909.876546-1-vipinsh@google.com>
 <20260610230909.876546-2-vipinsh@google.com>
 <178123377286.908199.18067987861441109485.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178123377286.908199.18067987861441109485.b4-review@b4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260612_102911_227033_46DB41F0 
X-CRM114-Status: GOOD (  15.40  )
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
> On Wed, 10 Jun 2026 16:09:07 -0700, Vipin Sharma <vipinsh@google.com> wrote:
> > diff --git a/tools/testing/selftests/liveupdate/lib/libliveupdate.mk b/tools/testing/selftests/liveupdate/lib/libliveupdate.mk
> > new file mode 100644
> > index 000000000000..0fb738c02330
> > --- /dev/null
> > +++ b/tools/testing/selftests/liveupdate/lib/libliveupdate.mk
> > @@ -0,0 +1,20 @@
> > [ ... skip 14 lines ... ]
> > +	$(Q)mkdir -p $@
> > +
> > +$(LIBLIVEUPDATE_O): $(LIBLIVEUPDATE_OUTPUT)/%.o : $(LIBLIVEUPDATE_SRCDIR)/%.c | $(LIBLIVEUPDATE_OUTPUT)
> > +	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
> > +
> > +EXTRA_CLEAN += $(LIBLIVEUPDATE_OUTPUT)
> 
> since this file contains utility functions (luo_open_device, luo_test, 
> etc.), naming it liveupdate.c makes it sound like the main 
> implementation rather than a test helper library. Using something 
> distinct like lu_utils.c would make more sense.

Okay, I will rename the new file to lu_utils.[ch]

> 
> >
> > diff --git a/tools/testing/selftests/liveupdate/luo_test_utils.c b/tools/testing/selftests/liveupdate/lib/liveupdate.c
> > similarity index 99%
> > rename from tools/testing/selftests/liveupdate/luo_test_utils.c
> > rename to tools/testing/selftests/liveupdate/lib/liveupdate.c
> > index 333a3530051b..897c200f3845 100644
> > --- a/tools/testing/selftests/liveupdate/luo_test_utils.c
> > +++ b/tools/testing/selftests/liveupdate/lib/liveupdate.c
> > @@ -22,7 +22,7 @@
> >  #include <errno.h>
> >  #include <stdarg.h>
> >  
> > -#include "luo_test_utils.h"
> > +#include <libliveupdate.h>
> 
> Linux kernel coding style generally prefers block headers to be sorted 
> alphabetically.
> 

Okay, I will reoder them here and in the other files.

Thanks!


