Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FEEAC4345F
	for <kexec@archiver.kernel.org>; Sun, 14 Apr 2024 13:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jZpqZ4f3TYXt92/mNn2rZVI+1vebzQnYgFfXC9BDcYc=; b=I5g4rr3sWGOd+5
	bUCarR1dkvaGI7Tjm2DJrHexLNf9PUEJdvmBw1ZQ7Hq0Jp+hwfZAuqthqVIG2a+iUwHyxir5Lysro
	BPetgrKb/3FVP/bSzUrIH+pPKLQIFp7eHmcTsdTO0O6ar2kowpdhr+TZVM2NXAIEex9ebWsSN4nU8
	uJmRgg/l5RF3gnkO4rjtIr+Eogb0fw3BoOmdidSaMaX/fPQtQ2PCkbcrFXp8HuHh1h5MGkpss5NWC
	P3daEHXI4uwFfRnWvozGeXIthMAXVmBnIRrZrV1O5rZm7iHpkGGn69DGlZWc2chz3HMFeOm/e7s1z
	zJsOwEp+RRFih0leV06A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvzi9-00000005VCe-0mrC;
	Sun, 14 Apr 2024 13:15:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvzi4-00000005VBL-0iEL
	for kexec@lists.infradead.org;
	Sun, 14 Apr 2024 13:15:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713100548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TxsVSEM/ISCMQK7WTXJMVVvHAiJqTZKC50KXYMuKRIg=;
	b=Vqj2qWSMX7inFHPGpUx/fJXEJrMCWOB5mDhodYNp67+h0UB8BSLS6hFgRanpil5NFoLVrb
	qEbpi4iklVu1Xf4SpYVLt7Zqn9RsIztfonYZm4Lm/xIHyAK/XtcsiogcSquLspvpyR8VCM
	dO6sv5yF5vbtzqjAKNx+1STiLM2qxPc=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-4I25Umy8MiuDqbAVme1TPQ-1; Sun, 14 Apr 2024 09:15:47 -0400
X-MC-Unique: 4I25Umy8MiuDqbAVme1TPQ-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-369f36aba3bso3848445ab.1
        for <kexec@lists.infradead.org>; Sun, 14 Apr 2024 06:15:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713100546; x=1713705346;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TxsVSEM/ISCMQK7WTXJMVVvHAiJqTZKC50KXYMuKRIg=;
        b=L3ynbKJUUM3sufZb045dSKyiq/pbw/Ygb+zCHKAq7/luaVpM8HPILeOWTTDppr5C4X
         k7tB7WE7cAkocXez1XgAkhamFCufJJo+IBbHbxFbAAnZ1heJ15DJuo/Rfp67/W+uJBna
         Ck0zMWyhiEOTOhMgOMPRqPRx7xVqiqbLfnEJ+IHY1fXt2oGQc9JctBCGgI49HTyK74Ve
         TSd9Y9OxaLRTCCmTVAikPZowyjgXGT7sGe4wHz7i47pUIWMiXvo5ae4/pFToamxVV3XW
         Sso1JNxOriGjf4zZgjzdSORyOwDOe63X2TMTwjhK8PpFhAblT9MXGfgyQyCE15vtjMWQ
         cfWg==
X-Gm-Message-State: AOJu0Yz6NQK2Pyr+0jG4eNkduWMr9p7YOQCrHyWIO+UUphZ0L8WltDJ0
	mmC3bSjKYl8luX6fDt0yjKGA5d+NRPR1TOdWbVw+1MFr1EEFTbttbaM2JHuenIYp5UtWRszDJNf
	JPsWfmU+UtD6CE2TpKsKsalr0mUt+P4umTcVKKfx0/ENlNeT5VN3QUkz4zu/ye7/QvuJLJBfh5d
	Y+Jjac2KCHE1QVzbIULp5McjunJ9xW0hrmeL5a07VH
X-Received: by 2002:a92:c006:0:b0:368:8d92:3262 with SMTP id q6-20020a92c006000000b003688d923262mr6507177ild.2.1713100546206;
        Sun, 14 Apr 2024 06:15:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHfCfuM8ItSMcRThrMGuKy7IWQL34kylDbIEss835twvGM4ein8hFI0+wZrivGJDJGhvKq9lSGaQtSik6eZXw=
X-Received: by 2002:a92:c006:0:b0:368:8d92:3262 with SMTP id
 q6-20020a92c006000000b003688d923262mr6507171ild.2.1713100545915; Sun, 14 Apr
 2024 06:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240409042238.1240462-1-bhe@redhat.com> <CALu+AoRB=kK00ecpboSJxpNqP+ERZaUrS+h-oo+uaXLoYPYT_Q@mail.gmail.com>
 <ZhtFUT3Xmab3CqoI@MiWiFi-R3L-srv>
