Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3AFC64EC4
	for <kexec@archiver.kernel.org>; Fri,  3 Mar 2023 09:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SJQzzBGW3P4D6K4/Y2P3VunARSzK8LwX7+7BDSx8eug=; b=Gv0cP4ussxzp9V
	z9SkbXrZP61Gk8+Hr6u7JE6KhkCbX+4a9UMDAcYJrUyYRk8F8PudmdSKBHce8paNNKby/IFr4J3GN
	2TCb3107ymJQQMGHtKKYraQTPVJLGIiK+Cxtw1QSu2kaT+keZPe9Yj+cxAG6MtAqoeRTDoQVDFbvB
	fdUI7NZkcrfNi4YValjEhz2RQ1kubE+pGp44XafMfnIv/jM8YiKz9nGWjhki0fy0JOKdBG/jZAhhW
	YdjyJXin7bCdz7g2LhitfOv5VTmO+1Y+U17nKdy9nvhFfNEkvN9XMn10iWNsZEOVhSiGcmM0m5Cc5
	r0XkAmEu5YbVI3HYrHPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pY1ch-005f8j-4K; Fri, 03 Mar 2023 09:22:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pY1bj-005eOj-CU
	for kexec@lists.infradead.org; Fri, 03 Mar 2023 09:21:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1677835301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XjkqTVt2QtWZVOvq30arJHAo3lGgaTpqVjd41aCw5H0=;
	b=FwUSFfhydM6bK1JyKp8UFDAJZEyhY0GkW94sBJv2B9iaA7WCYosSxO9imc/D2QrhW2gvNh
	kuWitnnIV6RmsT/MqNiK8ngY9uNDrjgl7d0lZzDCzalofNYjulucXJQADKSTu2tdIociLt
	5jwZwy7uUWpvmWV37ll7wljJdNlCnpk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-205-vMJPGrxyObqdC6zLBD8I6A-1; Fri, 03 Mar 2023 04:21:38 -0500
X-MC-Unique: vMJPGrxyObqdC6zLBD8I6A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA245803D50;
	Fri,  3 Mar 2023 09:21:37 +0000 (UTC)
Received: from localhost (ovpn-13-150.pek2.redhat.com [10.72.13.150])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B15B82166B34;
	Fri,  3 Mar 2023 09:21:36 +0000 (UTC)
Date: Fri, 3 Mar 2023 17:21:29 +0800
From: Baoquan He <bhe@redhat.com>
To: "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"vgoyal@redhat.com" <vgoyal@redhat.com>,
	"dyoung@redhat.com" <dyoung@redhat.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"horms@verge.net.au" <horms@verge.net.au>,
	"k-hagio-ab@nec.com" <k-hagio-ab@nec.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
	"yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
	"ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
Subject: Re: [RFC][nvdimm][crash] pmem memmap dump support
Message-ID: <ZAG8GVUdiKx9LfWg@MiWiFi-R3L-srv>
References: <3c752fc2-b6a0-2975-ffec-dba3edcf4155@fujitsu.com>
 <Y/4JxQtnmYrZgVwF@MiWiFi-R3L-srv>
 <777f338f-09cb-d9f4-fe5f-3a6f059e4b02@fujitsu.com>
 <Y/8KFYraba1Lsh5f@MiWiFi-R3L-srv>
 <ddae42f1-749b-7665-28fa-89a3731c7b4a@fujitsu.com>
MIME-Version: 1.0
In-Reply-To: <ddae42f1-749b-7665-28fa-89a3731c7b4a@fujitsu.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230303_012143_604336_52CEF5A7 
X-CRM114-Status: GOOD (  26.18  )
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

On 03/03/23 at 02:27am, lizhijian@fujitsu.com wrote:
> 
> 
> On 01/03/2023 16:17, Baoquan He wrote:
> > On 03/01/23 at 06:27am, lizhijian@fujitsu.com wrote:
> > ......
> >> Hi Baoquan
> >>
> >> Greatly appreciate your feedback.
> >>
> >>
> >>> 1) In kernel side, export info of pmem meta data;
> >>> 2) in makedumpfile size, add an option to specify if we want to dump
> >>>      pmem meta data; An option or in dump level?
> >>
> >> Yes, I'm working on these 2 step.
> >>
> >>> 3) In glue script, detect and warn if pmem data is in pmem and wanted,
> >>>      and dump target is the same pmem.
> >>>
> >>
> >> The 'glue script' means the scirpt like '/usr/bin/kdump.sh' in 2nd kernel? That would be an option,
> >> Shall we abort this dump if "pmem data is in pmem and wanted, and dump target is the same pmem" ?
> > 
> > Guess you are saying scripts in RHEL/centos/fedora, and yes if I guess
> > righ. Other distros could have different scripts. For kdump, we need
> > load kdump kernel/initramfs in advance, then wait to capture any crash.
> > When we load, we can detect and check whether the environment and
> > setup is expected. If not, we can warn or error out message to users.
> 
> 
> IIUC, take fedora for example,
> T1: in 1st kernel, kdump.service(/usr/bin/kdumpctl) will do a sanity check before loading kernel and initramfs.
>      In this moment, as you said "we can detect and check whether the environment and setup is expected. If not,
>      we can warn or error out message to users."
>      I think we should abort the kdump service if "pmem data is in pmem and wanted, and dump target is the same pmem".
>      For OS administrators, they could either change the dump target or disable the pmem metadadata dump to make
>      kdump.service work again.
> 
> But kdump.service is distros independent, some OS administrators will use `kexec` command directly instead of service/script helpers.

Yeah, we can add document in kernel or somewhere else that dumping to
pmem is dangerous, especially when we want to dump pmem meta. People who
dare use kexec command directly, should handle it by her/his own.

> 
> > We don't need to do the checking until crash is triggered, then decide
> > to abort the dump or not.
> 
> T2: in 2nd kernel, since 1st kernel's glue scripts vary by distribution, we have to do the sanity check again to decide
> to abort the dump or not.

Hmm, we may not need to worry about that. kernel just need to do its own
business, not touching pmem data during kdump jumping and booting, and
provide way to allow makedumpfile to read out pmem meta. Anything else
should be taken care of by user or distros. 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
