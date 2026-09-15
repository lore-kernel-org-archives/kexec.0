Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71303C982C4
	for <kexec@archiver.kernel.org>; Tue, 15 Sep 2026 22:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7NEEN5klK6sYQ7k8fj+V0z2WeSFVNwjy5fJJIdfiMPQ=; b=xlsS/WxlIGraYfJwZ5L8tY4z+o
	RxFoc6M2B/LGI+j8gUiVLJK12+k9stu4OiT3hN1T2I44QMrPkfGFImydwNkXJU/XbyMTD7aseg3Y1
	GzD6c4PZezOLucaFdVsqsXpW9lR3LA5lqYIoGWE/VxCm9Dcj1q082mvhMlEogZpTUxl+p4Z6ubt0G
	w5YQOqEENpE4LBPOc9y6KC5m2N/W6doIc0UhUWosjXyEPrcAP0URFWumFaOa8wSX+vw49XN9WEiQN
	kIg4Rl0Sttrh8yeZoeiItj5znpXSaBD5vk3qNYMdE/8EIdEz+TvR2yxgGcEUCjD/iGJsq/fD4C/ML
	rjD0nHvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6c3e-000000082lF-3HVt;
	Tue, 15 Sep 2026 22:55:22 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6c3b-000000082k7-1AcK
	for kexec@bombadil.infradead.org;
	Tue, 15 Sep 2026 22:55:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:Subject:Message-ID:
	Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7NEEN5klK6sYQ7k8fj+V0z2WeSFVNwjy5fJJIdfiMPQ=; b=CoT+JtrMijic3/aamEubT0JUc2
	oB2lvvxkGUnVMXsRVXGDHsDUiENUD1EcDI568nlpNZtqIRLJIp3rqeNnLf+1NyRP7CLhZHvX5dw0G
	IPfOwUwJuJuRFK5VzK3JGxU+g/FoGNespBtVPdmf6iCMZbglf3/G9HT/S4SP8IMHiFsicRNLZH1Vn
	HvxEgr9y4j3jTJfwfg5/Y3tz8yXiGR1xH8hiCNFqezjn1FAVlng/H0aWZPeXR+E8Q8aefFePuSr9f
	9n6q6CUT3Gqgb60UstmHghrvIpkLVyAAgFOKasy+/5DbHVcKu6UYRTvCn/WfvBxrs4NokiTZ5S3lK
	yuB6Sckw==;
Received: from mail-ed2-x10.google.com ([2a00:1450:4864:33::10])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x6c3X-00000007J4m-3zGn
	for kexec@lists.infradead.org;
	Tue, 15 Sep 2026 22:55:18 +0000
Received: by mail-ed2-x10.google.com with SMTP id 4fb4d7f45d1cf-6a9ab2a135dso526871a12.1
        for <kexec@lists.infradead.org>; Tue, 15 Sep 2026 15:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789512914; x=1790117714; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7NEEN5klK6sYQ7k8fj+V0z2WeSFVNwjy5fJJIdfiMPQ=;
        b=UjmYVQ4EekHgbAxownd4WXtzIR6TaeeiK8gdE7Z5yMPgKpCcWDwqlbuIwvnT5vf0/q
         f//2EZAO245ETQFQsbTLnyCFbB9Qr7Nfej+Xaeqii3ycNfa4Swp6LLxLQi194EEVT8oz
         +seH+aaTGH5hge5b2+OHq4B7+qDDsxykDDSFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789512914; x=1790117714;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7NEEN5klK6sYQ7k8fj+V0z2WeSFVNwjy5fJJIdfiMPQ=;
        b=wJWmDZwkNSTrFX8D0nAgabQP+Rq5CmNmwYfOivJKc7BC013TUfGRaaWH6tpxXb+LXB
         u4KECMpmlpPrANO7EPjaPJ3pNygv3CqhjymRpEDXr6lg0PNmmhdMljATjrU31QBGeP9b
         dOeyyngPbtLqHCor7AotTbi6b98iXdb0/0gBH3NzcKuownEYldh8EUWvf2rSP8ExXSQm
         tF6l191jOwqhU67sJ5xXzmaG3ox3nobBarHpNPTPUyootrjJB5hYEy4J8AgVq1avpdlc
         6NbrXyyaxI6Z/vR7GOv5DoU6vFceP5c4jv4Uc+NAEBLIgpj9zkM+Ad2v1LTTnYv9RkCW
         dHeA==
