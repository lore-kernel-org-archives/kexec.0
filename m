Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D2EBC77B7E
	for <kexec@archiver.kernel.org>; Thu, 27 Apr 2023 08:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VnYD7tO0Gzp7GH0qJB749J5mZjcUyW89bakaEHznmIc=; b=uHFKkWSYZVfAJI
	VZExeuRsOrxnOxMtgSpKOQP2zcjV0vqDwu3tGwHHoBbf4qkkd9p1VodzBSOGyMAFd5IPVNdj2rbpB
	pOXDv0IKbRDsm5Pg7rZ2uviK8tK4mQiGUu8VXT3N+At3r5OtPQ1vjgCCRAc/3mp2V0Rd/TDCo56w+
	VP7JClTZGy420AA+HFYJj9bJXt6wbh+5M/crE0uds8PWO22qQjdMGBdC/2IPkCkgTXEIKWOpjnRqP
	3PPJwGG9m60vOixZ5MezADMpgRZQaOO2aIHY6nMQW680QN2JOzQmXhp87sOexTuuXUquwKKv/872p
	1Q+FAUC81Tr6fP9axuHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prxKf-005rb6-34;
	Thu, 27 Apr 2023 08:50:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prxKc-005raS-2s
	for kexec@lists.infradead.org;
	Thu, 27 Apr 2023 08:50:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1682585421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rh/WbE+toZnJQPE0MKp08EzhTnMG7PdoYtKJ+SLzedk=;
	b=IJw4I7tcmfurcBKt2Xi46EFXseJoSfaLEm9h0JotjMv7zkzlvVklH4llhzy6xWRHwrkFu6
	DnEyBSowaFoLhLCd+iD2KISQTADmpczFmmbz2OCJVGcu7WW9p46349GtGJhQgpbRGxFhEQ
	N32v5v+po8y82pSfH9HBkApXWZUrViA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-360-oDXpSVuMOjy-jd1jxNjljQ-1; Thu, 27 Apr 2023 04:50:17 -0400
X-MC-Unique: oDXpSVuMOjy-jd1jxNjljQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD33FA0F380;
	Thu, 27 Apr 2023 08:50:16 +0000 (UTC)
Received: from localhost (ovpn-13-168.pek2.redhat.com [10.72.13.168])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 49D46492C14;
	Thu, 27 Apr 2023 08:50:12 +0000 (UTC)
Date: Thu, 27 Apr 2023 16:49:56 +0800
From: Baoquan He <bhe@redhat.com>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: Eric DeVolder <eric.devolder@oracle.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
	dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
	robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
	sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
	boris.ostrovsky@oracle.com
Subject: Re: [PATCH v21 5/7] x86/crash: add x86 crash hotplug support
Message-ID: <ZEo3NK/9Nkc7ctrc@bhe.users.ipa.redhat.com>
References: <20230404180326.6890-1-eric.devolder@oracle.com>
 <20230404180326.6890-6-eric.devolder@oracle.com>
 <da95e01d-24bd-676b-3a48-bafda1b36cda@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <da95e01d-24bd-676b-3a48-bafda1b36cda@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230427_015027_035224_E7711B42 
X-CRM114-Status: GOOD (  21.54  )
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

On 04/27/23 at 12:39pm, Hari Bathini wrote:
> Hi Eric,
> 
> On 04/04/23 11:33 pm, Eric DeVolder wrote:
> > When CPU or memory is hot un/plugged, or off/onlined, the crash
> > elfcorehdr, which describes the CPUs and memory in the system,
> > must also be updated.
> > 
> > The segment containing the elfcorehdr is identified at run-time
> > in crash_core:crash_handle_hotplug_event(), which works for both
> > the kexec_load() and kexec_file_load() syscalls. A new elfcorehdr
> > is generated from the available CPUs and memory into a buffer,
> > and then installed over the top of the existing elfcorehdr.
> > 
> > In the patch 'kexec: exclude elfcorehdr from the segment digest'
> > the need to update purgatory due to the change in elfcorehdr was
> > eliminated.  As a result, no changes to purgatory or boot_params
> > (as the elfcorehdr= kernel command line parameter pointer
> > remains unchanged and correct) are needed, just elfcorehdr.
> > 
> > To accommodate a growing number of resources via hotplug, the
> > elfcorehdr segment must be sufficiently large enough to accommodate
> > changes, see the CRASH_MAX_MEMORY_RANGES description. This is used
> > only on the kexec_file_load() syscall; for kexec_load() userspace
> > will need to size the segment similarly.
> > 
> > To accommodate kexec_load() syscall in the absence of
> 
> Firstly, thanks! This series is a nice improvement to kdump support
> in hotplug environment.
> 
> One concern though is that this change assumes corresponding support
> in kexec-tools. Without that support kexec_load would fail to boot
> with digest verification failure, iiuc.

Eric has posted patchset to modify kexec_tools to support that, please
see the link Eric pasted in the cover letter.

http://lists.infradead.org/pipermail/kexec/2022-October/026032.html


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
