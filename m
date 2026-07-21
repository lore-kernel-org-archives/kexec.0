Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1B6C44536
	for <kexec@archiver.kernel.org>; Tue, 21 Jul 2026 16:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6IIRL+XPWpelEfDBhGxVOXyFyatQ6xSvU7ZF4RnBpbA=; b=r4C+ySbUKk836pzZqjQ1Ur2W64
	FjmPRg2Nd9TsVkCJ8Z7qZe9tafxa8739/oqsnNcMjhVVz1qnEDZ9xBJ5Dg3aZcznWQda4PUu9IBS9
	ReoQHBRDaLSVGoPKeDR1D2WsmWHXjm3yGeHLF5v0ogwJSYZa7OHNTu+BYmIWctczJL2W/OHkjh8X8
	GWpHCOfOJeDPsf2C3EXuWkcXuUH4LDSJhkTlut3CPW8Fd2noKqnj3UDcwFhUZ4Dpsvkt+waDG3RUk
	DRf+rAAYlfDKQbXwAmyR1rE2ly4grCrVskloHdq3Zx4aANDDdwJSIVV+hNxuLxLdvgaX7vcO4FjD8
	GBs29jTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmDGQ-00000009tDN-2MM6;
	Tue, 21 Jul 2026 16:24:14 +0000
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmDGO-00000009t72-0Imu
	for kexec@lists.infradead.org;
	Tue, 21 Jul 2026 16:24:13 +0000
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-5b2a73da7e1so5603e87.0
        for <kexec@lists.infradead.org>; Tue, 21 Jul 2026 09:24:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784651049; cv=none;
        d=google.com; s=arc-20260327;
        b=EifLn4hKNJlzsrV9FwhgBhkgiltdmZdz6yBfSMIs8sAQkW/WyVdFEnt9IFOJWseVoJ
         IZoJxUFPqnsJaRwbIpU+dip5rMkP19/DwXdJcjyDvLDIDgwpyu6s59wVAVHL73QpnzDs
         VkIaoK5SBx3mq7YhZgxCYg4RdTYQIraVwYO0ofQCtPo6qNAYs4iyqJ1T6Rj1gKzgz1Oc
         bxh5q5wD0n92MIjIV4GhaGwAOBzquWz05FGqiI/UXWIxCYlu6d8FCclRIvvari2kE90U
         DB93ZjG75QJS+Evc6hYKrlO/CVMtU6OXz1ZOqKzOH8TqBgWgmnccZ0BcXYqhQakEIn2R
         6GRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6IIRL+XPWpelEfDBhGxVOXyFyatQ6xSvU7ZF4RnBpbA=;
        fh=BDGanTXxIWi+/GUYBjyvH7HK3U3XFVpZOTbX1ls4Jh0=;
        b=nMU0ZhRVt4c7A/7zo4Np/BCf5AY2EHVzeduysMkymihKajTuL3pnNMMMsLkXzB8L/R
         YJK/KNGNLAdhYShZMY0YcTxN4xan91uLBMo+z/a1Kzt8uEXeeKIGpk4s0WebSZykihJH
         aHUTLkFOstvfuvEsWm18+G994vA87yBl+EGMJZpRvWqwwwONz1DYSIdf/VraV9ZR8PQv
         X2e+myHTTLxEy4XIx62BUT1iGzUi3DMG9V9VCJsdPNBL4JyXkWvDzz9a181guH14nh7d
         rbss4s+lCtcyMwL2P5EfyRjZM+dI10Wz+YIznej3V5FpeHwV9YY0dhFkDJJIkM3ggSDt
         igmA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784651049; x=1785255849; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6IIRL+XPWpelEfDBhGxVOXyFyatQ6xSvU7ZF4RnBpbA=;
        b=QUCF6ogGhxKhVzN9Ngq8JDExuSBP3k+KAg7W7XuwBS2wdis5mzZMxbngDcHSQzrO1E
         hB/Hb4zBqxI6pwkxMc93YBUV0qVhampOLAhRUlqp5s/zX68qtkvdM1W/Z78IXjeNfHjW
         wQifrYrTFOk8trKFIcp59nflaTZOL2aR0YeGPdC7g4MGlDbHtpKuEabKP1ORcimADoPj
         T1Hi965G8/3R8aLNSGqjYP8PrxP0NO/Swd5+okWqdpevdFws2dMYRUZUrJecoKVtfb2s
         T/8sJvCXXK2LvxOAK5F+E3PlW+F9STZGtFes9aIWVQdcSEXD1KaRxDqjC5L8sh6aQTkv
         NoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784651049; x=1785255849;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6IIRL+XPWpelEfDBhGxVOXyFyatQ6xSvU7ZF4RnBpbA=;
        b=Y5q1xyhB73E0XVmvtbDofOaYQR7huhXCV0bGflnb2BrYZsVid4imy5KcWeYYod8wiQ
         Z/A9zFZNSeqmvHAHkjFkOcDswFm9k7dgCCSHVobG5LHUv2GltiHcVwMx/GP2zR1O7Ij0
         K1wHzP8sbdj5aohWAe43BWIfHLt4W2Fy5tzzBK6VkP4D1OpQN6PMSpk+hWXOlCwxEd+1
         tCmp8mJPDsJSRJtd4TMzQw9VkiTBjRZs8dLZCMzZcLH1E7M61GgOeM+dKArZHLokk43Z
         TLewAaYsTP82DKnSYfTbP+bc0lRYH6/ON0EoZSUaLryqazYysboL8sso2dF0yv0KhHgK
         pJBw==
