Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C456C4345F
	for <kexec@archiver.kernel.org>; Sun, 14 Apr 2024 02:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lStM6rveBuQLFAvt/JLJI0zL7zAWmo81di1AFZu5KWA=; b=Wn1lWVSaByZrLH
	yRjTWgs1s1GCiJ1CxrGmNhuGAcT7wkYVOPPfxbELtzgQaEtCKYK3a8Dzzn9hVMtC+5E8ocEqCES8M
	IS4jgllx3eHjkacawBpAS6eZfJsKm/wyWWdCdGhZNgIZF1x2PdH7apNac0QwjA92OEGI9IltEKR/e
	bBGuagsaWg6LwM5r3uWuUbEcNXJ6jyUAHnN1HkuwL8rrvjPxFLIgWD9k9cXEMLpm2fj0u0ZLctnsP
	hkCE6P7zkuAeYHNjcRZJnsGqreqS8dKxi1LidTW2bRgg9k2sVSp66KauVIYaZB6M2JSMGwDC8v2YT
	H83taARzDBMXx9lRtt4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvq0g-00000004RLh-2Quy;
	Sun, 14 Apr 2024 02:54:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvq0c-00000004RJx-2vuz
	for kexec@lists.infradead.org;
	Sun, 14 Apr 2024 02:54:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713063260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OhLPL+Z8mhdNe67IKMsqNtqhIqypjsxI4KpmPg+trm4=;
	b=Rl6yz7pLX2ATCUcleAHpEKsJWanGW1QPbrPw1ZznghaxbdpABZY06uCWf0VInpJb/WdGgS
	aAJ8+Yhavt5p+InygWmQfIefh1NxWnRwrcZoqdLqfPH23sNq2gGgpTMCpn2Tz+DSsRa3iQ
	eUlhUNP4p0wPRwqwdXecGcSpnUhmOC0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-mzn0Pu1aNfCwCNMoXmM7hA-1; Sat,
 13 Apr 2024 22:54:18 -0400
X-MC-Unique: mzn0Pu1aNfCwCNMoXmM7hA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F0141C05AB5;
	Sun, 14 Apr 2024 02:54:17 +0000 (UTC)
Received: from localhost (unknown [10.72.116.11])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EA896492BC8;
	Sun, 14 Apr 2024 02:54:16 +0000 (UTC)
Date: Sun, 14 Apr 2024 10:54:09 +0800
From: Baoquan He <bhe@redhat.com>
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, jirislaby@kernel.org
Subject: Re: [PATCH v2] kexec: fix the unexpected kexec_dprintk() macro
Message-ID: <ZhtFUT3Xmab3CqoI@MiWiFi-R3L-srv>
References: <20240409042238.1240462-1-bhe@redhat.com>
 <CALu+AoRB=kK00ecpboSJxpNqP+ERZaUrS+h-oo+uaXLoYPYT_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALu+AoRB=kK00ecpboSJxpNqP+ERZaUrS+h-oo+uaXLoYPYT_Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240413_195422_931337_B5C17EE9 
X-CRM114-Status: GOOD (  31.23  )
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

Hi Dave,

On 04/12/24 at 03:28pm, Dave Young wrote:
> On Tue, 9 Apr 2024 at 12:23, Baoquan He <bhe@redhat.com> wrote:
> >
> > Jiri reported that the current kexec_dprintk() always prints out
> > debugging message whenever kexec/kdmmp loading is triggered. That is
> > not wanted. The debugging message is supposed to be printed out when
> > 'kexec -s -d' is specified for kexec/kdump loading.
> >
> > After investigating, the reason is the current kexec_dprintk() takes
> > printk(KERN_INFO) or printk(KERN_DEBUG) depending on whether '-d' is
> > specified. However, distros usually have defaulg log level like below:
> >
> >  [~]# cat /proc/sys/kernel/printk
> >  7       4      1       7
> >
> > So, even though '-d' is not specified, printk(KERN_DEBUG) also always
> > prints out. I thought printk(KERN_DEBUG) is equal to pr_debug(), it's
> > not.
> >
> > Fix it by changing to use pr_info() instead which are expected to work.
> 
> Could you also update the kernel/crash_core.c and
> kernel/crash_reserve.c to include the filename prefix?
> #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

When I added pr_fmt() to kernel/crash_reserve.c and tested code, the
printed boot log about crashkernel reservation is changed as below:

[  +0.000000] crash_reserve: crashkernel reserved: 0x000000007d000000 - 0x0000000095000000 (384 MB)

When I looked around, I noticed all other lines around don't have the
module name printed out. Seems it's not appropriate to add one for
crashkernel alone. And the kexec_dprintk() doesn't exist in
kernel/crash_reserve.c. Furthermore, the kexec_dprintk() is added to
enable debugging printing for kexec_file_load when loading kexec/kdump
kernel. This crashkernel reservation may not be related. Combinbed these
all, I would suggest not adding pr_fmt() for kernel/crash_reserve.c for
now, let's add pr_fmt() for kernel/crash_core.c, what do you think?

> 
> >
> > Fixes: cbc2fe9d9cb2 ("kexec_file: add kexec_file flag to control debug printing")
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > Reported-by: Jiri Slaby <jirislaby@kernel.org>
> > Closes: https://lore.kernel.org/all/4c775fca-5def-4a2d-8437-7130b02722a2@kernel.org
> > ---
> > v1->v2:
> > - Change to use pr_info() only when "kexec -s -d" is specified. With
> >   this change, those debugging message for "kexec -c -d" of kexec_load
> >   will be missed. We'll see if we need add them for kexec_load too, if
> >   someone explicitly requests it.
> >
> >  include/linux/kexec.h | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > index 060835bb82d5..f31bd304df45 100644
> > --- a/include/linux/kexec.h
> > +++ b/include/linux/kexec.h
> > @@ -461,10 +461,8 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
> >
> >  extern bool kexec_file_dbg_print;
> >
> > -#define kexec_dprintk(fmt, ...)                                        \
> > -       printk("%s" fmt,                                        \
> > -              kexec_file_dbg_print ? KERN_INFO : KERN_DEBUG,   \
> > -              ##__VA_ARGS__)
> > +#define kexec_dprintk(fmt, arg...) \
> > +        do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
> >
> >  #else /* !CONFIG_KEXEC_CORE */
> >  struct pt_regs;
> > --
> > 2.41.0
> >
> >
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
