Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC6F4C3ABB2
	for <kexec@archiver.kernel.org>; Thu, 29 May 2025 02:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PClIz5ruLM/ZV/ePtDq10a1ylr6BVLzbUjXceuS9BvI=; b=TO1uAqbL3vGOZS/VNEicS6tKea
	/Gq2nm+lT+kJx7RleQfG+D2150bp1BKNIsmLjPLOVEJmLN+nnOOF4Tqsp7Z58feieH1863U+i+dG4
	FQGu7/wXfSrpX+cAr2P7hNXxUYb3lPgpI03K1dVuRj7bw00UA69gT35MfEGv6YMaBmRyxV6iF7QW/
	eB4SChHRI9iOJLqpeaBRie42ags+9B2T18wKhEgxosEdEbYMabs7UuGwlCCTZTYOrROoytHzzRBf3
	u+Bpbcyj49tbrQzZ4AkJKx9uM8WnJfjw68w06Wn2QD7bQ0Ggs/CIZcnWXTCSQlOFlmTMe/qGdoKSc
	3ZjM/6Qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKSsh-0000000Ejmk-2ipu;
	Thu, 29 May 2025 02:20:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKSrC-0000000Ejgi-3CoP
	for kexec@lists.infradead.org;
	Thu, 29 May 2025 02:19:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748485136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PClIz5ruLM/ZV/ePtDq10a1ylr6BVLzbUjXceuS9BvI=;
	b=e5csMtiLPdQ19lwY6hVIFE5qqqSVlK7Hk2K9ngAe3DUBQhUQUhF2+xf1rr5/OoqDLLgk0K
	yOXZTrHi5RYjpUTAhMsipQICcQ353HJ3gLtkhlhwAzRmdvGS7WDg/r05s4vUfAaqHhagkq
	4STE2Wc3a5xNuXnum8+t3GDZc8peHGE=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-SBNk8H7HNlONA-fn5w9UdQ-1; Wed, 28 May 2025 22:18:55 -0400
X-MC-Unique: SBNk8H7HNlONA-fn5w9UdQ-1
X-Mimecast-MFC-AGG-ID: SBNk8H7HNlONA-fn5w9UdQ_1748485134
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7429fc0bfc8so1290749b3a.1
        for <kexec@lists.infradead.org>; Wed, 28 May 2025 19:18:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748485134; x=1749089934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PClIz5ruLM/ZV/ePtDq10a1ylr6BVLzbUjXceuS9BvI=;
        b=G8jrqjbq0lazUoaiZ38w3I3Lx3NUv59xbMwtgPDe1Zv0fi91AsQrCYOBw2vuo16JJ1
         2RxK1EomKQel9clQBkviOTqpDHg4R/lOoZkhYw75jfkwMKTxQ+75KyIqQQsOhhjHQBT7
         ugoSVg4YaixP6GLU/5SkjB5c4Gi1gj/WmRp/iXdPpXSnq1fVETWjHD4o8Kn/EoH9+bWg
         8V4Cnu38uziGEbv7fEAaqXhgytH/T0nmVfN32wL5SbEbZiLyafvZWU0pfiaMEzIRC7Qe
         egIKYI1FhmW3BSlVSQvqob9eE4QfBQRrgMlBSrqXwhlqHF/B7TJdgtOF362d720kPEhl
         vMtg==
X-Forwarded-Encrypted: i=1; AJvYcCXPLto8dEVqkP/U3EghlSUqlp/aMGWZ09wfc8ejDDTokEZme6klPvGmOfHo100BFqQqKaU88w==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy5e16CK3c9/miAKVCEEceREKfIZBCwcham8eIHhtfvsC9ufAVN
	9YSo9K5l+EkNBOSCxtkx/lre4DNj/g2KOSTsqb/4CR7I8LFE48l9ZW5+ORnPfqxVgqM+Z3tp/Di
	Vbyz9JOGQbO3uB8+tbxS0xbV4bBkSSrMJa9lf6kd7fhII0uP17QguZQBm3qOq7Q==
X-Gm-Gg: ASbGncuT0G9zhGI8ZjezGdM6baZi+t6rQbYHCiCCSTn1HDh8f5duVFsesI8ftCGBX1t
	OQjcXdkjz0wPJRSVYO/O4ImIs9bJPkuWE3vr7Ib18Nc2Uy/51QP+o+yD+plFEM4WlTMY+WVRuoH
	GaOfPkjQafXbRtUsKDDYJlfhT+b+lRTdNeAw2VcdhhfpBDgZOrQ+0tPxe619szlE7GJmZlPxoCz
	KbobmikqD0VJ7S30hdmPXza55vLAvGAFBzVNZYsIMm7yOsUFHYETk257i5LLcDiojjiuSvWCfh3
	lQ==
X-Received: by 2002:a05:6a20:a123:b0:1f3:323e:3743 with SMTP id adf61e73a8af0-21ac5b89ed6mr2617218637.12.1748485134054;
        Wed, 28 May 2025 19:18:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwJD31EacUd4P1pvoKAV06D2STXMvWS1b7iusv5/kGhFEscB3PEL0FPwjBntBCWf/HwaZxdw==
