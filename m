Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 829B1C52D7C
	for <kexec@archiver.kernel.org>; Mon, 19 Aug 2024 06:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=snsETcFegvwL9i1FzS571eYSEu1zp4XOPRIoIGk2w0k=; b=VYCuFr59HgRth6
	bySXV3PZh4+lW0LomzBlcGGjfsrruTRXTv7EzuHAiSUvQzgGvuOB8ZCD22qJGZei7IYfMIlXojywj
	Rs4UCU735FW4BFR6/+UTtXvx0a7S2HM5q+nFfUbqMeaLuhXwHOJODInQNNutt7nP2uR27itDxH/rK
	90wOhwWiSI7loVBwtMMCNFlPZL1CGGYhFH1quAXBn4jpMA/KeyYTEGMyPqi68IHHQqxTlXjQFFeLI
	wZz6BxqnsxoYLoK0T5jt/65tUweEmTiNODgip9Kg1mkey5V0R7jvE8GDm8knnCBoFcy+IONYFGXlr
	3/bFOS9j8YXVvPifG0GA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sfvga-00000000VKO-29NI;
	Mon, 19 Aug 2024 06:16:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sfvgW-00000000VJQ-2Lv1
	for kexec@lists.infradead.org;
	Mon, 19 Aug 2024 06:16:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724048165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FcJLl/Fp3h6jQcz16e/hG76KVnOut/BqwVl6XHyRN6I=;
	b=S0dFYkBehoCsRyJEV/tlcOsoDp4j+1ql1+kd7LriDg6gyZG/2f8D7UPS2SSBfRfDNJAz9l
	ff+8gK0B3AurHHdGBMh4gvXsTev63Ju/Lxjg8McelBIgde2objotDWuwRkt6EBdPbfb9aF
	URTM65fZISK8XUioyi3zVRqFRrzPxeY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-UEOZI0jQNFyoDul8YmFjXw-1; Mon,
 19 Aug 2024 02:16:01 -0400
X-MC-Unique: UEOZI0jQNFyoDul8YmFjXw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 13E011955EA6;
	Mon, 19 Aug 2024 06:15:59 +0000 (UTC)
Received: from localhost (unknown [10.72.112.51])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB58419773E0;
	Mon, 19 Aug 2024 06:15:56 +0000 (UTC)
Date: Mon, 19 Aug 2024 14:15:52 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Hari Bathini <hbathini@linux.ibm.com>, kexec@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
Subject: Re: [PATCH] kexec/crash: no crash update when kexec in progress
Message-ID: <ZsLjGJvAUIaxrG6x@MiWiFi-R3L-srv>
References: <20240731152738.194893-1-sourabhjain@linux.ibm.com>
 <87v80lnf8d.fsf@mail.lhotse>
 <10c666ae-d528-4f49-82e9-8e0fee7099e0@linux.ibm.com>
 <355b58b1-6c51-4c42-b6ea-dcd6b1617a18@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <355b58b1-6c51-4c42-b6ea-dcd6b1617a18@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240818_231608_695728_5B2CF8B7 
X-CRM114-Status: GOOD (  26.54  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 08/19/24 at 09:45am, Sourabh Jain wrote:
> Hello Michael and Boaquan
> =

> On 01/08/24 12:21, Sourabh Jain wrote:
> > Hello Michael,
> > =

> > On 01/08/24 08:04, Michael Ellerman wrote:
> > > Sourabh Jain <sourabhjain@linux.ibm.com> writes:
> > > > The following errors are observed when kexec is done with SMT=3Doff=
 on
> > > > powerpc.
> > > > =

> > > > [=A0 358.458385] Removing IBM Power 842 compression device
> > > > [=A0 374.795734] kexec_core: Starting new kernel
> > > > [=A0 374.795748] kexec: Waking offline cpu 1.
> > > > [=A0 374.875695] crash hp: kexec_trylock() failed, elfcorehdr may
> > > > be inaccurate
> > > > [=A0 374.935833] kexec: Waking offline cpu 2.
> > > > [=A0 375.015664] crash hp: kexec_trylock() failed, elfcorehdr may
> > > > be inaccurate
> > > > snip..
> > > > [=A0 375.515823] kexec: Waking offline cpu 6.
> > > > [=A0 375.635667] crash hp: kexec_trylock() failed, elfcorehdr may
> > > > be inaccurate
> > > > [=A0 375.695836] kexec: Waking offline cpu 7.
> > > Are they actually errors though? Do they block the actual kexec from
> > > happening? Or are they just warnings in dmesg?
> > =

> > The kexec kernel boots fine.
> > =

> > This warning appears regardless of whether the kdump kernel is loaded.
> > =

> > However, when the kdump kernel is loaded, we will not be able to update
> > the kdump image (FDT).
> > I think this should be fine given that kexec is in progress.
> > =

> > Please let me know your opinion.
> > =

> > > Because the fix looks like it could be racy.
> > =

> > It seems like it is racy, but given that kexec takes the lock first and
> > then
> > brings the CPU up, which triggers the kdump image, which always fails to
> > update the kdump image because it could not take the same lock.
> > =

> > Note: the kexec lock is not released unless kexec boot fails.
> =

> Any comments or suggestions on this fix?

Is this a little better?

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 63cf89393c6e..0355ffb712f4 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -504,7 +504,7 @@ int crash_check_hotplug_support(void)
 =

 	crash_hotplug_lock();
 	/* Obtain lock while reading crash information */
-	if (!kexec_trylock()) {
+	if (!kexec_trylock() && kexec_in_progress) {
 		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
 		crash_hotplug_unlock();
 		return 0;
@@ -539,7 +539,7 @@ static void crash_handle_hotplug_event(unsigned int hp_=
action, unsigned int cpu,
 =

 	crash_hotplug_lock();
 	/* Obtain lock while changing crash information */
-	if (!kexec_trylock()) {
+	if (!kexec_trylock() && kexec_in_progress) {
 		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
 		crash_hotplug_unlock();
 		return;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
