Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281E9C27C53
	for <kexec@archiver.kernel.org>; Wed,  5 Jun 2024 16:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6Xe3Lbqeko/f/5lZEQeqt2PAyGZLTyInITKOXnW0Z8A=; b=YQ9kgYJl+egEed
	yiNV52MxlwHpVgNUNDd4USP0YJmQMGku5mC5AWTbE4mAwXM+nbceOxW4mZfjYnk0amsGiN0zNZ7PG
	83EP0LIPgexmH7V3A9gmQLuIhDe3e5zgDjo5Lj9NtHwZXjPWMMVgbYIqipMWmqszv1OJYfnx7gqUi
	wMWBwu6thXljcCI8EzHfwOJuc1s2ICuu/7tOLuXT+plU3iQRLlCo3Mxqkf6RXtRn1lZV/P6JkUuFn
	/svEj7oUwiWZ225Q9wGIJiOaCQbYt/G41WMwOebXo8J/wdC6XbzGPkbT4xTaDBgvbvU/i8F4G/rNj
	OfYpixH3cpqj3602vXxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEtRg-00000006qe4-3nbf;
	Wed, 05 Jun 2024 16:25:04 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEtRd-00000006qby-1B9T
	for kexec@lists.infradead.org;
	Wed, 05 Jun 2024 16:25:03 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1085140E016A;
	Wed,  5 Jun 2024 16:24:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NKcdbJr_y2wU; Wed,  5 Jun 2024 16:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717604693; bh=es2T3xUJ//5xyaKB1XndAP8uqqdLOgfFIhPCGmC/CDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eRN1VmHnofXkhGbMAgrYH2Qk/XhZLkNNY5mvJhNCQVUDK2oKst2OKufJHPZHki19j
	 HXRRnxH9jrI9cGFwAQZL+0DzxPkofD/fHw8ZnDFrL2ll7iM/yL9LHcp0mA0i5sJpbD
	 3ylwHa3HpncMb2v+ZW2n+cRyZNAzlsVOvEkly3X0yb4jkjUlFEUFmtAtkT7fE5MU+T
	 wN3aWpxstOWhJgOunWnyxYduYZWWBBCyjxmf1rQM/r3OVAk1TTqvA92IHop0+DNb71
	 mwI1Y0xIBnG89A4gQSaTpXZ5QRFWF49WdtuQ69vt8sjE6xolMG562jnsWa1pj0H3lf
	 fhtmx3RwEatiztWu1GrxrpXph6arL2U9EVO8TJN9I0JL7e1A+filxFr/8PS99z0ibH
	 0T4mtQ70vtFGiXwxEzcQFQCWGUUSkbqeMt2+rfQzijo6sHd+b6MDwqXn+mlf9CiLL+
	 G2Lmg++PwW/y+Isb8OcvW2TiuXkyXUKzX72RgL0wRIpHm27BPgN9c0tYQVZK3jAOOJ
	 zBMeewlGislpLpoSwEFvCoz4oS1To6U+1vl4uq6b4dX50aL0OLeoGc9uCZeyQXHAzc
	 5PVp3Wv+OslihQmk0W4zzv2gLhf4FBzqEFS7byBrvi6537gyCuWzQojV2fn98LE3cn
	 1B3BeEv74sKj4rarohbtsP4M=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2F7C140E0177;
	Wed,  5 Jun 2024 16:24:25 +0000 (UTC)
Date: Wed, 5 Jun 2024 18:24:19 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>, adrian.hunter@intel.com,
	ardb@kernel.org, ashish.kalra@amd.com, bhe@redhat.com,
	dave.hansen@linux.intel.com, elena.reshetova@intel.com,
	haiyangz@microsoft.com, hpa@zytor.com, jun.nakajima@intel.com,
	kai.huang@intel.com, kexec@lists.infradead.org, kys@microsoft.com,
	linux-acpi@vger.kernel.org, linux-coco@lists.linux.dev,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	ltao@redhat.com, mingo@redhat.com, peterz@infradead.org,
	rafael@kernel.org, rick.p.edgecombe@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
	tglx@linutronix.de, thomas.lendacky@amd.com, x86@kernel.org
Subject: Re: [PATCHv11.1 11/19] x86/tdx: Convert shared memory back to
 private on kexec
Message-ID: <20240605162419.GJZmCRM8V6xooyvm9H@fat_crate.local>
References: <20240531151442.GMZlnpYkDCRlg1_YS0@fat_crate.local>
 <20240602142303.3263551-1-kirill.shutemov@linux.intel.com>
 <20240603083754.GAZl2A4uXvVB5w4l9u@fat_crate.local>
 <noym2bqgxqcyhhdzoax7gvdfzhh7rtw7cv236fhzpqh3wqf76e@2jj733skv7y4>
 <78d33a31-0ef2-417b-a240-b2880b64518e@intel.com>
 <u3hg3fqc2nxsjtfugjmmzlahwriyqlebnkxrbzgrxlkj6l3k36@yd3yudglgevi>
 <20240604180554.GIZl9XgscEI3PUvR-W@fat_crate.local>
 <alkew673cceojzmhsp3wj43yv76cek5ydh2iosfcphuv6ro26q@pj6whxcoetht>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alkew673cceojzmhsp3wj43yv76cek5ydh2iosfcphuv6ro26q@pj6whxcoetht>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_092501_506049_25241CA4 
X-CRM114-Status: GOOD (  10.91  )
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

On Wed, Jun 05, 2024 at 03:21:42PM +0300, Kirill A. Shutemov wrote:
> If a page can be accessed via private mapping is determined by the
> presence in Secure EPT. This state persist across kexec.

I just love it how I tickle out details each time I touch this comment
because we three can't write a single concise and self-contained
explanation. :-(

Ok, next version:

"Private mappings persist across kexec. If tdx_enc_status_changed() fails
in the first kernel, it leaves memory in an unknown state.

If that memory remains shared, accessing it in the *next* kernel through
a private mapping will result in an unrecoverable guest shutdown.

The kdump kernel boot is not impacted as it uses a pre-reserved memory
range that is always private.  However, gathering crash information
could lead to a crash if it accesses unconverted memory through
a private mapping which is possible when accessing that memory through
/proc/vmcore, for example.

In all cases, print error info in order to leave enough bread crumbs for
debugging."

I think this is getting in the right direction as it actually makes
sense now.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
