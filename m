Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4054C25B74
	for <kexec@archiver.kernel.org>; Fri, 24 May 2024 07:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AL2vMdvUUtteJma+CdRcBUrYD+MvabKEfaMMqTzfEfQ=; b=bxceOG/27nYdmg76RFvFCw0WnP
	yrDczaEnqLGamY89q3E0wXOnhIx7hN4cLZIU+wTO3tlf9JwabQg1nhzg5gFJN6SQ7X4jbUfBI4XAw
	ci2wwfM1IK52xmqDBTwV2ZBy3wHZEW+rLSi3/q4Mgy4HoRHgD/qX4BViuURxlN8jhVNtTrH6EVT5V
	9DYq22ibGt2u6QievVMl3jgwhDe3rblmBBHm+WbexXbX3JlPXmYthgObyimdIgMgQ3qIuERsXHPUp
	d76MxToQcoQQRmjbERuQAopNgqG1v8xIqJ2fSY20uDXwLyuk9hOE74mYkJhmb8qTNBshdwciukGbK
	TD2LCIDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAPJO-00000008GFx-0vBk;
	Fri, 24 May 2024 07:25:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAPJL-00000008GDF-3Ih8
	for kexec@lists.infradead.org;
	Fri, 24 May 2024 07:25:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716535553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PzoNctDwu2m6AmJa5cOCmGwkuh/QFbymJSnZ7SGPShc=;
	b=E1os7uMtDVLvlfMmtio3Bxzdg76DDUa3k79zj6J+I0LrDfUKVVZ+IkTc+fvnBS6GaBfzgU
	/b5A4gmthzkDtUZjxu1KHqsvRFk4VcwRUNru/vUQNB7lBA7ZNFKK7683yHVexY4p7tPI0s
	gaAFfAWvLkC3yXxX2sPCS0rbhubYxGA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-7hV0RZXIOb-mPP8OWIO8ng-1; Fri, 24 May 2024 03:25:48 -0400
X-MC-Unique: 7hV0RZXIOb-mPP8OWIO8ng-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2bf5ba94169so792811a91.0
        for <kexec@lists.infradead.org>; Fri, 24 May 2024 00:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716535548; x=1717140348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PzoNctDwu2m6AmJa5cOCmGwkuh/QFbymJSnZ7SGPShc=;
        b=qbt82nC5TxOudJDbXb9am0KP2ERJ3PgPhHhBa/smgZXehH+VGUWvbnNoCNW+QFgP+S
         XtyH6RGreD99DrX5KHwTXpHTUnm4vTMSoRi9xL1hhL9st1feqAoytqTSLW1keJN40cqe
         THDy9vFd7COKh3v2a8Tlr6Emug0+uPwlOu6r9kps7cd9tnojuLI9+8SNDRiDjiqO3ut+
         tlpqXqyoKvjQOaZJsUr5ELavxqIXxqpEzx4+eoM3rc79N0uXVJozvDy75MDBMT3rO6y1
         IHuLPGWkyRdPcpPwfBk35hOHnYoinIKeevLID/7Lz5safCDXEtzPJKq8Pu5CaHU/xAky
         GnLA==
X-Gm-Message-State: AOJu0YxnjhoPWLw0kicIzutuW7Zra1bu3/F1LNlbLeFjKVsmTX4+w/KI
	eKaKzKqtQZdTVRvEmrvNZmKdiyq211a7nW6ELA1S4gys5S/QqiL9KW/u5cq3PxMxvrdYV4X66lp
	RFy14PzKjunaRxop4QKReyql5Ahqvcoy0iQVf/xAWKVhhq1/239eQEdq1uA==
X-Received: by 2002:a17:90b:3110:b0:2bd:d680:3c8a with SMTP id 98e67ed59e1d1-2bf5e139562mr1478926a91.5.1716535547491;
        Fri, 24 May 2024 00:25:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0Oel1WZj5nAuJTGDSIq3qNp4/LOi5MgmRKqKyhKbREm4bXAiRorKX9Z+oY2dV58dic8Rx4w==
X-Received: by 2002:a17:90b:3110:b0:2bd:d680:3c8a with SMTP id 98e67ed59e1d1-2bf5e139562mr1478897a91.5.1716535546660;
        Fri, 24 May 2024 00:25:46 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bdda14e538sm2655538a91.49.2024.05.24.00.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 00:25:45 -0700 (PDT)
Date: Fri, 24 May 2024 15:22:17 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v3 1/7] kexec_file: allow to place kexec_buf randomly
Message-ID: <nfe3elcoihbt2g55upa3y5r3bfapngh6yudicyhjqcjczzgswo@cb6h4fl5vi6p>
References: <20240425100434.198925-1-coxu@redhat.com>
 <20240425100434.198925-2-coxu@redhat.com>
 <ZkrqkzJlW2RZkmH9@MiWiFi-R3L-srv>
 <y5ogivx7qbdm6u37t5o6na4jewn6qofzrbibnsneoqlwns63y5@eg62cytuvwql>
 <ZkwRZxGw2dWStd1C@MiWiFi-R3L-srv>
MIME-Version: 1.0
In-Reply-To: <ZkwRZxGw2dWStd1C@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240524_002555_923713_E883F048 
X-CRM114-Status: GOOD (  24.35  )
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

On Tue, May 21, 2024 at 11:13:43AM +0800, Baoquan He wrote:
>On 05/21/24 at 09:58am, Coiby Xu wrote:
>> On Mon, May 20, 2024 at 02:16:43PM +0800, Baoquan He wrote:
>> > On 04/25/24 at 06:04pm, Coiby Xu wrote:
>> > > Currently, kexec_buf is placed in order which means for the same
>> > > machine, the info in the kexec_buf is always located at the same
>> > > position each time the machine is booted. This may cause a risk for
>> > > sensitive information like LUKS volume key. Now struct kexec_buf has a
>> > > new field random which indicates it's supposed to be placed in a random
>> > > position.
>> >
>> > Do you want to randomize the key's position for both kdump and kexec
>> > rebooting? Assume you only want to do that for kdump. If so, we may need
>> > to make that more specific in code.
>>
>> Thanks for the suggestion! Currently, no one has requested this feature
>> for kexec reboot so yes, I only have kdump in mind. But kdump depends
>> on kexec thus I'm not sure how we can make it kdump specfic. Do you have
>> a further suggestion?
>
>I remember you said kexec reboot doesn't need the key passed from 1st
>kernel to 2nd kernel because the 2nd kernel will calculate one during
>boot.
>
>kbuf has the information, the similar handling has been in
>kernel/kexec_file.c:
>
>#ifdef CONFIG_CRASH_DUMP
>        if (kbuf->image->type == KEXEC_TYPE_CRASH)
>                ....;
>#endif

Thanks for the suggestion! I'll wrap related code inside
CONFIG_CRASH_DUMP.

>
>> > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> > index 060835bb82d5..fc1e20d565d5 100644
>> > --- a/include/linux/kexec.h
>> > +++ b/include/linux/kexec.h
>> > @@ -171,6 +171,7 @@ int kexec_image_post_load_cleanup_default(struct kimage *image);
>> >  * @buf_min:	The buffer can't be placed below this address.
>> >  * @buf_max:	The buffer can't be placed above this address.
>> >  * @top_down:	Allocate from top of memory.
>> > + * @random:	Place the buffer at a random position.
>>
>> How about a comment here saying this is currently only used by kdump.
>
>No, it's not good. Please don't do this, let code tell it.
>
>By the way, can you rebase this series on the latest v6.9 and resend? I
>rebase my code and can't apply your patchset.

Sure, v4 was sent.


-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
