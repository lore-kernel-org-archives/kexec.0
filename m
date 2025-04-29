Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516EAC369DC
	for <kexec@archiver.kernel.org>; Tue, 29 Apr 2025 09:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OlWJ5SOttcQupos3aVHbzKCM3KJZPFw+aL6yodCqXTg=; b=mxRyF6F7wZYF5DekvwmVyBOEdT
	tFUgRCTBaEqhYKuGCsM04GcvFqY72DlDjwylDOSULj3KFkY/AoUZv7BFU05ulqcLC9pB8FwBVcTPI
	HvHe9XczS1hP8HvMoh9EVwH1U4N6YjXUrwvZKrgs6pL1Aj6FyAxJG/8T5e9mzQRAohyPRpelo1hff
	pof8vMtSw5VgtsQDvvHwo/ycf4sNPpUokW26p5AXGL++lYSGLjHJcxuFlqGmf6yOuX0Ma1GtAxadU
	g+YbsrfG7XbyQQjlWIX9DR9fF9vTmusLuQ332rv8iKyBsE3A048/cUAy56LLBesTj3yv8/6fG6TJJ
	sQt9yEEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9hVA-00000009BRU-3L97;
	Tue, 29 Apr 2025 09:43:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9hTW-00000009BHw-00xI
	for kexec@lists.infradead.org;
	Tue, 29 Apr 2025 09:42:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745919720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OlWJ5SOttcQupos3aVHbzKCM3KJZPFw+aL6yodCqXTg=;
	b=XIsyv9nvX3lP+aunZDGxWbSXj+ZBOUcnUq9V16qDLa3MILh9wfIaoC8xjIwHa2/51DwAv6
	0JsX5wqhoLefyZuh3SFfZLLQp6ejbJiSCNO6GZjzBFOADxqEAeT0ehIr7YBpJcYwG5i2ZX
	TYjyJ0+lT4p0IkbRVX0prGJHU2C0guI=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-EbusawQiN6CHr_a5KqlcPQ-1; Tue, 29 Apr 2025 05:40:37 -0400
X-MC-Unique: EbusawQiN6CHr_a5KqlcPQ-1
X-Mimecast-MFC-AGG-ID: EbusawQiN6CHr_a5KqlcPQ_1745919636
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b00ce246e38so6063975a12.2
        for <kexec@lists.infradead.org>; Tue, 29 Apr 2025 02:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745919636; x=1746524436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlWJ5SOttcQupos3aVHbzKCM3KJZPFw+aL6yodCqXTg=;
        b=Epi4yKlrF4ps0R1MgqzqH0Z2FGoAwHfkDBtBG4gMkpU13AbqHayLa9BQTnTAAOD9hE
         rk+UoPfPvLYQDSUwI/4sF0vegbvsCZRMdBiEezToDU11V/3bwQ6DktYDERvP1uPEZd1G
         r+TWGM1zA7OhNGWmD38CnZPbxaLaVO6Cs2X8GSbPlEEFLikDd4t2RVvJyewXq+haZFJH
         CRg8y0b3n8rT0EkilxuuE+LzAj1gJoXDdAuS8TDzoBhoJXgcbxuEcoVXa8bumkcQluov
         v3SdXNx9g5ZjPxOz4chzLaCykkqaD+/2opY2Y/4ySeTnVHR3ETd3YZWSVB0y12AV+/Aa
         gfng==
X-Gm-Message-State: AOJu0Yx/944ExKoIsASIfG8bYQrFOZKjGKIr29a6wj4Wa7rWkp0oT9CA
	3ETfoELU9+E5b3ombQvc3XsBpejZFrWR6/J/Hujprl9Hhf+KrKz+GEfjux2NSWJT4ZlSY7WpChU
	UysFuhfa1UtU0rP/ODud6kulnBV0WiDQZimwI1AAaxDAAhyRMFebuGw145g==
X-Gm-Gg: ASbGnctD/Rpb4Nxforl61URVgf+NUQzAVC69JF/ivTgQ+zOR+S7xqjVIHLBJ9JYFRxm
	GcYH5UdD5HvcO1sqF5p0S5Ks5DMV2kdVUB2RBbW/3HKkvDcg1mCHVVyCxtDjAKrqsoOOb35tiid
	neWjPXpSfdAMeLK5fIAxPFpYhIuxOgkcnnflQEUlQowT0hoqHv7zWai0wZITinKKXkfazbgTB1+
	BjXHtBoHwexd++d9pdisnfPO2Aznwf+aJtRbhWtr7Na3IfJWJuXao1QsOMYDqdt9z7tQ3a8cKjU
	BOI=
