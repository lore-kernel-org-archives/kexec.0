Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A80E677F8
	for <kexec@archiver.kernel.org>; Sat,  2 Nov 2024 10:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sj+yft75CRfzXWLYVyOug1K6QASgMe9DyqtMaDbhY9Y=; b=XRdkskPxa+HvIo
	+BmEk5Gtq//ajU8YUNjMnGGmxQGQOCMD2M4VsBCeDNNyz9BbtFXDP5x2sQkWwDwSGLrTgHSdipxeT
	/eoGS5FAyarqgOY1Q76P7CWcN47WUyMv1Vi23zLPwsxHv2Rr1EZKPkZogQMjFfzoFajgUX3eSNVGj
	6Jc6QOpBhfoRPY2cvHLBFcy/m61hAxG8tDNmh+ljSzXp+/24cEZ4LgxCQWclB8QwxAIjvAI/ZvM7l
	R6g+Vsn+NFWYoXPCMhc+7CjO5O7sRtHjL1gQwukmq5H/qhTntz479E1tSwI50JpkBu88IEl6Z3oa0
	IscCtwnNLNOrNwj0ovWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7Bme-00000009XJS-323H;
	Sat, 02 Nov 2024 10:55:08 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7Bju-00000009X2N-0lom
	for kexec@lists.infradead.org;
	Sat, 02 Nov 2024 10:52:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D13A45C3803
	for <kexec@lists.infradead.org>; Sat,  2 Nov 2024 10:51:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D46C4CEDB
	for <kexec@lists.infradead.org>; Sat,  2 Nov 2024 10:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730544737;
	bh=BNs0vMT9okoG3ctz2ayg1gJ18NykgP8pjbU3xi9lAVw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dK6SLEGG9PayZ9NB+yOQuKF8a3NnL6Y0fIfORpLa9E298aTBP5OUL6VMVh4iN851Z
	 q6m1AS2LNLmZtz82eBXbkqwmHhgRVGWkl0fQfg285Eoh1GljmfPdmo6+dkui06WP43
	 e3zzoNVilyvT8Hhki3HEVDpyw1CM/LcI8+rX4XRCp61aDnYae7ysCURJH8WqEYeAUu
	 p0YmO+QMj5j+ytAF/odZNigrvZlRGsoyi8r8YmH48uOmNKHoyTRqwweJxgTGuh1c1u
	 QwDbNWV0qnLsOV+lWadWQo0T3rVCOCpdnUtokbDMJ40gsPNnBL9sS2uqCfWm5HeKI7
	 31UpiW1YXO8ZQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539eb97f26aso542080e87.2
        for <kexec@lists.infradead.org>; Sat, 02 Nov 2024 03:52:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUfy+hTDK8BhieTcBcPxYx8DtPs/+kHHDTgoln+KtyJOiROeq2Gmwl/DBYzv2Xr1+jm4bVqXg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwsiCCkJjhkf7Ma55EwIanFpgLpKIhGzt4IJKxeYcthNjgovzxq
	PytzL2YLdhyFPWlQ1wJ2jYksT9kzZrWjNIGdzVNLC+2VG/ntoUm+g/iWd2xIX5oWNdLqRDBaGSF
	GEKihnQW6HnZvjX52pIpDY0lTTjw=
X-Google-Smtp-Source: AGHT+IGKIsyFNydotRxNbkfDFdnL87m+LkWPywtfpMYouXaEqYk6mvq/ex/9DjHC7TO0PtB9vxAygAsd35XhXmCRUnk=
X-Received: by 2002:a05:6512:1086:b0:539:8c02:64d5 with SMTP id
 2adb3069b0e04-53b7ecf213cmr7778977e87.27.1730544735380; Sat, 02 Nov 2024
 03:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <D5BB5GX4KEUO.VJ2G9G9QKYRR@kernel.org> <20241102062259.2521361-1-jarkko@kernel.org>
 <D5BHBW3NUS5C.293GUI03HMTCF@kernel.org> <CAMj1kXGk8y=rZiNiDcD-8mDKJB5HkTowM7g+kjO6616MGdTQaQ@mail.gmail.com>
 <D5BMMJYMVWKJ.3MIGB8KW34PR2@kernel.org>
In-Reply-To: <D5BMMJYMVWKJ.3MIGB8KW34PR2@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 2 Nov 2024 11:52:03 +0100
X-Gmail-Original-Message-ID: <CAMj1kXExMWBAx7geuU8Uwp9CQLpJyTgYmWUw2CtKd3xT8mMFsg@mail.gmail.com>
Message-ID: <CAMj1kXExMWBAx7geuU8Uwp9CQLpJyTgYmWUw2CtKd3xT8mMFsg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] tpm, tpm_tis: Introduce TPM_IOC_SET_LOCALITY
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	James.Bottomley@hansenpartnership.com, andrew.cooper3@citrix.com, 
	baolu.lu@linux.intel.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	davem@davemloft.net, dpsmith@apertussolutions.com, dwmw2@infradead.org, 
	ebiederm@xmission.com, herbert@gondor.apana.org.au, hpa@zytor.com, 
	iommu@lists.linux-foundation.org, kanth.ghatraju@oracle.com, 
	kexec@lists.infradead.org, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luto@amacapital.net, mingo@redhat.com, mjg59@srcf.ucam.org, 
	nivedita@alum.mit.edu, ross.philipson@oracle.com, tglx@linutronix.de, 
	trenchboot-devel@googlegroups.com, x86@kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241102_035218_329637_7368279E 
X-CRM114-Status: GOOD (  18.72  )
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

On Sat, 2 Nov 2024 at 11:38, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Sat Nov 2, 2024 at 11:02 AM EET, Ard Biesheuvel wrote:
> > Same for the ioctl() [as well as the read-write sysfs node]: looking
> > at the code (patch 19/20) it doesn't seem like user space needs to be
> > able to modify this at all, at least not for the patch set as
> > presented. So for now, can we just stick with making the sysfs node
> > read-only?
>
> Short answer: I have no idea. I would not mind that but neither
> the commit message for TPM give a clue on this. Actually, I *do
> not care* if it is RO and RW but I'm neither good at guessing
> random shit.
>

You were cc'ed on the rest of the series, no?

Shall we clarify this first, before proposing patches that introduce
new ioctls() and kernel command line parameters to a security
sensitive subsystem?

My reading of 19/20 is that the secure launch module sets the default
locality, and given that it can be built as a module, setting the
default locality needs to be exported to modules (but as I indicated,
this should probably be in a TPM internal module namespace)

If setting the default locality from user space is a requirement down
the road, we can discuss it then. For now, let's not go off into the
weeds and derail this series even more.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
