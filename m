Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6B6C55ABF
	for <kexec@archiver.kernel.org>; Thu,  6 Aug 2026 06:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:Date:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B/NHFXtKvpJgNsrg54qLLAZzpdpKsGUenXdJI9IHZDc=; b=e/JAp/DDQ5YWxviHlchKcRjzHO
	5+CKOnhSBmXv1+rD5dz4DxSGt79W7i5TxHwVAgr4mRTVOFUL06jndu+SL0GEUN360BSQczQypv8kb
	eJPMVvQc7pxQD/xncutnuCWg9IdclIppr5jLkE7cw5CcYIA6Wa+f8gcUDSgTX9eNiGBIWXVxXzlG0
	xuuFLVmr3m1VThx4ygS6xjpSi1aS0M1mQjcpXfRCTT9NRfv+0EzFe6Je2gLaMKvjnTuuScZumnLRo
	zfOKtOzwDv8GILuJQR64FK/To/9NFzE1JYWaPukhCqE6Uk3Qv3RrFv3iomG46zCbfycpOzBn8I5vb
	p1EKWruA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrrcJ-000000052jc-2wMJ;
	Thu, 06 Aug 2026 06:30:11 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrrcH-000000052j0-0Vyl
	for kexec@lists.infradead.org;
	Thu, 06 Aug 2026 06:30:10 +0000
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so570124a91.0
        for <kexec@lists.infradead.org>; Wed, 05 Aug 2026 23:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785997808; x=1786602608; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B/NHFXtKvpJgNsrg54qLLAZzpdpKsGUenXdJI9IHZDc=;
        b=HZfr64RaVZt54FWm5tyyLaLAWyVe1eS404l+zd51T9NVyq77ZuHckejPOfAulgpT9k
         GdcPMu/Xh6+PEyC6vrBfbDjVIQVIQfH5F4gefaveDc5s2vy61bFYIrvARhSMtz4yqu/q
         z7tNPIQ92Y/35XJTIdy8q9SdaIR0wXJGXVuUywCQFpxVqj+HNo1EXYVep+r2elmnAq1v
         mlyYOo1m/E1sc+AAc4/GImXa9P+Qv4mX1lTErO2afcFZsevNJWOQEtsHBvcT1Ja9l+OS
         NJSo5cTIQL2e3NckFFehDiLqN6D3NM9es30aIXQa2Q2i2eTcdG6yp3ztraM/xKvS3GZA
         35/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785997808; x=1786602608;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B/NHFXtKvpJgNsrg54qLLAZzpdpKsGUenXdJI9IHZDc=;
        b=gAfmR/ygMflgCHP0oMoD2WGR5kqxy8e7BEYHuPm/DKyj3Sd2/WkKnl+3G4IF9xa5CL
         g+ARmc5bxX5HS/uOm64goPfEetQqFgQxOUOD6Rw5k2nx0h+CiPXZ4QRLZsN3opu0KS/R
         xZ+M/Zz2T1lA2dPvvNYHDlgT68th9B8qjIJAEtcn4MAhWehUt0HRlwjOOKiiAB5OLP5X
         qDJNnpnYbM/Ism2Tb0rwgqZJw2f7lopEuKNP7i5vwCxsrRuqPAi/rf7+xg6XwvcoGSrN
         qjq0dPJVnDg5steFfOG5FruVpwmggHxZeuF3/ydburfdbvFeznyP6Mrqag/ajiMiH2Dj
         c9qQ==
X-Gm-Message-State: AOJu0YxXVOUispwIVDpqzodRJwL0DofxdMq5+2bs5KEug5+cVYfrwGQV
	IrjiWPp+S4tMiQgFCrhOwxvLy0JpSc4TfKc19VmfzmpkuBRh1kAkbzr5