X-Received: by 2002:a05:6a20:d48b:b0:1f5:8678:183d with SMTP id adf61e73a8af0-2046a4664c2mr16009533637.14.1745919636490;
        Tue, 29 Apr 2025 02:40:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7gEjku+ZpVt/qDtNHhW6HIJZl8Z51nAZpzs1vZoq3o460vaQWQG9eqlKMDsZkZdnRqTXCEg==
X-Received: by 2002:a05:6a20:d48b:b0:1f5:8678:183d with SMTP id adf61e73a8af0-2046a4664c2mr16009502637.14.1745919636084;
        Tue, 29 Apr 2025 02:40:36 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25aca38fsm9778532b3a.171.2025.04.29.02.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 02:40:35 -0700 (PDT)
Date: Tue, 29 Apr 2025 17:40:21 +0800
From: Coiby Xu <coxu@redhat.com>
To: Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>
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
Message-ID: <rwetpbjimryr7g7xmdmaeuwkdasyqdpejsy4sdee3kzlssm32s@5xnznwqa3ivm>
References: <20250207080818.129165-1-coxu@redhat.com>
 <20250207080818.129165-7-coxu@redhat.com>
 <fa6uyhukjfjgteptdpud6wd6w7yin466p3tp6rdxwbsuqgkfdc@jwgf5ztb2ni7>
MIME-Version: 1.0
In-Reply-To: <fa6uyhukjfjgteptdpud6wd6w7yin466p3tp6rdxwbsuqgkfdc@jwgf5ztb2ni7>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CjGQRV04p-xpoASIGP-ERXDaHiFdN5EqVQTQiGwVzdg_1745919636
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_024202_114845_ED1FDBFB 
X-CRM114-Status: GOOD (  18.10  )
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

On Wed, Apr 23, 2025 at 10:59:06PM +0200, Arnaud Lefebvre wrote:
>>diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
>>index 68530fad05f7..5604a5109858 100644
>>--- a/arch/x86/kernel/kexec-bzimage64.c
>>+++ b/arch/x86/kernel/kexec-bzimage64.c
>>@@ -76,6 +76,10 @@ static int setup_cmdline(struct kimage *image, struct boot_params *params,
>>	if (image->type == KEXEC_TYPE_CRASH) {
>>		len = sprintf(cmdline_ptr,
>>			"elfcorehdr=0x%lx ", image->elf_load_addr);
>>+
>>+		if (image->dm_crypt_keys_addr != 0)
>>+			len += sprintf(cmdline_ptr + len,
>>+					"dmcryptkeys=0x%lx ", image->dm_crypt_keys_addr);

sprintf will return the length of dmcryptkey=xxx which will be added to
len.

>>	}
>>	memcpy(cmdline_ptr + len, cmdline, cmdline_len);
>>	cmdline_len += len;

Then cmdline_len will included the new len.

>
>You are adding another kernel parameter but I believe without taking its
>length into account. See the MAX_ELFCOREHDR_STR_LEN constant which is added to the
>params_cmdline_sz variable for the elfcorehdr= parameter.

Thanks for raising the concern! I believe this issue has already been
took care of. Please check the above two inline comments:)


>
>This will (at least during my tests) truncate the cmdline given to the crash kernel because
>the next section (efi_map_offset) will have an offset starting inside the cmdline section
>and it might overwrite the end of it:
>
>kexec-bzimage64.c:480:
>params_cmdline_sz = sizeof(struct boot_params) + cmdline_len +
>			MAX_ELFCOREHDR_STR_LEN; <<< Should have + 31 here for "dmcryptkeys=0x<ptr> "
>params_cmdline_sz = ALIGN(params_cmdline_sz, 16);
>kbuf.bufsz = params_cmdline_sz + ALIGN(efi_map_sz, 16) +
>			sizeof(struct setup_data) +
>			sizeof(struct efi_setup_data) +
>			sizeof(struct setup_data) +
>			RNG_SEED_LENGTH;
>
>And I believe the buffer might be too small.
>
>Also, there is another check a few lines above that needs to take the size into account:
>
>/*
> * In case of crash dump, we will append elfcorehdr=<addr> to
> * command line. Make sure it does not overflow
> */
>if (cmdline_len + MAX_ELFCOREHDR_STR_LEN > header->cmdline_size) {
>	pr_err("Appending elfcorehdr=<addr> to command line exceeds maximum allowed length\n");
>	return ERR_PTR(-EINVAL);
>}
>

-- 
Best regards,
Coiby


