Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB4DC4828D
	for <kexec@archiver.kernel.org>; Mon,  5 Feb 2024 23:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nMR+YF7bGI54f8xSTBnkRlkuFWV5thtvtW9o59sp9fo=; b=EEVQn7bAlUYdA7
	0hL42VhfO08cEHUxCYuDa2NSDnM+icTzrL+4zeaolaAW6z9pLlVNp+LB3fvmnxHd40j8bQjnDgKBX
	wnmQ8BMdF62ht9tpakOoJSVjDF8BMeuKI2TiP3peYzXw35ASq1FmeGudh8mH/nunAndXnsIRCGzTX
	X1t+thQsuflmgINcvmbQRFf7xZsaU5khj3pqdZ4YC6rXNuBQEUok0AQZ/2QE2+ej5K0vxV/Pks+z1
	qH0hy9eKeJw62jgwJULBwvrBIWdfEKSB60859lLHqhlUJNN+ofTn8j6yWFsA5iTID7mB4439aHQkT
	qrzHzuZIWz6EQerkumAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX8UH-00000005ZMj-0Kmo;
	Mon, 05 Feb 2024 23:34:53 +0000
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX8UF-00000005ZLL-0lpI
	for kexec@lists.infradead.org;
	Mon, 05 Feb 2024 23:34:52 +0000
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso4154189a12.3
        for <kexec@lists.infradead.org>; Mon, 05 Feb 2024 15:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707176089; x=1707780889; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gtL3jvJTvpjem+XLSIljDmdaRNW3JxGajKR4+xmGq/g=;
        b=dkV4n/ttLqk8mIEjGjrPX8zsaTBQVafqPtc+o4yoO1yoauf9maOO/73xb+O8O0vdD+
         NDvSX8H20rhZFAxmGQmU415eJnqZ1VCxczewfxPUIlsl7XA6ING6D8qdbKX6mtBYLdAY
         xGUJ7K0kPZ7IqNJVc41txOJOapEVwfL9e4K5TQvUAW+RQNZ0rzCWcsjF5Jf8qNoL3+8l
         nU1kkBKLZaL/brBul4vDpLEOXeV62O8z/34iZV2Z+E73eauc5LjsyBQaXBpcwghddxGt
         2cV8EyAuf1H7GT3YV6xMfoa3ibz74c/HmzGv6ox+rNXWC2nzUQWK3MkjJKit0+NYMl57
         6hag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707176089; x=1707780889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtL3jvJTvpjem+XLSIljDmdaRNW3JxGajKR4+xmGq/g=;
        b=UGfxwSApmXIaI9ffrnMy26/FjtUXS/eQDdgzsLIqa5LR4n1PqzBfjVaDNZvKYnu/Dq
         6CMf4mPK1DtVe0URh/3Ourxx69gen1zbKpcbl11fXTLfvCxKTNFhdA9v39ur/vv9JWM3
         6XZLBul4YSXL00uHM0iYbmBIblAMrV9n9WPH23vJIFiy3RYIvgFcx1rj8H8QNzKQWvaY
         2mOSPhTlngVNTtnbj7EL5tTyg4lws8WesnWuEHlW9XB47k46uEqRvFMZH2WVbOchR4FD
         Orb+gQv+2LWFDvLtaDw/Tcoh2cSRsfJYwhudZicxIH6fqdzJE00rV8Or32qdmb1dhn1Q
         bfhQ==
X-Gm-Message-State: AOJu0Yy8EfEEefIM01lIzSxS2erzBiJf1sqt9nti60jviyyRt+wv9LIp
	Gq9m5tgUXzBybX/tiSoBC6lPr8TYmLX8EPNvbluRKDo3XMoScNCQuCDIkm62XTc=
