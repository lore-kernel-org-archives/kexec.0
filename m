Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5370BC6FD1D
	for <kexec@archiver.kernel.org>; Tue, 14 Mar 2023 14:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XczPJebZn3A7JpCCL6NT8Z8fx7dDUFfXL56Oy5TELhI=; b=3txhf0IwPQxcj7
	LlWiYVuqQmIjw3o/oS6lX6U0SaiRYTRe6qUtCUh3Aeg/zugcmsXj7m8JvOXibaUYYz+yKe86nuP08
	JHjq5DQ9dBWv/mLtr0W0iHgnheFfmslAnhxc9F+Y1wz8XumOfoi+I0j9vvFLlkPSW9r3e+rK5sDH2
	KJBTwTdu0kO2Kp4FJav+ijLhPtBxCnUp9fCq327jbdLVFQaN1rvmB+bS7ExfNyOgyuaIW6AfyK4C3
	xcBG+oRhQQHpeE9/S6wUxpaUWQIfewhqHMrIK0g9ZwWbP5Z3L8VjJuQ//mACTt9e/wHY55dp6xHC0
	hCQh3txPe4GXSeROFvZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pc5YV-00AS2K-0s;
	Tue, 14 Mar 2023 14:23:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pc5YR-00AS0n-23
	for kexec@lists.infradead.org;
	Tue, 14 Mar 2023 14:23:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1678803784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3rV/CKa5wadgKLok3eourywXXQnzSqpZ7XBoZDYaJi8=;
	b=eS7dsiaL4C/tMBwxPV75ZBk3gasiL/bsR5i2ssFc+jT0r34NGFV26fcFPhWQo6LCTMMhsU
	0bxuaEhcuwYMq2w7DOwUJCZ66tR1bNtre1VNrPM7N1hegTbj6Lz0rWQ8QOdU4M0LFU5wY5
	2GJeYPjUXKIor8THGC3xXNVUrAY8B98=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-552-9Lh6L2NCPKWmtI7AoNP3mQ-1; Tue, 14 Mar 2023 10:23:00 -0400
X-MC-Unique: 9Lh6L2NCPKWmtI7AoNP3mQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1B9DF2800489;
	Tue, 14 Mar 2023 14:22:59 +0000 (UTC)
Received: from localhost (ovpn-12-81.pek2.redhat.com [10.72.12.81])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 03B3A202701E;
	Tue, 14 Mar 2023 14:22:57 +0000 (UTC)
Date: Tue, 14 Mar 2023 22:22:54 +0800
From: Baoquan He <bhe@redhat.com>
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org,
	ebiederm@xmission.com, dyoung@redhat.com, vgoyal@redhat.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	nramas@linux.microsoft.com, thomas.lendacky@amd.com,
	robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
	sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
	boris.ostrovsky@oracle.com
Subject: Re: [PATCH v19 2/7] crash: add generic infrastructure for crash
 hotplug support
Message-ID: <ZBCDPuTdjMY+7VrG@MiWiFi-R3L-srv>
References: <20230306162228.8277-1-eric.devolder@oracle.com>
 <20230306162228.8277-3-eric.devolder@oracle.com>
 <ZBBPzKBTuzGZe4OC@MiWiFi-R3L-srv>
 <2fd31764-b341-638a-f70e-43dc0d5b0092@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2fd31764-b341-638a-f70e-43dc0d5b0092@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230314_072307_786133_1FF744E2 
X-CRM114-Status: GOOD (  15.51  )
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

On 03/14/23 at 08:28am, Eric DeVolder wrote:
......
> > > +static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
> > > +{
> > > +	switch (val) {
> > > +	case MEM_ONLINE:
> > > +		crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY,
> > > +			KEXEC_CRASH_HP_INVALID_CPU);
> > > +		break;
> > > +
> > > +	case MEM_OFFLINE:
> > > +		crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY,
> > > +			KEXEC_CRASH_HP_INVALID_CPU);
> > > +		break;
> > > +	}
> > > +	return NOTIFY_OK;
> > > +}
> > > +
> > > +static struct notifier_block crash_memhp_nb = {
> > > +	.notifier_call = crash_memhp_notifier,
> > > +	.priority = 0
> > > +};
> > > +
> > 
> > Because for_each_possible_cpu() is taken in
> > crash_prepare_elf64_headers(), x86 doesn't need to respond to cpu
> > hotplug or doesn't do anything with this patchset. This cpu part in
> > infrastructure is only for the later powerpc usage, right?
> 
> That is true, yes.

Given this patchset is aimed at crash hotplug on x86, while obviously it
does't need to have the cpu hotplug support on x86 since the
for_each_possible_cpu() adjustment. People looking into this may be
confused if they don't follow the discussion thread of v18. Do we need
to mention this in cover letter or somewhere else? I could miss that
though it is has been told, please ignore this if yes.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
