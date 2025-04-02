Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA3AC28B20
	for <kexec@archiver.kernel.org>; Wed,  2 Apr 2025 11:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QY16FlaFz/8AAtmk+eEXNvgP9tXOB0A0u1SLLOqmEPg=; b=lENDUX6M394L05ArVxTFVlQ3G+
	nhEU7JgybrXpSlI1400s6AdAesUIFmhjLgwT3ICERNA07GSI2UYqujtlqhZzVgTWQmP1a2RytdJpY
	2Og5fisfC3HmJrMznXaVPomFrUNgmaAIxJ2yhsRkcg8tXQG3iy1pxn5/GxLPsH+LgRJNEF+j+x36R
	FVLxdjGEzaTIg5x5PuWhgQxqzmg0g1pps5YLJy6XXDrIKZO1PMZRmNJl183me+jSUTDgbJHrrx6rR
	udbUdfC9TdFKBPMNuoPl/23ZQwjPxUHKfL6AhnQtALqfldnQxwUJyblFw5Nm2c8ShYJIS/72PaSjn
	6/5x0jKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzwh1-00000005z9Y-2uZw;
	Wed, 02 Apr 2025 11:55:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzwbD-00000005y9R-3RgQ
	for kexec@lists.infradead.org;
	Wed, 02 Apr 2025 11:49:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743594577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QY16FlaFz/8AAtmk+eEXNvgP9tXOB0A0u1SLLOqmEPg=;
	b=QaQL1Maaq+9cAlJOzNF8/JXRN8RCfgFdz1o9d1sTwtsUnUxZ6GVwjCDvSFWX2Bx4cmi7mg
	PoyhWpRpMD3IHngJSt51NGH92hFnGWKR1qHK4wmQubFY+E/FGZKntJ418QegK2P+dFUVLu
	IwHXyJQTRUILJhXfmQKrvr06ZtFz5ws=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-4Vn8jndVOgCQk1a3RQWe8A-1; Wed,
 02 Apr 2025 07:49:34 -0400
X-MC-Unique: 4Vn8jndVOgCQk1a3RQWe8A-1
X-Mimecast-MFC-AGG-ID: 4Vn8jndVOgCQk1a3RQWe8A_1743594573
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 932A1180035E;
	Wed,  2 Apr 2025 11:49:33 +0000 (UTC)
Received: from localhost (unknown [10.72.112.12])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 21B0A1801747;
	Wed,  2 Apr 2025 11:49:31 +0000 (UTC)
Date: Wed, 2 Apr 2025 19:49:26 +0800
From: Baoquan He <bhe@redhat.com>
To: Coiby Xu <coxu@redhat.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, RuiRui Yang <ruyang@redhat.com>,
	linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [RFC PATCH] ima: add a knob to make IMA be able to be disabled
Message-ID: <Z+0kRhCfsjdZ53rZ@MiWiFi-R3L-srv>
References: <20250331061611.253919-1-bhe@redhat.com>
 <b1eba83a9f68ed9a19100f6c0dc5aca7aff437d5.camel@linux.ibm.com>
 <fv7h5jfb4r6d5j6jjpgyjbv75zyzqpy6tbqn3ahzuewghnvrgd@5yclg75kr3cq>
 <CALu+AoQrKunS5RjikkcZD7=J9vwhv1_Dw96fmO0EtyKi0MHHJg@mail.gmail.com>
 <d14c72bbb377c6f8f0efdbf6d725c553b3ad741c.camel@linux.ibm.com>
 <h3bjnvtded2hgbhya6ugb62mnlmkjpmifa6w6wwutfd3jq326r@lzpoun5pksev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <h3bjnvtded2hgbhya6ugb62mnlmkjpmifa6w6wwutfd3jq326r@lzpoun5pksev>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_044939_926715_3431C5D4 
X-CRM114-Status: GOOD (  33.12  )
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

On 04/02/25 at 04:43pm, Coiby Xu wrote:
> On Tue, Apr 01, 2025 at 11:30:09PM -0400, Mimi Zohar wrote:
> > On Wed, 2025-04-02 at 09:47 +0800, RuiRui Yang wrote:
> [...]
> > > > > that.  Please don't make it generic like this.
> > > > >
> > > > > Please refer to ima_appraise_parse_cmdline().
> > > >
> > > > Hi Mimi,
> > > >
> > > > To save memory for kdump, it seems init_ima has been to be skipped thus
> > > > ima=off is necessary (ima_appraise=off won't serve the purpose). Or do
> > > > you have any specific concerns in mind?
> > > 
> > > I think as Mimi said see below logic enforces the IMA even with the
> > > cmdline disabling, see ima_appraise_parse_cmdline:
> > > if (sb_state) {
> > >                 if (!(appraisal_state & IMA_APPRAISE_ENFORCE))
> > >                         pr_info("Secure boot enabled: ignoring
> > > ima_appraise=%s option",
> > >                                 str);
> > >         } else {
> > >                 ima_appraise = appraisal_state;
> > >         }
> 
> Thanks for pointing me to the above code! Note with the whole IMA
> disabled as done by this patch, the above code will not run so IMA
> (appraisal) won't be enforced.
> 
> > 
> > Thanks, RuiRui.
> > 
> 
> Mimi, so do I understand it correctly that your want IMA-appraisal to be
> always enabled as long as secure boot is enabled even if users choose to
> disable IMA? I wonder what security issue will it bring if this promise
> gets broken considering other LSMs can SELinux can be disabled when
> secure boot is enabled?
> 
> > Coiby, would disabling just IMA-measurement, as opposed to IMA-appraisal, save
> > sufficient memory for kdump?
> 
> For disabling just IMA-measurement, do you mean not enabling any measure
> rules?  The more memory reserved for the kdump kernel, the less memory
> can be used by the 1st kernel. So from the perfective of kdump, we try
> to make the memory footprint as smaller as possible.
> 
> Baoquan, do you have any statistics about the memory overhead of IMA?

I am getting a system to check that. I think there are two aspects of
IMA functionality we want to disable. One is disable the IMA-measurement
copying from 1st kernel to 2nd kernel, this is only needed by kexec
reboot; the other is IMA is not needed at all in kdump kernel, means we
don't want to call ima_init() to initialize
ima_keyring/crypto/template/digests/fs etc. 

With my shallow knowledge about IMA, I don't know how to imitate
appraisal cmdline to disable IMA partially in kdump kernel case.

One exmaple is 'cgroup_disable=memory' we have been doing to add into
kdump cmdline because mem_cgroup is not needed at all for kdump kernel.
We want to achieve that effect.


