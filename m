Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4627C3600C
	for <kexec@archiver.kernel.org>; Mon, 31 Mar 2025 08:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bVRkWbCJy3ewoWGb1n5T3gIChWyY6D9l014rj6UHHF4=; b=OrFKr7aKwuaCTmS9NthDrbcxJ1
	+2pwGVInWo+PnujFbmb41+pAKkM6/F1WeHsbAJfVDri75pMMqr2CiYTJHASPZKEWAUDLnWgB1GC7o
	aFX99WwGKu01ppwvwN0T12gE9i9LUNybFUapr4mKrm+xxBLzhz+LJhPwpzN/1AgcYokf0x1JepI9Y
	M9TM6X5u9ZHGC3JsS8UG35QSfNbvWCd0194n+jIkZ4SFTyN6osAy6SifRqPhXQXKBHIJ2wmXX282a
	491wWYtgm5dFKGcX/PFONDzN5pHLVgrV2NdO+oD9kg/stpFa2yqjK8PLAwpbf8dih1P9TExNGsqvR
	tIdgs73A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzASF-0000000HM17-3Czd;
	Mon, 31 Mar 2025 08:25:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzAOq-0000000HL7D-2Vs2
	for kexec@lists.infradead.org;
	Mon, 31 Mar 2025 08:21:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743409299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bVRkWbCJy3ewoWGb1n5T3gIChWyY6D9l014rj6UHHF4=;
	b=FpzG5O4fMJqLE35gzpcFbRa10xgYShgD4ArptMGAQ+VNG3HsrwgKi7JmlRSNlkejr83dNJ
	LPsZSEE+iIFt84ZDjNo0yinVbohYC4FYeWcmxeOJHgOl53QABon79Ttmr9glWQlYNHrjkp
	ZJWGrM3zZ2UQqN/76ka/2IpjMQZcqHU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-X_OYxhqHP7ug7jFmYg-lSw-1; Mon,
 31 Mar 2025 04:21:35 -0400
X-MC-Unique: X_OYxhqHP7ug7jFmYg-lSw-1
X-Mimecast-MFC-AGG-ID: X_OYxhqHP7ug7jFmYg-lSw_1743409294
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5275F195606B;
	Mon, 31 Mar 2025 08:21:33 +0000 (UTC)
Received: from localhost (unknown [10.72.112.9])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 89FEC1801752;
	Mon, 31 Mar 2025 08:21:30 +0000 (UTC)
Date: Mon, 31 Mar 2025 16:21:26 +0800
From: Baoquan He <bhe@redhat.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
	kexec@lists.infradead.org
Subject: Re: [RFC PATCH] ima: add a knob to make IMA be able to be disabled
Message-ID: <Z+pQTb+e0SuMvwkS@MiWiFi-R3L-srv>
References: <20250331061611.253919-1-bhe@redhat.com>
 <42ae3379-992e-45fc-acfc-0f808ff0d406@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42ae3379-992e-45fc-acfc-0f808ff0d406@molgen.mpg.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250331_012140_703715_8D7E1FC6 
X-CRM114-Status: GOOD (  29.79  )
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

Hi Paul,

On 03/31/25 at 08:22am, Paul Menzel wrote:
> 
Thanks for your careful reviewing.
> 
> Thank you for your patch. I’d add the knob name to the commit message
> summary/title, so it shows up in `git log --oneline`.

Sounds great, will change.

> 
> Am 31.03.25 um 08:16 schrieb Baoquan He:
> > It doesn't make sense to run IMA functionality in kdump kernel, and that
> > will cost extra memory. It would be great to allow IMA to be disabled on
> > purpose, e.g for kdump kernel.
> > 
> > Hence add a knob here to allow people to disable IMA if needed.
> 
> `initcall_blacklist=…` could be used already. I prefer a dedicated parameter
> too though.

Yes, adding parameter can provide an explicit functionality to the
feature. While 'initcall_blacklist=' can't guarantee there won't be
dependency or connection between ima and other feature, and people could
add or change the connection anytime when userspace is using it but not
knowing the change.

> 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >   security/integrity/ima/ima_main.c | 21 +++++++++++++++++++++
> >   1 file changed, 21 insertions(+)
> > 
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > index 28b8b0db6f9b..5d677d1389fe 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -38,11 +38,27 @@ int ima_appraise;
> >   int __ro_after_init ima_hash_algo = HASH_ALGO_SHA1;
> >   static int hash_setup_done;
> > +static int ima_disabled = 0;
> >   static struct notifier_block ima_lsm_policy_notifier = {
> >   	.notifier_call = ima_lsm_policy_change,
> >   };
> > +static int __init ima_setup(char *str)
> > +{
> > +	if (strncmp(str, "off", 3) == 0)
> > +                ima_disabled = 1;
> > +        else if (strncmp(str, "on", 2) == 0)
> > +                ima_disabled = 0;
> > +        else
> > +                pr_err("invalid ima setup option: \"%s\" ", str);
> 
> I’d add the allowed strings.

Sounds better, will change.

> 
> > +
> > +	return 1;
> > +}
> > +__setup("ima=", ima_setup);
> > +
> > +
> > +
> >   static int __init hash_setup(char *str)
> >   {
> >   	struct ima_template_desc *template_desc = ima_template_desc_current();
> > @@ -1176,6 +1192,11 @@ static int __init init_ima(void)
> >   {
> >   	int error;
> > +	if (ima_disabled) {
> > +		pr_info("IMA functionality is disabled on purpose!");
> 
> … on Linux CLI.

I may not get the suggestion in this place, could you be more specific?

> 
> > +		return 0;
> > +	}
> > +
> >   	ima_appraise_parse_cmdline();
> >   	ima_init_template_list();
> >   	hash_setup(CONFIG_IMA_DEFAULT_HASH);
> 
> 
> Kind regards,
> 
> Paul
> 


