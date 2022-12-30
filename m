Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99992C4332F
	for <kexec@archiver.kernel.org>; Fri, 30 Dec 2022 07:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=31xNkDIRBvXFIo74I/NBL21KdQuuXLyqRqMTD46dcXU=; b=22WQf5T+oH2jKJWclRYRKSaUAl
	UcUXsVKqqF7cKnyP6g1HFCNyjj+/h4R9xE5S2sYKFTAbBfemDRQDOxhyiOpItn0bWM+11eL59XAd5
	yPDj2OiRxuBb5SODYVdz7BvrFkhwO/R9oS21tEPA+451kuRfjOY+Vf4PLzcIPJHfIH2g3oFG6iuOX
	MTNCv2faQKXnVSSELNM6HjMUzK0CXRyMuCPNn93aXqrF0VRAvxDpRCHrmEZipuqga+ltP+PfpgulT
	jHb5SpyxfeLOi4wTm0O6YqCInf92Z6A4oCKROqMRXIQADfslUWA9qYiwYvqAX8KL9chrM4ZOe28LO
	8oiVqc+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pB9Nq-006fwP-Dn; Fri, 30 Dec 2022 07:00:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pB9Nm-006fuF-R5
	for kexec@lists.infradead.org; Fri, 30 Dec 2022 07:00:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1672383645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ImmGCQvbrQbubKMSG6ameYopLxKvK1Dq+0f6WyefBN0=;
	b=PLsrvzqtuBnIHo4dbMjzVBqyS9yiSm6oYVJ2/u+NVZIzKqcsajnI1PM0AFESvI+SBiUdx0
	C2dNuDQz33gl475etGYByzMij8y1rbwR3u3eKmAT5mecN6DeQQLwkaxz+MZUc/fF5rr3wg
	5dyF09kiHrugjUereTQ4SFFi5LhCoKk=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-607-q7OmBS7HNwCsyomu5iY9YA-1; Fri, 30 Dec 2022 02:00:44 -0500
X-MC-Unique: q7OmBS7HNwCsyomu5iY9YA-1
Received: by mail-pf1-f199.google.com with SMTP id k21-20020aa78215000000b00575ab46ca2cso10425479pfi.20
        for <kexec@lists.infradead.org>; Thu, 29 Dec 2022 23:00:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImmGCQvbrQbubKMSG6ameYopLxKvK1Dq+0f6WyefBN0=;
        b=6/mlgaU99E23/dErEpSgZud+6Z3R945As+NfyHQXIZI7SzXkKpS39FAhwPgmTaM9jM
         ZaluJMiLpB/fwRpjIuK4CLEbQsyKQXHgIuNQoALDV/GRpmHBNValnMVF8eY3KeDZoMUr
         F7k9zrDNLan5aoL0KLWfPiOZwmRcCnt49Fp670ToSw3d7SM9wQ5G1l/YolDO6l5thEV4
         xP9wh1hxMvdti11Se+OPm5XD3ZSQ0x+m9huzfuFYJ1t0C3tSSvDtkSO78AJfznjUTmAi
         JUu+aqdQQg0IHScozwB1VZbgQrHeu8LBVi4OyjmF+CpXFQ+YyqvJb32g7HpALSajZM1l
         1CSw==
X-Gm-Message-State: AFqh2kpjMyBaN0hv48VRTtV8H3S7rUU6j+/B27NzvJQSxMgnsuvcwlQm
	diMyZq89hGf6nELZzlh+p9GBJEAhaX9DpEsCP7Qe0mUwIZWV/pMEEs2aejvF4aMbx1Zj1ioGsPH
	T7aHwauZ96vwydbnMzh4p
X-Received: by 2002:a17:902:f30a:b0:192:5d9b:5881 with SMTP id c10-20020a170902f30a00b001925d9b5881mr21193548ple.31.1672383643007;
        Thu, 29 Dec 2022 23:00:43 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuFyJMAfM2ex+xnuBDCSnUVb8vWNZEix+IQzpCxtuyT8dY7U9e4J7L3ewHS7tRYBThynAwxpw==
