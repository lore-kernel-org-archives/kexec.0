Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5576606A31E
	for <kexec@archiver.kernel.org>; Wed, 21 Oct 2026 23:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=g+MULQxs;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=lG6X5msm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rh1ct0ynFCJmpIeBgUsQvZu9SOoIsv6E2A9BdvVwioc=; b=g+MULQxs1kHgXDB3AiCdvxYFS1
	2mwRrlmo0O3XZGC2dfdHjZA3yOIKPYjP3HF3B+b84DYFtNc6Cr0wLfNoHLySTq1CVR6ZGr7UUTiHI
	1JXNNFCkyh7hfT05Phw7R5JC8hRvae3Kx+aQhntknmA6ZfZU+BXfnevGc4kRjCixKmf+4ndklxvdd
	DH6ppc7GkUm8DrzViCVOUOC0hwXjNTSOPlkEkVPkYF2yStqphEW3lYTDiuNV1i90+bnnD16KMOT+N
	gdpnff/Pv2kpC62WU4JXWrbbF80avoOIaW+XlLwuNSsMENrWJdThpKK5tjjG9jJPgPx0lBDWVEX5R
	l1k93/Ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJfKB-0000000D0pB-3aiy;
	Wed, 21 Oct 2026 23:02:23 +0000
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJfK9-0000000D0oI-2iIe
	for kexec@lists.infradead.org;
	Wed, 21 Oct 2026 23:02:22 +0000
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so766459a91.2
        for <kexec@lists.infradead.org>; Wed, 21 Oct 2026 16:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792623740; x=1793228540; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rh1ct0ynFCJmpIeBgUsQvZu9SOoIsv6E2A9BdvVwioc=;
        b=lG6X5msmmCAR2gy0OeSZKLNdww8QYsjnbCN7pjRyhQwOirSHybLaxtWFjJSVXKpwDC
         OocCsPL2uud2gq6hiCBpIF1OFehhoDCxgjZwrk7AT8CKruS7hS6rS/3dxH65ej3CtdZj
         UXJlwypr0JC3mbZKOiUSeQ59au2Kx8ZtegH65BpyVcZZxoCVkpWKrNq/JUz0E3nWFiEx
         CJc+dLGR7jtcCAjRtZhWCvDqYziY2uuuNH3lhFX71Lp73CLquvnzxX1sVlJPTbmM4uD5
         3Gu7gyU3UfVd2zIm0F7Zj22e0Fpo4JQTMheTR6Vs0tIXcYlTJT109OcBjQD6bVOAyF2g
         srBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792623740; x=1793228540;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Rh1ct0ynFCJmpIeBgUsQvZu9SOoIsv6E2A9BdvVwioc=;
        b=Crm8UI7crUdulb/te5GjjSPnUIuCBNA1z73QgGmDbkbLL99FZkyhQ2LeKpCEhN+xZA
         d28y2DweLfSP4+r73n87jhXII9XQ9HNSoi5uDe5nf3CKGnXW4QdHmoiQobglh42Z34Ik
         XVUYhCphVpru8mKoYcbTLDnDbFfi/rBNmjlTDrOjZCPWcZ0ZmDYfOv3umlGXIlt9CirX
         2n4tmyjASBuqxMajgLF5fCIWe29Icl+REHZmdUtsnIYZHMv52sdqYvOzDSGaLWHkQAu1
         c/cfPHNzedFJHpnbMsZ3+lZPB4ImCOv6eut89SvFfGCkWu8dA1SuEr+/TaJQx7uW3HE+
         KFgQ==
X-Forwarded-Encrypted: i=1; AKwUvBwXdrCKyTMqMqIHzUZ9wIxU7PVhmBdEu6ob3CqHJ7RKsLYp+xxPMV3B93OCUQ6R1qIoanoGjg==@lists.infradead.org
X-Gm-Message-State: AFq9FYJIJw4QVttr/ukhFXprkgjrpM17x5oKDGzkdE3d5fv5c8a+bqxz
	B/IokC5cVGRrnW+Ub+P8cy1nm9XzmMtDKNPRDCi/uGh0MmgslONwtY93/3eLwreE/g==
X-Gm-Gg: AYBFou0PK7Ha4pbpiIMXCYBR7h2VSVu0K2xEEixlVUlZThmFEh2S9gbmR0MfAEAeiiX
	PlVoVTHP5n7AJTo6fEY8h5X4NjNjCRCwSCxJES/uY8RmCQAFDL9bzN15nDkjPB4JwbGUG9aM0bu
	UCx18+dafVsL/pcebS55v279uBGrhjmW8eVmTe/D7dXxvV4d1gv4+3m6zBp1NSV53UDmVYmlvrG
	u/yVRZdnstjZRPxHcQiY778+Ek95qi8/xADIrSroJAfK9VmQYFiB+ClfCjomYwVhdpMQDOEWM9W
	TaCZ21WFn/5kRMNXTr/RO62oxJmM20ElibKfnBuwsJjihYhuWI8mmRMFuuDHEl8Y4Im0xIb2zFc
	69ZXMTsa1ABoA2p/5eZp+WbjBUx4nK1O8XwmKe+cA+w2iGbqi5BZJ7DbR76y2NPvJgLZydyvBH6
	ZAb2w/umZBXuSxYql2U0WLnrq+mZaM6GsiIE8mBrlblIYiBJ+QPZcpTZZkHvYmvf9fbMos7FpSM
	GWYIsQZ07jykDIUvR1Sq//p3/DE3l6R0qBi2d1CG2b4ryrBHFillQ77V0EHyfvVpbNhxYG13zyb
	+Arm+okomH3xKHNCVipqCiLszjpe+lLdJw+LPQ==
