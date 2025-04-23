Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799D0C369CB
	for <kexec@archiver.kernel.org>; Wed, 23 Apr 2025 20:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X8rBmkOf4aIvYi3I8FgBy0awmrD8H509/EVP5Ei1ytI=; b=45Is9yNEHeb6qtzWrD3hDiZ9C9
	kTig6oIFX6HdO+55qfLCv24W3IEdgLDTmo7IhlCloJwwFg/F7EY2X2tFNTJQn18KQUUuwtEXdSRAN
	RR8L1q/taruDHKrkhVXRqEjVFPVrsmdn0UQ5iVg+TizJXSOtTfsrfIRpI+VEvdccg1h40goZtCz1x
	O1ERvu1X6xREJUdiHqMNFkcFpsU+KxQdiFoAiyZCIasnkea7dxafjIXJGzw+CcPlAREg3GWco1QTT
	iIz+X5B4a9TNxqftJhBUcXNEVmbP16apWsP4taQyWyAezVA04Yn3Hh+5BABJJsd9arYpgSyWTMr81
	xtqWU91A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7hBX-0000000C25z-46Ru;
	Wed, 23 Apr 2025 20:59:11 +0000
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7hBV-0000000C25U-1tqY
	for kexec@lists.infradead.org;
	Wed, 23 Apr 2025 20:59:10 +0000
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3913d129c1aso237197f8f.0
        for <kexec@lists.infradead.org>; Wed, 23 Apr 2025 13:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clever-cloud.com; s=google; t=1745441948; x=1746046748; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X8rBmkOf4aIvYi3I8FgBy0awmrD8H509/EVP5Ei1ytI=;
        b=PbykP/bVPhpkYhmMqtO8SndLvHyseB4brh9kPu6lHkXwgKPHn0pw1rPa7U58j5fGYh
         haRLT23o1F0SOOo9Cxbe01t5kjJ+kAv89DyRQ/xSAT1T2epWLS7Q4jRUwHQnB6hS6LKa
         Rq8Js+ejfEGRpnG/RBJL69MY4LyYPiQtQ+0OGTA4H8KSJYD7yyeADm60kwF+wK1EEhS5
         JYw9zWAs0ow2TmyiwkL8uqtIVAc34VawOcfltzAsWgt5NX3p2gD+CkHhUbC0uv4qofMC
         jqE0lOWVVNBqqaGyiPlySrGR4v+O9TonWk+6kzjONzliu6HCQxSMR8XXQHGlOuayP7pe
         nkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745441948; x=1746046748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8rBmkOf4aIvYi3I8FgBy0awmrD8H509/EVP5Ei1ytI=;
        b=Jxo/vDswbYhSV3+ylyHk5bBEw0+txWlefQNMSiuQQfvRRlH8jcKq3G6i+SilQyx/j+
         qFuf2zIUjWd8rPqHeIdnTJrDAQupsG5UXiVsbR6jCzqXFa144FAKzdISZBWIQEhbQncg
         njoX9AI4V6jONoMc4QFYIq4mWCvAk7/4Vl3+uwoIT1lRJUN4oPWORIOZyaPKiF0b0sMK
         8LVjfot1DICnUqO/4uorjajTzsUcDfWzi/FdW6G/UCV8s7Pl5uCxXK+H0hk0lfBIE0gG
         P79iG1tYJTLEEgfWTM6XTjYvHekTWjm3qh00lF3SeMs2DhYK+R0E5KS2o+03FRNrqkVm
         pyGw==
X-Gm-Message-State: AOJu0YxdrdyibAOvOqOuvgXCsOONe7z+8VSf6oSJadA7VJx7laDSbxeh
	UljTWvPZ5zB+5vE287wKhfsneRO/Pa3dabE7G/xH5RFmHBLX/Ugf7WsQIwM5cTw=
