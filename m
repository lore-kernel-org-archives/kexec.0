Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66F5C3ABBE
	for <kexec@archiver.kernel.org>; Tue,  6 May 2025 06:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ef8W+vMYwBS9RnWnXRE7fKcNBov/mCBwOP6v8SZB5sY=; b=lqmrn3PlVjMElLKZXhd3Gjeu6n
	k1GdfTy+G70ITPj2UfiVPZSIRGeGoHmduo8Ajmpp7cACzSDmPw//JsgtKXwph5QYQYnifW9J3tIjo
	9QLBbLTADzwwM0uGq1E0JTzCao4b+kythboQRZcMcVnVoTDV33h96eyCG6b/Mo3xlKid2VzRWAzQ4
	TIQ0S7KkloqgiRakFSv5/3iqqf886oDRe7IOcwVyvnQ/89PGssJRI2yCESM95oer4NYV4AEdgK7E0
	TkJbdwDRJYE20jmzJutCoteVrZBntJykk7Y2jkj6xPeAgitKuoATjoVMazQ0VoH5+oCVIs9uHi45u
	W15ySeXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCBqK-0000000AhAk-1dwc;
	Tue, 06 May 2025 06:31:52 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCBB7-0000000AWdx-0MzQ
	for kexec@lists.infradead.org;
	Tue, 06 May 2025 05:49:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746510554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ef8W+vMYwBS9RnWnXRE7fKcNBov/mCBwOP6v8SZB5sY=;
	b=bmRnuryrH9CKMbt4tT/1ePWneXjRUPGHgN+/jHX9JS+VQneGi431PyQ89dYWGlxedRhIPe
	Nc8/v8ZeFTKWJGluVVYkKKvvMJv4f85oqMfANF5QoMuaE82WmxSA7qqFydiv11bTfb0qN6
	S/l17PkvDZkYMxK15Gkamg42JR6a3e4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-KDeYyDfQNRafeLfXFymNcw-1; Tue,
 06 May 2025 01:49:13 -0400
X-MC-Unique: KDeYyDfQNRafeLfXFymNcw-1
X-Mimecast-MFC-AGG-ID: KDeYyDfQNRafeLfXFymNcw_1746510549
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ADDE31800EC9;
	Tue,  6 May 2025 05:49:08 +0000 (UTC)
Received: from localhost (unknown [10.72.112.8])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 729071956094;
	Tue,  6 May 2025 05:49:05 +0000 (UTC)
Date: Tue, 6 May 2025 13:49:01 +0800
From: Baoquan He <bhe@redhat.com>
To: steven chen <chenste@linux.microsoft.com>
Cc: zohar@linux.ibm.com, stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
	eric.snowberg@oracle.com, ebiederm@xmission.com,
	paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
	James.Bottomley@hansenpartnership.com, vgoyal@redhat.com,
	dyoung@redhat.com
Subject: Re: [PATCH v13 0/9] ima: kexec: measure events between kexec load
 and execute
Message-ID: <aBmizZATrxhXbWyE@MiWiFi-R3L-srv>
References: <20250421222516.9830-1-chenste@linux.microsoft.com>
 <aApMnEl1Xzarmimn@fedora>
 <7337e27f-cc54-4c51-91d8-11d875baee49@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7337e27f-cc54-4c51-91d8-11d875baee49@linux.microsoft.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_224917_206037_8A80CF67 
X-CRM114-Status: GOOD (  23.83  )
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

On 05/02/25 at 09:25am, steven chen wrote:
> On 4/24/2025 7:37 AM, Baoquan He wrote:
> > Hi Steven,
> > 
> > Could you test below code and post a formal patch to not copy
> > measurement list buffer to kdump kernel? Below log is just for your
> > reference, please feel free to modify or rephrase.
> > 
> > ===
> > Kdump kernel doesn't need IMA to do integrity measurement.
> > Hence the measurement list in 1st kernel doesn't need to be copied to
> > kdump kenrel.
> > 
> > Here skip allocating buffer for measurement list copying if loading
> > kdump kernel. Then there won't be the later handling related to
> > ima_kexec_buffer.
> > ===
> > 
> > diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> > index 38cb2500f4c3..7362f68f2d8b 100644
> > --- a/security/integrity/ima/ima_kexec.c
> > +++ b/security/integrity/ima/ima_kexec.c
> > @@ -146,6 +146,9 @@ void ima_add_kexec_buffer(struct kimage *image)
> >   	void *kexec_buffer = NULL;
> >   	int ret;
> > +	if (image->type == KEXEC_TYPE_CRASH)
> > +		return;
> > +
> >   	/*
> >   	 * Reserve extra memory for measurements added during kexec.
> >   	 */
> > 
> Hi Baoquan,
> 
> I tested the kernel with above change. Normal soft reboot works fine.
> 
> I will post the patch for review.

Just come back from Labor Day public holiday. I went through the code
flow, the code should be fine. I will test it by checking the setup_data
if IMA data is excluded in kdump case.


