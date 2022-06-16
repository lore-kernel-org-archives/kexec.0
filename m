Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160E8C43334
	for <kexec@archiver.kernel.org>; Thu, 16 Jun 2022 01:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TAD/+wnp3TvhWReumo5cSuo8suARyG8kjxuqvVUikl0=; b=k4R2OLGFPmYFfx6BQKAfaCIJ87
	K+3J99rBsg8EXLDe2I8DpylWSXxfNxU2ZY3kgQh6SKLYPdBmBLycGFfJkNnISlLJ9isrqfo5t8HNn
	57Ljw/oTRYecced76zv8F0ZtB2e3FahKwa+yuWHmQSWXeNAqVFAvZJ9sAlUu6HLjKZstU8nIe5M5l
	Ts6+c6E9aWd1ZfTQ2afRvRrt2Z8RAycqf2DeLuwJawFVq3lnS9XKQybsA7LL1d7XHmXUDhGshqnUj
	CgDPTjjfdiqVBVptnJhQeJWOa6YFWVRsakpHA9oRBUqtAn4OQc3kgjjxmx+p310HgET8WoKMLBSzp
	p2iOFy9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1een-00HRtA-7G; Thu, 16 Jun 2022 01:50:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1eeL-00HRiI-Hk
	for kexec@lists.infradead.org; Thu, 16 Jun 2022 01:50:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655344220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fVV/WU4SmfLzF3DDklDbzisp7F5k+JmdrLDWS6yeIfg=;
	b=JrDyFlAvxSxlBY+HBrcP1teh/2vFF/g+pchJQdZREV57ODoGSkP2T0dAvNjkBLICOO3vqF
	cxnuvNUd4L3ewbdxwUpMY1LuTUQYQgUYBMGkDWPGx+ciYy/3sfps3sIlK8l3WRvBlmkKAc
	bozH7arTJu23kCPZDT9vdodz1qYJb2I=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-YxosdN34MIGxHTmWA-SIIg-1; Wed, 15 Jun 2022 21:50:19 -0400
X-MC-Unique: YxosdN34MIGxHTmWA-SIIg-1
Received: by mail-pg1-f197.google.com with SMTP id 78-20020a630051000000b003fe25580679so7339951pga.9
        for <kexec@lists.infradead.org>; Wed, 15 Jun 2022 18:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fVV/WU4SmfLzF3DDklDbzisp7F5k+JmdrLDWS6yeIfg=;
        b=p6y5W3uk2UHD9C3DUeA1oSmNfoZpSd+81mvaZNFZzqpriBfzmv8nvUb5q+DMTkm/H5
         AUH48Tnd1iFeh371nROx/jPhNGQ0OYov+AgP/AfLsQh5Emrvp6cm4/V3/pCmh0kgJs3U
         E1+zQhLhQn50NajNyQpy86wUK82z7XoqznSRvH/BwX1idqT9tvg7+uWIz/vKXgLOfuN/
         Cr0cqOGSnI4ihw8+bseAK1vH8bLCVYJ1W4d0WdTg9eGGjYvOVf1VqPaD/F+vaF6gCyiI
         2HocVf8KvbsdKco2Bclq/4QyVIUtGD7NMBBwLMm0be+TlD6gaa45LNxsagGFGkD9Wha0
         zlbQ==
X-Gm-Message-State: AJIora+7EOECFW5TVGiMkX/IeenIebrB/VBaCMreCLXHUeFyXrNCZ7W8
	6Uhr8q2dcxaLqZY6vpsXi84OQAxijXxhjmP4GqyC4i/Q80jfh7vn+WxlsP20Rzs7Z4QY4y3GTVm
	G7cRFTZkzWuPiVOE3F+g9
X-Received: by 2002:a65:6b8a:0:b0:3db:7dc5:fec2 with SMTP id d10-20020a656b8a000000b003db7dc5fec2mr2271734pgw.223.1655344218186;
        Wed, 15 Jun 2022 18:50:18 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tat2EzR0T5nORvsBcX3iBlSsbkY9k1dYVtfU8jZxFaMpWCPS32EidaNFNhOavM/bEZa8rfiQ==
X-Received: by 2002:a65:6b8a:0:b0:3db:7dc5:fec2 with SMTP id d10-20020a656b8a000000b003db7dc5fec2mr2271708pgw.223.1655344217907;
        Wed, 15 Jun 2022 18:50:17 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z11-20020a63b90b000000b00408b89e4282sm280945pge.47.2022.06.15.18.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 18:50:17 -0700 (PDT)
Date: Thu, 16 Jun 2022 09:47:48 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	Michal Suchanek <msuchanek@suse.de>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Chun-Yi Lee <jlee@suse.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 2/4] kexec, KEYS: make the code in
 bzImage64_verify_sig generic
Message-ID: <20220616014748.ys3abgfakedckvag@Rk>
References: <20220512070123.29486-1-coxu@redhat.com>
 <20220512070123.29486-3-coxu@redhat.com>
 <5db507747b2be22499e7357ce65f1800b36e1de4.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <5db507747b2be22499e7357ce65f1800b36e1de4.camel@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=coxu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_185021_776017_40A06D5C 
X-CRM114-Status: GOOD (  15.29  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Mimi,

On Thu, Jun 09, 2022 at 06:18:44PM -0400, Mimi Zohar wrote:
>Hi Coiby,
>
>On Thu, 2022-05-12 at 15:01 +0800, Coiby Xu wrote:
>> commit 278311e417be ("kexec, KEYS: Make use of platform keyring for
>> signature verify") adds platform keyring support on x86 kexec but not
>> arm64.
>>
>> The code in bzImage64_verify_sig makes use of system keyrings including
>> .buitin_trusted_keys, .secondary_trusted_keys and .platform keyring to
>> verify signed kernel image as PE file. Make it generic so both x86_64
>> and arm64 can use it.
>
>^uses the keys on the .builtin_trusted_keys, .machine, if configured
>and enabled, .secondary_trusted_keys, also if configured, and .platform
>keyrings to verify the signed kernel image as PE file.
>
>>
>> @@ -202,6 +203,12 @@ int arch_kexec_apply_relocations(struct purgatory_info *pi,
>>  				 const Elf_Shdr *relsec,
>>  				 const Elf_Shdr *symtab);
>>  int arch_kimage_file_post_load_cleanup(struct kimage *image);
>> +#ifdef CONFIG_KEXEC_SIG
>> +#ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
>> +int kexec_kernel_verify_pe_sig(const char *kernel,
>> +				    unsigned long kernel_len);
>
>Please join this line with the previous one.
>
>> +#endif
>> +#endif
>>  int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
>>
>>  extern int kexec_add_buffer(struct kexec_buf *kbuf);

I've applied the two suggestions, thanks!

>
>thanks,
>
>Mimi
>

-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
