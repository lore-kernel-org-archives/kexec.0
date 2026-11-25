Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638D4606A32C
	for <kexec@archiver.kernel.org>; Wed, 25 Nov 2026 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UxKrKu8h;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=p/OQw3/p
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:
	Subject:Cc:To:From:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=X+1AYy7Mp2a7SBL4ePYq/G5iDJIRCdCJCue8L7l5f3k=; b=UxKrKu8hwPmw+d
	bJD/GCos5sUvlljtAVEWlLUAf8wfEzfY6bUs4qPAUGWnG7J9BjOGaCmA3uLejduNb1znNc64dIS7z
	iLID4J9BvEGwqzyYsMNRTomfaUVDW/3UZUKMG2cNGsND8+CwmEtQDAoctUHW/PybVZSo+J3uwT57I
	MAI1/q8J1bSoKesuwf64pgSyzi5dWm3NaWv8Y0WVwrQvA8wjPCwe98QxlcMgpy4tazhi7WSuv25Sw
	QxLmIV2raKjjoVYL0vglrYxAOSHBADqEdOR7Dn4BEG8QkIhdqKXOiFMTdOwCVd+PEw408O/r04Sab
	Y39Wu3k31MX7JMZMLEPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWHL6-0000000Aw7n-01Pg;
	Wed, 25 Nov 2026 18:03:28 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWHL2-0000000Aw67-38vQ
	for kexec@lists.infradead.org;
	Wed, 25 Nov 2026 18:03:26 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2f045b921caso35837895ad.3
        for <kexec@lists.infradead.org>; Wed, 25 Nov 2026 10:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795629804; x=1796234604; darn=lists.infradead.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=X+1AYy7Mp2a7SBL4ePYq/G5iDJIRCdCJCue8L7l5f3k=;
        b=p/OQw3/pChri//N5poZM6SYf661NegLLGRO0mW2n0lYQMcxpCbu8vhF6lkSLgZ/Isb
         gvjw6av3jnePME7oIRW+IWWiGhZgiqV8TiY6WTig4o9FXsxDgDDClZQ3eTv+QYmFtiaY
         uBd07ZixTkhGtyMWOsw68dUcm3XuZDYWt9GcHmDrcBCbuOhotmegjk6V63vU1A9p7MFy
         E63nroypktXAeCRN2p6SrVztG5+2CbJmkD4p8mgZCM/fUwmSJle+pyLReRRABfX2tzZk
         l7ezCU44vI33WO6uq85FCVvstk0WBfEe1sPmHfMG3ZwnAn6W6oCowDa/piVQQZC2v9aU
         WrVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795629804; x=1796234604;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X+1AYy7Mp2a7SBL4ePYq/G5iDJIRCdCJCue8L7l5f3k=;
        b=0RbqEKSlK4GoPaFfu271jxecE+nQX/KVChuftemMfSM3iboFR2vhOA9uNmGP2+kmIl
         sgycAKTgB/cPC2j4C4ViFb1t+0XGo/7DmEwjeYMuzV3obHhhbmf0zrLzWvhLIDZth+9/
         p1z0T2XSbwhpLdrp/kmWx44sET6VlP9xl+r8I+NQs0KhVJkdwlQK8G3HsoRSRy8gU+nX
         Vs9H+MDFlJGlhY1PBarlvpT5sNEGWS5DCpX5BcWxVdjtvqoF4V3IdviZ17Wo29OVxVgo
         kNCojT8raodIp/AonYBwFpMv/LLHRixx8MB3GcM9ZV9YZ7WsnRCVl9ygZ7D06vyB+rHx
         eQ8g==
X-Gm-Message-State: APuU4Z+maVc0qL/y3wK06mx5AcwsTC+mxB1TkHA9GCaz8zPknbum8OeR
	hhtpq+LMp6tWQiT3VH0/fkCuE8LHwBMMmvdeFjsZfwYeW/gAOZUCLSlLJK1EEadXGQ==
X-Gm-Gg: AZFdTZcpCYOsYEwFqnOGXVFK6E30T0tIK6NE8cK+uUx8rVnybsz91sU8xh0XUhIS/gV
	pt7oiNcE2hDoMAR6K6emLw0GMeIkngWxU/UDgJDMuE+henxbBYufnrCzRfgb8gbJiBusoi8gvb5
	nqCgiXacyneCOBuwHIhx4DUORDaX9qpiIk7u95pXPuoZZPaRoCChbisPuDiSgDYhbKIMyUiQvJ7
	cHhxnOvOwkFwFOqa2cUo8xqc7CvI7JdGKpe3UbspcTUeKr/+hybGOUQH6SpigmJ3NDKcQJOn9If
	6i1ZW/8s2FY/GXQGNpAhyCL25TMOtgluSIAx3allmWLZHt0HfdqP9rYXDSapFCfu4YZgN5xA5kh
	FlYk5RNWD09evPwUmq/ma1glXXL/qYCc4MEMabF70FUINTl7rbTy2sQtBYOnVeIx9jmgEpRUTEh
	A8RcucrJhd64eLe2lFwdK2BBMp/cHdcvRL5HjTEz/Az5sH2K3OiVh/8fPNdyPKCqBdVmjsWSwny
	V+OxPxollwMm6pi9yjZmPxGv4qQEH1KZkoLc/MMmyIvpy9E8x0qimiXA/Pm/Wwkl0wjUsNF98A5
	Q1N1SLykSMxR1FcHvcFwJTcXzPfn0f7BNu0Umr5ZXKRH/Vk3okBGYsQLmbz8/cZYHg==
X-Received: by 2002:a17:902:f54c:b0:2e8:9820:80cf with SMTP id d9443c01a7336-2f03f1cfbe5mr188390265ad.58.1795629802894;
        Wed, 25 Nov 2026 10:03:22 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f14a432sm91361725ad.75.2026.11.25.10.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 10:03:21 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Nov 2026 10:03:21 -0800
Message-Id: <DN4HN2W6ZVES.289H6BZD9U7KB@google.com>
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
 <DMZLLYOVIGOU.1RXWYJN6UQTM@google.com>
 <20261124234830.GB3545683.vipinsh@google.com>
In-Reply-To: <20261124234830.GB3545683.vipinsh@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_100324_801574_F0BDAB8E 
X-CRM114-Status: GOOD (  14.93  )
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

On Tue Nov 24, 2026 at 4:22 PM PST, Vipin Sharma wrote:
> On Thu, Nov 19, 2026 at 04:06:38PM -0800, David Matlack wrote:
>> The incoming kernel computes its own virt[] and write[] masks and
>> requires both to match exactly with what's in vfio_pci_core_device_ser,
>> otherwise it fails the retrieve. On take-over it uses the preserved
>> value for bits in virt and its own freshly initialized value for the
>> rest, like your option 1.
>
> For now, we will be rejecting any changes and in future when we add
> userspace opt-in mechanism then we can loosen this check, am I right?

Yes, any difference fails the retrieve.

I don't think the opt-in would loosen the check. What changes is the
masks the incoming kernel expects: it builds its emulation for the
device with the opt-in bits recorded in struct vfio_pci_core_device_ser,
so a device that opted in to new emulation still matches. Devices that
didn't opt in get the baseline emulation and keep matching older
kernels.

Separately, if we later find specific differences that are safe to
accept (e.g. a newer kernel allowing writes to a bit that used to be
read-only), we could relax the comparison for those. But that's
independent of the opt-in.

