Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2053CD6E67
	for <kexec@archiver.kernel.org>; Wed, 11 Oct 2023 13:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vMITKLkZ8HOVagcPizWMbcRY/xxQn5bVGF+ZkZN1meE=; b=3N8K9Xe4VkF76x
	woR51KnOBsPh+AzcuVaNrPgKXn7zazTHGP7QcAIGbuVOHSjnY6ie0b8DwboiuOJ8zvscXhel2BQxd
	1TDE5HIcySf5F47MO+Or8LamNCQumxc4C49sNoi7dSuwGKiXV45IUTDNevdyfWs7qDMNgwq67aO7R
	TqcQ1NQvHKS6FI/hiVrL6+zX5vMxp3N4+uaZnPL0bta+i+/AKgz0JirUdLdO4IiKiyc/NSHJS0SbZ
	FHdG4BTAv5Yr5apMWThNdFKSXZ0kq4diBITWNX4nhPl5X0cY3Us22nUs3GTyLVtGwojLYkQGvSOX9
	IuLiNVecQo/fmJszwVFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqYwq-00FvND-2L;
	Wed, 11 Oct 2023 13:08:24 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqYwo-00FvKu-20
	for kexec@lists.infradead.org;
	Wed, 11 Oct 2023 13:08:24 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1697029691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KcBTZkFrKCC9+uriZsI68GWlw6IK9Tb1wdFpYBJJCYg=;
	b=HRCnUMdudkR0auWBbsD9vd5nJL5XsHWCK+TpeuH+ljrS+yAuh7yWwHQXVWHQtoSQ/Dg4hQ
	DWGlyJST7xM6ZlxJvio94UFxahqzw9eDXFuuGQq1XR0dnBTm+3zQOmKYF89WFsvw7OniM+
	kJp5ZeSLgo4PWDDYMgaAreJD+C8wEdJ1Sdi1UvN8LRwpbS8q03enfWDgv4KxdGWX1c1q9w
	OywHOoNEYPAT6HUmGSPqAF/N2SfS5SLoIAWjZ4iyMqCdLVLAbKC+XUXnpOuo+Ra6awNvx3
	lVy5ry0vgpgz08y4o/l0CpqmQGfVKto/KhbPKqAYnfxzhXtz+Nzvu1rstgmm7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1697029691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KcBTZkFrKCC9+uriZsI68GWlw6IK9Tb1wdFpYBJJCYg=;
	b=hIKtc13IGbcJcA+HEU8u0u/QMSxtdx3S9gGt4y4EK3K7p6Xxo3NxxcTFFuk5co9X8DfKDy
	Lvpx0r8mBCR9UbDA==
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>, Jun Nakajima
 <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Tom
 Lendacky <thomas.lendacky@amd.com>, kexec@lists.infradead.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 02/13] kernel/cpu: Add support for declaring CPU hotplug
 not supported
In-Reply-To: <20231005131402.14611-3-kirill.shutemov@linux.intel.com>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-3-kirill.shutemov@linux.intel.com>
Date: Wed, 11 Oct 2023 15:08:11 +0200
Message-ID: <87il7dl32c.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231011_060822_802104_44D83317 
X-CRM114-Status: GOOD (  10.89  )
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

On Thu, Oct 05 2023 at 16:13, Kirill A. Shutemov wrote:
> The function cpu_hotplug_not_supported() can be called to indicate that
> CPU hotplug should be disabled. It does not prevent the initial bring up
> of the CPU, but it stops subsequent offlining.

This tells me what the patch is doing, but not the why.

> This function is intended to replace CC_ATTR_HOTPLUG_DISABLED.

> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -132,6 +132,7 @@ extern void cpus_read_lock(void);
>  extern void cpus_read_unlock(void);
>  extern int  cpus_read_trylock(void);
>  extern void lockdep_assert_cpus_held(void);
> +extern void cpu_hotplug_not_supported(void);

This function name sucks.

The point is as you explained to prevent offlining, but not onlining. So
can we please make this very clear? Something like:

    cpu_hotplug_disable_offlining()

> +/* Cleared if platform declares CPU hotplug not supported */
> +static bool cpu_hotplug_supported = true;

Again. This is not about disabling hotplug all together. Something like:

static bool cpu_hotplug_offline_disabled;

Which expresses clearly what this is about and does not require this
awkward negation.

Thanks,

        tglx

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
