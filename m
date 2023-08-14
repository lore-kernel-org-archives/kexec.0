Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD89BC001DB
	for <kexec@archiver.kernel.org>; Mon, 14 Aug 2023 03:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ayJ3ZrYYPzEnt7oTh8PdHcN/oN7KjVAg3lPvqIgKBTk=; b=RwhdNA2nrGfgCT1p+CCzXaevmu
	ssfvFYLyZzmZnP+fVHQwmBul3kGCX60Mlb/uoP7QxnEz9nxDzD+T2GLUJyB7ZVwd4i0WMRgh8+w5O
	7oIvGAcXeCm5hAmmlonukln8BbqHw1T/HeBzpC2PsZwEDKSM22jZh2u58TpXoqrQZWxDnJuuypQ6A
	Dw6JDBxpcorVtSBdvhYAsuVP53/Tt7rhCjLGIOshZ59RAX3kEWLBVoBByttWNZmBEjWZdqZZ/Q3xK
	pxmV/GYAih/a07FRySVHZ5mykDWh2A5xS6rWNNlhiNhpEug9ceR7TAGPFSC/t1a3bOCiFkjFEiAWX
	klBl1/zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVO8I-00G4Tr-14;
	Mon, 14 Aug 2023 03:20:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVO8F-00G4SW-2h
	for kexec@lists.infradead.org;
	Mon, 14 Aug 2023 03:20:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691983223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gTJEN2TMUNOqfwcnbNfLyPtS6KqN3XMXWxTCOfXYZ/s=;
	b=cV5JdJp6HmDYY0bV0AtBXvXk86acneNN3QyWJ77wniSdM4bsVbaid8w58BY0ihSEjPhoyK
	CPbAFPWgaOu2ywznCGKp7OfH3K0/swbTW5/ldBlZinSA4vAGnH/Yj5TakhY8jVYCGifugd
	gX0pEf7Rmny54NEmrni/qL5plyWPjjI=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-irZfWB7nOgij6IuKUZ2G-w-1; Sun, 13 Aug 2023 23:20:21 -0400
X-MC-Unique: irZfWB7nOgij6IuKUZ2G-w-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6bc4dfb93cbso4713853a34.1
        for <kexec@lists.infradead.org>; Sun, 13 Aug 2023 20:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691983221; x=1692588021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTJEN2TMUNOqfwcnbNfLyPtS6KqN3XMXWxTCOfXYZ/s=;
        b=W2ND0pSp4QX7xLWAxREykZ/jS92FDiNfvDXGmnQPbATsf+kTWB2Q7bqriDmtHVdscl
         95j3FavLFMpfwjLk58fbw7s81GhhIcKGaOquWf+0L7dlUoiQnGomp4MjqyqAk5uZj2MW
         fI94h2QyJuRI9yG5/UHY3322clqeT/IZp0juTKVVX+nlEd9jdRN52BofR8dgw2pQKaG6
         1TMitIOqDH/DSr+yVaw0xz5mx2U6uXGXOll1x0razSAdjU1PEB5Ads+ouV1nRL8P4uO0
         V6Mha2rQtJf8HTYL8STfKHteBo77KN9miOksy0CaXsxV5LYxTkW7aCwVnwmtySg6Z8f0
         ei9Q==
X-Gm-Message-State: AOJu0YxouVyOp3o47mACAcKFsbZOR0iGRoLdHS+pVkgM67hIvsofYGkI
	KpGBfSdl40bMrYnsMwhZPX3rIY60NUrj8ieY1FR1C7zPRlMNjVDt0Rcnk+x/cOzLuDB1MlCrDfX
	XCO3T+UYFrdrnvzCOQMu/
X-Received: by 2002:a05:6870:f293:b0:1bf:42b9:e8a1 with SMTP id u19-20020a056870f29300b001bf42b9e8a1mr8600029oap.29.1691983221059;
        Sun, 13 Aug 2023 20:20:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGet8TF9RLXPAPrWMmfKgP+CTzlfkYfWbgyDPC0yp51vgdxBUPta148ETBtBWwu/7HjOWOMcg==
X-Received: by 2002:a05:6870:f293:b0:1bf:42b9:e8a1 with SMTP id u19-20020a056870f29300b001bf42b9e8a1mr8600015oap.29.1691983220774;
        Sun, 13 Aug 2023 20:20:20 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id iu11-20020a17090b450b00b0026b4ca7f62csm1705850pjb.39.2023.08.13.20.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 20:20:20 -0700 (PDT)
Date: Mon, 14 Aug 2023 11:19:07 +0800
From: Coiby Xu <coxu@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Simon Horman <horms@kernel.org>, kexec@lists.infradead.org
Subject: Re: [ANNOUNCE] kexec-tools v2.0.27 preparation
Message-ID: <ymdn754ihzovgpgoikjnpwueqx6zzmgcempvlr6bsn5rx3mwrw@62dmgvygv4eo>
References: <ZNXjs19UOvGEl/5K@vergenet.net>
 <d92decbb-768c-27e7-8c0b-eea662a86670@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <d92decbb-768c-27e7-8c0b-eea662a86670@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230813_202039_970682_9BB08C11 
X-CRM114-Status: UNSURE (   9.75  )
X-CRM114-Notice: Please train this message.
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

Hi Sourabh,

On Mon, Aug 14, 2023 at 08:17:34AM +0530, Sourabh Jain wrote:
>Hello Simon,
>
>Can we include below fix?
>https://lists.fedoraproject.org/archives/list/kexec@lists.fedoraproject.org/thread/O3W4SLVVFT6J25U5YSXNZ3URZ4QY6SRU/

I'll review your patch! Note the patch is against Fedora's kexec-tools
so it doesn't apply to this upstream kexec-tools. The relationship
between Fedora's kexec-tools and this upstream kexec-tools can be
described as follows,
1. Fedora's kexec-tools packages the kexec binary which is provides by upstream
kexec-tools; 
2. The kexec binary is used for loading the kdump kernel and initrd but
it's not responsible for building the kdump initrd. Fedora's kexec-tools
is used to build the kdump initrd instead. 

Currrently it's WIP to split current Fedora kexec-tools into
kexec-tools, kdump-utils, makedumpfile and eppic. Hopefully after it's
done, you and other uses will no longer be confused by the relationship
between Fedora's kexec-tools and this upstream kexec-tools.

-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
