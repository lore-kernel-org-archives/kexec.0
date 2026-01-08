Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C72BFD185C2
	for <kexec@archiver.kernel.org>; Thu,  8 Jan 2026 10:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q4CgrKoI+gqPjZdUskKAdxCjFm05f46fwS6i3N+5Edg=; b=ij1Lkan8AGrN8Q6qvWs7jCb4BP
	v3bSFcj/941nzx2v7GxZWLLGRzlfLflFRQPlKsJwdvTm1D+iVccLb9ADzHIMo8dc2HL8gZ79Gual7
	msEO4W8xkG1mQNGRxeFgIoabIEGcpTJHB0Qej7m7LJFQlRKCy0GYAXT6wPWwRXKpJMuT/w//jNf6g
	QW+Wi2gL4Hstx8rrAWDLy1upnVQ/LY5dTGKapfcRvu8vKqKW6dBTsXRHg2NaDbXgSdk8+ocBjWwB2
	dFOJ4/C/5uc78z5Oel2crLAx8BjXym+hm8u6gvPpNgqjtN3Xp5PElD8QCi9wH6mYDbIi7Xa6mEOsi
	++pwDhAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdnMb-0000000Gdxi-12nZ;
	Thu, 08 Jan 2026 10:35:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdnMU-0000000Gdx1-1rjC
	for kexec@lists.infradead.org;
	Thu, 08 Jan 2026 10:35:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767868524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4CgrKoI+gqPjZdUskKAdxCjFm05f46fwS6i3N+5Edg=;
	b=a6iNZwtwj68FrR08CGGPfZQ7h7LczQZi0bEvFPAPHNsQ5XLUOA85kAXGfzM1mMJV/9y+h5
	8Z5fZ8Q1fLiPupAkIRy0eR5k8/1Uq8NcCt/5UyJRMQw91/AMJp+0ukf8EIy+A55W5sxZ43
	UQpzbIqWWM7Xg0xzxzk97gZF5CvyrOw=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-srt3iIdINOWweU8jjVZQ-w-1; Thu, 08 Jan 2026 05:35:23 -0500
X-MC-Unique: srt3iIdINOWweU8jjVZQ-w-1
X-Mimecast-MFC-AGG-ID: srt3iIdINOWweU8jjVZQ-w_1767868522
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29f1f79d6afso45636655ad.0
        for <kexec@lists.infradead.org>; Thu, 08 Jan 2026 02:35:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767868522; x=1768473322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4CgrKoI+gqPjZdUskKAdxCjFm05f46fwS6i3N+5Edg=;
        b=L3aib+pL65PY5iJgkmCbwRfhB47lyjMS+C+lBg4Cg+dSjadgHaOYJIEQuOcW1HoN3T
         O6FOBCECZ5yuGHJZqFu4GcsQfxHJIIe5hrdaePoamrD/NLbxYfwhIMlPyiDTZ8Jk+vl/
         Xn3CQ6KYUwHItkg4HJAjumpImpjwsB/JjGuKULnRUOdxMcK5/KhjomF6/DCvOBWz1GyU
         RKwmcah1fZZFljKwJy6mvNmLdOhizOlnZ7QadVKsjoL2ITwjDyLI+wtp2IDWWF4axH/Y
         suAaCXg8bfYqapY6ztYpabqW99CILWuKQ8XvPGIqrN5ORtLLW294PyWn9p6upCAk8v9k
         Qv8g==
X-Gm-Message-State: AOJu0Yxu15lYDhaxbBbuQkGq7K3rjGR9Kg0ibYEPHOOW/aCXMmtOfTtv
	R/7unHwTTqPMJxGc++ATqND8SyXl38MFdziLOt0zdW3qsTmaSsvybP6z4hCJ/otjCfnPELHm1aZ
	FYlMmSb2bdeQ/96RDYKT/HdxowpbY5ISQI1FJEtgPveedVMI8v33ourVAejlR/Q==
X-Gm-Gg: AY/fxX4raud1ezUrZDfZpCZrnrdGtgnhdXCBWoJ6uNpUZKFQqc2Ls2N66DcSCx6RRZ5
	GWivm9mjG1P1YM++oAQ2hVXAShxmULdRWZc11ZC2ddgi30jQnwMYTGDVQCgs7uZ0uybsxMzGJzu
	HML5xbxZSSNYorHXtWbhbkC1lJOLajQi5Ds2WiY1akBeBuUlxX9EB7KipJwpDboM8yF7cWGMmFG
	vhUZtFNgDTv7TL4RdBCKHAhx8wwgCRYq2RvDM40YMtzpJ0e55/UPsINKwlC9IVhBJyk4lDmRcLG
	Bdq5UpNow7JK6wrUeNHT8mCTiyRk/UgcIpvZYNzSe9znbuEBIoNNGSXywhbcIwDzBBkO26T7mUR
	L
