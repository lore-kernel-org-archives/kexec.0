Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA30DF54ADA
	for <kexec@archiver.kernel.org>; Tue, 24 Mar 2026 17:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oHY3J33g6ujwnRTqJrGO/jD1PTpcRqvXhZiCbNP/dps=; b=Lq0xOHmEfqd2+wRvxgYUmHn5sU
	w/srtVD09tOW70lqjjgVeh83aRTMT7B7S2CpKIltr9aUwfNgBxkQ5fSJ2Yc89SF2i35HMfgjsWsh6
	CYWzhPrXx1XXX7WRh3189vBdhryz4P1gpkOet+Ntx75KWcLLtch+DTPv54mKLr4tEDjEThw/wf65w
	e/zuZx1TudJrfQd5UgZD9EsNvm8LmmEqbJRVEIApOeB8fnx93CdlPp1CLKjoS4moT4HBwSMrcyqvG
	xLBrrzorcOqBg803aHGTkqUu+9cqKJ7/iaJNw3cguwuKg4G2aKDy0c+GAaz86+Y4bC4rSgk4T7LNX
	nSo5CqnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w55Ce-00000001yFg-0ivv;
	Tue, 24 Mar 2026 17:06:04 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w55Cb-00000001yEk-3sSw
	for kexec@lists.infradead.org;
	Tue, 24 Mar 2026 17:06:03 +0000
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-35ba2ae4df3so2872981a91.2
        for <kexec@lists.infradead.org>; Tue, 24 Mar 2026 10:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774371961; x=1774976761; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oHY3J33g6ujwnRTqJrGO/jD1PTpcRqvXhZiCbNP/dps=;
        b=Us+z60EkbPSewgzLLu3pYiT8bAa5zWM+0ugFB4aEKdym3AB1GEE28I/JRLl60QlcOs
         7dW/Dw7EeQSk9PNe42Gpwp8cPULyod17HVA7fNfaXvZ9OPPXWpRm/tsUXCi5cmmkPLOE
         xx9XnDLkjbHoYMQTRlC6O1dPiKcxKRJe7544Yk36KaLwoTn3uP+WnNRnciVeQ+8ploov
         mVcLTFhjxuf21x5tWvhLZTVJ08ZApwLbtlT69vAPcXnhyCC2bh7taXSu9OMtGaGTaRiG
         EqB8YVwIbnYFTJPU7Ad7CB46KVliCDjNr9MkWJ+HTllfHceilZzo9ZlBEFQ2k5gDfMit
         P0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774371961; x=1774976761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oHY3J33g6ujwnRTqJrGO/jD1PTpcRqvXhZiCbNP/dps=;
        b=ekPAW0ekKIZPGRHIMLxo4IvU4Q/eBUWjl+F4dgQ1k6J0PgbsaNaw0LMwbVUYKrcHoN
         KzL0xPoz2FWhL+YhEZdyO0BAKEJqTOpvAEE/S1hP+flmA/jai3Ej6wIF7umtUhqmolHr
         T88h0dT4R7wfWK6NffzbQzVLUxGAG8X/oTSFKg2MUd2mjYRCbQbKsBoyFnD4Kyjb6/6h
         pr/YHlKRW/TMFeJFtTjTPaVFyhMVVQw+PsBn1iRU/oVvfPVFSMT4eHg6eYCPq/c6YdU3
         0r4FwjZH/0UzU+4lC2MNActaFS/8JoN16bJOWbtt+kAjNYmjKRdBJ1Y/jE5nvPjGCW2S
         YH4A==
X-Forwarded-Encrypted: i=1; AJvYcCVJFOVHgcVHdp3vCIKSBKcO6j3ujRvtLbjdreq0GtGIpDxsCofrUR1rBi1q/lyKwOg/oOj33A==@lists.infradead.org
X-Gm-Message-State: AOJu0YyjBOlWhCqs3FEIxjc/0FbeT/1xn1w1KrBI1YkTm/1ABhbmb9eM
	BYI1sFZBt4q5NjoPqdTkONQrBwoOUzcPfIXlT38JpUmoBp12YZj4OfkNKxS4ACM0+w==
