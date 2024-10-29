Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFAD2D3A67A
	for <kexec@archiver.kernel.org>; Tue, 29 Oct 2024 18:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GthaLTBWSbJz/kYutHHgsahXeXIWCtIYKrj7+Lc04ak=; b=AX7FkMjK1bT+3M
	fdHASGci3QaXBjec7wypwokXBYgDsInLkOsokLjtQqVJJ4vwpMcWS+li5PNa63MjmIT9G4LgK5YWM
	jfuTmw2wIdXdF1A5dgHXQE5+GpfWO2PPk9WhzNTtfQER88YwEQwMHnCLEawaKzBEw6IuV3ErcuYZr
	tAt2wFN7C+HrJGoX/pMNzxnt68eCRz0Vv1CZqCtZsOpmmfFDZQ7mTZpKach65d+ZdS848j+PF8Vw2
	U249xVsh6W7EjW3dCjfifrCLI5smbjCEsdyyA4O44Jp5r5rc2nQmwBtuF2+usgK8CnmxNs8Ytv9qa
	5wo8ktoe2VAyGVKUEG7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5qrT-0000000FTTP-0f6q;
	Tue, 29 Oct 2024 18:22:35 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5qgf-0000000FS9M-1zil
	for kexec@lists.infradead.org;
	Tue, 29 Oct 2024 18:11:27 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E470140E0219;
	Tue, 29 Oct 2024 18:11:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1jUAB7o3tzMk; Tue, 29 Oct 2024 18:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730225476; bh=6Fu6LG6Vbq5lMPm5XWcRJQzu3wtX0SK7peh7dKKVOeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CqnPLbNZvNDu/GWN1P7RVVqFeuW1y5LP8a/bS/v6+1GCoF3D7Nvr0sVaaNEEzXKca
	 VjsHvLKArsgaYUYVl1bW9luZ8E+jDkNGBOgG4S8Waq/yuyD/RM7tI77mIhIopU9EQQ
	 0AgJjpEH385uvOfCQwbxVaSY/qaapfAEJH2cwD+fIBrogtG9sL8VdtLhEAqBtkFpUB
	 vYeFiwCVgWfcL5qeUHQP/r005V4tF3JlP9CNG6NhweXMWn2AF2C2ss5KbThAzagydt
	 ln1Y1Uvek14D9dL3PSg22Cea27lx8TKjOvHI7GJbSUS1EtaYRms92ty5Di2gKv8wZI
	 FEMOCfTkbDWHsRWKNJSa87wdVXONjh/bTRsegKVYutm/WhipVYPeW1myYcR+URvsGy
	 DaNbdWYPqjxGdyA6L+0kKfB6oINqZ4LfXbnKVHq0lo6PLRSg8TlCIDMJwMhVZ6zQGb
	 k31ottzjD9kxO/1GOO3yfZbHWBH1b51Gw97uTXQlnobbd6s4hQOzP/MK3Ym1tlNGhG
	 hIJO86HuJioZTEgZMjKhG/5AtXRU1RXrqb21ZAwD4khJozY0cHpWTN1yTRze78kXcH
	 XFCuZSlihelQmi/6HFYkuniS+uXwDzAu6qa4bvvNzSJQ5CRWLLwk0XmdJQUtLMoXoU
	 wJC06yLzsdwCKS+BhvzSK2TQ=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7A77E40E02BD;
	Tue, 29 Oct 2024 18:11:07 +0000 (UTC)
Date: Tue, 29 Oct 2024 19:11:01 +0100
From: Borislav Petkov <bp@alien8.de>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
	dyoung@redhat.com, daniel.kiper@oracle.com, noodles@fb.com,
	lijiang@redhat.com, kexec@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v3 1/2] x86/mm: rename the confusing local variable in
 early_memremap_is_setup_data()
Message-ID: <20241029181101.GXZyElNXVuF6596TKG@fat_crate.local>
References: <20240911081615.262202-1-bhe@redhat.com>
 <20240911081615.262202-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240911081615.262202-2-bhe@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_111125_834090_4D6023F9 
X-CRM114-Status: GOOD (  17.78  )
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

On Wed, Sep 11, 2024 at 04:16:14PM +0800, Baoquan He wrote:
> In function early_memremap_is_setup_data(), parameter 'size' passed has
> the same name as the local variable inside the while loop. That
> confuses people who sometime mix up them when reading code.
> 
> Here rename the local variable 'size' inside while loop to 'sd_size'.
> 
> And also add one local variable 'sd_size' likewise in function
> memremap_is_setup_data() to simplify code. In later patch, this can also
> be used.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/mm/ioremap.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index aa7d279321ea..f1ee8822ddf1 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -640,7 +640,7 @@ static bool memremap_is_setup_data(resource_size_t phys_addr,

Huh?

---
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 70b02fc61d93..e461d8e26871 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -632,8 +632,7 @@ static bool memremap_is_efi_data(resource_size_t phys_addr,
  * Examine the physical address to determine if it is boot data by checking
  * it against the boot params setup_data chain.
  */
-static bool memremap_is_setup_data(resource_size_t phys_addr,
-				   unsigned long size)
+static bool memremap_is_setup_data(resource_size_t phys_addr)
 {
 	struct setup_indirect *indirect;
 	struct setup_data *data;
@@ -769,7 +768,7 @@ bool arch_memremap_can_ram_remap(resource_size_t phys_addr, unsigned long size,
 		return false;
 
 	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
-		if (memremap_is_setup_data(phys_addr, size) ||
+		if (memremap_is_setup_data(phys_addr) ||
 		    memremap_is_efi_data(phys_addr, size))
 			return false;
 	}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
