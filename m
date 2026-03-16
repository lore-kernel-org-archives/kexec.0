Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1DAF53D78
	for <kexec@archiver.kernel.org>; Mon, 16 Mar 2026 17:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VjajILnhW/iAqqxkTb08T/Hii8IQWi4dcNUVIU2+S2M=; b=ryaTqHanyw3aAz1yqbJJa4thWk
	VxBloVVNVRqifCZmj3wXqxIWRV9vde7ZSG9Au5GTcpmc6tOSs5P/suquTMhCynwy93eVgYNzWCHi2
	66yVV2caTEPTN8ILRNYT4VA9KrPK3wt/5Wk3QDGEk8n6pgddk1ZFj5KVSkJED3wqVzWg2jOt2Oj1Y
	Gtk1cocrIH/TiKFevCds2hL8Tkh2R+e4WApur5rm/a7likf92xhreMk8F3lCp0g+3Nl3BXE8AYRIV
	kVCdQRQu/SrxSr+N+TI4KhZbhzjPg8+dbC/DSjs39im9IwjpuE8C7ccMwnCDwuXUjWcoE1WaNL+ca
	DZhBPx6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2BSA-00000004Vhy-3OFU;
	Mon, 16 Mar 2026 17:10:06 +0000
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2BS8-00000004VhT-1290
	for kexec@lists.infradead.org;
	Mon, 16 Mar 2026 17:10:05 +0000
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-5a140efd2d5so8761173e87.2
        for <kexec@lists.infradead.org>; Mon, 16 Mar 2026 10:10:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773681002; cv=none;
        d=google.com; s=arc-20240605;
        b=UISNuDuirdJnxo5tbDHKClnZ0b0rY7TR7rTitC6vQCOlgVI1+RXpFWUrcBQz7lpqhV
         i+olp+XZA3Asyc3YRkPDEde4wwhImGeK4yqYcltCK5VfP05EfwzukZ+M6U5lfYldK3ZE
         clMej9dhiNXlw8TNdu0ujxzupuQpn2ainTgPv2VpuUF5cQkEhRM5kYkjDb3eB1H1ghmI
         6KlEep3+7/2pio+TF6wUOtFmlXdpxDQlG19R8WW2OjfsdEiDoMhzB3ObxAie/LePOCro
         V5fvmsXP5j0nvqrhN/AP6yNaqNAGHU5bq70o0peGXHdZNQBpMXGqnsQs+pIof4E44PSr
         Kvxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VjajILnhW/iAqqxkTb08T/Hii8IQWi4dcNUVIU2+S2M=;
        fh=7j/F87rpkgQMM2JTGkcjQl62q1SAr6Tso4sZn9DYpuQ=;
        b=Z5vj+uPWbsTRQVk/CU1LThZ0Thn0jPLrFRfLKL3DvCJ5nyYvkU30h3Y5/N0DUzEcIG
         a9MBZjvEQ0wLCNl7JBVIpcQ5xJ58bp9ahI5dvhWOVZYdDo65D5EoB1B3nY48IpTXlabe
         bma6osGYung1HAt8X73zAielHneWQ62j33o4iJ1oTe4mTpopQec5E8imdbHYBmtdFmQf
         84Leyi4tLxH4qwclzKcOxxK1SJDv72c3076vNhY1PoazPaZ8Kyzs3W+dpWVAa3+BXxeD
         bKXeTb4RX2slAo5IezHcs2sdaJpJdPJWxmNklFjTzEfgxvUGX0UhSRQuwWQS/m96BMuy
         mCPA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773681002; x=1774285802; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjajILnhW/iAqqxkTb08T/Hii8IQWi4dcNUVIU2+S2M=;
        b=QqMVauwvSa9N72aQUF/sVmml5Y67ketsBa3R3e8PSJ6Qx32TziRgTDDgnOxx7+Btmw
         +nPhZ5xX1nmJ34q9N89uHY0EuPmoi5bjG0LqIwbaeOokR878nSSZjtUpJC4seISVSY71
         8s2ZenKyqoMsRC63X6RriXO+E5AgjTRzajg0ZDY5Tid6G1JFLafmyiDgI/h4kO6HdL3m
         mBocMrcGNXYGTRNt6P3tyznhSp4mjLWDKVjSuRIxu+x0ig5dMbwIs/ClBB6alXVMK3M1
         2XROFfl1GTYWOXHbA383t2wu0kw3ggjzohyXWZIjjQnt0vFm7fvA/yimzman6E7YwA6v
         TTUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773681002; x=1774285802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VjajILnhW/iAqqxkTb08T/Hii8IQWi4dcNUVIU2+S2M=;
        b=XB90G+8MoUomQ3f2esE5VlZ/6+5v+TrRpdYMRQGsuMSciSjP7k20VBeJQ1/1nXdDp1
         Cm/llbWO+pWLxPfAAiFoCoW5P74g0qgEifDNRYQraHvO2J1cpoD4DzNePg78CtlhdOSV
         jbXBUgElUX0jdNfG3ngF7ufkwn8up1muM8hN0gPM/6KvhV1FmtfbrYHrojfrWB63I3yk
         Kf0IKK0hK0Ubu4C3jbheoLwRYkS1KvLz/SbqPwYRSh9e5++Y/CmX9B/ugCrh8gnp15cV
         jxB8xXPB/OMUVquqd/3qgpaz+878FlNxMQSxjsQMrEHOEPEg1pkfL7ImhrEfbExawpce
         tsTw==
