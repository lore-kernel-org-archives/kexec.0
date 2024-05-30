Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F8E8C25B7E
	for <kexec@archiver.kernel.org>; Thu, 30 May 2024 09:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=keZUA9zdKmKHBchry4R/fRM4M/3li3CTMBZq4DlV8H4=; b=iR5IGwLqKXkFfo
	jyz3YBQltz/GUqvgkQ42FFLUyjDlc5LY599EvzlNGBemXizO/pxgz4T4LXiAHkXrLR/GqfUCObcqt
	IyJLFeGONMfJml/X9w7cId0rb+W2vSGKwhHrBAKzkw8y8Crv2/8urrUlHe4uuJ5gqjfmQTOmgQqbW
	FPeWe//sQw1dKH9VuIloY70TSZ42+n3Sq57L6nQY3u+yeAegRKT1JRoqt02vzS8Ouy6Jz3CJVSS9N
	HnyftcgRfAFlMTKwx/itsf0MLWQT1DFlsjuVOAHzvCAWJvO4lU1qlY2wdA2gmdWV3U/cqGWenQiaI
	+Il015n5bQz/KNFW7cBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCcAI-00000006pyO-2OHE;
	Thu, 30 May 2024 09:33:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCcAB-00000006pv5-2IZe
	for kexec@lists.infradead.org;
	Thu, 30 May 2024 09:33:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717061610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TUC3GiLS6AozngaUvzZHBJhHgqIjB6D128VJ0PlNNsQ=;
	b=KykmsAP/XXBYAJ4440LzVTPQAsfst/SP/rBWN+eynAt+tbOB+uJvd7woKYkTyOJ9SK74hZ
	wdfy7cyBDxXwNK3P6SUmyO7NFCU2+k4fcqPtWe9fDjaFNRsgZY50XK9VLjbPOeSlXfkYvS
	uu/hBdS9WnDl1rK3RHxdjlnBV/uufQY=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-hR2ii8YcOriGECmnlCsezA-1; Thu, 30 May 2024 05:33:26 -0400
X-MC-Unique: hR2ii8YcOriGECmnlCsezA-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3747f78b7f0so788325ab.0
        for <kexec@lists.infradead.org>; Thu, 30 May 2024 02:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717061605; x=1717666405;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TUC3GiLS6AozngaUvzZHBJhHgqIjB6D128VJ0PlNNsQ=;
        b=O3a7ctP8Tve72e3338z15VWHsP6gKqj/aFn9iMWl0kJTmPitzII0EL4DpI4pSXXoSi
         xYbozpTFSE5W+4aGuizcyMebcMVc6GuJAvvrRyXoHKPX0HpXB9TspB7QH+3d2YslUbcb
         92FFrxeCW2l/2u9CcoFIaHB2ultEwes+PGvdkcngq44IlAhrzVovMJxxDwbacUKNOql5
         nNroWFZhod1ufIbvz8xJWTbsN+vtDxQI1kphoMW0++khJFA0aAA5aXRbvPkyog+BpaiR
         Xmj10k0FDYrqzfQss3EAf+0hndqWxQb2QlCjjLZfD7qQcAsjIILu4GfUmKlwCv9MEdsj
         fg/A==
X-Forwarded-Encrypted: i=1; AJvYcCUC/mzeRNl+JCyhifPYnvG3zWtsF3rJAFyyKwXzri+GtUoTexQpHjmFsyFBbpXW8xtmCovTSyfrHkjQx8YGNAwXut1Z4hYRV7DZ
X-Gm-Message-State: AOJu0Yw3wwzu+3N1jC4jy8Gdcbqf2XFWnfOOIVv+uBPtUceAJ8E3IUf9
	RzarbqLOvjr/u9NwFZL8V4ahYmJOI7O/IviLcWMQBLC1gsS8p8teNrA6jKc+p4hbm8r1oFrZwlp
	VsaJdYbsS9dU+dHwnB3owabuRmxjQX18Wc8FSIiOIfnuK1YFBSAcVoDpv9A1kCwkOQdWpk5+S4s
	uas14t68lHpAxG1wMO7QvibD+y7QbsnRZf
