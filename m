Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE60F54AD9
	for <kexec@archiver.kernel.org>; Tue, 24 Mar 2026 16:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UCikAyXiicm5k2VXyH9xrW1vWINN0uWZrBsYrIEp9jQ=; b=3AtT6O70gspFNh46jckoTpCNPT
	8NSlq1h7hqt5Yz4lTkFt4UHuHZ1FGoADp4YcJaYeQC38afNOc/EbTudm4upeNGADlA9upiR5xrkzd
	C7TweiD9DV8y6S1cqiJqfj8m38oz5WTz71FHGUFrfMdcvuTKlDlXqq2mDZsPvuuXc9o4xqSxEaRg7
	pc1h2Tu+wEQxH2u0GqUiHhDn3RuCmziJbdMyf5beIkFoPdKOVYkGxnV2tou2hBj/ZkNglPZEmsplJ
	eGYkFjaE+iYYTU+DPAebOyUwPcibg3yGkwNORCMi5EcbGFpg4tMmcr357Lpodj8recbIOODEX5w4b
	gftKC5Hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w54to-00000001vTG-2p3u;
	Tue, 24 Mar 2026 16:46:36 +0000
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w54tn-00000001vSb-0lam
	for kexec@lists.infradead.org;
	Tue, 24 Mar 2026 16:46:36 +0000
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-389f9895c81so14422191fa.2
        for <kexec@lists.infradead.org>; Tue, 24 Mar 2026 09:46:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774370793; cv=none;
        d=google.com; s=arc-20240605;
        b=PdJcFPPJQNwawnC7Lg/WRdcm4UFuMaKlLfNa31M90QA73gF8copmKauuLXqrMsA0hY
         8TRr7SL6vZXOOSPtVdKH1/4aQtSBjOe0enG8aEUj2TQGqJ4L+MfnwMlsFyoacqi5v0ZR
         XQHzMfA7paP4AdziJAv85I90U4WjWzZs95qNDk8zYcCo0vFS9jpy2H1vDNTu/QoCyVbV
         ph0AJoxo/8g6KzrCW5MDzvkS/9Y4Twoehz5qZpRtNkgILulJw8Ojv7GTcEOXOUqy5bjF
         3UqTEkCxAumc3elpZ9jk5PyMCLSc39+rDzn+Id2nDCieEUYfAWpogjfskDxd24gbYzqw
         BF2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UCikAyXiicm5k2VXyH9xrW1vWINN0uWZrBsYrIEp9jQ=;
        fh=7w+znsiDXWY6EPGY0gamd42VpC+x40Ep0kAJR+uSkY4=;
        b=jRsmJQpY1xsFGrpOUTgHQkSZn321gEChsCdOCF56p9gaX+/wJ75NhzalvJPjRCLOjN
         O99GOuIM/i2pXzOq0xOzVK/hY/r1F0GEr7iQRMkrxAqiU1FquaqU/GjCbYwBQEvHfN0Q
         N0xy+OVkonb1TPFTDAp+/6/kqik57eGW25hapO5CS6MgTL9PV8/l30xmC5MVwOsqFjJf
         7LdZETYOIPRyr8nRAxm/oNNXRJnEXMEUoyxEaaGham0JhYt5k4LJxBKMMAWfeHdWdjot
         R+PP9Iy9gTsXc22mOjdtYH+UeBgxnOp8YBPd22F4E2vO0QMrk4Vq5agIZPGYfZLzTRbA
         QnkA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774370793; x=1774975593; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCikAyXiicm5k2VXyH9xrW1vWINN0uWZrBsYrIEp9jQ=;
        b=M8WGTSlOxVqmlxtowEoFyhnPf9HESwAsm0H9ZgtXYlGMLU8cNtRuiq0SRaJ5pmUdvs
         lo6JpqnNAVcOqqFyck8rt/ZzAddmedpz0bhnxHg95/czfw4Ohp0NODtY58Qtt0G4t/lc
         TNIWdpodwiT+2p0vH5VF/pCVrz7T3wwJvssvfV449UtyqEmajf1N0vlg82m2wRjQnzow
         ZO7+I1/BGRe90i48+cTX23YH1SNKgl37L9vaUUL+orS9NkVaUm0Wd45WaV1a/w+dbBF0
         usI8Ag8uw/TdkslsP8nTURY3YFK+iNnzkFlfokCX7dCXvxWNrClKWICEmGc9wp/d26HS
         FqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774370793; x=1774975593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UCikAyXiicm5k2VXyH9xrW1vWINN0uWZrBsYrIEp9jQ=;
        b=b6+FgogXiqZVBIl5UI+OhTMSk7hv1hPmSpzL5rZR6Y/jtAp/Qyd6fRRbe5QpGhpLEq
         uUPBPSjJ/FsFjdTGV7f0+tEZeXaJszE7+WcBL8MpZp5seZNSwIlJ/+e4McOQvhoeHbzL
         ihScYSK978z8IOK3DsxgC+GvlUQI6qtvLSvhFI1xqH9MBtePhdyNSFz80LtYuHBo1TEK
         Tj5r7gzThHMSK0oM7jPCondc33barzmSjWclw5mSQPWRyJPDys6Sg1pmGD35sSuBmwgQ
         NluAGBZPqL82KQdEVW9SbNNHFx1MpYCcYSUbuPD+fqK2qdkrajW/kqN8/wAbmGEDoS4+
         YUXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyvgY7SFfdFlwBBAinjvJmJORBShtVX++IKHJzYQVnS0L63kQQg2Mbqq75ln61fefyX0z75w==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy3zSwEjq2xdLc758lgfU7wyu+TI8RoR2pUxqS/wAZJ8oxxlwWk
	s9AxS5H60bWpDmt83MZ3uMIk49VdEufgVJTcWSclmZ6LY5rV6gMeOezufBx5gnfpW7F8ny8m2jU
	97NBGB72VA9bpaPlD9dFzqeia5Sl8QYLVjfqUJb67
