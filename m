Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20905C43458
	for <kexec@archiver.kernel.org>; Fri,  3 Jul 2026 11:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OJa2AE/q6LxcAJlKRT9Ro3yKfffQf1xa1GooqwuD9kA=; b=3+XKUFGYosh3PKiUjJ7iEJ4lJa
	is7NqTGR9rTEkqx0T95DRHCDqA+DrRf8ByOI8B9S71XZfPR3b1DNBDZuqmWx5/yJ/xlXywyQWnEd6
	gCgsNBhVxQ+/CRqT12juSPMxi8NJb78TYCJfVYNanBDZMclmza+5AKqy9OKMSFsYe7fNsJedld22a
	yBsPtW0zzvS1nodYHV3aAIqYdSdttujrMwRqoREHWp74UAEi6kEKFkldCgh0AUa4bMBa7Nt/KYdM7
	YhurPUSardW+kcX2C0X+LYq+B8VQeq2Qvi2e6ldVtbN4o5YTyRg4lDtk418zm6eB2k3YWZ1Q6m9aH
	BM98Tn7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfboK-00000006mr3-28o5;
	Fri, 03 Jul 2026 11:11:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfboH-00000006mqC-1lJW
	for kexec@lists.infradead.org;
	Fri, 03 Jul 2026 11:11:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783077112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OJa2AE/q6LxcAJlKRT9Ro3yKfffQf1xa1GooqwuD9kA=;
	b=WCXkxgpJmt6DZIAM8CgzWvmtHblTDasHcV3776dJxBk6mnOG7yUGOBTCFq9+/B5W5JXt6+
	pHl0eQPq8DBDW8f0cslEbQ8qJwtJ8CpBCHrwfF2bqPGwc9ayEV5dae5KmlfLDATDCtDbGR
	HHZ+gsjPyGf9MMTo8uz55Ll5/7A7+mA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-Ln9DHgSxMWqC19SCo5OEpg-1; Fri, 03 Jul 2026 07:11:51 -0400
X-MC-Unique: Ln9DHgSxMWqC19SCo5OEpg-1
X-Mimecast-MFC-AGG-ID: Ln9DHgSxMWqC19SCo5OEpg_1783077111
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92d1cae5939so48827685a.0
        for <kexec@lists.infradead.org>; Fri, 03 Jul 2026 04:11:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783077111; x=1783681911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OJa2AE/q6LxcAJlKRT9Ro3yKfffQf1xa1GooqwuD9kA=;
        b=NA6Rg7f0n1acKnOZAjf4ags+3G5dchtwfrtsqy+AF6AKatiBtFBC6ELeTcyUWN4bdn
         jVmKhZ/3UVp/UODQl3VNhlnOGpHJR2d4CIdOiPKSm65ltDPvRC1sXvZlz5Ae8aS4Npeq
         g7TRkNCCaaeWMnH9hR6FO2T0AVGpzY6J1geD3fzAyr1U9KZTwvsH9XC6jUC0LKRgzBgy
         Rfu1TR9VEzDLHDTweYO4gvDYf0yiPRkQZTgAYOpwYVvHptICbVf0KGSmKwxC9BlctS+g
         jS47MDoTbtpDTBLroC41LdGwZ0fBtMzU7ucC5/mXp7W1HS7XdCyqcm97niTLK8Em12kx
         JTRg==
X-Forwarded-Encrypted: i=1; AFNElJ9sSKH1+h2j9IeNUX6RyrBXsJ8BmDjsHsGFKno/ZcBAS4gHwi28PIFdgmRe9w0qJyu9Wlj7Pg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxyYNt2RwxoTKxo/VGxzFMMJQlrb7tDuJZIREov0HrV7WQcWPev
	vvWuMqN/jMZx91gjihAPWHistMhy+RiHtqCGggbnIbrGp03UdG4sdCNGvY7W4hEc3W5BP4ALS+c
	3a/x8SLawd/PIJXL+p1GinimpxC2mMytt9u0Lw+MYnGIPS/bLVjzy+OIUyTiPP/YHaUuZ5u3L5Q
	c6CpvDZcOrSoDzllPkUnITHIMF99tRSiGcRZc4
X-Gm-Gg: AfdE7clcd2VdpeAYvGBwIjzJvaaOCQPpR64oiiu7h9htj9DqX9cHVA1Je9/eCBcAcEK
	epRFSsY1bg4UfLD8aRmncCQE2f3N2DkwD6ZnUgA2dttQRCfoQWAdzbIpCcikCU8xr6uLNEJ0GFc
	VBSzs58m0C9aybfoLBNixMj3rewGhvg8E0w+GE68vf3IxesEQXlUW20np8xB8eUFyg0Q==
X-Received: by 2002:ac8:7d53:0:b0:519:e91a:f4bb with SMTP id d75a77b69052e-51c26a8f88cmr125087441cf.31.1783077110677;
        Fri, 03 Jul 2026 04:11:50 -0700 (PDT)
X-Received: by 2002:ac8:7d53:0:b0:519:e91a:f4bb with SMTP id
 d75a77b69052e-51c26a8f88cmr125086941cf.31.1783077110290; Fri, 03 Jul 2026
 04:11:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260701025732.66330-2-ltao@redhat.com> <4b21e0d5-07d1-438b-a6ea-a2be596a3044@web.de>
In-Reply-To: <4b21e0d5-07d1-438b-a6ea-a2be596a3044@web.de>
From: Tao Liu <ltao@redhat.com>
Date: Fri, 3 Jul 2026 23:11:11 +1200
X-Gm-Features: AVVi8Ce5GouoiHvVypy54hHJATfssSZf7IVivve4m9vb8B4fIq_nNJ7KXKAOoB8
Message-ID: <CAO7dBbW_vxnRiq9QrZK0+nuNUkzOG8qrqYhKqzrz3FdRcayVOw@mail.gmail.com>
Subject: Re: [PATCH v3] riscv: Fix a NULL pointer dereference in machine_kexec_prepare
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-riscv@lists.infradead.org, kexec@lists.infradead.org, 
	linux-integrity@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
	kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Baoquan He <bhe@redhat.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Mimi Zohar <zohar@linux.ibm.com>, Nutty Liu <nutty.liu@hotmail.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cIpcFrZGlFwK-ioOlNZJWVdtxd6kKL7IrkI-AqiNJTU_1783077111
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260703_041153_550607_C84A2D53 
X-CRM114-Status: UNSURE (   9.55  )
X-CRM114-Notice: Please train this message.
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

Hi Markus,

On Wed, Jul 1, 2026 at 6:01=E2=80=AFPM Markus Elfring <Markus.Elfring@web.d=
e> wrote:
>
> =E2=80=A6
> > Fix this by simply adding a check before copy.
>
>                                            a data copy attempt?
>
>
>
> > Fixes: b7fb4d78a6ad ("RISC-V: use memcpy for kexec_file mode")
>
> See also once more:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/stable-kernel-rules.rst?h=3Dv7.2-rc1#n34
>
>
> Would a summary phrase like =E2=80=9CPrevent null pointer dereference in =
machine_kexec_prepare()=E2=80=9D
> be nicer?

Agreed, I will improve it in v4. Thanks again for your guidance!

Thanks,
Tao Liu

>
> Regards,
> Markus
>


