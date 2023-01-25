Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D2FC61D9D
	for <kexec@archiver.kernel.org>; Thu, 26 Jan 2023 07:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YyusD3Pet2Cm845737uQkrp8orAP+SeDms2S1IyqLLM=; b=ZzGoPxUTWKnj77
	A39D9p8K0O+bBEF1cnrv2HoKFMfbBQdihFz2iXVbsnrcx3FgeBosXlJcIGDXP3FDM1JvZkNHPVDJY
	/AfeYJLa2XdyeK7KwMqIfOWVJnO2dua5T/zBtHz7Qd5y/jNLFRqISFlIPP7oHddtbJFVY8eOZ9M8Y
	O0qkumJzMU4LvIHrCuKCLfOVLhPjEo7MRx0p7tS9uj3J+A3gL9mhXx8FbiqCOmqRr0BTuMTbRCL+K
	/cHzc1yojYWyicskrxz1GnHOE0EoWOxfsiv/h3hFyN9Ni6Ew9g5+O9BX1VX3Pb+WDRn+yPJglPytS
	GVhmgmbIIOLMpbrZQnyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKwKm-009nud-CB; Thu, 26 Jan 2023 07:06:08 +0000
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKj62-0086xc-DQ
	for kexec@lists.infradead.org; Wed, 25 Jan 2023 16:58:04 +0000
Received: by mail-yb1-xb36.google.com with SMTP id a9so23813069ybb.3
        for <kexec@lists.infradead.org>; Wed, 25 Jan 2023 08:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G/HaQvIeifLKJJp6JsBUTA/Cu0PG4HCFXOBV2LCBpGc=;
        b=ngnRJahtqVxSN6UIjLqWU+1aTxdIhv7re4hDfLrN8LXncI6BNG1ZwqGy4tzOTLxPiH
         4VWOIuHk0tMtzp4F11bJV5cn9qN75X4TjPW2iyn4nOIj2Y2qsTa18wfmHkOGhLKlmZoS
         vXpRc/g/QGDtReYNnPGF6rlvG7jz8sM8MsRTR7LhXioKCpHgDgO7fKBddw0dzS48JeET
         78piPZYcyZX9vIYyfAzpklatM6XnaaFqr/b+XLZlxI1Y0y+wCHWFOsnbVElEi6T+CQOb
         4zMPa96gAXD4xbmjnQv7nMUvo5bgJJEK/r3Eu0NIV8f4SPGC7eT5IU6zl2RkKdozGWcK
         sknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G/HaQvIeifLKJJp6JsBUTA/Cu0PG4HCFXOBV2LCBpGc=;
        b=xMt5fVGLLRQYfRkNW8s+IKeaS6A7X99mOxwkpRTCNWp2WkL6Gevaq2lOwIijNlsBBb
         pYqCzbG9MNDTbWM0vS+lekPDGvmhRODc/DunoHK+pUZvyDWqWkI+cQSYVwhMtkpFWwvN
         aEi9SIanCbCP4Hb7xpuQ9lWcHNm50zJEkwDrDppVyS/LnY9dNTu+Z0E6hZq9Ym2e0IGi
         2MYEDUkpmCt3VHC7yyx3wUerqiD0bZ+ugu4VGY4EkYyYyQCvqSh+L5KwvuVEz2F1t9+3
         haJjAV2/JYZhrM+b3ZHgF+ENIFtFTclLAkEVKZYEvUVtf1Z5iD2gyvVGvRHesstDUccP
         JkvQ==
X-Gm-Message-State: AO0yUKWoH1yzMgWLJYjmZ+dHuYL0FOR0veBz7XGXsLIc+/HShon2xT1C
	PnUmYj1NvnvWoygfBQ0q2Af1eX2zn02uDd7C9efp/A==
X-Google-Smtp-Source: AK7set97wrc43TM0/ovVONCfpWDKrtFzkyYmNKL3FW97qdU/yOGMPZssBTWD4MRF2UhZkPfEz4JLEj3/xF1loldnjYM=
X-Received: by 2002:a25:ad02:0:b0:80b:6fd3:84d3 with SMTP id
 y2-20020a25ad02000000b0080b6fd384d3mr714673ybi.316.1674665880846; Wed, 25 Jan
 2023 08:58:00 -0800 (PST)
MIME-Version: 1.0
References: <20230125083851.27759-1-surenb@google.com> <20230125083851.27759-5-surenb@google.com>
 <Y9D4rWEsajV/WfNx@dhcp22.suse.cz>
