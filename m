Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D85CD342C
	for <kexec@archiver.kernel.org>; Wed,  6 May 2026 16:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ip9FOPUnGn8oIskEdOYGUFzCLkqL2KBoKQm63orD1Do=; b=TNxClvP2RmefoSfpARFf+QxjNV
	UiKeglM/hAqtHSbf2x8vqTshSw6NnBodmN0bM0A5+zmHRRKmDwRi+6JlGmxeRJLzI2Y0+m4no8G2U
	8WnIC70t8G/y2vnHDmPcI6ddSmB/39SeWYfJUbEf5XvTlUNMZHSxFUhyjF1+by+asnJVNYwt2Qcwd
	4kcS4sui/ddfv7BkxNVp4+XJSbNUXsff3IvjEVS4sFfgbaXmmzERyggFTWLeJoduTV7uqDxvSXY9f
	ETD+zUnlQTHOGF4/eqp+3xEpuYBsP9ZVrNbft6hW+KDW8tUPXEPSLMdnf+gzyWGBAW6xsqiHcHAu2
	ZxE2otPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKelh-00000001Rmy-1sNy;
	Wed, 06 May 2026 16:06:37 +0000
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKelg-00000001RmU-1AAE
	for kexec@lists.infradead.org;
	Wed, 06 May 2026 16:06:36 +0000
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-7b37d84a6b3so69537627b3.2
        for <kexec@lists.infradead.org>; Wed, 06 May 2026 09:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1778083595; x=1778688395; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ip9FOPUnGn8oIskEdOYGUFzCLkqL2KBoKQm63orD1Do=;
        b=JVTvMtQ+NwUEcLCH0WWUPvBOQDG2qGpuoOQ+ArAHK8YtjtL6Vk5ckAC3bnkEH4YgL0
         A5rrAq531pVkuoWbfxSLYkoCMBqv5cK9ansJDC4/P70A3aV8hN4i0evyqROx1wlKh9ob
         ZK1ZSZPrX4d9tgrNBzkVDYmXByp/C+CLgfGgtQkz7o6H1zxOBPbZljY/4jqa7ATbGS4j
         cwBUrGPVEQ+KVbOLXUJiSu1eBjbgJN0Z/n0y3csxboLV9lUQhSIWsvaZ35MasgBTcw3V
         JfjcvyaquPK3I8XRCX+PwQGHLx7tSEP3d8ngsJp2gsnwIY4vTlWEIBiIqqrv6gQ9LfGH
         ZVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778083595; x=1778688395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ip9FOPUnGn8oIskEdOYGUFzCLkqL2KBoKQm63orD1Do=;
        b=o0zFQXxahkwojaMb/7yTlcO2Q5TzDJJDc4rDI/96cHIKucj4u0ruccpp0YBjyF9b9p
         yjo9/2vyzbyBVSJR9Zry2qCMi9f/9gH/uazghE5mx1KewJTnE2XELqjpU/KDD9ZQrtof
         36S/WcR9i7PSEohQ60XqHPu7r+PkDa5uSPByy0Ex/EpFf2kYt+3UrxnqYUQGkvMVi3QN
         iqYRFPKFW8+aFc4tegxegQ2/ZSr/diW/9H2sbUHT0QliYG7lSyZHVvRedGnMf0Rig1iz
         um9JCNxtvHMgsesMFWZLyjuWwfLIU+SjdjgkoHE9TQ/L+/D3jon8Xv4lnsZCQdvjuDS9
         wQ0g==
X-Forwarded-Encrypted: i=1; AFNElJ8KPWrLsEBcHLgMFfi0j9GMj558kUEd96bw+bpNxkrCrwfcBWsHKZ4Vh45omrM5vpbV94IC3Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YwfYkCCpBkeRKoFoPjxwUxOqtOjK9YTt8UYgZr0CdAxpJb1yK4L
	XeTuoK9T36BZXHSgCSiwGRMaXkwNMTPJe6gYFNh3Kdevb9++oZUZ1WmEnZyazUj4heA=
