Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99EBFC5320E
	for <kexec@archiver.kernel.org>; Thu, 22 Aug 2024 12:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gNLj82vhLjLnDWJxnpiMzIm6ZCB8YsCIbSvE0D2Uym8=; b=y0PiwMKBsIQX2p
	70WXB00vdKQN4so6Q4sU40LUsj3XfmcmEbi3b6l2HtYfWLHVkRcXAJtbcZK9Sjte97WtAzduifjjC
	Huk7cDiu1IMynLZd3qvpQh+IqWQexQsmqOcwUYrsMYVzEYJ9/t3JjC/TQ6VwU11phlQbSB05vINxT
	/6AaOMQGw7O6qSfEYew6eB+h1CHckPYx0NeicDSXVv2YcTzH/A9x6S3cRVqmOj86YK4P8dFIoNzaO
	ss3zV49maz70+otPjVh7C5nIusWU23hKXssWtc+4y9bKXskGVJLQLAxrPbEdqFOUAecxHqLiflus8
	uHuuvmpIPZMFpjxAPq7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh6Yg-0000000ChCv-2IBI;
	Thu, 22 Aug 2024 12:04:54 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh6Yd-0000000ChB4-2alT
	for kexec@lists.infradead.org;
	Thu, 22 Aug 2024 12:04:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724328290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZRxqb0+LBWgvJI7l0bIvtzhcmJ+Lii5dEsLzcEYoGcQ=;
	b=Pvtk2j+55t9yphVBHTIQrxvDDAhgwDaguxB1Fq+7oXJi1J+LK0JJdhRF9nLDo4Yk8Gnn5V
	PvOnov/m5H0Ynca8h0fkpqN42QP4R7GpC83dBKg+Q/xxRp7Pqbe/bZdZkUS8FTzGdPPo4a
	DVrzU/Th8YkHV4znukVkkRmxyJdivFc=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-qLyjFzJWPhmhmdzAowBbgQ-1; Thu, 22 Aug 2024 08:04:49 -0400
X-MC-Unique: qLyjFzJWPhmhmdzAowBbgQ-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-201f27cdafcso7481755ad.1
        for <kexec@lists.infradead.org>; Thu, 22 Aug 2024 05:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724328288; x=1724933088;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZRxqb0+LBWgvJI7l0bIvtzhcmJ+Lii5dEsLzcEYoGcQ=;
        b=TkjOQKRPNbf07knKb6n86uqgNFK6AFVghXWJVVbajdXe97sGtp9zcheMxQU3wovsAh
         UVq4Llmgbg9xl7GeDH+gJ2zFGAwJvLPAJIR+ME7emBXb34x3DOckxZvxSwKhPW00y5wW
         zAviwsyissi5aONHG+sAqvtTZXE2o9b9CwMJUfRYU4yT0L0DvrAwphxH8hir8ZMldg3X
         kndJfgnWls0qP31IXyIT5SxNumVJcD61+iDzoBz+Bv/f4t6aT0+K+Apba00plmxywOCj
         pxCnQESPDDRdy8A38hdq9olzYMdTj5WZfPzcvoJBVwcldNR8Dl4pYTVDs6oZ80Oq5xhW
         AfIg==
X-Forwarded-Encrypted: i=1; AJvYcCVhVB9zo+5Ya51kx0myVifUYLkYUAjiYb33EWcciB8NzYfcd69JsSB4pPCkbQojTkobABHKTQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwoqjJJuqKfDGegRU21s2wwWfBM4B3+oWDUBqattnB22j7EMjcJ
	wt8/G3j4v+vTADBus/SjlisU4EetNRD9uopnqk/x2JfS8fyC9m3SVVwrIFWRYdVi3o0Cue/fwsl
	eyW9O2dkLymrVNVq18XuZi2/h3o0iir5LaC0/iIW8jpW8vnHIrtD3F/F9TtkqcKsu8Bt44Y6aSn
	TdWfl7xLZ0hiKrGTobtSrMsIpFswix5upptrYzWi2FJsc=
X-Received: by 2002:a17:902:d2cb:b0:1fc:6901:9c35 with SMTP id d9443c01a7336-20367d074f8mr59134935ad.20.1724328287743;
        Thu, 22 Aug 2024 05:04:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1v+uoAtKSiDZxaczWF08SLG9Gd1AAeF2w/dT8PMJW73gjNN5rmBu3aiwmk+3SOVpzCwbWmyF+g/abINV5+U0=
X-Received: by 2002:a17:902:d2cb:b0:1fc:6901:9c35 with SMTP id
 d9443c01a7336-20367d074f8mr59134625ad.20.1724328287380; Thu, 22 Aug 2024
 05:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240819145417.23367-1-piliu@redhat.com> <ZsX5QNie3pzocSfT@gardel-login>
 <CAF+s44S2Ph1_nFcZYy3j0Jr4yuHayb5zdNu1YXg8ce_Lf3TOgQ@mail.gmail.com>
 <CALu+AoQRdxJUpNK_eCjKJ=ydRZ4av2S3xBaz3CYJZp12xqm=jQ@mail.gmail.com> <ec8befa0-f193-4de3-acea-8e37f8437c7e@app.fastmail.com>
In-Reply-To: <ec8befa0-f193-4de3-acea-8e37f8437c7e@app.fastmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Thu, 22 Aug 2024 20:04:58 +0800
Message-ID: <CALu+AoR3=a6suS0KyC7HJBOca8zBA0Y2AteF4=b=21j=pVKm1g@mail.gmail.com>
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
To: Jan Hendrik Farr <kernel@jfarr.cc>
Cc: Pingfan Liu <piliu@redhat.com>, Lennart Poettering <mzxreary@0pointer.de>, 
	Ard Biesheuvel <ardb@kernel.org>, Philipp Rudo <prudo@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_050451_756820_34CF9B3D 
X-CRM114-Status: GOOD (  18.86  )
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

On Thu, 22 Aug 2024 at 18:56, Jan Hendrik Farr <kernel@jfarr.cc> wrote:
>
> Hi Dave,
>
> > I forgot why we can not just extract the kernel from UKI and then load
> > it directly,  if the embedded kernel is also signed it should be good?
>
> The problem is that in the basic usecase for UKI you only sign the entire
> UKI PE file and not the included kernel, because you only want that kernel
> to be run with that one initrd and that one kernel cmdline.

Hmm,  as replied to Pinfan I thought that both the included kernel and
UKI can be signed, and for kdump case kexec_file_load can be used
simply.

>
> So at a minimum you have to have the signature on the whole UKI checked by
> the kernel and than have the kernel extract UKI into its parts unless you
> somehow want to extent trust into userspace to have a helper program do that.

extend trust into userspace is hard, previously when Vivek created the
kexec_file_load this has been explored and he gave up this option. :(

Pingfan,  nice to see you have something done as POC at least, and
good to see this topic is live. I just have some worries about the
complexity of the emulator though.

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
