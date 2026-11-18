Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE720606A31C
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 06:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=blqeGY43;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=U1vgkwY8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=D3IFWTA7ou2igClaDYSbsGTVSgzRWm+OXVAzSzama/M=; b=blqeGY43992lpKQWzZgYfE/SVu
	t9q0CVw4ytgj/vyHKDJy7iBckN+BUTEHUaYMWCDQBMZ4euHQWBQX7RZzY3m8xJv8shc9GHH8YxRmI
	zTdnVJ29gZoDU82Sglivkq89M5qgjKAIOlW8W+lJp3331B/FZHfC/DaGuZzr7NF5ThlYTgaxAHAdF
	+US41pDwqYQpOBuqBz73GPaJV4j0ESivOu4B5ZzgP8kjmvnBfJA9UjDgHIAN8Jx6jwy+XHmTka382
	HFXpYewFfACSISWNWtDVHtk/kR+mU364GPH57lADwtb/gjLX3MTTS3pt7eGGpynmoY7t83ULSX0h/
	ioq0GIRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTZaD-00000007wq2-0WcJ;
	Wed, 18 Nov 2026 06:55:53 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTZa9-00000007wpS-3oFN
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 06:55:51 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2efc4a84e75so28985ad.1
        for <kexec@lists.infradead.org>; Tue, 17 Nov 2026 22:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794984949; x=1795589749; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D3IFWTA7ou2igClaDYSbsGTVSgzRWm+OXVAzSzama/M=;
        b=U1vgkwY87BlmGAwviRCTV9ZFG/IdwOFuACElbBTdpayUq7HQVcFfJrzL26anjU1JFn
         T1KS7A944/WmAvnXImAHyvV4pn8WO3CXPTBH8tYJNQptjVeXWpP0mNr1O3QiCndYyJCM
         guaw0EU0XC9xCciKJWjyiXv9DQ/puv6UfG3d9OoeVY8ZuhDTMY46rxwDqMcCv6Y1SaU3
         BP75JcUcjAcT/WmFpzbiMgUHCWs6efKT45maCs569/VbDRFdC2ON5wqSQbJrH3jPZrh2
         0MSBKWEghY+qoiFlbunn+pg5r2siAvaWNVaJG772VxO3mFUyH5qaTG+R18xOUHGkukhP
         eCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794984949; x=1795589749;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D3IFWTA7ou2igClaDYSbsGTVSgzRWm+OXVAzSzama/M=;
        b=hawGssOf6wA25IxZzS/5pqEHWINaE2tfBaqnGKoHg/mTmPg9WDf4vUS5vkA5b+DI0w
         1bVybRwfsWusQ1eMXB5aTPgO3sC0KbzmkJGwuKD+RnLa39I4caHifjpWCVaybv/UpOc8
         9WArVEMBqNPYEuPppx3B5jp0TXuekyeqPRSOkoq0PYP5fxIeS+PPEG5xZa4rFNFtMdu3
         iZzjjtWxWOAo89rAIVYJTwN0G00ncI9Rli0WV1edO/C1kxPvNaEMvDvk1YF4IKrnns1j
         7AL4Z/81hbjvbthQXjvIzbBMSSXNtQGnVhNszHPxsztH+NsgxYGfQCKo67QS636nK2em
         EiwA==
X-Gm-Message-State: APuU4Z9O9fuDMp1Bj+CcguNHM3KyOOqpM7dtZfSCbGoPIRSQq+KpHlWR
	cBE7dPVyTlU22S0MEC2xq+aXVlwCQM7l43by+CnTj/16/sOwlJa3J5PaFmc85zpPEA==
X-Gm-Gg: AZFdTZdfPJ7mSrG857D36VqddHaN0BOBcE7depUFCKXQzTIvlHn80gC9VGBaR22m7lj
	WUf8t5cx+OwSnQQjlsFbzjJzuI+90p8elfeoqanGVP+xohcCmrVV7seFdMOOzJiXBisFwDwv7oE
	ZPm40ecHoSvB6kxq3mxFfw/v2qhj1KMXyum8bIuQ8bWe7e4aTJWBFRbx3GSuTGCZ1vPfr6k/3d7
	DmwRAKkhi6E4rHQibms2ZcKeaWSS9lU2E+a19MlXkgM5N9nSUh1hwV6kdQD3tXCa3egQo9B35AH
	2T87au8lQs5HWjkiWmhxB6oc0tV/fYUROmzt9OAVH2v6WXqLX1HhgJ2S3BGsIdlX98Dfwpy5S/Y
	vnI1zFm57kPZdBziZooeK4QKPOilyJbYWqH38PQSjMHWGzpL+Bod1Sj074P/VC+egE8ZWg0wBco
	/X4zvmhN1UB47Qq0FfcxRA2yhJ1CE5wTKjrF72Qw0kkuZDlmApA5bK6++SFjPnZAVCwkOk4z8wt
	gJnpkzOUNQqYFqgzKgf4E16sNxsdLqkPEYqTxcYfDTLLavgIHmw1WnCeCJAo7V+302K6fs0SGIA
	tafqgHhdiiETpSlbGVw7+kOaFxN8ZzRxrj/sNxhA4s524AWzR94Foy0R8tMuKYbT
