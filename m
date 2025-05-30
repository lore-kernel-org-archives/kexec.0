Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB41C5B552
	for <kexec@archiver.kernel.org>; Fri, 30 May 2025 09:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WBD4FC4JP/aK9PaRJ0xxbq96AkGHxNwwAgjyDa2KnPU=; b=TmwVoBO0UcTVUGe+G2u28p6cdd
	jI5OAanQEWPCiUq3KohhcGy8C6MbEYoV17DVI5uR8ahb7SlFmVZFTa2a658/S8gCefp0jDUv9ZtOo
	iw8c6I5bC48TccW9wmnLgoti+j1mHjSiZ3NT3OGXn1rD9dV67+YB5on9oUK56+anDX+b8XUN/lOtQ
	yjFKwslhL3VNCgG4TgvQ1o6MHorOL5gvZtjTrtNeniOLS8kCUk7Tc9Uf0xSBDMqUCv+tqCO5KvNpI
	5JqEfgtrMCHQMB/57GwnUvitAQC8zKHRcqmDExL197olGke7VB2rrRqkNNRL1H6jFuDhtxN8HJD7U
	9NQ1rx6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKw3C-000000007dC-2VEG;
	Fri, 30 May 2025 09:29:18 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKw09-0000000071s-2pqB
	for kexec@lists.infradead.org;
	Fri, 30 May 2025 09:26:11 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-43cfe574976so14361405e9.1
        for <kexec@lists.infradead.org>; Fri, 30 May 2025 02:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748597168; x=1749201968; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WBD4FC4JP/aK9PaRJ0xxbq96AkGHxNwwAgjyDa2KnPU=;
        b=VXYQJdJ9itXwCsqyNcjQ/b3FEerufFTomhFPzVGoYwyy044/30VmVUEqRX+W9WnLz6
         otj0eOF0E9HhIOghpC6vlIO51bWRYti4pxFrCt+c9FEZe8cN73fqr/QMD9+olqOTKaJY
         dXQ/kKEgj7Aceeyzm84a6E4VgoyyrMSVvgHh8F4uRy0eXSoX9IYUe3+baT4/4ox1zXwY
         MXk+9iIF6jmQvFjUXFLoMQ7GDluChaY7A2YQWOd5wkXeVZmDoHoJOiq4gvr1u7JV6DDz
         Z4OCA1T7WixGcaqH0idD9zolGoUPt5hhhTy/k4xzujhSe9goSa+c+/8dVD3gYFYeSKq9
         uIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597168; x=1749201968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBD4FC4JP/aK9PaRJ0xxbq96AkGHxNwwAgjyDa2KnPU=;
        b=wyvb6itSqgkFNwGqMWKCkAst8Bst2EhEZigYmjFsluLzANZ95QalWFS9ayJSLLlnaD
         tqJ9rH/CmHbRg/2PudjwRPJcU3a1pfIN7P8LA3dp4+q/ggiK/MPCcdjpvvnALWTsFXjK
         yyKBTGVbcEXwknV97aV1ziQcPIpJVFnVbQ3KPPmt8Y0fySCSPFRdEqWa5DZF4gKDZnAW
         ei+hXaHJ0TRWkBSjlQhJESj73yIlW8pRRt7sbJZNfGVMY8MBzDFk+8qp8guGA9tPdW/E
         0bp3fVQA2k5p+8ipEFt2VSjS/oDRZuKYw1xZz15hytOGMKO+7Qo3nvMwUMvvEzTfJ5w1
         0VEw==
X-Forwarded-Encrypted: i=1; AJvYcCVXAuFLBPcS1H9esCPubro6Ruec2aMcnxqfPSjH/uGa4lA6GSOMGUImSfYVlNaIpYqhWglV4A==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxrm8YRd9QRBOxnmoeR5ldCqAAIpao2HMpw1tu5IWBDcbGs72qp
	TxJyG6EwKqNSrzjTp1Hch6rkr9o4k2hubXfp5QbCGvO4sh8kzcZJvBlOoSiP9pG4uvM=
