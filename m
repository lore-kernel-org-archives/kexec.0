Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A33FD45FC
	for <kexec@archiver.kernel.org>; Wed, 25 Feb 2026 23:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/+d/kouLLf9iKHdyjkzWOU+gVjFz9R5tJbv1KqoUtQs=; b=4gVLpDe0TBIdsp1QG5E+dgN7tM
	+oulV44TXGIyVjdqxex/koMBJWAdC5bjIDrKtITTcBweVbWx+wrdt/nAHld5Qs+mzHWgTgOWm9hCc
	RHGI7uheikcxUYe3yckbuNH69JxLtj3Gcfyrko3UevocgAZ8e59YouxitsiUwZnztYn3c6qiqD6Jr
	nvu3QvSx/PRTrbX3p8ZSvnKOk65HiAZDvopVeV/+eub5aSrg6hQ1/iNg+//dcCMW93/Rgmr29NFhz
	fOEQhR2u/4L+ZXETV8JURcvM/4+8oR+6SJNrtouQQCCfO/aV6hR9qbC/0u5HTiIPv2REtShAyh8tj
	Pcj+P+qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvOic-0000000560H-1O8K;
	Wed, 25 Feb 2026 23:55:02 +0000
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvOia-000000055zc-3PgT
	for kexec@lists.infradead.org;
	Wed, 25 Feb 2026 23:55:01 +0000
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-5069a785ed2so125911cf.1
        for <kexec@lists.infradead.org>; Wed, 25 Feb 2026 15:55:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772063699; cv=none;
        d=google.com; s=arc-20240605;
        b=JxNe/PQpOfxm25dmxD9sMNdl758P84uUbUnvgWW+QyZxb/lK4J2yYJxTuJ52weTUc8
         1Gx3zmjUhdPr4nZyc+7nFC1J3d96XTTkQIVyUFKCtW2+dN2OqNYln0QaNTNWg2fmeIzV
         2U+lx98PfR6oOXYogCp5hEL0cTcyglRGRw9QZrZGr3nmsD1qTD2ee0+TF9uyUiOnzlUF
         xINM72HVoMFY29tZ4eY8zureA56mgDpgHLnMgPeW9SlfCpZsqr99A+oxs5I/iofBpzh6
         wXJzWShP7Kvav5CPqXk/ORP3laQUKrlZjQUTmWXPEWRR0KViYcF3Kpg8qQncwhdMMWLn
         lqDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/+d/kouLLf9iKHdyjkzWOU+gVjFz9R5tJbv1KqoUtQs=;
        fh=UndnppKDvlwPHjRkWHJqhdv8WXTh2ifXFpBjZcpZ0Aw=;
        b=ihjSoqi30lb9rDoxX2NGhGvzYpWAndLy1JSc95lbf9AFL3bfKIbbj6aoOkqRTtJQhb
         knT0+9sHEKhGZ4sTesjvlufAic9pHsCpVsq9POtWYjGGGDNKuL0VZDSHuF6lGQZX9o5W
         uK5pmmaBHSDIrIrOV5KrXm3yK4v2Us0/SsmP/Z/5PSDfQdhSqPt54v7Tdi6CkotYx8NB
         PofLGQ+JdDTB+zgpHOSmDUNn/K+d8YKYWqFAgUVxQDnFnw2iwgxgImygmZj4DnuU6gqJ
         vGZxwjtHII5WBHuSkg8zn3SVVA+8TrCK9ICkpDMmQ5Zoqy6PTLEwWkHbTGZeA+ITaSxq
         8AHg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772063699; x=1772668499; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+d/kouLLf9iKHdyjkzWOU+gVjFz9R5tJbv1KqoUtQs=;
        b=umPDzo0SLBwcKRFMnU03dfA+ANM/s9+zY/ZhJpiwjZ4+R87EsHQxE/i7+ILwxzp6J7
         QeKCRdW5hcdGOsYi2hKX1X8DQRG3V/SCDRfT+IsOFhwMejfMGZU+Pq7FY9vc/Ip4scwy
         fWKer/MkPUdBcrOq9dC8w33oxtlb0RtgKdIjax33NK1HNjqlRL8RSOQmt0HkFj29tykw
         25o04yN75E69OeZTo7S8ug/yJW83frO5ryrmXeGIayTKw46+rzKM1rEvJsAj7UdtiKHb
         ZiJwTUerWKHSbowQkzHmD/apoYHC0xv6RYFUKqkGg1DAe7L2ek+c3gOPJqZC3CCkVV86
         gTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772063699; x=1772668499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/+d/kouLLf9iKHdyjkzWOU+gVjFz9R5tJbv1KqoUtQs=;
        b=i7HkgfOI9vHRu7Z+Au/XD5Egk7Wm0kibH+IZqqxtTKZUcVIJT8Z7M+3bLPQ7VhxsJO
         we13Bq5jXoDsGAfXhXiRHzib6WnhsCWaLXPdtjHszjRlXuCo56LqfNtilzMtdua2GqrZ
         RXEhOdNhTUaKDdXSnmNTZAwXkAh1mZchWYSAHSpgUf4tAsWMHgtMimtcZmFREepl4GkC
         PpKuYsGrShn46y2dKQ0FG0+MnW9WM6t0MmpnyuGp7dUQDADRkKgzhfGGr9oZC6V1vRLY
         w9eGi0WDCF/pl4mAsJQcIPnVIUCZ/Zo7DdmMu/1atOVFaNMP4Eyn3M2d0jkaUkHNU/5K
         hUkw==
