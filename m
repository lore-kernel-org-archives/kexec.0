Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF4BC433EF
	for <kexec@archiver.kernel.org>; Wed, 15 Jun 2022 20:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gIDKOXqXrt+9JNXBxCUiWhvYyeCzMM9gN2G/zPr96IQ=; b=IYZX574W7Y0aBC
	al1VHsWBGEGZw69I93KVbLnA7NvhmubNVEVp/9+M0aZU0In8h1wjtOT+CFgsiGEnoQ9RbMds0zQol
	WfbZRQ5eRE+Pxx4xeKnoMmvjNB7CrBbSflFebOs1ZdHyMnCChY7TgVVxaKitq8vNzwvyyHG5nAkJm
	ppu5nFDx0w1K7jqmV1FaKFqdeYaZy6cSGFcWsd+1cFiS1jP8tJAYTZOwetIbe7pohlkQ36MfSky7n
	t1FOIQTNVdS7zvLj1FlBL4kl1p8k/T4r4ICVrVWBBcePAdk4R4Z7zgTL45D5Jor6wDfHZ1E82RQfG
	DPqymL+ptrtxWE37k6QQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1ZPv-00GDIG-Lt; Wed, 15 Jun 2022 20:15:07 +0000
Received: from mail-il1-f172.google.com ([209.85.166.172])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1ZPp-00GDH0-0k
	for kexec@lists.infradead.org; Wed, 15 Jun 2022 20:15:03 +0000
Received: by mail-il1-f172.google.com with SMTP id y16so9541466ili.13
        for <kexec@lists.infradead.org>; Wed, 15 Jun 2022 13:14:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2mpz2IB3EwACi9X4Vw/oqbU5DFkBaY337tnk1NpetAU=;
        b=GN9UIRAc2XZWfi6KFDSSsL2BDpwsOBuGTQHH5yXYVihy+RYwhx0N9vIzhv5t7Yr1G0
         orUj0g+JFYQF99uq7ArbyD25Jd6tZJ3zJux0HKnf1COubTnB/qu+RUVR+eTucMobToQA
         0kvGKe1nxBXrH7FMkqjYV35OWVbqWJ0VLBPW/5r3l7g0+kireooaLyIKA3slMVnYnCBM
         vFmHayBGPMCsJiqM2ekmMDAWlqLdn0gHst38NE94bIBWTeVVFMsET2vAjZOVbVUt4aCo
         PLXTeYdMZ7BMv0qwEYzRuCbkf5s9eT7TbQgsiLVZRNEF4ToiiC5vyMDPddw0QPgKpste
         +tpg==
X-Gm-Message-State: AJIora9y3I5WvvvtBOkBb74uuZWMl1TicKxlIvTlx1pY4Zg/tFqM9Jeu
	/tfgW3kbnYssWxvRjMh3wA==
X-Google-Smtp-Source: AGRyM1vkopFE6p9qtbaHjAU8BTRDSrE3U4ohzcR0docaxf0h1Z0OdstljRmhjL0XbNMulfjUzWdyYg==
X-Received: by 2002:a05:6e02:811:b0:2d5:2294:ff37 with SMTP id u17-20020a056e02081100b002d52294ff37mr899453ilm.249.1655324095759;
        Wed, 15 Jun 2022 13:14:55 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id q187-20020a6b2ac4000000b006688c6802dfsm54106ioq.33.2022.06.15.13.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 13:14:55 -0700 (PDT)
Received: (nullmailer pid 1735698 invoked by uid 1000);
	Wed, 15 Jun 2022 20:14:53 -0000
Date: Wed, 15 Jun 2022 14:14:53 -0600
From: Rob Herring <robh@kernel.org>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: kexec@lists.infradead.org, devicetree@vger.kernel.org, Nayna Jain <nayna@linux.ibm.com>, nasastry@in.ibm.com, Frank Rowand <frowand.list@gmail.com>, Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 2/3] tpm/kexec: Duplicate TPM measurement log in of-tree
 for kexec