X-Received: by 2002:a17:90b:2f85:b0:3ac:7c4d:8be6 with SMTP id 98e67ed59e1d1-3ad86d9e088mr2829501a91.40.1792623739843;
        Wed, 21 Oct 2026 16:02:19 -0700 (PDT)
Received: from google.com (64.75.127.34.bc.googleusercontent.com. [34.127.75.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada4896c4dsm1314919a91.7.2026.10.21.16.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 16:02:18 -0700 (PDT)
Date: Wed, 21 Oct 2026 23:02:14 +0000
From: David Matlack <dmatlack@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Tarun Sahu <tarunsahu@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de,
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com,
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org,
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com,
	will@kernel.org, Alexander Graf <graf@amazon.com>,
	Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	kexec@lists.infradead.org, skhawaja@google.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/4] liveupdate: Select file handler by name in
 the preserve ioctl
Message-ID: <atlEdhPjlyTPDWmG@google.com>
References: <20261021152527.375070-1-tarunsahu@google.com>
 <20261021152527.375070-3-tarunsahu@google.com>
 <CA+CK2bCnS8wcVDbOymBGeJB6pDUkknOpF22EynbwSV=D5=J4ow@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bCnS8wcVDbOymBGeJB6pDUkknOpF22EynbwSV=D5=J4ow@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_160221_713092_79C1D090 
X-CRM114-Status: GOOD (  26.78  )
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
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-21 01:17 PM, Pasha Tatashin wrote:
> On Wed, Oct 21, 2026 at 11:25 AM Tarun Sahu <tarunsahu@google.com> wrote:
> >
> > Currently luo_preserve_file() iterates over luo_file_handler_list and
> > picks the first registered handler whose .can_preserve() callback
> > returns true. When a subsystem introduces a new, backwards-incompatible
> > file handler alongside an existing one for the same file type, userspace
> > has no way to choose which handler preserves a file descriptor, nor can
> > the kernel keep the existing rollback-safe handler as the default while
> > allowing callers to opt into the new handler.
> 
> That is not how it will work. If we are in the .can_preserve() call,
> it means the user has already decided which file handlers to use. We
> need to do that before any preservation happens; otherwise, we could
> run into conflicts on FLBs i.e. FH of different version require
> different FLBs.
> 
> Therefore, there should be a luoctl call (i.e via a new ioctl to set
> compatability) that provides the kernel with the specs file of the
> target kernel we are updating to, allowing the kernel to select the
> compatible file handlers. Since .can_preserve() is called when the
> user is already preserving files, the specification must have already
> been supplied, or the kernel should fall back to using the default
> (i.e., latest) file handlers.

I don't think that is the right direction. IMO the kernel should not be
choosing which file handler to use, userspace should be. If userspace
gets it wrong and chooses a file handler the next kernel does not
support, that's on them.

The problem with the kernel making a decision about file handlers is
then userspace does not know what arguments to pass in. We are adding
custom per-file handler arguments to PRESERVE_FD and RETRIEVE_FD. If the
kernel is picking which file handler to use, say for a memfd, then
userspace doesn't know which arguments to pass in.

Sure you could add some method where userspace could query which file
handlers are active and decide arguments based on that. But it feels
backwards.

I think a much cleaner solution is that userspace chooses file handler
during PRESERVE_FD. I would even require it for RETRIEVE_FD so that we
are guaranteed that the args the user is passing in are being sent to
the right file handler. Passing to RETRIEVE_FD also opens the door to
transforming across Live Update (similar to how AWS did LU from Xen to
KVM as discussed at LPC).

Regarding FLB conflicts, today we don't support multiple FLBs for the
same global state, so there is nothing to conflict. Selecting a file
handler during PRESERVE_FD doesn't change that.

If we ever need to support multiple FLBs for the same global state
(e.g. an incompatible change to the PCI FLB), we can add an ioctl that
lets userspace select which FLB to use before preserving any files.
After that, only file handlers registered with the selected FLB can be
used to preserve files. PRESERVE_FD with any other file handler fails.

That keeps the FLB decision up front and global, like you want, while
still letting userspace pick the file handler for each fd. I'd also
expect this to be rare, since FLB serialized state can use the same
feature flags as everything else in this series.

