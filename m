Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC71C36010
	for <kexec@archiver.kernel.org>; Wed,  2 Apr 2025 01:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=esIx3FLgUyECr9heAFo1/Ans5T4q1I6Sd+VAOR0d4fY=; b=CPo5ues7FTQbMNIZVh1Nn+XH1C
	fvKHl4wZ3lLgNH1bDvjZdCYBjboHX8RMm073SY8Or1mNBFCSnxe2DKgGV/5dAoT3QC70H09iDWCAV
	q/i2gTW8ExZF6NAinDMSVeZWehmj12WxCL4y5dH12wa6dAQkf0Uum6Qr8YKGEJqV+rnz+MybcAYXn
	NVplAa8U/wZXUqz8RqmUhrOJO1qyC/zW44SXte+rQGXIZnBvvEKMJ5IkryQnb3pmtaCkJWKA+rbrH
	a8jhSCyFu3WYDdczKfBxeDnJACwZLEywzlRFHvCJ20rmYK0FLcHwdmZGWUED5f8ukeN1Skr214Rf1
	tOsOmNCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tznBm-00000004s62-41uF;
	Wed, 02 Apr 2025 01:46:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tznBk-00000004s5Q-3fuc
	for kexec@lists.infradead.org;
	Wed, 02 Apr 2025 01:46:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743558402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=esIx3FLgUyECr9heAFo1/Ans5T4q1I6Sd+VAOR0d4fY=;
	b=SKuxbzQGvVkthqjaO1b7AAGJH49noPAmJ6LebFSYtQRBALVcSzdTdQT3d6aeiuocjHUYvr
	LoDbRxfiki26pH4hPVLf2YxoinrxZ/XJEzkpNb7itAakLXIJtUO0wRgnHLu3xyLdxO6aPP
	95Z+0oppO0vX0rlMxqiv3yo2dhghVIo=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96--3-1vpY6M8GP3K9N1MgQJg-1; Tue, 01 Apr 2025 21:46:41 -0400
X-MC-Unique: -3-1vpY6M8GP3K9N1MgQJg-1
X-Mimecast-MFC-AGG-ID: -3-1vpY6M8GP3K9N1MgQJg_1743558400
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d5da4fb5e0so47865335ab.2
        for <kexec@lists.infradead.org>; Tue, 01 Apr 2025 18:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743558400; x=1744163200;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=esIx3FLgUyECr9heAFo1/Ans5T4q1I6Sd+VAOR0d4fY=;
        b=e8L7+b8Gj94vwHLcm6KAJ+4AeFgzqXSsxnpzNelLNMGB+jEhIJ8J/WRM8Uerg1CZY2
         YdlPi5QP1lctmwv7NKT9qrmwp+3BV7LL/l4JjJxghJ7pSC3X03Tuu7Kt82LzlnWDL8rM
         YWjyR5oR31Ufqvxn2+VPHh+HR/jA4qNcNzgWXjDGrzoJsVPPu7DJ5goInkHs4pJPMHJe
         DBMzJQavIq9DmA4C/SaO/zkU9zU4CEqa6Z/16UYiDmLa98LGrAMjYvMOxJmMfUPRLnBA
         UT/UveptVFyrG7ZqwT5C1gsVPeaiIKv8/v6gwU3AuHPr/b/2wgdcj5xaMk6fG+sc9Thk
         4FhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVag03xhesBJC4db5mmJYd8wJppeYkm0yUI879TubcNSb6pp+5wJFXyEyhW1vkvi+uX87lEIA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxrpR5X8vpbCWQB9pfXYGKrswklpoEYzGzaJULUt0neSTocEZKh
	OPsqo6NzLtz1yqfMmBxz7aw4CKmAKtyDGEWZzVokq8TGMSUS+lDiRBI+plHNbqbCHDqtUIH/xHF
	gZD2wvtqgJXmOtAJiYudhj+9C5TqERbi1fVtv8K7jiAA1oGW7YpDE8SK1gCe28YTgCesi3I2wKv
	kzyUpUTXgMcYeTs7YIjvr6xiSkAILH/i+5
X-Gm-Gg: ASbGncucYftJzxMaRWHpRapXCzKSh9WJQoKO9uzPpGTvzEaP50r7LAk+mCCigHcZJRO
	Bwd8Dcw7Upvvr4FitESkkr94ZUN3Ss4L2Zw3vMfWLAevbgrH/am9Ijgzb0eEq9+K+A82HE56PxQ
	==
X-Received: by 2002:a05:6e02:1a61:b0:3d2:bac3:b45f with SMTP id e9e14a558f8ab-3d5e08ea950mr170102265ab.4.1743558400467;
        Tue, 01 Apr 2025 18:46:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXXL/DGOEKBaPDll5ERFe7X9clUCsdL8rJLlHEQdb+JT8lEhX7G9wZM//WuiBK0lbpMEn92VoHj13w3iRbxh4=
