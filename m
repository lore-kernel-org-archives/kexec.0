Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FC2ECAAA1
	for <kexec@archiver.kernel.org>; Mon, 12 Sep 2022 03:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=foRgB/SBUAJVl4C1ecDXR7UJY5DeS10g+q4uCChl088=; b=FGdZ8aWQo9K3rS
	0HyJV3L//yyM0AEJktRb9JzZYxhI/cgmBnN9/XAkmmbLLXJCcl1FKBdqhtDP488SzR7VpCvNXapEs
	WO6/zfNiL82Q6PXEeCLFOYAWLgLXZmQ54FrAtnPb28DLMrvfO9GDuPDfEgiWLybY2FLU93WojR0xT
	/pitP3VUn0edYkF9xlesQ3RnYDaipehz38p66+5QmMN7Xft+vGpeGzfkaMnLR3NIbJbUfEkwO7voq
	jkzVZ8OdDsudEGHC1/Ib8f6xXIj8PYhX3TgTYYXorH9IeN2p2lluOdPvXAxWNVV1/Lqkcoy9tuw04
	j3Yuq7mgaV0Nqct7bJgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXaQ6-006hKM-BX; Mon, 12 Sep 2022 03:47:38 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXaPw-006hIu-S7
	for kexec@lists.infradead.org; Mon, 12 Sep 2022 03:47:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1662954445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0YI2fZY4L8mJJbSUbUjIEfSD3oHCErBi4sdySSSE2E0=;
	b=P3dJrYnHOAObKpKxiXq6la5JHBfv1hPNXZpB89BYVTlCCegUxlewsZbHUBwpAUvQ+XNX+p
	vbxshlRUUjpluQUvLF8dheLIU8YX08cby9pcq2XUvD3gMCSBreyE8dcjnrOaK5Oieqd2hu
	LzBM45eSoI4WxzykUJ/QKNmduVbwAPU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-544-3HCIQzL1M1ydpu-6_MnOoA-1; Sun, 11 Sep 2022 23:47:20 -0400
X-MC-Unique: 3HCIQzL1M1ydpu-6_MnOoA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BDD1D185A794;
	Mon, 12 Sep 2022 03:47:19 +0000 (UTC)
Received: from localhost (ovpn-12-21.pek2.redhat.com [10.72.12.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C8552026D64;
	Mon, 12 Sep 2022 03:47:18 +0000 (UTC)
Date: Mon, 12 Sep 2022 11:47:14 +0800
From: Baoquan He <bhe@redhat.com>
To: Eric DeVolder <eric.devolder@oracle.com>, bp@alien8.de,
	akpm@linux-foundation.org, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	ebiederm@xmission.com, dyoung@redhat.com, vgoyal@redhat.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	nramas@linux.microsoft.com, thomas.lendacky@amd.com,
	robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
	sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
	boris.ostrovsky@oracle.com
Subject: Re: [PATCH v12 0/7] crash: Kernel handling of CPU and memory hot
 un/plug
Message-ID: <Yx6rwt+nMybIzlAz@MiWiFi-R3L-srv>
References: <20220909210509.6286-1-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220909210509.6286-1-eric.devolder@oracle.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220911_204729_192208_F6E8FBB9 
X-CRM114-Status: GOOD (  17.74  )
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

On 09/09/22 at 05:05pm, Eric DeVolder wrote:
> When the kdump service is loaded, if a CPU or memory is hot
> un/plugged, the crash elfcorehdr, which describes the CPUs
> and memory in the system, must also be updated, else the resulting
> vmcore is inaccurate (eg. missing either CPU context or memory
> regions).
> 
> The current solution utilizes udev to initiate an unload-then-reload
> of the kdump image (e. kernel, initrd, boot_params, puratory and
> elfcorehdr) by the userspace kexec utility. In previous posts I have
> outlined the significant performance problems related to offloading
> this activity to userspace.
> 
> This patchset introduces a generic crash hot un/plug handler that
> registers with the CPU and memory notifiers. Upon CPU or memory
> changes, this generic handler is invoked and performs important
> housekeeping, for example obtaining the appropriate lock, and then
> invokes an architecture specific handler to do the appropriate
> updates.
> 
> In the case of x86_64, the arch specific handler generates a new
> elfcorehdr, and overwrites the old one in memory. No involvement
> with userspace needed.

Thank a lot for all the effort, Eric.

Hi Boris, Andrew,

This version looks good to me. It introduces a framework for kdump
to react mem/cpu hotplug eveut and add x86 handler. Should this go
to x86 tree or mm tree? Please check what else we need do to fix or
improve.

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
