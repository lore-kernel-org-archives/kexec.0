Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF5560A2612
	for <kexec@archiver.kernel.org>; Fri, 20 Nov 2026 00:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CZRwFfR3;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hd5ZeImn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:
	Subject:Cc:To:From:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=8PsDwtqZ7ZOXHEr9V4C4myUyqMWkC/3w4Fd9za5pDc8=; b=CZRwFfR3ZuQaWM
	0nSuYNCUMDyb/pzkCJX09qNTuAvLc+1VPXeyIIkP6pFxXo+qSbfwnYNAmVkQCWVnIbCzKpCS2iUE5
	ILM5lU8uaIkd1EwS6qrzMikP6FVOld0oLSymgjzAKCCoS/2btUcaf1f9aXcvx6EQjhJnLcxdt3MSx
	rO3fao9SVwh4Y4MrEuKhDgcpFTs8kYTHQ3mhvatENsIdgdnVdvnhUj5PzONIpK/4Hz8SmOpsXfvgn
	7Z7WIUMa7KiV40YUXq3ft4LipxRjttrg7P59eBW7y42IBkgdbXoD4SoPQ1AvF4a3bkZsWqbtXxlf+
	y3VogsCmLuR/k/L+GEsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUC9P-0000000DirO-1P33;
	Fri, 20 Nov 2026 00:06:47 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUC9M-0000000Dipq-1aiS
	for kexec@lists.infradead.org;
	Fri, 20 Nov 2026 00:06:45 +0000
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-3b179528d56so186466a91.3
        for <kexec@lists.infradead.org>; Thu, 19 Nov 2026 16:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795133202; x=1795738002; darn=lists.infradead.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8PsDwtqZ7ZOXHEr9V4C4myUyqMWkC/3w4Fd9za5pDc8=;
        b=hd5ZeImnGKZzsDRFsXb9n5am627itcGNTaaj0NtzYi7zVNvKoQQceM7K/KtWWpi0fS
         CDoCFRiAJXkG7kFXFSIw9zLvvYwprezPbGbev7MMBBpeEuJGl6Ife+p/eikf2EAx682v
         g25WktectE75ucvkEpLcHr+7hSfvPzGNYfa1COgU3kzSDihabpQYEbLsA0+9GJR9M2Dt
         jyoJhAQCCodrn5r4tA+YbuuUtIlBUiysP9IVI9TPTQVPeHK2mpKRUnEcJUy9T01IvqUU
         XrsupDIuHqdl6fMxPUxOBifTp0NGAgwBBVKmjygByHBPP8O6G6dF+hwB27OM7CRLHa88
         CjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795133202; x=1795738002;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8PsDwtqZ7ZOXHEr9V4C4myUyqMWkC/3w4Fd9za5pDc8=;
        b=kwsXa1NmXAp1oe0H6CkPNLg65Z66FxDaJ/dbTV8GOcpAyLRnqRAL2nFfyNkGO85sEW
         VIEOjUlWVBfxkQd+jgYHsrT+QbNvFVyCCQ5jAvgYxE+vxk0X2Qf/AmRAesOf1FHFDGau
         jQrFxv2p4rkVQfOhPL5UhwchHXwaanutO2ZnuXUU1qYafQ/ScB2Ynba75162Ta7913IZ
         TVjxzpj094KJp02VuD3suTjln9pNkbLvGXQaKKXsgck3ogo2Pr+hBmnFfs60g7EtyAcX
         Y4yw9kSPNcHo0FEsl06YVc4thjF51ycHIQP7SOTpvm0phRqcc8FGH39MRldM/ogCnOnT
         Ap7g==
X-Gm-Message-State: APuU4Z9zUVzlDFCsVSpBCnKalGrlo9HjeBTAusWywqx94SHJ+Dwg74JO
	AHvC2mi85no49K0p+bhxeARlT3vp+K5S1EYpfFy+N2MDiLKjddMD5gxlnSFmTJ6x1Q==
