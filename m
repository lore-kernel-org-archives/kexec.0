Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA7CC48260
	for <kexec@archiver.kernel.org>; Mon, 19 Feb 2024 04:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XMEvsaVHaZoh5sb8ieBjsaKX43It6t8baRtTx0ANZTI=; b=W8luEdTxzRb3qK
	w6yJdzZvUzHvLGDSCz1T9LLsExe8BLD8u9EkLmpPBAL9CKbGZ7ogETN5ut01SEQ9AYckJW+MPMgNA
	cKYHtHtwLPhMXdd+fsDWuAy9OVCXP9ACCQgUyEQkjF6wNsZ9JaImB95whiwYd6QGUywXiPi9fHqkp
	rkC5CMlmpxxQjsY6QF2qCjNLgufwtNhlysQwi87NAXb671ePl+lLjN2XUNg45v0LTyYSNYZjy26t/
	RJ1Un0nPlAGJuWgTMg4h8xr0vaTywjuj0D1I1XRvEOYDkt/PxKv6zabbI3auVUi9vTD+MfUzxQQAO
	MJmv2ciu6q9NPItSwlzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rbvXo-000000095Kp-0X7h;
	Mon, 19 Feb 2024 04:46:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rbvXl-000000095Ja-14sO
	for kexec@lists.infradead.org;
	Mon, 19 Feb 2024 04:46:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708317976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dLXISstnHfpiIpRnh79Jrtq+xnWJNyw4ml3k09pwYAA=;
	b=c3ZrRrdkwqnl1Q0uUhGzyo0L47EA2ctrlWNyCIfqs5yO9C/BeaKqfAr0Qr6ztEQd4hewiW
	NS3Y6HfVLPMp6pkFcFWRS/dopAM47sgQ8PBpv7ddcz07qk+WM1fwScFn6ANALVWh6OvhOv
	REOOP4JMUypPhQffrKGL5FeHgJOpo7Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-3JnxGZhPN4OftMT9bGeA-A-1; Sun,
 18 Feb 2024 23:46:12 -0500
X-MC-Unique: 3JnxGZhPN4OftMT9bGeA-A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E49291C0BB43;
	Mon, 19 Feb 2024 04:46:10 +0000 (UTC)
Received: from localhost (unknown [10.72.116.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 36F7BC03282;
	Mon, 19 Feb 2024 04:46:09 +0000 (UTC)
Date: Mon, 19 Feb 2024 12:46:03 +0800
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
Subject: Re: [PATCHv7 02/16] x86/apic: Mark acpi_mp_wake_* variables as
 __ro_after_init
Message-ID: <ZdLdC4B2ov4JxxXf@MiWiFi-R3L-srv>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-3-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240212104448.2589568-3-kirill.shutemov@linux.intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240218_204617_374937_0CCC0778 
X-CRM114-Status: GOOD (  13.74  )
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

On 02/12/24 at 12:44pm, Kirill A. Shutemov wrote:
> acpi_mp_wake_mailbox_paddr and acpi_mp_wake_mailbox initialized once
> during ACPI MADT init and never changed.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Kai Huang <kai.huang@intel.com>

Reviewed-by: Baoquan He <bhe@redhat.com>

> ---
>  arch/x86/kernel/acpi/madt_wakeup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
> index 7f164d38bd0b..cf79ea6f3007 100644
> --- a/arch/x86/kernel/acpi/madt_wakeup.c
> +++ b/arch/x86/kernel/acpi/madt_wakeup.c
> @@ -6,10 +6,10 @@
>  #include <asm/processor.h>
>  
>  /* Physical address of the Multiprocessor Wakeup Structure mailbox */
> -static u64 acpi_mp_wake_mailbox_paddr;
> +static u64 acpi_mp_wake_mailbox_paddr __ro_after_init;
>  
>  /* Virtual address of the Multiprocessor Wakeup Structure mailbox */
> -static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
> +static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox __ro_after_init;
>  
>  static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
>  {
> -- 
> 2.43.0
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