X-Gm-Gg: AR+sD10rolqphCgZjX5/mm/KsscQGYBGy4F1gPPJoe8Ro5GpClwveUjnwgSYqpUqvg6
	Q5Fw3fmIjjR6r5APAOtTUujFWQa65aHky1B4RwIREDzLXThHCYS+Ydf9Ht3NoDJRdYcbchCTl8c
	cOPc0HGWx7+pzMts+iywtrZfwyWju+HEnR0We6BfkiYBW02rUDwIaZwAcH6LdAcRPmdycWDUXJL
	X11sQ7hzYeM/8ycIM8EHLkWZBjk9xnbsr68RRkSwfQkEy83twulb+K9uolwNxiJMSvVM2igpQOC
	BM0g3ap9nLkk89i4q2O/s7LZjHvvcKmbYXLrBU5+UnnfgXM8BtENfR5kGPEXp+V315EyML9IRRI
	mXyGMEaN3V/bXE7dBKr1eekYc8wH4LQlfBdc6m7bWh+Xh4cqPF2vhr/uTqfxEOZApZggpbjSmlw
	8IzPJa3BSoquSRhvGamtccNB7NqAwNYHKo85G3CCnD3ow91SYJAMMyqg==
X-Received: by 2002:a17:90b:2d87:b0:385:3ab:fecb with SMTP id 98e67ed59e1d1-3908972ccc2mr916287a91.4.1785997808126;
        Wed, 05 Aug 2026 23:30:08 -0700 (PDT)
Received: from localhost ([2a09:bac5:55f3:25af::3c1:3f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085de9f6asm853476a91.7.2026.08.05.23.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 23:30:07 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Thu, 6 Aug 2026 14:26:27 +0800
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <baoquan.he@linux.dev>, Dave Young <ruirui.yang@linux.dev>, 
	Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Coiby Xu <coxu@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 07/10] crash_dump: Improve readability of
 config_keys_restore_store
Message-ID: <anQouK8KGgurqAgn@Rk>
References: <20260729033654.311541-1-coiby.xu@gmail.com>
 <20260729033654.311541-8-coiby.xu@gmail.com>
 <816ce698-c4f1-4179-9741-798f5842742e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <816ce698-c4f1-4179-9741-798f5842742e@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260805_233009_165548_88FAFE22 
X-CRM114-Status: GOOD (  13.78  )
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

On Wed, Aug 05, 2026 at 05:22:39PM +0530, Sourabh Jain wrote:
>
>
>On 29/07/26 09:06, Coiby Xu wrote:
>>config_keys_restore_store currently doesn't validate the user input
>>before restoring dm-crypt keys. Although it's not necessary for the case
>>of vmcore dumping, it's better to do it for the sake of consistency and
>>code readability. Also check the return code of
>>restore_dm_crypt_keys_to_thread_keyring.
>>
>>Fixes: 62f17d9df692 ("crash_dump: retrieve dm crypt keys in kdump kernel")
>>Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
>>---
>>  kernel/crash_dump_dm_crypt.c | 13 ++++++++++---
>>  1 file changed, 10 insertions(+), 3 deletions(-)
>>
>>diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>>index 3ee01996778f..1f4549956824 100644
>>--- a/kernel/crash_dump_dm_crypt.c
>>+++ b/kernel/crash_dump_dm_crypt.c
>>@@ -370,12 +370,19 @@ static ssize_t config_keys_restore_show(struct config_item *item, char *page)
>>  static ssize_t config_keys_restore_store(struct config_item *item,
>>  					  const char *page, size_t count)
>>  {
>>-	if (!restore)
>>-		restore_dm_crypt_keys_to_thread_keyring();
>>+	bool val;
>>-	if (kstrtobool(page, &restore))
>>+	if (kstrtobool(page, &val))
>>  		return -EINVAL;
>>+	if (val) {
>>+		if (restore) {
>>+			pr_warn("dm-crypt keys already restored!\n");
>>+			return count;
>>+		} else if (!restore_dm_crypt_keys_to_thread_keyring())
>>+			restore = true;
>>+	}
>>+
>>  	return count;
>
>Nit: returns count even when restore fails.

I'll change it in next version, thanks!

>
>Rest of changes looks good to me.
>Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>

And thanks for reviewing and ack'ing the patch!

>
>>  }
>

-- 
Best regards,
Coiby

