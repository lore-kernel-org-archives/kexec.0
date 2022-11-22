Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899CEC433FE
	for <kexec@archiver.kernel.org>; Tue, 22 Nov 2022 02:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FcCG8n4KE/F+F1MzagtZ89NOwJaacVVMND42Y2KQORk=; b=VhydMHXPC8m4FfCFRZIvUNXtaV
	FRzgiRIAQduOLMGntSs9zeEkZPx6Qij7fPn4FnjvyCSivXaesZUD47ywmpqPw6sjI3PH5xRhfTLDo
	2J4YNc8xvGz5Sp9wA+7995ssYLlqHnFHMuhp6X3J2xY7fCT4XRqUQzsZIWyOu0jRsJfCUfVeJzqQx
	lrcyY1f8f98X/6qRuEKuLfya0r9aH5uu32DaBSdckHHMZodexl/nWifTG2xdcWNPzQMIq0dEnHWr4
	2Tr9KyRladbGFAKquIt4Yw33WkZKnIMETbWX0tFigze3IKQ4eD3Z07odavQzUtSwHapcuzhobEJhT
	Z3ujwNnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxJ9k-002WDL-Bx; Tue, 22 Nov 2022 02:37:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxJ9h-002W6U-6k
	for kexec@lists.infradead.org; Tue, 22 Nov 2022 02:37:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669084620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xvIIlAJedlMA1IAN6mozxkUlISNRY72m50Y0CwedFi4=;
	b=a/U+NUgTyahnfyxcC8MyIoEZQ3ZQZLNqB6agIZDKvGHS1pUzcozEEz9s1CwJ2bk8P6Ru16
	BS3mlhEqWf4TGYgPFmljA4+N4WOojfRPeq6jawY7AO+hgzjnzfCYhZiztm9bIgwpFXJBxm
	VJE/XKC/74uCrHvDx7v3AfD7ifxvxZA=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-340-8W5Ea0pXPy6o48WEaiPnUA-1; Mon, 21 Nov 2022 21:36:58 -0500
X-MC-Unique: 8W5Ea0pXPy6o48WEaiPnUA-1
Received: by mail-pg1-f200.google.com with SMTP id a33-20020a630b61000000b00429d91cc649so7730479pgl.8
        for <kexec@lists.infradead.org>; Mon, 21 Nov 2022 18:36:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvIIlAJedlMA1IAN6mozxkUlISNRY72m50Y0CwedFi4=;
        b=vGyu+B0u22QPM0b2FPftak0KNB3lAwELpBHiMo6U/z6C08jMuFMmb3X34sohH311ZV
         bU9HeGmI1iyxRQrAnB/oNHsXYg3mMUafcRhidVmEzsEG/SEF5dXao0cv8ckGYUnReclU
         3FrZFWNdXnJmGKAS7cHtBW6l/JhykPN//PhY0OhYWagCGWwzpapFo0gUsS+SfkLPnb4Z
         gXPIdhFB207wchJtbJYSiQlpUUpEcD3+RjrM6Rxb5DlxpLmHZMzy9tQ6tM7HuBKPiPOf
         ZAYu8gpTQ/I7EJWWEPA+OKQhfEF0f7rFO3nOQb6uhvWply2IaDyZQVl/9wPtmg4WRUtK
         taSA==
X-Gm-Message-State: ANoB5pkfO3UroxoYINo5lKpxbT3T9IPmzpz5GSvWXk35/vnC84HtBHpd
	QHXEQL9qdVjDwBPP9rrR/3rxbkC7BOxBteUCGkbnwf4PmMrLVv0LYnNnxh6ChZdNZ4uLLYUljgd
	RAy6m5OeDs9apxxa+r2hj
X-Received: by 2002:a17:902:bd42:b0:188:ca57:8945 with SMTP id b2-20020a170902bd4200b00188ca578945mr1672926plx.116.1669084617020;
        Mon, 21 Nov 2022 18:36:57 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5u80bNrcNaRgL0fQ5kRBTesC/rxRbN9BLu4B5mZ4iRUSxKXsFzA1wq6uSnG3iu384vaVg/tg==
X-Received: by 2002:a17:902:bd42:b0:188:ca57:8945 with SMTP id b2-20020a170902bd4200b00188ca578945mr1672913plx.116.1669084616745;
        Mon, 21 Nov 2022 18:36:56 -0800 (PST)
Received: from localhost ([240e:3a1:2e3:6280:f5b8:e7c9:62bf:459])
        by smtp.gmail.com with ESMTPSA id k186-20020a6324c3000000b0046fd180640asm8185870pgk.24.2022.11.21.18.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 18:36:56 -0800 (PST)
Date: Tue, 22 Nov 2022 10:36:06 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: kexec@lists.infradead.org, Matthew Garrett <mjg59@srcf.ucam.org>,
	Jiri Bohac <jbohac@suse.cz>, David Howells <dhowells@redhat.com>,
	linux-integrity@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	James Morris <jmorris@namei.org>,
	Matthew Garrett <mjg59@google.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lockdown: kexec_file: prevent unsigned kernel image when
 KEXEC_SIG not enabled
Message-ID: <20221122023606.nrifkrng5nbfmkka@Rk>
References: <20221121072947.836672-1-coxu@redhat.com>
 <5d98172d77a8a0f1e3daab44ad51bf38978cc053.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <5d98172d77a8a0f1e3daab44ad51bf38978cc053.camel@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221121_183701_351557_20463E19 
X-CRM114-Status: GOOD (  13.71  )
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

On Mon, Nov 21, 2022 at 01:23:57PM -0500, Mimi Zohar wrote:
>Hi Coiby,
>
>On Mon, 2022-11-21 at 15:29 +0800, Coiby Xu wrote:
>> A kernel builder may not enable KEXEC_SIG and some architectures like
>> ppc64 simply don't have KEXEC_SIG. In these cases, unless both
>> IMA_ARCH_POLICY and secure boot also enabled, lockdown doesn't prevent
>> unsigned kernel image from being kexec'ed via the kexec_file_load
>> syscall whereas it could prevent one via the kexec_load syscall. Mandate
>> signature verification for those cases.
>>
>> Fixes: 155bdd30af17 ("kexec_file: Restrict at runtime if the kernel is locked down")
>> Cc: Matthew Garrett <mjg59@srcf.ucam.org>
>> Cc: Jiri Bohac <jbohac@suse.cz>
>> Cc: David Howells <dhowells@redhat.com>
>> Cc: kexec@lists.infradead.org
>> Cc: linux-integrity@vger.kernel.org
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>
>Other than correcting the function name to mandate_signature_verificati
>on(),

Applied to v2, thanks for correcting me! Btw, I realize I overwrote the
return code of kexec_image_verify_sig with
mandate_signature_verification's. v2 has fixed this issue as well.

>
>Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

And thanks for the review!

-- 
Best regards,
Coiby

-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
