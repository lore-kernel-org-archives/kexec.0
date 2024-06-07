Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896CEC27C53
	for <kexec@archiver.kernel.org>; Fri,  7 Jun 2024 12:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IUl1GK5fN/1d79CLLI5wktFj3+K+rwOcvi2wUHS3KrY=; b=j7VmWHjzCIkd7evXQ9xY3KjMv2
	d7xWez+TjL4FYXygB8FL64wP+jrcYg3sOSu1ZV5jyg5Qstoatt6aDKGtWwdHHewo5pXjfv5+mY5M0
	pMRKSOJZYE9p/8x+tLJUmphrW7Zlr/LQlxPfXyYouFty6RQ/TFpJX9MhNf4O3A7QBPOIkkqThp+Gq
	6odcriAwyJ00M4RRVHQ/wuwhNJBHwwrRlhSaR9yzVMyf0EPF7dQLQN5paFQyiChasShf0ELtJs+Af
	p1Ty8qz4j+8PlyAvP807NHOBVBCOiFgnTu/vZ0nJrlvnlFdhf/1ofEMbGlGG60fDpiGu5+Ph1K372
	+HzHxvGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFYhZ-0000000DvJk-0qPR;
	Fri, 07 Jun 2024 12:28:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFYhW-0000000DvIj-48q3
	for kexec@lists.infradead.org;
	Fri, 07 Jun 2024 12:28:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717763290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ceg3v1XYelnaOfRo7wOTHj9bzW3yT+c0QEYcp/FF1E=;
	b=MKm5P7hdo+Smuld/EqGuISvYcaf62Ke7mKHRGrtAJGFZ/h6hpwdKFnER02yTD9nl3KZ0Qv
	4+lkBWqAwBcKwp4oUruSuENonqy/0MKTpH4JTCmVWta2Vf82+ajDsjehJql6Bn3+Rwy1Rh
	07eyJuIfoAxBGAJ89l7H0mbTaODF/fk=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-0ADDDEWMPEOJFkEuXJFWmg-1; Fri, 07 Jun 2024 08:28:08 -0400
X-MC-Unique: 0ADDDEWMPEOJFkEuXJFWmg-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-5b9cc90b70aso1448140eaf.0
        for <kexec@lists.infradead.org>; Fri, 07 Jun 2024 05:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717763288; x=1718368088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ceg3v1XYelnaOfRo7wOTHj9bzW3yT+c0QEYcp/FF1E=;
        b=ASO532uN2sYJg6RAIbS4gCAMamVV4rJbv6/Gt43fKTT33wD1H54uVefma1rEpW2c9N
         hAO4lbteu0JXF90w2RB/LVsJHVwZ5ykBv2iHhnnui0Z6ccht3koCC7Wk/Hr4CATaY9YV
         mROnjQkYO3jRKxrLnLdD6frb068Wp0FOT021IOplcE8MFySpXPWADUu/UTm5b8lptHSd
         9P4zQo0Td8rMCMuQxFxIq52bYNufVU/AQ9H7VX1XVXafIx7IFdmf2wGhoqnEdoVRkE2h
         Ny0gA//IxQjbjt1o7IaZzpt7qi9fzhJhruqrsmY28LkGe7OigwldVpnWSiIUfnAicgiN
         t1pg==
X-Gm-Message-State: AOJu0Yw8Rwdi+j05ydwXR0QeppGzd2UdNth4v0cYfDxhHSQIeojPQvQs
	+6JrwJZlX+jkwFF/tS50DwuRtuoCKwpW7gPHTfZpGflq36lC4mHIyABBDlfUSoX2nmuCXDFa+rP
	rCxWHMVX9/FiJMuKMDepiSgUJ4QTMOIWDKCwtXekTrM/1vTQhkgXj18V4Gw==
X-Received: by 2002:a05:6359:4c98:b0:19c:548f:8064 with SMTP id e5c5f4694b2df-19f1fd06a38mr299961255d.2.1717763287626;
        Fri, 07 Jun 2024 05:28:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCk2sIvJKjLhFdiMz1GzjMHjxQ6ETEhpu27Fo9gLowYjF+aM/kNNWu4JIRiindyHdJ+cdRyA==
X-Received: by 2002:a05:6359:4c98:b0:19c:548f:8064 with SMTP id e5c5f4694b2df-19f1fd06a38mr299957655d.2.1717763286830;
        Fri, 07 Jun 2024 05:28:06 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6e4532507casm607768a12.62.2024.06.07.05.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:28:06 -0700 (PDT)
Date: Fri, 7 Jun 2024 20:26:48 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>, 
	Milan Broz <gmazyland@gmail.com>, Thomas Staudt <tstaudt@de.ibm.com>, 
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, 
	Jan Pazdziora <jpazdziora@redhat.com>, Pingfan Liu <kernelfans@gmail.com>, 
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v4 1/7] kexec_file: allow to place kexec_buf randomly
Message-ID: <v23pityqahr6tgkhnfjoloqwhxcef23i6xjvpb23qbql5rq436@3baoli7d5vta>
References: <20240523050451.788754-1-coxu@redhat.com>
 <20240523050451.788754-2-coxu@redhat.com>
 <Zl7FLw+YrFN/blA+@MiWiFi-R3L-srv>
MIME-Version: 1.0
In-Reply-To: <Zl7FLw+YrFN/blA+@MiWiFi-R3L-srv>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240607_052811_122487_97810E35 
X-CRM114-Status: GOOD (  16.21  )
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

On Tue, Jun 04, 2024 at 03:41:35PM +0800, Baoquan He wrote:
>On 05/23/24 at 01:04pm, Coiby Xu wrote:
>> Currently, kexec_buf is placed in order which means for the same
>> machine, the info in the kexec_buf is always located at the same
>> position each time the machine is booted. This may cause a risk for
>> sensitive information like LUKS volume key. Now struct kexec_buf has a
>> new field random which indicates it's supposed to be placed in a random
>> position.
>>
>> Suggested-by: Jan Pazdziora <jpazdziora@redhat.com>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> ---
>>  include/linux/kexec.h |  2 ++
>>  kernel/kexec_file.c   | 15 +++++++++++++++
>>  2 files changed, 17 insertions(+)
>>
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index f0e9f8eda7a3..cc81b8a903ab 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
[...]
>> @@ -445,6 +456,8 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
>>
>>  	temp_end = min(end, kbuf->buf_max);
>>  	temp_start = temp_end - kbuf->memsz + 1;
>> +	if (kbuf->random)
>> +		temp_start = kexec_random_start(temp_start, temp_end);
>
>As we discussed before, this need be limited in kdump scope, seems v4
>doesn't include the change.

Yes, v4 was sent mainly for you to review the patches by applying to
latest Linus tree. v5 now include the change.

-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
