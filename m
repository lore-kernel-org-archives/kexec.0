Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D521DC36010
	for <kexec@archiver.kernel.org>; Wed,  2 Apr 2025 01:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/k0YNeB6UyiHRw5bzlnGVGO6Th6xGTizhYj16Y2ixXU=; b=xzyHkxppISBDI75zC5KKlss/gO
	fOPNnOiFFzabFzRgaogdAj2o2e1bVWFBoEP0aqGRyvu+C6VoLzmy5qn/psonQENm+XEWtHPBq8rtx
	0mv4XfZYU7NXpQD7ZNNQ5FlX9WLtCrkm6NcwY6ulkbkdEHK3lro2Eweutw+ziQV8C5DHeVj2Bptjz
	uBJRnR2ob7CQOvkCwru3FT93fm2VFsvOX0PNt86bAu0n7P+UNW7frpjJPXceJANkXfroYLcoJbKsT
	grrjCL0I7V0HnR9zFi5xqc8b+VMRB8nLvLIF4gC2WZm/hJzveNih2cmP1yhBaTt2ZHDcTBsBwtprm
	ZMpawWTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzn6h-00000004raI-2Khb;
	Wed, 02 Apr 2025 01:41:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzn5P-00000004rTE-3llm
	for kexec@lists.infradead.org;
	Wed, 02 Apr 2025 01:40:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743558009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/k0YNeB6UyiHRw5bzlnGVGO6Th6xGTizhYj16Y2ixXU=;
	b=Vkf/541ln6pc7LE4G7bAGF1N2B2XXuz+VBa2BXxxSa/aBw1qMpLOIjhsTEL/uEg93QpPwQ
	WUDYv++HVXf7fiJrSzmPhFrA6BPNpf5zz0WLyab9Hzg/tg5JrPlsFZ/ajPsotSn1GkTTgg
	exemkKjmcNqZvEdyQxZhOvQPOpPf9aY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-PupA4utdNbmuYvVnj0WOHQ-1; Tue, 01 Apr 2025 21:40:06 -0400
X-MC-Unique: PupA4utdNbmuYvVnj0WOHQ-1
X-Mimecast-MFC-AGG-ID: PupA4utdNbmuYvVnj0WOHQ_1743558005
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-22412127fd7so85563675ad.0
        for <kexec@lists.infradead.org>; Tue, 01 Apr 2025 18:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743558005; x=1744162805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/k0YNeB6UyiHRw5bzlnGVGO6Th6xGTizhYj16Y2ixXU=;
        b=e+yxiOhWuIpA4sPh3qKnM3wR4oWT3ojqI4osh0SU0fc+6H5Z/hfI7Ae+RpxrSFKDbA
         ujGBlQcYa3FnTsvCYPcb+Eb5d/2iwuUL7KkpAGGhRMSji4STXuWchWwQ/kdxYpSP495M
         WqkSVM0SemZxUFIYXoW1vie42U+wkMZFkDQqN/kY1KGvQLs2ENQQ6bV6KTzM2I3FrorL
         5HJNYoTW2g4Hq6dW0Vx/2xsqtT69iqMVhJoKStyIQB0LPR70KK0LbNXmBhaEsLz0E1ze
         beB0fQ+OPwDBN7hy+/fSuFxNGcXtpwtvUHNOSP4xRaiJ4/inF4vAJs8a8Zc084zrpnh/
         rwvw==
X-Forwarded-Encrypted: i=1; AJvYcCUyQDJIgrBGPO51GP5HmEjSnYQ7LXcTlVqziHYB3W/kYG1o1U9Y6k/U2vBo7hNQ7Gxh5AAObg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzKok4wz/EcPHrh4HUjxAkt1itl4RUaPT9mOaTujgErCQaPUYgW
	JsCszEx6Ja9meYiXMyONxSOlAoYtIYg1M8teFzKmt+a5GvvF/1CbdMq6mCS+NRMbRurxE39rjXn
	UpNLl+XtKWSCRxO1OQ61VMkhvosXJe5bhpbFSgM2+RgrGQ/F6N2K5nj1DYA==
X-Gm-Gg: ASbGncutj+0JbMXeHvAslJG8qzRtH9X536xTs3TzQa+BBu4C8J0EqRU/QbJiU/jEbu9
	RivCzG/n05e7CD7DnjFzp2nIaWnnFqoLBmArzDe3UP2xcNW66qqBrYr1lWMI2brgO9k5tU+cnhW
	/rxzoEc0J/ynxYpgtjzij5e8IYeBYio6WXnV16/RupCmBoYVCGuuH1bHNZLRzqGWdD/mMHmNgV1
	DElRNepk5uFyUaHFgzzNOv5R1Pd6Gv0Ke3TqTq/H2CVyTf0XXcEH3qWeEN4ZHb3C4GGtd8O4Wry
	hzYaLf0=
