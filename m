Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE7CDCA0FE7
	for <kexec@archiver.kernel.org>; Tue, 26 Aug 2025 01:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uflk8J63v5Vdk+A5T71w43msAplrhyNBzSbyCutgOBw=; b=2swG7mYbpHWVyfXscqs0SqnLig
	bkZa4u5279fHmFy/MRlvNJqajC5M2iNK9g8g8uo1IJgT9Yes0cnJVOODw1WHNPUxHbknto6SskxtE
	h+OX17tKdv28mI3FhEZBw3HXbhWZooStDZX/Tg2cK10AW5/TQiaArseaO7Uj2ewYB3uKBAH46WI8T
	M5LIfCk9qKoVOjiVOerX+LwgM4owLfopZGtsw4VnSMT1AXM0+/TpikcHmgFkGpCXLjHlmNpdbrNUo
	/TljE19xLM5YTmG1suJnL+yUbHL09M1yidlMXHXnYa2Sbs+DAdl3BlodFjhRToCjn59aYRH2jwQJl
	woIh3ABg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqi82-0000000AFQ8-1Dii;
	Tue, 26 Aug 2025 01:05:38 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqi7x-0000000AFPK-1ZPd;
	Tue, 26 Aug 2025 01:05:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9A4F7406A6;
	Tue, 26 Aug 2025 01:05:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1935C4CEED;
	Tue, 26 Aug 2025 01:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1756170332;
	bh=9t+LpWoHJIsYPbMjiU2USC8E5Wcpyq+n6+4DJhGHFvo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y8XBmyN0f/0MgGjeKimTUShtaB8EhLKUUrrmRMR3IbngvR7S1rg8rHkhnN78HfAhX
	 DkF1xazVTsIy6tOSICzsHTiycb3Y3thNj93LolbqqMl4AQS5gOJlcJyEdyCIp+1zxZ
	 rCJn2sE5Sff8NjTQL5EKgcgv+i4W35W228YHKaoo=
Date: Mon, 25 Aug 2025 18:05:31 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Coiby Xu <coxu@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, kexec@lists.infradead.org, Ondrej
 Kozina <okozina@redhat.com>, Milan Broz <gmazyland@gmail.com>, Thomas
 Staudt <tstaudt@de.ibm.com>, Daniel P . =?ISO-8859-1?Q?Berrang=E9?=
 <berrange@redhat.com>, Kairui Song <ryncsn@gmail.com>, Pingfan Liu
 <kernelfans@gmail.com>, Baoquan He <bhe@redhat.com>, Dave Young
 <dyoung@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, Dave
 Hansen <dave.hansen@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>, Jan Pazdziora
 <jpazdziora@redhat.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 1/8] kexec_file: allow to place kexec_buf randomly
Message-Id: <20250825180531.94bfb86a26a43127c0a1296f@linux-foundation.org>
In-Reply-To: <yng55a2z25m5upehczerzhi6zawe3j4ka7amfu4vw4cu27bbg2@x2lgbuk3iqyf>
References: <20250502011246.99238-1-coxu@redhat.com>
	<20250502011246.99238-2-coxu@redhat.com>
	<oninomspajhxp4omtdapxnckxydbk2nzmrix7rggmpukpnzadw@c67o7njgdgm3>
	<yng55a2z25m5upehczerzhi6zawe3j4ka7amfu4vw4cu27bbg2@x2lgbuk3iqyf>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250825_180533_458004_3D0C3B61 
X-CRM114-Status: GOOD (  16.70  )
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

On Mon, 25 Aug 2025 09:18:53 +0800 Coiby Xu <coxu@redhat.com> wrote:

> >diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
> >index 532d72ea42ee8..287b25e674d76 100644
> >--- a/arch/arm64/kernel/kexec_image.c
> >+++ b/arch/arm64/kernel/kexec_image.c
> >@@ -76,6 +76,7 @@ static void *image_load(struct kimage *image,
> > 	kbuf.buf_min = 0;
> > 	kbuf.buf_max = ULONG_MAX;
> > 	kbuf.top_down = false;
> >+	kbuf.random = 0;
> >
> > 	kbuf.buffer = kernel;
> > 	kbuf.bufsz = kernel_len;
> >
> 
> And also thanks for posing a fix! The patch LGTM. Can you add a Fixes
> tag 'Fixes: bf454ec31add ("kexec_file: allow to place kexec_buf
> randomly")' and then send it to kexec@lists.infradead.org? Thanks!

I turned all this into a regular patch and queued it (see below),
thanks.  No additional actions are needed.

I'm really not liking that code.  I laboriously verified that all
fields of kexec_buf are now initialized, except for `cma'.  Is that a
bug?

This function has a call frequency of about 3x per week.  Can we please
just memset the whole thing so people don't have to worry about this
any more?


From: Breno Leitao <leitao@debian.org>
Subject: kexec/arm64: initialize the random field of kbuf to zero in the image loader
Date: Thu Aug 21 04:11:21 2025 -0700

Add an explicit initialization for the random member of the kbuf structure
within the image_load function in arch/arm64/kernel/kexec_image.c. 
Setting kbuf.random to zero ensures a deterministic and clean starting
state for the buffer used during kernel image loading, avoiding this UBSAN
issue later, when kbuf.random is read.

  [   32.362488] UBSAN: invalid-load in ./include/linux/kexec.h:210:10
  [   32.362649] load of value 252 is not a valid value for type '_Bool'

Link: https://lkml.kernel.org/r/oninomspajhxp4omtdapxnckxydbk2nzmrix7rggmpukpnzadw@c67o7njgdgm3
Fixes: bf454ec31add ("kexec_file: allow to place kexec_buf randomly
Signed-off-by: Breno Leitao <leitao@debian.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Coiby Xu <coxu@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Kairui Song <ryncsn@gmail.com>
Cc: Liu Pingfan <kernelfans@gmail.com>
Cc: Milan Broz <gmazyland@gmail.com>
Cc: Ondrej Kozina <okozina@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/arm64/kernel/kexec_image.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm64/kernel/kexec_image.c~kexec-arm64-initialize-the-random-field-of-kbuf-to-zero-in-the-image-loader
+++ a/arch/arm64/kernel/kexec_image.c
@@ -76,6 +76,7 @@ static void *image_load(struct kimage *i
 	kbuf.buf_min = 0;
 	kbuf.buf_max = ULONG_MAX;
 	kbuf.top_down = false;
+	kbuf.random = 0;
 
 	kbuf.buffer = kernel;
 	kbuf.bufsz = kernel_len;
_


