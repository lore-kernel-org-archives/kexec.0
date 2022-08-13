Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238CCC00140
	for <kexec@archiver.kernel.org>; Sat, 13 Aug 2022 00:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3PYnBHGhI6j5DJU+/rqjmUKz9g6lEzQbppiv5j3NC9Y=; b=sC0pnzRwvPhwG6
	HAmYGtC2UerHgtC8FkAgyDPDw9G8OZueu1SvikhIvWiBpkbPRiRO7JBBHV9DEGLHwxJ/p37rhFOTn
	tsNkWbuJ4U1jqo/a0tWbPqav6NsxePd8LPXoRBvgEZKPH16SzSHwhbAcTJumZF37iD4VgjuWSh8bb
	YpLefvdObGeDJoSzrOlV1Iy21hP38YCStM6PiYp6TXbl/+/aKYCVs96CfoQYXAqU+Ud50vtB08+UR
	hmrV8vOz3QhMrCyhnms5k+DidCpwMxlE9AQw7YbDUEaaPUgenTe+fv78v4gCYNfq5/q6GNCLeYAxn
	bNXZS9+qbBtKVpmAnrWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMexO-001Apg-7H; Sat, 13 Aug 2022 00:24:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMexL-001AkQ-2E
	for kexec@lists.infradead.org; Sat, 13 Aug 2022 00:24:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1660350284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D+F48GZrNmKWUhdl+zaXl1w6N+t4Zw3HE18peH9oyp0=;
	b=Jt+QW/KIZbAwkWpxZNJV7j2dAgTMiJhvmlZvg7YxsiXyIQTiixK4qn//dO1nAWfzDGj9Ns
	qFnxR9v2ryNb6jqNsIEbYSIBSh2bK8yFepqLw6PeBOcD1YPu+HfQNzD+HuW5GotBvC5XNt
	WKtkQBoWSAKZBgak+ulfjrG4X+F1Hbs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-BCAHucJXNv2sttbzvrBPPQ-1; Fri, 12 Aug 2022 20:24:40 -0400
X-MC-Unique: BCAHucJXNv2sttbzvrBPPQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1564B3C0219A;
	Sat, 13 Aug 2022 00:24:39 +0000 (UTC)
Received: from localhost (ovpn-12-29.pek2.redhat.com [10.72.12.29])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F3593403178;
	Sat, 13 Aug 2022 00:24:37 +0000 (UTC)
Date: Sat, 13 Aug 2022 08:24:35 +0800
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
Subject: Re: [PATCH v10 1/8] crash: introduce arch/*/asm/crash.h
Message-ID: <YvbvQ5+cmExVNaGE@MiWiFi-R3L-srv>
References: <20220721181747.1640-1-eric.devolder@oracle.com>
 <20220721181747.1640-2-eric.devolder@oracle.com>
 <YvCCOY+mRshu1tHi@MiWiFi-R3L-srv>
 <52d40562-ee6f-bb89-6d21-2d6baf67053d@oracle.com>
 <YvYhYdV6F2zH4o3X@MiWiFi-R3L-srv>
 <2b44bbd1-6e6f-40d1-73ac-19348d1ef48a@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2b44bbd1-6e6f-40d1-73ac-19348d1ef48a@oracle.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220812_172447_448302_D4DC6699 
X-CRM114-Status: GOOD (  27.35  )
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

On 08/12/22 at 04:23pm, Eric DeVolder wrote:
> 
> 
> On 8/12/22 04:46, Baoquan He wrote:
> > On 08/08/22 at 10:18am, Eric DeVolder wrote:
> > > 
> > > 
> > > On 8/7/22 22:25, Baoquan He wrote:
> > > > Hi Eric,
> > > > 
> > > > On 07/21/22 at 02:17pm, Eric DeVolder wrote:
> > > > > The use of __weak is being eliminated within kexec sources.
> > > > > The technique uses macros mapped onto inline functions in
> > > > > order to replace __weak.
> > > > > 
> > > > > This patchset was using __weak and so in order to replace
> > > > > __weak, this patch introduces arch/*/asm/crash.h, patterned
> > > > > after how kexec is moving away from __weak and to the macro
> > > > > definitions.
> > > > 
> > > > Are you going to replace __weak in kexec of arll ARCHes? I don't see
> > > > your point why all these empty header files are introduced. Wondering
> > > > what's impacted if not adding these empty files?
> > > 
> > > Hi Baoquan,
> > > In this patchset, to file include/linux/crash_core.h I added the line #include <asm/crash.h>.
> > > I patterned this after how include/linux/kexec.h does #include <asm/kexec.h>.
> > 
> > I am sorry, Eric, it looks not so good. I understand you want to pattern
> > asm/kexe.h, but we need consider reality. Introducing a dozen of empty
> > header file and not being able to tell when they will be filled doesn't
> > make sense.
> > 
> > Includig <asm/crash.h> where needed is much simpler. I doubt if your way
> > can pass other reviewers' line. Can you reconsider?
> 
> If I include <asm/crash.h> where needed, which is kernel/crash_core.c, then
> the other archs will fail build if that file doesn't exist. A couple of
> options, which do you think is better to pursue?
> 
> - use asm/kexec.h instead of asm/crash.h; it appears all the architectures
> already have this file in place
> 
> - go ahead and put the appropriate crash macros/inline functions into each
> arch asm/crash.h so that the files are not just empty, and leave the use of
> asm/crash.h

I think we can do this in two steps.

Firstly, make do with asm/kexec.h since all other ARCHes put crash related stuff
into asm/kexec.h, except of x86. 

Secondly, clean up to put those crash marco/inline functions into
asm/crash.h.

The 2nd step can be done in a independent patchset. What do you think?


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
