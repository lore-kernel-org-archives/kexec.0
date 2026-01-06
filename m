Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A96ECD043F
	for <kexec@archiver.kernel.org>; Tue,  6 Jan 2026 06:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5odIQwPJjuX5od5ef4AjZuxMCllVPli7nQhOJ/OzpYQ=; b=drOB6R1T0eb0QRC1hP+Wo9fo8q
	W69/ycupoNKg5h0+iFwKXu1DeYZxt3js4h83KUzLFVQiPMH2tWhV1DauLJFkh+m2hUW/pwm9p8wBp
	ecdAePB1iOA7pJN9iDbuBNdyqaNuciAyGY0VPsmW4rxB/af3m9dYj+z8za79lNaZpx7iUVIXZSgRU
	ORbortO8egRmlUYwwmramLb2V9p0ZG8tzfEqXlblWaOVKG3ZB81yPKFNJFoPIG9PSwn85ayDAebvb
	nEMKZz55T2ukYF1DKtyAl1pYhyud/09Ts9Z3cjQXhBsTa9Hj2qgAlTqXi8XbdWV3DW7R8ecnpGiB2
	U25Nvz3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd0aL-0000000CTE9-1800;
	Tue, 06 Jan 2026 06:30:29 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd0aH-0000000CTDU-3X91
	for kexec@lists.infradead.org;
	Tue, 06 Jan 2026 06:30:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767681024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5odIQwPJjuX5od5ef4AjZuxMCllVPli7nQhOJ/OzpYQ=;
	b=I1EngBiFDOnnvbLjY2nkYiUMqGrkw6B1/wJEghp7522pbUkDo8H9GJpU1Z3i0MUr4iA+JG
	1EHw6rTi993KyaaKcPIOGOWjmkl6gAbpkUje/65zPPGuAZXjpiQxyO9NRH/QSf9kfKRlxi
	AIULZM5kg0EeoHDRYHfS7rliYIxXK2A=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-zB_Q6UvwMPOm--RnsdeLOg-1; Tue, 06 Jan 2026 01:30:23 -0500
X-MC-Unique: zB_Q6UvwMPOm--RnsdeLOg-1
X-Mimecast-MFC-AGG-ID: zB_Q6UvwMPOm--RnsdeLOg_1767681022
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7b90740249dso1349917b3a.0
        for <kexec@lists.infradead.org>; Mon, 05 Jan 2026 22:30:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767681022; x=1768285822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5odIQwPJjuX5od5ef4AjZuxMCllVPli7nQhOJ/OzpYQ=;
        b=GKt1pcxlOQmAjYANz9NySRqlsqY/9KnUnoSEmqrP7IenErigjjFz0CHLBjIUxJL1lh
         AYNFV4BP9FCailNn+/qxCCQe0jhexYll1ZfoT8aqFmXBrjlrboaeC43cFFyDFQ8D7puN
         LPxh/app8MeCoZexEcWJ92pSvZ2FiS3vQbGqJhAc9t4s4H6jiMeXcDhN92hebcxyRFCn
         br3NrmI/b2ErWIowhTypdb8oeKAysqXEdgkEGBq1/KDrnZKkjA7107ymlYF+nDrregtP
         vXd4JLcJxYc5Ws+0WmzxcAzVe+uKctqxnuRikvSoUZIg92P+8J/K6LxgYiEfQFb7/wuL
         WlvA==
X-Gm-Message-State: AOJu0YxH/y2T74zESLa46SNCvPQQvyfpakkrRrgO9d4T9MzE9+UZ7TEh
	TqZuvRX0r0tSLO42FV+O9oXxRvzvUwbsdvnY6gmqY4K2niUfbKgbM5zl1SALYDUgvyI97QhN+BH
	7fufjPs8J0Jfyr5J1zS/p0Mj5jKzdByZ+K+5BYSkipXeDqVEvJsxzDNIUj4P6sg==
X-Gm-Gg: AY/fxX4TmgMgvMerlK8IdkCKqj82NLbtHymhcdU7DiWLDii7bC5YL7hjNv2MhbFfgZF
	OYXKXbdtWLzSCRVf3ky7W4dvfrYHlfIyNl4UaMu3sEmD/jClNAS6SOEhwOVIb8oWWA4Z1KMc4T/
	UUpZ8+01+myFfbYz559j6FJqXsof3TQFqHGT/Lg8laUccChFNbMAWkgowF/g5yPKMjHqcdUM5Nx
	nfCmG5ua9gQjvXxGvxNhqJeoaYeRn5VsnFArxry9aZJjNAlUtwvF3AZSGBhWnA0zuWxVTiYqQnM
	c8+o9vy7iKMsZBCOdip/RfP1UlNp9yz9fYW4d6PVbWMjf8FGJcAewwlUptF5o7j/+WyXJltcA2N
	m
