Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137C7CA0FF9
	for <kexec@archiver.kernel.org>; Wed, 27 Aug 2025 15:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4etMjBoHFn+n6erGPScH1pkM2ZUCXCdu4tc4puWCOpw=; b=HrGun6ahfSk1/eF0o6GLoz0B5c
	QVeJNBbfkoKm0SkUDmCWtndwSkVHvYvz1PFlxiPQq2JRCWJoF5P24WXVILN9Atna1xX3/dFo9/noO
	3FZZu/MfnWvcVRTWfzz1uG3Lp63KEv1R9GbsdgDREmxNGP4TkC2Qa2X6OZUvDea3SgncGDnK7w9WO
	uNZ0ppX6xcCJAP/tD3Ct1cU6+x1c/tfMOzunxMkOGdSBMciIF4IoYx1Q4NymgQVbeBjycM5NH1Ogk
	yioA4C0QNSxc/nPXB2r9DH5uRiCIjUbI6PVmlc6UbY5JIYCpKuWW4piaEEGxLU0JbmGug2mspWHy3
	umTm72jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urIOe-0000000FyEg-1MNS;
	Wed, 27 Aug 2025 15:49:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urEUM-0000000FIcg-0QGX
	for kexec@lists.infradead.org;
	Wed, 27 Aug 2025 11:38:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756294728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4etMjBoHFn+n6erGPScH1pkM2ZUCXCdu4tc4puWCOpw=;
	b=cqxI4d8LtLtMUqm5L/9FUaV+mZZkpgsBu1gcQcjO1pO74mNjMqA77QN/EdiIQAuERp4mHC
	Kg19bRSyAhxMgV4pYc9XJVI6haViseRfh8LZDcbtvG08XRbhGvw8hnlVyTByCNwN4swbON
	YZfu512zn/5YHUb0GOgbxCi/dCNzclY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-qWNPhpUiOlegaE8ds_eWKg-1; Wed,
 27 Aug 2025 07:38:45 -0400
X-MC-Unique: qWNPhpUiOlegaE8ds_eWKg-1
X-Mimecast-MFC-AGG-ID: qWNPhpUiOlegaE8ds_eWKg_1756294723
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D27CE19560AA;
	Wed, 27 Aug 2025 11:38:42 +0000 (UTC)
Received: from localhost (unknown [10.72.112.154])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F06E41955F24;
	Wed, 27 Aug 2025 11:38:39 +0000 (UTC)
Date: Wed, 27 Aug 2025 19:38:29 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Coiby Xu <coxu@redhat.com>, Breno Leitao <leitao@debian.org>,
	kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>, Pingfan Liu <kernelfans@gmail.com>,
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 1/8] kexec_file: allow to place kexec_buf randomly
Message-ID: <aK7uNf8n67HQW+hh@MiWiFi-R3L-srv>
References: <20250502011246.99238-1-coxu@redhat.com>
 <20250502011246.99238-2-coxu@redhat.com>
 <oninomspajhxp4omtdapxnckxydbk2nzmrix7rggmpukpnzadw@c67o7njgdgm3>
 <yng55a2z25m5upehczerzhi6zawe3j4ka7amfu4vw4cu27bbg2@x2lgbuk3iqyf>
 <20250825180531.94bfb86a26a43127c0a1296f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825180531.94bfb86a26a43127c0a1296f@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250827_043850_231172_991F9231 
X-CRM114-Status: GOOD (  25.17  )
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

On 08/25/25 at 06:05pm, Andrew Morton wrote:
> On Mon, 25 Aug 2025 09:18:53 +0800 Coiby Xu <coxu@redhat.com> wrote:
> 
> > >diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
> > >index 532d72ea42ee8..287b25e674d76 100644
> > >--- a/arch/arm64/kernel/kexec_image.c
> > >+++ b/arch/arm64/kernel/kexec_image.c
> > >@@ -76,6 +76,7 @@ static void *image_load(struct kimage *image,
> > > 	kbuf.buf_min = 0;
> > > 	kbuf.buf_max = ULONG_MAX;
> > > 	kbuf.top_down = false;
> > >+	kbuf.random = 0;
> > >
> > > 	kbuf.buffer = kernel;
> > > 	kbuf.bufsz = kernel_len;
> > >
> > 
> > And also thanks for posing a fix! The patch LGTM. Can you add a Fixes
> > tag 'Fixes: bf454ec31add ("kexec_file: allow to place kexec_buf
> > randomly")' and then send it to kexec@lists.infradead.org? Thanks!
> 
> I turned all this into a regular patch and queued it (see below),
> thanks.  No additional actions are needed.
> 
> I'm really not liking that code.  I laboriously verified that all
> fields of kexec_buf are now initialized, except for `cma'.  Is that a
> bug?
> 
> This function has a call frequency of about 3x per week.  Can we please
> just memset the whole thing so people don't have to worry about this
> any more?

Yeah, adding these trivial patches to mute XXSAN warning is annoying.
Maybe arm64 can initialize the local variable kbuf like we do in x86_64
as below, to explicitly set the necessary fields when defining.

static void *bzImage64_load(struct kimage *image, char *kernel,
                            unsigned long kernel_len, char *initrd,
                            unsigned long initrd_len, char *cmdline,
                            unsigned long cmdline_len)
{
......
        struct kexec_buf kbuf = { .image = image, .buf_max = ULONG_MAX,
                                  .top_down = true };
        struct kexec_buf pbuf = { .image = image, .buf_min = MIN_PURGATORY_ADDR,
                                  .buf_max = ULONG_MAX, .top_down = true };
.....
}

> 
> 
> From: Breno Leitao <leitao@debian.org>
> Subject: kexec/arm64: initialize the random field of kbuf to zero in the image loader
> Date: Thu Aug 21 04:11:21 2025 -0700
> 
> Add an explicit initialization for the random member of the kbuf structure
> within the image_load function in arch/arm64/kernel/kexec_image.c. 
> Setting kbuf.random to zero ensures a deterministic and clean starting
> state for the buffer used during kernel image loading, avoiding this UBSAN
> issue later, when kbuf.random is read.
> 
>   [   32.362488] UBSAN: invalid-load in ./include/linux/kexec.h:210:10
>   [   32.362649] load of value 252 is not a valid value for type '_Bool'
> 
> Link: https://lkml.kernel.org/r/oninomspajhxp4omtdapxnckxydbk2nzmrix7rggmpukpnzadw@c67o7njgdgm3
> Fixes: bf454ec31add ("kexec_file: allow to place kexec_buf randomly
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Coiby Xu <coxu@redhat.com>
> Cc: "Daniel P. Berrange" <berrange@redhat.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Kairui Song <ryncsn@gmail.com>
> Cc: Liu Pingfan <kernelfans@gmail.com>
> Cc: Milan Broz <gmazyland@gmail.com>
> Cc: Ondrej Kozina <okozina@redhat.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  arch/arm64/kernel/kexec_image.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- a/arch/arm64/kernel/kexec_image.c~kexec-arm64-initialize-the-random-field-of-kbuf-to-zero-in-the-image-loader
> +++ a/arch/arm64/kernel/kexec_image.c
> @@ -76,6 +76,7 @@ static void *image_load(struct kimage *i
>  	kbuf.buf_min = 0;
>  	kbuf.buf_max = ULONG_MAX;
>  	kbuf.top_down = false;
> +	kbuf.random = 0;
>  
>  	kbuf.buffer = kernel;
>  	kbuf.bufsz = kernel_len;
> _
> 


