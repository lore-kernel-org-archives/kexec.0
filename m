Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59496C00140
	for <kexec@archiver.kernel.org>; Fri, 12 Aug 2022 09:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K70Kvni1MBP/dMNuHFf31s6/fAxq1Dq4nLQcn1uQwd8=; b=qWsl/IculkAdhI
	ecDKzQU42Q1QAqLdItIpzJi/qncQhqZruDjnlIQgoLmwyWrVqG8qZzgR/iBu377+3pQU/5JKL85Hi
	XShBf/aigEERyoYKzMY262o4NWr60aNOGa8KnL2r++jFL7uJj5N52djfEW5F94AGw79VQid7OKyEv
	tztAUKv3psx2ymrE01jxZ26E5fMPzv9F6Pdy0MyAzC5QX8AbOHWBKf8teDlSI/XzGYsVj4rpezaSp
	uTJwALwPAuKx6Bt8oPfEbzdcRZgEKlw3P/v5kxSFrf5JZzD2ezvF05ggKI1FnIFyP3XTqEEmQ+cLk
	vaMVtJ3jdQ2Shx5/0Gww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMRFJ-003vSU-V7; Fri, 12 Aug 2022 09:46:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMRFG-003vLD-HZ
	for kexec@lists.infradead.org; Fri, 12 Aug 2022 09:46:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1660297579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2c/iImSQTA02RBtmBVV2RGW771GUr2pXHiaSO81S20w=;
	b=HQpUYVEdR3WLm+PlU9DgFKIYTH4MJ7HcTU05DjKaXs40+PRKunpxjh60YXCjl0C0dd0Y6B
	mBcyHe8xXcXLtp6KTUG7UXdDYBpTq7NPfVnYLWVUXf/x/BWgcIePlepsdvVBU/k3iV9VsV
	9MpDzm+JN7RjBUKy2UhIoH2oTdlfYUA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-211-2Wxmoo5wOzabgm-izal5tA-1; Fri, 12 Aug 2022 05:46:15 -0400
X-MC-Unique: 2Wxmoo5wOzabgm-izal5tA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 29815811E75;
	Fri, 12 Aug 2022 09:46:14 +0000 (UTC)
Received: from localhost (ovpn-12-160.pek2.redhat.com [10.72.12.160])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E44A42166B26;
	Fri, 12 Aug 2022 09:46:12 +0000 (UTC)
Date: Fri, 12 Aug 2022 17:46:09 +0800
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
Message-ID: <YvYhYdV6F2zH4o3X@MiWiFi-R3L-srv>
References: <20220721181747.1640-1-eric.devolder@oracle.com>
 <20220721181747.1640-2-eric.devolder@oracle.com>
 <YvCCOY+mRshu1tHi@MiWiFi-R3L-srv>
 <52d40562-ee6f-bb89-6d21-2d6baf67053d@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52d40562-ee6f-bb89-6d21-2d6baf67053d@oracle.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220812_024622_805407_37B9476C 
X-CRM114-Status: GOOD (  19.08  )
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

On 08/08/22 at 10:18am, Eric DeVolder wrote:
> 
> 
> On 8/7/22 22:25, Baoquan He wrote:
> > Hi Eric,
> > 
> > On 07/21/22 at 02:17pm, Eric DeVolder wrote:
> > > The use of __weak is being eliminated within kexec sources.
> > > The technique uses macros mapped onto inline functions in
> > > order to replace __weak.
> > > 
> > > This patchset was using __weak and so in order to replace
> > > __weak, this patch introduces arch/*/asm/crash.h, patterned
> > > after how kexec is moving away from __weak and to the macro
> > > definitions.
> > 
> > Are you going to replace __weak in kexec of arll ARCHes? I don't see
> > your point why all these empty header files are introduced. Wondering
> > what's impacted if not adding these empty files?
> 
> Hi Baoquan,
> In this patchset, to file include/linux/crash_core.h I added the line #include <asm/crash.h>.
> I patterned this after how include/linux/kexec.h does #include <asm/kexec.h>.

I am sorry, Eric, it looks not so good. I understand you want to pattern
asm/kexe.h, but we need consider reality. Introducing a dozen of empty
header file and not being able to tell when they will be filled doesn't
make sense.

Includig <asm/crash.h> where needed is much simpler. I doubt if your way
can pass other reviewers' line. Can you reconsider?

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 77f5f3591760..b0577bdcc491 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -15,6 +15,7 @@
 
 #include <asm/page.h>
 #include <asm/sections.h>
+#include <asm/crash.h>
 
 #include <crypto/sha1.h>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
