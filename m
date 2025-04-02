Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8EDC36014
	for <kexec@archiver.kernel.org>; Wed,  2 Apr 2025 08:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sJ5rqwO2zrtxM+k33EU2A19c926SMTdHUn2V9GINfc4=; b=xXqK3xPZjErvxPdzQ1RK+KcQEY
	OgYKPhAJVDdPUSoIez/BLlc1jNB7Ncq8xndk3N+EpGBIWhYLOFE7xG4T/Gh3TtTlx6RX+8xutKetU
	i3qGhs7fOhW5+iyJKF1ANjfiprMOjWUSR+6cfoAKDtHVLwAcUwRy/6kT24D/rT41oHmsxIKWX2kgu
	our3/2wGnL+ilfkFgows/snVmQqu2Ob2S+Ssc2Gh315qSv7hBrVxC0pt1nGqIyHrBSMJQgNuMgfQ7
	YJneRy/3/UHgVgyCTtjkUDuK/jhSjXdInn5b5jbUV84bTB1AS6ClSN6CLIpBKYm65nwFYHP6st4JN
	Wsi4l3WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tztq0-00000005adM-2PVd;
	Wed, 02 Apr 2025 08:52:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tztif-00000005Zlg-0XbT
	for kexec@lists.infradead.org;
	Wed, 02 Apr 2025 08:45:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743583508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sJ5rqwO2zrtxM+k33EU2A19c926SMTdHUn2V9GINfc4=;
	b=iIAfn5491fgBssJUYasOGDTt3wYMV48xXbvM1v2bsHdQTCpfE5RZ4j1ng5IdIFrWF3YB36
	kN2RrKSAtqBIPXngLFgN0j90K+b9p4nU6W4iT+mTgu2Vm9xUAQ2xUbN0485jkX1ZiPsnTU
	KPtSLcI5oIuqleA6RAbSD8zcfoyVjO4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-thHIS2AWNF-pyXNXEJZKcg-1; Wed, 02 Apr 2025 04:45:05 -0400
X-MC-Unique: thHIS2AWNF-pyXNXEJZKcg-1
X-Mimecast-MFC-AGG-ID: thHIS2AWNF-pyXNXEJZKcg_1743583505
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3054210ce06so11056355a91.2
        for <kexec@lists.infradead.org>; Wed, 02 Apr 2025 01:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743583505; x=1744188305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJ5rqwO2zrtxM+k33EU2A19c926SMTdHUn2V9GINfc4=;
        b=kLwRRyKVhFXOnSfSvoUeTUXz5VWXX6XxmJ2tUryClaqeFrsLPAxEWqjBBl7Z7hemUR
         8Dd4oBLysqm6tGA64yq80sTaWIsb+jFjZfUBkj9MkBVuvP6V/x3NbN9VTb3nCrvjAY2b
         v4s5x0UslMXUu9wgcL4lizrX6sv7cBimgmsGGJVVWLsib+cBoamXbd732B09VVUXBp//
         iGwI0SKqY2pGXzWIsu/ZFaGRGgKkQAhX6O0moRvRSvdsVGZK2niki8f+BJ6REpyec7WV
         pGahIApOMED11WgiVWDmL4fp5kF1ndPb86r8Ng3HE+hPJACWUoX5c31nxGB2S+MLvW7Q
         Ne4w==
X-Forwarded-Encrypted: i=1; AJvYcCVMGrEpsXlwSumBVdEy6Jx6wYHNzBiCv6Uy/4zxbdr6jLqxWBOjPVYMEh7cTlLY3TCd2VNoqw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxgV3mP+V7aw7fcK4smgrYtvV0gw33dsYb2XcorcAOCtdKzByc6
	fbCDXQAkYGeTBLFieGfEx2z2rD54yijLU6scw0qDBvCvfZPBycjLm0JqeDdLrhzxF8oIJrBwHUT
	bSbZLOFqaS2r5Zcb7n9MR/WOc/z92rg5Ej3EL0aISS7LVtF4VcnYFTuHLDA==
