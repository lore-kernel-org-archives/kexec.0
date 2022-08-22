Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F439C32774
	for <kexec@archiver.kernel.org>; Mon, 22 Aug 2022 17:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NeaGa/U7K1mNdsnAK2Mx1jn/cgEikhOUNKGksu0Wo5c=; b=h+8UlqxBHNLuZq
	T2x542VXHJmV0farJ9actLszUZ+5sB834Cl8uzp0V/eoG7KwprgIVN4Ycoj7qPhdNehnktz3JUFPo
	y1oZDYuHq/jRjTXs/udpDpG8zWUA53H7MQBWAVbuqM98dRfpF9obDt5YF7ejCMMdapvPV5gCCeODv
	c+kR02QYTXXNAadJdWrq4C3QlHQp0KeGlaP7g+CFR0+gjv+vlobIc/D3JphWeFPVoSUdc6PckYMJG
	fC3+yb8guA/Jat3HNiWYN92VDCXhXPKfTPEHAVR7vw0r9BIRhAH6E0vDWvBwYcBxw6QNXBKY+MD09
	K81hSI6KqFYf1O8iJrww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQBi4-00DJwg-2T; Mon, 22 Aug 2022 17:59:36 +0000
Received: from mail-oi1-f169.google.com ([209.85.167.169])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQBhw-00DJsS-Qf
	for kexec@lists.infradead.org; Mon, 22 Aug 2022 17:59:30 +0000
Received: by mail-oi1-f169.google.com with SMTP id t140so4269797oie.8
        for <kexec@lists.infradead.org>; Mon, 22 Aug 2022 10:59:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=3TuVf54GgPydYoGd51XaXL3tfz0KadvwC9z8/Fy+sls=;
        b=hgvua+12L2VIN0tNlQocbDZvR5fuHrpDL+nG46APdTYyd5Rj2gPlzCIdbf5wUyueTZ
         QGevLQb9guHrnkERbMrMH8ECoYFbtMl5ukQbrPOmSqctbGsFdCRkBqnnAPH/Y0/5V9tK
         CiSzcyvsy6zsIxDds2Qg72ZtTDHucln0iQSjQiuMAcBhHLy/zjP4hCMNYhyXlqxU5yDH
         JM1u3kpy4ZwfxDBEPscl+BfahxIkaftV3R4U+xNDx5/nWX5KKlzeCio+rAL6XVsJNc7Q
         FnzR5/XOUQ1IR6ml4NslyQgPxAWVD3lO+X/kx/N6YsZklgvwaHu2x1rehbGRKm8JAefm
         AIQA==
X-Gm-Message-State: ACgBeo0pUTP0/ZIIhaHzdMhgYhCujBYjy5++yGXGBNLo9pHC0y4BUGbP
	liVeNm6Bjp8EP6JdiNRc9g==
X-Google-Smtp-Source: AA6agR602WMERbYZ3uSCPQSQ/AhC9EWTsVLdvnnS5HXY696Jr8IN6ZBdolcGmNue7hlW5WqBeaMdnQ==
X-Received: by 2002:a05:6808:302b:b0:2f9:eeef:f03 with SMTP id ay43-20020a056808302b00b002f9eeef0f03mr11736503oib.128.1661191166666;
        Mon, 22 Aug 2022 10:59:26 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r11-20020a4a964b000000b0041b49c19a00sm2478019ooi.18.2022.08.22.10.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 10:59:26 -0700 (PDT)
Received: (nullmailer pid 62586 invoked by uid 1000);
	Mon, 22 Aug 2022 17:59:24 -0000
Date: Mon, 22 Aug 2022 12:59:24 -0500
From: Rob Herring <robh@kernel.org>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: kexec@lists.infradead.org, mpe@ellerman.id.au, devicetree@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Nageswara R Sastry <rnsastry@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, nayna@linux.ibm.com, nasastry@in.ibm.com, Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v7 6/6] tpm/kexec: Duplicate TPM measurement log in
 of-tree for kexec
Message-ID: <20220822175924.GA62553-robh@kernel.org>
References: <20220812164305.2056641-1-stefanb@linux.ibm.com>
 <20220812164305.2056641-7-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220812164305.2056641-7-stefanb@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220822_105929_043566_794440FC 
X-CRM114-Status: GOOD (  26.66  )
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

On Fri, 12 Aug 2022 12:43:05 -0400, Stefan Berger wrote:
> The memory area of the TPM measurement log is currently not properly
> duplicated for carrying it across kexec when an Open Firmware
> Devicetree is used. Therefore, the contents of the log get corrupted.
> Fix this for the kexec_file_load() syscall by allocating a buffer and
> copying the contents of the existing log into it. The new buffer is
> preserved across the kexec and a pointer to it is available when the new
> kernel is started. To achieve this, store the allocated buffer's address
> in the flattened device tree (fdt) under the name linux,tpm-kexec-buffer
> and search for this entry early in the kernel startup before the TPM
> subsystem starts up. Adjust the pointer in the of-tree stored under
> linux,sml-base to point to this buffer holding the preserved log. The TPM
> driver can then read the base address from this entry when making the log
> available. Invalidate the log by removing 'linux,sml-base' from the
> devicetree if anything goes wrong with updating the buffer.
> 
> Use subsys_initcall() to call the function to restore the buffer even if
> the TPM subsystem or driver are not used. This allows the buffer to be
> carried across the next kexec without involvement of the TPM subsystem
> and ensures a valid buffer pointed to by the of-tree.
> 
> Use the subsys_initcall(), rather than an ealier initcall, since
> page_is_ram() in get_kexec_buffer() only starts working at this stage.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
> 
> ---
> v6:
>  - Define prototype for tpm_add_kexec_buffer under same config options
>    as drivers/of/kexec.c is compiled, provide inline function otherwise.
>    (kernel test robot)
> 
> v4:
>  - Added #include <linux/vmalloc.h> due to parisc
>  - Use phys_addr_t for physical address rather than void *
>  - Remove linux,sml-base if the buffer cannot be updated after a kexec
>  - Added __init to functions where possible
> ---
>  drivers/of/kexec.c    | 216 +++++++++++++++++++++++++++++++++++++++++-
>  include/linux/kexec.h |   6 ++
>  include/linux/of.h    |   9 +-
>  kernel/kexec_file.c   |   6 ++
>  4 files changed, 234 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