X-Gm-Gg: ASbGncuGRLEwga/UsfyTQtW5iQ0wvFxQqHpOGuGoBBQL+/pnjXHNOR7f2GoWMMQlr4H
	wGtEx4fQ9wLJgrNG8hYZyxM3Nf3Nj2bVUQYWUo8AvBAJzI8RGwo6FD8EfTP1Ieh1KvirExUPkHM
	XUqLF56Rj0m+u2FGXnW8tm4flNrbY7a0H+QaYtzAsS+wbFS0YM967S/2N9+Khv3N9Huy/cL7zTk
	/pMDEXRvsB4/JyVTqytz16kn30CuzPtDNiGLjG8BbIup4FR1XNpeCn/MFIUI0N+4lNdLAd71du0
	F7RFhSDGHEKphW5ps1rtCels8rVKKOW/6RRmc4puBRYivNE7TxzSQGSw
X-Google-Smtp-Source: AGHT+IEC8NhWZ4nFelT85eBp6fi4TvPQ6Kzx7d5h/Km9A9mjgSdikufYzNisns3RJyMikFxJ1y2KBQ==
X-Received: by 2002:a5d:5f4e:0:b0:39c:12ce:1112 with SMTP id ffacd0b85a97d-3a06ced244emr13792f8f.21.1745441947688;
        Wed, 23 Apr 2025 13:59:07 -0700 (PDT)
Received: from exherswag ([2a01:e34:ec5f:fb40:df48:ecab:7887:deaa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4931b8sm19625573f8f.80.2025.04.23.13.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 13:59:07 -0700 (PDT)
Date: Wed, 23 Apr 2025 22:59:06 +0200
From: Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Pingfan Liu <kernelfans@gmail.com>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Dave Hansen <dave.hansen@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v8 6/7] x86/crash: pass dm crypt keys to kdump kernel
Message-ID: <fa6uyhukjfjgteptdpud6wd6w7yin466p3tp6rdxwbsuqgkfdc@jwgf5ztb2ni7>
References: <20250207080818.129165-1-coxu@redhat.com>
 <20250207080818.129165-7-coxu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20250207080818.129165-7-coxu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_135909_494766_E528D337 
X-CRM114-Status: GOOD (  11.58  )
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

>diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
>index 68530fad05f7..5604a5109858 100644
>--- a/arch/x86/kernel/kexec-bzimage64.c
>+++ b/arch/x86/kernel/kexec-bzimage64.c
>@@ -76,6 +76,10 @@ static int setup_cmdline(struct kimage *image, struct boot_params *params,
> 	if (image->type == KEXEC_TYPE_CRASH) {
> 		len = sprintf(cmdline_ptr,
> 			"elfcorehdr=0x%lx ", image->elf_load_addr);
>+
>+		if (image->dm_crypt_keys_addr != 0)
>+			len += sprintf(cmdline_ptr + len,
>+					"dmcryptkeys=0x%lx ", image->dm_crypt_keys_addr);
> 	}
> 	memcpy(cmdline_ptr + len, cmdline, cmdline_len);
> 	cmdline_len += len;

You are adding another kernel parameter but I believe without taking its
length into account. See the MAX_ELFCOREHDR_STR_LEN constant which is added to the
params_cmdline_sz variable for the elfcorehdr= parameter.

This will (at least during my tests) truncate the cmdline given to the crash kernel because
the next section (efi_map_offset) will have an offset starting inside the cmdline section
and it might overwrite the end of it:

kexec-bzimage64.c:480:
params_cmdline_sz = sizeof(struct boot_params) + cmdline_len +
			MAX_ELFCOREHDR_STR_LEN; <<< Should have + 31 here for "dmcryptkeys=0x<ptr> "
params_cmdline_sz = ALIGN(params_cmdline_sz, 16);
kbuf.bufsz = params_cmdline_sz + ALIGN(efi_map_sz, 16) +
			sizeof(struct setup_data) +
			sizeof(struct efi_setup_data) +
			sizeof(struct setup_data) +
			RNG_SEED_LENGTH;

And I believe the buffer might be too small.

Also, there is another check a few lines above that needs to take the size into account:

/*
  * In case of crash dump, we will append elfcorehdr=<addr> to
  * command line. Make sure it does not overflow
  */
if (cmdline_len + MAX_ELFCOREHDR_STR_LEN > header->cmdline_size) {
	pr_err("Appending elfcorehdr=<addr> to command line exceeds maximum allowed length\n");
	return ERR_PTR(-EINVAL);
}

