Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E22C36010
	for <kexec@archiver.kernel.org>; Wed,  9 Apr 2025 02:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8oczL3HYI3fV8uNpqQCBGvL6Ew7ctt5Mkmc92a4dxCQ=; b=bP7gZz6m0e5J8qN7L7bYvkiwgT
	9ajV3VsIqT1BwDsI1ZrobaEV9Jl1uO+Ntl0xSnOPbRhXPrgSjhun+90n82wDcyDVDtSMguLRWXDtV
	6BveSlCAqOGaOJimzCkywq7caC1mFjdgsqx9aj11nKCh+QciEwh5RITcYajGCYs1Du/lWcxdEk6zd
	O5xHfDKTwmEPtcy2ofXd6ipKftsS7r6KDtxaIwzYAcYlJVM/qrwdaaTmkI4rbDJx8yuEi6o28xkG2
	RqmNWNV0iqT9KQpRMBl0gL5Ob+b2bfglNVFQVcbYpSa4kOnrpQKeN77btxVd0N7QTD0/C/V1jociV
	fudIaTDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2LQq-00000005xev-0bZY;
	Wed, 09 Apr 2025 02:44:52 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2LP9-00000005xW2-0iog
	for kexec@lists.infradead.org;
	Wed, 09 Apr 2025 02:43:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744166585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8oczL3HYI3fV8uNpqQCBGvL6Ew7ctt5Mkmc92a4dxCQ=;
	b=O/Z/tCpBbWBRM8KgN33f6y2QkmewWFNUnXT86oAErsZgYj8B3qXsHaad3f05lgH3mh40JZ
	kpzQCHpoADz15tHJGeZyWxddoAhXloBdoFjHq9ICYUaMLVv/QJrwfqYomwipfvq6B/bnhL
	iIBba7LlXl8OHqXjHKG2rvK7YpRrwXY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-zWV1UIe8MoG8-LOQMG9ABA-1; Tue,
 08 Apr 2025 22:43:01 -0400
X-MC-Unique: zWV1UIe8MoG8-LOQMG9ABA-1
X-Mimecast-MFC-AGG-ID: zWV1UIe8MoG8-LOQMG9ABA_1744166580
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 519851955DC5;
	Wed,  9 Apr 2025 02:43:00 +0000 (UTC)
Received: from localhost (unknown [10.72.112.61])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F1FC5180B48C;
	Wed,  9 Apr 2025 02:42:58 +0000 (UTC)
Date: Wed, 9 Apr 2025 10:42:54 +0800
From: Baoquan He <bhe@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>, chenste@linux.microsoft.com
Cc: Coiby Xu <coxu@redhat.com>, RuiRui Yang <ruyang@redhat.com>,
	linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [RFC PATCH] ima: add a knob to make IMA be able to be disabled
Message-ID: <Z/Xero1B0OazLcHL@MiWiFi-R3L-srv>
References: <20250331061611.253919-1-bhe@redhat.com>
 <b1eba83a9f68ed9a19100f6c0dc5aca7aff437d5.camel@linux.ibm.com>
 <fv7h5jfb4r6d5j6jjpgyjbv75zyzqpy6tbqn3ahzuewghnvrgd@5yclg75kr3cq>
 <CALu+AoQrKunS5RjikkcZD7=J9vwhv1_Dw96fmO0EtyKi0MHHJg@mail.gmail.com>
 <d14c72bbb377c6f8f0efdbf6d725c553b3ad741c.camel@linux.ibm.com>
 <h3bjnvtded2hgbhya6ugb62mnlmkjpmifa6w6wwutfd3jq326r@lzpoun5pksev>
 <Z+0kRhCfsjdZ53rZ@MiWiFi-R3L-srv>
 <65057b5256a28c3416e6b90a143d741801e68b03.camel@linux.ibm.com>
 <Z/MrpIv9EWftPhbD@MiWiFi-R3L-srv>
 <02563b1e8b0000bedf94ded447a8372f21d4304a.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02563b1e8b0000bedf94ded447a8372f21d4304a.camel@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250408_194307_281799_26CCDEE2 
X-CRM114-Status: GOOD (  53.46  )
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