X-Gm-Gg: ATEYQzwT7kDUEMG24b89Gk4UJfKXW1bgSB6Vu57CByXwtHaz3aXhBROV8XsN6pjRxEj
	lQlWynlsBcSHF2Sqouu9/jSuWaZdpDikYMh9EJDzovDMvjeyVrfW9ixFo/e2YO/t4E2RJE0Ig5l
	cQ47RU6YZPAAg0GGHo8uKOQN2t86ziPBHBk56nIY/WT/MVnHwCQ11hho6SHxFnvY5EJ+9b446QK
	vvOLeRB6GLZbrepRmhvW3ddVH1zjgA2TaYZFLrXUjjOTeafP5o1qSwS5y71S/gwhWOCb6Y1vm1Q
	s6RVfmaG
X-Received: by 2002:a05:651c:198d:b0:38a:45d6:c246 with SMTP id
 38308e7fff4ca-38c4309f785mr403821fa.8.1774370792285; Tue, 24 Mar 2026
 09:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260323235817.1960573-1-dmatlack@google.com> <20260323235817.1960573-8-dmatlack@google.com>
 <df5dac48-8a54-49e2-acb8-9370b7078033@intel.com>
In-Reply-To: <df5dac48-8a54-49e2-acb8-9370b7078033@intel.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 24 Mar 2026 09:46:03 -0700
X-Gm-Features: AaiRm53x8nRAyhq72BKXQ8vBk2jNU8cpC5QwT_5hu3qjlEbsk36YMzg6v1f1PaQ
Message-ID: <CALzav=cGzzZTL-tyaaG_AhC3gP7ULiU6hWS=X6joLTjyoo-6sg@mail.gmail.com>
Subject: Re: [PATCH v3 07/24] vfio/pci: Preserve vfio-pci device files across
 Live Update
To: Yi Liu <yi.l.liu@intel.com>
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ankit Agrawal <ankita@nvidia.com>, 
	Arnd Bergmann <arnd@arndb.de>, Askar Safin <safinaskar@gmail.com>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Chris Li <chrisl@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	David Rientjes <rientjes@google.com>, Feng Tang <feng.tang@linux.alibaba.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org, 
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Li RongQing <lirongqing@baidu.com>, 
	Lukas Wunner <lukas@wunner.de>, Marco Elver <elver@google.com>, 
	=?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Raghavendra Rao Ananta <rananta@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, William Tu <witu@nvidia.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260324_094635_254884_18D4BE5A 
X-CRM114-Status: GOOD (  16.87  )
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

On Tue, Mar 24, 2026 at 6:01=E2=80=AFAM Yi Liu <yi.l.liu@intel.com> wrote:
> On 3/24/26 07:57, David Matlack wrote:

> > + * Usage Example
> > + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > + *
> > + * VFIO PCI devices can be preserved across a kexec by preserving the =
file
> > + * associated with the device in a LUO session::
> > + *
> > + *   device_fd =3D open("/dev/vfio/devices/X");
>
> /dev/vfio/devices/vfioX

Will fix in v4.

> > + *  * The device file must have been acquired from the VFIO character =
device,
> > + *    not ``VFIO_GROUP_GET_DEVICE_FD``.
>
> how about "The device file descriptor must be obtained by opening the
> VFIO device
> character device (``/dev/vfio/devices/vfioX``), not via
> ``VFIO_GROUP_GET_DEVICE_FD``."?
>
> just be aligned with the below words in vfio.rst.
>
> "Traditionally user acquires a device fd via VFIO_GROUP_GET_DEVICE_FD
> user can now acquire a device fd by directly opening a character device
> /dev/vfio/devices/vfioX"

Thanks for the suggestion. Here is the wording I have for v4:

  *  * The device file being preserved must have been obtained by
opening the
  *    VFIO character device (``/dev/vfio/devices/vfioX``), not via
  *    ``VFIO_GROUP_GET_DEVICE_FD``.

> > +#include <linux/kexec_handover.h>
> >   #include <linux/kho/abi/vfio_pci.h>
> >   #include <linux/liveupdate.h>
> >   #include <linux/errno.h>
> > +#include <linux/vfio.h>
>
> maybe follow alphabet order. errno.h would be moved to the top first.

I will reorder errno.h to be at the top in the previous patch (where
the alphabetical ordering issue is introduced).

