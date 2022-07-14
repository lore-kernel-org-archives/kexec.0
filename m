Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7ECAC43334
	for <kexec@archiver.kernel.org>; Thu, 14 Jul 2022 17:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=INvvkLMy81e6lx7OHMNbDtw/8aYx6CghYPmijUU9AqU=; b=L+2PQA92yTTHn4
	se6EvDp7aqkbfjeWL2HxxL/eXsPQXfq4lxoGJOoP5ZQx6JVnU1+0oWVFe284A7yfHyFtwyjnU5TGM
	9Yyr6xhmFOi5i5dfVN+SuQp31gu00wspEUEi2NEchMRvv+WUN8DkD2Do9j0UIwmWHFG2KN3EITE72
	LU6UTX/bzOclLKk7VAVDxCG7vLcZOPc40oBsVN6wibseEGWEXqjnpH5DwK+/zoeBg855AlfT+GElv
	AcbhrjW7r/FQMcWaYRJfxWeghhqa1PGEZK7bF0Cbs6w/M7gs45RFubml/82zQKQ3cq0sKf8l0/XX6
	s4Ql2UCNCB0JtAOuT/YA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oC2X0-00GgnI-Id; Thu, 14 Jul 2022 17:21:42 +0000
Received: from mail-io1-f48.google.com ([209.85.166.48])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oC2Wx-00Ggkk-SU
	for kexec@lists.infradead.org; Thu, 14 Jul 2022 17:21:41 +0000
Received: by mail-io1-f48.google.com with SMTP id q14so1967791iod.3
        for <kexec@lists.infradead.org>; Thu, 14 Jul 2022 10:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TwlP1i3DseYJRbHuqOfV0GFqZdryH2G33X6Mm9Jm2CM=;
        b=BXJPaazxiUYghuVhYd7wPll8zTaccWV7MF9yPgfWFYc37xOUskZ0oPOs1vuVfsiJAP
         kFpGKFpbNP7/veYmBjkmZoq9Agx6YgijtxCYuSzKrJjvADUf8/V4uiA48I05895vzy1L
         SZTaLQsziKq+7X2T5q+jf99rJmrq9wjQPUVYCumnY3Binrzd59Ze+o0lhF0Q3dv+4JFi
         ks5keT68bI1luMwTTWjJpDZKGZ0Gi/1w/GBcW/gtgvGrjTk8+O3e4IF/KnTD6qD+0x6C
         9Rf4euyojUdEyVpoWtFULmXUllxUm7lChHcepE6AKsCDN1p+z8IqZ+IgB5lD/+Ikx6+G
         kVEw==
X-Gm-Message-State: AJIora9ewQnJ5C1/MF7uilGzj+9865ijKGgjpvIbCpZAELyj166q0mie
	aA+PkyPe6sRtlA9MG2yaMTXbaKGVAg==
X-Google-Smtp-Source: AGRyM1vO9dGrA7Y7SKsg+5554fBaotiNHywW1yLUMUZ53GyvbeVEnUtAvGac2Q1pjgYrrT0HbEWTiw==
X-Received: by 2002:a05:6602:1682:b0:65d:f539:e30 with SMTP id s2-20020a056602168200b0065df5390e30mr4768576iow.81.1657819297971;
        Thu, 14 Jul 2022 10:21:37 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id p32-20020a056638192000b00339da678a7csm970726jal.78.2022.07.14.10.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 10:21:37 -0700 (PDT)
Received: (nullmailer pid 2584872 invoked by uid 1000);
	Thu, 14 Jul 2022 17:21:36 -0000
Date: Thu, 14 Jul 2022 11:21:36 -0600
From: Rob Herring <robh@kernel.org>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: kexec@lists.infradead.org, devicetree@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, nayna@linux.ibm.com, nasastry@in.ibm.com, mpe@ellerman.id.au, Frank Rowand <frowand.list@gmail.com>, Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH v6 5/6] of: kexec: Refactor IMA buffer related functions
 to make them reusable
Message-ID: <20220714172136.GA2575969-robh@kernel.org>
References: <20220707172026.831614-1-stefanb@linux.ibm.com>
 <20220707172026.831614-6-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220707172026.831614-6-stefanb@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220714_102139_941013_E81BA6B9 
X-CRM114-Status: GOOD (  11.01  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Thu, Jul 07, 2022 at 01:20:25PM -0400, Stefan Berger wrote:
> Refactor IMA buffer related functions to make them reusable for carrying
> TPM logs across kexec.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> 
> ---
> v6:
>  - Add __init to get_kexec_buffer as suggested by Jonathan
> 
> v5:
>  - Rebased on Jonathan McDowell's commit "b69a2afd5afc x86/kexec: Carry
>    forward IMA measurement log on kexec"
> v4:
>  - Move debug output into setup_buffer()
> ---
>  drivers/of/kexec.c | 126 ++++++++++++++++++++++++++-------------------
>  1 file changed, 74 insertions(+), 52 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