X-Received: by 2002:a17:903:46c5:b0:2a3:e89c:593e with SMTP id d9443c01a7336-2a3ee41f181mr62398225ad.4.1767868522227;
        Thu, 08 Jan 2026 02:35:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWb7Nq1EAzfMOaDGj/G/lGftVbslZgXtHq29CNW23TT+aB3wwbYZDR2hEBzPzfJM832bE6sw==
X-Received: by 2002:a17:903:46c5:b0:2a3:e89c:593e with SMTP id d9443c01a7336-2a3ee41f181mr62397775ad.4.1767868521555;
        Thu, 08 Jan 2026 02:35:21 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c48c2bsm74465035ad.26.2026.01.08.02.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 02:35:21 -0800 (PST)
Date: Thu, 8 Jan 2026 18:32:55 +0800
From: Coiby Xu <coxu@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	Thomas Staudt <tstaudt@de.ibm.com>, Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>, 
	Baoquan he <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Pingfan Liu <kernelfans@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Vivek Goyal <vgoyal@redhat.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] powerpc/kdump: pass dm-crypt keys to kdump kernel
Message-ID: <aV5F-T1nNumTTdgK@Rk>
References: <20251226140636.1378505-1-coxu@redhat.com>
 <20260106074039.564707-1-coxu@redhat.com>
 <9aa592c9-c766-4aac-a60c-25dd5c2f143d@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <9aa592c9-c766-4aac-a60c-25dd5c2f143d@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hE_f-3MbKEy5ifMTDILDArLQUn139xtjzwPH7SaLV4s_1767868522
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260108_023526_560115_B48DE970 
X-CRM114-Status: GOOD (  21.03  )
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

On Wed, Jan 07, 2026 at 02:32:41PM +0530, Sourabh Jain wrote:
>
>
>On 06/01/26 13:10, Coiby Xu wrote:
>>CONFIG_CRASH_DM_CRYPT has been introduced to support LUKS-encrypted
>>device dump target by addressing two challenges [1],
>>  - Kdump kernel may not be able to decrypt the LUKS partition. For some
>>    machines, a system administrator may not have a chance to enter the
>>    password to decrypt the device in kdump initramfs after the 1st kernel
>>    crashes
>>
>>  - LUKS2 by default use the memory-hard Argon2 key derivation function
>>    which is quite memory-consuming compared to the limited memory reserved
>>    for kdump.
>>
>>To also enable this feature for PowerPC, we only need to let 1st kernel
>>build up the kernel command parameter dmcryptkeys as similar to
>>elfcorehdr to pass the memory address of the stored info of dm-crypt
>>keys to the kdump kernel.
>>
>>Note to avoid a building failure [2] caused by undeclared function
>>crash_load_dm_crypt_keys when CONFIG_CRASH_DUMP is not enabled,
>>realign the function declaration with CONFIG_CRASH_DM_CRYPT.
>>
>>[1] https://lore.kernel.org/all/20250502011246.99238-1-coxu@redhat.com/
>>[2] https://lore.kernel.org/oe-kbuild-all/202512272218.ghBaSjzO-lkp@intel.com/
>>
>>Cc: Thomas Staudt <tstaudt@de.ibm.com>
>>Cc: Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>
>>Cc: Baoquan he <bhe@redhat.com>
>>Cc: Dave Young <dyoung@redhat.com>
>>Cc: Kairui Song <ryncsn@gmail.com>
>>Cc: Pingfan Liu <kernelfans@gmail.com>
>>Cc: Andrew Morton <akpm@linux-foundation.org>
>>Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
>>Signed-off-by: Coiby Xu <coxu@redhat.com>
>>---
>>v2:
>>- fix double kfree issue [Sourabh]
>>- corretly kfree old modified_cmdline
>>- use imperative mood for commit message
>>- fix a compiling error caught by kernel test robot
>>
>>  arch/powerpc/include/asm/kexec.h |  3 ++-
>>  arch/powerpc/kexec/elf_64.c      | 27 ++++++++++++++++++++++++++-
>>  arch/powerpc/kexec/file_load.c   | 18 ++++++++++--------
>>  include/linux/crash_core.h       | 14 +++++++-------
>>  4 files changed, 45 insertions(+), 17 deletions(-)
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
>>index 5d6d616404cf..995d7e8e98e1 100644
>>--- a/arch/powerpc/kexec/elf_64.c
>>+++ b/arch/powerpc/kexec/elf_64.c
>>@@ -81,13 +81,38 @@ static void *elf64_load(struct kimage *image, char *kernel_buf,
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
>
>I have a limited understanding of the new dm-crypt keys, but the way they
>are loaded and the additional command-line options added for the kdump
>kernel look good to me.
>
>Feel free to add:
>Acked-by: Sourabh Jain <sourabhjain@linux.ibm.com>

Thanks for reviewing and acknowledging the patch!

-- 
Best regards,
Coiby


