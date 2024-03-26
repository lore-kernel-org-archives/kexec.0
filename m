Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1879EC6FD1F
	for <kexec@archiver.kernel.org>; Tue, 26 Mar 2024 15:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dNrI1vp6QZyI+VC2xzs4RpYj9lpb2uP1UzbIkjeVKow=; b=3KCkqE1+1mEFFn
	6XKb/aq0G8mq21pJXHXwI2OFednopQ02491HZjKl/zcUQ9tu9zamnH2RTdx19vbzXNQdecmxnSqbj
	EL++bstKO7nsqf5m4L3thR8GsbFE4Q+n0lDPd+yPW+yM87NKo6gh3LbNnWjI7b+D/8OOWc75zha5G
	Mhd//XnBU3D9v57fnF4lZ2ly879qHRnXI82rlgnhNKiybo9qy/HdRfGXW67Ga6SqtPzL4VhfJSocO
	tPEkiyyI+avTOlGV8gZHf57S67oFGWt5i3fHcvrot3N3DVi2teR3nDPxEenzRQ8lDSDzBHH+6x3rW
	GXL63yeQPIufd/jgPlXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp8mt-00000005BAq-1ZZZ;
	Tue, 26 Mar 2024 15:32:31 +0000
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp8mo-00000005B7u-3bL7
	for kexec@lists.infradead.org;
	Tue, 26 Mar 2024 15:32:29 +0000
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-690d7a8f904so59122046d6.1
        for <kexec@lists.infradead.org>; Tue, 26 Mar 2024 08:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1711467145; x=1712071945; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O3SHR7HxdotDZ2M8AZNxpUiAzi1WTnbP3eb5Z70DWwE=;
        b=bYMsaqWCl6KLbgAeQZyHYEZ1bClTj3bH36cr/Vor8NY3puP8zjmSWHydLau7uwaml4
         +lxAi0d5VicPsAPDM+Q9hQsFqlguOYjwduLeR1CGOSe1y9JK0fug9B8oRqqMYhsOvT3s
         q/nH2s6Ux7pmIwMcGvwyIrIJV+lBxwEfkPwUgLISCeiREvVSUYpOoGIRW1+1+9G9EPjU
         KDYGCSzB+Go3nQm6JM8lWokaDHaKLGTok+Ve+PfXJraAlMJoUB3QEq0OOePFfJ8ZJG5+
         5ZFJf5fw7IVz4iCGly+Uln0Vtuiz8saPVDDSAxQqjrrVuUgJ6kRWynKjFZtUDGoOlnAC
         ILIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711467145; x=1712071945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3SHR7HxdotDZ2M8AZNxpUiAzi1WTnbP3eb5Z70DWwE=;
        b=aFoZZnFUb0gQiibt8MF3mDQGQM8sMswpCWoqEwj1s3XyQu+9vCfV18gbAMApGFdZLC
         YzH7K4DR93HAjHdKEdG1ZAOc/INuXJEHXb+xjTH6mQ5uuyw7q19mOfdQyzYxYKXcbDYs
         h5Rv/DDtnsMEKqj+S11A1F19USIfKKDAT+Z6pOgJz6VKGIS2pHBdh0/Esxk+MqMbCepY
         tQHTYF9B4TiOxqMhWcTBNqrxJVTLvbfsGw9aA3WT6Y37fJOEzhtnVTY5RS4wbcpnyYTS
         eonPu1wQw9jDYEqKpxGt7lcUkF3hoyfI0QAnF7eASpvsfuhJt0uuMJ0CvoO1KhZtSyzs
         BYog==
X-Forwarded-Encrypted: i=1; AJvYcCUY5J7b4H3JXCm7UuiowDXkoQUW7WK+ScQvlNL/npazXy8xkgBwe6s6DDHjiwmweO6vSt/VdfSdYn20XjGY6DEXGOtUXN8RWcWK
X-Gm-Message-State: AOJu0YzNoHar3CloDFiqjkwI0X6GK47x7Hf1zX06wyAjWhbeG2xqomdt
	k8ZZ4K4hcSGDFtZKQFt6qQWn0JBHYXfH18EAPWfflkbHPv7mJx5I7KApJMvu24s=
X-Google-Smtp-Source: AGHT+IFb5rsoFzP1zcQcm+tSf+kkK6vnwteEHMmMK0+qzdpITXfqA9F3uCSQSSM/c2javsPnq0SJmA==
X-Received: by 2002:a05:6214:2249:b0:696:89ae:9f57 with SMTP id c9-20020a056214224900b0069689ae9f57mr2883743qvc.25.1711467144748;
        Tue, 26 Mar 2024 08:32:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 5-20020a05621420c500b006968303bf73sm3279781qve.94.2024.03.26.08.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 08:32:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rp8ml-003UNx-AR;
	Tue, 26 Mar 2024 12:32:23 -0300
Date: Tue, 26 Mar 2024 12:32:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Margolin, Michael" <mrgolin@amazon.com>
Cc: Tao Liu <ltao@redhat.com>, Gal Pressman <gal.pressman@linux.dev>,
	sleybo@amazon.com, leon@kernel.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: Implementing .shutdown method for efa module
Message-ID: <20240326153223.GF8419@ziepe.ca>
References: <CAO7dBbVNv5NWRN6hXeo5rNEixn-ctmTLLn2KAKhEBYvvR+Du2w@mail.gmail.com>
 <5d81d6d0-5afc-4d0e-8d2b-445d48921511@linux.dev>
 <CAO7dBbXLU5teiYm8VvES7e7m7dUzJQYV9HHLOFKperjwq-NJeA@mail.gmail.com>
 <b6c0bd81-3b8d-465d-a0eb-faa5323a6b05@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b6c0bd81-3b8d-465d-a0eb-faa5323a6b05@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_083226_985545_F5F93D3C 
X-CRM114-Status: GOOD (  12.52  )
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

On Tue, Mar 26, 2024 at 02:34:45PM +0200, Margolin, Michael wrote:
> Hi Tao,
> 
> Thanks for bringing this up.
> 
> I've unsuccessfully tried to reproduce this kernel panic using production
> Red Hat 9.3 AMI (5.14.0-362.18.1.el9_3.aarch64).
> 
> Are there any related changes in the kernel you are testing?
> 
> Anyways we do need to handle shutdown properly, please let know if calling
> to efa_remove solves your issue.

efa_remove should not be used for shutdown..

If you have an iommu in your system (smmuv3 for this ARM64 case) then
drivers must implement a shutdown handler or you will risk data
corruption on ARM64 sytems during crash.

The shutdown handler must stop all DMA from the device.

If you don't have an iommu then the shutdown handler shouldn't be
critical.

Jason

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
