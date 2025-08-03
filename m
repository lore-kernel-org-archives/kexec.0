Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81EC6C87FCA
	for <kexec@archiver.kernel.org>; Sun,  3 Aug 2025 06:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EoOkZOeOKNBWaDehCjjVCVpOpwcj59N5p8x5bREgwH8=; b=RaA0LVXccSzfjzV7it0kYKTaU7
	MUC1PyseE3AyHZNv8/TmZJ2P7tHlbGt4MvernBIc+5/SgM4ucg7VxNe1FYvWbEek0C9kiL4iHMy4F
	UlAaoOx7jUNRi4bbARRl4yw+i9nlDue0pK7rMek56Y4uF1mTk1Wgc8MJx+Emg/EmwNa5U6cNPBjdr
	Qfyf9IlByCl5N2uiDmkP6XbN0NwF0YpU5Y6YVN4Fa2nWBJJpXJ6ptf14lcs7+va0fZLsbOLZHXsaR
	3q9Ziyd0pnnURhEK6vc0Fq9LifDjdsYMxJKuAbCtfeX3yN/dKxUbtTXBKbprfzkOsl8GT5xUoY7RG
	AfIteCHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uiSIt-00000008SHL-1M2F;
	Sun, 03 Aug 2025 06:34:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uiPys-00000008A74-0M8J
	for kexec@lists.infradead.org;
	Sun, 03 Aug 2025 04:05:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754193949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EoOkZOeOKNBWaDehCjjVCVpOpwcj59N5p8x5bREgwH8=;
	b=CU+s+lunm33M7QxsLyIgHs3Ug2BuGiN77IiggvEmfm/x1pgG7IQqtQglriRLi9tY+c9nKE
	dHcPisW3TZL5s5OP7VtNw/XPCcfDQ4V1lH0UlbawIBhTLETtywccXvnOhWn6LwKH4pvAsQ
	XMVBnFV3YwXVa7diseKy9tlwkdjFTbc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-95tvEVS2PE-gfrSu9SPQRw-1; Sun,
 03 Aug 2025 00:05:43 -0400
X-MC-Unique: 95tvEVS2PE-gfrSu9SPQRw-1
X-Mimecast-MFC-AGG-ID: 95tvEVS2PE-gfrSu9SPQRw_1754193934
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 55423195609D;
	Sun,  3 Aug 2025 04:05:33 +0000 (UTC)
Received: from localhost (unknown [10.72.112.43])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 82EB63000199;
	Sun,  3 Aug 2025 04:05:30 +0000 (UTC)
Date: Sun, 3 Aug 2025 12:05:26 +0800
From: Baoquan He <bhe@redhat.com>
To: Brian Mak <makb@juniper.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] x86/kexec: Carry forward the boot DTB on kexec
Message-ID: <aI7gBld/+yKQ2EXM@MiWiFi-R3L-srv>
References: <20250729182142.4875-1-makb@juniper.net>
 <aIwuSFKSUJDI6ULl@MiWiFi-R3L-srv>
 <5A9FE2FF-800A-4458-9929-124EB89FE1D9@juniper.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A9FE2FF-800A-4458-9929-124EB89FE1D9@juniper.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250802_210554_367373_F1AD0F1E 
X-CRM114-Status: GOOD (  21.82  )
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

On 08/01/25 at 07:24pm, Brian Mak wrote:
> On Jul 31, 2025, at 8:02 PM, Baoquan He <bhe@redhat.com> wrote:
> 
> > On 07/29/25 at 11:21am, Brian Mak wrote:
> >> The kexec_file_load syscall on x86 currently does not support passing
> >> a device tree blob to the new kernel.
> >> 
> >> To add support for this, we copy the behavior of ARM64 and PowerPC and
> >> copy the current boot's device tree blob for use in the new kernel. We
> >> do this on x86 by passing the device tree blob as a setup_data entry in
> >> accordance with the x86 boot protocol.
> > 
> > I see how, but no why. Why do we need to add DTB for x86?
> 
> Hi Baoquan,
> 
> Thanks for your comment. Some embedded x86 systems, such as ours at
> Juniper, use device trees. Currently, the x86 kexec_file_load syscall
> has no support for passing the device tree to the new kernel, which is a
> problem for us since we use kexec for some software upgrade related
> features. Not passing a device tree to the new kernel would cause a boot
> failure here.

Thanks for the info. Please add these into patch log to let reviewers
know them. We don't add code w/o objective.


