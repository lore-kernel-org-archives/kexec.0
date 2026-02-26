Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90193FD9E22
	for <kexec@archiver.kernel.org>; Thu, 26 Feb 2026 23:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uUrZ9rZ9RlW3x07tCEk7xJ4J4Vz88lZHdKC8XE8Cxsc=; b=m1aFnaYbUWuhiD+rOLXpAeLgx1
	+z5k+uLwv+2ypIqXk9InzqDa/mDitlehtavkPFJQwiBJtp3jSE7U1gPUGy/xxrHOSwavfv48jjFD0
	XJtB0uPlLDAcQvb8ye966VtLGs4TO7UnoNsK3E46DjtGzIkZ8c0NQqpt4MOH0Hps3CztoNaTkPosv
	5W2qyEbZH39dE6aLR0pfLWry2UnadIf859wqZ73gGVRMpixRKt+OMvy9SzgFQ0Qkoa+YvJHESBMmj
	k7Ltb2ChQS+4O1AUi3MbZrvTs9el0ZM/aOAmDv/XB4kUx9AlLRiGlZl2rVEaWBnHcitEurcXJQpfW
	9FL2vbjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvklx-00000007NiI-38AA;
	Thu, 26 Feb 2026 23:27:57 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvklv-00000007Nhv-1Fnz
	for kexec@lists.infradead.org;
	Thu, 26 Feb 2026 23:27:56 +0000
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-82746ed8cb1so477492b3a.3
        for <kexec@lists.infradead.org>; Thu, 26 Feb 2026 15:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772148473; x=1772753273; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uUrZ9rZ9RlW3x07tCEk7xJ4J4Vz88lZHdKC8XE8Cxsc=;
        b=yZK+fuGoG1EGchiq6PbyOx/Ms/2F1+MI0NVVIzFCUHCg8vRvooBOfjQfvTMTnXMXt8
         TO0jWdiUvsMPSE0hOugPM62vs/7vOPZdoFB6N6PsGzUifG4d2wfcHJ7/WpVggrrfhN5G
         lzFTVVAONpR7IdL7Lm18glHUOBkXb4VqO/I6M3rVW3TypNc3rREmY47EoT5eazRf0PxE
         WvnOGS4SoUTVrjICCsqn1PbR4VYl2zJnkETk+kRfqvS4mTLSt0ghEu4Ve0f2A1AbvfJk
         0i2kPM5iL28fQk8ZAJORlA/oDiQ40jEbQeLyMqNNfodCojxyPf2C1f+mkLSM6nRVj/qL
         +g8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772148473; x=1772753273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUrZ9rZ9RlW3x07tCEk7xJ4J4Vz88lZHdKC8XE8Cxsc=;
        b=X4iXLNc8NatSuwVwAP334FPQirxBcShfIA8Fy7ADVt13XAG6Cg/wRycTR7zFqRiMKK
         esWJQSskZt4pxq/MuPmMTj8/A8hs6SnHI6UN8zo86kHtXLtgsvRtRNtZV3cyWJz5MmgH
         AnFmjL/YFhg2JAtz4+ROilA0Z5lfMGHsc6UOBX1Z37QSEs+KVhQeK/KjXlq9veOeLhC5
         6cG5QH1u3npQP8Bfp3nheHsLXgs/K7zX7huWJ6hf/oOUhJn9CJ8mVpQJxdRUgu7zGnwA
         OH/oUsdH0ZFOh9XADcCX1phfaHYdqBwjFZe3oL3pkiGE+EkBEALOntF29Y/A3Z1WMMFC
         PvbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCp1iOTr0avYCxser+j4k9f3dYv+5d3x7mYG+hTafN0GJQIxqP8/IqiI8epXUGVDRECcwtvA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzgm1yhmVwu1l89mZApcxtOmhXrdRrdVMpkJAybrJmDWQ6TkTzU
	XPQeZIsGq+jGVtex8E9z3cxW0Yifp+hwbemSBhQCvHJzlf/6SzVPCoFGZ849oItLPA==
