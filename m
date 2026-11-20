Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF75D606A336
	for <kexec@archiver.kernel.org>; Fri, 20 Nov 2026 00:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WRVmDOJA;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XImeq63N
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=hAC07b8lFLojHV0Uml6G9ei5fnLsVAdumfXqcmefGN4=; b=WRVmDOJAtYZWdi
	7MvTHnHftg39gCoZ0A1pg6SiQ1EG5PiZxcUVWylYAFxvGvsGtrgFb6qZ1jsFLvfS7ZLkoMopoGXTf
	snXuvk6QNDqzGrmMjqRBueJxOGKlDKgcOslfKpRhuxuLeBijaLt0HjqvE1IKzmqNLT7B1tXtwOfRr
	XKbLFpssrgLzG/8HOd0mfKp5ORxyx4yrS7vUDzFrVLn2wKzMf/UDYWaD7PMJpxrHm+GLdcyylyKi9
	m3C7kyggiCuPM2Fx+5Z9OzCUM0zIrukB3FRcGPxg0s8OtcVSeK6ZxnXUL54FJORoa2Y75sHoUJ8T8
	u625RoSwVVWTKUeoCW0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUCIh-0000000Djcl-0jqH;
	Fri, 20 Nov 2026 00:16:23 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUCId-0000000DjcN-2t8a
	for kexec@lists.infradead.org;
	Fri, 20 Nov 2026 00:16:21 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2e98798cbddso1369715ad.0
        for <kexec@lists.infradead.org>; Thu, 19 Nov 2026 16:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795133779; x=1795738579; darn=lists.infradead.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hAC07b8lFLojHV0Uml6G9ei5fnLsVAdumfXqcmefGN4=;
        b=XImeq63NPfpEpRynKPeZWb3sxYIfc+wOEWPz8sjzJ/xYRP+Iu88xWjl6ycBUym2QKE
         wWinYjQMwNkal2ztuwHRSg+JQdCd1jxG8muUNjYXRDLRj7AORomv+qyTiyJkii4zgeNO
         AFrX92HMuNqEaYbb9soOhA7jH7RYsUFtyfSqgyhvZNkAJknhwLz4JJsUtUP39KDVEfh4
         5iGtCno+ExQyd5pkDbH71jdGoMunMJb/58OKqG9CAHTWw/50NBXYyurKNciYRfhO9jHr
         2xmfHFMBSJ6s2gI2ArOh3XZ5GxndeqU78NDWYRW5Eao+K1jUE+W+h0ej2sH+Kt59fIGF
         0kRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795133779; x=1795738579;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hAC07b8lFLojHV0Uml6G9ei5fnLsVAdumfXqcmefGN4=;
        b=gvM5dGqG6eAucWqqj3UBVovOvYA+lipj226JscO0o2IHtTWI0adPDX/VQsvgR1Ya+2
         xM83jBWcvVt5ny+fuSaSI+kC1/vnSgOJOTSYgJqKMQF8pOhAnX+MOObXnQtwKqS2aShP
         hr9X4rn1tp11fD3fYbuXJP6RuClvNZ8pVGfRT3TYU7YHZqnt2iYprInbMmuK2OuBsCGT
         iO9RHD4SfRdoTglxCY+idBgspd9Zc2AnPGcvllBtuksh8SM2GQZtozrUwCnSr6SwAvu7
         YyMF+WBWqqBORFe3OxcKTgt8s90QZA4k+loKPIZ+OmDCd9D97lp8tnesWraTX8J5nn8d
         hGXg==
X-Gm-Message-State: APuU4Z9M5MpZggbsEwXEX3/4K5W9Zj47Ps2cCOZVutSbFWGDHa+uJwc/
	nHBodXw8zjU43zvFkyEQnkXj+vyvsE+BVKmOeCVy8W+1peCpqEu3as+vU8mnVBpp/w==
X-Gm-Gg: AZFdTZfarubbdpkwL8YLT5Y5ZO4L/wJogrzhRdR0jNjpN7N7BmKI4MkBnsLF/cte/tU
	G9zXMzExrP6SwA3+G43r4PDXy0ZswpZtvRDqq9IMAF526Gft0i9cP0PD/02j46SNa6i4/2lqIAi
	NGXd/bclxlPB1w7WfAYfNWSGcikMYef2C4StLxk9+umDHvjW3+QqK5FJKqCuXiVfcSxHzZWJnoo
	BQMkXvLVVU4PVZq41rewsoyy6AhUgwUvQg2nzeB0Ka/xoO7SVrjbJ6hGLlSVy8G2TWUeRcLnWVQ
	qaJpWxIa9J/bRQYLaCQNEz9qj0ZAP92QWaDT8+OMz23Kjm/NXv99oTmI6TMF+b3KPuPv70rwjKi
	bpQG0GahGKLS/VdoPUzEcfeXkIHyD3XGAnqzX+yImbFvkcmclvPQs9EaTi9oaRGmn3dT3Sw3xDz
	X+ywgiAcyGFSq1tosoByIPy3uu4e24Z/eQ+S1RykCgAZJJv5YjevYkUl7XUavClvkmmcpAaFyjN
	JIG2nEi/tPKi2a0bMQQheox0au+W5I/YipSH2Kjvwep27PFJWC9Felp6tYwRSHH7w2cYvie7SST
	kUzkIWyME3Ib5p0QV83BXKrk/PyhG4Lzmco9w6F12Sg1vrY7B9YXEjliP1dq8yB2
