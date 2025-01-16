Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10274E77188
	for <kexec@archiver.kernel.org>; Thu, 16 Jan 2025 07:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=okdt0fx0NV20NIbFUTu8L5bpNAapNYnpnIywHGLF0Ck=; b=oa8uXuVT+MqzuUaHfg3+n9PdjO
	S/Z+d7zh59tC2CQGGQNu26Zmd1Yindm4gf2WliLXd3lJ6hQsMPNFiGFP/eFgJqmfCOlE+ztRrWy/S
	hfcMF3Tn3AlIPmGVb2TWc51VcL/KHf2EWPYSUcg9dQMRpjtqu8tRQ+qo8lA/+BXyrYIJzrJN1wyw6
	EsAd9+SQ3h5x3BPvHMksK4dPwPoOPl+HvXmZxiCXmOGqdgd7OMHhZYg4DX0OWx1zYkClIkM2Shdhl
	I9+M+DW06gbKnz/EMGDWyVA8X0Sz9e5aRFxuxXD90/iEDUx6L2bfYcoe6Qt2SA0N5wnSsYFXElrox
	C6rcdjVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYJvg-0000000E0Ul-3F0Q;
	Thu, 16 Jan 2025 07:04:36 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYJvf-0000000E0U8-0T8N
	for kexec@bombadil.infradead.org;
	Thu, 16 Jan 2025 07:04:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=okdt0fx0NV20NIbFUTu8L5bpNAapNYnpnIywHGLF0Ck=; b=Z7jYqtNH7s6Xj5dyR+8YdH0hDz
	HLDocw6jpb8gU6SZZM6jmwtUFLPSrV42IxYqXoCWq77u5VIZzEXLGb4XHFn4VWRhTFIJyjDdi24bs
	ddwCQi9+D5AUq401N6+IxYQoeLvQ2HBPOQd9vUKrNzsZfo9ZKZ52N8JpJWIKG3Jv7SriGh7xMV6Kw
	XMaomfqfbKK19IDNRs64YMu9s68h+RNKtzMa2sqdw9L/DFp5U9WCpXfZIum9kezTYqqxQTGhcNu3M
	aOc9GEz9R6LPUivZAPFljj97thIKN65TLqOtLKzvUdL775x4ac6bqRM8Tf3663O0TZsyUoj6zY0Tm
	qrPtSMgQ==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tYJva-0000000B0pO-0Bys;
	Thu, 16 Jan 2025 07:04:30 +0000
Message-ID: <4a663a07-2442-4552-b524-a5cc6b06b727@infradead.org>
Date: Wed, 15 Jan 2025 23:04:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/7] crash_dump: make dm crypt keys persist for the
 kdump kernel
To: Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org
Cc: Ondrej Kozina <okozina@redhat.com>, Milan Broz <gmazyland@gmail.com>,
 Thomas Staudt <tstaudt@de.ibm.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>,
 Jan Pazdziora <jpazdziora@redhat.com>, Pingfan Liu <kernelfans@gmail.com>,
 Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20250116065825.1041558-1-coxu@redhat.com>
 <20250116065825.1041558-3-coxu@redhat.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250116065825.1041558-3-coxu@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi,

On 1/15/25 10:58 PM, Coiby Xu wrote:
> diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
> index 5376890adbeb..192d6796ab94 100644
> --- a/Documentation/admin-guide/kdump/kdump.rst
> +++ b/Documentation/admin-guide/kdump/kdump.rst
> @@ -551,6 +551,34 @@ from within add_taint() whenever the value set in this bitmask matches with the
>  bit flag being set by add_taint().
>  This will cause a kdump to occur at the add_taint()->panic() call.
>  
> +Write the dump file to encrypted disk volume
> +============================================
> +
> +CONFIG_CRASH_DM_CRYPT can be enabled to support saving the dump file to
> +encrypted disk volume. User space can interact with

   an encrypted disk volume.

> +/sys/kernel/config/crash_dm_crypt_keys for setup,
> +
> +1. Tell the 1st kernel what keys are needed to unlock the disk volumes,

               first

> +    # Add key #1
> +    mkdir /sys/kernel/config/crash_dm_crypt_keys/7d26b7b4-e342-4d2d-b660-7426b0996720
> +    # Add key #1's description
> +    echo cryptsetup:7d26b7b4-e342-4d2d-b660-7426b0996720 > /sys/kernel/config/crash_dm_crypt_keys/description
> +
> +    # how many keys do we have now?
> +    cat /sys/kernel/config/crash_dm_crypt_keys/count
> +    1
> +
> +    # Add key#2 in the same way

             key #2
(be consisent)

> +
> +    # how many keys do we have now?
> +    cat /sys/kernel/config/crash_dm_crypt_keys/count
> +    2
> +
> +2. Load the dump-capture kernel
> +
> +3. After dump-capture kerne get booted, restore the keys to user keyring

      After the dump-capture kernel is booted,

> +   echo yes > /sys/kernel/crash_dm_crypt_keys/restore
> +
>  Contact
>  =======
>  

-- 
~Randy


