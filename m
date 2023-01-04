Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A00C4708D
	for <kexec@archiver.kernel.org>; Wed,  4 Jan 2023 03:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OXfE+3+YwwDDxpZoLXxZf6I5SiKksa5N2JYRQHsRpxo=; b=sqdwn3nlyWjIrs
	TFUlY2oUvDRYRGPhbV2nBdaRL6NLdJCLzTbwoZFXCj5bVG/+qrdzBa0d7ijd/eXLW4vwhKR39udT5
	Ycr4qLc32aImuVQ5VaKz8F5SdUP5xYZrcwuJamb6qdimEroa4eKkTUSVQ1kkLnzexgUkT3SI4WBxa
	ZNYJy96QnWC5Zs1kixhQTtsx5K+jOV3nSwZgjtzYlkCaHmokv/ijZwf/ByGRXunnNhgzrJlEg4gGr
	DOyCNTOltPkDpuHW4WiDMJgWe9u6sIHUMmbvaqYsyQIhXCKNO1BJ/FonZgZqJc2KsU03QjPBCRNjV
	VzIuQLXbwby5Nq8TVu+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCuLC-006YRN-3b; Wed, 04 Jan 2023 03:21:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCuL7-006YQK-TW
	for kexec@lists.infradead.org; Wed, 04 Jan 2023 03:21:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1672802473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a0EYPdegMv2Qzzqky790rw/FkqITGzxXVxGnFBGqkRE=;
	b=Qs/OyH8DIesngML/zN6HXQvBUS9Eubm7jOfXHcc+JuiGuqcOpU9MyAjPc7QmfV486dcp08
	b9Ajp6uT+zRH/r5S234JqisAf3S1QjZLDEz50QFq1NCVMeaqpoEJ6uDJNUspUwup6UyWWp
	t6Q/yE/LlSG5XkJsNisVYaE0UG6Wg/k=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-132-8xHK1lY2PtyCeW7JVIIdsA-1; Tue, 03 Jan 2023 22:21:08 -0500
X-MC-Unique: 8xHK1lY2PtyCeW7JVIIdsA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 017E129ABA17;
	Wed,  4 Jan 2023 03:21:08 +0000 (UTC)
Received: from localhost (ovpn-12-189.pek2.redhat.com [10.72.12.189])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BC5B02026D68;
	Wed,  4 Jan 2023 03:21:06 +0000 (UTC)
Date: Wed, 4 Jan 2023 11:21:03 +0800
From: Baoquan He <bhe@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Eric Biederman <ebiederm@xmission.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] kexec: Remove unnecessary arch hook
Message-ID: <Y7TwnyixithmnizI@MiWiFi-R3L-srv>
References: <20221215182339.129803-1-helgaas@kernel.org>
 <Y6KiH2Nf/hMiaPmD@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y6KiH2Nf/hMiaPmD@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230103_192118_234531_B3382817 
X-CRM114-Status: GOOD (  14.74  )
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

Hi Ingo, Boris,

On 12/21/22 at 02:05pm, Baoquan He wrote:
> On 12/15/22 at 12:23pm, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > There are no arch-specific things in arch_kexec_kernel_image_load(), so
> > remove it and just use the generic version.
> 
> This patchset looks good to me, thx.
> 
> Acked-by: Baoquan He <bhe@redhat.com>
> 
> Since it cleans up the last arch specific version of
> arch_kexec_kernel_image_load in x86, maybe this patchset can go into x86
> branch?

Could you consider picking this patchset into x86 branch? This is a
clean up on kexec, while the last ARCH using it is x86.

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
