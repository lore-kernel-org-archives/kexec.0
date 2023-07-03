Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC878EB64DC
	for <kexec@archiver.kernel.org>; Mon,  3 Jul 2023 13:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uE1WSuePdpj0TkBHKxrQY2ftUA6AARPpwf1hLcJixD0=; b=Kr9h2aCP25Mq+t
	0U9Pg3RqzQ21ilYCNYqRWI79zmhyWKAUk26ms+padPfBwZsnND8EDg7dMfOLoQEYHV6N4lD/9oTw4
	uF/8HF6FRr9CiHFvj8jzqBKyT0rAftTu/nfwRwip9JYdAxol025vJEANIgr5W3HCkUkmvYHVFnL+2
	23+S27epOzcJ64UQrFKY8fXJ3NjVS250BcHfE9wd6Irw/bj40DQoUP9hS4qTE3eD2Gb+HJJkVePRP
	9Xyf3G2vXgi8hZcf+KlI11VKOk/GUhxBNDSYBUrRHthkfKIKghgq1phsM/XQ3UTMZSZLghQGfcgv1
	AdSmZo0TkBdexcypMcgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGJIL-00AaeP-2V;
	Mon, 03 Jul 2023 13:08:45 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGJII-00AadU-2p
	for kexec@lists.infradead.org;
	Mon, 03 Jul 2023 13:08:44 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D1CDF60F25;
	Mon,  3 Jul 2023 13:08:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795CDC433C8;
	Mon,  3 Jul 2023 13:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1688389721;
	bh=ypbcj87dPUAw9tzLtO/umPTpb2y3vCv6n+L9rNnzz58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xLr+Vuydj3zwqtXJDbof6qt1egJsCwGG7z1JqapZix5T/n6ja+Kwo8KTGK/Y2hItD
	 6KKa493JijPBeliZnn61IYNmRt9cFvJej2Vrmki4L6PeJItT/MixQmRQzIeTPVpLDl
	 fAvq9kslDMfoChfvyLMM2g2U7ug/P0An5+tF9UYc=
Date: Mon, 3 Jul 2023 15:05:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
	corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
	ebiederm@xmission.com, kexec@lists.infradead.org, hpa@zytor.com,
	rafael@kernel.org, vgoyal@redhat.com, dyoung@redhat.com,
	lf32.dev@gmail.com, akpm@linux-foundation.org,
	naveen.n.rao@linux.vnet.ibm.com, zohar@linux.ibm.com,
	bhelgaas@google.com, vbabka@suse.cz, tiwai@suse.de,
	seanjc@google.com, linux@weissschuh.net, vschneid@redhat.com,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
	boris.ostrovsky@oracle.com
Subject: Re: [PATCH v25 01/10] drivers/base: refactor cpu.c to use
 .is_visible()
Message-ID: <2023070342-human-spill-a62c@gregkh>
References: <20230629192119.6613-1-eric.devolder@oracle.com>
 <20230629192119.6613-2-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230629192119.6613-2-eric.devolder@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_060842_961727_5A7141D0 
X-CRM114-Status: GOOD (  11.11  )
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

On Thu, Jun 29, 2023 at 03:21:10PM -0400, Eric DeVolder wrote:
>  - the function body of the callback functions are now wrapped with
>    IS_ENABLED(); as the callback function must exist now that the
>    attribute is always compiled-in (though not necessarily visible).

Why do you need to do this last thing?  Is it a code savings goal?  Or
something else?  The file will not be present in the system if the
option is not enabled, so it should be safe to not do this unless you
feel it's necessary for some reason?

Not doing this would make the diff easier to read :)

thanks,

greg k-h

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
