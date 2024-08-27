Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2EB6C54742
	for <kexec@archiver.kernel.org>; Tue, 27 Aug 2024 22:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=N8uCbmnfLHmpyBQ6SMs5vs2dCAuohLde08I0OjzkU7A=; b=HIDTY5PwjTMQL5
	g/113JQ9yhkURPDv4YHntWJ2A/6rsdY1pnTDiNAoltwb42BYsZE++uR7oKx9EbzH8pX98L0FTBHys
	sJfSDVMn1hA3JlClAX7160Y+YAEZe+HOjiO5PqiP8d/tqARtOR/c9CO3br1oVsgtaUUqyKZZKEDXs
	uZYTO0n2BTVN6Mq404nMgOEHZwleUKBB2nJqsGMwQhHqNaJ8XVRwxZ3Sbj06a7z0UhnQjolIzO3yk
	v2gJKoiCaZmh4jrC5n+z5xOg5Eg/j0fUV0Ofy1Co77QFFcKesuPK9FcfwWxNNaSLBIG9O7TQcaTQA
	LJzSIWJGjgK9ZqAIFMBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sj4rK-0000000D2m1-1WQ6;
	Tue, 27 Aug 2024 22:40:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sj4rH-0000000D2kq-446q
	for kexec@lists.infradead.org;
	Tue, 27 Aug 2024 22:40:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724798414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NmdBAM2JtkvTbDIIpL2at1ANoYfOw4zWq0b3hsBM2zc=;
	b=VDBeAjvPBTRQ6wP5H+wi3I0nHnyJQo7iQeiMD4SwCEvncUjkJ1iGuI7Fjbi0iZHj5JCnOG
	RqP5JxS5LCGTTrGUCrTtJjYfxnY2Ya3wHv0NEf9asDxiepWUsmHWHYTJmVq7JgxgtJM9jB
	wRhRnxsN2fbiRRAGnGfG1vUPAUY8MvU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-9FifvTB6P1S61EsS22p3Ag-1; Tue,
 27 Aug 2024 18:40:09 -0400
X-MC-Unique: 9FifvTB6P1S61EsS22p3Ag-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 813EC19560A2;
	Tue, 27 Aug 2024 22:40:08 +0000 (UTC)
Received: from localhost (unknown [10.72.112.42])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A5F6C1956054;
	Tue, 27 Aug 2024 22:40:06 +0000 (UTC)
Date: Wed, 28 Aug 2024 06:40:02 +0800
From: Baoquan He <bhe@redhat.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, noodles@fb.com, x86@kernel.org,
	lijiang@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org
Subject: Re: [PATCH] x86/mm/sme: fix the kdump kernel breakage on SME system
 when CONFIG_IMA_KEXEC=y
Message-ID: <Zs5VwrKVetWFkYmR@MiWiFi-R3L-srv>
References: <20240826024457.22423-1-bhe@redhat.com>
 <35e40987-1541-cbbe-6b16-1ddadc2c4c35@amd.com>
 <Zs1FrZVuZK14Je7z@MiWiFi-R3L-srv>
 <be6e5ab6-8b43-1a3f-39a6-b4aa5e0523ac@amd.com>
 <ac929075-27a3-8cbd-5ffd-966ea3e82697@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ac929075-27a3-8cbd-5ffd-966ea3e82697@amd.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240827_154016_121614_EFDBF845 
X-CRM114-Status: GOOD (  23.37  )
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

On 08/27/24 at 09:00am, Tom Lendacky wrote:
> On 8/27/24 08:52, Tom Lendacky wrote:
> > On 8/26/24 22:19, Baoquan He wrote:
> >> On 08/26/24 at 09:24am, Tom Lendacky wrote:
> >>> On 8/25/24 21:44, Baoquan He wrote:
> >>>> Recently, it's reported that kdump kernel is broken during bootup on
> >>>> SME system when CONFIG_IMA_KEXEC=y. When debugging, I noticed this
> >>>> can be traced back to commit ("b69a2afd5afc x86/kexec: Carry forward
> >>>> IMA measurement log on kexec"). Just nobody ever tested it on SME
> >>>> system when enabling CONFIG_IMA_KEXEC.
> >>>>
> >>>>
> >>>> Here fix the code bug to make kexec/kdump kernel boot up successfully.
> >>>>
> >>>> Fixes: 8f716c9b5feb ("x86/mm: Add support to access boot related data in the clear")
> >>>
> >>> The check that was modified was added by:
> >>> 	b3c72fc9a78e ("x86/boot: Introduce setup_indirect")
> >>>
> >>> The SETUP_INDIRECT patches seem to be the issue here.
> >>
> >> Hmm, I didn't check it carefully, thanks for addding this info. While
> >> after checking commit b3c72fc9a78e, I feel the adding code was trying to
> >> fix your original early_memremap_is_setup_data(). Even though
> >> SETUP_INDIRECT type of setup_data has been added, the original
> >> early_memremap_is_setup_data() only check the starting address and
> >> the content of struct setup_data, that's obviously wrong.
> > 
> > IIRC, when this function was created, the value of "len" in setup_data
> > included the length of "data", so the calculation was correct. Everything
> > was contiguous in a setup_data element.
> > 
> >>
> >> arch/x86/include/uapi/asm/setup_data.h:
> >> /* extensible setup data list node */
> >> struct setup_data {
> >>         __u64 next;
> >>         __u32 type;
> >>         __u32 len;
> >>         __u8 data[];
> >> };
> >>
> >> As you can see, the zero-length will embed the carried data which is
> >> actually expected and adjacent to its carrier, the struct setup_data.
> > 
> > Right, and "len" is the length of that data. So paddr + len goes to the
> > end of the overall setup_data.
> 
> Ah, I see what you're saying. "len" doesn't include the size of the
> setup_data structure, only the data. If so, then, yes, adding a sizeof()
> to the calculation in the if statement is correct.

Exactly. That could confuse people sometime.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
