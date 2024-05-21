Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA6BC25B77
	for <kexec@archiver.kernel.org>; Tue, 21 May 2024 03:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OHruZkwA0R3WP3IIlTHT4f5MAX9HPFFADAnKm3aeuFg=; b=qmvv9Q3yxahstD
	/QQzFH92+L/JnV3GJ/7RmuwhJ+xrA6Xd57xz0Gk7/NHd7XrAIm9DA5yowYWXkaaa0CSqB5qdfK402
	qexqjOW349uLlT00Vn1pdJVBCps0C+H97ZVZRWlh1sZ88HBvg0kuUC7T3hiyA7FHdkh5YfYLqB8uC
	POlmGFE1T1oxxWBfCLmilS3u/rWU6LIqe8ioJhpt7DFDpX+UA576LDB1dmDOZ12uL7ed46XKxQ3HC
	t294SuDWnZQXkf2BAIeA+aky94adwZKa/PgrzFYWhCCY5QAaIrb+sF3cbmy5KDPGLNERIygbmBNLo
	we/YnQzIanxHMjGvqE3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9Fwr-0000000G9pj-4A8R;
	Tue, 21 May 2024 03:13:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9Fwp-0000000G9o3-0kq2
	for kexec@lists.infradead.org;
	Tue, 21 May 2024 03:13:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716261232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3/HzK1apeoYY0DujLj2rbx8MJd+TQtas5Uof0p135Ck=;
	b=fqyeBLLdodfxF+36YUaBadgc+f2BskO2Jm9HeWTAPh6uv0ZDSvNnXIVL2lb6rjMF7CSUC6
	v/48xVYk9mMqDIceL8v7/FiKeQ5AYHnofjbjkU7TWL7hkem+Mwb6JHZ6NaD48qnGdL9nKR
	WKvYKqzunJd4ioDRgNMOL0GIgKBMlkg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-ugmp0PizN2unNesMjqUHGA-1; Mon, 20 May 2024 23:13:48 -0400
X-MC-Unique: ugmp0PizN2unNesMjqUHGA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2FE3C101A54F;
	Tue, 21 May 2024 03:13:48 +0000 (UTC)
Received: from localhost (unknown [10.72.116.65])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 28DF440C6EB7;
	Tue, 21 May 2024 03:13:46 +0000 (UTC)
Date: Tue, 21 May 2024 11:13:43 +0800
From: Baoquan He <bhe@redhat.com>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v3 1/7] kexec_file: allow to place kexec_buf randomly
Message-ID: <ZkwRZxGw2dWStd1C@MiWiFi-R3L-srv>
References: <20240425100434.198925-1-coxu@redhat.com>
 <20240425100434.198925-2-coxu@redhat.com>
 <ZkrqkzJlW2RZkmH9@MiWiFi-R3L-srv>
 <y5ogivx7qbdm6u37t5o6na4jewn6qofzrbibnsneoqlwns63y5@eg62cytuvwql>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <y5ogivx7qbdm6u37t5o6na4jewn6qofzrbibnsneoqlwns63y5@eg62cytuvwql>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240520_201355_330008_CABD1137 
X-CRM114-Status: GOOD (  25.12  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 05/21/24 at 09:58am, Coiby Xu wrote:
> On Mon, May 20, 2024 at 02:16:43PM +0800, Baoquan He wrote:
> > On 04/25/24 at 06:04pm, Coiby Xu wrote:
> > > Currently, kexec_buf is placed in order which means for the same
> > > machine, the info in the kexec_buf is always located at the same
> > > position each time the machine is booted. This may cause a risk for
> > > sensitive information like LUKS volume key. Now struct kexec_buf has a
> > > new field random which indicates it's supposed to be placed in a random
> > > position.
> > 
> > Do you want to randomize the key's position for both kdump and kexec
> > rebooting? Assume you only want to do that for kdump. If so, we may need
> > to make that more specific in code.
> 
> Thanks for the suggestion! Currently, no one has requested this feature
> for kexec reboot so yes, I only have kdump in mind. But kdump depends
> on kexec thus I'm not sure how we can make it kdump specfic. Do you have
> a further suggestion?

I remember you said kexec reboot doesn't need the key passed from 1st
kernel to 2nd kernel because the 2nd kernel will calculate one during
boot.

kbuf has the information, the similar handling has been in
kernel/kexec_file.c:

#ifdef CONFIG_CRASH_DUMP
        if (kbuf->image->type == KEXEC_TYPE_CRASH)
                ....;
#endif

> 
> 
> > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > index 060835bb82d5..fc1e20d565d5 100644
> > --- a/include/linux/kexec.h
> > +++ b/include/linux/kexec.h
> > @@ -171,6 +171,7 @@ int kexec_image_post_load_cleanup_default(struct kimage *image);
> >  * @buf_min:	The buffer can't be placed below this address.
> >  * @buf_max:	The buffer can't be placed above this address.
> >  * @top_down:	Allocate from top of memory.
> > + * @random:	Place the buffer at a random position.
> 
> How about a comment here saying this is currently only used by kdump.

No, it's not good. Please don't do this, let code tell it.

By the way, can you rebase this series on the latest v6.9 and resend? I
rebase my code and can't apply your patchset.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