Message-ID: <20220615201453.GA1525994-robh@kernel.org>
References: <20220614161258.1741427-1-stefanb@linux.ibm.com>
 <20220614161258.1741427-3-stefanb@linux.ibm.com>
 <CAL_JsqJG4MJHeu+7Ar0jWi-W6P01_EFtwiz56m_vtVy39uMtiw@mail.gmail.com>
 <af78f4b6-4cfb-5ea6-fdc9-dfcb73f4bc8c@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <af78f4b6-4cfb-5ea6-fdc9-dfcb73f4bc8c@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_131501_112510_F4DB99B9 
X-CRM114-Status: GOOD (  70.10  )
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

On Wed, Jun 15, 2022 at 09:08:04AM -0400, Stefan Berger wrote:
> 
> 
> On 6/14/22 13:48, Rob Herring wrote:
> > (),On Tue, Jun 14, 2022 at 10:13 AM Stefan Berger <stefanb@linux.ibm.com> wrote:
> > > 
> > > The memory area of the TPM measurement log is currently not properly
> > > duplicated for carrying it across kexec when an Open Firmware
> > > Devicetree is used. Therefore, the contents of the log get corrupted.
> > > Fix this for the kexec_file_load() syscall by allocating a buffer and
> > > copying the contents of the existing log into it. The new buffer is
> > > preserved across the kexec and a pointer to it is available when the new
> > > kernel is started. To achieve this, store the allocated buffer's address
> > > in the flattened device tree (fdt) under the name linux,tpm-kexec-buffer
> > > and search for this entry early in the kernel startup before the TPM
> > > subsystem starts up. Adjust the pointer in the of-tree stored under
> > > linux,sml-base to point to this buffer holding the preserved log. The
> > > TPM driver can then read the base address from this entry when making
> > > the log available.
> > 
> > This series really needs a wider Cc list of folks that worry about
> > TPMs and kexec.
> > 
> > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Frank Rowand <frowand.list@gmail.com>
> > > Cc: Eric Biederman <ebiederm@xmission.com>
> > > ---
> > >   drivers/of/device.c       |  24 +++++
> > >   drivers/of/kexec.c        | 190 +++++++++++++++++++++++++++++++++++++-
> > >   include/linux/kexec.h     |   6 ++
> > >   include/linux/of.h        |   5 +
> > >   include/linux/of_device.h |   3 +
> > >   kernel/kexec_file.c       |   6 ++
> > >   6 files changed, 233 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/of/device.c b/drivers/of/device.c
> > > index 874f031442dc..0cbd47b1cabc 100644
> > > --- a/drivers/of/device.c
> > > +++ b/drivers/of/device.c
> > > @@ -382,3 +382,27 @@ int of_device_uevent_modalias(struct device *dev, struct kobj_uevent_env *env)
> > >          return 0;
> > >   }
> > >   EXPORT_SYMBOL_GPL(of_device_uevent_modalias);
> > > +
> > > +int of_tpm_get_sml_parameters(struct device_node *np, u64 *base, u32 *size)
> > 
> > of/device.c is for functions that work on a struct device. This is not
> > the case here.
> 
> Can I put it into platform.c?

That's for struct platform_device things.

> I should have probably mentioned it but this function here is a copy of code
> from tpm_read_log_of() from here: https://elixir.bootlin.com/linux/latest/source/drivers/char/tpm/eventlog/of.c#L38
> 
> 3/3 refactors the code in tpm/eventlog/of.c to make use of this new function
> then to avoid code duplication. Therefore, this code here is more general
> than necessary at this point. Maybe I should do the move in a patch of its
> own?

Maybe you should leave that function there and call it?

Generally, subsystem specific things go into the subsystems. However, 
there's a few special cases like kexec now. That was added primarily to 
avoid per arch duplication.

