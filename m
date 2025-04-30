Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE83C3ABA9
	for <kexec@archiver.kernel.org>; Wed, 30 Apr 2025 14:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QBafi4wy61at6m9m8dlEpfvo5N42mzCjz/Tvd2WuLBw=; b=m6BqRBv8pp4BFyNjYjU5TG6PWA
	+PWSjmfyECcqI+Ke57NW7t1X2FHoeymCoKx9P9y2ektRikQBfduhKK4RPKkqqs4wO7C2JZDvIz4rF
	MWz1TsQWjWRBpTQ+BM/3EBEG1R4ue0gyaI+xd/rGlsohfiXNMJEk2xJyOVLJ8bBLvxXSJgJBR0k1w
	+OlbjZeN6q3h64cz97OYz0yOlOA3nhNZbzuXiwHY3W3qI4ycIIx/visMosHN/iEM/Sy2iHKehbCZ9
	Qb58PTNAt5ayvdXvdWzYRCh0f+Qa6SlQY8VBwLdDnFQk3/2LUkBbCRVPKrlSZknLRzeVSjXxSl5Gj
	g3EYs7rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA8kf-0000000DAtL-3KQZ;
	Wed, 30 Apr 2025 14:49:33 +0000
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uA8je-0000000DAg2-1Jii
	for kexec@lists.infradead.org;
	Wed, 30 Apr 2025 14:48:31 +0000
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-43cf848528aso53033835e9.2
        for <kexec@lists.infradead.org>; Wed, 30 Apr 2025 07:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clever-cloud.com; s=google; t=1746024508; x=1746629308; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QBafi4wy61at6m9m8dlEpfvo5N42mzCjz/Tvd2WuLBw=;
        b=UEmwraRHN1qomE2N1//Y9CroN/H925ThpniUbr321qxgq6vX5jyOxqaiXJOpSDaNHa
         xj1ULiJWIHr0uD6Zk+JmWCM/Nub6UV88bXlQTHccFBC+HG/HHqNQowYnLngVvSjsbGHT
         /Bb4+MK1peZhNbAzQqdaYdmpvB15kUKidsLpS/Fet+z5XIydecng2hMSRaMF4FmD2wBq
         84egQoZ/rWfRCrmZhWGxpP9ivFOCb3fYI9wFjJ++kwfrzyxz9577dOQi4vqi6WWq7oVY
         NcTvpU5GWzb2TagSJQjDeRi4Oz7adacbrNkAUAzPONEqCwJKUfrTNC6rLbz71ZrfHcb+
         0J3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746024508; x=1746629308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBafi4wy61at6m9m8dlEpfvo5N42mzCjz/Tvd2WuLBw=;
        b=HoeWlufSbcBQN7tbvLTr4G2zz58qLGAYtjTaTJZSGIRwINlxgXoh+6bFHZtMklTQIr
         HRYnXCYv1J13oefdiTHGcyY4CGPLf7tBrIr18G64mQipzIIWx8vV7gQnD+Q6UNByjubJ
         idJxWRGpwP3OTQg3wk1b+c21gP6YPgc12iZ5EATC6cbsSX9Ep4qYvgeDzIMyHX17k5wD
         stCK1wpSRr/14l/9bYMh0z8jHuXqfFJQozW7NXG5seUiPmzoH7MtIH12SgG7r3JpF27r
         1T4H1XcslL0zOwYdZBWXta7P5uxSJNLJgsE50MdTvDACkMA8EWokCb3SuCCZuhxchgEe
         ZWdA==
X-Gm-Message-State: AOJu0YztbxmF/+f5gQYPIhJ8/EQMX2j4SI8caqtzbBSzHjIsreZt46hc
	m+X7ZPx6i2O0rHAUtNNm5C02OghjWl6LMeZuYfWVaLdZ1SdeBQ0pxmZW4eEVNU0=
X-Gm-Gg: ASbGncvpJi3Ayo9PVD+XAtzIngdgCqRm1EUJLVhOo+D52GLRJf/e8yumpzghhaNXf0G
	cIXgTL3fjDIQtLXwvbQh6RKPIGHJFiapSmb02BLyWCfYAd0XOWCDthCCKQBfli/qxLEitqjKuBf
	y/4n1qY2cOMBp/GX3BJsn0nYSgBzehhXv/+NeYz4iVrJN1RuLKLQP7URB3d0e42mfrctWHg8fRD
	Ir2v+IwEJ9x/QAq82OosdHYHJvDKkPNbE3VSpbylCwaFK5N5jPq873c7CzrirJXRXzKVoY9f52/
	bn7/YknoMWf7ZSQNaV5qxHM8VJ8vx/Rx0r/KrBI/4uiiEFxEffZ5FDwlNrlxICg9gEJ99rIVdbV
	flSzvCccJaRhnNb+4s1ihPXniwC/HDJk8UHW6xJxtiGjf