X-Gm-Gg: AeBDiesm4AKGiXw8PiPm4B6YC0fh0HkdoGsVlD1N7vmgLcqQbXFjKB9rcswCSYJpZ59
	R2NyN/eookTWSjdPd90mLKtHeuiaQMmDRhmurr/P2kGsO54pSOR7ceSix0aCu6Yk0EpvGoYB5RJ
	sVSeqUPHoBiqo49XkMDrGxzAwgbsEltTaQzPUJrw0dXJKiyhCTHIAYezlvQWS3bfG72sO6bqtWS
	nrlR5gryOMlIaWSESSaLxlS31XMorpyKVI5YkFVxKuHZY6lxvHhJI/yjGkQ4gf6Wjx0lg6M825H
	AdNML1Y+P97teTpQHQ32VQ7qyGNfnk1w+cnIFgPEyHy8vrEi7K2AqwzkRjyInb92yJq2QdlBNK3
	a4pHBY7t4hLWKYRZPdnuHko/IWLWi1N3vbWEeZ6HVVAPUC26Q52lKnNj4IrmiNMYpEPR5G3cOaT
	Gp0FCi6aBg7A28WkQ/yFpIxSWOVRtMOKD7Vj04I1oNegtC20xHVK+APgzT27y76NAeIkP3MTHdC
	d7kd/qYMedVGIS0bhBc1c+o96Vl7OOBhMEHnG0B
X-Received: by 2002:a05:690c:102:b0:7bd:d303:fa19 with SMTP id 00721157ae682-7bdf5eef638mr42974727b3.46.1778083595206;
        Wed, 06 May 2026 09:06:35 -0700 (PDT)
Received: from google.com (57.233.150.34.bc.googleusercontent.com. [34.150.233.57])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6655f443sm82518017b3.19.2026.05.06.09.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 09:06:34 -0700 (PDT)
Date: Wed, 6 May 2026 12:06:33 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, rppt@kernel.org, 
	sourabhjain@linux.ibm.com, jbouron@amazon.com, akpm@linux-foundation.org, bhe@redhat.com, 
	linux-kernel@vger.kernel.org, dan.carpenter@linaro.org, liaoyuanhong@vivo.com, 
	rafael.j.wysocki@intel.com, piliu@redhat.com, kexec@lists.infradead.org, graf@amazon.com, 
	mario.limonciello@amd.com
Subject: Re: [PATCH v1 1/3] liveupdate: skip serialization for
 context-preserving kexec
Message-ID: <aftm3HQ-XrraUBJU@google.com>
References: <20260506043200.2025677-5-pasha.tatashin@soleen.com>
 <20260506043200.2025677-6-pasha.tatashin@soleen.com>
 <2vxz34050wi7.fsf@kernel.org>
 <aftZZ5AuQcNuqInP@google.com>
 <2vxzjytgzh5r.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzjytgzh5r.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260506_090636_327756_732B5DAE 
X-CRM114-Status: GOOD (  21.48  )
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

On 05-06 17:33, Pratyush Yadav wrote:
> On Wed, May 06 2026, Pasha Tatashin wrote:
> 
> > On 05-06 10:31, Pratyush Yadav wrote:
> >> Hi Pasha,
> >> 
> >> On Wed, May 06 2026, Pasha Tatashin wrote:
> >> 
> >> > A preserve_context kexec returns to the current kernel, which
> >> > is unrelated to live update where the state is passed to the next
> >> > kernel. Skip liveupdate_reboot() in this case to avoid serialization
> >> > and prevent sessions from being left in a frozen state upon return.
> >> 
> >> Should we also stop KHO? Now it is stateless and always finalized. I am
> >
> > No. KHO preserves kernel internal memory; for context-preserved 
> > kexec, the 2nd kernel and the 1st kernel do not have overlapping 
> > memory. So, whatever the 1st kernel maintains in KHO is an internal 
> > detail of the 1st kernel. Once we return from the 2nd kernel to the 1st 
> > kernel, all KHO memory is going to stay as-is, and the 1st kernel can 
> > even perform a regular kexec or live update later.
> 
> My point is that we keep KHO data in the 1st kernel but do not pass it
> to the 2nd kernel via setup_data or the devicetree because it should not
> use that memory anyway. So essentially we add a check in
> kho_fill_kimage() and return early if preserve_context is set.

This is a good point, I think we should do that to prevent passing via 
setup_data on preserve_context kexec.

> 
> I don't think it makes much difference in practice so no strong
> opinions. Fine either way.
> 
> [...]
> 
> -- 
> Regards,
> Pratyush Yadav

