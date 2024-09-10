Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2580EDE9A0
	for <kexec@archiver.kernel.org>; Tue, 10 Sep 2024 16:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=28y/KsAhM2zO2JSurngLfbOGTVCUQ7iylV5NW+jiZFI=; b=QvlgnDii4kVbHK
	zASe5HidnDan2tlfuUDYbTik+2FgJ2udKyDChjq5P09YpQXZAb7X/0Iu2TEM2SQlOHtAaPyjQ69vG
	M2uOUxnZP+GZ1bVHJlskPTW0jnRDbUpUNr4qaPryrHUWvSmOIgLU2a9oQlx0KWHHlzaUDRiONuik9
	cr72QAlhgSDXk58Ey4rJyywsOFcNXgUXxQH6aJLUDUURCq0hC0lceh3i3BnS+1HuPCB7qpdA9E0y9
	ReC4uA3ACTDpb9Wo4HqXy6Ne3qHtu8pjjMAuoXWPUz7tYhkwqjEDlIvYnlEiPfTlJLnPiWIWAA8JV
	dz3waD6dV7joQ4zPrXfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so3RM-00000006HxT-2eW9;
	Tue, 10 Sep 2024 16:10:04 +0000
Received: from mail-ed1-f43.google.com ([209.85.208.43])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so3Qs-00000006Hsv-0Fv5
	for kexec@lists.infradead.org;
	Tue, 10 Sep 2024 16:09:35 +0000
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c3d209db94so6254303a12.3
        for <kexec@lists.infradead.org>; Tue, 10 Sep 2024 09:09:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725984572; x=1726589372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OICN9yWXeUKoIzpkf47HqdysUCLiFXPVEMv35d7OftU=;
        b=dwpFwTjQJuG+7NulxCfCbeYUYvEXs8B+wyHJtGbm+lmonlfMXUC26O5wgEHkFeFCrh
         sxocicbWWe6xWET+wTaf9xEiVYIzOl4D6fxrk7avt8zBUZtanzyKlEEZ10BJ3yA7Gnjh
         rJTg8CTKs5IKIshtf8j9uZhx31cl5kZ31RDOsJGWIBIAPiSzbVgNTRQqhjYwahyCx84I
         nRDQXyq2Bm4Rxti1z52KgV7J+9zdkOrRE1gFC0gK2r4e33Mpkt5M/+jS31+5e8rMPR8T
         saRgQgH297DDVcXzZjYnUAz2LZ6/kVzOclujiVx9jyieIQD0ie8/uR3wkBqMjTyyNcNw
         +SUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3FFALkQPW7Dyu0lj/slLWO5ivX71B14+9mobYW8u6BDDnEIDTtWwEMGgyf3SKZfkONfOZnw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw9bz7oKzvxyE39NWuFd6wbOPMnqZZ2s2913m4V3t6YOUrNu8nD
	1ouFBzzX3G2J4yLmAOrvOvTncKxwoM4ekim95c4O0MaiJyAzx1IQ
X-Google-Smtp-Source: AGHT+IGNrkxiR+3Iqt74NRnDw9jegrN1LNQi6QH6ygQSAS6+yyvwbVZ0/uE5DBfWEfyrmIMzBTFiUQ==
X-Received: by 2002:a17:906:730a:b0:a86:68a1:6a08 with SMTP id a640c23a62f3a-a8ffab8346amr133085166b.29.1725984571286;
        Tue, 10 Sep 2024 09:09:31 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d65742sm497575366b.216.2024.09.10.09.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 09:09:24 -0700 (PDT)
Date: Tue, 10 Sep 2024 09:09:21 -0700
From: Breno Leitao <leitao@debian.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, ardb@kernel.org,
	linux-efi@vger.kernel.org, kexec@lists.infradead.org,
	bhe@redhat.com, vgoyal@redhat.com, devel@edk2.groups.io,
	rppt@kernel.org, gourry@gourry.net, rmikey@meta.com,
	tglx@linutronix.de
Subject: Re: EFI table being corrupted during Kexec
Message-ID: <20240910-strong-dancing-rottweiler-aaed51@devvm32600>
References: <20240910-juicy-festive-sambar-9ad23a@devvm32600>
 <87ed5rd1qf.fsf@email.froward.int.ebiederm.org>
 <9b024f7d-e326-46eb-bd88-71a16151fcf0@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9b024f7d-e326-46eb-bd88-71a16151fcf0@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240910_090934_119283_38FE6810 
X-CRM114-Status: UNSURE (   8.88  )
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

hello Usama,

On Tue, Sep 10, 2024 at 04:46:15PM +0100, Usama Arif wrote:
> --- a/drivers/firmware/efi/tpm.c
> +++ b/drivers/firmware/efi/tpm.c
> @@ -60,7 +60,9 @@ int __init efi_tpm_eventlog_init(void)
>  	}
>  
>  	tbl_size = sizeof(*log_tbl) + log_tbl->size;
> -	memblock_reserve(efi.tpm_log, tbl_size);
> +	if (!memblock_reserve(efi.tpm_log, tbl_size)) {
> +		arch_update_firmware_area(efi.tpm_log, tbl_size);
> +	}

Shouldn't you reserve the region into 8250 independently of
memblock_reserve() return value?

Thanks for the patch,
--breno

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
