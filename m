Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24CD3CD1288
	for <kexec@archiver.kernel.org>; Wed,  3 Apr 2024 15:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gV7NGY7dUhW95E4L/Az2EUb35k0y0WaZ2nCP/2nDBfk=; b=rM6ce7nZHb1N6V
	sIJ8pIcYmQKMfgIPbRMZqNx7jgDabwPEPz6bIDuJG9Zlxr2oVlIbH1d5LILxRVlkQcWUgoSq/Vvb3
	ngiiFkLHIcTWEoEwRWeZDniqimICGfy9YFbujPHeMnClkMxFeECC0cMoIJlsEQXhKRxuR3V+lf8MM
	fNnmQzyOFpGnfkkwPZBmoh1L+GFYXGxXR5Q2WynIbGoOVIxoNzf5SMWi4JuJHcmFerm5m0BjuCSIx
	JNzg5HlN9nKWkCI4grRUo8ziAI2yzB+3/ITnQCg2dkRybbk74rJUnhdH4BjWeQBaWs6k/KWXJzJoA
	qRF3pSn+3oH9HlFVAJZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs2mm-0000000GnUY-3uZC;
	Wed, 03 Apr 2024 15:44:24 +0000
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs2mh-0000000GnSv-2fnr
	for kexec@lists.infradead.org;
	Wed, 03 Apr 2024 15:44:21 +0000
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6e9ddea8b3dso315365a34.1
        for <kexec@lists.infradead.org>; Wed, 03 Apr 2024 08:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1712159055; x=1712763855; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7PVVYuNrAUl36pyd3xeuvzvQvdQgmwGY67VpgOIWSOw=;
        b=UJBiWR6aIKmtCrQ/5Tv6veTi8kwRYoGidTwfXy/kxMizMi9F/OhYunbr6T6/SdOpGT
         Nh3ZiOyOPL//h2KSDYbdhbaDMjtvHR2EWyuZL7FEjUvjxwnLBWvxal/F92nL20Uxb+zJ
         N6RWgMU8kR8/3KdZDy2skT/GziGHGzwzqE+a/GZ/GzKMBnEGFQ1j+WiGTrfzybToLWkX
         4ADHqc73mJX/oCsR1vnqYdsTLn+DwgOQudv3sJscbaS7spHz84OebzMWJAPpKV3Mmskz
         9UVVReOzD7zG2aq99RF7wJ7Lum7zMafejvoZQANvMybVJnEADYIYeLjjpbV98g4AjdPl
         5WNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712159055; x=1712763855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PVVYuNrAUl36pyd3xeuvzvQvdQgmwGY67VpgOIWSOw=;
        b=j3x12B0oM2eWJkiXjaCl8VETMDbOnuRiAvpCQVcCYJxAUY4I53zayI1xlPI8s/tOvW
         jJBnM3BrJNjIZg9hNCg2DcaKAGcs31Ik/aYzqU6YoNxhi7mBajdkZt5j7nlucPtKdb29
         sN6LzdWr/ZYKOuGDBSZJdv1uXX6MyodCvlBYlv+IRErShQvPFDKKq5s+oxv0gEl42tOF
         9gonk343AOttoV4VhxNCdLZOJnBFQ0taOxeXzNdj77+mLUUPMK225naR+Uhhcke5RRDj
         ZxWiWD6OJZw0Jc3Nnk5UaJ/2ycp5JC7rR+3rTwMiafUuutgFWa88F3/G7F+iu+F3gkV4
         P9PQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZmWRNHNjtuEvjuxe+tnW2kqHtBXtliTQc/QcfrAS0VR+030H4HW0dUxiVsRzvNzDSzFJGO34kNzzJtANWIaEezm6qtzOBI/YY
X-Gm-Message-State: AOJu0Yz4pJO38ePKEhqdnEM1hDrEz32EkfJjD7v7W5yWzaxOAc3es/fA
	vGUjZZMF0Y6UfE9mZnf5mGjqRjLWF42wR+/3jmeQM82YN+OsdKZLVVXJuEw0lLQ=
X-Google-Smtp-Source: AGHT+IFZkhbozTXxif0mxmF92PRdOyaPTrbx7gCtN2UwQ51SV5wycjFky/1bPdc61ntu60EA8vaM6A==
X-Received: by 2002:a9d:6f85:0:b0:6e8:aba7:4b8b with SMTP id h5-20020a9d6f85000000b006e8aba74b8bmr6319870otq.34.1712159055700;
        Wed, 03 Apr 2024 08:44:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id f8-20020a9d5e88000000b006e6e3fdec53sm2673494otl.35.2024.04.03.08.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 08:44:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rs2mc-007hKH-2b;
	Wed, 03 Apr 2024 12:44:14 -0300
Date: Wed, 3 Apr 2024 12:44:14 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Margolin, Michael" <mrgolin@amazon.com>
Cc: Tao Liu <ltao@redhat.com>, Gal Pressman <gal.pressman@linux.dev>,
	sleybo@amazon.com, leon@kernel.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: Implementing .shutdown method for efa module
Message-ID: <20240403154414.GD1363414@ziepe.ca>
References: <CAO7dBbVNv5NWRN6hXeo5rNEixn-ctmTLLn2KAKhEBYvvR+Du2w@mail.gmail.com>
 <5d81d6d0-5afc-4d0e-8d2b-445d48921511@linux.dev>
 <CAO7dBbXLU5teiYm8VvES7e7m7dUzJQYV9HHLOFKperjwq-NJeA@mail.gmail.com>
 <b6c0bd81-3b8d-465d-a0eb-faa5323a6b05@amazon.com>
 <20240326153223.GF8419@ziepe.ca>
 <0e7dddff-d7f3-4617-83e6-f255449a282b@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0e7dddff-d7f3-4617-83e6-f255449a282b@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_084419_822292_9F62C0FB 
X-CRM114-Status: UNSURE (   9.51  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon, Apr 01, 2024 at 04:23:32PM +0300, Margolin, Michael wrote:
> Jason
> 
> Thanks for your response, efa_remove() is performing reset to the device
> which should stop all DMA from the device.
> 
> Except skipping cleanups that are unnecessary for shutdown flow are there
> any other reasons to prefer a separate function for shutdown?

Yes you should skip "cleanups" like removing the IB device and
otherwise as there is a risk of system hang/deadlock in a shutdown
handler context.

Jason

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
