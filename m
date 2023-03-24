Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C173EC6FD1C
	for <kexec@archiver.kernel.org>; Fri, 24 Mar 2023 01:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p41m/wSpOIfI1uFUgl4+rxi6fmgrJiFiMpXr3+j8mmE=; b=qDJrCSSOStuACE
	opAUJ5uIVQ1MoJCPidAgoO/pxPlcrI3eO7CkmqxOSQfg4IYKPY3oYFw6aeuGNjDNGPDXr5hZ/97Ne
	cbEuOFj7yNe6Gh1h5/5iS9+Kq1OXr0vefzLh4v5l2PGT18NKEGmb4BsfU7uokdC/m6S/i4Rxmaj/F
	QZKcPz/gWml6uSYlffhwShx52koyU+15fH+c0skcXg1eHtDtQ/K4fNnR7ZzZIMtGjI9NRDswgNKcF
	vu9p3KCedJOPmTNSVxADlaTYAecWWS0onjjkQJYLLKmyWvhkM9c3kkeRqc9fHFOBzPfdTFu5+Z6gz
	i+VeOvVr59CBiwZdn8gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfWSW-003KdJ-12;
	Fri, 24 Mar 2023 01:43:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfWST-003Kcr-0I
	for kexec@lists.infradead.org;
	Fri, 24 Mar 2023 01:43:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1679622188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+qRY2eQHWA6TVqowK/iddv6jgQSvWFOjHndRvcplPbY=;
	b=Jgc9tRItrkaqs6FUyWbxYpF9UOQAS2LW5s3tq6YZDO3tVnYvUR778IizGsNWbwzkvXC0m3
	h60IbBW8of8y+/uKUcGTdPnTLGi/AMnj11f+JpelVIWcHbjtqcsrvnLlArz14tDumV1yje
	yhALq2ROOPG3Bzjhl0rQMO9zbxHlsas=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-12-qjM_UH_6M3iDMjZq8HWwFA-1; Thu, 23 Mar 2023 21:43:06 -0400
X-MC-Unique: qjM_UH_6M3iDMjZq8HWwFA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 087FA85A588;
	Fri, 24 Mar 2023 01:43:06 +0000 (UTC)
Received: from localhost (ovpn-12-55.pek2.redhat.com [10.72.12.55])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B4AFD492B0A;
	Fri, 24 Mar 2023 01:43:04 +0000 (UTC)
Date: Fri, 24 Mar 2023 09:43:00 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, x86@kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 0/2] kexec: Remove unnecessary arch hook
Message-ID: <ZB0AJFCdHcFRI7PE@MiWiFi-R3L-srv>
References: <20230307224416.907040-1-helgaas@kernel.org>
 <ZBwEgDPq71+09OiD@MiWiFi-R3L-srv>
 <20230323150755.06f8977fa2b860b8e02c37c3@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230323150755.06f8977fa2b860b8e02c37c3@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230323_184309_203023_A6D847D1 
X-CRM114-Status: GOOD (  16.97  )
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

On 03/23/23 at 03:07pm, Andrew Morton wrote:
> On Thu, 23 Mar 2023 15:49:20 +0800 Baoquan He <bhe@redhat.com> wrote:
> 
> > Hi,
> > 
> > On 03/07/23 at 04:44pm, Bjorn Helgaas wrote:
> > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > 
> > > There are no arch-specific things in arch_kexec_kernel_image_load(), so
> > > remove it and just use the generic version.
> > > 
> > > v1 is at:
> > > https://lore.kernel.org/all/20221215182339.129803-1-helgaas@kernel.org/
> > > 
> > > This v2 is trivially rebased to v6.3-rc1 and the commit log expanded
> > > slightly.
> > 
> > This is an obvious and good cleanup patchset, who should I ping to ask
> > for accepting?  It's touching kexec generic code, while the hook
> > only exists on x86 ARCH.
> 
> I grabbed them

Thanks a lot, Andrew.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
