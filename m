Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C3DC77B7C
	for <kexec@archiver.kernel.org>; Tue,  9 May 2023 11:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iIrKgM3mWqEffO1Gvg+TXJsES3WtFPzZQrdGhJbvfy0=; b=fPzjlIDeHmiMe1
	y/tHjO0lJQFU9SQ9TlUElPv2zwLrfZ8qtG0onJpHaevU7weZeRVMS88UdWX38PG7AHlARxrpxf3YT
	C5hH69XQA6sLdcD5V9ZvZLuX0Ac+nGSgDhGo/4pPC31TRyj0wbPVcEgIEra+qtfFnTiHvbFCEI6PO
	JVCcOs+yix2x5lv6KXcWURcpce2Kg8pFbdi0CelDl6AeVIX/XyDOb0VuFiK51PxKH3mUwEQALQrTp
	jP7zrttMgOzjr1CI9qfFMthcmcSgwpZ9cOCgpnMVK061hj3l/n+cIxx/KKN/MgjSMNhYUheu/uqWS
	x466OkfB0kN0LKI8pkcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwLty-003C5e-0G;
	Tue, 09 May 2023 11:53:06 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwLtv-003C4x-04
	for kexec@lists.infradead.org;
	Tue, 09 May 2023 11:53:04 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id CA6A56337A;
	Tue,  9 May 2023 11:53:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D8EC4339B;
	Tue,  9 May 2023 11:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683633181;
	bh=iDUKUbZirpdLT/vnKcBM+kYSe00R/wpZnwcBAxCQbnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W1bPOiZKnSFiLiLDtQ3LlokHgGQOjwFeqjF2sJvt61xfBfEyxxAwUd9YekZxf2TGN
	 QgrM9ySmN7DbaweowOOlrfViqNK3SKTeMw+V0NttIAXV8og+4XWQPPpMNGjVs+1pPZ
	 TOI/DTI3R096tlA5EZ32dSL9UBuVu8uT5fx+axy6nDcLMhThlu1+kFlzkxHu9l0Tlx
	 Cj66TLJ/YtYuVIm+3SGnqt8hxlZjaTTa2e8xwE8AuXR2sZGqcbHDBjLmyCYY7GNNv9
	 iW4uHJgbgTczFJ/+gIHD3YjCte+cisebQsAvK1K6PPweCbLsNmNb5RRgjtQjCqt6eC
	 bUMJ3jAAQThkQ==
Date: Tue, 9 May 2023 13:52:57 +0200
From: Simon Horman <horms@kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	"Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
	kexec@lists.infradead.org, linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] parisc: kexec: include reboot.h
Message-ID: <ZFo0Gd/Eucw/0gtC@kernel.org>
References: <20230508-parisc-kexec-include-reboot-v1-1-78a155a8a0a4@kernel.org>
 <ZFoL9ntYCCfZFCNs@bhe.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZFoL9ntYCCfZFCNs@bhe.users.ipa.redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230509_045303_098452_251E28BF 
X-CRM114-Status: GOOD (  14.01  )
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

On Tue, May 09, 2023 at 05:01:42PM +0800, Baoquan He wrote:
> On 05/09/23 at 09:01am, Simon Horman wrote:
> > Include reboot.h in machine_kexec.c for declaration of
> > machine_crash_shutdown and machine_shutdown.
> > 
> > gcc-12 with W=1 reports:
> > 
> >  arch/parisc/kernel/kexec.c:57:6: warning: no previous prototype for 'machine_crash_shutdown' [-Wmissing-prototypes]
> >     57 | void machine_crash_shutdown(struct pt_regs *regs)
> >        |      ^~~~~~~~~~~~~~~~~~~~~~
> >  arch/parisc/kernel/kexec.c:61:6: warning: no previous prototype for 'machine_shutdown' [-Wmissing-prototypes]
> >     61 | void machine_shutdown(void)
> >        |      ^~~~~~~~~~~~~~~~
> > 
> > No functional changes intended.
> > Compile tested only.
> > 
> > Signed-off-by: Simon Horman <horms@kernel.org>
> 
> Acked-by: Baoquan He <bhe@redhat.com>
> 
> We may need to find out the places in all architectures and fix all of
> them.

I did check. It seemed to be needed for riscv, m68k and parisc.
I've sent out patches for all three. But I may have missed something.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
