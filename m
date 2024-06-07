Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E09AC27C53
	for <kexec@archiver.kernel.org>; Fri,  7 Jun 2024 12:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3q/WGer3FeJFsZ+Jee4+fCKzCGjuEGaT+bFd/yAzxTE=; b=rAK8uALAL2Mg/0QOVvEzRvWdfV
	6CoLwyjRjkgCuDSMExXY/+sOY7VdNkVkCu512zy+W6mNvLzWGqARWbf3JUa+ny2daWNlR/WpUuZam
	pYPxGxJB3hybFEXdu+Eci8w4en0X7/TW0ZjXX6B/ejzrriIVHp7eFZLsoMZlblEfNt0NkTx468Xbr
	ZqerBVKqQAUECjmX6uDWY/f3ZvW8W/6C3pfIIWhULKsfvr5ZAcUv/twMREPFS7EXx4tRrC9q3AmUG
	qFmTBonXxFc/Cj01g+beuhCdIb+gOu+xhO+FFrMTUZWsvrIXyrsuLPHWNCcNXoDZnrBwwOCfNQK/W
	MjXg0KiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFYi5-0000000DvaP-0VWt;
	Fri, 07 Jun 2024 12:28:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFYi1-0000000DvY9-3Y9l
	for kexec@lists.infradead.org;
	Fri, 07 Jun 2024 12:28:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i/vT53TWEjy08/r3RbLeFfTwbW4PNcgFRM/VPKY6Npg=;
	b=UWBvJyDdXE22PDG4uYY8tc5R4Ix/3VFV/Kb0naYXyomDcWZi2QjpVAb658L9xqRCUWed5E
	PwdXt/TD4Z60B3hInxGyuh3J2bwa6TjYg4R5DRkuTzGTDtQrYVp3nVIoTt/HnDD+6WMbtP
	tKvWmqe3ZXNKLKviDivkFY9wShywfac=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-Yn99xZAGONGKaS4hMH_USw-1; Fri, 07 Jun 2024 08:28:39 -0400
X-MC-Unique: Yn99xZAGONGKaS4hMH_USw-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-6cebd09196bso1547845a12.2
        for <kexec@lists.infradead.org>; Fri, 07 Jun 2024 05:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717763319; x=1718368119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/vT53TWEjy08/r3RbLeFfTwbW4PNcgFRM/VPKY6Npg=;
        b=MY+bQv+qUx7P3k0mqQyr0VSsod1T5VgcJ5hCfl0HyZmB04H2V8i6y9/3llsa/ZtrHI
         ZqNhSaLTXJXd00fum3KXfNt7D3od2cKogeQ79UzoqX/xeL7MjqsblRFzo8odyx4LJxBO
         /zvqqEKciJkXaqR57w7jmRxDXKNjiTuAHC3HHvydKhnIOdsZUVJukjK3FpKbbpIRvQuv
         ws9cDqqiSqCsi77fi69PQy7R611Go+rhHe2MDgFQhbi8HAHAL4LiL7F/F39nPq2Gj2F7
         HmtDyTPBChf5BKmy3RIp1jY86rBL1azP+p8YQ12V+fJu71n1bjUueE9OOy5RxgpNQWts
         EBEg==
X-Gm-Message-State: AOJu0YzTt9mS8i4JSzr47Cjwc2m/FlTt6CLvUfVM8+omRrEBCj9e3AdS
	bu1+zuOoQIbE2VgksNufaMsyAl+0pKlde5b4TU8u2sIvO8usBViwb6cJ4Wq/+jbT34oK+DqXceV
	54Gg+y7wsuS4ChijhIG49CbOE7KvjvmgaO0dcYbGDCSCOJfH61LcGjcnuFw==
X-Received: by 2002:a05:6a20:da84:b0:1a7:3b4a:3e8 with SMTP id adf61e73a8af0-1b2f968d8afmr2340414637.7.1717763318239;
        Fri, 07 Jun 2024 05:28:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjC0KOFCSMBj595ucryYMAtLDyWr19LmKIMSzmSM9/L23RH/k6EfQW7vDi8RBhmbxD4JUwqQ==
X-Received: by 2002:a05:6a20:da84:b0:1a7:3b4a:3e8 with SMTP id adf61e73a8af0-1b2f968d8afmr2340379637.7.1717763317629;
        Fri, 07 Jun 2024 05:28:37 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7e42c0sm33015205ad.222.2024.06.07.05.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:28:37 -0700 (PDT)
Date: Fri, 7 Jun 2024 20:27:37 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v4 5/7] crash_dump: retrieve dm crypt keys in kdump kernel
Message-ID: <7fucfvhq74bzdhzowvso7re3c6c3bhtqj5trxe5gl3p7cgzgym@xz7wdxw3wojr>
References: <20240523050451.788754-1-coxu@redhat.com>
 <20240523050451.788754-6-coxu@redhat.com>
 <ZmLX15YJIhUG/XP3@MiWiFi-R3L-srv>
MIME-Version: 1.0
In-Reply-To: <ZmLX15YJIhUG/XP3@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240607_052842_019579_D86B2CDA 
X-CRM114-Status: UNSURE (   9.52  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Fri, Jun 07, 2024 at 05:50:15PM +0800, Baoquan He wrote:
>On 05/23/24 at 01:04pm, Coiby Xu wrote:
>......
>> +ssize_t __weak dm_crypt_keys_read(char *buf, size_t count, u64 *ppos)
>> +{
>> +	struct kvec kvec = { .iov_base = buf, .iov_len = count };
>> +	struct iov_iter iter;
>> +
>> +	iov_iter_kvec(&iter, READ, &kvec, 1, count);
>> +	return read_from_oldmem(&iter, count, ppos, false);
>Do we need create a x86 specific version to cope with the confidential
>computing thing, e.g sme/tdx?

Thanks for raising the concern! I'll test sme/tdx and will fix it in v6
if any issue is found.

-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
