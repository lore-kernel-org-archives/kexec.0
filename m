Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0530C4332F
	for <kexec@archiver.kernel.org>; Wed, 15 Nov 2023 00:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sBdF120mAuytKnRVU/3KloymDUIjwFt9o20Mokd4R2g=; b=nXp6NxjrXRTYSz
	xJwlRU1azU/i84gzvWXTeHGGY7218gQ0n7XR+lpGeEmY8/uoo98cjG7eS5eSAkFjaNXRhB+bqJprY
	Uq7YV3pu093VkEfQuMbA8hB0L38ubEv1qJvCwHTqvcCvYjxKqpyiZqVlMXcq1IOGRKZCM4lLqpBUv
	znw1ANC0DRgQdpb04LDNDefsi/KUOvyJzfTSfowHJOPmR3Bic4tdHOWrJnkpzfsXWMJyWarFiz4NR
	1gyjxmPP0jIfRfAz4iu2N2Fg6qioIijR/32Wo3nvqMpaItXu8E6IJ1URVTnj21BZgn0LcKoc5tPrR
	JB4ZEBEhDhGk5Ikrbueg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r34Es-00H3OC-1E;
	Wed, 15 Nov 2023 00:58:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r34Eo-00H3N2-39
	for kexec@lists.infradead.org;
	Wed, 15 Nov 2023 00:58:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700009918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3zlBf98ARjkQaX/S5kQ5snEY5GoQGl3AvBs2Ts5bz28=;
	b=U9eqYY3BZoF9kYmE5mB4TjKIRnwL4VSDtcntiBkFPAXtR9ilphfbatZ4JnqPoxWjgIWMJf
	XGslX6/WFU1YS1+ClFl9nbtOcJ4qL8TGD4/KVh0tdOyjUI3DSXAx1KC+6LulF346DveOKr
	JkZxPCgP8JN3VtGEEzyKSL36w1QFtlo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-MZ5tl1akPnSAAv4ds1nyfQ-1; Tue, 14 Nov 2023 19:58:35 -0500
X-MC-Unique: MZ5tl1akPnSAAv4ds1nyfQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8873B185A781;
	Wed, 15 Nov 2023 00:58:34 +0000 (UTC)
Received: from localhost (unknown [10.72.112.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D1C892166B26;
	Wed, 15 Nov 2023 00:58:33 +0000 (UTC)
Date: Wed, 15 Nov 2023 08:58:30 +0800
From: Baoquan He <bhe@redhat.com>
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-parisc@vger.kernel.org
Subject: Re: [PATCH 1/7] kexec_file: add kexec_file flag to control debug
 printing
Message-ID: <ZVQXthHraBBVeNy2@MiWiFi-R3L-srv>
References: <20231114153253.241262-1-bhe@redhat.com>
 <20231114153253.241262-2-bhe@redhat.com>
 <1e7863ec4e4ab10b84fd0e64f30f8464d2e484a3.camel@perches.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1e7863ec4e4ab10b84fd0e64f30f8464d2e484a3.camel@perches.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231114_165839_079617_8DFAEB57 
X-CRM114-Status: GOOD (  26.63  )
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

On 11/14/23 at 08:03am, Joe Perches wrote:
> On Tue, 2023-11-14 at 23:32 +0800, Baoquan He wrote:
> > When specifying 'kexec -c -d', kexec_load interface will print loading
> > information, e.g the regions where kernel/initrd/purgatory/cmdline
> > are put, the memmap passed to 2nd kernel taken as system RAM ranges,
> > and printing all contents of struct kexec_segment, etc. These are
> > very helpful for analyzing or positioning what's happening when
> > kexec/kdump itself failed. The debugging printing for kexec_load
> > interface is made in user space utility kexec-tools.
> > 
> > Whereas, with kexec_file_load interface, 'kexec -s -d' print nothing.
> > Because kexec_file code is mostly implemented in kernel space, and the
> > debugging printing functionality is missed. It's not convenient when
> > debugging kexec/kdump loading and jumping with kexec_file_load
> > interface.
> > 
> > Now add KEXEC_FILE_DEBUG to kexec_file flag to control the debugging
> > message printing. And add global variable kexec_file_dbg_print and
> > macro kexec_dprintk() to facilitate the printing.
> > 
> > This is a preparation, later kexec_dprintk() will be used to replace the
> > existing pr_debug(). Once 'kexec -s -d' is specified, it will print out
> > kexec/kdump loading information. If '-d' is not specified, it regresses
> > to pr_debug().
> 
> Not quite as pr_debug is completely eliminated with
> zero object size when DEBUG is not #defined.
> 
> Now the object size will be larger and contain the
> formats in .text.

Ah, I didn't realize that. Thanks for telling. I didn't take pr_info()
and pr_debug because I want to avoid printing the pr_fmt() string in
each file.

> 
> []
> > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> []
> > @@ -264,6 +264,18 @@ arch_kexec_apply_relocations(struct purgatory_info *pi, Elf_Shdr *section,
> >  	return -ENOEXEC;
> >  }
> >  #endif
> > +
> > +extern bool kexec_file_dbg_print;
> > +
> > +#define kexec_dprintk(fmt, args...)			\
> > +	do {						\
> > +		if (kexec_file_dbg_print)		\
> > +			printk(KERN_INFO fmt, ##args);	\
> > +		else					\
> > +			printk(KERN_DEBUG fmt, ##args);	\
> > +	} while (0)
> > +
> > +
> 
> I don't know how many of these printks exist and if
> overall object size matters but using

Not too much because they are spread in different arch.
> 
> #define kexec_dprintkfmt, ...)					\
> 	printk("%s" fmt,					\
> 	       kexec_file_dbg_print ? KERN_INFO : KERN_DEBUG,	\
> 	       ##__VA_ARGS__)
> 
> should reduce overall object size by eliminating the
> mostly duplicated format in .text which differs only
> by the KERN_<PREFIX>

Sure, the new one looks great to me, I will update code to take it.
Thanks a lot for your great suggestion.

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
