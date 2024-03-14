Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD877C54E60
	for <kexec@archiver.kernel.org>; Thu, 14 Mar 2024 13:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1mJkQguAXb1LBi2FMu07vn+DFHhC6HSHUnf5b36YmSc=; b=OhjXXiAQTf1i40
	eA+/Pe6/88PcvwDgo+GC4ZxKCcWqUIX5MD0y5sy2QISzCfdTDnoKwlK55VxE3rsJlySbvdqFeA46W
	GF84PFJg9EWLcZQM7Kx61LjGFnioiXw+t98ZrGRGXfIwky10CTU9bRMoZiLOxfgBH/h3gF8n6bLLW
	BE5FJcLmHN44k8vWWn5hYvSKcTQpNgtulMUk2ynxjWD1NcW+A8vKlkCJM7J90G3J0ciBwGrRgA/wv
	qOk7p6/YRti+5vtofKRlztw3ZmLjk9dXn7J90vxBwJmrx39aZNGctpFn0PFg+wq6jBeboCX747nQX
	QyZp0VSZJLprR6PsjTxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkkjh-0000000ELKD-2k1M;
	Thu, 14 Mar 2024 13:03:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkkje-0000000ELIl-2tOa
	for kexec@lists.infradead.org;
	Thu, 14 Mar 2024 13:03:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710421381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NPly0vMKCUXLoKRkQ6t3RWJ8bsdSfgA8CK9VGL1bM5U=;
	b=jCqbsGLs/aqOwbdHywnoWnmfVSUHhQY4hvnYlChEFxdf7kHDGw3tTo6nkecDBJW6bVszEi
	baM/PHAcsw3F13l5vHqRakLtt9vkJZG3yvrLTNDtiYe+5vx52qbADysRnl45L6KY36akU2
	bCAOdLP5h0wmzzcb90AQhsVEpytzggE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-46-bR1910l5MtSlwZwXc9xaHA-1; Thu,
 14 Mar 2024 09:02:59 -0400
X-MC-Unique: bR1910l5MtSlwZwXc9xaHA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3539D3C0EAB7;
	Thu, 14 Mar 2024 13:02:59 +0000 (UTC)
Received: from localhost (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B6BDA1C060A4;
	Thu, 14 Mar 2024 13:02:57 +0000 (UTC)
Date: Thu, 14 Mar 2024 21:02:54 +0800
From: Baoquan He <bhe@redhat.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	akpm@linux-foundation.org, joe@perches.com, dyoung@redhat.com
Subject: Re: [PATCH] kexec: fix the unexpected kexec_dprintk() macro
Message-ID: <ZfL1fvlfcziCVBsP@MiWiFi-R3L-srv>
References: <20240314103947.717991-1-bhe@redhat.com>
 <5d10552a-1c73-4f35-84be-ce6c1dcd800b@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5d10552a-1c73-4f35-84be-ce6c1dcd800b@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240314_060302_829182_F84C35B1 
X-CRM114-Status: GOOD (  21.89  )
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

On 03/14/24 at 12:54pm, Jiri Slaby wrote:
> On 14. 03. 24, 11:39, Baoquan He wrote:
> > Jiri reported that the current kexec_dprintk() always prints out
> > debugging message whenever kexec/kdmmp loading is triggered. That is
> > not wanted. The debugging message is supposed to be printed out when
> > 'kexec -s -d' is specified for kexec/kdump loading.
> > 
> > After investigating, the reason is the current kexec_dprintk() takes
> > printk(KERN_INFO) or printk(KERN_DEBUG) depending on whether '-d' is
> > specified. However, distros usually have defaulg log level like below:
> > 
> >   [~]# cat /proc/sys/kernel/printk
> >   7	 4	1	7
> > 
> > So, even though '-d' is not specified, printk(KERN_DEBUG) also always
> > prints out. I thought printk(KERN_DEBUG) is equal to pr_debug(), it's
> > not.
> > 
> > Fix it by changing to use pr_info() and pr_debug() instead which are
> > expected to work.
> 
> Hi,
> 
> sow, you'd need both -d, and dyndbg updates. Hence, again my question:
> ===
> Actually what was wrong on the pr_debug()s? Can you simply turn them on from
> the kernel when -d is passed to kexec instead of all this?

I checked code, it's because some codes are shared by both kexec_load and
kexec_file_load, e.g below function on arm64:

arch/arm64/kernel/machine_kexec.c:machine_kexec_post_load()

"kexec -c -l -d" is for kexec_load debugging message printing, it's all
done in user space kexec-tools utility. The pr_debug() have been there
for arm64 developer's debugging if they want to. I don't want to change
that.

If 'kexec -s -l -d', pr_info() is called to print out. If 'kexec -s -l'
w/o '-d', or 'kexec -c -l', it's still pr_debug just as before.

> ===
> 
> And yet, it is still missing a prefix :).

It looks like this now, seems no need to add prefix.
 
[  102.609784] kexec_file: kernel: 0000000081fc03e0 kernel_size: 0xccb200
[  102.617084] PEFILE: Unsigned PE binary
[  102.753174] ima: kexec measurement buffer for the loaded kernel at 0x71435000.
[  102.761335] kexec-bzImage64: Loaded purgatory at 0x71430000
[  102.767571] kexec-bzImage64: Loaded boot_param, command line and misc at 0x7142c000 bufsz=0x1320 memsz=0x2000
[  102.778650] kexec-bzImage64: Loaded 64bit kernel at 0x6d000000 bufsz=0xcc6200 memsz=0x3c4c000
[  102.788251] kexec-bzImage64: Loaded initrd at 0x6ac0f000 bufsz=0x23f0175 memsz=0x23f0175
[  102.797283] kexec-bzImage64: Final command line is: root=/dev/mapper/fedora_lenovo--electron--sr850--01-root ro rd.lvm.lv=fedora_lenovo-electron-sr850-01/root console=ttyS0,115200n81
[  102.815435] kexec-bzImage64: E820 memmap:
[  102.819912] kexec-bzImage64: 0000000000000000-000000000003dfff (1)
[  102.826817] kexec-bzImage64: 000000000003e000-000000000003ffff (2)
[  103.021435] kexec-bzImage64: 00000000ff000000-00000000ffffffff (2)
......snip
[  103.028336] kexec-bzImage64: 0000000100000000-000000403fffffff (1)
[  103.269194] kexec_file: nr_segments = 5
[  103.273484] kexec_file: segment[0]: buf=0x00000000898981dd bufsz=0x59e mem=0x71435000 memsz=0x1000
[  103.283616] kexec_file: segment[1]: buf=0x000000003d8dd363 bufsz=0x4000 mem=0x71430000 memsz=0x5000
[  103.293748] kexec_file: segment[2]: buf=0x00000000ba27c5ef bufsz=0x1320 mem=0x7142c000 memsz=0x2000
[  103.303865] kexec_file: segment[3]: buf=0x0000000026acdcf4 bufsz=0xcc6200 mem=0x6d000000 memsz=0x3c4c000
[  103.333455] kexec_file: segment[4]: buf=0x000000001a7dac7f bufsz=0x23f0175 mem=0x6ac0f000 memsz=0x23f1000
[  103.356698] kexec_file: kexec_file_load: type:0, start:0x714301a0 head:0x1222da002 flags:0x8


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