X-Gm-Gg: ASbGnct4lKETPMQxATRB10KwlwyTnfmVAOM56y3zO2P7mHHAPwIQfYAgdJ+640KPp4M
	I1DdlMX7Rs1pkjShVJKm2lY+cbZNUY07bZi1EAk3qRGLxLT2emE632O6jGxgaYHbp1Rxy0eTRzw
	ICurhPyrynWWXnHL7CiSpcifhTZlNNuOLBRbn1v065YlDgHlxNcmvi23mEx3J5bDVKeJB//Cs94
	08UkwkWifHuF9csVDT32PnbgOYyq0iSk7jaZFkJYgqUbESWHLqr9Wo7JUS83T/VoRobcJT72L+C
	SOkEYlg=
X-Received: by 2002:a05:6a20:c701:b0:1f5:8e54:9f10 with SMTP id adf61e73a8af0-2009f75b1b3mr27633106637.34.1743583504726;
        Wed, 02 Apr 2025 01:45:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNqPrnFWcI0KzZugfSso7yYOl9ecVA4ev8O29z9DMGZUP9V1eMmmdV9OaMRWROghUGsvpHHA==
X-Received: by 2002:a05:6a20:c701:b0:1f5:8e54:9f10 with SMTP id adf61e73a8af0-2009f75b1b3mr27633077637.34.1743583504369;
        Wed, 02 Apr 2025 01:45:04 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739710636aesm10725535b3a.91.2025.04.02.01.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 01:45:03 -0700 (PDT)
Date: Wed, 2 Apr 2025 16:43:57 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>, RuiRui Yang <ruyang@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, linux-integrity@vger.kernel.org, 
	kexec@lists.infradead.org
Subject: Re: [RFC PATCH] ima: add a knob to make IMA be able to be disabled
Message-ID: <h3bjnvtded2hgbhya6ugb62mnlmkjpmifa6w6wwutfd3jq326r@lzpoun5pksev>
References: <20250331061611.253919-1-bhe@redhat.com>
 <b1eba83a9f68ed9a19100f6c0dc5aca7aff437d5.camel@linux.ibm.com>
 <fv7h5jfb4r6d5j6jjpgyjbv75zyzqpy6tbqn3ahzuewghnvrgd@5yclg75kr3cq>
 <CALu+AoQrKunS5RjikkcZD7=J9vwhv1_Dw96fmO0EtyKi0MHHJg@mail.gmail.com>
 <d14c72bbb377c6f8f0efdbf6d725c553b3ad741c.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <d14c72bbb377c6f8f0efdbf6d725c553b3ad741c.camel@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TrYNIbtpwUkzC1_wV6ynvGm8OYNR_lN3W9FJQT4zHLM_1743583505
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_014509_243609_3E183353 
X-CRM114-Status: GOOD (  20.88  )
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

On Tue, Apr 01, 2025 at 11:30:09PM -0400, Mimi Zohar wrote:
>On Wed, 2025-04-02 at 09:47 +0800, RuiRui Yang wrote:
[...]
>> > > that.  Please don't make it generic like this.
>> > >
>> > > Please refer to ima_appraise_parse_cmdline().
>> >
>> > Hi Mimi,
>> >
>> > To save memory for kdump, it seems init_ima has been to be skipped thus
>> > ima=off is necessary (ima_appraise=off won't serve the purpose). Or do
>> > you have any specific concerns in mind?
>>
>> I think as Mimi said see below logic enforces the IMA even with the
>> cmdline disabling, see ima_appraise_parse_cmdline:
>> if (sb_state) {
>>                 if (!(appraisal_state & IMA_APPRAISE_ENFORCE))
>>                         pr_info("Secure boot enabled: ignoring
>> ima_appraise=%s option",
>>                                 str);
>>         } else {
>>                 ima_appraise = appraisal_state;
>>         }

Thanks for pointing me to the above code! Note with the whole IMA
disabled as done by this patch, the above code will not run so IMA
(appraisal) won't be enforced.

>
>Thanks, RuiRui.
>

Mimi, so do I understand it correctly that your want IMA-appraisal to be
always enabled as long as secure boot is enabled even if users choose to
disable IMA? I wonder what security issue will it bring if this promise
gets broken considering other LSMs can SELinux can be disabled when
secure boot is enabled?

>Coiby, would disabling just IMA-measurement, as opposed to IMA-appraisal, save
>sufficient memory for kdump?

For disabling just IMA-measurement, do you mean not enabling any measure
rules?  The more memory reserved for the kdump kernel, the less memory
can be used by the 1st kernel. So from the perfective of kdump, we try
to make the memory footprint as smaller as possible. 

Baoquan, do you have any statistics about the memory overhead of IMA?


-- 
Best regards,
Coiby


