Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07636C433EF
	for <kexec@archiver.kernel.org>; Thu, 16 Jun 2022 01:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=osjOnluhHuirogb1bEaINqy74i0bgDzEeMTIuSffHGI=; b=QuLF2sFKY8+X6aDtc3SYFx4MlP
	8/qDA3VEepW56Q6KZI5LJ9fVxt25SX/zACPSofXE3nlSqD6VhATz64sacIC+Qi2PWfwplLDHq44PW
	wJWrO/hUIIrgsfBIYS5PLsIfC83MVj+2jDhRgF2yGWiBS0flqSAzcr5xvcD73Y46KibVpRiHU+MuX
	P2BtCV4qw6nJi7ULzQ3TJEgfgggtwcfnTs2n9APCPLQqR6XBugT7xX34KnqRJ1p32qGgKQAdy1pWl
	R9kkb3Y5EQaOUJUcHX2LOx75SwH/YRr9PyWLY7i4lKJ02p6FPAEiZ6zXhYdBB4X2xoEARNpWb5ccP
	ruTGNDzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1eG8-00HOAv-JY; Thu, 16 Jun 2022 01:25:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1eG6-00HOAS-0k
	for kexec@lists.infradead.org; Thu, 16 Jun 2022 01:25:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655342716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sBY/W0khNVZ7C08/XgYPdo/2hJV3qzna7vF2B6OjnQk=;
	b=QWN9voa8Qgzk7f6SrbdOUiqEjmbmEDUNmjqWY4D7stgU7FCntD6bCp3Acn3MPvZFF47HiM
	ojA2hfgRKovHn7GSy3NkR+29D1ZpIqdYMifZwfJtQeuVtP26EwpMUU9jBmTwz8CvF/yrcL
	6lYdKLsFAW2KifrxrnYtratO7u1GPCo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-63-ENwnzbrHNFqBO76b30t3xg-1; Wed, 15 Jun 2022 21:25:15 -0400
X-MC-Unique: ENwnzbrHNFqBO76b30t3xg-1
Received: by mail-pj1-f72.google.com with SMTP id j8-20020a17090a3e0800b001e3425c05c4so122240pjc.0
        for <kexec@lists.infradead.org>; Wed, 15 Jun 2022 18:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sBY/W0khNVZ7C08/XgYPdo/2hJV3qzna7vF2B6OjnQk=;
        b=7GlccVZKJVZBE43m64riSC3t8iUIPspqHYin+Pz7Sq/PVRJXx4MkNO4CgxZaYyOdgu
         7AlsLZQo/rwFfNWeqnVBddM4USE/bs/fKC6qzLSvUaq3XqaFF0/hhcqKexG51qZwtOq0
         gLgzu6GI0eRCvMPSOW0CshKL6a4B9o/gbSvio1aqowsluX3Tg+xBhjFqb5eKvyw1NO9F
         EI8GjmRt7d5v2tfFoxaLb9RwvbucrJNNShTUe469lVTDaZmo3TlF/bgQhk3j2ofoLgDc
         yrTnTw5Ullo6z7L2lMrZHDYBYlZ6QOhnuzg/NtFDNbKF6sBiaYB7CL5XAx0CV3UmMKtC
         CRUw==
X-Gm-Message-State: AJIora9BgyQBOnU0Mq85BpMgLl8P6hLkq3ZtCW8TCPjfbh8vpEH22l/J
	f3rVK2IiH74E7Ix3FMimo6GGii/NB2Vcui52xCvYBcJ6taPS2tV4oH/yJzUP9GX8LJ/Z0nFXCHu
	e5YCqGRYYz3MhZJGgxJyc
X-Received: by 2002:a17:902:e84c:b0:167:6ef7:b09b with SMTP id t12-20020a170902e84c00b001676ef7b09bmr2386424plg.43.1655342714021;
        Wed, 15 Jun 2022 18:25:14 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s1UIR7htYxbcWkDODvitCscFl1Ub3THTedbqKZYBozfGnkC+aZ0/Rmms3WNojcmzJq5bl+pg==
X-Received: by 2002:a17:902:e84c:b0:167:6ef7:b09b with SMTP id t12-20020a170902e84c00b001676ef7b09bmr2386400plg.43.1655342713730;
        Wed, 15 Jun 2022 18:25:13 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j3-20020a170903024300b00161947ecc82sm262761plh.199.2022.06.15.18.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 18:25:13 -0700 (PDT)
Date: Thu, 16 Jun 2022 09:21:28 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	Michal Suchanek <msuchanek@suse.de>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Chun-Yi Lee <jlee@suse.com>
Subject: Re: [PATCH v8 0/4] use more system keyrings to verify arm64 and s390
 kexec kernel image signature
Message-ID: <20220616012128.7ufebi2lkusx5aga@Rk>
References: <20220512070123.29486-1-coxu@redhat.com>
 <e382780002db9767671ca5a0213237f443243537.camel@linux.ibm.com>
 <20220525095957.vvref4yeaidd5iww@Rk>
 <d1a431e8cf69b3d892c118204705739a0ed907b7.camel@linux.ibm.com>
 <20220527134315.afnuszqbfqkpnxpv@Rk>
 <5b11a8043f78ef5ca41254b8a46f78dca0a5b159.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <5b11a8043f78ef5ca41254b8a46f78dca0a5b159.camel@linux.ibm.com>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=coxu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_182518_175671_DB89FF4D 
X-CRM114-Status: GOOD (  12.94  )
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

On Thu, Jun 09, 2022 at 11:35:13AM -0400, Mimi Zohar wrote:
>Hi Coiby,
>
>On Fri, 2022-05-27 at 21:43 +0800, Coiby Xu wrote:
>> It seems I need to only change cover letter and commit message i.e.
>> there is no concern about the code. So it's better to provide a
>> new cover letter here to collect new feedback from you thus we
>> can avoid unnecessary rounds of patch set.
>
>One other thing before re-posting, the existing Subject line is a bit
>snarky.  Perhaps you could come with a more appropriate title?

How about "Using the same keyrings as x86 to verify kexec'ed kernel image
signature for arm64 and s390" or "Uniform keyrings to verify kexec'ed
kernel image signature across x86, arm64 and s390"?

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
