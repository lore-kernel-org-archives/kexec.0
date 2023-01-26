Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C2FC61D97
	for <kexec@archiver.kernel.org>; Fri, 27 Jan 2023 16:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
	:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zg73AITK0wGu/r5aL7rWFjo+5493gtZ5cKUcG/UlEEM=; b=veLSfV7zKikDPDMgmXEKWCloZf
	i/2BUH5soTN6qENZ3GAyDlpVCVrLHZBE4yGm4ssvjqgqRwdfvQsI8LpTCmrQrO5lswv1f6/+9zjmu
	m67L/+o1VkgbjzUO1RLvTJzSCbrvFrn0gb50ICOo6e5d+UwgAnchsQ6I/qXPQKkEwsxUO2bWPnoPp
	7ZTBpNtELaO5FJK+CBTMzGJz/4ERM/8YEgp/nlJH2R0gT4wJ+kQBt5QMk6NoK63G4tS/1o2vLMSYI
	teVA0DLl/sivBleRZUVCbpPfnsI7sdf/g9ey5tlIz5NpWte1wc3oTCBhhDQtNgfIFcK7dcl5X9zXJ
	JMaYSgPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pLRk5-00Fk70-K9; Fri, 27 Jan 2023 16:38:21 +0000
Received: from madras.collabora.co.uk ([46.235.227.172])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pL5j2-00By7k-CA; Thu, 26 Jan 2023 17:07:50 +0000
Received: from mercury (dyndsl-037-138-191-219.ewe-ip-backbone.de [37.138.191.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 7FC3E6602E7D;
	Thu, 26 Jan 2023 17:07:41 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1674752861;
	bh=TJwB9xWefUtenAJhobcnuA3/dr44yh/1qZH05naV3dA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HIAeawkSMl4wLK9atphFO2PYIuQtn0mXWrQTGJkp27Vvwen4RmNJXIKy0KOcMN2qu
	 MGji/BoqRh//5quIKkg+7Jg9a4rlT6zYnOxKnHRve8IRt32uZ0O2J9C6ByA7KSG9ni
	 ooI+f+xDzdj/4Xv/XqAW1ZMOqMbxlnaE69Ns4AaVsCb09DHvVD+xjXrJ7HkcJ65ZDs
	 0FKkR9qOOchTbFQKw+Lbe8GJsd/K96q/WWSPWtyPUY4G0yRJ/G34tsJUBI/vL5q95x
	 a6dIJ/I/0Glk/75yhzfiBv6PLPN/HUTuWOcS4vpdAGRdicde5HTb77Vj3shLRE2rZN
	 snAuQFm3yL5CQ==
Received: by mercury (Postfix, from userid 1000)
	id 8DAD710609C7; Thu, 26 Jan 2023 18:07:39 +0100 (CET)
Date: Thu, 26 Jan 2023 18:07:39 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, michel@lespinasse.org, jglisse@google.com,
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
	mgorman@techsingularity.net, dave@stgolabs.net, willy@infradead.org,
	liam.howlett@oracle.com, peterz@infradead.org,
	ldufour@linux.ibm.com, paulmck@kernel.org, luto@kernel.org,
	songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
	dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
	kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
	lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
	axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
	jannh@google.com, shakeelb@google.com, tatashin@google.com,
	edumazet@google.com, gthelen@google.com, gurua@google.com,
	arjunroy@google.com, soheil@google.com, hughlynch@google.com,
	leewalsh@google.com, posk@google.com, will@kernel.org,
	aneesh.kumar@linux.ibm.com, npiggin@gmail.com,
	chenhuacai@kernel.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, richard@nod.at,
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
	qianweili@huawei.com, wangzhou1@hisilicon.com,
	herbert@gondor.apana.org.au, davem@davemloft.net, vkoul@kernel.org,
	airlied@gmail.com, daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, l.stach@pengutronix.de,
	krzysztof.kozlowski@linaro.org, patrik.r.jakobsson@gmail.com,
	matthias.bgg@gmail.com, robdclark@gmail.com,
	quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org,
	tomba@kernel.org, hjc@rock-chips.com, heiko@sntech.de,
	ray.huang@amd.com, kraxel@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, tfiga@chromium.org,
	m.szyprowski@samsung.com, mchehab@kernel.org,
	dimitri.sivanich@hpe.com, zhangfei.gao@linaro.org,
	jejb@linux.ibm.com, martin.petersen@oracle.com,
	dgilbert@interlog.com, hdegoede@redhat.com, mst@redhat.com,
	jasowang@redhat.com, alex.williamson@redhat.com, deller@gmx.de,
	jayalk@intworks.biz, viro@zeniv.linux.org.uk, nico@fluxnic.net,
	xiang@kernel.org, chao@kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, miklos@szeredi.hu,
	mike.kravetz@oracle.com, muchun.song@linux.dev, bhe@redhat.com,
	andrii@kernel.org, yoshfuji@linux-ipv6.org, dsahern@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, perex@perex.cz, tiwai@suse.com,
	haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
	linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-graphics-maintainer@vmware.com,
	linux-ia64@vger.kernel.org, linux-arch@vger.kernel.org,
	loongarch@lists.linux.dev, kvm@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-sgx@vger.kernel.org,
	linux-um@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-crypto@vger.kernel.org, nvdimm@lists.linux.dev,
	dmaengine@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
	linux-samsung-soc@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	xen-devel@lists.xenproject.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
	linux-accelerators@lists.ozlabs.org, sparclinux@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-staging@lists.linux.dev,
	target-devel@vger.kernel.org, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-fbdev@vger.kernel.org,
	linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
	devel@lists.orangefs.org, kexec@lists.infradead.org,
	linux-xfs@vger.kernel.org, bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org, kasan-dev@googlegroups.com,
	selinux@vger.kernel.org, alsa-devel@alsa-project.org,
	kernel-team@android.com
Subject: Re: [PATCH v2 3/6] mm: replace vma->vm_flags direct modifications
 with modifier calls
Message-ID: <20230126170739.mlka2jivn3mfstyf@mercury.elektranox.org>
References: <20230125083851.27759-1-surenb@google.com>
 <20230125083851.27759-4-surenb@google.com>
MIME-Version: 1.0
In-Reply-To: <20230125083851.27759-4-surenb@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230126_090748_777127_ADE61356 
X-CRM114-Status: GOOD (  14.27  )
X-Mailman-Approved-At: Fri, 27 Jan 2023 08:38:04 -0800
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
Content-Type: multipart/mixed; boundary="===============4837509790261777782=="
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org


--===============4837509790261777782==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qcyccrleajamxo75"
Content-Disposition: inline


--qcyccrleajamxo75
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 25, 2023 at 12:38:48AM -0800, Suren Baghdasaryan wrote:
> Replace direct modifications to vma->vm_flags with calls to modifier
> functions to be able to track flag changes and to keep vma locking
> correctness.
>=20
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
> [...]
>  drivers/hsi/clients/cmt_speech.c                   |  2 +-
>  120 files changed, 188 insertions(+), 199 deletions(-)
> [...]
> diff --git a/drivers/hsi/clients/cmt_speech.c b/drivers/hsi/clients/cmt_s=
peech.c
> index 8069f795c864..952a31e742a1 100644
> --- a/drivers/hsi/clients/cmt_speech.c
> +++ b/drivers/hsi/clients/cmt_speech.c
> @@ -1264,7 +1264,7 @@ static int cs_char_mmap(struct file *file, struct v=
m_area_struct *vma)
>  	if (vma_pages(vma) !=3D 1)
>  		return -EINVAL;
> =20
> -	vma->vm_flags |=3D VM_IO | VM_DONTDUMP | VM_DONTEXPAND;
> +	set_vm_flags(vma, VM_IO | VM_DONTDUMP | VM_DONTEXPAND);
>  	vma->vm_ops =3D &cs_char_vm_ops;
>  	vma->vm_private_data =3D file->private_data;
> =20

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

--qcyccrleajamxo75
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmPSs1EACgkQ2O7X88g7
+pquLBAAkw9lw9lxNRCI6jvqLy98JsUBgSQigNB6Eh8JVWsySHMm1OszFCcvTpoc
vinC/VPMOa6JwEw5e9naXRF2UJahO+Cx+e5MYIKos3QyIUPfi0YM7Cv96h6+c4l/
NdcxLS8+9ElitTuA47UVgPSeZwzdZ1kU5VUV1X2fx+6aGA+dBfWVBgWDqU6AB0Sa
ehU4betso5Ypl26YEmLPHmY+8Xx2jXNwwBEgsHgO2/YjRn9YPDeMAqb4lWs99h0d
nUV1VqwTClRrExtNDvidHryknmyCIBpYt38gn0i9+uIf9mFoBmUDN+/zAdRguGBT
r1CQAwvRvHmEyGJ4dp1nijyt/PWxDBlCWytlmzXrK/rkeH8sQCRdCr9L83/d5DM0
iU98ehmbH9kx8rD4y0L91xmsnegNYNKSfAvz3EP4KYFOHjTw2SOCYoazPu3z62bN
d3HL+08LeZpm1XwVPydZqBd5UpBK8NaQYCJ3BjsLUefsSJE+SWzsnoYFnbUrL1X9
1XfU6LGtVvjCPUsjk7oqh5PjtRGQsdtUhSZJLwNzTeh4I0nSzL1pj8vRFZ7UTcV4
RmFYsjBbKhja2fC13eM4tKzfx53harnHVNuUPw2aoLKshpkQaOTUqWBnRXtbJZkb
dSRKObxfPlHVI+awnfN6owpXF86Owew2+XJcXILOPxaBk8PI/Ns=
=/0TB
-----END PGP SIGNATURE-----

--qcyccrleajamxo75--


--===============4837509790261777782==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============4837509790261777782==--

