Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34B4C6FD18
	for <kexec@archiver.kernel.org>; Wed, 19 Apr 2023 00:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wZ8Umk+aXtUqXSfZ1jHCksvh1u6G39+zl2llqfjaBeo=; b=jNWEtkB5p4J9FK
	F8nDxPDZ9ApEuGzA6hfYCBfOfcHQyEmYa87cCBzbEP5SFaMpmJ7U2xQHKXHYd/Tn03dxi4CgAmYFs
	POAiASf19FmAUza3X2NIJNMswSfkjFO+8SC2Z3+gttkri5JK6ODZDN5kVOtjsQzBe43hjPw/NS7mb
	UwENAp7OAs/6uspN8cF44hGGzJGIeirwzk/JHCUqGja5NGZVZinXbjANZ9tn2257IXkYiBfedStjk
	jEKyWfqS1pviiVLaN4iUGifAwhBLNZp9qcMlLjkhJuPeL/q5JzRxG5wtD713ypo5cNEGIeA53Z1BE
	wzHzo6OFhsVZmi6xganQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1povKH-003cxm-20;
	Wed, 19 Apr 2023 00:05:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1povKC-003cx4-1T
	for kexec@lists.infradead.org;
	Wed, 19 Apr 2023 00:05:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1681862725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iqYcQJ7RxHLqq2m5mcHetAO2yttoUlP/01PDG9Z2dnM=;
	b=h2q2iIt/FqmMw5DMh4+BJT3Fj9Ee6vWwRfm0D3BvgmRFT9ZXK0OfefUoRedG7Tnwx4h2iX
	dnZ5G4pK4TfaKCKcmsCn+1+P0sC/VSNlWAblC+HGC/jIVKtmvQ8QrgkU11epPNYCHUad91
	e4VEaFMhXRGhz58fWVwWE5mkmDZSDi8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-lhN3jzYlOMG7_cdy7DrwjA-1; Tue, 18 Apr 2023 20:05:22 -0400
X-MC-Unique: lhN3jzYlOMG7_cdy7DrwjA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 81B788996E0;
	Wed, 19 Apr 2023 00:05:21 +0000 (UTC)
Received: from localhost (ovpn-12-26.pek2.redhat.com [10.72.12.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 434E12958;
	Wed, 19 Apr 2023 00:05:20 +0000 (UTC)
Date: Wed, 19 Apr 2023 08:05:16 +0800
From: Baoquan He <bhe@redhat.com>
To: Eric DeVolder <eric.devolder@oracle.com>, bp@alien8.de, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	ebiederm@xmission.com, dyoung@redhat.com, vgoyal@redhat.com,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
	robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
	sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
	boris.ostrovsky@oracle.com
Subject: Re: [PATCH v21 2/7] crash: add generic infrastructure for crash
 hotplug support
Message-ID: <ZD8wPOPxvh7cGJun@MiWiFi-R3L-srv>
References: <20230404180326.6890-1-eric.devolder@oracle.com>
 <20230404180326.6890-3-eric.devolder@oracle.com>
 <ZC6nWzPuIWOxmvv2@MiWiFi-R3L-srv>
 <80767ccc-ffd4-9cb9-44e4-a8d4f0e13853@oracle.com>
 <ZC9cp5RLyNNx0DMG@MiWiFi-R3L-srv>
 <7b25449b-72e9-3eca-73a9-592d7400b746@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7b25449b-72e9-3eca-73a9-592d7400b746@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_170528_584707_23D27C3D 
X-CRM114-Status: GOOD (  36.45  )
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

On 04/18/23 at 08:55am, Eric DeVolder wrote:
......
> > > > Seems we passed in the cpu number just for printing here. Wondering why
> > > > we don't print out hot added/removed memory ranges. Is the cpu number
> > > > printing necessary?
> > > > 
> > > Baoquan,
> > > 
> > > Ah, actually until recently it was used to track the 'offlinecpu' in this
> > > function, but tglx pointed out that was un-necessary. That resulted in
> > > dropping the code in this function dealing with offlinecpu, leaving this as
> > > its only use in this function.
> > > 
> > > The printing of cpu number is not necessary, but helpful; I use it for debugging.
> > 
> > OK, I see. I am not requesting memory range printing, just try to prove
> > cpu number printing is not so justified. If it's helpful, I am OK with
> > it. Let's see if other people have concern about this.
> > 
> 
> I do not plan on adding the memory range printing.
> 
> > > 
> > > The printing of memory range is also not necessary, but in order to do that,
> > > should we choose to do so, requires passing in the memory range to this
> > > function. This patch series did do this early on, and by v7 I dropped it at
> > > your urging (https://lore.kernel.org/lkml/20220401183040.1624-1-eric.devolder@oracle.com/).
> > > At the time, I provided it since I considered this generic infrastructure,
> > > but I could not defend it since x86 didn't need it. However, PPC now needs
> > > this, and is now carrying this as part of PPC support of CRASH_HOTPLUG (https://lore.kernel.org/linuxppc-dev/20230312181154.278900-6-sourabhjain@linux.ibm.com/T/#u).
> > > 
> > > If you'd rather I pickup the memory range handling again, I can do that. I
> > > think I'd likely change this function to be:
> > > 
> > >    void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
> > >       struct memory_notify *mhp);
> > > 
> > > where on a CPU op the 'cpu' parameter would be valid and 'mhp' NULL, and on a memory op,
> > > the 'mhp' would be valid and 'cpu' parameter invalid(0).
> > > 
> > > I'd likely then stuff these two parameters into struct kimage so that it can
> > > be utilized by arch-specific handler, if needed.
> > > 
> > > And of course, would print out the memory range for debug purposes.
> > > 
> > > Let me know what you think.
> > 
> 
> I do not plan on adding the memory range handling; I'll let Sourabh do that as he has a use case for it.
> 
> As such, I don't see any other request for changes.

OK, then I have no concern about this patchset. Thanks a lot for all
these effort, Eric.

Hi x86 maintainers,

Could you help check if there's anything we need improve, or consider
taking this patchset?

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
