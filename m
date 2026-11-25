Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFA6606A323
	for <kexec@archiver.kernel.org>; Wed, 25 Nov 2026 00:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=kNCBAoPg;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=a/ZG+g1A
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=TYzGQKZhwagkTAG/Juiri3uWHZu9q9sF8vYxgRrqGqI=; b=kNCBAoPg3rg7VIoAGh32AfWFz1
	SSB0e9d+hPDjVJhNjiipoeJ4iVv/BZaxUcv0gYEjstLqZ0TK8FFv8x6ZXrtRv/bjT6DGaoxpslX91
	G4Rt2+VZwuxN0RRSCwLmjL7uuCWaWHpdto+TkoHDD7lCRQtYKKNJ2Pn4/wYvigjO/1I+1uXT+SqsV
	34i9SE0OiRrZjECQqIKR04NOZS4jqA8HosJ7jfQnPEiQKV0IL9SSCyL3CactJC7RcHQxl1vkPO1Wv
	DTHp3VMTkz9FMYd9iJfAkUWMg3BQF4VUbciJpDUb2bfcar1uxLFUUJY2pdL7iCkn3y71OrqLdDQ8z
	QUiohxLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW0mD-000000088ms-0Iah;
	Wed, 25 Nov 2026 00:22:21 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW0mA-000000088mL-0833
	for kexec@lists.infradead.org;
	Wed, 25 Nov 2026 00:22:19 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2ee254f6eefso244065ad.0
        for <kexec@lists.infradead.org>; Tue, 24 Nov 2026 16:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795566136; x=1796170936; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TYzGQKZhwagkTAG/Juiri3uWHZu9q9sF8vYxgRrqGqI=;
        b=a/ZG+g1ACG1itetkzZ8P7fue5T8CM3eCF3Mxw7rxLzLYmt8ALzO825aphd18ONdmyh
         Aa8xK49FwXNguqgm8U1nMIfuXYysyCvebr26O1UAKgJnTTmGIMfVlOfn9zIXbTYOkqsQ
         SSElMnJ4tuJWLtIhkPR+paookwqdXS7wxY2z99Lb9UJM8/3efMYQaPm639IOVpVNGayF
         f8QPs5waNFFW9Ds42nZQhe5cN3D+Lz7Ho3M5w1jITQjT4RlounhwTnORUoNqMn++2xlT
         9kxRsnayC8SiRVvtYv0CBRe6Pvb+rC7jqBMETZX4+igh+QHx9IyGJZcR69MMLZWcyTXB
         BmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795566136; x=1796170936;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TYzGQKZhwagkTAG/Juiri3uWHZu9q9sF8vYxgRrqGqI=;
        b=1WpdTqu3yJXev6TxJ3leLT4WhhwPoWAIckaeYXc9BIlULj1wZ7VnLPQulQogSCrIWd
         uaDkNGD3oEXIJjJ+S64yIWD3sojy+5uHq479GBMaenN9v8scBrTeGYbZDOXUtm30C8xM
         WLX1yYiH+T5dVTdvCf+mQdm1DAr/j4dxfjLl8hVtm5HHK95c7FAYNZYznLReNIrEQcyj
         P3TSTkdJsQeueoeh4d4veRkA7A1Pz6EflmfDpXBuGH3h3SIqM9WsW5+5Uva+j30q7Mc5
         9PhHBfMnWRYyT4pf5c43SBfo5sV1EbCmEkDbv6bgK7/iYbgzTlYrYSUicUMii30C9OIh
         7ZPw==
X-Gm-Message-State: APuU4Z8+PY1Ll1kgPqQrNd3XG/qVHtelNZTCFITIrBpjEycp/DrSKTPu
	ps0qJxu1DlzmaFbr2GPEM9yEdAoYymXAMRAXYacBvh9uCkBGEyoeD3rLvc6bpDy22A==
X-Gm-Gg: AZFdTZdyO4Z0CBdK2CApbcoVLex9lPJgdwZYZRdry84AZw8+VViMXmE2cBDe9xVTh0p
	g386xtJJX/zI2CT7kF2rFiy9SJgC6rVSi37NqgIie9aOGomCdjYlW1ADu1waspuqUDGuuAqNom/
	LzZTI80Z+DTay608pvYIf+GtS0/n9m22tux4FXVTqpslFf93rwyGLXg3GUT8ZAygPiSue6ly7Fs
	bzdNsPnJkUS1Kyh/UP8D22PNPnG+lCbSnc9XlE9tEDdfwulxFm1LJboAGXaouGPfRw36BUO8Iqz
	xLkBSmTDPw/BTFETquo5ZUCvvgvLf+xh4/WucVoZbSO5mFVm+weWiisK5IeuX+0SxDYqLyW5G7y
	x/SkJ2hTDGahla+X0bk4F9XvSS9/z2nQDI3SUrYFtkD0ow13+GTzDwYAF40d5LA9KFHWVEHkfgD
	LZKnSlxhU6XrtjzXhI4l91XIyXUwJPUVF8/lfTBuyhXnPWdKT7YWH4TOfSRqVRkzvO2cOwmG9Bq
	VzYU7W8eiq5GbMHC687Dan2m/PJt+z/onNqHoRx9MhqXHGPBwnxVvmdDMSTAN2UA2O/Gd/DAGSl
	4eqOcidmyKrJJv9IyNT+TSBnSmt/bDlzrTe0V6mKCixO0/XmO2Cmf13vUeCsQQiVDAg=