X-Received: by 2002:a05:6a21:33a2:b0:366:14ac:e20d with SMTP id adf61e73a8af0-389823ccaeamr1702267637.75.1767681021937;
        Mon, 05 Jan 2026 22:30:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9cfpUUe1HFlsOEg/hJrnV4Zf0Q08lNkGZQR8DEVWxFHSM5lZqtkm1xu9aYzl5/kpjJzLI2w==
X-Received: by 2002:a05:6a21:33a2:b0:366:14ac:e20d with SMTP id adf61e73a8af0-389823ccaeamr1702228637.75.1767681021396;
        Mon, 05 Jan 2026 22:30:21 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cc8d29592sm1233261a12.22.2026.01.05.22.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 22:30:20 -0800 (PST)
Date: Tue, 6 Jan 2026 14:26:45 +0800
From: Coiby Xu <coxu@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	Thomas Staudt <tstaudt@de.ibm.com>, Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>, 
	Baoquan he <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Pingfan Liu <kernelfans@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc/kdump: pass dm-crypt keys to kdump kernel
Message-ID: <aVyqc_0FALlTV8Ad@Rk>
References: <20251226140636.1378505-1-coxu@redhat.com>
 <e32554c8-774e-416d-92e4-306aec42b953@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <e32554c8-774e-416d-92e4-306aec42b953@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: S4E3oA2cTzH977wzuvWjkbC5ivoAUhODF2LB6Ypk7rM_1767681022
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260105_223025_958561_15E17AC9 
X-CRM114-Status: GOOD (  21.30  )
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