X-Received: by 2002:a05:6a20:a123:b0:1f3:323e:3743 with SMTP id adf61e73a8af0-21ac5b89ed6mr2617187637.12.1748485133630;
        Wed, 28 May 2025 19:18:53 -0700 (PDT)
Received: from localhost ([117.88.136.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afeaad78sm287636b3a.46.2025.05.28.19.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 19:18:53 -0700 (PDT)
Date: Thu, 29 May 2025 10:18:27 +0800
From: Coiby Xu <coxu@redhat.com>
To: Kees Cook <kees@kernel.org>, Baoquan He <bhe@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	fuqiang wang <fuqiang.wang@easystack.cn>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v4] x86/kexec: fix potential cmem->ranges out of bounds
Message-ID: <m4kujahyi2wudx56imnvoiyfau25eio5dp5j4kivwmdyunss4v@eu2x3ittlayz>
References: <2754f4evjfumjqome63bc3inqb7ozepemejn2lcl57ryio2t6k@35l3tnn73gei>
 <aB3RqS85p6DiHKHm@MiWiFi-R3L-srv>
 <20250509183518.bf7cd732ac667a9c20f1fee1@linux-foundation.org>
 <sn775iwfnogyvgxetbcfneuuzsnr5wva6kc4vachyzc7r6uhfi@ozhimoihtk4b>
 <aCaycGEtgNvynjNQ@MiWiFi-R3L-srv>
 <202505161616.F4C1BCCF6A@keescook>
 <aCksAsgAw1jsGBL9@MiWiFi-R3L-srv>
 <202505190716.B21F11984@keescook>
 <aCtBf2LqRqlWXaUp@MiWiFi-R3L-srv>
 <gxysezp2tc6qtb3o3wpdsk7k4aijxontf3ozfnhn76giobkefe@v2vkfov2tcck>
MIME-Version: 1.0
In-Reply-To: <gxysezp2tc6qtb3o3wpdsk7k4aijxontf3ozfnhn76giobkefe@v2vkfov2tcck>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: maqz9HwXDTfkN0llRM8hJO_DeDnC-2p_BY-Yj0tMDHo_1748485134
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250528_191858_876661_24EB46C9 
X-CRM114-Status: GOOD (  20.24  )
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

On Tue, May 20, 2025 at 05:13:28PM +0800, Coiby Xu wrote:
>On Mon, May 19, 2025 at 10:34:39PM +0800, Baoquan He wrote:
>>On 05/19/25 at 07:19am, Kees Cook wrote:
>>>On Mon, May 19, 2025 at 09:22:30AM +0800, Baoquan He wrote:
>[...]
>>>> > I went back through the thread and the referenced threads and I can't
>>>> > find any details on the USBAN splat. Can that please get reproduced in a
>>>> > commit log? That would help understand if it's a false positive or not.
>>>>
>>>>
>>>> The original patch is trying to fix a potential issue in which a memory
>>>> range is split, while the sub-range split out is always on top of the
>>>> entire memory range, hence no risk.
>>>>
>>>> Later, we encountered a UBSAN warning around the above memory range
>>>> splitting code several times. We found this patch can mute the warning.
>>>>
>>>> Please see below UBSAN splat trace report from Coiby:
>>>> https://lore.kernel.org/all/4de3c2onosr7negqnfhekm4cpbklzmsimgdfv33c52dktqpza5@z5pb34ghz4at/T/#u
>>>
>>>Ah-ha! Thanks for the link.
>>>
>>>> Later, Coiby got the root cause from investigation, please see:
>>>> https://lore.kernel.org/all/2754f4evjfumjqome63bc3inqb7ozepemejn2lcl57ryio2t6k@35l3tnn73gei/T/#u
>>>
>>>Looking at https://lore.kernel.org/all/aBxfflkkQXTetmbq@MiWiFi-R3L-srv/
>>>it seems like this actually turned out to be a legitimate overflow
>>>detection? I.e. the fix isn't silencing a false positive, but rather
>>>allocating enough space?
>
>The words "out of bounds" in the patch subject are kind of misleading
>because the patch is outdated. A later merged commit 6dff31597264
>("crash_core: fix and simplify the logic of crash_exclude_mem_range()")
>has actually fixed out-of-bound access issue as illustrated in
>https://lore.kernel.org/kexec/ZXrY7QbXAlxydsSC@MiWiFi-R3L-srv/ Current 
>crash_exclude_mem_range simply returns -ENOMEM when there is no
>enough space to hold split ranges (I'll post a patch to prove the
>correctness of crash_exclude_mem_range by reasoning about the code and
>including a thorough unit tests). So I'll change the subject to "fix
>potential cmem->ranges out of memory" in the upcoming patch.

The kdump LUKS support patches which fix the UBSAN warnings as a
byproduct are now in the Andrew's mm-nonmm-stable tree. Can I assume
it's not appropriate to re-send a new version of kdump LUKS support
patches which includes a separate patch to fix the UBSAN warnings alone?
If that's the case, I can send a single patch to the stable tree if the
stable tree requires an upstream commit already in Linus's tree.

-- 
Best regards,
Coiby