X-Gm-Gg: ATEYQzwxp6bbHJvstK3UhyZCDuzYEgWZ/4/ZmkVDwdREA8MDExxuLEglObt5hBEmLui
	Nrx3TZflFGddrZQksSh5v6c7QMT9jTwLN+fxrRZAYclVS3lv8uzhk3ixeehYpMtQTDHFGVf7bha
	fDQGbmcTLVCoJ6puo/q+ApmqiZDs3Iqu3C0A8hSOjgScMNeCSjpBabSGfox5JIoALYSCiv9d1nq
	jqrjKac1pI+AwnNLx92rNp8oD5qxP2Cy+KSbDAG0IvP+nR4xpDPab8z8gAwDX8aJXgURvdV4kV1
	P7efCwpOYFhb/Vj3rsHobvyidcZZFBpl0CWk2gnfXr51MsM97Wch/UX0khoHsGyifWsytfaJG8p
	hzi7+qU0DN5iH18rETY7tczu3nC9GGKSkdip6OkxI23U+DZWjqAdmB85sC94xizV1rOMjppUDDi
	APZEXFY/chkHGM96KfPXzgAbA7mu1YMK9Eo8oILyR/1zwfVcf8Di5tUs4rruENog==
X-Received: by 2002:a17:90b:2249:b0:35b:a53a:7d0b with SMTP id 98e67ed59e1d1-35c0dd3ae00mr92968a91.20.1774371960194;
        Tue, 24 Mar 2026 10:06:00 -0700 (PDT)
Received: from google.com (239.23.105.34.bc.googleusercontent.com. [34.105.23.239])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c03172a8asm3524836a91.15.2026.03.24.10.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 10:05:59 -0700 (PDT)
Date: Tue, 24 Mar 2026 17:05:55 +0000
From: David Matlack <dmatlack@google.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ankit Agrawal <ankita@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
	Askar Safin <safinaskar@gmail.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Chris Li <chrisl@kernel.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	David Rientjes <rientjes@google.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
	kexec@lists.infradead.org, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Li RongQing <lirongqing@baidu.com>, Lukas Wunner <lukas@wunner.de>,
	Marco Elver <elver@google.com>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	William Tu <witu@nvidia.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v3 08/24] vfio/pci: Retrieve preserved device files after
 Live Update
Message-ID: <acLEczJW3sGpeL5b@google.com>
References: <20260323235817.1960573-1-dmatlack@google.com>
 <20260323235817.1960573-9-dmatlack@google.com>
 <815947ee-2603-47f0-9b03-f523601eae86@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <815947ee-2603-47f0-9b03-f523601eae86@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260324_100601_964553_E34635B9 
X-CRM114-Status: GOOD (  16.51  )
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

On 2026-03-24 09:08 PM, Yi Liu wrote:
> On 3/24/26 07:58, David Matlack wrote:
> > From: Vipin Sharma <vipinsh@google.com>
> > 
> > Enable userspace to retrieve preserved VFIO device files from VFIO after
> > a Live Update by implementing the retrieve() and finish() file handler
> > callbacks.
> > 
> > Use an anonymous inode when creating the file, since the retrieved
> > device file is not opened through any particular cdev inode, and the
> > cdev inode does not matter in practice.
> 
> do we have a list of struct file fields that do not matter?

My understanding is that VFIO only cares about these fields in struct
file:

 - private_data: Pointer to struct vfio_device_file
 - f_op: Pointer to vfio_device_fops
 - f_mapping: Pointer to vfio_device->inode->i_mapping

This is based on cross-referencing VFIO_GROUP_GET_DEVICE_FD (which uses
an anonymous inode) and the cdev code.

> > +err_free_device_file:
> > +	kvfree(df);
> 
> any reason to use kvfree()?

No this can be kfree(). Will fix in v4.

