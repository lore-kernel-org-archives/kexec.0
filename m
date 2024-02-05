Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C25C48292
	for <kexec@archiver.kernel.org>; Mon,  5 Feb 2024 17:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fL1ENsTP1Eqje6VDmrjJ8WsGIxDKiJK3EqZJHHz833s=; b=XMAywbezLYqSHK
	s7RDckhPV8NKmjJRRHc3+oI80j9cNVu7goc4GCQptju5xD0BPJkyisk9TflD7jIAGQ1h7U/7OCMZ2
	UMLDNdjAUkelwPotQLbjmI95LoyfN3KwJigCRpW69t3Qkoop+p60hEN/U+m0fDDx0EdNcFv69HGG+
	jLpxE6GLO+ERWVuKF8cQKRHlbU/oGFla7VzHXl+FVr1Xsk2my+VdM0yZJz7YIKmExQQb9vt+gKGCn
	pKTS0t/OI2OEOFbuui9oFcO/qdMpALRqzUxzbK0zAfy7FnmbfEz3546WdL8HUB2ur98MxaDwpD9kQ
	/QKVuGLsDmvOdKE4N1Mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX31t-00000004E50-1Ppg;
	Mon, 05 Feb 2024 17:45:13 +0000
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX31q-00000004E41-3V6V
	for kexec@lists.infradead.org;
	Mon, 05 Feb 2024 17:45:12 +0000
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-68ca1db07ceso6621416d6.2
        for <kexec@lists.infradead.org>; Mon, 05 Feb 2024 09:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707155108; x=1707759908; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kr2vrWVlUyntHvMw7Si5zE2PHtWM0mT+einhFyctsMw=;
        b=IF5pAMCADn2vI3W+/TAz15A42IcOF6wCwzDWaMYxccZqhopp0rnDd9wU9dIS+fXVx6
         Qm9dlYvgnfprzsKsqAMeZc6inRrU/TRGC5TshwNzQ9jblmy9DFTdUGDGJH1eUFddxELZ
         qqHYZTZcobocNFUM6fmwfrXo+bCVRONmegD7/P3JQ3jlu/YCo0UTqQ8V1Ej8LpzQoclN
         zJJoJjQsBBbmLYNhYa5mP8nkeN2QE1krU7F0WPRqSnA0mNlsHp1kpQ+JbX3THZDbT3Ho
         ToSiqi8UaIRnZmNszRVB0vvxPKbrXF+liXy/JgH8lOiMhxNjS044RA1ToMAidVhu5Fd4
         XjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707155108; x=1707759908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kr2vrWVlUyntHvMw7Si5zE2PHtWM0mT+einhFyctsMw=;
        b=taveMrWs/ZGSGa+tiXg8FOgqWsXfmQj1t8vYqIQ7lvJzolbQa4ZmGGugr/MgsgKYqL
         dRv1nXxSVDFJgE+fqQhy/HjDCAEqkrj5geoBDCY/sXoTO22SLavk+7gYkQa5R32lIYqq
         IR5KKvcpiYpAe9EVyI9Z4ezoJzgY3wld69cYN6wtObk36h5OlipXml2wynMxqBSnfz3I
         imGHnYukt2J8DeN3bpwfPKYJKGDLsgmXM786W+ha9FIVMa2O5Nyq/6R4grCbXskhPXsp
         fPbhRSj9ZDhLFun/j4cq5NmCT/35YIBMrIKT2GZ6HDt1RtjVGh0J003qjxMLHGPyIH5/
         gssA==
X-Gm-Message-State: AOJu0YwkeE4Pol63hRVC3vtldujPu9JFoRTQ4FiWfdKl/Wh9OOgrPUR+
	bDiXbY1hV2TUoJfpa0RfZWLCP+5Njs23y4YgD+tFUMR9Oq+AcTh7oJOvymPeKu0=
X-Google-Smtp-Source: AGHT+IHYMw0vd64OVr0zEMte3BX2BoxkRkfAfpiJiAxhjtbWihbl0rcbbYsuxMOB9Sysr++MU/eDAQ==
X-Received: by 2002:a0c:e14b:0:b0:68c:850d:7e12 with SMTP id c11-20020a0ce14b000000b0068c850d7e12mr85628qvl.50.1707155107926;
        Mon, 05 Feb 2024 09:45:07 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWYPsWNFHv61exg+gMCQoag7gBZCOBqvyfZr1G9u+oPjqyrOwq3LYPfZ8DHnZ3lXGCW2H019rMJwKaxvLdC5XJN8bQPMtNx4sk0ynWnOH6QQ0slFrl5Ptdld6MfH+LsWOHXY6wGQ6IS12X4C5mk7za1Dt+B8lfZb10uQeB7pc/qZi7KKSgE4gi5/CGlXF+4KBrVRqMRlkZd5pnzVvhMFtp+/ID8YmfxZrrlM0m4QZoS0fYfjZl2v7d6XT0Gx8rUoXS0m9BTSzGFi8JG1cntWWEOJqGd7n7hHxxx4nUep3NwoA6HXavGEL5rXEZrdH+4UAd5sTZupOuxdbJV7A27rTBK67ACC96kircN6b9iBI1gGhtBpK9vNzQrHhudWql3BnS1EE1AS6aSX0WJ9rQHdrdmf3f9tnqcPEtENeciOx5OKeqVX5FAJReENYnTCNdQvPLNQer06oyzN3teSNcXQ48e1ehHBdIWISjJ7sB2lCzU73LG6HbNiR6oXT2JmXEqVaaiqtvL9iLUZ27KHPnSmSugFdYit9jQu51JSiHQgMtqIEKWj8uDuoLdyqhILWFR2ijsYJiEOHPgbH/hy+qkOlatgS3FAMrr+S/UgXx1wrJIAxxRZPk41WEdoxjJjHo8C0dZRbsUwVnhWcFMQZxRkFnSxxmnzmE6FnjNBZzNic9S6vFkSUtAKElK/+YSZSgxAevXVtsRW/5Env/IJqiTts//EICbFYy2RiY+TC0rAd9SM2NM
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id lx13-20020a0562145f0d00b006819bb31533sm176462qvb.99.2024.02.05.09.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:45:07 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rX31n-000fbS-19;
	Mon, 05 Feb 2024 13:45:07 -0400
Date: Mon, 5 Feb 2024 13:45:07 -0400
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
Subject: Re: [RFC 11/18] dma-iommu: Always enable deferred attaches for
 liveupdate
Message-ID: <20240205174507.GD31743@ziepe.ca>
References: <20240205120203.60312-1-jgowans@amazon.com>
 <20240205120203.60312-12-jgowans@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240205120203.60312-12-jgowans@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_094510_900216_20C024F0 
X-CRM114-Status: GOOD (  11.48  )
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

On Mon, Feb 05, 2024 at 12:01:56PM +0000, James Gowans wrote:
> Seeing as translations are pre-enabled, all devices will be set for
> deferred attach. The deferred attached actually has to be done when
> doing DMA mapping for devices to work.

This shouldn't be part of your solution..

A DMA API using driver should never be attached to a device that is
being persisted across a kexec. If it does then the device should be
fully reset and re-attached to the normal DMA API iommu domain.

You should be striving to have an iommu_domain to represent the
special post-kexec translation regime.

Jason

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