In-Reply-To: <ZhtFUT3Xmab3CqoI@MiWiFi-R3L-srv>
From: Dave Young <dyoung@redhat.com>
Date: Sun, 14 Apr 2024 21:16:02 +0800
Message-ID: <CALu+AoQXKR4P2G02kyLYiALGU+EoqWVYVAtv5rfD2Ce1hAbszQ@mail.gmail.com>
Subject: Re: [PATCH v2] kexec: fix the unexpected kexec_dprintk() macro
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, jirislaby@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240414_061552_549514_EF781C66 
X-CRM114-Status: GOOD (  36.79  )
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

On Sun, 14 Apr 2024 at 10:54, Baoquan He <bhe@redhat.com> wrote:
>
> Hi Dave,
>
> On 04/12/24 at 03:28pm, Dave Young wrote:
> > On Tue, 9 Apr 2024 at 12:23, Baoquan He <bhe@redhat.com> wrote:
> > >
> > > Jiri reported that the current kexec_dprintk() always prints out
> > > debugging message whenever kexec/kdmmp loading is triggered. That is
> > > not wanted. The debugging message is supposed to be printed out when
> > > 'kexec -s -d' is specified for kexec/kdump loading.
> > >
> > > After investigating, the reason is the current kexec_dprintk() takes
> > > printk(KERN_INFO) or printk(KERN_DEBUG) depending on whether '-d' is
> > > specified. However, distros usually have defaulg log level like below:
> > >
> > >  [~]# cat /proc/sys/kernel/printk
> > >  7       4      1       7
> > >
> > > So, even though '-d' is not specified, printk(KERN_DEBUG) also always
> > > prints out. I thought printk(KERN_DEBUG) is equal to pr_debug(), it's
> > > not.
> > >
> > > Fix it by changing to use pr_info() instead which are expected to work.
> >
> > Could you also update the kernel/crash_core.c and
> > kernel/crash_reserve.c to include the filename prefix?
> > #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> When I added pr_fmt() to kernel/crash_reserve.c and tested code, the
> printed boot log about crashkernel reservation is changed as below:
>
> [  +0.000000] crash_reserve: crashkernel reserved: 0x000000007d000000 - 0x0000000095000000 (384 MB)
>
> When I looked around, I noticed all other lines around don't have the
> module name printed out. Seems it's not appropriate to add one for
> crashkernel alone. And the kexec_dprintk() doesn't exist in
> kernel/crash_reserve.c. Furthermore, the kexec_dprintk() is added to
> enable debugging printing for kexec_file_load when loading kexec/kdump
> kernel. This crashkernel reservation may not be related. Combinbed these
> all, I would suggest not adding pr_fmt() for kernel/crash_reserve.c for
> now, let's add pr_fmt() for kernel/crash_core.c, what do you think?

Hi Baoquan,  I'm fine with it.

But adding pr_fmt is always good as all the pr_* will have a prefix
instead of manually add "crashkernel:" in every pr_warn etc.  There
are indeed a few without any prefix in this file though.  But it can
be done separately, not necessary to be done here together with the
debug print though.

Thanks
Dave

>
> >
> > >
> > > Fixes: cbc2fe9d9cb2 ("kexec_file: add kexec_file flag to control debug printing")
> > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > > Reported-by: Jiri Slaby <jirislaby@kernel.org>
> > > Closes: https://lore.kernel.org/all/4c775fca-5def-4a2d-8437-7130b02722a2@kernel.org
> > > ---
> > > v1->v2:
> > > - Change to use pr_info() only when "kexec -s -d" is specified. With
> > >   this change, those debugging message for "kexec -c -d" of kexec_load
> > >   will be missed. We'll see if we need add them for kexec_load too, if
> > >   someone explicitly requests it.
> > >
> > >  include/linux/kexec.h | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > > index 060835bb82d5..f31bd304df45 100644
> > > --- a/include/linux/kexec.h
> > > +++ b/include/linux/kexec.h
> > > @@ -461,10 +461,8 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
> > >
> > >  extern bool kexec_file_dbg_print;
> > >
> > > -#define kexec_dprintk(fmt, ...)                                        \
> > > -       printk("%s" fmt,                                        \
> > > -              kexec_file_dbg_print ? KERN_INFO : KERN_DEBUG,   \
> > > -              ##__VA_ARGS__)
> > > +#define kexec_dprintk(fmt, arg...) \
> > > +        do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
> > >
> > >  #else /* !CONFIG_KEXEC_CORE */
> > >  struct pt_regs;
> > > --
> > > 2.41.0
> > >
> > >
> >
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
