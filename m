Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901F2C433EF
	for <kexec@archiver.kernel.org>; Thu,  7 Jul 2022 14:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9WGPW2oAjgO85rDBkd7eeAQGaMlM+/yiHpuoFIkqAOQ=; b=2EJFM/kklX0CIeikZnzJUANAI3
	ZOTFeJZS+t238AeU1Dua5bFNTb0bCGsV3yHoCZRJwYo1zwjZfSb5Zyl4B/17z/JwsWMG8+tNZgwm+
	AxAA5kyQO2pPRB5631MDOkExLtgR9rWW1F5nJRW2+wE1wjaUvT2qNbusDaFJy+TCXCGZs0NiQH2s3
	bt7z4hr4hKtQX5kQhTVyDaw7Jm4l2IVH0+LGmCUETTXOzxRJGC8EPgSYp89ddubZyIhHb2z5Yt3ki
	ISMtYLmfFNn5Ex2yTxy9Q/oGn8O6BmiXgRk9/0UjMx2lmZFgC44egTSC9iV3n/8E+OfHsaDCjAgAu
	sdtMbTTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9SIR-00GR9p-39; Thu, 07 Jul 2022 14:15:59 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9SIF-00GR8I-7L
	for kexec@lists.infradead.org; Thu, 07 Jul 2022 14:15:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1657203346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Snse6WNAbXQDgwuAFPKIs/eg6AGY2otiMBS6p+tZq8Q=;
	b=BCTkUrPZXdyB4+YHjnXwmk9PKeYPaG0BumZPnJ7yVDYOvcOCov/vVAI5AbL4IE0u89llRW
	4PS+vwhmw9irEBegqs4xhZA/dp6VckXnDIKd1sZOtOSwMvkT0nLTOQGFTsuOc8YSfmI0u4
	S2vljZh/bdEJsaZGzH/HhuhhNEpYJvc=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-437-knd0RzdGNb-2Xor1rlNajg-1; Thu, 07 Jul 2022 10:15:42 -0400
X-MC-Unique: knd0RzdGNb-2Xor1rlNajg-1
Received: by mail-pg1-f199.google.com with SMTP id f9-20020a636a09000000b00401b6bc63beso8585984pgc.23
        for <kexec@lists.infradead.org>; Thu, 07 Jul 2022 07:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Snse6WNAbXQDgwuAFPKIs/eg6AGY2otiMBS6p+tZq8Q=;
        b=yhfUdAixs+A1RJ56lvg4Zyg6iSsMpm7dst+nFdVP3NrMAuoE5HhvYKKS2NFgdOQ78r
         Rh7bUiUVZBh8wy3+g3iUp897JoxG17MVPC00MQbDkCvWrN845P4moCPi0u+JC9yIOFxr
         PGaVoKY7hKSzY+/Swm8YW+juvXo2PeTBE21ski7QX5q+v/1O0fewvR8L7SuEbiFbDRBE
         ipA4wT9SJEb/bbOHHohzmY4qjXI06KHFSKaFwNYCiMZG9O/wVy3m/gFWKbW/XMmVkQ00
         nxWfLMqvkN62rwRG7BkOPW1gec60+uZzFt6fxt2vsGydQjigxJF4Sq7XRq04Qm0Ar76l
         mH0Q==
X-Gm-Message-State: AJIora9DjSdOZmHJxI4bGUrGb8cudJi45KDrjLkzYnkckje+k7B8yt0/
	a7rd2b/TsmfDYLgLnFdroQrHRQIYxyHPa61o9KFYFVHo/vdRgao388EcnSf4fW8mN7/C2dP9/2d
	4slz7DrFhFk21K/QT5aBV
X-Received: by 2002:a05:6a00:1d9e:b0:528:a33a:22b9 with SMTP id z30-20020a056a001d9e00b00528a33a22b9mr10537532pfw.7.1657203339901;
        Thu, 07 Jul 2022 07:15:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tuWzdyOy7C3Ub7vTA/s057bMHl2QvOk3c7J797qqSRQnzwd0elRhBJpWmYXea++UlYeQjR1w==
X-Received: by 2002:a05:6a00:1d9e:b0:528:a33a:22b9 with SMTP id z30-20020a056a001d9e00b00528a33a22b9mr10537501pfw.7.1657203339558;
        Thu, 07 Jul 2022 07:15:39 -0700 (PDT)
Received: from localhost ([240e:3a1:31b:3d30:c711:d753:abde:647d])
        by smtp.gmail.com with ESMTPSA id o197-20020a62cdce000000b005292729cc5csm203757pfg.160.2022.07.07.07.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 07:15:38 -0700 (PDT)
Date: Thu, 7 Jul 2022 22:10:29 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Will Deacon <will@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	kexec@lists.infradead.org, linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Michal Suchanek <msuchanek@suse.de>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Chun-Yi Lee <jlee@suse.com>
Subject: Re: [PATCH v9 0/4] unify the keyrings of arm64 and s390 with x86 to
 verify kexec'ed kernel signature
Message-ID: <20220707141029.tj6zerqd6dcu2wrr@Rk>
References: <20220704015201.59744-1-coxu@redhat.com>
 <711440de6340ef6ad73e4db5edd36fc391b8a11d.camel@linux.ibm.com>
 <20220706114806.GB2403@willie-the-truck>
 <45013a3990af13449c2d0deadab419e5d437eae7.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <45013a3990af13449c2d0deadab419e5d437eae7.camel@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=coxu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220707_071547_397590_025A3135 
X-CRM114-Status: GOOD (  12.22  )
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

On Wed, Jul 06, 2022 at 10:33:50AM -0400, Mimi Zohar wrote:
>On Wed, 2022-07-06 at 12:48 +0100, Will Deacon wrote:
[..]
>> It looks like this series is ready to go, but it's not clear who should
>> pick it up. Eric -- would you be the best person? Otherwise, I'm happy to
>> take it via the arm64 tree (on its own branch) if that would be helpful.
>
>Unless Eric is interested, I was asked to pick this patch set up.

Thanks! FYI, Andrew has queued up Naveen's patch set "[PATCH 0/2] kexec:
Drop __weak attributes from functions" though:
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/log/?h=mm-nonmm-unstable

With Naveen's patch set, "[PATCH v9 1/4] kexec: clean up
arch_kexec_kernel_verify_sig"" can be dropped. If you need me to send a
new version, please let me know.

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