X-Received: by 2002:a17:902:ce0b:b0:2e9:73e0:2a6e with SMTP id d9443c01a7336-2f0666fb91bmr16319865ad.17.1795566135674;
        Tue, 24 Nov 2026 16:22:15 -0800 (PST)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f105b76sm76508585ad.50.2026.11.24.16.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 16:22:14 -0800 (PST)
Date: Tue, 24 Nov 2026 16:22:10 -0800
From: Vipin Sharma <vipinsh@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, ajayachandra@nvidia.com, 
	alex@shazbot.org, amastro@fb.com, ankita@nvidia.com, apopple@nvidia.com, 
	bhelgaas@google.com, chrisl@kernel.org, christian.koenig@amd.com, corbet@lwn.net, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, kevin.tian@intel.com, 
	leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, mattev@meta.com, 
	michal.winiarski@intel.com, parav@nvidia.com, pasha.tatashin@soleen.com, praan@google.com, 
	pratyush@kernel.org, rananta@google.com, rdunlap@infradead.org, rientjes@google.com, 
	rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com, schnelle@linux.ibm.com, 
	skhan@linuxfoundation.org, skhawaja@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Subject: Re: [PATCH v6 07/27] vfio/pci: Preserve vfio-pci device files across
 Live Update
Message-ID: <20261124234830.GB3545683.vipinsh@google.com>
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-8-vipinsh@google.com>
 <auzftbPFO_6XBYVw@google.com>
 <20261117220059.GA2250529.vipinsh@google.com>
 <DMZLLYOVIGOU.1RXWYJN6UQTM@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DMZLLYOVIGOU.1RXWYJN6UQTM@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_162218_109256_A28E2364 
X-CRM114-Status: GOOD (  41.13  )
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

On Thu, Nov 19, 2026 at 04:06:38PM -0800, David Matlack wrote:
> On Tue Nov 17, 2026 at 10:44 PM PST, Vipin Sharma wrote:
> > How would a userspace opt-in? New kernel can change a capability visiblity
> > or virt and write permission of the bits inside a capability. Kernel
> > cannot know if userspace used the capability or not. Creating a VFIO
> > device in the new kernel by default results in a opt-in and currently
> > there is no way for userspace to opt-out unless we add a new
> > functionality where userspace can disable/enable features something
> > similar to KVM capabilities.
> >
> > For now, I think we don't need to worry about it. As this version will
> > be a base and if any serialized data with flags set received in this
> > kernel will lead to erroring out restore.
> 
> We don't need an opt-in mechanism in this series. Detecting mismatches
> is enough to make Live Update safe in both directions: if the next
> kernel would emulate the device in an incompatible way, retrieve should
> fail.
> 
> But an opt-in is needed to make rollback possible once vfio-pci starts
> changing its emulation. I imagine something like a VFIO_DEVICE_FEATURE
> that userspace can use to enable new emulation behavior right after
> opening the device, with the enabled bits recorded in a field appended
> to struct vfio_pci_core_device_ser behind a required flag. Devices that
> don't opt in keep the baseline emulation and stay compatible with older
> kernels. But that can come in a follow-on series.
> 
> > In the next version, I will not preserve pci_config_map. Hopefully,
> > anyone changing VFIO code doesn't forget to update flags if they change
> > capability or permission bits (I will write comments at appropriate
> > places.)
> >
> > If we want to be very careful, we can do two things in this series:
> >
> > 1. Create a per bit valid mask for the vconfig and compare this between
> >    new and old kernel during restore. In the new kernel, VFIO then takes
> >    each bit from the preserved copy only where the mask says it was
> >    valid, and keeps its own freshly initialized value elsewhere.
> > 2. Create a hash or store virt and writable bits in config space.
> >    Compare it with the new kernel.
> >
> > Both of the above combined will safeguard against forgotten flag update
> > in the code.
> >
> > We don't have to do it but it safeguards against mistakes. Let me know
> > what you prefer.
> 
> I think we should do both in this series, as two per-bit masks over
> config space, preserved in place of pci_config_map:
> 
>  - virt[]: the bits whose value vfio-pci keeps in vconfig and returns
>    instead of the device's value. This says which bits of the preserved
>    vconfig are valid.
> 
>  - write[]: the bits whose writes take effect. For bits in virt they
>    update vconfig, and for other bits they are forwarded to the device
>    (possibly after validation). Writes to other bits are ignored.
> 
> The masks should describe what vfio-pci actually does rather than copy
> perm->virt and perm->write.
> 
> vfio-pci can keep changing its implementation in ways that don't break
> Live Update, e.g. start intercepting writes to a register to sanity
> check them before forwarding them to the device.
> 
> Something like:
> 
>   struct vfio_pci_core_device_ser {
>           ...
>           u8 virt[PCI_CFG_SPACE_EXP_SIZE];
>           u8 write[PCI_CFG_SPACE_EXP_SIZE];
>           u8 vconfig[PCI_CFG_SPACE_EXP_SIZE];
>   } __packed;
> 
> 
> [ Note: I'd probably store virt[], write[], and vconfig[] on their
>   own folios to avoid multi-order folio allocations, but I am embedding
>   them here for simplicity. ]
> 
> The outgoing kernel computes virt[] and write[] through a helper in
> vfio_pci_config.c and saves vconfig[] during freeze().
> 
> The incoming kernel computes its own virt[] and write[] masks and
> requires both to match exactly with what's in vfio_pci_core_device_ser,
> otherwise it fails the retrieve. On take-over it uses the preserved
> value for bits in virt and its own freshly initialized value for the
> rest, like your option 1.

For now, we will be rejecting any changes and in future when we add
userspace opt-in mechanism then we can loosen this check, am I right?

> 
> I'd store the full masks rather than a hash, so that a mismatch can be
> pinpointed.

Yes.

