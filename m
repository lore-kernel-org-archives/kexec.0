Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A13EEC54EE9
	for <kexec@archiver.kernel.org>; Tue, 20 Sep 2022 07:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/1YGF7cwfP4fPHX98khQS58a4fzFxSiErUYyuqERxVo=; b=2RFXqHWhzjo9WssV1Yxph/+/By
	UxlisRo0lPqKeFGkcsR37uEPuDvrHKLLOR+U0wjYDNCQcFm5iEOvShUp4QaJIskaq4puc1ZQwIpCB
	aASea99o0la/akfk0ABGi+UmK4/XtMpMIBtt7JWr1D45hYU2rxNniWfwC4uMsgoXvvk8s3jXJCpkv
	Ah51NdjjsDDth49pXZ6GkzdtswtrlFteslHJByCgXUe2fOpx756yJsjy3irA8b1+FLvxk8O3AEte5
	V5kMSi1cW/lY6mQBVKp3r4+TFJuwyUMhq04pyX+ee5Z4M187RTdAsdj1LKm4roGZQ+3AtfwUtc4t1
	5YC9Hanw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaXWA-001JF0-TO; Tue, 20 Sep 2022 07:18:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaXW7-001JEO-Jj
	for kexec@lists.infradead.org; Tue, 20 Sep 2022 07:18:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663658281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qmY76XCFDnjbewQOtkLWhV+E5bTLApw5cTJ7UL+GfjI=;
	b=g6tEgAA/b/yg5gBgaDLqhWemZDVdKxin44vQE1y3Zsujm9Ixe/rx3E/8OLRpP3QIt+9Fun
	zmPYNrCCfahjigen+5GDYJQmkH1JUPvTU3oqhPRGK+gy9Lr67N/4sudqw4xbbUqNEq7Lmy
	U1uQFjzZkneEZXw6MfKI97eR4MbO1nA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-542-VDwD8Y-TP_-wmzDl36pgOw-1; Tue, 20 Sep 2022 03:15:53 -0400
X-MC-Unique: VDwD8Y-TP_-wmzDl36pgOw-1
Received: by mail-pj1-f69.google.com with SMTP id p4-20020a17090a348400b00202c6d79591so952704pjb.0
        for <kexec@lists.infradead.org>; Tue, 20 Sep 2022 00:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=qmY76XCFDnjbewQOtkLWhV+E5bTLApw5cTJ7UL+GfjI=;
        b=24IFG/C4ETzzTyxC6P6ZN5HQSKep8Pf2pJC7v9sbtKGQDYrng4h1gIc/oIkenAF+xj
         +DPcOsc+I+n6d/wqREqqjBIQzd2fkYCQsTUWQhWjE7HKv8JmXcq3vuwgFOu/w8m1isRo
         dVlTYQTxQMcCXQlKxVjlIwZWWWP1IFV0KWsp+nwSHge4dHpGb0/rIHTz8/H4VgDcjp8J
         Ggp7kVuxXufYdeOOdGPM0sjug70ol7bMpYe7eIegDluapm+HMWRgMKomc2UjuVxyBjuC
         jV6qXXmbhGebWkP7XTZiaCpgXn0VQuzpPLq81xIo8NfCWtDBc4WD8DpxcauBEHiayKhX
         70mw==
X-Gm-Message-State: ACrzQf0ZLcPAJa0FG/VTm8rPs5oa4rwphYKc3blMNUV4kMjdL9o8rDRC
	tSDEYdy2/HgeDM/fv08zuUd0Me9OB+ecLrFO/oyIZPTPsiysfSvZU7a7zUmxN0gRZY07c32uIhc
	OZHrsAAWKGM+i/zCgXpmK
X-Received: by 2002:a63:5845:0:b0:434:7894:d4fb with SMTP id i5-20020a635845000000b004347894d4fbmr18936739pgm.357.1663658152092;
        Tue, 20 Sep 2022 00:15:52 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4jlsmZVDm9bQjtbcWplcl/PBlzaE1QMWKXwy9CT3M/B2A66oUgFtWdpfI4wxjA+TsdSWrB4w==
X-Received: by 2002:a63:5845:0:b0:434:7894:d4fb with SMTP id i5-20020a635845000000b004347894d4fbmr18936722pgm.357.1663658151803;
        Tue, 20 Sep 2022 00:15:51 -0700 (PDT)
Received: from localhost ([240e:3a1:315:c5b0:3a17:6b9:6302:898])
        by smtp.gmail.com with ESMTPSA id u23-20020a1709026e1700b0016f8e8032c4sm628447plk.129.2022.09.20.00.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 00:15:51 -0700 (PDT)
Date: Tue, 20 Sep 2022 15:14:47 +0800
From: Coiby Xu <coxu@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, hbathini@linux.ibm.com
Subject: Re: [PATCH] ppc64: remove rma_top limit
Message-ID: <20220920071447.om36ms2leara2o2v@Rk>
References: <20220915084240.133742-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20220915084240.133742-1-sourabhjain@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220920_001803_873008_2E41406B 
X-CRM114-Status: GOOD (  14.80  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi,

I'm curious to ask which bug this patch is going to fix. I tested it
yesterday and it doesn't fix
https://bugzilla.redhat.com/show_bug.cgi?id=2126409.

On Thu, Sep 15, 2022 at 02:12:40PM +0530, Sourabh Jain wrote:
>Restricting kexec tool to allocate hole for kexec segments below 768MB
>may not be relavent now since first memory block size can be 1024MB and
>more.
>
>Removing rma_top restriction will give more space to find holes for
>kexec segments and existing in-place checks make sure that kexec segment
>allocation doesn't cross the first memory block because every kexec segment
>has to be within first memory block for kdump kernel to boot properly.
>
>Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>---
> kexec/arch/ppc64/kexec-ppc64.c | 2 --
> 1 file changed, 2 deletions(-)
>
>diff --git a/kexec/arch/ppc64/kexec-ppc64.c b/kexec/arch/ppc64/kexec-ppc64.c
>index 5b17740..611809f 100644
>--- a/kexec/arch/ppc64/kexec-ppc64.c
>+++ b/kexec/arch/ppc64/kexec-ppc64.c
>@@ -717,8 +717,6 @@ static int get_devtree_details(unsigned long kexec_flags)
> 			if (base < rma_base) {
> 				rma_base = base;
> 				rma_top = base + be64_to_cpu(((uint64_t *)buf)[1]);
>-				if (rma_top > 0x30000000UL)
>-					rma_top = 0x30000000UL;
> 			}
>
> 			fclose(file);
>-- 
>2.37.3
>
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec
>

-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
