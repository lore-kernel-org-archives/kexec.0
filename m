Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC61EDE9A0
	for <kexec@archiver.kernel.org>; Tue, 10 Sep 2024 16:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ks9nhWVP4MUVoD9CWGkhd6ztbeEQ04UjLvWZUoT8Kmg=; b=TTmQtXCTkJIkTQ
	mIujdzOaHp6QubYmIWKa3fqL+atwa6M4iFEutb0gQwzi9nnQQcdgeSzWxcoevnRN2aiiVW3CbNx+m
	acpQbFEPgQnVzKgMu/5dUwwad0VsF5MedYIZpGbqhsrvqjtnafjNRRDBM5FfxdgctsEMIJld4qx9Z
	RsQ+VFOHXIoE+eESPHLGk+EObfJzUupCR2lMvfIh6Gkop/J0/hjeaWEiM6rxfz2+4+UVA7FYUJgX1
	dgDKI6jheCzx4UNo0VC/nolHR/i7zvFccSfQc4UNDd6JGlxUiYIkAx2+LUAzauICDfVWFBYUmsojK
	fVEHoZVJmHoeDe4oyBsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so3WO-00000006Iap-2PkE;
	Tue, 10 Sep 2024 16:15:16 +0000
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so3WL-00000006IZn-3tVF
	for kexec@lists.infradead.org;
	Tue, 10 Sep 2024 16:15:15 +0000
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-457e153cbdcso44398811cf.2
        for <kexec@lists.infradead.org>; Tue, 10 Sep 2024 09:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1725984912; x=1726589712; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U5oeFB0UtmNBoPkoP3tI5YAp46EtRYc2ABouATqet3Y=;
        b=RfvDu7t9IQSjb3VUSjKeHiBzOIQJbOhxR4eA8Af43YFNrUdZmwg9aeBQqFXUmjf5j2
         1Go7T+ngCD1sUcLRNJDaiR/TDp0wKuyJ08w/75ydNi9sDM8YoWtONBY/g30s7yzW4wEj
         oZD7EUSTKQ0Ki5We40XENE4xOOk3Ze/txDHIwQawsuoqOs+jSjUxLTbi0q78l1jHAaBq
         TfYMt+HaOHbMc9vErWrBlomEChgB/3HLSQBLSlNaO2ZJG7TVtwsfbwM7S8JmVv9zC4Hp
         dnYKTK2PMhcWAnm+dqVKr/8VZDB1qP8+Y7ypQe8rjNUqLfia+/TbsoK+P7l8LD+j5qej
         k+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725984912; x=1726589712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5oeFB0UtmNBoPkoP3tI5YAp46EtRYc2ABouATqet3Y=;
        b=jMZrughUl6WIo+hS5q3p8hMZtSXybOjvC0R+XK/DaGo1B6VNpREPJD99o6TRGcJMT4
         17DgDHkV56tDNXsM0H69AUf9B3y3nArXmXDby/Pyx7ovXOioP5+3BPiwy2Bk8JE3qJkV
         txwwumGaAjh76cyY67gMH/5PT5L+Z7jr93MVUEF+Zsc8yCa256tsbRhOMLXtn3F8mip/
         aSE7+yFEhpIZk4HZ3zT/uKAh+3758eIDWQ339drgn4z2CiPlat0sLgGQSEUJSwf0fDax
         9d8tmzADjazEPe45YtrWsUTV/GYcIvPPApQ4NHW0nmZq/+zSSNOHlxuCPs8JyVFY4tkB
         aVHA==
X-Forwarded-Encrypted: i=1; AJvYcCX1t9aAnW0OxfNM11WzBLlyyFipp1oycLCsCknrALcJPHzp27aU4JRjg9YA4cehjOnMIGARiA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyO90tPkOqA7y81yoMMn1HZRvJNBUUyU83hwVQi41idgFAhT4pY
	Tl0FPI8O7Nm3pgKfPL56lt1X2yuXH4hFzfgKrz9x+Y9vGndpBu6yQLsnAWUTcqI=
X-Google-Smtp-Source: AGHT+IFTpWJi2aFDiPPHk0+23A7HN9yHR65F6ZyPjK7cId6epq0hxHHaXBsc3ShG3FbcaSvGW7M5IQ==
X-Received: by 2002:a05:622a:198e:b0:458:294c:39e7 with SMTP id d75a77b69052e-458294c3dd5mr172987661cf.38.1725984911873;
        Tue, 10 Sep 2024 09:15:11 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822f93978sm30231351cf.83.2024.09.10.09.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 09:15:11 -0700 (PDT)
Date: Tue, 10 Sep 2024 12:14:32 -0400
From: Gregory Price <gourry@gourry.net>
To: Breno Leitao <leitao@debian.org>
Cc: Usama Arif <usamaarif642@gmail.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>, ardb@kernel.org,
	linux-efi@vger.kernel.org, kexec@lists.infradead.org,
	bhe@redhat.com, vgoyal@redhat.com, devel@edk2.groups.io,
	rppt@kernel.org, rmikey@meta.com, tglx@linutronix.de
Subject: Re: EFI table being corrupted during Kexec
Message-ID: <ZuBwaAA_84weAzuW@PC2K9PVX.TheFacebook.com>
References: <20240910-juicy-festive-sambar-9ad23a@devvm32600>
 <87ed5rd1qf.fsf@email.froward.int.ebiederm.org>
 <9b024f7d-e326-46eb-bd88-71a16151fcf0@gmail.com>
 <20240910-strong-dancing-rottweiler-aaed51@devvm32600>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240910-strong-dancing-rottweiler-aaed51@devvm32600>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240910_091514_082555_83B0A06D 
X-CRM114-Status: GOOD (  13.57  )
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

On Tue, Sep 10, 2024 at 09:09:21AM -0700, Breno Leitao wrote:
> hello Usama,
> 
> On Tue, Sep 10, 2024 at 04:46:15PM +0100, Usama Arif wrote:
> > --- a/drivers/firmware/efi/tpm.c
> > +++ b/drivers/firmware/efi/tpm.c
> > @@ -60,7 +60,9 @@ int __init efi_tpm_eventlog_init(void)
> >  	}
> >  
> >  	tbl_size = sizeof(*log_tbl) + log_tbl->size;
> > -	memblock_reserve(efi.tpm_log, tbl_size);
> > +	if (!memblock_reserve(efi.tpm_log, tbl_size)) {
> > +		arch_update_firmware_area(efi.tpm_log, tbl_size);
> > +	}
> 
> Shouldn't you reserve the region into 8250 independently of
> memblock_reserve() return value?
> 
> Thanks for the patch,
> --breno

Probably also want some sanity check here that we're not over
writing already reserved areas before we just update the map.

If we're dealing with the scenario where we can't trust the
hardware/efi generated map, we probably want to put a small
amount of effort to ensure we're not wrecking the state when
the system is working correctly.

Only so much we can do in this scenario.

~Gregory

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
