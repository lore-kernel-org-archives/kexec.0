Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EDF9C6FD1C
	for <kexec@archiver.kernel.org>; Thu, 23 Mar 2023 07:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=w/cD5i7WqiN8sWY9z6srif2lkW7ZRJkEZ9+H87xWYJQ=; b=iM7aXPhTIell6g
	7Zc3AUqBCTndAgpIA+FZqq2LgbJYrycbKSRgwAwcaoMRljuIkXpG+6Pp/S359Woq2j002EjoPkzYf
	oshqp1y2r8Ie8gOkpfOK4awiWSVOh10gxvunc4zxxebX7tbPSTtrlUnhN65Cn2METhg4XzpMgT3m8
	OmufTXWAOdbm8GDn4/6UUVoXhH+EYl4WC0R1eIeHioRKjmpoK+b7tax9tzZSOCz/XU1tXD578ywYM
	uVDbdOn4jmKdc8tEgGtIMfbHf22YpweMisDKEFKqRUOeFvCEezVSVTrWJdGfXJZlnaBKWnNqExtV1
	E8vrRutaNx0/68nY3Ycg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfFhd-0019Kn-2A;
	Thu, 23 Mar 2023 07:49:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfFhY-0019Jl-1D
	for kexec@lists.infradead.org;
	Thu, 23 Mar 2023 07:49:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1679557773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wupudpKpSiccJ31lY6LftuSVm9mzcXiVCi/lHnPJZOg=;
	b=BMwsErTkndBb87XFX4meehADNlYNmKhZNuwDxiPxEQyBtglOAQbAPmSK6Cz/F9b+935xQk
	+1f9JVk3TAYuaWqnWJqkB77kgqiEyOYY8xIGKB+HBoKk/orv3DqxdxPElH4kwm+Rm2rPm+
	yuFs2An1a4vSaC8euLKO9BlQiucbQp8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-EYbPA4HBPtCHXKwu7dXdpw-1; Thu, 23 Mar 2023 03:49:28 -0400
X-MC-Unique: EYbPA4HBPtCHXKwu7dXdpw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD59B38149BA;
	Thu, 23 Mar 2023 07:49:26 +0000 (UTC)
Received: from localhost (ovpn-12-97.pek2.redhat.com [10.72.12.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E3AE175AD;
	Thu, 23 Mar 2023 07:49:24 +0000 (UTC)
Date: Thu, 23 Mar 2023 15:49:20 +0800
From: Baoquan He <bhe@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>, akpm@linux-foundation.org,
	x86@kernel.org
Cc: Eric Biederman <ebiederm@xmission.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 0/2] kexec: Remove unnecessary arch hook
Message-ID: <ZBwEgDPq71+09OiD@MiWiFi-R3L-srv>
References: <20230307224416.907040-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230307224416.907040-1-helgaas@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230323_004936_486083_AAB48D77 
X-CRM114-Status: GOOD (  12.22  )
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

Hi,

On 03/07/23 at 04:44pm, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> There are no arch-specific things in arch_kexec_kernel_image_load(), so
> remove it and just use the generic version.
> 
> v1 is at:
> https://lore.kernel.org/all/20221215182339.129803-1-helgaas@kernel.org/
> 
> This v2 is trivially rebased to v6.3-rc1 and the commit log expanded
> slightly.

This is an obvious and good cleanup patchset, who should I ping to ask
for accepting?  It's touching kexec generic code, while the hook
only exists on x86 ARCH.

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
