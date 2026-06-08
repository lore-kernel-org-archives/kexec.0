Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D51CD8C9D
	for <kexec@archiver.kernel.org>; Mon,  8 Jun 2026 12:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tJaMwlHdD5ukSuw9Ddmz9W921lhUeR/xfWp0HtFNkEA=; b=whK5rhQ5xdVTGWijRwuOWd1X2+
	fTPNz8QAmJYmPo4MorJO95frv60EGXnoEZ46LVtO3mfqkad8e3GyuW3T3iaFHxHiZ+1TrPCQLl09a
	m4YwtsyX+IQH/IWKabqU/qH+yEzQtlY8w/tpu423zzpz2osW883FWRONbuKSlGB0oWFdmrRqkRlDn
	ikSdiqamcdoxWMh8cdrjRG24JEEu5VUoTYWrXttKCjNtKh9lbTZJdyvUA1eTuavruqTtDsJAcirBI
	AR9I5XpnmK34RK0RpByJVwTCCEB0iIBguBibe9/gH0Uhys5ToXdLcsR/rvEUTlqeJmyRL6+hvrsLz
	vYrb54wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWYgC-00000003Tsh-3YQp;
	Mon, 08 Jun 2026 12:02:08 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWYgB-00000003TsM-0Nql
	for kexec@lists.infradead.org;
	Mon, 08 Jun 2026 12:02:08 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2bf2911f93cso298545ad.1
        for <kexec@lists.infradead.org>; Mon, 08 Jun 2026 05:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780920126; x=1781524926; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tJaMwlHdD5ukSuw9Ddmz9W921lhUeR/xfWp0HtFNkEA=;
        b=bMhH+IECLZGjx1RQRH9sKzGprnbV5pIeoqe0HAwhCRzrx3SINB0wFBKVfBgDCyhNtw
         tGybxJcr0yC6R2+1p1P6gyLnaGmJ4Sm3HRyERmFwn0W59egUQsfJ0mfwF9756oJfZF6J
         Yuu3tDEvWcbs25GkxYdXplACb6cV5+BxJfTqtQpTIn/tdFo3qamvXc2a4IxPCGayiR0l
         LJsFwTR0V1+SkO1CmmyS25k/tcGYCU9QZP58rhfvw/YgAEje+QyrafXbyBixGth1bEb0
         HcJbdeun49avmh6X7sdDWwpiwiPdom90D/OXFb0wDFZ2Sz7aEOjchtMAo84NsFhRydVD
         YHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780920126; x=1781524926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJaMwlHdD5ukSuw9Ddmz9W921lhUeR/xfWp0HtFNkEA=;
        b=sIY0sntQnjIT1cxyuTMt87l4cuxSGDFvRjZ2XfdgWV9Ku2i9FqQ8JILIgQIb/A5CL4
         G+UpmuZXf4Chl+eJvuBjVWx4VQ2NbVpeRaixWVtLWKda1XPdEZpY4QPrucDhzHhUVohx
         5Zc2z0TjF5ie+jVhHEczRWrfD9x3G8i2FXtIdaVmuxzfMNaw36G0UWOguyNsQl7jxlfZ
         lce0ORSianpSJYQ6UdvPdgBFGobmVspazdHIrjGp2M3q3pp0hRVWBVVvcwpVqvGKvzS/
         nR9eGvgNmbDaLRxXxjOteeRXJ3zmJkaUvZZV44TBYF3pyqsDBh3id49zaoLbsRD3Bq4F
         hNPA==
X-Gm-Message-State: AOJu0Yx7TqKpkU6M086lDU3EPP/Y/AIxDE0OB/HpxqR1dOhxOmSD5d1+
	wc9F1qTHard4G0fRELEJt3y5EckUR8sjiHBeikFRGuPFqHLMilz1t3myVQJTRpHyqQ==
X-Gm-Gg: Acq92OEzw+wH0sg23a6DT2AHZ45pwkAwXlRPo4jjN5ryOgpjfG1AmQ6GzwQxrMm6Hvb
	zOAJd9Vle7RjVshu6MHwe9gSf4U8qHYP3SemHTiPjzw30vPvwJdzB9NPDi0DRytBSPfCme0WrWL
	MLBNTcSs0c3WgOJYg1eEbv/rdy0v8vK5FBaVIz0BtjwYJtiw9fztT/MiO/9azZJuaS253CTeF0w
	fpKQAE3O6RwV0oO9SoCF377f5uTxBxfBcytwJCTf7NITfJnaw+uJRJNogsHnQTX0nCiBDpyPnRS
	Rh4eIihW89cV/XCl9m9DhTUgfAqGlbNqE2kX/0oFm79XtMqRg4Jb3Yvdx1Je74VcI1UKtcKLzTv
	pPDVQkJDET5NxHLnfjs5KEW41P1wBXMe6znrbQ+UViX5dgWoF4AyQlxhd2AieFaDBB+cL4Dy8mk
	3ZV/EAqWHWcTL7SiaU9uCa9ZdneQf1iQ4qkv/cNY1gzaw8lI0OhPCFI0LUuipgZ9sF/ry1TR5Cs
	wwPMIzASA==
X-Received: by 2002:a17:903:ac6:b0:2b0:aee4:afe7 with SMTP id d9443c01a7336-2c1eb1dbf25mr5272565ad.10.1780920124143;
        Mon, 08 Jun 2026 05:02:04 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f85de1sm180971895ad.20.2026.06.08.05.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:02:03 -0700 (PDT)
Date: Mon, 8 Jun 2026 12:01:55 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 12/12] Documentation: PCI: Add documentation for Live
 Update
Message-ID: <aiavM2JWPds-mEfD@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-13-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522202410.3104264-13-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260608_050207_132167_0F7866BF 
X-CRM114-Status: GOOD (  13.68  )
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

On Fri, May 22, 2026 at 08:24:10PM +0000, David Matlack wrote:
> Add documentation files for the PCI subsystem's participation in Live
> Update.
> 
> These documentation files are generated from the kernel-doc comments
> in the PCI Live Update source code. They describe the File-Lifecycle
> Bound (FLB) API, the device tracking API, and the specific policies
> applied to preserved devices (such as bus number inheritance and bus
> mastering preservation).
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  Documentation/PCI/index.rst           |  1 +
>  Documentation/PCI/liveupdate.rst      | 29 +++++++++++++++++++++++++++
>  Documentation/core-api/liveupdate.rst |  1 +
>  MAINTAINERS                           |  1 +
>  4 files changed, 32 insertions(+)

The kernel-doc directives seem to be wired up properly, along with 
formatting/indentation while keeping MAINTAINERS in sync in the same go.

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