X-Gm-Gg: AZFdTZd0FZDWR35IlCBWGUbIoPuzu2TET0zCAXSgj2nRdEfj/YV7tA3Eb3yNYuE068r
	/yx9ivDNPr8sxSUvP8VRUd5EL95rRiMD3cily0cQ3nhNpEmMDMIQCpK1QlXLiU2pFq++RGE7mB3
	eyFDSYE452EBNYy0q3xofD4GeySGrDApgUtmcNmcx0T124AIy3K1wBsqgYT0kmyYQsCjegSSeqF
	pyoCg1TVNFoU5cUCniKVMx4J9A2EWMU2dU57YN7EQx/Y55lnaLDBVpl6wEKTLTBAQidjKgu3iYC
	2ki1PAkE2IevOYpwLh+N1IYqy2fiWt/vP+mlCS7XVeRZo9RONUW8Qi7xWrpbjlLyaMl4RaEJIqq
	s091x6iDL/G7rqWJA+b9pyXSmF24aoP6WpkrydE1MeWq2AigeVcWF37HVHbw//nwcrIKqIwSYZv
	BqMhYTsNzDtVbQwyT7LFCXgU80JBqxddDHdro4nNycdZ55SnmlBA/5QxoOvGTZqOD+Z6eDgQQnC
	IarSl+cfzJ7ce+7GBCLa4LYIKgg+yBHgsiDoBieEhoU9bEfZiPVtS1EwzQ8pRXV6xv6XRx/Ovaw
	5q0+qqxOlOD7Jf1Ou11QVBUheonx0Tx9fxWZDqwR15KAVxsXqW/5BKOYh2hd2d77
X-Received: by 2002:a17:90b:442c:b0:3b3:ab74:cc9b with SMTP id 98e67ed59e1d1-3b41c554624mr967136a91.0.1795133201767;
        Thu, 19 Nov 2026 16:06:41 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ff5d3easm328044a91.1.2026.11.19.16.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 16:06:40 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 16:06:38 -0800
Message-Id: <DMZLLYOVIGOU.1RXWYJN6UQTM@google.com>
From: "David Matlack" <dmatlack@google.com>
To: "Vipin Sharma" <vipinsh@google.com>, "David Matlack"
 <dmatlack@google.com>
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
Subject: Re: [PATCH v6 07/27] vfio/pci: Preserve vfio-pci device files
 across Live Update
X-Mailer: aerc 0.21.0
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-8-vipinsh@google.com> <auzftbPFO_6XBYVw@google.com>
 <20261117220059.GA2250529.vipinsh@google.com>
In-Reply-To: <20261117220059.GA2250529.vipinsh@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261119_160644_424250_8EC6BA1E 
X-CRM114-Status: GOOD (  37.64  )
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

On Tue Nov 17, 2026 at 10:44 PM PST, Vipin Sharma wrote:
>> pci_config_map doesn't need to be preserved. PATCH 14 already rebuilds
>> it with vfio_config_init() in the next kernel and only uses the
>> preserved copy to check that the two are identical.
>>=20
>> I assume the intent is to detect changes to vfio-pci's config emulation
>> between the two kernels, but the map isn't a good proxy for that. It
>> changes for differences that don't matter (e.g. hiding a capability or
>> learning the length of a new extended capability), which would fail
>> take-over and lose the Live Update on exactly the kernel upgrades Live
>> Update is meant for. And it doesn't change for differences that do
>> matter, like which bits are virtualized or writable within a capability.
>
> I think it does matter because reads and writes of unitialized
> capabilities in VFIO PCI config space goes to hardware directly. So, in
> the new kernel if pci_config_map changes it from PCI_CAP_ID_INVALID to
> others then those reads/writes can go to vconfig which will contain
> stale unitialized data from the old kernel's heap.
>
> This also changes behavior under a running user. Writes that reached
> hardware before Live Update can be silently dropped or redirected to
> vconfig. See the comment above struct perm_bits unassigned_perms{}
> in vfio_pci_config.c