X-Google-Smtp-Source: AGHT+IFM1f/VQjEUzanLgfNlKL8+eZe9frOBhk8fG9VNEkHSwxq81/XTCkO1SajflF9iftLCBa6EiA==
X-Received: by 2002:a05:600c:4e4d:b0:43b:c284:5bc2 with SMTP id 5b1f17b1804b1-441b1dfb252mr36438585e9.0.1746024508186;
        Wed, 30 Apr 2025 07:48:28 -0700 (PDT)
Received: from exherswag (2a01cb059441a4004633a140b8a72842.ipv6.abo.wanadoo.fr. [2a01:cb05:9441:a400:4633:a140:b8a7:2842])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2ba4a5fsm27740485e9.12.2025.04.30.07.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 07:48:27 -0700 (PDT)
Date: Wed, 30 Apr 2025 16:48:25 +0200
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
Message-ID: <c2mqpzhtyrd5qzove5pa44ob2iiwdcrtnj655sozy2a4pprln7@mql5bjuwjbxs>
References: <20250207080818.129165-1-coxu@redhat.com>
 <20250207080818.129165-7-coxu@redhat.com>
 <fa6uyhukjfjgteptdpud6wd6w7yin466p3tp6rdxwbsuqgkfdc@jwgf5ztb2ni7>
 <rwetpbjimryr7g7xmdmaeuwkdasyqdpejsy4sdee3kzlssm32s@5xnznwqa3ivm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <rwetpbjimryr7g7xmdmaeuwkdasyqdpejsy4sdee3kzlssm32s@5xnznwqa3ivm>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250430_074830_369916_DDFEC8B4 
X-CRM114-Status: GOOD (  26.89  )
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

On Tue, Apr 29, 2025 at 05:40:21PM +0800, Coiby Xu wrote:
>On Wed, Apr 23, 2025 at 10:59:06PM +0200, Arnaud Lefebvre wrote:
>>>diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
>>>index 68530fad05f7..5604a5109858 100644
>>>--- a/arch/x86/kernel/kexec-bzimage64.c
>>>+++ b/arch/x86/kernel/kexec-bzimage64.c
>>>@@ -76,6 +76,10 @@ static int setup_cmdline(struct kimage *image, struct boot_params *params,
>>>	if (image->type == KEXEC_TYPE_CRASH) {
>>>		len = sprintf(cmdline_ptr,
>>>			"elfcorehdr=0x%lx ", image->elf_load_addr);
>>>+
>>>+		if (image->dm_crypt_keys_addr != 0)
>>>+			len += sprintf(cmdline_ptr + len,
>>>+					"dmcryptkeys=0x%lx ", image->dm_crypt_keys_addr);
>
>sprintf will return the length of dmcryptkey=xxx which will be added to
>len.
>
>>>	}
>>>	memcpy(cmdline_ptr + len, cmdline, cmdline_len);
>>>	cmdline_len += len;
>
>Then cmdline_len will included the new len.

Yes, the cmdline_len is correct. No issue there.

>
>>
>>You are adding another kernel parameter but I believe without taking its
>>length into account. See the MAX_ELFCOREHDR_STR_LEN constant which is added to the
>>params_cmdline_sz variable for the elfcorehdr= parameter.
>
>Thanks for raising the concern! I believe this issue has already been
>took care of. Please check the above two inline comments:)
>

I'm sorry but I don't think it is. If you look at my comments below:

>
>>
>>This will (at least during my tests) truncate the cmdline given to the crash kernel because
>>the next section (efi_map_offset) will have an offset starting inside the cmdline section
>>and it might overwrite the end of it:
>>
>>kexec-bzimage64.c:480:
>>params_cmdline_sz = sizeof(struct boot_params) + cmdline_len +
>>			MAX_ELFCOREHDR_STR_LEN; <<< Should have + 31 here for "dmcryptkeys=0x<ptr> "
>>params_cmdline_sz = ALIGN(params_cmdline_sz, 16);
>>kbuf.bufsz = params_cmdline_sz + ALIGN(efi_map_sz, 16) +
>>			sizeof(struct setup_data) +
>>			sizeof(struct efi_setup_data) +
>>			sizeof(struct setup_data) +
>>			RNG_SEED_LENGTH;
>>
>>And I believe the buffer might be too small.
>>
>>Also, there is another check a few lines above that needs to take the size into account:
>>
>>/*
>>* In case of crash dump, we will append elfcorehdr=<addr> to
>>* command line. Make sure it does not overflow
>>*/
>>if (cmdline_len + MAX_ELFCOREHDR_STR_LEN > header->cmdline_size) {
>>	pr_err("Appending elfcorehdr=<addr> to command line exceeds maximum allowed length\n");
>>	return ERR_PTR(-EINVAL);
>>}
>>
>

To try to explain a bit more, we pass a lot of arguments to the crash kernel so
the initrd (dracut) can mount the encrypted disk. When I run kexec using
the following:

/usr/host/bin/kexec --debug --load-panic /linux-hv '--append=maxcpus=1
reset_devices rd.info rd.cc.kdump root=UUID=d039277c-2ee
3-466a-85eb-db9524398135 console=ttyS0 rd.timeout=10 rd.shell=1
rd.cc.kdump.encrypted
rd.cc.kdump.device=UUID=908234b1-c1f3-4150-bfdf-c260907a2447
rd.cc.kdump.keyring=cryptsetup:908234b1-c1f3-4150-bfdf-c260907a2447' --initrd
/crash-initrd

