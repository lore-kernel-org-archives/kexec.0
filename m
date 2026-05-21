Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B512CD5BAF
	for <kexec@archiver.kernel.org>; Thu, 21 May 2026 17:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HSg+nGWk8GPf9iWHEueYvLqEM2Vxl0dwdaE30hzKrbQ=; b=hm6WruJe5bHuncV7scX9tbz6Iy
	ne4w2i5DwN2mkifJ567m7qWYqtKkLmkOMNsVbDO2Ia8HR/Cv+wJIlgPIQvhY8ppTdmTOW9Tutoh+/
	brQIqtlJ5B+8QYyAx/Q3lz9X/4t7JU++DtDyeLRxaTQmchaPTo5EZASNJ7ZuPnx1pYUarCvxlGYFI
	W7mODFcwhE5Qmu3Muz6J37zBYkpf9cHk0SKdu8UIvL0b2zDkWIafl15CMNpFjIO2++VPG7ikAPh8f
	RW1LQfzeb/Juet+lR475e2K4Snd4kkwxsbP1U6M35lqYbf1yEAJ+2PzbG4t2Mv1flArBXajLGfgHS
	EoStsMbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ7ec-00000008hxW-39kk;
	Thu, 21 May 2026 17:57:54 +0000
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ7eZ-00000008hwc-1ksp
	for kexec@lists.infradead.org;
	Thu, 21 May 2026 17:57:53 +0000
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-91173f20ccdso296077485a.0
        for <kexec@lists.infradead.org>; Thu, 21 May 2026 10:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779386269; x=1779991069; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HSg+nGWk8GPf9iWHEueYvLqEM2Vxl0dwdaE30hzKrbQ=;
        b=SnGKc9YQu1egxE2O0C0ifWUaE1fxEHGKwlDhQIL3eC+A60FnQdyJWsUTnBXRNeLIA1
         79Ab9XK4EmHGCNd7Ve9voNpmXaBgJUvRiqUpIYsx46xqP2YPbAA5jCArX8aNX8nlwzOT
         hgrFhC/cTEWyvNESdmVdKpOxkcF816mkIjJB9t54K0jaJ5kMa841X35q4hkqEcgCsiDB
         pmr8Q7C76J2uPOH9rSa6QiTOhrQmKLCw3niiO4OXzTyrnoksyQJOL1yqglHzpmpzeQX9
         qZo3RlQz/+Pce9PttXwTsKgvn3TwNcwmof2/wPF5CR5GgD5O7EF1uSeIQJEd0zbrERbg
         /5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779386269; x=1779991069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HSg+nGWk8GPf9iWHEueYvLqEM2Vxl0dwdaE30hzKrbQ=;
        b=DM3vGh6bS1vbi7eyo4CoNxqBPPg+kyB7k3WBfla8a78T/ubDHQ6tkG8tb3rn8kRjsU
         W39mPP/Q0v7iPx4VjPPuesPVq8qY30k6TWWYhpsu08av+PjcdqK++blc2mfUPjVY5Et3
         9Zpb7ED8ywxuy3EaKGwrqfatt6E6sP0VATzAL1seLmO5xh8b1AguA7VHhYZVgTdJgmDX
         0YF8ZcHJb8NIuNQuQAogqQBDkDJ0400qATuIPBIhtPq5M8Rx1jqdl8VKTsahjF7j/go1
         D0X0yDcORzpWLDSw48SsNqqZ4QgJOagqKXDRefo1uc2B3S+loLIkLA1z+9VzBNDeKMbG
         U6Cw==
X-Gm-Message-State: AOJu0YzHsWVtRrR0+zIUdIuYOv+1Nbkj1VyB1giQ8VUvrl5/qsVkcfa6
	76grajFl3O9rioYxH5R+1F/W9yA0dwHfy6cqotZCSE4SOEXPT8lMvL8+IOB+pX80eZM=