On 04/07/25 at 07:46am, Mimi Zohar wrote:
> On Mon, 2025-04-07 at 09:34 +0800, Baoquan He wrote:
> > On 04/03/25 at 04:03pm, Mimi Zohar wrote:
> > > On Wed, 2025-04-02 at 19:49 +0800, Baoquan He wrote:
> > > > On 04/02/25 at 04:43pm, Coiby Xu wrote:
> > > > > On Tue, Apr 01, 2025 at 11:30:09PM -0400, Mimi Zohar wrote:
> > > > > > On Wed, 2025-04-02 at 09:47 +0800, RuiRui Yang wrote:
> > > > > [...]
> > > > > > > > > that.  Please don't make it generic like this.
> > > > > > > > > 
> > > > > > > > > Please refer to ima_appraise_parse_cmdline().
> > > > > > > > 
> > > > > > > > Hi Mimi,
> > > > > > > > 
> > > > > > > > To save memory for kdump, it seems init_ima has been to be skipped thus
> > > > > > > > ima=off is necessary (ima_appraise=off won't serve the purpose). Or do
> > > > > > > > you have any specific concerns in mind?
> > > > > > > 
> > > > > > > I think as Mimi said see below logic enforces the IMA even with the
> > > > > > > cmdline disabling, see ima_appraise_parse_cmdline:
> > > > > > > if (sb_state) {
> > > > > > >                 if (!(appraisal_state & IMA_APPRAISE_ENFORCE))
> > > > > > >                         pr_info("Secure boot enabled: ignoring
> > > > > > > ima_appraise=%s option",
> > > > > > >                                 str);
> > > > > > >         } else {
> > > > > > >                 ima_appraise = appraisal_state;
> > > > > > >         }
> > > > > 
> > > > > Thanks for pointing me to the above code! Note with the whole IMA
> > > > > disabled as done by this patch, the above code will not run so IMA
> > > > > (appraisal) won't be enforced.
> > > > > 
> > > > > > 
> > > > > > Thanks, RuiRui.
> > > > > > 
> > > > > 
> > > > > Mimi, so do I understand it correctly that your want IMA-appraisal to be
> > > > > always enabled as long as secure boot is enabled even if users choose to
> > > > > disable IMA? 
> > > 
> > > Secure boot is not the only reason.  Based on policy IMA-appraisal and EVM
> > > calculate and store file hashes and HMAC's in their respective security xattrs.
> > > Normally the usage of file hashes and HMAC's is limited to mutable files. 
> > > Disabling IMA-appraisal could result in not properly updating the security
> > > xattrs, which would result in not being able to verify the file's integrity on
> > > reboot.
> > > 
> > > On systems where the RPM includes file signatures, file signatures of immutable
> > > files can be safely restored.  Although it is possible to walk the filesystem(s)
> > > "fixing" the xattrs of mutable files, it defeats the purpose.  "fix" mode should
> > > only be enabled in a trusted environment.
> > > 
> > > > > I wonder what security issue will it bring if this promise
> > > > > gets broken considering other LSMs can SELinux can be disabled when
> > > > > secure boot is enabled?
> > > 
> > > The builtin IMA policy rules are not defined in terms of SELinux labels.  If the
> > > initial IMA custom policy defines rules based on SELinux labels and SELinux is
> > > not enabled, the policy will fail to be loaded.
> > > 
> > > > > > Coiby, would disabling just IMA-measurement, as opposed to IMA-appraisal, save
> > > > > > sufficient memory for kdump?
> > > > > 
> > > > > For disabling just IMA-measurement, do you mean not enabling any measure
> > > > > rules?  The more memory reserved for the kdump kernel, the less memory
> > > > > can be used by the 1st kernel. So from the perfective of kdump, we try
> > > > > to make the memory footprint as smaller as possible.
> > > 
> > > Got it.
> > > 
> > > > > Baoquan, do you have any statistics about the memory overhead of IMA?
> > > > 
> > > > I am getting a system to check that. I think there are two aspects of
> > > > IMA functionality we want to disable. One is disable the IMA-measurement
> > > > copying from 1st kernel to 2nd kernel, this is only needed by kexec
> > > > reboot; the other is IMA is not needed at all in kdump kernel, means we
> > > > don't want to call ima_init() to initialize
> > > > ima_keyring/crypto/template/digests/fs etc. 
> > > > 
> > > > With my shallow knowledge about IMA, I don't know how to imitate
> > > > appraisal cmdline to disable IMA partially in kdump kernel case.
> > 
> > Thanks for detailed explanations. Just back from holiday, sorry for late
> > reply.
> > 
> > > 
> > > The IMA policy controls how much or how little IMA measures and appraises.  Most
> > > of the memory usage is the IMA measurement list, itself, and the per file cache
> > > info.  (The per file cache info limits re-measuring or re-appraising files.)
> > 
> > In Steve Chen's kexec supporting ima patchset, kdump kernel loading
> > should skip ima_kexec buffers allocating and storing via checking if
> > (image->type == KEXEC_TYPE_CRASH).
> > > 
> > > Similarly my knowledge of kdump is very limited.  Is there a way for the kernel
> > > to differentiate between kexec and kdump?  If we need a mechanism to disable
> > > IMA-measurement, I'd *really* prefer it be limited to kdump.
> > 
> > Yes, function is_kdump_kernel() is provided for checking if the current
> > kernel is in kdump kernel.
> > 
> > As said in earlier reply, for kdump kernel, there are two things we
> > should do:
> > 1) when loading 2nd kernel to prepare for switching, we should not
> > allocate buffer and store IMA measurement list;
> > 2) when switched into kdump kernel, we should not call ima_init() to do
> > kinds of init which is useless.
> > 
> > My personnal opinion.
> 
> Thanks for pointing out the KEXEC_TYPE_CRASH check and is_kdump_kernel().  Both
> changes sound reasonable.

Thanks for confirming. I will consider how to fix it accordingly. Maybe
after Steven's patches are merged. That would be great if the buffer
allocating and storing can be skiped for kdump in Steven's patch. While
I am worried that could disrupt the progress of Steven's patches.