X-Forwarded-Encrypted: i=1; AJvYcCWbeDlugjTG81wnqvZX6c0F29qFdqBmZH2Ca/ItLrQq49BEBp7bsT2J5khBN5DoeDWOki7X5g==@lists.infradead.org
X-Gm-Message-State: AOJu0YzqutP9pqIiKUlVPkkHJDiyBQEs7y2edkZGsh6c9+uSUjHiuUdT
	kDPVHQ81MtJlHJvUt0fSHQ4dKN7DB9U32cvGmipvaDXnzpcvC5NydBOrjD+oG4OhBV6HnOcVVam
	deERYM4HqWeiPu9yYvxAYFRjABZZ4/mQdreKxkZa2
X-Gm-Gg: ATEYQzy4y/2vWidXFFgSd//Pl8LbXKFWc/PKF+M0752SvwPJuRpw5l1hseQdEXpLisH
	d1zBxd0buAKOU/DH9WSC4I4skkdxj9m0sxL8RDdCfSkNeZ8CINTVjAT0dbPBWqnjMnEhnvjMU80
	8TAX4M7LdTLYgLGQwCk6IAy6/ch7yr770FnTj30WMPctyXUfKCjDUkeZNb0YjqlhQK634o5tFPk
	LerwvxfLh6Pex727BCo2imQVGSjZiw1sIdGKzs/9aPkTPL2lhF122m4ariaP4QRrmW87AL98wJL
	wciWLxvRhnyrlp0F+Gj+6Jx1vsLdcZb/yfUG8oHY/w==
X-Received: by 2002:a05:622a:4c:b0:4ff:cb25:998b with SMTP id
 d75a77b69052e-507441e2d95mr4895751cf.12.1772063699005; Wed, 25 Feb 2026
 15:54:59 -0800 (PST)
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-5-dmatlack@google.com>
 <20260225143328.35be89f6@shazbot.org> <aZ-CnywNgMnr6f1k@google.com>
In-Reply-To: <aZ-CnywNgMnr6f1k@google.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Wed, 25 Feb 2026 15:54:47 -0800
X-Gm-Features: AaiRm51g4hX409PKMap5bNDNnG0XAykqCRndojsQbHHI9mzip6hP9-Z2S9ohyZI
Message-ID: <CAAywjhR4Azqx8hXRap0eLUrwetYRiX8TALEM=b+1BorPc3eJdQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/22] vfio/pci: Register a file handler with Live
 Update Orchestrator
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, 
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_155500_864959_D01D6CF8 
X-CRM114-Status: GOOD (  18.27  )
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

On Wed, Feb 25, 2026 at 3:15=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2026-02-25 02:33 PM, Alex Williamson wrote:
> > On Thu, 29 Jan 2026 21:24:51 +0000
> > David Matlack <dmatlack@google.com> wrote:
>
> > > +int __init vfio_pci_liveupdate_init(void)
> > > +{
> > > +   if (!liveupdate_enabled())
> > > +           return 0;
> > > +
> > > +   return liveupdate_register_file_handler(&vfio_pci_liveupdate_fh);
> > > +}
> >
> > liveupdate_register_file_handler() "pins" vfio-pci with a
> > try_module_get().  Since this is done in our module_init function and
> > unregister occurs in our module_exit function, rather than relative
> > to any actual device binding or usage, this means vfio-pci CANNOT be
> > unloaded.  That seems bad.  Thanks,
>
> Good point. So a better approach that would allow vfio-pci to be
> unloaded would be to register the file handler when the number of
> devices bound to vfio-pci goes from 0->1 and then unregister on 1->0.

Yeah maybe a kref that gets inc/dec in probe/remove. I have a similar
problem with iommufd preservation, but I think I can handle it based
on the number of iommufd open.

I am wondering whether this file handler registration kref stuff can
be moved into LUO by adding it to LUO file_handler and the modules
only call get/put?