X-Gm-Gg: Acq92OGOMc3e9fDP5OutmQqupARMmAB+m9wPAN3JRU89PGJnP5vT8xvzk3kx/n0O2Qs
	zpXKBOgr/BMWEDtiP890uanX2wXIES+vSAQzCYfZcDlSVW7pGBPirxCLAzF62mUyBd+z9wrbpMK
	3zD7/AspCqlVoElxL0pQukaG7vZ8owfN8RIdCv6jG8kNVzhqH7vj9D74janvKVtfTiMK/KGin/y
	9dJLNLLEAmSm3q/e1aOZDfn2prF+fzbXytQSYnTtLk8AT4tcSLgdw3vKkgFGuUxuKz1YWvGThFr
	IBvdvKTdl+dHPz+TjUg3WeKmpMiRQCEcsTjXjZqq190e7i2kGkSd117Z/Z8PZuONkPXpwZBiooP
	vz8cwLS9uSkOvGSzMq/OAJdoIjpUlBW/HcedH347njgWeTlUS2Nu89r86MJJiRrlzhcxdSuJtlc
	XHhsiHgKaH4t4HIUcYO1Qs4/CJx4oBIdEi90M7zWkxK5rBE+WtmSw=
X-Received: by 2002:a05:6214:501c:b0:8ba:b699:9e54 with SMTP id 6a1803df08f44-8cc7b5f1a7amr5338246d6.47.1779386269340;
        Thu, 21 May 2026 10:57:49 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc781b3611sm13231686d6.26.2026.05.21.10.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 10:57:48 -0700 (PDT)
Date: Thu, 21 May 2026 17:57:47 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: luca.boccassi@gmail.com
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, 
	pasha.tatashin@soleen.com, pratyush@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] liveupdate: document systemd support
Message-ID: <ag9Hj5j4OFRn1G8c@plex>
References: <20260519152957.548119-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519152957.548119-1-luca.boccassi@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_105751_472533_F2376092 
X-CRM114-Status: GOOD (  16.39  )
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

On 05-19 16:28, luca.boccassi@gmail.com wrote:
> From: Luca Boccassi <luca.boccassi@gmail.com>
> 
> systemd v261 will add native support for LUO via the file descriptor
> store mechanism. Add a brief paragraph in the LUO userspace documentation
> page to inform users.
> 
> Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> ---
> NOTE: the external links will mention LUO after the next release is
>       published, which should happen within ~4 weeks
> 
>  Documentation/userspace-api/liveupdate.rst | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/Documentation/userspace-api/liveupdate.rst b/Documentation/userspace-api/liveupdate.rst
> index 41c0473e4f16..f6efc32fb40b 100644
> --- a/Documentation/userspace-api/liveupdate.rst
> +++ b/Documentation/userspace-api/liveupdate.rst
> @@ -14,6 +14,29 @@ ioctl uAPI
>  ===========
>  .. kernel-doc:: include/uapi/linux/liveupdate.h
>  
> +Userspace Integration
> +=====================
> +
> +systemd (since version v261) uses LUO to preserve its per-service file
> +descriptor store across a kexec-based live update. Services opt in by setting
> +``FileDescriptorStoreMax=`` and ``FileDescriptorStorePreserve=`` in their unit,
> +and push file descriptors with a name into the store via
> +``sd_pid_notify_with_fds(... "FDSTORE=1\nFDNAME=foo")``.
> +
> +Services may also create their own LUO sessions (via ``/dev/liveupdate``) and
> +push the resulting session fds into their file descriptor store like any other
> +fd. systemd detects such session fds and handles them accordingly, and
> +hands the re-retrieved session fd back to the service after kexec, using the
> +existing file descriptor store service interface.
> +
> +For details, see:
> +
> +- `File Descriptor Store <https://systemd.io/FILE_DESCRIPTOR_STORE/>`_
> +- `systemd.service(5) FileDescriptorStorePreserve=
> +  <https://www.freedesktop.org/software/systemd/man/latest/systemd.service.html#FileDescriptorStorePreserve=>`_
> +- `sd_pid_notify_with_fds(3)
> +  <https://www.freedesktop.org/software/systemd/man/latest/sd_pid_notify_with_fds.html>`_
> +

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com> 

>  See Also
>  ========
>  
> -- 
> 2.47.3
> 

