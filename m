Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9088C4828D
	for <kexec@archiver.kernel.org>; Mon,  5 Feb 2024 17:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jEFM9PzW85JoceXoJjlfG1ZeZowXY8dyNEg+xh/hKPg=; b=qUS8c9I2Tfr8zH
	N7YO9wG63ImEECPwp6SsbI9h3pDzdktH79FwFhmfqtm7rQEjEkE4Wxx5XPpRdyXdcR5Mi1mOuCmZr
	TzEe+FltUtMLFG3p+cfHqWBar3nGAGPZH0cKOwbQxna4PTxLOEkT+eUzKJMy1j+MLFfA7REcBGuoC
	o3H1TIDSFMjzPGdUBGyYKPCjBBSX3NrxomCKctRQBirJ3XdWRUOts0wWXHXifAS4iD3rTyCEvB7Un
	njbBnKBsDTBfA/kx8kQ3qH/tBL3U8pgnFrEGkBpU9AL1IZj2+NDbIFNIIawGhyYzynPyDdWdHvjrp
	zELNSJt+uisXbRnhiUqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX2Sc-0000000450J-2lzi;
	Mon, 05 Feb 2024 17:08:46 +0000
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX2SZ-000000044yd-1ezy
	for kexec@lists.infradead.org;
	Mon, 05 Feb 2024 17:08:44 +0000
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-42a8be32041so38881041cf.1
        for <kexec@lists.infradead.org>; Mon, 05 Feb 2024 09:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707152920; x=1707757720; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8gBlKfQm3vRprhFc0/QpnWE8p96XYPuWr7rTbz4Ejy4=;
        b=j8jO4CaWO91vvyeEdZ3HvRtNXjoRGfVkMr8Fwy/FJV9mlu5QtEyBF4l7FP0m8ZxOa9
         F4rpkx1Yb2uBhzhTlm69D2UA8T6+VTbGbCKHYHqFFAOfkAMhvknUVIdJb97xi8qdEuQ6
         NPJtFb8OiZi/mYVN7LgyqhuIVZEYRvwaU0RARAVBo/AR0OrvINwltS0dMRyEEphJ4kV4
         yZ/JJhKnfVx/RsIhIMDY0cKhn96/ADvZISc3J6KtrqEE7PtNYjz57tTQbDyBDDLy1o95
         Bg6Upj+tkJyJDOYgN/LFa2bnjABOvVSTU9wjtlW+W4OCwMaq/HdWojs7DdbYRatMgPCf
         cUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707152920; x=1707757720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gBlKfQm3vRprhFc0/QpnWE8p96XYPuWr7rTbz4Ejy4=;
        b=si5PGJVgYVg8TBn5rbMSjkXO03kbPZVNoQFwJGoa4j5/5Dnq3ChmnNU1VvxVy55S1e
         4/Vg6+WkuOi5r6Do1FfF5y52cJnuSY6YylvwYfcM0PqxT6F3sqDQGMdQRIqoSxL5bTD1
         3Y3ilI3whNUxvuG3TOSRNG3N+VPWeRO5CPJ2/6zOTa/oJdQJ1Um78xAC3STROHXsWRoX
         hNj3dQ7No5w2vtYpu+Yx1HAAptB3/Iuat7PbQ3nXLjTgbIgEN6K9zxQhoHCGMsU6/FNr
         OsYL84q5eQH8tHMVVgbtdMhjFgBedGSxVpAfxcqZ55hssJvOQ8OUblQd4/En+rV14/OM
         fIEw==
X-Gm-Message-State: AOJu0Yyyde3sF5SvCexQdDTb6yzsiH51pDT4111iUoSXlmkZqywl+4jr
	haZ2hhSWrur3cmdAaNBsSQukvzqpux3ppFYNMjce2GN9OKbibqaof2fUi53fgl0=
X-Google-Smtp-Source: AGHT+IFRr68RJWhr55aAuCOmm/7ig7Z946GhQZxCWJnXpgTkXxQZq9u9NN3DdLuHLeVoxwlh1gajUQ==
X-Received: by 2002:ac8:6bcb:0:b0:42a:48bc:f69 with SMTP id b11-20020ac86bcb000000b0042a48bc0f69mr7977973qtt.35.1707152920631;
        Mon, 05 Feb 2024 09:08:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWFnZsn/+oaH85mYCSnpv4YgXZiAdaRH0+Rq60h3VhSx80V/GhIDkgZR10vmkuwF1N3jhhz9aRo8LLD4ff5OgXLimlfMXcSIPuyfjqJcxPxDRiouB5DndZ1kQz5dDjvpSVf2qZnwpdmYLKdUUiGGPxIlHQiPas89V0qswdC6497cElumvLrngGqTJkZscqv6ouG2f0OrpG6Ei2Zn4TY19Lk9NbJPoaaQZIBZSq0XCtZUA7d3PA2XkCWjmZueMp2A4tCAorCWj6i6E3kIrdi2y7VdUXMK5IQwL1ODMaERiIbTXBJbVrhlVGqhDyHvDIuotZrahRKcH/dGKlHT6GOh0AiVMK8Tzohvd/1DqWSOsUrv6/uL6cpoulHtaNasUn2g1+as+1/aN3+PukRM38uB/fouGVfLgmdpOE3dunZMoCAT8ZvWsyLQq5HJzPKp8dnEjpdvCDijtK2oY+4Fte+c9yCkKSI9o3pZZZEGbyVB7g/qoYjmnzB6UvMvTFVVXtvqMnEmcwOaYKyi0HF6aat2Ve6C6mKE8L/YuQwof83w3Z5XmIHwIZ2oGMal/R+I06RZSVRWXaOUkQuB8sHRlexzojF3AdtuOI7nq6sqs2lcG4+ML2g+c2ZAxM9tnpLd69JMkvGu7iMwJ1692U5EjqV1QDP6l+mc+OUUzf8X6XSuc3UdFj+vXovcLlbwYzYR22mSvd+Sld4DusAh+aVZhGTkOMpJe7mDCGP0YbiYqikir3ZKx0d
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id f22-20020ac84996000000b0042c22902ca2sm112941qtq.81.2024.02.05.09.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:08:39 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rX2SV-000d2w-7N;
	Mon, 05 Feb 2024 13:08:39 -0400
Date: Mon, 5 Feb 2024 13:08:39 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: James Gowans <jgowans@amazon.com>
Cc: linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
	kexec@lists.infradead.org, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Alexander Graf <graf@amazon.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Jan H . Schoenherr" <jschoenh@amazon.de>,
	Usama Arif <usama.arif@bytedance.com>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	madvenka@linux.microsoft.com, steven.sistare@oracle.com,
	yuleixzhang@tencent.com
Subject: Re: [RFC 13/18] vfio: add ioctl to define persistent pgtables on
 container
Message-ID: <20240205170839.GA31743@ziepe.ca>
References: <20240205120203.60312-1-jgowans@amazon.com>
 <20240205120203.60312-14-jgowans@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240205120203.60312-14-jgowans@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_090843_564562_39917E31 
X-CRM114-Status: UNSURE (   9.67  )
X-CRM114-Notice: Please train this message.
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

On Mon, Feb 05, 2024 at 12:01:58PM +0000, James Gowans wrote:
> The previous commits added a file type in pkernfs for IOMMU persistent
> page tables. Now support actually setting persistent page tables on an
> IOMMU domain. This is done via a VFIO ioctl on a VFIO container.

Please no changes to VFIO in the iommu area, new features need to be
implemented on top of iommufd instead.

We already have the infrastructure there to customize iommu_domain
allocations that this can be implemented on top of.

Jason

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