kexec debug print those logs:

<snip>
[   53.642483] kexec-bzImage64: Loaded purgatory at 0xb6ffb000
[   53.642828] kexec-bzImage64: Loaded boot_param, command line and misc at
0xb6ff9000 bufsz=0x12f0 memsz=0x2000
[   53.643366] kexec-bzImage64: Loaded 64bit kernel at 0xb1000000
bufsz=0x16a5000 memsz=0x550d000
[   53.643918] kexec-bzImage64: Loaded initrd at 0xaeb90000 bufsz=0x246f2a1
memsz=0x246f2a1
[   53.644363] kexec-bzImage64: Final command line is: elfcorehdr=0x77000000
dmcryptkeys=0xa81fc000 maxcpus=1 reset_devices rd.info rd.cc.kdump
root=UUID=d039277c-2ee3-466a-85eb-db9524398135  console=ttyS0 rd.timeout=10
rd.shell=1 rd.cc.kdump.encrypted
rd.cc.kdump.device=UUID=908234b1-c1f3-4150-bfdf-c260907a2447
rd.cc.kdump.keyring=cryptsetup:908234b1-c1f3-4150-bfdf-c260907a2447
<snip>

Here, we see the full command line, as expected. But when I trigger a panic
using `echo c > /proc/sysrq-trigger`, the first two lines of the crash kernel
loading are:

[    0.000000] Linux version 6.12.23+ (arnaud@exherbo) (gcc (GCC) 12.3.0, GNU ld
(GNU Binutils) 2.44) #4 SMP Wed Apr 30 16:11:39 CEST 2025
[    0.000000] Command line: elfcorehdr=0x77000000 dmcryptkeys=0x9ec14000
maxcpus=1 reset_devices rd.info rd.cc.kdump
root=UUID=d039277c-2ee3-466a-85eb-db9524398135 console=ttyS0 rd.timeout=10
rd.shell=1 rd.cc.kdump.encrypted
rd.cc.kdump.device=UUID=908234b1-c1f3-4150-bfdf-c260907a2447
rd.cc.kdump.keyring=cryptsetup:908234b1-c1f3-4150-bfdf-c26090

You can see some of it is truncated at the end. It's missing `7a2447`. This is
because I guess it gets overridden.

My comment above explains where and why it might happen. If I add the size of
the dmcryptkeys string length to the params_cmdline_sz variable, we should
allocate enough space to have it all. With the patch below, it works fine and I
get the full cmdline when my crash kernel boots:

[    0.000000] Linux version 6.12.23+ (arnaud@exherbo) (gcc (GCC) 12.3.0, GNU ld
(GNU Binutils) 2.44) #3 SMP Thu Apr 24 16:42:18 CEST 2025
[    0.000000] Command line: elfcorehdr=0x77000000 dmcryptkeys=0xa81fc000
maxcpus=1 reset_devices rd.info rd.cc.kdump
root=UUID=d039277c-2ee3-466a-85eb-db9524398135 console=ttyS0 rd.timeout=10
rd.shell=1 rd.cc.kdump.encrypted
rd.cc.kdump.device=UUID=908234b1-c1f3-4150-bfdf-c260907a2447
rd.cc.kdump.keyring=cryptsetup:908234b1-c1f3-4150-bfdf-c260907a2447


diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 5604a5109858..06fc1f412af4 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -27,6 +27,7 @@
  #include <asm/kexec-bzimage64.h>
  
  #define MAX_ELFCOREHDR_STR_LEN	30	/* elfcorehdr=0x<64bit-value> */
+#define MAX_DMCRYPTKEYS_STR_LEN 31
  
  /*
   * Defines lowest physical address for various segments. Not sure where
@@ -434,7 +435,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
  	 * In case of crash dump, we will append elfcorehdr=<addr> to
  	 * command line. Make sure it does not overflow
  	 */
-	if (cmdline_len + MAX_ELFCOREHDR_STR_LEN > header->cmdline_size) {
+	if (cmdline_len + MAX_ELFCOREHDR_STR_LEN + MAX_DMCRYPTKEYS_STR_LEN > header->cmdline_size) {
  		pr_err("Appending elfcorehdr=<addr> to command line exceeds maximum allowed length\n");
  		return ERR_PTR(-EINVAL);
  	}
@@ -478,7 +479,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
  	 */
  	efi_map_sz = efi_get_runtime_map_size();
  	params_cmdline_sz = sizeof(struct boot_params) + cmdline_len +
-				MAX_ELFCOREHDR_STR_LEN;
+				MAX_ELFCOREHDR_STR_LEN + MAX_DMCRYPTKEYS_STR_LEN;
  	params_cmdline_sz = ALIGN(params_cmdline_sz, 16);
  	kbuf.bufsz = params_cmdline_sz + ALIGN(efi_map_sz, 16) +
  				sizeof(struct setup_data) +


Let me know if it makes more sense!

