Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690971112250
	for <kexec@archiver.kernel.org>; Thu,  2 Apr 2026 01:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uUiSeqS9PkkLaNVQ/zvAdXBaf2XPU2fS5cvEfFpiuvg=; b=PdvI6c5WZ7DrEr5+uED09hQFL3
	ocYPLdc8k2j9HPbN/e2jW5+mBsrZmfWBA0NERNVezfNPYfBdrFICBtumqbSYYLHZvYj5LNt8RE9Y/
	Nql1tDICW+lSl2E1U5Xm/jXj+6GxfxtFgk+h1E5P3dXZvn+2Vu1j6WQ7DbOQBhPIRJgyAkLOtVflr
	zjiKblFjQUjwSCYgqlnusuZDPScbUufDznzQVtBj2ZDctoT0PBYJi0TsaAHhcsa+8y9rgbv1uSqKx
	qgN90eLDCEeL8jtPPRIoTOCrtEF14D6r/1xb2II/i/FhMjcDBHN6rz0QiJUu5rSPYumAMCHlxHqwZ
	AOXHkjAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w87Cb-0000000GZY5-0Ehs;
	Thu, 02 Apr 2026 01:50:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w87CS-0000000GZWL-0KEn
	for kexec@lists.infradead.org;
	Thu, 02 Apr 2026 01:50:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775094623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uUiSeqS9PkkLaNVQ/zvAdXBaf2XPU2fS5cvEfFpiuvg=;
	b=hGxbUUbEeGdfH+x1TLqP1VWlCTXh1Jdmuexd0zlY+7IQW+TjMD7b6p8faVjr2Na3dxfPVw
	AbDE888s2/OW+LIZpzjAeKWLdCJlJwLkzCMPT3V9NVOMGeR7AsMtl5UcdWMHLo/rZaZ0eB
	gvyubsKkyT3gJetBQaCs+muvev2n+tE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-lU7fieBWPxesCg8WqThd2Q-1; Wed, 01 Apr 2026 21:50:21 -0400
X-MC-Unique: lU7fieBWPxesCg8WqThd2Q-1
X-Mimecast-MFC-AGG-ID: lU7fieBWPxesCg8WqThd2Q_1775094620
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b0b57e192bso2346955ad.1
        for <kexec@lists.infradead.org>; Wed, 01 Apr 2026 18:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775094620; x=1775699420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUiSeqS9PkkLaNVQ/zvAdXBaf2XPU2fS5cvEfFpiuvg=;
        b=E7XgUHO77QG4HbxJWSFgxlJ0GiT+tCglfYpS8c4g3TissZsLvgB5V0Lwi1dGZnhEZb
         D0KYxiaueq0Q5lFoMsfifaFEfArjbXois2zt7kt+39glkE3aL8RgKm7QM11HZAOAWWH3
         5scHdM2CKTIEAApNHV5WdvQxyohF4m8zmk0iT63aitbfXU/S6v8K80FxCBytMnlXIbXM
         D/TLXQ3IKjOkG7CWd3/On7Vl8VEO/ioqCoBTBOwg0oaGUKurATDyldslVNEQzsXlAjcS
         36MWqeY6QjybIT+KKDOHHhEgUAZoJTekaP8Yctkpqa9ck4dwyPPn0rssyJX/LzOwU3mu
         hl/w==
X-Gm-Message-State: AOJu0Ywh+c7RBz13UN+xSUPmLfeb3QJgCUwxRo0l9K4jGPBYD1me/oZI
	xmNLFIVvOM9FBmclnPq3CfLpWf71r2ZWXvZ2cudQSH7YtRne3rM+Dp1AziTwSqQwLCvLijeA7u5
	jty2v5h9cST7aVxu/bXJG7EnIOVhp5q2hlQC0zgE3sWlA4wxjVLNaEdjzv5PhHw==
X-Gm-Gg: ATEYQzy5aLNz2YEew7Ixr/D8POjSGX+UtY+AAUzuWZ7vyP9WxoEw/JfHshb9zugtT1N
	8MgaYv2/VnRHEUqCw03Mcikk7fFyfnosDHoRUyDYbExMn1QmqjGdeC3mAFz6tLKwu4rrkPnVm0V
	1bYIsHeyvrctX36SZSg7a3PLUiTCvUcIV6rtATcSmMylUVMqS/CrQl6fSOS8bST+SEiYui7BhUf
	vZU/BZ7SqnXpQRogboZSwDW1wIJtVqX5rKhmPn0/u+JWmIqaIoYv1DFki2MD4rgD+vCLyYcpe6U
	dihwgW7eZjJAjAhg13OhRRaDuBeOJ521xvkcOQxuCegbZxGkriM59cIJA9ZEWk1W6jGIG67Fps0
	f5umHZZnnaw==
X-Received: by 2002:a17:903:2282:b0:2b2:49a7:a5bc with SMTP id d9443c01a7336-2b269caa786mr54155305ad.39.1775094620313;
        Wed, 01 Apr 2026 18:50:20 -0700 (PDT)
X-Received: by 2002:a17:903:2282:b0:2b2:49a7:a5bc with SMTP id d9443c01a7336-2b269caa786mr54155025ad.39.1775094619683;
        Wed, 01 Apr 2026 18:50:19 -0700 (PDT)
Received: from localhost ([49.65.225.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749cbd9fsm9680585ad.75.2026.04.01.18.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 18:50:19 -0700 (PDT)
Date: Thu, 2 Apr 2026 09:46:37 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, 
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/3] crash_dump/dm-crypt: Don't print in arch-specific
 code
Message-ID: <ac3J_pWwyUNOy034@Rk>
References: <20260225060347.718905-1-coxu@redhat.com>
 <20260225060347.718905-2-coxu@redhat.com>
 <actzxO1p6OlmK2gp@fedora>
MIME-Version: 1.0
In-Reply-To: <actzxO1p6OlmK2gp@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OOgNzxtOEGb7B7MOfgQExyjFjA3v6mhv-60NeRZN1gs_1775094620
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260401_185024_293891_6479977B 
X-CRM114-Status: GOOD (  13.23  )
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

On Tue, Mar 31, 2026 at 03:12:04PM +0800, Baoquan He wrote:
>On 02/25/26 at 02:03pm, Coiby Xu wrote:
>> When the vmcore dumping target is not a LUKS-encrypted target, it's
>> expected that there is no dm-crypt key thus no need to return -ENOENT.
>> Also print more logs in crash_load_dm_crypt_keys. The benefit is
>> arch-specific code can be more succinct.
>>
>> Suggested-by: Will Deacon <will@kernel.org>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> ---
>>  arch/x86/kernel/kexec-bzimage64.c | 6 +-----
>>  kernel/crash_dump_dm_crypt.c      | 7 +++++--
>>  2 files changed, 6 insertions(+), 7 deletions(-)
>
>Acked-by: Baoquan He <bhe@redhat.com>

Thank Baoquan for ack'ing the kexec/kdump part of this patch set!

-- 
Best regards,
Coiby