X-Received: by 2002:a17:902:ce10:b0:2e9:73e0:2a6e with SMTP id d9443c01a7336-2eff9952062mr2886095ad.17.1794984948419;
        Tue, 17 Nov 2026 22:55:48 -0800 (PST)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c5ca5bf959sm657169b3a.20.2026.11.17.22.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 22:55:47 -0800 (PST)
Date: Tue, 17 Nov 2026 22:55:44 -0800
From: Vipin Sharma <vipinsh@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, ajayachandra@nvidia.com, 
	alex@shazbot.org, amastro@fb.com, ankita@nvidia.com, apopple@nvidia.com, 
	bhelgaas@google.com, chrisl@kernel.org, christian.koenig@amd.com, corbet@lwn.net, 
	dmatlack@google.com, graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, 
	jgg@ziepe.ca, jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, rananta@google.com, 
	rdunlap@infradead.org, rientjes@google.com, rodrigo.vivi@intel.com, rppt@kernel.org, 
	saeedm@nvidia.com, schnelle@linux.ibm.com, skhan@linuxfoundation.org, 
	vivek.kasireddy@intel.com, witu@nvidia.com, yanjun.zhu@linux.dev, yi.l.liu@intel.com
Subject: Re: [PATCH v6 07/27] vfio/pci: Preserve vfio-pci device files across
 Live Update
Message-ID: <20261118064707.GD2250529.vipinsh@google.com>
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-8-vipinsh@google.com>
 <au5VMy7zhOb65xIE@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <au5VMy7zhOb65xIE@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_225550_057161_10BAA4FF 
X-CRM114-Status: GOOD (  18.20  )
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

On Fri, Nov 06, 2026 at 10:35:27PM +0000, Samiullah Khawaja wrote:
> On Mon, Nov 02, 2026 at 07:36:36AM -0800, Vipin Sharma wrote:
> > +/**
> > + * struct vfio_pci_core_device_ser - Serialized state of a single VFIO PCI
> > + * device.
> > + *
> > + * @domain: The device's PCI domain number (segment).
> > + * @bdf: The device's PCI bus, device, and function number.
> > + * @cfg_size: Size in bytes of the device's PCI configuration space
> > + *            (``PCI_CFG_SPACE_SIZE`` or ``PCI_CFG_SPACE_EXP_SIZE``).
> > + * @size: Total size in bytes of this serialized buffer, equal to
> > + *        ``sizeof(struct vfio_pci_core_device_ser) + 2 * @cfg_size + @saved_state_size``.
> > + * @flags: Bitmask of ``VFIO_PCI_SER_*`` flags; unknown bits are rejected.
> > + * @saved_state_size: Size in bytes of the serialized &struct pci_saved_state_ser
> > + *                    blob stored in @data after ``config_map``, or 0 if none.
> > + * @reserved: Reserved for future use; must be 0.
> > + * @data: Variable-length payload containing, in order:
> > + *        1. ``u8 vconfig[@cfg_size]`` - VFIO virtualized config space snapshot
> > + *           captured during ``freeze()``.
> > + *        2. ``u8 config_map[@cfg_size]`` - VFIO capability map snapshot
> > + *           captured during ``freeze()``.
> > + *        3. ``u8 saved_state[@saved_state_size]`` - serialized
> > + *           &struct pci_saved_state_ser captured during ``preserve()``.
> > + */
> > +struct vfio_pci_core_device_ser {
> > +	u32 domain;
> > +	u16 bdf;
> > +	u16 cfg_size;
> > +	u32 size;
> > +	u32 flags;
> > +	u32 saved_state_size;
> 
> We will need space for iommufd_token when we preserve that, we should
> probably add it now as otherwise the compatibility would be broken when
> we add it? Is the reserved here for that?

No, reserved was just to align data[] to 4 bytes boundary.

Based on David's suggestion, I am gonna get rid of variable length
data[]. This whole serialization struct will be fixed length.

I think it will be fine to extend this struct by adding a new field at
the end of struct in your series along with updated flag when you add
iommufd support. 

iommufd preserved vfio device cannot be rollbacked to this kernel where
there is no support for iommufd preservation, so, flags will be correct
to reject the change.

Do you have some other concerns when yiou compatibility would be broken?

> > +	u32 reserved;
> > +	u8 data[];
> > +} __packed;
> > +

