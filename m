Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18D3CDE008
	for <kexec@archiver.kernel.org>; Thu, 25 Jun 2026 10:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:Date:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QCLiqqbRf30CdU1t3fLSbC8vqU8dRqc0DXQEs6SNDTU=; b=iBDc6XXzBsn4bXcWPoq8POnifF
	1fVGKOij8hzuObomFvAOZiBJitnWKtOirhaYDFKz4z+YaAYG5QdhnrLQjiV8fuDkqCdRFQ8ciM+rQ
	4aJpQQR50/kBAHM/EhutDEgBfUogkOkiOtOUogoJPQ2Fh/tXEkJlOylQxxzOZZxJ5P3UUpkrLa5vn
	BPpCJ6jOhkLQijCtShBMNbOyECqJs31GVHeMprBPAdSB1h0Kal2A5ZArZZZVBfH+L/Hu9jyHQW/39
	ejERiyVLq8A9ZqNeUzh6eoWYnvfz2Phs9cgZS3ju8w8PcvO+njoV2Zh08lpo6K+n+aaigjk997kX1
	Uywcsq5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wchfU-000000092Hj-1wEW;
	Thu, 25 Jun 2026 10:50:48 +0000
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wchfR-000000092HN-2S85
	for kexec@lists.infradead.org;
	Thu, 25 Jun 2026 10:50:46 +0000
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-37df0b86a82so440956a91.0
        for <kexec@lists.infradead.org>; Thu, 25 Jun 2026 03:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782384644; x=1782989444; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QCLiqqbRf30CdU1t3fLSbC8vqU8dRqc0DXQEs6SNDTU=;
        b=EZNwVRwAV/wRIyHqBmG1+hHBqjbiPWtHzK9GZ6RmYw4085P1V6smnUbcJ33TZb4KPs
         t25LOtuH9oDMh9sDxqwJTi/Ce54ETfO34b7k6YhpLp14e+GwR7rLKX2qPDt87u6a3hHE
         kiOtYLTpeQ6rDsGGwkJN6axsyiPf2VGrQZVNxV8+NsQp7RGDpt8oq/ZXUTrapu8hARsX
         pxg+L/joMWo+FirjqPmwg+xyUMfxZDyyJYueb3ueRW9Gfhh7HPioQGzMUGxf12GKtPIG
         m/3BQwz6D4lKKW2sEubmrw1FSG/62SY6P0Dw0mkBB4VAXNnya70gfDN4Tiy6Jh4JUhjJ
         O5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782384644; x=1782989444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QCLiqqbRf30CdU1t3fLSbC8vqU8dRqc0DXQEs6SNDTU=;
        b=lIrzr3trxt+f1JFkpdcBS7v1/vNg3eeH26KDCV8ntLKiPkqSF157RxkWvmxrfTdAp6
         1H15KlWwNoidnvXfEbinsVz1uqpEXfuwgvy7SXDXET7lPMyXbSyjntmnUwXzMqb0/7DG
         DNy+3aCwKUM6hOwIUasSL3jWj9QqqP+Ia0XnWUfYezaG8j1NddlOLiPtl7BNXjPeFkoG
         XqlLYnD+j4+A6MPOakH39+jI4OS0BxmLWDkNkSXLvvWZuV5L1p4Y834yPkGIZ/2jAHva
         94vZ1fMtt9ON4a5wd6EhEN2mrPgHOaaiIHqODQJzQpJS4RWXjbOS46Dpu+nvuJD1g0vF
         5Dqg==
X-Forwarded-Encrypted: i=1; AHgh+RpKM6wsmkKzddJb+G7gGunZwE+BDYX+rx3RO+aAryk49qnQpLOPbi9yTZfzZyQrIS/DQvIJMA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw+8LsyV7ZuV2PHZeDSwoyUUwndNLFWo3mV+Z6Vo3ob0wRk62Aq
	d17FxlCGU20olAJ1i0+wlYTj8iVuRp2mQLUG2I7H1BA1Bua9pVBYdRUM
