Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D12C47DA9
	for <kexec@archiver.kernel.org>; Tue, 30 Jan 2024 03:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kfJpLjSbWm5LxvWSVljgFJZTtULm1C3AItXzsNHKKBk=; b=o0VeQpRfNdEhcN
	S0xtJ7S1G5QUokEJof0QU2hXUpZrv7FDF4ihgBW9Gz4ywrE0g/twGAX9Dea3I892xKEQYQ1lA0SLA
	kXV443I1lXjuJ1l/zTIItSSwGrF2FJDR5u1AcQqe95Tpzv8TxVFz/E/qHIyvbGakZMKYd2xfpkWiH
	nIu4zNmsiFVuK+TzerD65lgK9S0E59XhPyrNElGR76tBfTib7pjXU42WVbpVulkF4JjOtJ+FFB3/A
	64CMM2+7tKqWbhY9D/zASnxnq6190nkeDlRR3v8TgTSVxgPoc568JmPfhyLUu4/DndYNOmu3yV2iJ
	mswL/QsXRgAPz2heJSPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUfGR-0000000FBsp-2pAw;
	Tue, 30 Jan 2024 03:58:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUfGO-0000000FBrj-13Rs
	for kexec@lists.infradead.org;
	Tue, 30 Jan 2024 03:58:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706587097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u8RDoe2yCdgr10/YRzYCMiM1TZtxb1vkYMgwLoeeQrg=;
	b=OCEjmiRYD3cxwHpv6u3Qfsgvqh/m5qFSLtE6Thc6U2CwabqCeWZvuSwCE3VjyKrQz34pGt
	kdSjtBuJ0pidin83ToHDYluggRrTl3EqKZ6BKY9waut7GQiH32efV3E63tDWdTp4eMMbxc
	sREFKvpcCNG9w6unTGwkNQ4MHqgT09Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-blDvJ29cOj2GDaPpPG2lBA-1; Mon, 29 Jan 2024 22:58:13 -0500
X-MC-Unique: blDvJ29cOj2GDaPpPG2lBA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6AF1983B82B;
	Tue, 30 Jan 2024 03:58:12 +0000 (UTC)
Received: from localhost (unknown [10.72.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A8BAAC0FDCA;
	Tue, 30 Jan 2024 03:58:11 +0000 (UTC)
Date: Tue, 30 Jan 2024 11:58:08 +0800
From: Baoquan He <bhe@redhat.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"nathan@kernel.org" <nathan@kernel.org>
Subject: Re: [PATCH linux-next 1/3] x86, crash: don't nest CONFIG_CRASH_DUMP
 ifdef inside CONFIG_KEXEC_CODE ifdef scope
Message-ID: <Zbhz0D3DgDyTsboe@MiWiFi-R3L-srv>
References: <20240129135033.157195-1-bhe@redhat.com>
 <SN6PR02MB41571397201804BD486C6148D47E2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <ZbhH+sg1BPi+R0j4@MiWiFi-R3L-srv>
 <SN6PR02MB41575A5568875B85C8AA7F4BD47D2@SN6PR02MB4157.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41575A5568875B85C8AA7F4BD47D2@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_195820_400369_ACD3D7AF 
X-CRM114-Status: GOOD (  24.15  )
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

On 01/30/24 at 01:39am, Michael Kelley wrote:
> From: Baoquan He <bhe@redhat.com>
> > 
> > On 01/29/24 at 06:27pm, Michael Kelley wrote:
> > > From: Baoquan He <bhe@redhat.com> Sent: Monday, January 29, 2024
> > 5:51 AM
> > > >
> > > > Michael pointed out that the #ifdef CONFIG_CRASH_DUMP is nested inside
> > > > arch/x86/xen/enlighten_hvm.c.
> > >
> > > Did some words get left out in the above sentence?  It mentions the Xen
> > > case, but not the Hyper-V case.  I'm not sure what you intended.
> > 
> > Thanks a lot for your careful reviewing.
> > 
> > Yeah, I tried to list all affected file names, seems my vim editor threw
> > away some words. And I forgot mentioning the change in reboot.c.
> > 
> > I adjusted log as below according to your comments, do you think it's OK
> > now?
> 
> Yes -- looks like everything is included and clear up my confusion.  But
> I still have two small nits per below. :-)

Right, I will grabbed them into v2. Thanks again.

> 
> > 
> > ===
> > Michael pointed out that the #ifdef CONFIG_CRASH_DUMP is nested inside
> > CONFIG_KEXEC_CODE ifdef scope in some XEN, HyperV codes.
> 
> s/Hyper-V/HyperV/
> 
> > 
> > Although the nesting works well too since CONFIG_CRASH_DUMP has
> > dependency on CONFIG_KEXEC_CORE, it may cause confusion because there
> > are places where it's not nested, and people may think it needs be nested
> 
> s/needs to be/needs be/
> 
> > even though it doesn't have to.
> > 
> > Fix that by moving  CONFIG_CRASH_DUMP ifdeffery of codes out of
> > CONFIG_KEXEC_CODE ifdeffery scope.
> > 
> > And also put function machine_crash_shutdown() definition inside
> > CONFIG_CRASH_DUMP ifdef scope instead of CONFIG_KEXEC_CORE ifdef.
> > 
> > And also fix a building error Nathan reported as below by replacing
> > CONFIG_KEXEC_CORE ifdef with CONFIG_VMCORE_INFO ifdef.
> > ......
> > ===
> > 
> > Thanks
> > Baoquan
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
