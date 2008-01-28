Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JJbXW-0001rN-6x
	for kexec@lists.infradead.org; Mon, 28 Jan 2008 21:29:21 +0000
Received: from Relay2.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 13F6C27640
	for <kexec@lists.infradead.org>; Mon, 28 Jan 2008 22:29:11 +0100 (CET)
Date: Mon, 28 Jan 2008 22:29:10 +0100
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: Kexec command line length
Message-ID: <20080128212910.GA21889@suse.de>
References: <20080125153924.GA13287@redhat.com> <479A03DD.5030308@zytor.com>
	<20080125195058.GE28683@hmsendeavour.rdu.redhat.com>
	<20080125201305.GG13287@redhat.com>
	<20080125205450.GG28683@hmsendeavour.rdu.redhat.com>
	<20080128170811.GA1174@hmsreliant.think-freely.org>
	<20080128193741.GB32765@redhat.com>
	<20080128200702.GB1174@hmsreliant.think-freely.org>
	<20080128202041.GD32765@redhat.com>
	<20080128205324.GC1174@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080128205324.GC1174@hmsreliant.think-freely.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

* Neil Horman <nhorman@tuxdriver.com> [2008-01-28 21:53]:
>  		return -1;
>  	}
>  
> +	if (setup_header.protocol_version >= 0x0206) {
> +		if (command_line_len > setup_header.cmdline_size) {
> +			dbgprintf("Kernel command line too long for kernel!\n");
> +			return -1;
> +		}
> +	}
> +
>  	if (setup_header.protocol_version >= 0x0205) {
>  		relocatable_kernel = setup_header.relocatable_kernel;
>  		dbgprintf("bzImage is relocatable\n");

I know that there was a kernel release with 2048 _and_ still the old
boot protocol, but wouldn't it be better to warn the user if the size
is beyond 256 and the old kernel is used? I think new kexec-tools
should still support old kernels without problems ...



        Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
