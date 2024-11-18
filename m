Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FA9D10F40
	for <kexec@archiver.kernel.org>; Mon, 18 Nov 2024 01:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PKQCzsDpm3bkAxjIb5j+tGdt7LY0tOOHLHVxr/jc2Ew=; b=agodutM/xI1Ryqjky3k+1+m4/Z
	75r0nSxuQ+Hozh3Rsf9DADO+c+1hfAW3SxmHugthk2L/CYytJA3M5xx69vQYHXefkzQjwgGjoip3J
	swaVRvUZb5HVThhgd76Kc+qjORiVgQY6onjKROwqhot05mEBsaoUVBiiHnfCq8Av01XkIWbQNTeXR
	Ry4Gw+f2zg0Ky44dR1e6QA/PJU5OVJKsGJlL+lILNaQX69y2Jho0PTij2hzasQrJC0BRWyvDqwROq
	LV5pLo86F/IrcerR05sswn/GAZYQitY2E4QwuNMpb1fCGg9Un2iIJzk7ju93ETGc7/ME8+SYbHYgv
	1RXupWwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tCqzv-000000087Wj-0EPq;
	Mon, 18 Nov 2024 01:56:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tCqzo-000000087Vw-3Y36
	for kexec@lists.infradead.org;
	Mon, 18 Nov 2024 01:56:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731894966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PKQCzsDpm3bkAxjIb5j+tGdt7LY0tOOHLHVxr/jc2Ew=;
	b=UrgKlwNSJzu/ejZTSiOEyyVFlPIGi3OTXeRtPdzaIaSveHuewPwVxtthYcQrhLaRN8Gh0+
	nT+S7z0RY/j+0nCmaMCGBQ0QvQUSCaTMmiruow385kXqoEu0SWfHDlqLRyphVIUGSi94BO
	ojZfBeKsgEB/jGDjUxSOU81129OJpFg=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-ERznf-voNeW4hPj_mH5JEA-1; Sun, 17 Nov 2024 20:54:31 -0500
X-MC-Unique: ERznf-voNeW4hPj_mH5JEA-1
X-Mimecast-MFC-AGG-ID: ERznf-voNeW4hPj_mH5JEA
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a7632ed454so5705055ab.2
        for <kexec@lists.infradead.org>; Sun, 17 Nov 2024 17:54:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731894871; x=1732499671;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PKQCzsDpm3bkAxjIb5j+tGdt7LY0tOOHLHVxr/jc2Ew=;
        b=RiLoiJc0Z/MdP2gyUgzDX1qeoCZJxt/oaoshutVBPRCpAIarnQOmsX3PllzM2FgcnY
         9TV1vMaFlpSswU25qIxM8DNs1DfPbVxEE9nX2y8rW/ezF3H9zVkRhg5rnlQMnROTrhHV
         SSmI1EECGP4GCibWdwM76Ht1d5YZOWSHI571jOltVqhv7FNkYH4U2ctj57NlZOdp+1q9
         /epautdtgB5av0jXoHqZQZccE9z0QlpUeMGjWNG3cc9v/UL8HhbdyD7dEXnIx16xrLGT
         KeH2ujgH9L1MyNhC4a/Z/9DMJZhg/irVA8itKs318UUUTYknV9suxg4/+hL+/+GbIEUH
         iqwQ==
X-Gm-Message-State: AOJu0YxdOHnl0MC6YoQlRZ5KD396q0ojx8/rdVf/wNYFXMrAEmhso0wB
	6OkyC2ZMhEPlC07e5nwGivyoXxyNNZ0jBpta/jbOpG7vmSyyBzirC/vaNE/WNhqc33nETffFwUL
	D3HgYpMDuvMxM+5/8w2nbSjP7Dv+XnKJpI86hjFhwHJ2HDpvn1zTVhQDZfP+nzVd8yjt0Uk3nPO
	HaNJYXibzXkRFSNGi3Ip40B6Jy0YKAzQ+T
X-Received: by 2002:a05:6e02:1529:b0:3a7:19cc:9b5e with SMTP id e9e14a558f8ab-3a748032698mr117360265ab.12.1731894871029;
        Sun, 17 Nov 2024 17:54:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHt105JXXx+mjg4imf/b5wZMsOJuyacuAs3cQEBxW7dTB8+LkjC/X8rp8aaNLuONf8Ukm+XbYguS9atqDqhuA=
X-Received: by 2002:a05:6e02:1529:b0:3a7:19cc:9b5e with SMTP id
 e9e14a558f8ab-3a748032698mr117360125ab.12.1731894870761; Sun, 17 Nov 2024
 17:54:30 -0800 (PST)
MIME-Version: 1.0
References: <f39c89d510a90bef5c4b853c6cd34b4c39af580c.camel@infradead.org>
In-Reply-To: <f39c89d510a90bef5c4b853c6cd34b4c39af580c.camel@infradead.org>
From: Dave Young <dyoung@redhat.com>
Date: Mon, 18 Nov 2024 09:54:24 +0800
Message-ID: <CALu+AoT4x7iVHEUSTJ5tvuR7u_Gp-fYuunC5bg=4UZBvMqffvQ@mail.gmail.com>
Subject: Re: How to test preserve_context mode?
To: David Woodhouse <dwmw2@infradead.org>
Cc: kexec@lists.infradead.org, Simon Horman <horms@kernel.org>, 
	Huang Ying <ying.huang@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nT3UimqEAiELXS9Iz4BQBa_g_eENHJ3NkYSuTqDQIGY_1731894871
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241117_175608_974682_8981587C 
X-CRM114-Status: GOOD (  18.62  )
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

Hi David,

I did not see anyone around me test this.   The kexec jump feature was
introduced by Ying [cced him] in below kernel comment, probably you
can try the steps mentioned in the commit log:
commit 3ab83521378268044a448113c6aa9a9e245f4d2f
Author: Huang Ying <ying.huang@intel.com>
Date:   Fri Jul 25 19:45:07 2008 -0700

    kexec jump

On Fri, 15 Nov 2024 at 19:15, David Woodhouse <dwmw2@infradead.org> wrote:
>
> I'm messing around with the x86 relocate_kernel code, and I'd like to
> test the 'preserve_context' mode. I can't find any documentation or
> examples; am I just being dim?
>
> All I want to do is kexec into an environment which just does a 'ret',
> and comes back to the original kernel.
>
> I've only been able to do that by hacking out the 'call %rdx' in
> relocate_kernel_64.S so it never even calls into the environment in the
> first place.
>
> (Which doesn't work, as the kernel forgets to reload its own GDT, but
> with *that* fixed it seems fine.)
>
>
>
> Also, I've configured the mailing list to no longer append a footer,
> because it makes the lore.kernel.org archive unhappy.

Thanks
Dave