X-Gm-Gg: AfdE7cnncZiUsd3+OYNkjHXpKh9wy+Dlv0z4kwWDWL6yrFZcZe7E8EDVH9MOGD/zvrN
	jdiXsEw06rwh7pYbQlwT/m0XNI127/37DTR7FXhpew/bckEDNs573fwVTXORPRGcymwdGfqLZyP
	cOHPhrv0jpvVMS+YGAlc89HIcVqxZmEQuvjAdPokowNgvsAk7TZP4TPUygDNyUJJf48X+hWlrXR
	3+C+iyxu6k1xl80mcuYzYf7x7fQPkJ6uwWqzuTRey3xY++bTX3zjcCus3xvL4LqeElIDk4aavG3
	snxr+xu5yV+T0D/srvjaJdyFyvHBLYCIMlQ5Krbl2l74kty3PHVL/FWFbAlNgPAhRdkcQEONBpP
	gpETZDCGd1ObP1NN7FSQAk7TMcNmCBVzw9s5VTUxPaMIFZzFQ0++wrS+jBOfsAW88Dkzqxp4=
X-Received: by 2002:a17:903:228a:b0:2c1:88a1:9839 with SMTP id d9443c01a7336-2c7c3d60007mr102203315ad.11.1782384644034;
        Thu, 25 Jun 2026 03:50:44 -0700 (PDT)
Received: from localhost ([2a09:bac5:55fd:25b9::3c2:55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f5ae5ecfsm17660805ad.21.2026.06.25.03.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 03:50:43 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Thu, 25 Jun 2026 18:46:33 +0800
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <baoquan.he@linux.dev>, Vivek Goyal <vgoyal@redhat.com>, 
	Dave Young <ruirui.yang@linux.dev>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crash_dump: release keyring reference at the correct time
Message-ID: <aj0Ai72gTkrorkYI@Rk>
References: <20260603135056.1397084-1-lgs201920130244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260603135056.1397084-1-lgs201920130244@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260625_035045_628339_AB46F7ED 
X-CRM114-Status: GOOD (  16.97  )
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

Hi Guangshuo,

Thanks for sending this patch! Your fix is more complete than my version
https://lore.kernel.org/kexec/20260501234342.2518281-2-coiby.xu@gmail.com/
So I plan to drop mine from the patch set. I only have some nitpicking
for this patch. Please check inline comments.

On Wed, Jun 03, 2026 at 09:50:56PM +0800, Guangshuo Li wrote:
>restore_dm_crypt_keys_to_thread_keyring() gets a reference to the user
>keyring before restoring the saved dm-crypt keys.
>
>The same keyring reference is then passed to add_key_to_keyring() for each
>saved key, but add_key_to_keyring() drops that reference on every call.
>This is only balanced when exactly one key is restored. With multiple
>keys, the keyring reference is dropped too many times and may trigger a
>refcount underflow or use-after-free.

My testing shows when there are more than five keys to be added, this
"refcount_t: underflow; use-after" error can occur. Maybe you can
include this info in your commit msg.

>
>The early error paths after lookup_user_key() also return without dropping
>the keyring reference.
>
>Keep ownership of the keyring reference in
>restore_dm_crypt_keys_to_thread_keyring(), drop it once on all exit paths,
>and make add_key_to_keyring() only use the reference without consuming it.
>
>Fixes: 62f17d9df692 ("crash_dump: retrieve dm crypt keys in kdump kernel")
>Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
>---
> kernel/crash_dump_dm_crypt.c | 15 ++++++++++-----
> 1 file changed, 10 insertions(+), 5 deletions(-)
>
>diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>index a20d4097744a..641c290f1270 100644
>--- a/kernel/crash_dump_dm_crypt.c
>+++ b/kernel/crash_dump_dm_crypt.c
>@@ -80,7 +80,6 @@ static int add_key_to_keyring(struct dm_crypt_key *dm_key,
> 		kexec_dprintk("Error when adding key");
> 	}
>
>-	key_ref_put(keyring_ref);
> 	return r;
> }
>
>@@ -104,6 +103,7 @@ static int restore_dm_crypt_keys_to_thread_keyring(void)
> 	size_t keys_header_size;
> 	key_ref_t keyring_ref;

I think ordering local variables from longest line length to shortest line
length a.k.a Reverse Christmas Tree style is preferred i.e.
     int ret = 0;
     u64 addr;


-- 
Best regards,
Coiby

