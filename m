Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB10C54EBD
	for <kexec@archiver.kernel.org>; Mon,  9 Jan 2023 01:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XiqYjKoFcD5mb2v0uqFxCBkbRN1vw6NCbHq7Sq2DBXU=; b=NFOyPMD57a0G2l
	YuXewV/jZmgRtwCY6CaVRiO5+OMKlA+d25swbo2GZxINkA2Ari6b/Oyb6/XCpVCHHiwhW8sRBzebe
	HDXTMtmKfR/cmtUTi6m29LH0A+0YSMoaPn57nXKXcaSmwahzICJrWrq+eGzDtDvbaeLEFOvnbUylA
	bPR6UUZnE/Zt5kUAHl/L7Il/VT04viZHVC4YX+wqSQyM8bkA1GAOfFZsYrHhjuK3ZlXjETftXDENd
	38I/jHevKMhk4DYehUhynVK05Dkc1U1BAm4hln2Cum21CgvvHkqCKM+OI92jJJPdfVSmAsCYQ2TYA
	qKSxOFFilcDS1zWzncwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEh81-00GgkY-Pj; Mon, 09 Jan 2023 01:39:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEh7z-00GgjQ-CY
	for kexec@lists.infradead.org; Mon, 09 Jan 2023 01:39:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1673228342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RbPb+qIwZD/rIeCEnssQ21f/8PvH6fuTvr/C+at4VEc=;
	b=GBklWILG2zj2sCDwmP7lddHvQQl20gi6Pnc3biZIZUCA7wPs/sQiRXoG4uTjpyCLCokuXq
	Z0Ye8A+XzmnzqBawhfImzrd4NUspSeKNHZkeNcRsnfDe7BVQVXj3tqqLAXPg/aTttIkB8/
	8DMJ48i3bPXTxQ6Jb6494J4MNcmjXFA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19-JZe4po0bMd-JNDuHmhStsA-1; Sun, 08 Jan 2023 20:38:58 -0500
X-MC-Unique: JZe4po0bMd-JNDuHmhStsA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 465F4802D1A;
	Mon,  9 Jan 2023 01:38:57 +0000 (UTC)
Received: from localhost (ovpn-13-135.pek2.redhat.com [10.72.13.135])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 01CEE39DCA;
	Mon,  9 Jan 2023 01:38:55 +0000 (UTC)
Date: Mon, 9 Jan 2023 09:38:51 +0800
From: Baoquan He <bhe@redhat.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Eric Biederman <ebiederm@xmission.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] kexec: Remove unnecessary arch hook
Message-ID: <Y7twK57xddLROyW5@fedora>
References: <20221215182339.129803-1-helgaas@kernel.org>
 <Y6KiH2Nf/hMiaPmD@MiWiFi-R3L-srv>
 <Y7TwnyixithmnizI@MiWiFi-R3L-srv>
 <e587eebc-5f28-0a63-9200-b67ba20ea347@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e587eebc-5f28-0a63-9200-b67ba20ea347@intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230108_173907_669591_4E412D7A 
X-CRM114-Status: GOOD (  13.21  )
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

On 01/04/23 at 10:37am, Dave Hansen wrote:
> On 1/3/23 19:21, Baoquan He wrote:
> >> Since it cleans up the last arch specific version of
> >> arch_kexec_kernel_image_load in x86, maybe this patchset can go into x86
> >> branch?
> > Could you consider picking this patchset into x86 branch? This is a
> > clean up on kexec, while the last ARCH using it is x86.
> 
> I'll stick it in my queue to take a closer look.

Thanks.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
