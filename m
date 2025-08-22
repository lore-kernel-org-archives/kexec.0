Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B8D0CA0EFC
	for <kexec@archiver.kernel.org>; Fri, 22 Aug 2025 11:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/v92R0GOhuNAlhtlX1z69+cdYEAGYV7imOq4xj8OFbg=; b=1CGJlQxQUPF1FQ/UGEmGWGiLYa
	1O0mQRib6pzc9i5SE7LVa6b28+1UNuiMOOasoDBuejs9rU3YVATnGFKbQ3TRwTlLSt21yk88Nbv3E
	rZDWBHz40n2TqMSQuemyDD8sQhwq48NRHrsyoqO/rmOIDdCAD3B3sqQL6UIlrbTaPe1spTZHYdGGC
	2AQbZzZjubpGBl7oMd+YxMYNG3G9wpbqpOOBY2RZ1JoVDEWLqpFByypp0D9xOJqvMO3vp7pv7Iuce
	UvwUbZlLLoDo/DwM9AthhEGF6hI0vzvWbRS0H0IbWOX663RUjWf9RoIhxT5uvIv6g3bNPfUCRH5Kk
	8FLAOfSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upPrh-00000002JYF-0Ny8;
	Fri, 22 Aug 2025 11:23:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upIq3-00000001RyW-0gVK
	for kexec@lists.infradead.org;
	Fri, 22 Aug 2025 03:53:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755834794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/v92R0GOhuNAlhtlX1z69+cdYEAGYV7imOq4xj8OFbg=;
	b=L73pIcUYOQnDGJ9xP4NFsyFsRI5m5MwTVvHDp9+d7yM+pZw0cQMcUfpi9jVm1wgZS1E0ia
	wfTJyBGEoL1HV2NZnKHfdNjh1eZHN/gW3J/M93wX8Zp9RCeGgx12NCRN2zQsdNXMek+9pp
	BVTG3liqoIvMqRE0axGUYfvDUz3v2SU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-HVsgRoUwOAes3u9ZKsC-zQ-1; Thu,
 21 Aug 2025 23:53:10 -0400
X-MC-Unique: HVsgRoUwOAes3u9ZKsC-zQ-1
X-Mimecast-MFC-AGG-ID: HVsgRoUwOAes3u9ZKsC-zQ_1755834789
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ECC4C1956086;
	Fri, 22 Aug 2025 03:53:08 +0000 (UTC)
Received: from localhost (unknown [10.72.112.99])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A6E218004A3;
	Fri, 22 Aug 2025 03:53:06 +0000 (UTC)
Date: Fri, 22 Aug 2025 11:53:02 +0800
From: Baoquan He <bhe@redhat.com>
To: Usama Arif <usamaarif642@gmail.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, paulmck@kernel.org,
	leitao@debian.org, kernel-team@meta.com
Subject: Re: [RFC] kexec: Add bootconfig support to get_command_line
Message-ID: <aKfpnjjKU23JNFO2@MiWiFi-R3L-srv>
References: <20250811153736.3865487-1-usamaarif642@gmail.com>
 <aKaSRJ9HGNR07Svl@MiWiFi-R3L-srv>
 <f24af1e6-509a-4a36-8b7d-0188b3a2e9e2@gmail.com>
MIME-Version: 1.0
In-Reply-To: <f24af1e6-509a-4a36-8b7d-0188b3a2e9e2@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TXByxS8L-l6v6dum2JT8Eb5btPdQO7XBQCcUUZKYsUk_1755834789
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_205315_274789_9F49C501 
X-CRM114-Status: GOOD (  28.69  )
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

On 08/21/25 at 12:32pm, Usama Arif wrote:
> 
> 
> On 21/08/2025 04:28, Baoquan He wrote:
> > Hi,
> > 
> > On 08/11/25 at 04:37pm, Usama Arif wrote:
> >> If the kernel is enabled with CONFIG_BOOT_CONFIG_FORCE, it will
> >> always append the bootconfig at the start of the kernel commandline.
> >> If reuse-cmdline option is used in kexec, the bootconfig will be
> >> repeatedly appended at the start of the commandline on every kexec.
> >> As there is a limit on the size of kernel commandline that can be
> >> used, --reuse-cmdline option will break kexec depending on the
> >> size of bootconfig on repeated kexec.
> >>
> >> Bootconfig is embedded in the kernel, so it should not be considered
> >> when reusing kernel command line.
> >> Modify get_command_line() to first attempt reading kernel parameters
> >> from /proc/bootconfig before falling back to /proc/cmdline. This allows
> >> kexec to use the original boot parameters without bootconfig which
> >> is embedded in the kernel.
> > 
> > Thanks for the great fix. While I have some questions about the change.
> > 
> > 1, if we can read kernel parameters from /proc/bootconfig, does it mean
> >    we will skip other kernel parameters, e.g I set some parameters in
> >    grub, meanwhile set bootconfg? Is this allowed?
> 
> Hi Baoquan,
> 
> Thanks for the questions.
> 
> /proc/bootconfig treats the parameters from bootconfig separate from the rest.
> i.e. parameters from grub will be coming after "# Parameters from bootloader:"
> in /proc/bootconfig. It shouldn't skip grub parameters. For e.g. on my machine
> 
> cat /proc/bootconfig 
> kernel.csdlock_debug = "1"
> kernel.mitigations = "off"
> # Parameters from bootloader:
> # crashkernel=.....
> 
> 
> kernel.csdlock_debug = "1"
> kernel.mitigations = "off"
> comes from bootconfig, while the crashkernel and the rest come from bootloader [1]
> 
> [1] https://elixir.bootlin.com/linux/v6.16.1/source/Documentation/filesystems/proc.rst#L739
> 
> > 
> > 2. If /proc/bootconfig includes the whole kernel parameters of the
> >    runnign kernel, setup_boot_config() will parse and append bootconfig
> >    to kernel cmdline again, right? But it doesn't matter.
> 
> /proc/bootconfig contains the whole parameters, but the bootconfig is seperated by "# Parameters from bootloader:".
> If we repeatedly kexec using /proc/cmdline, we will continuously append bootconfig,
> and wont be able to kexec anymore once the commandline gets too big..

I see, then it should be OK. I thought /proc/bootconfig only contains
the content of bootconfig, and was worried about the incomplete kernel
cmdline passing to 2nd kernel. Thanks for the explanation.

For the patch,

Acked-by: Baoquan He <bhe@redhat.com>


