Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E64C43217
	for <kexec@archiver.kernel.org>; Tue, 29 Nov 2022 00:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7MlOd+PKFPydPSIttDZ2fhi+HhUi25vUqBQnf2Kk728=; b=qG9QOc7d6nklGZ
	jAcucjvZhsHl0ZXMxJYzVhi7L3XdKcQlPljrlxyRIlVwSyyMJk2m2281PGsCts5xTY7PbVeY1PkVK
	gW7VDQ2p132AbR+gZ//72Ryr5kzx22jZ8vnVjRxMKhNZVAsLt8Oq1RH2Xlymn8793mZmWXkVEK8JZ
	mnfbvhatJ6VhFDotrc/xjZZsctCFnR6P5JuS32JCsAjP3vM/0U2bff4rZFKXK14fZh5SdhD5ByNHZ
	OHTk9A30xNrWkbFLjaNZTI+5F6uaGaMPvhexeX7UQX5v+Sl0Mee5L5OVsS/qOpU/n/dZLp/Qr983O
	ugpmGmTjGGEy2vU38suA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozoib-004vAI-Ts; Tue, 29 Nov 2022 00:43:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozoiW-004v8e-JT
	for kexec@lists.infradead.org; Tue, 29 Nov 2022 00:43:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1669682596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+aFl0sgOrMydmqjUk07fy4RrxHvoSGQ4dmDc5GOKMr4=;
	b=HdX0EVWrgJccob2uSxrWzs2ufMtR6FEGnYzb3NI+COxALZoQke1aKYh96T0nPyVISeg/FW
	cyGtguOkQd0ajzp5X7cDRH4/vXqbj9DQKmqiMEPFEpktYeRRmel2mex6ybF1OH+Uq2hJmu
	EeGkzMocKR5WHMvR7WVLmT9oVyZ01sw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-567-68pV0VV2PL6qJaYl8zXnxA-1; Mon, 28 Nov 2022 19:43:13 -0500
X-MC-Unique: 68pV0VV2PL6qJaYl8zXnxA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 19623833AEC;
	Tue, 29 Nov 2022 00:43:12 +0000 (UTC)
Received: from localhost (ovpn-12-142.pek2.redhat.com [10.72.12.142])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E07274B3FC8;
	Tue, 29 Nov 2022 00:43:10 +0000 (UTC)
Date: Tue, 29 Nov 2022 08:43:07 +0800
From: Baoquan He <bhe@redhat.com>
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org,
	ebiederm@xmission.com, dyoung@redhat.com, vgoyal@redhat.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	nramas@linux.microsoft.com, thomas.lendacky@amd.com,
	robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
	sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
	boris.ostrovsky@oracle.com
Subject: Re: [PATCH v14 3/7] crash: add generic infrastructure for crash
 hotplug support
Message-ID: <Y4VVm5gVWqa0GkbY@MiWiFi-R3L-srv>
References: <20221116214643.6384-1-eric.devolder@oracle.com>
 <20221116214643.6384-4-eric.devolder@oracle.com>
 <Y4A1/cSekXUTFriC@MiWiFi-R3L-srv>
 <248486ff-5f9d-bffd-ab6e-131c54f31bd8@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <248486ff-5f9d-bffd-ab6e-131c54f31bd8@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221128_164320_756477_8FEC627C 
X-CRM114-Status: GOOD (  19.94  )
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

On 11/28/22 at 09:46am, Eric DeVolder wrote:
> 
> 
> On 11/24/22 21:26, Baoquan He wrote:
> > On 11/16/22 at 04:46pm, Eric DeVolder wrote:
> > ......
> > > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > > index ebf46c3b8f8b..b4dbc21f9081 100644
> > > --- a/include/linux/kexec.h
> > > +++ b/include/linux/kexec.h
> > > @@ -32,6 +32,7 @@ extern note_buf_t __percpu *crash_notes;
> > >   #include <linux/compat.h>
> > >   #include <linux/ioport.h>
> > >   #include <linux/module.h>
> > > +#include <linux/highmem.h>
> > >   #include <asm/kexec.h>
> > >   /* Verify architecture specific macros are defined */
> > > @@ -374,6 +375,13 @@ struct kimage {
> > >   	struct purgatory_info purgatory_info;
> > >   #endif
> > > +#ifdef CONFIG_CRASH_HOTPLUG
> > 
> > This kernel config CRASH_HOTPLUG is added in patch 7, but we have used
> > it in the previous patch, not sure if this is acceptable.
> > 
> I wasn't sure what to do here either. Patch 7 is the x86 arch-specific
> support patch, and CRASH_HOTPLUG is introduced in arch/x86/Kconfig. I did
> look at introducing CRASH_HOTPLUG as a generic/non-arch-specific option, but
> no location seemed appropriate given HOTPLUG_CPU is arch-specific and
> MEMORY_HOTPLUG is in mm/Kconfig.

arch/Kconfig?

Because CRASH_CORE/KEXEC_CORE are defined there.

> 
> This doesn't break bisect, but as you point out, not sure if the location in patch 7 is acceptable.
> I'm not really sure how to resolve the question.

Hmm, since it's bisect-able, seems doesn't break rule. I could be too
sensitive. Do we have a precendent like this, to strengthen our
confidence?

If no concern from other people, it's also fine to me.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