I've never looked at the TPM code, so sorry, I don't have more specific 
suggestions.

> > > +{
> > > +       const u32 *sizep;
> > > +       const u64 *basep;
> > > +
> > > +       sizep = of_get_property(np, "linux,sml-size", NULL);
> > > +       basep = of_get_property(np, "linux,sml-base", NULL);
> > 
> > Any new properties need a schema. For chosen, that's located here[1].
> > The more common pattern for similar properties is <base size>.
> > 
> > Don't use of_get_property(), but the typed functions instead.
> 
> I think this was done due to the little endian and big endian distinction
> below.


Right.

> > > +       if (sizep == NULL && basep == NULL)
> > > +               return -ENODEV;
> > > +       if (sizep == NULL || basep == NULL)
> > > +               return -EIO;
> > 
> > Do we really need the error distinction?
> 
> As I mentioned, this code is a copy from the TPM subsystem. There it does
> make a distinction because similar functions for acpi and efi make a
> distinction as well although this particular function's return code doesn't
> matter in the end.
> 
> The code I am referring to is this here:
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/char/tpm/eventlog/common.c#L85
> 
> > 
> > > +
> > > +       if (of_property_match_string(np, "compatible", "IBM,vtpm") < 0 &&
> > > +           of_property_match_string(np, "compatible", "IBM,vtpm20") < 0) {
> > > +               *size = be32_to_cpup((__force __be32 *)sizep);
> > > +               *base = be64_to_cpup((__force __be64 *)basep);
> > > +       } else {
> > > +               *size = *sizep;
> > > +               *base = *basep;
> > 
> > What? Some platforms aren't properly encoded? Fix the firmware.
> 
> It's been like this for years...

Great! :(

I'm confused how IBM needs this? Only a LE machine with LE DT encoding 
would need this. With Power being historically BE and only recently 
(though I guess that's a few years now) supporting LE, how did the DT 
encoding become LE for this yet not for everything else in DT?

[...]


> > > +/**
> > > + * tpm_post_kexec - Make stored TPM log buffer available in of-tree
> > > + */
> > > +static int __init tpm_post_kexec(void)
> > > +{
> > > +       struct property *newprop;
> > > +       struct device_node *np;
> > > +       void *phyaddr;
> > > +       size_t size;
> > > +       u32 oflogsize;
> > > +       u64 unused;
> > > +       int ret;
> > > +
> > > +       ret = tpm_get_kexec_buffer(&phyaddr, &size);
> > > +       if (ret)
> > > +               return 0;
> > > +
> > > +       /*
> > > +        * If any one of the following steps fails then the next kexec will
> > > +        * cause issues due to linux,sml-base pointing to a stale buffer.
> > > +        */
> > > +       np = of_find_node_by_name(NULL, "vtpm");
> > 
> > This seems pretty IBM specific.
> 
> Yes, it is and I am not sure what to do about it. Should I cover parts of
> the function with a #ifdef CONFIG_PPC_PSERIES ?

#ifdef's aren't great. IS_ENABLED() is a bit better, but really put 
implementation specific things in implementation specific code.

Perhaps each TPM implementation needs its own hook to do stuff?

> > > +       if (!np)
> > > +               goto err_free_memblock;
> > > +
> > > +       /* logsize must not have changed */
> > > +       if (of_tpm_get_sml_parameters(np, &unused, &oflogsize) < 0)
> > > +               goto err_free_memblock;
> > > +       if (oflogsize != size)
> > > +               goto err_free_memblock;
> > > +
> > > +       /* replace linux,sml-base with new physical address of buffer */
> > > +       ret = -ENOMEM;
> > > +       newprop = kzalloc(sizeof(*newprop), GFP_KERNEL);
> > > +       if (!newprop)
> > > +               goto err_free_memblock;
> > > +
> > > +       newprop->name = kstrdup("linux,sml-base", GFP_KERNEL);
> > > +       if (!newprop->name)
> > > +               goto err_free_newprop;
> > > +
> > > +       newprop->length = sizeof(phyaddr);
> > > +
> > > +       newprop->value = kmalloc(sizeof(u64), GFP_KERNEL);
> > > +       if (!newprop->value)
> > > +               goto err_free_newprop_struct;
> > > +
> > > +       if (of_property_match_string(np, "compatible", "IBM,vtpm") < 0 &&
> > > +           of_property_match_string(np, "compatible", "IBM,vtpm20") < 0) {
> > > +               ret = -ENODEV;
> > > +               goto err_free_newprop_struct;
> > > +       } else {
> > > +               *(u64 *)newprop->value = (u64)phyaddr;
> > > +       }
> > > +
> > > +       ret = of_update_property(np, newprop);
> > 
> > Just FYI for now, there's some work happening on a better API for
> > writing nodes and properties.
> 
> Ok.
> 
> > 
> > > +       if (ret) {
> > > +               pr_err("Could not update linux,sml-base with new address");
> > > +               goto err_free_newprop_struct;
> > > +       }
> > > +
> > > +       goto exit;
> > > +
> > > +err_free_newprop_struct:
> > > +       kfree(newprop->name);
> > > +err_free_newprop:
> > > +       kfree(newprop);
> > > +err_free_memblock:
> > > +       memblock_phys_free((phys_addr_t)phyaddr, size);
> > > +exit:
> > > +       tpm_of_remove_kexec_buffer();
> > > +
> > > +       return ret;
> > > +}
> > > +postcore_initcall(tpm_post_kexec);
> > 
> > Would be better if this is called explicitly at the right time when
> > needed rather than using an initcall.
> 
> The 'when needed' would be the TPM subsystem. However, if I was to make it
> dependent on the TPM subsystem we would loose the TPM log if we were not to
> kexec into a kernel with TPM subsystem or the TPM driver wasn't activated. I
> wanted to be able to preserve the log even if a kexec'ed kernel didn't
> support or activate the TPM driver and then a subsequent one again has it
> activated...

Sounds like a TPM problem the TPM code should deal with. Or a scenario 
that just shouldn't be supported. IDK

> > > +
> > >   /*
> > >    * of_kexec_alloc_and_setup_fdt - Alloc and setup a new Flattened Device Tree
> > >    *
> > > @@ -464,6 +649,9 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
> > >          remove_ima_buffer(fdt, chosen_node);
> > >          ret = setup_ima_buffer(image, fdt, fdt_path_offset(fdt, "/chosen"));
> > > 
> > > +       remove_tpm_buffer(fdt, chosen_node);
> > > +       ret = setup_tpm_buffer(image, fdt, fdt_path_offset(fdt, "/chosen"));
> > > +
> > >   out:
> > >          if (ret) {
> > >                  kvfree(fdt);
> > > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > > index 58d1b58a971e..a0fd7ac0398c 100644
> > > --- a/include/linux/kexec.h
> > > +++ b/include/linux/kexec.h
> > > @@ -319,6 +319,12 @@ struct kimage {
> > >          void *elf_headers;
> > >          unsigned long elf_headers_sz;
> > >          unsigned long elf_load_addr;
> > > +
> > > +       /* Virtual address of TPM log buffer for kexec syscall */
> > > +       void *tpm_buffer;
> > > +
> > > +       phys_addr_t tpm_buffer_addr;
> > > +       size_t tpm_buffer_size;
> > 
> > Probably should use the same types as other buffers...
> 
> It did so following existing support for IMA:
> https://elixir.bootlin.com/linux/latest/source/include/linux/kexec.h
> 
> #ifdef CONFIG_IMA_KEXEC
> 	/* Virtual address of IMA measurement buffer for kexec syscall */
> 	void *ima_buffer;
> 
> 	phys_addr_t ima_buffer_addr;
> 	size_t ima_buffer_size;
> #endif

Ah, nevermind then.

Rob

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