X-Forwarded-Encrypted: i=1; AJvYcCVIDC9z02HLii+s7JsFiRdpFGiIi+0mSkvvHy8immRWPtVTvv2a40CrODoNMLWLX1qaKwPAXw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy7nI5atqLFlPe+5cQ/krBrPXKyPTf7WLd8NeAJq1bYbsqzMqdd
	GN6e9I8G0+UGox8tbmmjetJJ3MlVjRRyOxolgcrWNkv0h2zkwoKkF/CBZAKuNjGTj+pKaRnnBAa
	091ETL6EUrBrjgSarPdEqkJQCqHtXuER+kkwoaO9y
X-Gm-Gg: ATEYQzzunY0lzJ9ST8o7QJp0bRVqjNek6c3Xo50MG8cndgRsLpw5g75FyKRzXfzslLK
	H+36T6Q04OcHjpQIWlaSmcp7e+B1gzMuqESihGpIgaOpGC8rJrXiXzstkLWzaggTmMplYyS3Ghy
	0eSvScqoWWraPSplb3IH7Xkw8NkgkDUkkjTEZICIDZVaRaFXAflw1ZZQS7DfO7E/9modoIP3d/L
	t7rwVd2UM/eGm6w4ObSM0bLkaOv36Yd+HtsH8L6N77PvcG+EQ5kebMSLGke/yL7MZ1x73u3bXKs
	9Vidzgecs/Pt+luvWF4=
X-Received: by 2002:a05:6512:145c:20b0:5a1:3207:694c with SMTP id
 2adb3069b0e04-5a162b0c23emr3396226e87.29.1773681001667; Mon, 16 Mar 2026
 10:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260129212510.967611-1-dmatlack@google.com> <20260129212510.967611-17-dmatlack@google.com>
 <20260314073250.GE4177610.vipinsh@google.com>
In-Reply-To: <20260314073250.GE4177610.vipinsh@google.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 16 Mar 2026 10:09:31 -0700
X-Gm-Features: AaiRm539MAtTSlMtJ9cZiQMw7S77YkLj3Qx3YTaEKJUIvtilcVTIw0VDB1yQ5S8
Message-ID: <CALzav=fWmv_+BACzTLq2Nj2aUux575EnbLRwJTevH4aYZTXycw@mail.gmail.com>
Subject: Re: [PATCH v2 16/22] vfio: selftests: Add vfio_pci_liveupdate_uapi_test
To: Vipin Sharma <vipinsh@google.com>
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
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260316_101004_313064_C367F989 
X-CRM114-Status: GOOD (  13.94  )
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

On Mon, Mar 16, 2026 at 9:05=E2=80=AFAM Vipin Sharma <vipinsh@google.com> w=
rote:
>
> On Thu, Jan 29, 2026 at 09:25:03PM +0000, David Matlack wrote:
> > +
> > +TEST_F(vfio_pci_liveupdate_uapi_test, preserve_device)
> > +{
> > +     int ret;
> > +
> > +     ret =3D luo_session_preserve_fd(self->session_fd, self->device->f=
d, 0);
> > +
> > +     /* Preservation should only be supported for VFIO cdev files. */
> > +     ASSERT_EQ(ret, self->iommu->iommufd ? 0 : -ENOENT);
> > +}
> > +
> > +TEST_F(vfio_pci_liveupdate_uapi_test, preserve_group_fails)
> > +{
> > +     int ret;
> > +
> > +     if (self->iommu->iommufd)
> > +             return;
>
> for iommufd variant, should we mark test as skipped instead of showing
> it as passed?

Will do.

> > +int main(int argc, char *argv[])
> > +{
> > +     int fd;
> > +
> > +     fd =3D luo_open_device();
> > +     if (fd < 0) {
> > +             printf("open(%s) failed: %s, skipping\n", LUO_DEVICE, str=
error(errno));
> > +             return KSFT_SKIP;
>
> Both can be combined using ksft_exit_skip()

Will do.

Thanks!

