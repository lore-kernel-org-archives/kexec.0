Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E246EB64DD
	for <kexec@archiver.kernel.org>; Mon,  3 Jul 2023 13:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NKx7c/o+vFZNNLfEI3QjuQvDWCc0VjwhEfsmuc+cW9o=; b=NuNWlImIQruyfX
	zBD0dIBeCOg+8beHL8c6X56vIqNWWXo29g2XtBtw5IYh5J39cA7PlN3Eh5gNInarGc1+6X8ZtM3wz
	rZjjK8RI/nJc4XWXi8MUhXHqy42aO+Xe4rulD+2fxVVX6/FtIvsNjkIf+FGYNTqEvw0SgCSxsLW6e
	oe2KsPgN2FbiXevVv99rR2s+ZP74BOexFRZQOiX5YaJzth7HODCACNNkfJFAjbiZeN7SH/vfQAeRQ
	ektNcRLmfb/DZlfjcd2+Ri1BJNWcrobkNwUnWUtZRXDgsUHelc68tGsol+wogXMUwKNjNlghnitjh
	uKXWcxEpfNj55Mk7IEXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGJJ2-00Aakz-17;
	Mon, 03 Jul 2023 13:09:28 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGJIz-00AakG-23
	for kexec@lists.infradead.org;
	Mon, 03 Jul 2023 13:09:26 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id AA83260F1B;
	Mon,  3 Jul 2023 13:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BCBC433C8;
	Mon,  3 Jul 2023 13:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1688389764;
	bh=T7Ufr/yUXiAraO8aEPf0fd3IynmqDCJjXf6AnGN17u4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FstFVqiOOub0QPkzlTWmoa1ngU2Y+dI3ygdxBmCXB7XXduSXAruOW4Gq/vlTZMAU/
	 5xExvyfrJN7N+2ZKKjTxU/83uaQ7BBhhboo59yTT/Sv4cOZkAP+P3iA38ftBNgTEoJ
	 NOogCkM7yMaevmyWa0boAN22Gx6dQUoJm1DETK4c=
Date: Mon, 3 Jul 2023 15:07:29 +0200
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
Subject: Re: [PATCH v25 06/10] crash: memory and CPU hotplug sysfs attributes
Message-ID: <2023070359-saline-unsolved-3a99@gregkh>
References: <20230629192119.6613-1-eric.devolder@oracle.com>
 <20230629192119.6613-7-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230629192119.6613-7-eric.devolder@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_060925_716472_E34AF02A 
X-CRM114-Status: UNSURE (   7.32  )
X-CRM114-Notice: Please train this message.
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

On Thu, Jun 29, 2023 at 03:21:15PM -0400, Eric DeVolder wrote:
> +What:		/sys/devices/system/cpu/crash_hotplug
> +Date:		Jun 2023

It's not "Jun" anymore :(

> +Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>

Why are you not going to maintain this?  Why is this up to me?

thanks,

greg k-h

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