X-Received: by 2002:a17:902:d2cd:b0:224:1eab:97b5 with SMTP id d9443c01a7336-2292f94944emr221795815ad.1.1743558005033;
        Tue, 01 Apr 2025 18:40:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZOUh4MmWk+aGZXLGBKMqkfsxmI8ex3akUdiud/F0qCd7uEBlf0i0UkeBJ4QOm7cMCaSHkBA==
X-Received: by 2002:a17:902:d2cd:b0:224:1eab:97b5 with SMTP id d9443c01a7336-2292f94944emr221795595ad.1.1743558004648;
        Tue, 01 Apr 2025 18:40:04 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7397106ad9bsm9729016b3a.117.2025.04.01.18.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 18:40:03 -0700 (PDT)
Date: Wed, 2 Apr 2025 09:38:10 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Baoquan He <bhe@redhat.com>, linux-integrity@vger.kernel.org, 
	kexec@lists.infradead.org
Subject: Re: [RFC PATCH] ima: add a knob to make IMA be able to be disabled
Message-ID: <fv7h5jfb4r6d5j6jjpgyjbv75zyzqpy6tbqn3ahzuewghnvrgd@5yclg75kr3cq>
References: <20250331061611.253919-1-bhe@redhat.com>
 <b1eba83a9f68ed9a19100f6c0dc5aca7aff437d5.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <b1eba83a9f68ed9a19100f6c0dc5aca7aff437d5.camel@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zFcP6lJW8ai0dWM9X-jVjFigf1wN6GRkotvXbnHD4xw_1743558005
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250401_184012_011498_8928C691 
X-CRM114-Status: GOOD (  21.43  )
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

On Mon, Mar 31, 2025 at 08:15:08AM -0400, Mimi Zohar wrote:
>On Mon, 2025-03-31 at 14:16 +0800, Baoquan He wrote:
>> It doesn't make sense to run IMA functionality in kdump kernel, and that
>> will cost extra memory. It would be great to allow IMA to be disabled on
>> purpose, e.g for kdump kernel.
>>
>> Hence add a knob here to allow people to disable IMA if needed.
>>
>> Signed-off-by: Baoquan He <bhe@redhat.com>
>> ---
>>  security/integrity/ima/ima_main.c | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
>> index 28b8b0db6f9b..5d677d1389fe 100644
>> --- a/security/integrity/ima/ima_main.c
>> +++ b/security/integrity/ima/ima_main.c
>> @@ -38,11 +38,27 @@ int ima_appraise;
>>
>>  int __ro_after_init ima_hash_algo = HASH_ALGO_SHA1;
>>  static int hash_setup_done;
>> +static int ima_disabled = 0;
>>
>>  static struct notifier_block ima_lsm_policy_notifier = {
>>  	.notifier_call = ima_lsm_policy_change,
>>  };
>>
>> +static int __init ima_setup(char *str)
>> +{
>> +	if (strncmp(str, "off", 3) == 0)
>> +                ima_disabled = 1;
>> +        else if (strncmp(str, "on", 2) == 0)
>> +                ima_disabled = 0;
>> +        else
>> +                pr_err("invalid ima setup option: \"%s\" ", str);
>> +
>> +	return 1;
>> +}
>> +__setup("ima=", ima_setup);
>
>I understand your wanting to disable IMA for Kdump, but this goes way beyond
>that.  Please don't make it generic like this.
>
>Please refer to ima_appraise_parse_cmdline().

Hi Mimi,

To save memory for kdump, it seems init_ima has been to be skipped thus
ima=off is necessary (ima_appraise=off won't serve the purpose). Or do
you have any specific concerns in mind?

>
>Mimi
>
>> +
>> +
>> +
>>  static int __init hash_setup(char *str)
>>  {
>>  	struct ima_template_desc *template_desc = ima_template_desc_current();
>> @@ -1176,6 +1192,11 @@ static int __init init_ima(void)
>>  {
>>  	int error;
>>
>> +	if (ima_disabled) {
>> +		pr_info("IMA functionality is disabled on purpose!");
>> +		return 0;
>> +	}
>> +
>>  	ima_appraise_parse_cmdline();
>>  	ima_init_template_list();
>>  	hash_setup(CONFIG_IMA_DEFAULT_HASH);
>
>

-- 
Best regards,
Coiby


