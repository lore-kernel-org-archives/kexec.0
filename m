Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 709F6C197A0
	for <kexec@archiver.kernel.org>; Thu, 16 Nov 2023 12:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tUFEqJX7M7hDyHiQoCEhOZIyWVR9HWMx5eFHC/Z4eqA=; b=IqIYbHZbovQXbp
	bMdB9qHFnQ+M+q3CRwdIrwomF/wj5L/8r6pPgpF6XwWMY9i+Qz0FIxlXJeK7sMUMdtsdAht3fNyBs
	uIHJC7C6PuNwzaShuqWMxW8T8cZrL4zoZSYIoydnipiOBTSwg6lwGekEeIqhqW0U4JvFfDTRCtTrq
	T+3nakBa2k377BXd+iWitfnjkAICELFuBw3HHDE02/CjNe0QlgbE033oAn/f63VHup7SI4bKfRYUV
	cjlslktjYW+CTc9fD2b//acrzn8eDVafdnGlP4MlokKnGVsgOQe1zKjug8WyWoUsJXQpAkFhhfziL
	DGlRaK7apG9TQRjM46Hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3bD5-003Rsk-2J;
	Thu, 16 Nov 2023 12:11:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r3bCz-003Rrv-2z
	for kexec@lists.infradead.org;
	Thu, 16 Nov 2023 12:11:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700136657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2o8llrEy4J3tkRIyO6miHMlYGkEf09QZYyfJI1/fuJU=;
	b=f2EBAgNltRd+wB6hn8mHTIXzmncT1s1C0wmETAAXcERfA2Pxb26hHxfQO0+L6f2Z2NJ3qe
	XiskCiKfDMZDjn5Qg3iT1hmSpUvTY+hRTQMcJo5GwYE5rO57lVVnMzlFXgeDAOCC0x/Dhp
	fxgcpAe2c80vXlCPyEZyTZt4zfIAh/o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-O4zObQUCNOqwSdecns0Nxg-1; Thu, 16 Nov 2023 07:10:52 -0500
X-MC-Unique: O4zObQUCNOqwSdecns0Nxg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ADDF285A58C;
	Thu, 16 Nov 2023 12:10:51 +0000 (UTC)
Received: from localhost (unknown [10.72.112.11])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DFD311C060AE;
	Thu, 16 Nov 2023 12:10:50 +0000 (UTC)
Date: Thu, 16 Nov 2023 20:10:47 +0800
From: Baoquan He <bhe@redhat.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 00/14] x86/tdx: Add kexec support
Message-ID: <ZVYGx1EwzjXbTEyX@MiWiFi-R3L-srv>
References: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231116_041058_057570_AE921C59 
X-CRM114-Status: GOOD (  10.16  )
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

On 11/15/23 at 03:00pm, Kirill A. Shutemov wrote:
> The patchset adds bits and pieces to get kexec (and crashkernel) work on
> TDX guest.

I finally got a machine of intel-eaglestream-spr as host and built a
tdx guest to give it a shot, the kexec reboot is working very well,
while kdump kernel always failed to boot up. I only built kernel and
installed it on tdx guest.
------------------------------------------
[    1.422500] Run /init as init process
[    1.423073] Failed to execute /init (error -2)
[    1.423759] Run /sbin/init as init process
[    1.424370] Run /etc/init as init process
[    1.424969] Run /bin/init as init process
[    1.425588] Run /bin/sh as init process
[    1.426150] Kernel panic - not syncing: No working init found.  Try passing init= option to kernel. See Linux Documentation/admin-guide/init.rst for guidance.
[    1.428122] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.7.0-rc1-00014-gbdba31ba3cec #3
[    1.429232] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 2/2/2022
[    1.430328] Call Trace:
[    1.430717]  <TASK>
[    1.431041]  dump_stack_lvl+0x33/0x50
[    1.431581]  panic+0x324/0x340
[    1.432037]  ? __pfx_kernel_init+0x10/0x10
[    1.432629]  kernel_init+0x174/0x1c0
[    1.433149]  ret_from_fork+0x2d/0x50
[    1.433690]  ? __pfx_kernel_init+0x10/0x10
[    1.434277]  ret_from_fork_asm+0x1b/0x30
[    1.434850]  </TASK>
[    1.435345] Kernel Offset: disabled
[    1.439216] Rebooting in 10 seconds..
qemu-kvm: cpus are not resettable, terminating


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