X-Gm-Message-State: AOJu0YwagngPbl9okqNhBZiBh927GHrYvABkTtegyrYm25hYATbQ/WO8
	gZbstEiSWNQ+lgZv3xu2GhqdUPXfBfXLco2JDCgqt9xaOHO1ll6N3ggcraBLYYB2yc/Go1FHbiX
	Fc1v99hOVJQ4J6IIrdaWbixA95HQSlzo8kh3HkVs=
X-Gm-Gg: AR+sD11J7pj56df3tXZsvJNjh04HhaQdxKUR9csCIHrN9fYs2AhfDTqczxHZWLHZzgS
	pkFABGn2dNjMYOwAHXuiqpdpl51nmhU2o7cCA8hWmDMTllndL3dxN5AyAx2JIVYCiA2dgntDpdA
	IIBTbO1b9H+6kxPVKa3EXoZzAtLjY1KOgi4xY39Xn1f3Z6X/y3G4Vy1nWUo7DSS7rIDjoYsWrwj
	eiuQCQkF0NXuFm43zGT7idnqA1d4YZ7GEoGTLKmzG8FRLpx7xPHQRFong==
X-Received: by 2002:a05:6512:ba1:b0:5b1:5141:9156 with SMTP id
 2adb3069b0e04-5b2a31c4862mr327591e87.9.1784651048492; Tue, 21 Jul 2026
 09:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260714151505.3466855-1-vipinsh@google.com> <20260714151505.3466855-11-vipinsh@google.com>
In-Reply-To: <20260714151505.3466855-11-vipinsh@google.com>
From: Josh Hilke <jrhilke@google.com>
Date: Tue, 21 Jul 2026 09:23:57 -0700
X-Gm-Features: AUfX_my4kAQgnpjbhryasf2kLrfrl2S4l9xVYW8Rn_Ur_MRpX7wHXzL-Nzt7PMM
Message-ID: <CAAdrzjsEG2DQoQbNe4aeq8gNF4Td+N6_gTifU6=EzAEuySu7PQ@mail.gmail.com>
Subject: Re: [PATCH v5 10/20] vfio/pci: Retrieve preserved device files after
 Live Update
To: Vipin Sharma <vipinsh@google.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, ajayachandra@nvidia.com, alex@shazbot.org, 
	amastro@fb.com, ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, 
	chrisl@kernel.org, christian.koenig@amd.com, corbet@lwn.net, 
	dmatlack@google.com, graf@amazon.com, jacob.pan@linux.microsoft.com, 
	jgg@nvidia.com, jgg@ziepe.ca, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rientjes@google.com, rodrigo.vivi@intel.com, 
	rppt@kernel.org, saeedm@nvidia.com, schnelle@linux.ibm.com, 
	skhan@linuxfoundation.org, skhawaja@google.com, vivek.kasireddy@intel.com, 
	witu@nvidia.com, yanjun.zhu@linux.dev, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_092412_142312_9AB21BA3 
X-CRM114-Status: GOOD (  10.65  )
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

On Tue, Jul 14, 2026 at 8:15=E2=80=AFAM Vipin Sharma <vipinsh@google.com> w=
rote:
>  static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *=
args)
>  {
> -       return -EOPNOTSUPP;
> +       struct vfio_pci_core_device_ser *ser;
> +       struct vfio_device *device;
> +       struct file *file;
> +       int ret =3D 0;
> +
> +       ser =3D phys_to_virt(args->serialized_data);
> +
> +       device =3D vfio_find_device(ser, match_device);
> +       if (!device)
> +               return -ENODEV;
> +
> +       file =3D vfio_device_liveupdate_cdev_open(device);
> +       if (IS_ERR(file)) {
> +               ret =3D PTR_ERR(file);
> +               goto out;
> +       }
> +
> +       args->file =3D file;
> +out:
> +       /* Drop the reference from vfio_find_device() */
> +       vfio_device_put_registration(device);
> +       return ret;
> +

Remove extra newline after "return ret"

