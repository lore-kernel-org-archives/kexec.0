Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB315D730A9
	for <kexec@archiver.kernel.org>; Fri,  3 Apr 2026 06:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z+XyFWPQDMhQFEfGTh5lxYJKkJRaIVp5bBIXM3gL4/Q=; b=FX2m739JwjTOd974+YTqvd2LZC
	QwFO8LVcaic/fSvIvrCf9p9uQTeH0hs2G/J7Fa5gzDV4OTy4armUC5uA8IusNNVBf5TfAZHP7vDGU
	q7TYWzyVReoF50fTLsrgLbqKU6Yt/xPNI0OdpI5oKLoNFmuwF1foqAJnpJB0JzBc23Q8Sv98OYS8y
	RlZUXL7zJuDhIwFwk7AiJxtJTXBnduSXsnWwDBw5pIA0MTvAATPkX+P1pmqmysFoLzZAlOz4BAdCk
	mNRsgDmGc+ydMWRb5joV6FNw+NUQ7iDSuRPvySrMSb3mlfiGJ8pleZ1jCyoGbAVqblGIVUOtBMLon
	hDq3l88Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8Y3z-00000001ObT-2grv;
	Fri, 03 Apr 2026 06:31:27 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8Y3t-00000001Ob1-2r1j;
	Fri, 03 Apr 2026 06:31:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 26B5B43F2F;
	Fri,  3 Apr 2026 06:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55355C4CEF7;
	Fri,  3 Apr 2026 06:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1775197880;
	bh=z5smXNJSDIZs7k9QwbEBHb9yac6jAucmud+T/8hzBOA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=wNbZTh+hRi8x6NmTtJ9Tt4BdER0gAGV8bnI1wlICJAzLhthK02O3Ak1qqpppmO6w9
	 ItAmoOlKwr1JFtSe+6AIaOuNsgXneiQAudP0xVDh/lwc/285dhdd9UmXc38A2RPQOU
	 8DQuoRvBiRsIHfOUw0fy82VH7uKPithrZYXkG7pc=
Date: Thu, 2 Apr 2026 23:31:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org, Arnaud Lefebvre
 <arnaud.lefebvre@clever-cloud.com>, Baoquan he <bhe@redhat.com>, Dave Young
 <dyoung@redhat.com>, Kairui Song <ryncsn@gmail.com>, Pingfan Liu
 <kernelfans@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring
 <robh@kernel.org>, Thomas Staudt <tstaudt@de.ibm.com>, Will Deacon
 <will@kernel.org>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Saravana Kannan <saravanak@kernel.org>, open
 list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] arm64,ppc64le/kdump: pass dm-crypt keys to kdump
 kernel
Message-Id: <20260402233118.08ea88a6836bd10f01031cce@linux-foundation.org>
In-Reply-To: <51761fcf-955f-45e2-97a5-2b49d8e79d04@linux.ibm.com>
References: <20260225060347.718905-1-coxu@redhat.com>
	<20260225060347.718905-4-coxu@redhat.com>
	<51761fcf-955f-45e2-97a5-2b49d8e79d04@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260402_233122_090454_09FBD9CA 
X-CRM114-Status: GOOD (  12.53  )
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

On Thu, 2 Apr 2026 16:24:14 +0530 Sourabh Jain <sourabhjain@linux.ibm.com> =
wrote:

> But while reading crash_load_dm_crypt_keys() I noticed a possibility of a
> double free at the address pointed by `keys_header`:
>=20
> In crash_load_dm_crypt_keys()/crash_dump_dm_crypt.c
>  =A0 =A0 snip...
>=20
>  =A0 =A0 kbuf.buffer =3D keys_header;
>=20
>  =A0 =A0 snip....
>=20
>  =A0 =A0 r =3D kexec_add_buffer(&kbuf);
>  =A0 =A0 if (r) {
>  =A0 =A0 =A0 =A0 pr_err("Failed to call kexec_add_buffer, ret=3D%d\n", r);
>  =A0 =A0 =A0 =A0 kvfree((void *)kbuf.buffer); =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 <---=20
> First Free
>  =A0 =A0 =A0 =A0 return r;
>  =A0 =A0 }
>=20
> Since `keys_header` is not reset, the next call to=A0build_keys_header()
> will cause a double free at `keys_header`.
>=20
> static int build_keys_header(void)
> {
>=20
>  =A0 =A0 snip...
>=20
>  =A0 =A0 if (keys_header !=3D NULL)
>  =A0 =A0 =A0 =A0 kvfree(keys_header);
>=20
>  =A0 =A0 snip...
> }
>=20
> What do you think?

It looks that way to me.