X-Gm-Gg: ASbGncuQ6KHfDaNRj1ZDBiPpG/GulsQ1quNHTXipmeWuSryo+QPLB/H0rSztFJa2/V3
	q9xkCmA1CK8zM94rmOP45V8xvfN1mfX3pyF/XtSWV1HyuKP2cpn+61NTp/35f2cdXmAoJpDJdkb
	NilU2yVGosaoegNzh9Z4+MPwjalWFS74NqL8GShWKBQVfuO09FpDCpm6e462dCCZXWXGKLoEBqV
	8gUr34U0AB6EIDKGre+CUb3K9IoTSDhZL94C6kzjE/hponyBiutnQoqeGrXskFG6C6hxbEXR72C
	UVhA1SLV1hZv1aj5i7u+yuP/ctSuLFJnhEjX6R7hlmAsidcQYVRM+nYj0olrH77j
X-Google-Smtp-Source: AGHT+IHy+f9++7ZGOrh9ZvJit3DYw9n8FLen71ac6q+FlrswfnOM19Wz+9AOWt0fC9IjOkvfOFAdwA==
X-Received: by 2002:a05:600c:5249:b0:43c:f81d:34 with SMTP id 5b1f17b1804b1-450d64d3fbemr26298075e9.9.1748597167912;
        Fri, 30 May 2025 02:26:07 -0700 (PDT)
Received: from localhost (109-81-89-112.rct.o2.cz. [109.81.89.112])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-450d7fa2278sm12794105e9.12.2025.05.30.02.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 02:26:07 -0700 (PDT)
Date: Fri, 30 May 2025 11:26:06 +0200
From: Michal Hocko <mhocko@suse.com>
To: David Hildenbrand <david@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, Donald Dutile <ddutile@redhat.com>,
	Jiri Bohac <jbohac@suse.cz>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	Philipp Rudo <prudo@redhat.com>, Pingfan Liu <piliu@redhat.com>,
	Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH v2 0/5] kdump: crashkernel reservation from CMA
Message-ID: <aDl5rpqCUyf7nX2M@tiehlicka>
References: <04904e86-5b5f-4aa1-a120-428dac119189@redhat.com>
 <427fec88-2a74-471e-aeb6-a108ca8c4336@redhat.com>
 <Z8Z/gnbtiXT9QAZr@MiWiFi-R3L-srv>
 <e9c5c247-85fb-43f1-9aa8-47d62321f37b@redhat.com>
 <aDgQ0lbt1h5v0lgE@tiehlicka>
 <a1a5af90-bc8a-448a-81fa-485624d592f3@redhat.com>
 <aDlsF5tAcUxo4VgT@tiehlicka>
 <e0f7fc1e-2227-4c6b-985a-34a697a52679@redhat.com>
 <aDl1ViMpK_6q_z06@tiehlicka>
 <04a49de5-eb79-431b-ba5b-eae2536781c6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04a49de5-eb79-431b-ba5b-eae2536781c6@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250530_022609_716504_BF94D75A 
X-CRM114-Status: GOOD (  21.25  )
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

On Fri 30-05-25 11:11:40, David Hildenbrand wrote:
> On 30.05.25 11:07, Michal Hocko wrote:
> > On Fri 30-05-25 10:39:39, David Hildenbrand wrote:
> > > On 30.05.25 10:28, Michal Hocko wrote:
> > [...]
> > > > All that being said I would go with an additional parameter to the
> > > > kdump cma setup - e.g. cma_sane_dma that would skip waiting and use 10s
> > > > otherwise. That would make the optimized behavior opt in, we do not need
> > > > to support all sorts of timeouts and also learn if this is not
> > > > sufficient.
> > > > 
> > > > Makes sense?
> > > 
> > > Just so I understand correctly, you mean extending the "crashkernel=" option
> > > with a boolean parameter? If set, e.g., wait 1s, otherwise magic number 10?
> > 
> > crashkernel=1G,cma,cma_sane_dma # no wait on transition
> 
> But is no wait ok? I mean, any O_DIRECT with any device would at least take
> a bit, no?
> 
> Of course, there is a short time between the crash and actually triggerying
> kdump.

This is something we can test for and if we need a short timeout in this
case as well then it is just trivial to add it. I am much more
concerned about those potentially unpredictable DMA transfers that could
take too long and it is impossible to test for those and therefore we
need to overshoot.
 
> > crashkernel=1G,cma # wait on transition with e.g. 10s timeout
> 
> In general, would work for me.
> 
> -- 
> Cheers,
> 
> David / dhildenb

-- 
Michal Hocko
SUSE Labs