That's true. Unassigned bytes passed through and vconfig is never
initialized for them, so hiding or exposing a capability does matter.
For example, 6467d0740a2b ("vfio/pci: Add DVSEC PCI Extended Config
Capability to user visible list") changed DVSEC from hidden (all bytes
raw) to exposed with a virtualized header. Across that boundary, v6
would have served DVSEC from uninitialized bytes in vconfig.

> How would a userspace opt-in? New kernel can change a capability visiblit=
y
> or virt and write permission of the bits inside a capability. Kernel
> cannot know if userspace used the capability or not. Creating a VFIO
> device in the new kernel by default results in a opt-in and currently
> there is no way for userspace to opt-out unless we add a new
> functionality where userspace can disable/enable features something
> similar to KVM capabilities.
>
> For now, I think we don't need to worry about it. As this version will
> be a base and if any serialized data with flags set received in this
> kernel will lead to erroring out restore.

We don't need an opt-in mechanism in this series. Detecting mismatches
is enough to make Live Update safe in both directions: if the next
kernel would emulate the device in an incompatible way, retrieve should
fail.

But an opt-in is needed to make rollback possible once vfio-pci starts
changing its emulation. I imagine something like a VFIO_DEVICE_FEATURE
that userspace can use to enable new emulation behavior right after
opening the device, with the enabled bits recorded in a field appended
to struct vfio_pci_core_device_ser behind a required flag. Devices that
don't opt in keep the baseline emulation and stay compatible with older
kernels. But that can come in a follow-on series.

> In the next version, I will not preserve pci_config_map. Hopefully,
> anyone changing VFIO code doesn't forget to update flags if they change
> capability or permission bits (I will write comments at appropriate
> places.)
>
> If we want to be very careful, we can do two things in this series:
>
> 1. Create a per bit valid mask for the vconfig and compare this between
>    new and old kernel during restore. In the new kernel, VFIO then takes
>    each bit from the preserved copy only where the mask says it was
>    valid, and keeps its own freshly initialized value elsewhere.
> 2. Create a hash or store virt and writable bits in config space.
>    Compare it with the new kernel.
>
> Both of the above combined will safeguard against forgotten flag update
> in the code.
>
> We don't have to do it but it safeguards against mistakes. Let me know
> what you prefer.

I think we should do both in this series, as two per-bit masks over
config space, preserved in place of pci_config_map:

 - virt[]: the bits whose value vfio-pci keeps in vconfig and returns
   instead of the device's value. This says which bits of the preserved
   vconfig are valid.

 - write[]: the bits whose writes take effect. For bits in virt they
   update vconfig, and for other bits they are forwarded to the device
   (possibly after validation). Writes to other bits are ignored.

The masks should describe what vfio-pci actually does rather than copy
perm->virt and perm->write.

vfio-pci can keep changing its implementation in ways that don't break
Live Update, e.g. start intercepting writes to a register to sanity
check them before forwarding them to the device.

Something like:

  struct vfio_pci_core_device_ser {
          ...
          u8 virt[PCI_CFG_SPACE_EXP_SIZE];
          u8 write[PCI_CFG_SPACE_EXP_SIZE];
          u8 vconfig[PCI_CFG_SPACE_EXP_SIZE];
  } __packed;


[ Note: I'd probably store virt[], write[], and vconfig[] on their
  own folios to avoid multi-order folio allocations, but I am embedding
  them here for simplicity. ]

The outgoing kernel computes virt[] and write[] through a helper in
vfio_pci_config.c and saves vconfig[] during freeze().

The incoming kernel computes its own virt[] and write[] masks and
requires both to match exactly with what's in vfio_pci_core_device_ser,
otherwise it fails the retrieve. On take-over it uses the preserved
value for bits in virt and its own freshly initialized value for the
rest, like your option 1.

I'd store the full masks rather than a hash, so that a mismatch can be
pinpointed.