X-Received: by 2002:a17:903:2b0f:b0:2e2:dfb8:818a with SMTP id d9443c01a7336-2f03f20f8c5mr14954585ad.62.1795133778058;
        Thu, 19 Nov 2026 16:16:18 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c6e50sm6072095ad.13.2026.11.19.16.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 16:16:17 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 16:16:16 -0800
Message-Id: <DMZLTC9U6DBX.3FR19X5M2IT3W@google.com>
Cc: <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <kvm@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kselftest@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <ajayachandra@nvidia.com>, <alex@shazbot.org>, <amastro@fb.com>,
 <ankita@nvidia.com>, <apopple@nvidia.com>, <bhelgaas@google.com>,
 <chrisl@kernel.org>, <christian.koenig@amd.com>, <corbet@lwn.net>,
 <graf@amazon.com>, <jacob.pan@linux.microsoft.com>, <jgg@nvidia.com>,
 <jgg@ziepe.ca>, <jrhilke@google.com>, <julianr@linux.ibm.com>,
 <kees@kernel.org>, <kevin.tian@intel.com>, <leon@kernel.org>,
 <leonro@nvidia.com>, <lukas@wunner.de>, <mattev@meta.com>,
 <michal.winiarski@intel.com>, <parav@nvidia.com>,
 <pasha.tatashin@soleen.com>, <praan@google.com>, <pratyush@kernel.org>,
 <rananta@google.com>, <rdunlap@infradead.org>, <rientjes@google.com>,
 <rodrigo.vivi@intel.com>, <rppt@kernel.org>, <saeedm@nvidia.com>,
 <schnelle@linux.ibm.com>, <skhan@linuxfoundation.org>,
 <skhawaja@google.com>, <vivek.kasireddy@intel.com>, <witu@nvidia.com>,
 <yanjun.zhu@linux.dev>, <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 11/27] vfio/pci: Retrieve preserved device files
 after Live Update
From: "David Matlack" <dmatlack@google.com>
To: "Vipin Sharma" <vipinsh@google.com>, "David Matlack"
 <dmatlack@google.com>
X-Mailer: aerc 0.21.0
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-12-vipinsh@google.com>
 <DMOAT4VV939P.2DI8CEOMMSKMY@google.com>
 <20261118065653.GE2250529.vipinsh@google.com>
In-Reply-To: <20261118065653.GE2250529.vipinsh@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261119_161619_755286_A95A342D 
X-CRM114-Status: GOOD (  23.92  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Nov 17, 2026 at 11:51 PM PST, Vipin Sharma wrote:
> On Fri, Nov 06, 2026 at 05:19:28PM +0000, David Matlack wrote:
>> On Mon Nov 2, 2026 at 3:36 PM UTC, Vipin Sharma wrote:
>> >  * Open and return an anonymous VFIO cdev file via
>> >    vfio_device_liveupdate_cdev_open().
>>=20
>> Here's an idea for how the device file could be created on retrieve,
>> which I'd like to hear your thoughts on.
>>=20
>> The patches from Pasha at [1] lets userspace pass a
>> file-handler-specific argument to LIVEUPDATE_SESSION_RETRIEVE_FD. In the
>> next version of the tmpfs series, I'm planning to use that to have
>> userspace create the file and pass it in the argument, and the kernel
>> then restores the preserved file into it.
>>=20
>> I wonder if VFIO should work the same way, e.g.:
>>=20
>>   struct liveupdate_vfio_retrieve_arg {
>>           __u32 size;
>>           __s32 fd;
>>   };
>>=20
>> Userspace would open /dev/vfio/devices/noiommu-vfioX itself and pass
>> the fd. retrieve() would check that it's an unbound vfio-pci cdev file
>> for the preserved device (domain/BDF, noiommu, incoming, cfg_size),
>> attach the incoming state to that file, and LUO would track that file
>> as the retrieved file. VFIO_DEVICE_BIND_IOMMUFD would then take over the
>> device as it does now. Since VFIO preservation is new, the argument
>> could simply be required.
>>
>> What do you think?
>
> Overall, I agree with the strategy. I think VFIO cdev retrieval should
> happen as the flow you mentioned above. I want to hightlight two things:
>
> 1. This will lead to lot of code changes happening in vfio core. This
>    means VFIO PCI live update code change will spill in vfio core.
>    Should I create a config VFIO_LIVEUPDATE for VFIO core code. It will
>    not be visible menuconfig option but selected when
>    VFIO_PCI_LIVEUPDATE is enabled.
> 2. List of other inflight series that this series will depend on is
>    increasing. It will be 3 (reset function, pci saved state, and
>    restore into fd).
>
> For '2', should I send v7 without changes you are recommending in this
> patch and future version of this series can transition to the approach
> you are suggesting after LUO changes are landed. VFIO liveupdate series
> will go through more iterations, so we will have opportunity to make the
> change. WDYT?

Sounds good. I am not 100% convinced yet we should switch to a
retrieve-into approach. But let's keep discussing it VFIO and IOMMUFD.