X-Forwarded-Encrypted: i=1; AKwUvBxTWL/y9sqs4Rp9H/ZeWRjtpNq1Pp1i5bwoIQN1ZEkN+5g1GAQWDMU5dm8cYq6Z74fn+mMnbQ==@lists.infradead.org
X-Gm-Message-State: AFuF++nfUCrvOXZAiu5TLgmSLNct2hmlKPD+jqAa2nQTUTCwmUvcRrXA
	oxnCmGTLoEc+XLspxBZnRDXElkgm8t89hqVQ5gQXnuKi7ODtvT3uXezF0xVyR6SbspkYggqMHAR
	BgPcr1EenUg==
X-Gm-Gg: AYBFou3PKgIVgFo/czhC6G+ydum1A6eE9ESJ9ZZ5vadLW++yWmfm29zdYA7vVgGW1q2
	adsmSk+GEUaQV/9RSUYxVsIHNll7gpGtXFAeJnNIWLkjViv5ZDNy5F/sAtkA9wRvqBsf+b35+Y3
	cLcx+WiF2f/oLHFZnCdd2qPbuB1OAl27bfCZqzmDHi9OIoulVjYjhR1B1wdVRISlucqOImePnsH
	GzCZyezUzlsjVRmoQLZ0BKK+ezYA+d2N31Pqdz1yNkWgvCn3bjFp4ZJ4PMr5CoozlHCRoluGcby
	Afa8chxFP0ZWk5gclX2pDlICT6ub9d8nMpnkT2zYlLWPcR60qtxRlkKInwdbTr8UDsfo4vA9GH+
	c6RbmwnruQ4IfLtqJZDLQBBFR53rgEqrSGYRr5HlkvahH+J093amOx3MmXKwiaH9fBstDh79WP9
	JVJ1J7+V5x/5cCLKfNaP2BAcPLI36iRk9eLiFlKhn5hSdHTsInwLj3vLRPK2R7y2mVas6hYzkZ7
	P3dt0JKPY9A4ZyEbvsnBZCeRzdeMszltMg2WTBwo4kmYnY/
X-Received: by 2002:a05:6402:46dc:b0:6a8:372:edcd with SMTP id 4fb4d7f45d1cf-6aa223fe588mr183087a12.22.1789512914192;
        Tue, 15 Sep 2026 15:55:14 -0700 (PDT)
Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com. [74.125.228.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa1cfe0570sm364023a12.4.2026.09.15.15.55.14
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 15:55:14 -0700 (PDT)
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a9ab2a135dso526857a12.1
        for <kexec@lists.infradead.org>; Tue, 15 Sep 2026 15:55:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByo8IldswFKsNu1bU369o7hVVR95Z3DhhJqu7/39pe5Ow8NA/591/hoLQwk/djQbqkvdoAssw==@lists.infradead.org
X-Received: by 2002:a05:6402:5d1:b0:6a9:a6c0:e5ef with SMTP id
 4fb4d7f45d1cf-6aa2244ef06mr218172a12.37.1789512913950; Tue, 15 Sep 2026
 15:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com> <CACSVV028AdnTYa6OKDeoJYCau58uTkKMgEdqTn7crNSV8QZxOA@mail.gmail.com>
In-Reply-To: <CACSVV028AdnTYa6OKDeoJYCau58uTkKMgEdqTn7crNSV8QZxOA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Sep 2026 15:54:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjhJF91TCO0Zqeuf+caG2tQZ4AzbLr2qFmRmnMM4dbh4g@mail.gmail.com>
X-Gm-Features: AcwNN1Wx2MaYDtFtmeOlL6MnzYY7doY_FEPpziKatTBWbLOeKsjmritQ5JuAL3M
Message-ID: <CAHk-=wjhJF91TCO0Zqeuf+caG2tQZ4AzbLr2qFmRmnMM4dbh4g@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: rob.clark@oss.qualcomm.com
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, 
	David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260915_235516_412941_D6B9A5F9 
X-CRM114-Status: GOOD (  10.10  )
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

On Tue, 15 Sept 2026 at 15:21, Rob Clark <rob.clark@oss.qualcomm.com> wrote:
>
> With fd's it is more than just about error rollback.. exposing an fd
> to userspace mid-way thru an ioctl is an easy security bug to write..

That isn't very common code. It's something that is done by a few
strange cases, and yes, those cases should just do it right.

But "those few cases should do it right" does not mean "make a whole
new subsystem for this thing that makes a simple "open" actually be
slower and stranger".

             Linus

