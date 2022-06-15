Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855FFC433EF
	for <kexec@archiver.kernel.org>; Wed, 15 Jun 2022 20:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cXya4xlhUkeZRToGe95Ogk4IJr2gjDxoWuex7axfaRo=; b=HtjU6Qtx75hZYX
	899zjUpy/aWzWXkKHi4jBlnrG7TwoZJ/cu66FzsoCpsYDkN8n6vizaOzw1vSGAKo5RkMFSCJUoHxD
	LJJFGgFYzpNlgw3bbiw5BHD0GXe/WHLhTePhUr6iKwfluM1g6bAcOC/FNWOpYv9vnDx+VqlTeIkPZ
	oXGUZJwC6+gmbipjqts/3ZilS98/bLlsF8PKCvokkCTPfQJd+COhL9YYH2AhTB9g3EQx/Nv7giu0n
	9lFNeGtOoxbv35sVFSEt/3JB/sYQHCMnVFfTGF1mZ4DJFM6sdJgNmXya4pgvO1CLM7KkXUFjvb2lY
	fTYe5zujp0Q0QVe8jfqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1ZTQ-00GE51-7v; Wed, 15 Jun 2022 20:18:44 +0000
Received: from mail-io1-f47.google.com ([209.85.166.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1ZTN-00GE3Y-50
	for kexec@lists.infradead.org; Wed, 15 Jun 2022 20:18:42 +0000
Received: by mail-io1-f47.google.com with SMTP id n11so13851625iod.4
        for <kexec@lists.infradead.org>; Wed, 15 Jun 2022 13:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xQh+eTwTpmaPBadAs7RFq9z38Ba2vaFoSOGMFjdUoUI=;
        b=zn7fbTwXaoDiQ5vmRbfuOrawO6x11c5GM3GtL21Lkdi746J8XfGkcM/fa3K4MFN645
         yqgBEn0V2eOXh4hqABFA6GOCwgiRAWmB5yvNDZxJKyOJHf1sKDrWeHvJoOYwF6FQsayZ
         wSDrSR7irlSxrOF0T7K6UiHPPlxRH1mLzuLljg+xP4Ob1g3cjwKcrNj1Lylq86k1NNom
         zzodMioGPlCgRLa3dqWBsAJUwOZSaMTqrMqxJQdkUrAyJ+bf/CnutF5Yxt8+9hdfkGSd
         P/gBLHFtST5445YwWXo2caVrdEcRStpq0up4RlzEPF2dJJPxyG9tGBAax8cZ4AGdHwhX
         oLWg==
X-Gm-Message-State: AJIora+k3H3VIkwZoT+oJi1U40H5TFxHlQdpO68Dc28umuIU5o149eio
	iA3Iz0ZluCsNnfQTzkjGZ6YClKDMsA==
X-Google-Smtp-Source: AGRyM1vQzvutwoc1umkK9GLIslUbs5YXYG/HUfAQts8IDiFqTuJ5brxnfo7A8Z1wYlqwjLFA8zaznA==
X-Received: by 2002:a5e:8a44:0:b0:66a:2699:df20 with SMTP id o4-20020a5e8a44000000b0066a2699df20mr717743iom.205.1655324319349;
        Wed, 15 Jun 2022 13:18:39 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id a21-20020a056638019500b0032b3a7817dbsm6584499jaq.159.2022.06.15.13.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 13:18:38 -0700 (PDT)
Received: (nullmailer pid 1740660 invoked by uid 1000);
	Wed, 15 Jun 2022 20:18:37 -0000
Date: Wed, 15 Jun 2022 14:18:37 -0600
From: Rob Herring <robh@kernel.org>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: kexec@lists.infradead.org, devicetree@vger.kernel.org, Nayna Jain <nayna@linux.ibm.com>, nasastry@in.ibm.com, Frank Rowand <frowand.list@gmail.com>, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 2/3] tpm/kexec: Duplicate TPM measurement log in of-tree
 for kexec
Message-ID: <20220615201837.GB1525994-robh@kernel.org>
References: <20220614161258.1741427-1-stefanb@linux.ibm.com>
 <20220614161258.1741427-3-stefanb@linux.ibm.com>
 <CAL_JsqJG4MJHeu+7Ar0jWi-W6P01_EFtwiz56m_vtVy39uMtiw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAL_JsqJG4MJHeu+7Ar0jWi-W6P01_EFtwiz56m_vtVy39uMtiw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_131841_227484_173B1A2C 
X-CRM114-Status: GOOD (  23.16  )
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

On Tue, Jun 14, 2022 at 11:48:30AM -0600, Rob Herring wrote:
> (),On Tue, Jun 14, 2022 at 10:13 AM Stefan Berger <stefanb@linux.ibm.com> wrote:
> >
> > The memory area of the TPM measurement log is currently not properly
> > duplicated for carrying it across kexec when an Open Firmware
> > Devicetree is used. Therefore, the contents of the log get corrupted.
> > Fix this for the kexec_file_load() syscall by allocating a buffer and
> > copying the contents of the existing log into it. The new buffer is
> > preserved across the kexec and a pointer to it is available when the new
> > kernel is started. To achieve this, store the allocated buffer's address
> > in the flattened device tree (fdt) under the name linux,tpm-kexec-buffer
> > and search for this entry early in the kernel startup before the TPM
> > subsystem starts up. Adjust the pointer in the of-tree stored under
> > linux,sml-base to point to this buffer holding the preserved log. The
> > TPM driver can then read the base address from this entry when making
> > the log available.
> 

> > +{
> > +       const u32 *sizep;
> > +       const u64 *basep;
> > +
> > +       sizep = of_get_property(np, "linux,sml-size", NULL);
> > +       basep = of_get_property(np, "linux,sml-base", NULL);
> 
> Any new properties need a schema. For chosen, that's located here[1].
> The more common pattern for similar properties is <base size>.

I noticed these are already documented and are TPM node properties. I 
was thinking these are chosen node properties. Though it would be good 
to get these common TPM properties converted to schema. That can live in 
the kernel tree.

Rob

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
