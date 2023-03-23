Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B08C7619A
	for <kexec@archiver.kernel.org>; Thu, 23 Mar 2023 22:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Q+Td0L3KDbAyLydloWaarWG8dmDHAeLoeegLdSjVsng=; b=lNRxk+X+mzU4UG
	s7gO+sTXrSKzWwwY3gKH3TOKHmipf/3gqLK1F42ZtNy4ZA9EYzag86x3ns0fwVHQXQRGGa6xJYHHD
	8P9ABE2VP83tNDNU9o1v8oIQltrKsLN5vK89vHJArMN6NgRXtFxMW+1qduGl/EOEDf4edNGgdgwcM
	/0/tKcf23gj7lXbMacEf/2pw1bH6bPxdAg1EQyzUB3Ywqxt9db1sbS8W/wZR2NB+/Ckj+w7UOyhfE
	N3LmAjpftZur48NPDrgQisB5o7po2+rxkS8XnLH2ivTjo7X5JhaSkyiHfYbbIwRUmMDIdjRuhjGb8
	xcc5d7Ml7YrUi495iHDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfT6G-0033DX-2e;
	Thu, 23 Mar 2023 22:08:00 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfT6E-0033D2-1F
	for kexec@lists.infradead.org;
	Thu, 23 Mar 2023 22:07:59 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id BFDCF628E0;
	Thu, 23 Mar 2023 22:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01901C433EF;
	Thu, 23 Mar 2023 22:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1679609277;
	bh=reLqZ6mL7WqZDYYjDhmQkKBmgPIHanFWRcBr7gpKytk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=yWnmA7jho28TdcB1GYNPLBSK1E0F2yavbxbGf5yE5BOHyqq4nxKHTwWpAFBQ7gqdq
	 kK4H+M4qD3qNbibUmbwo3f5JF0Hn3Xf21nMMrCr7TMJobLuTsAkNci/EDg68VV2ZT6
	 A/q4A6FXFsWJh+LO4VGt3pxf9RZ+HpGXB6OyFJ2o=
Date: Thu, 23 Mar 2023 15:07:55 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Baoquan He <bhe@redhat.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, x86@kernel.org, Eric Biederman
 <ebiederm@xmission.com>, Dave Hansen <dave.hansen@intel.com>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 0/2] kexec: Remove unnecessary arch hook
Message-Id: <20230323150755.06f8977fa2b860b8e02c37c3@linux-foundation.org>
In-Reply-To: <ZBwEgDPq71+09OiD@MiWiFi-R3L-srv>
References: <20230307224416.907040-1-helgaas@kernel.org>
	<ZBwEgDPq71+09OiD@MiWiFi-R3L-srv>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230323_150758_461263_AF085249 
X-CRM114-Status: GOOD (  15.73  )
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

On Thu, 23 Mar 2023 15:49:20 +0800 Baoquan He <bhe@redhat.com> wrote:

> Hi,
> 
> On 03/07/23 at 04:44pm, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > There are no arch-specific things in arch_kexec_kernel_image_load(), so
> > remove it and just use the generic version.
> > 
> > v1 is at:
> > https://lore.kernel.org/all/20221215182339.129803-1-helgaas@kernel.org/
> > 
> > This v2 is trivially rebased to v6.3-rc1 and the commit log expanded
> > slightly.
> 
> This is an obvious and good cleanup patchset, who should I ping to ask
> for accepting?  It's touching kexec generic code, while the hook
> only exists on x86 ARCH.

I grabbed them

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