X-Received: by 2002:a05:6e02:1a61:b0:3d2:bac3:b45f with SMTP id
 e9e14a558f8ab-3d5e08ea950mr170102145ab.4.1743558400061; Tue, 01 Apr 2025
 18:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250331061611.253919-1-bhe@redhat.com> <b1eba83a9f68ed9a19100f6c0dc5aca7aff437d5.camel@linux.ibm.com>
 <fv7h5jfb4r6d5j6jjpgyjbv75zyzqpy6tbqn3ahzuewghnvrgd@5yclg75kr3cq>
In-Reply-To: <fv7h5jfb4r6d5j6jjpgyjbv75zyzqpy6tbqn3ahzuewghnvrgd@5yclg75kr3cq>
From: RuiRui Yang <ruyang@redhat.com>
Date: Wed, 2 Apr 2025 09:47:04 +0800
X-Gm-Features: AQ5f1JqULEGvBbKdWyJ41Pxye25onthjjCVVmAY72XXy0WH85DAaqOpxLxCIZjc
Message-ID: <CALu+AoQrKunS5RjikkcZD7=J9vwhv1_Dw96fmO0EtyKi0MHHJg@mail.gmail.com>
Subject: Re: [RFC PATCH] ima: add a knob to make IMA be able to be disabled
To: Coiby Xu <coxu@redhat.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Baoquan He <bhe@redhat.com>, linux-integrity@vger.kernel.org, 
	kexec@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UtNdl7dVXoYEpO5mHGSTnXagSGbp47mI3Xfhsp54AkM_1743558400
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250401_184644_987092_7272E512 
X-CRM114-Status: GOOD (  28.89  )
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

On Wed, 2 Apr 2025 at 09:41, Coiby Xu <coxu@redhat.com> wrote:
>
> On Mon, Mar 31, 2025 at 08:15:08AM -0400, Mimi Zohar wrote:
> >On Mon, 2025-03-31 at 14:16 +0800, Baoquan He wrote:
> >> It doesn't make sense to run IMA functionality in kdump kernel, and that
> >> will cost extra memory. It would be great to allow IMA to be disabled on
> >> purpose, e.g for kdump kernel.
> >>
> >> Hence add a knob here to allow people to disable IMA if needed.
> >>
> >> Signed-off-by: Baoquan He <bhe@redhat.com>
> >> ---
> >>  security/integrity/ima/ima_main.c | 21 +++++++++++++++++++++
> >>  1 file changed, 21 insertions(+)
> >>
> >> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> >> index 28b8b0db6f9b..5d677d1389fe 100644
> >> --- a/security/integrity/ima/ima_main.c
> >> +++ b/security/integrity/ima/ima_main.c
> >> @@ -38,11 +38,27 @@ int ima_appraise;
> >>
> >>  int __ro_after_init ima_hash_algo = HASH_ALGO_SHA1;
> >>  static int hash_setup_done;
> >> +static int ima_disabled = 0;
> >>
> >>  static struct notifier_block ima_lsm_policy_notifier = {
> >>      .notifier_call = ima_lsm_policy_change,
> >>  };
> >>
> >> +static int __init ima_setup(char *str)
> >> +{
> >> +    if (strncmp(str, "off", 3) == 0)
> >> +                ima_disabled = 1;
> >> +        else if (strncmp(str, "on", 2) == 0)
> >> +                ima_disabled = 0;
> >> +        else
> >> +                pr_err("invalid ima setup option: \"%s\" ", str);
> >> +
> >> +    return 1;
> >> +}
> >> +__setup("ima=", ima_setup);
> >
> >I understand your wanting to disable IMA for Kdump, but this goes way beyond
> >that.  Please don't make it generic like this.
> >
> >Please refer to ima_appraise_parse_cmdline().
>
> Hi Mimi,
>
> To save memory for kdump, it seems init_ima has been to be skipped thus
> ima=off is necessary (ima_appraise=off won't serve the purpose). Or do
> you have any specific concerns in mind?

I think as Mimi said see below logic enforces the IMA even with the
cmdline disabling, see ima_appraise_parse_cmdline:
if (sb_state) {
                if (!(appraisal_state & IMA_APPRAISE_ENFORCE))
                        pr_info("Secure boot enabled: ignoring
ima_appraise=%s option",
                                str);
        } else {
                ima_appraise = appraisal_state;
        }


>
> >
> >Mimi
> >
> >> +
> >> +
> >> +
> >>  static int __init hash_setup(char *str)
> >>  {
> >>      struct ima_template_desc *template_desc = ima_template_desc_current();
> >> @@ -1176,6 +1192,11 @@ static int __init init_ima(void)
> >>  {
> >>      int error;
> >>
> >> +    if (ima_disabled) {
> >> +            pr_info("IMA functionality is disabled on purpose!");
> >> +            return 0;
> >> +    }
> >> +
> >>      ima_appraise_parse_cmdline();
> >>      ima_init_template_list();
> >>      hash_setup(CONFIG_IMA_DEFAULT_HASH);
> >
> >
>
> --
> Best regards,
> Coiby
>
>