On Thu, Jan 01, 2026 at 08:36:09PM +0530, Sourabh Jain wrote:
>
>
>On 26/12/25 19:36, Coiby Xu wrote:
>>Based on the CONFIG_CRASH_DM_CRYPT feature, this patch adds
>>LUKS-encrypted device dump target support to PowerPC by addressing two
>>challenges [1],
>>  - Kdump kernel may not be able to decrypt the LUKS partition. For some
>>    machines, a system administrator may not have a chance to enter the
>>    password to decrypt the device in kdump initramfs after the 1st kernel
>>    crashes
>>
>>  - LUKS2 by default use the memory-hard Argon2 key derivation function
>>    which is quite memory-consuming compared to the limited memory reserved
>>    for kdump.
>>
>>1st kernel will build up the kernel command parameter dmcryptkeys as
>>similar to elfcorehdr to pass the memory address of the stored info of
>>dm-crypt keys to the kdump kernel.
>>
>>[1] https://lore.kernel.org/all/20250502011246.99238-1-coxu@redhat.com/
>>
>>Cc: Thomas Staudt <tstaudt@de.ibm.com>
>>Cc: Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>
>>Cc: Baoquan he <bhe@redhat.com>
>>Cc: Dave Young <dyoung@redhat.com>
>>Cc: Kairui Song <ryncsn@gmail.com>
>>Cc: Pingfan Liu <kernelfans@gmail.com>
>>Cc: Andrew Morton <akpm@linux-foundation.org>
>>Signed-off-by: Coiby Xu <coxu@redhat.com>
>>---
>>  arch/powerpc/include/asm/kexec.h |  3 ++-
>>  arch/powerpc/kexec/elf_64.c      | 26 +++++++++++++++++++++++++-
>>  arch/powerpc/kexec/file_load.c   | 19 +++++++++++--------
>>  3 files changed, 38 insertions(+), 10 deletions(-)
>>
>>diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
>>index bd4a6c42a5f3..f3d098d543b4 100644
>>--- a/arch/powerpc/include/asm/kexec.h
>>+++ b/arch/powerpc/include/asm/kexec.h
>>@@ -80,7 +80,8 @@ struct kimage_arch {
>>  };
>>  char *setup_kdump_cmdline(struct kimage *image, char *cmdline,
>>-			  unsigned long cmdline_len);
>>+			  unsigned long cmdline_len,
>>+			  char *name, unsigned long addr);
>>  int setup_purgatory(struct kimage *image, const void *slave_code,
>>  		    const void *fdt, unsigned long kernel_load_addr,
>>  		    unsigned long fdt_load_addr);
>>diff --git a/arch/powerpc/kexec/elf_64.c b/arch/powerpc/kexec/elf_64.c
>>index 5d6d616404cf..57cb3361d91b 100644
>>--- a/arch/powerpc/kexec/elf_64.c
>>+++ b/arch/powerpc/kexec/elf_64.c
>>@@ -81,13 +81,37 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
>>  		/* Setup cmdline for kdump kernel case */
>>  		modified_cmdline = setup_kdump_cmdline(image, cmdline,
>>-						       cmdline_len);
>>+						       cmdline_len,
>>+						       "elfcorehdr",
>>+						       image->elf_load_addr);
>>  		if (!modified_cmdline) {
>>  			pr_err("Setting up cmdline for kdump kernel failed\n");
>>  			ret = -EINVAL;
>>  			goto out;
>>  		}
>>  		cmdline = modified_cmdline;
>>+		cmdline_len = strlen(cmdline) + 1;
>>+
>>+		ret = crash_load_dm_crypt_keys(image);
>>+		if (ret == -ENOENT) {
>>+			kexec_dprintk("No dm crypt key to load\n");
>>+		} else if (ret) {
>>+			pr_err("Failed to load dm crypt keys\n");
>>+			return ERR_PTR(ret);
>>+		}
>>+
>>+		if (image->dm_crypt_keys_addr != 0) {
>>+			modified_cmdline = setup_kdump_cmdline(image, cmdline,
>>+							       cmdline_len,
>>+							       "dmcryptkeys",
>>+							       image->dm_crypt_keys_addr);
>>+			if (!modified_cmdline) {
>>+				pr_err("Setting up cmdline for kdump kernel failed\n");
>>+				ret = -EINVAL;
>>+				goto out;
>>+			}
>>+			cmdline = modified_cmdline;
>>+		}
>>  	}
>>  	if (initrd != NULL) {
>>diff --git a/arch/powerpc/kexec/file_load.c b/arch/powerpc/kexec/file_load.c
>>index 4284f76cbef5..e1c08050286d 100644
>>--- a/arch/powerpc/kexec/file_load.c
>>+++ b/arch/powerpc/kexec/file_load.c
>>@@ -23,38 +23,41 @@
>>  #define SLAVE_CODE_SIZE		256	/* First 0x100 bytes */
>>  /**
>>- * setup_kdump_cmdline - Prepend "elfcorehdr=<addr> " to command line
>>+ * setup_kdump_cmdline - Prepend "<name>=<addr> " to command line
>>   *                       of kdump kernel for exporting the core.
>>   * @image:               Kexec image
>>   * @cmdline:             Command line parameters to update.
>>   * @cmdline_len:         Length of the cmdline parameters.
>>+ * @name:                Name e.g elfcorehdr.
>>+ * @addr:                Memory address.
>>   *
>>   * kdump segment must be setup before calling this function.
>>   *
>>   * Returns new cmdline buffer for kdump kernel on success, NULL otherwise.
>>   */
>>  char *setup_kdump_cmdline(struct kimage *image, char *cmdline,
>>-			  unsigned long cmdline_len)
>>+			  unsigned long cmdline_len,
>>+			  char *name, unsigned long addr)
>>  {
>>-	int elfcorehdr_strlen;
>>+	unsigned long parameter_len;
>>  	char *cmdline_ptr;
>>  	cmdline_ptr = kzalloc(COMMAND_LINE_SIZE, GFP_KERNEL);
>>  	if (!cmdline_ptr)
>>  		return NULL;
>>-	elfcorehdr_strlen = sprintf(cmdline_ptr, "elfcorehdr=0x%lx ",
>>-				    image->elf_load_addr);
>>+	parameter_len = sprintf(cmdline_ptr, "%s=0x%lx ", name, addr);
>>-	if (elfcorehdr_strlen + cmdline_len > COMMAND_LINE_SIZE) {
>>-		pr_err("Appending elfcorehdr=<addr> exceeds cmdline size\n");
>>+	if (parameter_len + cmdline_len > COMMAND_LINE_SIZE) {
>>+		pr_err("Appending %s=<addr> exceeds cmdline size\n", name);
>>  		kfree(cmdline_ptr);
>>  		return NULL;
>>  	}
>>-	memcpy(cmdline_ptr + elfcorehdr_strlen, cmdline, cmdline_len);
>>+	memcpy(cmdline_ptr + parameter_len, cmdline, cmdline_len);
>>  	// Ensure it's nul terminated
>>  	cmdline_ptr[COMMAND_LINE_SIZE - 1] = '\0';
>>+	kfree(cmdline);
>
>When setup_kdump_cmdline() is called for elfcorehdr, cmdline holds the
>same pointer as image->cmdline_buf. Freeing it here may therefore
>cause issues, right?

Yes, you are right, I'll drop the above kfree in next version.

>
>Currently, image->cmdline_buf is not used after calling the
>architecture-specific load function (elf64_load on powerpc).
>However, kimage_file_post_load_cleanup() later calls kfree() on
>the same address.

I missed kimage_file_post_load_cleanup. Thanks for pointing it out!


-- 
Best regards,
Coiby


