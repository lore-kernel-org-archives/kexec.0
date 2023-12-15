Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E8FC4332F
	for <kexec@archiver.kernel.org>; Fri, 15 Dec 2023 02:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2M6UfATQQWcoXL5e2fdXG3pKHJP/04l6puI5t2YREfs=; b=y03ZANIcxNpXmW
	hSbOUC+hJqXB8mSvfIT3E/IPyfu41Ocb4ZHrCWQp2EhPM5VPvhe5NFoAXwy55TKEnJMh7XgenwcQK
	lk5XoYly1YvGxqnRd0pyvfFLWxBwwnRCEEAysFWD6aIlP6VJ1uek2wCkoFC7RNrcvd15QTHQeQHhD
	CwIR8nHq0zhLh0p9B8qJpd3ZaPnhXy7Vekj/eghkxeUAbT4egQqXbxshvi6VD5EUDx1IEcAmIeW5S
	kyH5uKaci90FvNA90hz54MtTKATvDNp8UMc0BMMqrSXxIJPePRv7rgNGhwlEi5wKDRXVNKZVigs08
	W/QAL8mOrb2LaYkAtx8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDxwo-001nD6-1M;
	Fri, 15 Dec 2023 02:29:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDxwm-001nBy-01
	for kexec@lists.infradead.org;
	Fri, 15 Dec 2023 02:29:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702607342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xiQyckJTwnqYOVFcTln1GExvRHz6Chm9H/hFawrpLu4=;
	b=Oy8Kv4vCnVXGaz5ukMiTo0y+tvX/yEWMh/JHyk+LefjGVQqwdOV+3EiQg7hPf+r8UV8eR2
	aV1J29XX/s6z8XmXqLiT/g/BLNq2CGQAO07RvOJ12CzwyiMLlxFLvZAlzPwPvdzbiFn7xc
	MWpoGO4RCd5vkPDFer87kxRybJSiH+Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-_ekwzBs_NQC2U-Afnm6wqA-1; Thu, 14 Dec 2023 21:28:58 -0500
X-MC-Unique: _ekwzBs_NQC2U-Afnm6wqA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3DB13881B6B;
	Fri, 15 Dec 2023 02:28:57 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E298E2166B31;
	Fri, 15 Dec 2023 02:28:55 +0000 (UTC)
Date: Fri, 15 Dec 2023 10:28:53 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Akhil Raj <lf32.dev@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Young <dyoung@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Eric DeVolder <eric.devolder@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Laurent Dufour <laurent.dufour@fr.ibm.com>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mimi Zohar <zohar@linux.ibm.com>, Naveen N Rao <naveen@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
	x86@kernel.org
Subject: Re: [PATCH v14 3/6] crash: add a new kexec flag for FDT update
Message-ID: <ZXu55ZXVSMeQDE/e@MiWiFi-R3L-srv>
References: <20231211083056.340404-1-sourabhjain@linux.ibm.com>
 <20231211083056.340404-4-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20231211083056.340404-4-sourabhjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231214_182904_111911_F82938E3 
X-CRM114-Status: GOOD (  25.12  )
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

On 12/11/23 at 02:00pm, Sourabh Jain wrote:
> The commit a72bbec70da2 ("crash: hotplug support for kexec_load()")
> introduced a new kexec flag, `KEXEC_UPDATE_ELFCOREHDR`. Kexec tool uses
> this flag to indicate kernel that it is safe to modify the elfcorehdr
> of kdump image loaded using kexec_load system call.
> 
> Similarly, add a new kexec flag, `KEXEC_UPDATE_FDT`, for another kdump
> component named FDT (Flatten Device Tree). Architectures like PowerPC
> need to update FDT kdump image component on CPU hotplug events. Kexec
> tool passing `KEXEC_UPDATE_FDT` will be an indication to kernel that FDT
> segment is not part of SHA calculation hence it is safe to update it.
> 
> With the `KEXEC_UPDATE_ELFCOREHDR` and `KEXEC_UPDATE_FDT` kexec flags,
> crash hotplug support can be added to PowerPC for the kexec_load syscall
> while maintaining the backward compatibility with older kexec tools that
> do not have these newly introduced flags.
> 
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Cc: Akhil Raj <lf32.dev@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Borislav Petkov (AMD) <bp@alien8.de>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Eric DeVolder <eric.devolder@oracle.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Laurent Dufour <laurent.dufour@fr.ibm.com>
> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: Naveen N Rao <naveen@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: kexec@lists.infradead.org
> Cc: x86@kernel.org
> ---
>  include/linux/kexec.h      | 6 ++++--
>  include/uapi/linux/kexec.h | 1 +
>  kernel/kexec.c             | 2 ++
>  3 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 0f6ea35879ee..bcedb7625b1f 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -319,6 +319,7 @@ struct kimage {
>  #ifdef CONFIG_CRASH_HOTPLUG
>  	/* If set, allow changes to elfcorehdr of kexec_load'd image */
>  	unsigned int update_elfcorehdr:1;
> +	unsigned int update_fdt:1;

Can we unify this to one flag, e.g hotplug_update?

With this, on x86_64, we will skip the sha calculation for elfcorehdr. 
On ppc, we will skip the sha calculation for elfcorehdr and fdt.

>  #endif
>  
>  #ifdef ARCH_HAS_KIMAGE_ARCH
> @@ -396,9 +397,10 @@ bool kexec_load_permitted(int kexec_image_type);
>  
>  /* List of defined/legal kexec flags */
>  #ifndef CONFIG_KEXEC_JUMP
> -#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_UPDATE_ELFCOREHDR)
> +#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_UPDATE_ELFCOREHDR | KEXEC_UPDATE_FDT)
>  #else
> -#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT | KEXEC_UPDATE_ELFCOREHDR)
> +#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT | KEXEC_UPDATE_ELFCOREHDR | \
> +			KEXEC_UPDATE_FDT)
>  #endif
>  
>  /* List of defined/legal kexec file flags */
> diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
> index 01766dd839b0..3d5b3d757bed 100644
> --- a/include/uapi/linux/kexec.h
> +++ b/include/uapi/linux/kexec.h
> @@ -13,6 +13,7 @@
>  #define KEXEC_ON_CRASH		0x00000001
>  #define KEXEC_PRESERVE_CONTEXT	0x00000002
>  #define KEXEC_UPDATE_ELFCOREHDR	0x00000004
> +#define KEXEC_UPDATE_FDT	0x00000008
>  #define KEXEC_ARCH_MASK		0xffff0000
>  
>  /*
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 8f35a5a42af8..97eb151cd931 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -132,6 +132,8 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>  #ifdef CONFIG_CRASH_HOTPLUG
>  	if (flags & KEXEC_UPDATE_ELFCOREHDR)
>  		image->update_elfcorehdr = 1;
> +	if (flags & KEXEC_UPDATE_FDT)
> +		image->update_fdt = 1;
>  #endif
>  
>  	ret = machine_kexec_prepare(image);
> -- 
> 2.41.0
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