X-Gm-Gg: ATEYQzygznqVyHi4hmtXGe8nj6mONaRsUqvBOiOgifampHfB2sngi9+Y9VirheD5na+
	GeSTeNdKS4fPjyC0miqopig3nOEb07CLsdetobmtI7JsD9BxbrJ+ZNtbDiNsLhL8KMne4usIAOZ
	TK3nv7Ms6ssoNsJL/rd50ZAJI/DqVOtP5WreD3Zy8HQdaDECV0RqaFXjH+b9ZiRa3qRnEvQIXFT
	p6lHwXm0MsXAVd275VZFsgbHeyoWuJI+CIofRlGq8lyrk4kHjvV2JhRZq7pGHc8e7P3l9AeYuSw
	aITCm+ED6UqukV3M5tLU1RvyywAPo/Thanfc0E3a3ULX6xXdpAS3VhF5l/GlFAY5SAs4tq5TFo4
	8Dw1iUFflCV/OmIDSsKQ8L4ZYVfA8CJiejDalDXAx3yBkMFaJgE6DsWBMyI1GwJiAbrkAII3W3W
	w9EbrCJSJ2uBQiahL2WzoBMugQjidYahADsqoLdT8oAW7gE+ZjWgouGlta7iYI3hniCAK+McwB
X-Received: by 2002:a05:6a20:1585:b0:38b:e9eb:b12b with SMTP id adf61e73a8af0-395c3ae6d18mr701611637.41.1772148472659;
        Thu, 26 Feb 2026 15:27:52 -0800 (PST)
Received: from google.com (239.23.105.34.bc.googleusercontent.com. [34.105.23.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6a03fbsm48080705ad.43.2026.02.26.15.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 15:27:51 -0800 (PST)
Date: Thu, 26 Feb 2026 23:27:47 +0000
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org,
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	 =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Tomita Moeko <tomitamoeko@gmail.com>,
	Vipin Sharma <vipinsh@google.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 08/22] vfio: Enforce preserved devices are retrieved
 via LIVEUPDATE_SESSION_RETRIEVE_FD
Message-ID: <aaDW86eWuQLZ3cfP@google.com>
References: <20260129212510.967611-1-dmatlack@google.com>
 <20260129212510.967611-9-dmatlack@google.com>
 <20260226161512.532609ec@shazbot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226161512.532609ec@shazbot.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_152755_343667_89CC1165 
X-CRM114-Status: GOOD (  17.47  )
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

On 2026-02-26 04:15 PM, Alex Williamson wrote:
> On Thu, 29 Jan 2026 21:24:55 +0000 David Matlack <dmatlack@google.com> wrote:

> > +	/*
> > +	 * This device was preserved across a Live Update. Accessing it via
> > +	 * VFIO_GROUP_GET_DEVICE_FD is not allowed.
> > +	 */
> > +	if (vfio_liveupdate_incoming_is_preserved(device)) {
> > +		vfio_device_put_registration(device);
> > +		return -EBUSY;
> 
> Is this an EPERM issue then?

I was thinking EBUSY in the sense that the device is only temporarily
inaccesible through this interface due it being in a preserved state as
part of a Live Update. Once the preserved device file is retreived and
closed, the device can be accessed again through
VFIO_GROUP_GET_DEVICE_FD.

EPERM might lead to confusion that there is a filesystem permission
issue?

> > +#ifdef CONFIG_LIVEUPDATE
> > +static inline bool vfio_liveupdate_incoming_is_preserved(struct vfio_device *device)
> > +{
> > +	struct device *d = device->dev;
> > +
> > +	if (dev_is_pci(d))
> > +		return to_pci_dev(d)->liveupdate_incoming;
> > +
> > +	return false;
> > +}
> > +#else
> > +static inline bool vfio_liveupdate_incoming_is_preserved(struct vfio_device *device)
> > +{
> > +	return false;
> > +}
> > +#endif
> 
> Why does this need to be in the public header versus
> drivers/vfio/vfio.h?

No good reason. I'll make it private.