X-Google-Smtp-Source: AGHT+IERWsgnVzcArUkK0ONx3MiZk4r16tHisF/C0B+IjOUSmMRlRCaxDntU0A4X2gmwb0jbKeI/4g==
X-Received: by 2002:a05:6a20:5a23:b0:19c:6994:8913 with SMTP id jz35-20020a056a205a2300b0019c69948913mr18604pzb.7.1707176089472;
        Mon, 05 Feb 2024 15:34:49 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV0CEkV2IfB4OmDyzaC+v8m2BH8FR7RhAj08DN4ZCHOpokDj9NS3wCXNVRfk7DG1CgufYqK8wHCWHs/PTSMiUjOuQSYNN6ZB+aTscx7+cznoZDT8F2Z+x8Fq3mxFfB9Q2jg/LH2Xu5A+NenLIQoUHD99PduRSLqa/iSmtJqGUFocP6eazRhZvFPA9oDPPOrGfymNqdHw0h/nxszHDIMLLBz29NGLa3hIDKXa0S4z53eR2lqqcuHECKUht7VhUHfbFimSw7QRk7cn4BKB3os4xsrqwiVMkY7NRCwcGUSArF2DNAxABXpngViCgO/vzS6NOCH8aVzjxa+p7AcjKWz6oTuWjyOTrBZ8G63OPDI6g9B3Y9ih4iHTfBED1X+kcrAoyJpINXQ5q4bBt5dYYppH+8WNNuWMz2CNZCklGzQk9dJuoE2ItM4zSqmfovYw3ID101Lnd3kUjofr8ibkxgD8K3q6WDRUDbueTuqDCvzRQDSW98rcWllaXDIoFd2YDIC4WD/pL8BWmhBnN8pJ6k6aTgCMvz90BDChV469mYLup57WhnQyVmsE3Qc8hAeKEEGLeNjV2ax1UH2rK7sI8BbI4uqpLjJUj6kEP6G3Awmmm0ngNCcknaIUFOysIxxB9aT2a3JhYMHnRxYt1Ck/1I805Fl85lKwmRr4/1P9deiddme4xe2eCvJLYL3JVcbTYiI3Vs+wFW6KG3VQaHK+PxspiH1JWWW2QHFdaRaiqgAgi3xQs8I
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id k18-20020a170902c41200b001d8f12b0009sm423859plk.293.2024.02.05.15.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 15:34:48 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rX8UA-002agH-2H;
	Tue, 06 Feb 2024 10:34:46 +1100
Date: Tue, 6 Feb 2024 10:34:46 +1100
From: Dave Chinner <david@fromorbit.com>
To: James Gowans <jgowans@amazon.com>
Cc: linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
	kexec@lists.infradead.org, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Alexander Graf <graf@amazon.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Jan H . Schoenherr" <jschoenh@amazon.de>,
	Usama Arif <usama.arif@bytedance.com>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	madvenka@linux.microsoft.com, steven.sistare@oracle.com,
	yuleixzhang@tencent.com
Subject: Re: [RFC 05/18] pkernfs: add file mmap callback
Message-ID: <ZcFwlu9+LQQWWOz4@dread.disaster.area>
References: <20240205120203.60312-1-jgowans@amazon.com>
 <20240205120203.60312-6-jgowans@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240205120203.60312-6-jgowans@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_153451_253501_4E499283 
X-CRM114-Status: GOOD (  12.40  )
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

On Mon, Feb 05, 2024 at 12:01:50PM +0000, James Gowans wrote:
> Make the file data useable to userspace by adding mmap. That's all that
> QEMU needs for guest RAM, so that's all be bother implementing for now.
> 
> When mmaping the file the VMA is marked as PFNMAP to indicate that there
> are no struct pages for the memory in this VMA. Remap_pfn_range() is
> used to actually populate the page tables. All PTEs are pre-faulted into
> the pgtables at mmap time so that the pgtables are useable when this
> virtual address range is given to VFIO's MAP_DMA.

And so what happens when this file is truncated whilst it is mmap()d
by an application? Ain't that just a great big UAF waiting to be
exploited?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
