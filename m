Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD130C433FE
	for <kexec@archiver.kernel.org>; Fri, 11 Nov 2022 02:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nUD6fBJHymPrcqHIhRbgtkwkDaMKgbCEryFqJ5Mdpbs=; b=eqQvZUYXfDOcG286d9CbCmNTZi
	K0fTauayutQZz67n7DFwS26dOokDCgibr8sOL0jCp7yjVYz5CirwWRUMMAvTg8MnULVUVy75v2xLB
	wtrFto1jJW4AL534fFlGDhXNRF5atPWGzPIHJv+WYGs0dgue5ju5iJ3fQXmOW/mRBlJwFudzWVgrT
	TgdPHxIBJpuW5kL7orScmepP9VqyXEN55NwJk1V9ERZLx68jmkaeh9MHlhxTd/CUxC+bxOykcjqca
	9ZJf5IeEelD9czEds4L176i19VZDPV9KFlP9Azb6mTEl+1etwqZbc3//0PivJz9ScyqoE1PiYuS6U
	/uGn+kuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1otJjc-00C6tA-LV; Fri, 11 Nov 2022 02:25:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1otJja-00C6sl-CQ
	for kexec@lists.infradead.org; Fri, 11 Nov 2022 02:25:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1668133532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WaG6D9NPul5lwMcNCuIe3sGhugQZUKvnrKFJmGoro3c=;
	b=PWTZZynKGvfUR+JqAZVPOYCA2ZWbXYR3k49Prqqfk4ZoNFNUmD+lz54BXhMMCezCS6Cb69
	pBcffh+pcDKt1wpNpRgvUns8fT7jSGgCdRZDHhfJNBa34AhNJEAvmPp6ytexH0GSEsgVxa
	qeTLvdloFXhwus9Nks8QNylQy/L0bGk=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-448-PMTHwtYTOCaPj9IzGDxdFw-1; Thu, 10 Nov 2022 21:25:30 -0500
X-MC-Unique: PMTHwtYTOCaPj9IzGDxdFw-1
Received: by mail-pg1-f199.google.com with SMTP id a33-20020a630b61000000b00429d91cc649so1898534pgl.8
        for <kexec@lists.infradead.org>; Thu, 10 Nov 2022 18:25:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WaG6D9NPul5lwMcNCuIe3sGhugQZUKvnrKFJmGoro3c=;
        b=09JgXR0NpC0/8tw/r3bzurNhntyOYjHjTNOYlWrFyKOQA18ABMtor43yY7I2OJkpia
         4Jk51E8zphW4lpX7+F4W1GImTqVMBw5NJ4lAc7yErcdw6T82nMyRWmRPhRdQVSBcSKHy
         Rd70HUsvYPP+znOZ1Hg74didIZA50ee7ltu1CbRSAt6Ca3rHAfBdUItIzOEek5bA/048
         ppgbDxIRZOEq7jmlUexPkycwVF8lNZ3SBGh0m0aDYt06mtKNaip6qFz3pX9nfuHkElYC
         zcwj8FHPtn7dpmmDkkPeW5M60hTCish7DK8BmKV3H149bNXfOkLNDkT3ieT0Fww2IR4v
         uy+A==
X-Gm-Message-State: ANoB5pn4mXAaWILiHg9UtTpjWqPJn+1YiWKqNxe03ZfaXkEtvQVQLXOg
	EwtZ6xoMzfcYOaFTzPGRmVxBvcT8f099EAP8j7C/pq3zNTD/V6hXaHPjECNhicIe97eF4dKGax9
	X9O9vSXum9IqQs4nBqBTE
X-Received: by 2002:a17:902:f811:b0:187:19c4:373a with SMTP id ix17-20020a170902f81100b0018719c4373amr321319plb.163.1668133529853;
        Thu, 10 Nov 2022 18:25:29 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5JE5CicYQ2l/VDcgKu1A3Opx/g/1lm/7vpkfRaW5I/+bVsxwi+MrsKOPNQCArSCBYFvx9qNQ==
X-Received: by 2002:a17:902:f811:b0:187:19c4:373a with SMTP id ix17-20020a170902f81100b0018719c4373amr321304plb.163.1668133529575;
        Thu, 10 Nov 2022 18:25:29 -0800 (PST)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id w8-20020a1709026f0800b0018544ad1e8esm358845plk.238.2022.11.10.18.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 18:25:28 -0800 (PST)
Date: Fri, 11 Nov 2022 10:21:43 +0800
From: Coiby Xu <coxu@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Stefan Berger <stefanb@linux.ibm.com>, kexec@lists.infradead.org,
	devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	nayna@linux.ibm.com, nasastry@in.ibm.com,
	Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v8 0/4] tpm: Preserve TPM measurement log across kexec
 (ppc64)
Message-ID: <20221111022143.xvpi3pfwwrw4qda2@Rk>
References: <20220901214610.768645-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20220901214610.768645-1-stefanb@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221110_182534_539022_E2F94B6F 
X-CRM114-Status: GOOD (  17.63  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Michael,

Could the PowerPC tree take this patch set which resolves a
PowerVM/KVM-specific issue?

On Thu, Sep 01, 2022 at 05:46:06PM -0400, Stefan Berger wrote:
>The of-tree subsystem does not currently preserve the IBM vTPM 1.2 and
>vTPM 2.0 measurement logs across a kexec on PowerVM and PowerKVM. This
>series fixes this for the kexec_file_load() syscall using the flattened
>device tree (fdt) to carry the TPM measurement log's buffer across kexec.
>
>   Stefan
>
>v8:
> - Added Jarkko's, Coiby's, and Rob's tags
> - Rebase on v6.0-rc3 that absorbed 2 already upstreamed patches
>
>v7:
> - Added Nageswara's Tested-by tags
> - Added back original comment to inline function and removed Jarkko's R-b tag
>
>v6:
> - Add __init to get_kexec_buffer as suggested by Jonathan
> - Fixed issue detected by kernel test robot
>
>v5:
> - Rebased on 1 more patch that would otherwise create merge conflicts
>
>v4:
> - Rebased on 2 patches that would otherwise create merge conflicts;
>   posting these patches in this series with several tags removed so
>   krobot can test the series already
> - Changes to individual patches documented in patch descripitons
>
>v3:
> - Moved TPM Open Firmware related function to drivers/char/tpm/eventlog/tpm_of.c
>
>v2:
> - rearranged patches
> - fixed compilation issues for x86
>
>Palmer Dabbelt (1):
>  drivers: of: kexec ima: Support 32-bit platforms
>
>Stefan Berger (3):
>  tpm: of: Make of-tree specific function commonly available
>  of: kexec: Refactor IMA buffer related functions to make them reusable
>  tpm/kexec: Duplicate TPM measurement log in of-tree for kexec
>
> drivers/char/tpm/eventlog/of.c |  31 +--
> drivers/of/kexec.c             | 336 ++++++++++++++++++++++++++++-----
> include/linux/kexec.h          |   6 +
> include/linux/of.h             |   9 +-
> include/linux/tpm.h            |  36 ++++
> kernel/kexec_file.c            |   6 +
> 6 files changed, 346 insertions(+), 78 deletions(-)
>
>
>base-commit: b90cb1053190353cc30f0fef0ef1f378ccc063c5
>-- 
>2.35.1
>

-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