In-Reply-To: <Y9D4rWEsajV/WfNx@dhcp22.suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 25 Jan 2023 08:57:48 -0800
Message-ID: <CAJuCfpGd2eG0RSMte9OVgsRVWPo+Sj7+t8EOo8o_iKzZoh1MXA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] mm: replace vma->vm_flags indirect modification in ksm_madvise
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, michel@lespinasse.org, jglisse@google.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org, 
	luto@kernel.org, songliubraving@fb.com, peterx@redhat.com, david@redhat.com, 
	dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de, 
	kent.overstreet@linux.dev, punit.agrawal@bytedance.com, lstoakes@gmail.com, 
	peterjung1337@gmail.com, rientjes@google.com, axelrasmussen@google.com, 
	joelaf@google.com, minchan@google.com, jannh@google.com, shakeelb@google.com, 
	tatashin@google.com, edumazet@google.com, gthelen@google.com, 
	gurua@google.com, arjunroy@google.com, soheil@google.com, 
	hughlynch@google.com, leewalsh@google.com, posk@google.com, will@kernel.org, 
	aneesh.kumar@linux.ibm.com, npiggin@gmail.com, chenhuacai@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, richard@nod.at, anton.ivanov@cambridgegreys.com, 
	johannes@sipsolutions.net, qianweili@huawei.com, wangzhou1@hisilicon.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, vkoul@kernel.org, 
	airlied@gmail.com, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, l.stach@pengutronix.de, 
	krzysztof.kozlowski@linaro.org, patrik.r.jakobsson@gmail.com, 
	matthias.bgg@gmail.com, robdclark@gmail.com, quic_abhinavk@quicinc.com, 
	dmitry.baryshkov@linaro.org, tomba@kernel.org, hjc@rock-chips.com, 
	heiko@sntech.de, ray.huang@amd.com, kraxel@redhat.com, sre@kernel.org, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, tfiga@chromium.org, 
	m.szyprowski@samsung.com, mchehab@kernel.org, dimitri.sivanich@hpe.com, 
	zhangfei.gao@linaro.org, jejb@linux.ibm.com, martin.petersen@oracle.com, 
	dgilbert@interlog.com, hdegoede@redhat.com, mst@redhat.com, 
	jasowang@redhat.com, alex.williamson@redhat.com, deller@gmx.de, 
	jayalk@intworks.biz, viro@zeniv.linux.org.uk, nico@fluxnic.net, 
	xiang@kernel.org, chao@kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	miklos@szeredi.hu, mike.kravetz@oracle.com, muchun.song@linux.dev, 
	bhe@redhat.com, andrii@kernel.org, yoshfuji@linux-ipv6.org, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, perex@perex.cz, 
	tiwai@suse.com, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, 
	linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-kernel@vger.kernel.org, 
	linux-graphics-maintainer@vmware.com, linux-ia64@vger.kernel.org, 
	linux-arch@vger.kernel.org, loongarch@lists.linux.dev, kvm@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-sgx@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-acpi@vger.kernel.org, 
	linux-crypto@vger.kernel.org, nvdimm@lists.linux.dev, 
	dmaengine@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org, 
	linux-samsung-soc@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
	linux-tegra@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	xen-devel@lists.xenproject.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-rdma@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-accelerators@lists.ozlabs.org, sparclinux@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-staging@lists.linux.dev, 
	target-devel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-aio@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-ext4@vger.kernel.org, devel@lists.orangefs.org, 
	kexec@lists.infradead.org, linux-xfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, kasan-dev@googlegroups.com, 
	selinux@vger.kernel.org, alsa-devel@alsa-project.org, kernel-team@android.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230125_085802_479590_8A0A86A1 
X-CRM114-Status: GOOD (  13.67  )
X-Mailman-Approved-At: Wed, 25 Jan 2023 23:06:05 -0800
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, Jan 25, 2023 at 1:38 AM 'Michal Hocko' via kernel-team
<kernel-team@android.com> wrote:
>
> On Wed 25-01-23 00:38:49, Suren Baghdasaryan wrote:
> > Replace indirect modifications to vma->vm_flags with calls to modifier
> > functions to be able to track flag changes and to keep vma locking
> > correctness. Add a BUG_ON check in ksm_madvise() to catch indirect
> > vm_flags modification attempts.
>
> Those BUG_ONs scream to much IMHO. KSM is an MM internal code so I
> gueess we should be willing to trust it.

Yes, but I really want to prevent an indirect misuse since it was not
easy to find these. If you feel strongly about it I will remove them
or if you have a better suggestion I'm all for it.

>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Acked-by: Michal Hocko <mhocko@suse.com>
> --
> Michal Hocko
> SUSE Labs
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
