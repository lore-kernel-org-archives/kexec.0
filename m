Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 076D4C678D5
	for <kexec@archiver.kernel.org>; Wed,  8 Mar 2023 10:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xzqmR089nMSv56OWWCHsUg6tcLyH+/G7w0tYC4AUQrg=; b=MK0fO1T7kc71tG
	MwTo094PhwEGdqb46HVCtg2Vp5SiYci5JE6vvJQ+JndUA6ygp7gWdVxO6EqAbw42zsKM6VZlnzY2z
	UR+kXytrckRFGnwnojC8VAh3CUgtbDg5DmwV6FQNtjHpYgPWzZeVbsMHmWGwDXhYcb1GPNApWaZj4
	hLG4Z45ovvi9GohTh4ZURe3SO9BiTkaRigKzB1miV6Cq8rVkKmZDz2ebDcv37quvzBaMBJxImtNKh
	y1qFLlglWhH6hMia7ttbiImy4WFiluwEKqMUuaLS7A5ucznoZCvyBtFYayHBfcww9Oh8e1ql7IMQs
	cp/2COED8X5ElYQLjHDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZrIE-004Sgs-3t; Wed, 08 Mar 2023 10:45:10 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZrIB-004Sfq-3k
	for kexec@lists.infradead.org; Wed, 08 Mar 2023 10:45:08 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id E215161751;
	Wed,  8 Mar 2023 10:45:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A642C433D2;
	Wed,  8 Mar 2023 10:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678272302;
	bh=iSWueHLUrs/NaHPLqnCJKn35uwGRs6PonZvH/yLtCok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eM1hx0OT8/GNZBEa1BxUyuST6f+85rQQnLacuGaSg9rybe2eO61TtRGog7yF4vEGC
	 v6+9NIG/HwQ/xIjGUJxBfmoQnl7p7Td5pC8KMaz/NEFQpMmfaWtWE6kKmEuSlxK+HS
	 XHozLR6yRReIYEe+EdsizeqmX1F2b1WpCmiVduLES9MlNrWff3RXGOgXvn4pEVHmGk
	 PjAhTXMboB6u19dNdjy/Kn+fhVVXmXjQGWrTsvV8TThdvYO8bDjz9lWtCiMYvQwBOc
	 wapr25OhzaysSsuMqb5ZsqK1KwQmxmLZPApjRED5nTz8M873JXShNQzBcclxmhPamA
	 1LNZDAo6R/jNQ==
Date: Wed, 8 Mar 2023 11:44:57 +0100
From: Simon Horman <horms@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
	x86@kernel.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 1/2] x86/kexec: Remove unnecessary
 arch_kexec_kernel_image_load()
Message-ID: <ZAhnKdXbf2fa9Ql8@kernel.org>
References: <20230307224416.907040-1-helgaas@kernel.org>
 <20230307224416.907040-2-helgaas@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230307224416.907040-2-helgaas@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230308_024507_235314_0BE6CEEE 
X-CRM114-Status: GOOD (  10.88  )
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

On Tue, Mar 07, 2023 at 04:44:15PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The x86 implementation of arch_kexec_kernel_image_load() is functionally
> identical to the generic arch_kexec_kernel_image_load():
> 
>   arch_kexec_kernel_image_load                # x86
>     if (!image->fops || !image->fops->load)
>       return ERR_PTR(-ENOEXEC);
>     return image->fops->load(image, image->kernel_buf, ...)
> 
>   arch_kexec_kernel_image_load                # generic
>     kexec_image_load_default
>       if (!image->fops || !image->fops->load)
> 	return ERR_PTR(-ENOEXEC);
>       return image->fops->load(image, image->kernel_buf, ...)
> 
> Remove the x86-specific version and use the generic
> arch_kexec_kernel_image_load().  No functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