X-Received: by 2002:a05:6e02:2169:b0:36d:96ab:f4a with SMTP id e9e14a558f8ab-3747dfa63c3mr15236135ab.1.1717061605475;
        Thu, 30 May 2024 02:33:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF07FZF6G9bCv3Ha1VyWeLp5vvYcR+lGN7y97uhWQYZdbUL/l423c7F4PKTtj8AWBCWH9ONcFWnUZ8v1FJ3LEw=
X-Received: by 2002:a05:6e02:2169:b0:36d:96ab:f4a with SMTP id
 e9e14a558f8ab-3747dfa63c3mr15235855ab.1.1717061605055; Thu, 30 May 2024
 02:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240425100434.198925-1-coxu@redhat.com> <ZkrrIf1P6rx3WhjM@MiWiFi-R3L-srv>
 <iwx2noaevjat4uzqvagmrwgxgxj3rufanut4gnjte33thx2bdr@r3fhtf45sgrv> <ZkwS3UNmjTkK2HeY@MiWiFi-R3L-srv>
In-Reply-To: <ZkwS3UNmjTkK2HeY@MiWiFi-R3L-srv>
From: Dave Young <dyoung@redhat.com>
Date: Thu, 30 May 2024 17:33:43 +0800
Message-ID: <CALu+AoRZ0mQBL6pCsMxMck_j_tD9xGR2ubSa6tcy3pr6rfSf3Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Support kdump with LUKS encryption by reusing LUKS
 volume keys
To: Baoquan He <bhe@redhat.com>
Cc: Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org, 
	Ondrej Kozina <okozina@redhat.com>, Milan Broz <gmazyland@gmail.com>, 
	Thomas Staudt <tstaudt@de.ibm.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
	Kairui Song <ryncsn@gmail.com>, Jan Pazdziora <jpazdziora@redhat.com>, 
	Pingfan Liu <kernelfans@gmail.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240530_023335_670237_429210B2 
X-CRM114-Status: GOOD (  22.75  )
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

On Tue, 21 May 2024 at 11:20, Baoquan He <bhe@redhat.com> wrote:
>
> On 05/21/24 at 09:43am, Coiby Xu wrote:
> > On Mon, May 20, 2024 at 02:18:09PM +0800, Baoquan He wrote:
> > > Please don't add dm-devel@redhat.com in the public list because it's a
> > > internal mailing list or aliase. And I got error when replying.
> >
> > Thanks for the reminder! Actually it's a public mailing list and you
> > can find all emails publicly listed on [1]. I did some research and it
> > seems we should email to dm-devel@lists.linux.dev instead. Quoting [2],
>
> I always got this when replying to your patch. Maybe you registered
> before.
>
> msmtp: recipient address dm-devel@redhat.com not accepted by the server
> msmtp: server message: 550 5.1.1 <dm-devel@redhat.com>: Recipient address rejected: User unknown in local
> recipient table

Hi Baoquan and Coiby,  lists on listman.redhat.com have all been
migrated somewhere else.  For dm-devel, according to MAINTAINERS it is
dm-devel@lists.linux.dev.   I think the old address should not be used
otherwise it is expected to see some errors.

>
>
> > > To post a message to all the list members (who were subscribed with
> > > mail delivery enabled as of 2023.10.20), send email to
> > > dm-devel@lists.linux.dev.  You can no longer subscribe to
> > > dm-devel@redhat.com, to subscribe to dm-devel@lists.linux.dev please
> > > send email to dm-devel+subscribe@lists.linux.dev.
> >
> > [1] https://lore.kernel.org/dm-devel/
> > [2] https://listman.redhat.com/mailman/listinfo/dm-devel
> >
> > --
> > Best regards,
> > Coiby
> >
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
