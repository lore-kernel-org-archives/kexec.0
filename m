Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14C6CE79AB
	for <kexec@archiver.kernel.org>; Wed, 20 Sep 2023 07:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mwJbi/6DaAg9tULZIukq4fv5qPXpWQb0IJtYQZwY090=; b=LGBQNtupKdp5+6
	kaw/WWN7Nqk7JbzfrL3uPEk7eQy28xS/nHWyHLLDdBwt9ky5FhoYBWiSY2fxZ2FjKcilNqcYnw95T
	Ph8Q6vVgXDdNoXuL4b5jjLGCSWeXw7z7eImIz35jqrugPbYpLGQw7+iPfnRBWUFHhF/+HT+HzW5Pu
	lL89rTmoyzv3iHgy4y4YlPtxHyYdZl9RFUYnAfvCWfR5bQtn88z8pzGhtoWIuTzurK5b2XxVrGxNR
	kXjsXijnPmwWS08nF20M9Bd+txhA30saKSRw4qAaRBeSIROMim8zy89Y9CYls8rhIb7SJ2OrvFRQ9
	0l3zkwlEWN6yvmgFl/rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qirsM-002AJj-2b;
	Wed, 20 Sep 2023 07:43:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qirsI-002AIl-1n
	for kexec@lists.infradead.org;
	Wed, 20 Sep 2023 07:43:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695195832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cQY/xb2Ut4I8guUVtcmZYuOrVGNbPd5OCYHLcWkr4PQ=;
	b=O0CkhXJyiQkUCid4yn31VX3po4e3L8/q+Jc3MsEun4z61p1Nn2ES+bOVzwwvPwlt75uhF/
	K03FBybHaQ39+JTo5etX/7S3mZgoFDiWUTMcRrkFIWKd9rANqo0A5caEIDghmEMc+VrYh3
	0qSf09Shjf2yb9HjFyd4ca1PjfWiqTA=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-_L_LsNc9MTmMkvLndK4WUw-1; Wed, 20 Sep 2023 03:43:48 -0400
X-MC-Unique: _L_LsNc9MTmMkvLndK4WUw-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-792701056b1so156397939f.1
        for <kexec@lists.infradead.org>; Wed, 20 Sep 2023 00:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695195828; x=1695800628;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cQY/xb2Ut4I8guUVtcmZYuOrVGNbPd5OCYHLcWkr4PQ=;
        b=bEm4TISlFs7vyPN4wievGKey8fpzCIThmjvoKjPxXkH9kits5dtIYSIpXNg30BqI56
         /C3atcC/Fulkt4U6hAptY1dVjoB1Arx/7gPxp3H90OZfTI54F5OffdFDBQwPob0CX7oD
         1EkYdohPCH6QDPBt+jwbw2r/dt9/FWwqMyPQwtRlGTe4xDLcKjXRoDKHJMWv8RvCIfz4
         4B+AeOnneAsxyd0dp8Z1O0u64ityF/WoMSpAnydvUoCAqPTU5ERge28kbGi1//DTCjRI
         36e91SKzGCctdv92YqW87N6fqZxBD3xFDp/lrZC09fTtTMvX+bj7zzb1/8bY/8uF2cx1
         pwyg==
X-Gm-Message-State: AOJu0YwEPsjHbTUsVleQj+sGqUJ8q+F21wjqC6rdDF4biuY5YVQ6erZ3
	mZ/njg1T5Q284m/yWLKul1vbeGPrVEVCyJ37VyXPd6pvfBP3vVDsWJIOICYgQ39i3/3wKdo/4Bj
	MDaq/K4yADnZOk8ZD4OcisVkOqSPJroISiUdp
X-Received: by 2002:a92:c649:0:b0:34f:6e08:d6a3 with SMTP id 9-20020a92c649000000b0034f6e08d6a3mr2061580ill.0.1695195828113;
        Wed, 20 Sep 2023 00:43:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhKrIUaDVR8FWBSE8eiA+LxkP+Hvqf+lgVMJ5a3lTeGzEqd1tzKJSp2LFhKHoV6H2rV3NESf0IQB4QSqC7HKI=
X-Received: by 2002:a92:c649:0:b0:34f:6e08:d6a3 with SMTP id
 9-20020a92c649000000b0034f6e08d6a3mr2061565ill.0.1695195827853; Wed, 20 Sep
 2023 00:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230911052535.335770-1-kernel@jfarr.cc> <20230913160045.40d377f9@rotkaeppchen>
 <63952cb0-5217-42a8-9b62-8be6d03f5844@app.fastmail.com>
In-Reply-To: <63952cb0-5217-42a8-9b62-8be6d03f5844@app.fastmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Wed, 20 Sep 2023 15:43:27 +0800
Message-ID: <CALu+AoTAUWWtx8yChQMKF9J5X_Qd8+x0hz0jzVwoOvAvh5VmHA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] x86/kexec: UKI Support
To: Jan Hendrik Farr <kernel@jfarr.cc>
Cc: Philipp Rudo <prudo@redhat.com>, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, x86@kernel.org, tglx@linutronix.de, 
	dhowells@redhat.com, vgoyal@redhat.com, keyrings@vger.kernel.org, 
	akpm@linux-foundation.org, Baoquan He <bhe@redhat.com>, bhelgaas@google.com, 
	Luca Boccassi <bluca@debian.org>, lennart@poettering.net, 
	"Liu, Pingfan" <piliu@redhat.com>, Ard Biesheuvel <ardb@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230920_004354_668552_029262EF 
X-CRM114-Status: GOOD (  11.61  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

> > In the end the only benefit this series brings is to extend the
> > signature checking on the whole UKI except of just the kernel image.
> > Everything else can also be done in user space. Compared to the
> > problems described above this is a very small gain for me.
>
> Correct. That is the benefit of pulling the UKI apart in the
> kernel. However having to sign the kernel inside the UKI defeats
> the whole point.


Pingfan added the zboot load support in kexec-tools, I know that he is
trying to sign the zboot image and the inside kernel twice. So
probably there are some common areas which can be discussed.
Added Ard and Pingfan in cc.
http://lists.infradead.org/pipermail/kexec/2023-August/027674.html


Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