X-Received: by 2002:a17:902:f30a:b0:192:5d9b:5881 with SMTP id c10-20020a170902f30a00b001925d9b5881mr21193531ple.31.1672383642759;
        Thu, 29 Dec 2022 23:00:42 -0800 (PST)
Received: from localhost ([240e:478:10:2273:12cf:a540:d79b:db49])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902650700b00189c536c72asm14085355plk.148.2022.12.29.23.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 23:00:42 -0800 (PST)
Date: Fri, 30 Dec 2022 15:00:28 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: kexec@lists.infradead.org, Matthew Garrett <mjg59@srcf.ucam.org>,
	Jiri Bohac <jbohac@suse.cz>, David Howells <dhowells@redhat.com>,
	linux-integrity@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	James Morris <jmorris@namei.org>,
	Matthew Garrett <mjg59@google.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lockdown: kexec_file: prevent unsigned kernel image when
 KEXEC_SIG not enabled
Message-ID: <20221230070028.7i4w57xmhwa44c4z@Rk>
References: <20221121072947.836672-1-coxu@redhat.com>
 <5d98172d77a8a0f1e3daab44ad51bf38978cc053.camel@linux.ibm.com>
 <20221122023606.nrifkrng5nbfmkka@Rk>
 <2204915d319ff9acf80f68ccba8600aaeb5578d7.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <2204915d319ff9acf80f68ccba8600aaeb5578d7.camel@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221229_230046_999665_3D1FBF03 
X-CRM114-Status: GOOD (  17.49  )
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

On Mon, Nov 28, 2022 at 12:16:08PM -0500, Mimi Zohar wrote:
>On Tue, 2022-11-22 at 10:36 +0800, Coiby Xu wrote:
>> Hi Mimi,
>>
>> On Mon, Nov 21, 2022 at 01:23:57PM -0500, Mimi Zohar wrote:
>> >Hi Coiby,
>> >
>> >On Mon, 2022-11-21 at 15:29 +0800, Coiby Xu wrote:
>> >> A kernel builder may not enable KEXEC_SIG and some architectures like
>> >> ppc64 simply don't have KEXEC_SIG. In these cases, unless both
>> >> IMA_ARCH_POLICY and secure boot also enabled, lockdown doesn't prevent
>> >> unsigned kernel image from being kexec'ed via the kexec_file_load
>> >> syscall whereas it could prevent one via the kexec_load syscall. Mandate
>> >> signature verification for those cases.
>> >>
>> >> Fixes: 155bdd30af17 ("kexec_file: Restrict at runtime if the kernel is locked down")
>> >> Cc: Matthew Garrett <mjg59@srcf.ucam.org>
>> >> Cc: Jiri Bohac <jbohac@suse.cz>
>> >> Cc: David Howells <dhowells@redhat.com>
>> >> Cc: kexec@lists.infradead.org
>> >> Cc: linux-integrity@vger.kernel.org
>> >> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> >
>> >Other than correcting the function name to mandate_signature_verificati
>> >on(),
>>
>> Applied to v2, thanks for correcting me! Btw, I realize I overwrote the
>> return code of kexec_image_verify_sig with
>> mandate_signature_verification's. v2 has fixed this issue as well.
>>
>> >
>> >Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>>
>> And thanks for the review!
>
>You're welcome.
>
>Without either IMA_ARCH or KEXEC_SIG enabled, the kexec selftest
>test_kexec_file_load.sh properly failed with "kexec_file_load failed
>[PASS]", but from the informational messages output, it isn't clear why
>it failed.  This should be corrected.

Thanks for the suggestion! I've added some tests in v3 and now the
message is "# kexec_file_load failed (missing IMA sig) [PASS]".

>
>-- 
>thanks,
>
>Mimi
>

-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
