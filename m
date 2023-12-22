Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73ED1C46CCD
	for <kexec@archiver.kernel.org>; Fri, 22 Dec 2023 00:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FhIzoKm/Ykvl1tidmgt4H5OCezfXk2bxdMgU+g2IvDk=; b=gkMQFEZhDTHElz
	pG7AZWHpki3a6j0f9n+BLDSD3d0oslSiTGIVA3QFEA0TMPuM49K0WU5INr8V+yLYFQfc35w7xGrau
	RDjR/RIpCs4U5lifeXh/JTFIY+8s9cWEzAWs+DOMkjcQf403Np/n/+3ZSKs6zx7zj+n3t8Ok3CJK9
	sAcfOWJ14wpbA+o6L+sI2d2i/lw3hEy1LSB8cQWucPpcIJ59BUuMAVbMbu8xQ4yqwr30StGA8umwO
	/OCcJ7SqoJ0S8u/tjK9OKKIX0MabPu7nHU3po0Yjk2CRxTaWPEjT9rl+rGaW/yaBtgQonQNABb2w/
	rX/KPGJ6bT34e9NE36qQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGTP3-004Web-10;
	Fri, 22 Dec 2023 00:28:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGTP0-004WcR-0b
	for kexec@lists.infradead.org;
	Fri, 22 Dec 2023 00:28:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703204911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V469IzZFM/sqWdM4ZH24JLlDB8BfQ7rXz+wlXVI+39A=;
	b=ZSLBkypywc9LqW04kpt+nVKrUekiVTsLCEPqKFVXF9xEPmciIaerRogJbdvAjvuLpoQ2kh
	qiyNuVd6xxvRa34V5PpLlhxwXUysosA9TGso6M2iAzMdoEFC14now8iE+tFTnQK5KLv0BV
	gwHu/nP0TtvNiGG7JZZM1SFgtDEiIEk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-l7GbVMzmMVK1MfKz78CCNQ-1; Thu, 21 Dec 2023 19:28:29 -0500
X-MC-Unique: l7GbVMzmMVK1MfKz78CCNQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 581E7833945;
	Fri, 22 Dec 2023 00:28:28 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 73CE840C6EB9;
	Fri, 22 Dec 2023 00:28:26 +0000 (UTC)
Date: Fri, 22 Dec 2023 08:28:23 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Akhil Raj <lf32.dev@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Young <dyoung@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Eric DeVolder <eric.devolder@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Laurent Dufour <laurent.dufour@fr.ibm.com>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mimi Zohar <zohar@linux.ibm.com>, Naveen N Rao <naveen@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
	x86@kernel.org
Subject: Re: [PATCH v14 3/6] crash: add a new kexec flag for FDT update
Message-ID: <ZYTYJ6sjdzZwjGpS@MiWiFi-R3L-srv>
References: <20231211083056.340404-1-sourabhjain@linux.ibm.com>
 <20231211083056.340404-4-sourabhjain@linux.ibm.com>
 <ZXu55ZXVSMeQDE/e@MiWiFi-R3L-srv>
 <7fe7b62f-d3fc-4035-96fe-1ab0e3e743c0@linux.ibm.com>
 <ZX1wwVlE85FcTxmV@MiWiFi-R3L-srv>
 <67cadf74-6ae6-4f37-8645-af1833b13196@linux.ibm.com>
 <ZX5H+X9Urz8kuiSG@MiWiFi-R3L-srv>
 <cdde877b-e620-45db-ae28-4b691c1ae5b6@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <cdde877b-e620-45db-ae28-4b691c1ae5b6@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_162834_325625_3809EF25 
X-CRM114-Status: GOOD (  23.57  )
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

On 12/21/23 at 11:36am, Sourabh Jain wrote:
......
> > > > diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
> > > > index 3d5b3d757bed..df6a6505e267 100644
> > > > --- a/include/uapi/linux/kexec.h
> > > > +++ b/include/uapi/linux/kexec.h
> > > > @@ -13,7 +13,7 @@
> > > >    #define KEXEC_ON_CRASH         0x00000001
> > > >    #define KEXEC_PRESERVE_CONTEXT 0x00000002
> > > > -#define KEXEC_UPDATE_FDT       0x00000008
> > > > +#define KEXEC_CRASH_HOTPLUG_UPDATE 0x00000004
> > > >    #define KEXEC_UPDATE_ELFCOREHDR        0x00000004
> > > >    #define KEXEC_ARCH_MASK                0xffff0000
> > > >    /*
> > > > 
> > > > With my understanding, the kexec flag should be indicating the action,
> > > > the mem/cpu hotplug, but not relating to any detail. Imagine later
> > > > another segment need be skipped on one ARCH again, then another flag
> > > > need be added, this sounds not reasonable.
> > > I strongly agree with you. The KEXEC_CRASH_HOTPLUG_UPDATE kexec flag
> > > should be sufficient to inform the kernel that the kexec tool has been
> > > updated
> > > to support CPU/Memory hotplug for the kexec_load system call. Unfortunately,
> > > we cannot use the 0x00000004 kexec flags bit for KEXEC_CRASH_HOTPLUG_UPDATE
> > > at the moment.
> > I am fine with 0x00000008 and a new flag, it has the same effect as
> > #define KEXEC_CRASH_HOTPLUG_UPDATE 0x00000004
> > 
> > I am worried about the header file incompatiblity.
> 
> If we are OK to have KEXEC_CRASH_HOTPLUG_UPDATE 0x00000008 as new bit
> to introduce CPU/Memory hotplug feature for kexec_load syscall, we will not
> have
> compatibility issue.
> 
> Let me write next version for this patch with KEXEC_CRASH_HOTPLUG_UPDATE
> 0x00000008
> as new flag bit and show how it will be handled. I will also share kexec
> code for clarity.

It's great we are in the same page about segments excluding done in arch
function. While It's a little unclear to me why we can't reuse 0x00000004
flag value. Then KEXEC_UPDATE_ELFCOREHDR will only exist in v6.6 kernel,
and that bit won't be used in v6.7 and future version.

Except of the existence in kexec-tools utility for XEN, do you see other
barrier? I would like to know so that one day I can explain
KEXEC_UPDATE_ELFCOREHDR to someone else if asked.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
