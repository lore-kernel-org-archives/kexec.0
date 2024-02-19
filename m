Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F60C48BF8
	for <kexec@archiver.kernel.org>; Mon, 19 Feb 2024 11:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Uf3aR0bwn6CWTr9NrxojxoNjc2SapHbdOdqZuHeZmYg=; b=kq4CRuqExr/jaJ
	4OZ//tFwMWg12c2jlWe61frHUu5BRkARkW6s8yEUCCVOZgtVxFSHov24m6XOpSa8a2NhHi59hKkzL
	oAXa+KqczAld0RwTAEpqz4kWj9Cs1VqlU0cQ1bl5/p3p0klOQxPQV4MPpsH8d07E/TTdwQ57YRrMZ
	YkeRD5YCHuW5aT51WwDl3/6AdkblI65pd9eJMxOcZ64u2jdXSwjQIego0gYyVshWGfTzsq3dO6Wu+
	bBEfj7bYGkuWnK98ptKbGdjpHw6nBUfP9o22SnKs08wwVUItGL4T02aOTgcTEwErHY46MQwnlWBiz
	nUP7VIT7+1XCT9DWI8GQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rc1xC-0000000AEMS-0BC5;
	Mon, 19 Feb 2024 11:36:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rc1x9-0000000AELO-0IFx
	for kexec@lists.infradead.org;
	Mon, 19 Feb 2024 11:36:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708342614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TORTFmeK/rTrufvipbgOGnTjCcaJenkxzXpRYRFY+R0=;
	b=XJ3+0oNiKEV3rcPSu825Pmgfj0PUGYzy9A/PWqJJvezmVPnwV4Jl3NA/Sfcdcs03pTIbmo
	PmkRAsRwXNdoVnp2ZdQLAa8bwOe1o7L2FgGYfbjhtzu4vsC6JYIih1FEz1i3vJjjTD0lbZ
	HIMLOpfTNwaguvrnyrn4uY8qWXj0AhY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-SBEEdG1FMEq9wTIVVOM19Q-1; Mon, 19 Feb 2024 06:36:49 -0500
X-MC-Unique: SBEEdG1FMEq9wTIVVOM19Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 187F6811E81;
	Mon, 19 Feb 2024 11:36:48 +0000 (UTC)
Received: from localhost (unknown [10.72.116.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6371C1C060B2;
	Mon, 19 Feb 2024 11:36:47 +0000 (UTC)
Date: Mon, 19 Feb 2024 19:36:44 +0800
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
Subject: Re: [PATCHv7 01/16] x86/acpi: Extract ACPI MADT wakeup code into a
 separate file
Message-ID: <ZdM9TPVafuHJ6QQp@MiWiFi-R3L-srv>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-2-kirill.shutemov@linux.intel.com>
 <ZdLc61QMLu3L0Eqv@MiWiFi-R3L-srv>
 <a2cmua3qhbmhgzdxl5mszuvatnkyf4nwxjciurguhgbulrhin4@gvswvfats5er>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a2cmua3qhbmhgzdxl5mszuvatnkyf4nwxjciurguhgbulrhin4@gvswvfats5er>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240219_033655_190874_CDD6F394 
X-CRM114-Status: GOOD (  22.24  )
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

On 02/19/24 at 12:08pm, Kirill A. Shutemov wrote:
> On Mon, Feb 19, 2024 at 12:45:31PM +0800, Baoquan He wrote:
> > Do we need add the entry printing for ACPI_MADT_TYPE_MULTIPROC_WAKEUP
> > now in acpi_table_print_madt_entry()? Surely it's not related to this
> > patch.
> 
> Good catch. See patch below. Does it look okay?

Looks good to me, thanks.

Reviewed-by: Baoquan He <bhe@redhat.com>

> 
> > FWIW, 
> > 
> > Reviewed-by: Baoquan He <bhe@redhat.com>
> 
> Thanks!
> 
> From 23b7f9856a3d6b91c702def1e03872a60ae07d0e Mon Sep 17 00:00:00 2001
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Date: Mon, 19 Feb 2024 11:58:19 +0200
> Subject: [PATCH] ACPI: tables: Print MULTIPROC_WAKEUP when MADT is parse
> 
> When MADT is parsed, print MULTIPROC_WAKEUP information:
> 
> ACPI: MP Wakeup (version[1], mailbox[0x7fffd000], reset[0x7fffe068])
> 
> This debug information will be very helpful during bring up.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  drivers/acpi/tables.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index b07f7d091d13..c59a3617bca7 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -198,6 +198,20 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
>  		}
>  		break;
>  
> +	case ACPI_MADT_TYPE_MULTIPROC_WAKEUP:
> +		{
> +			struct acpi_madt_multiproc_wakeup *p =
> +				(struct acpi_madt_multiproc_wakeup *)header;
> +			u64 reset_vector = 0;
> +
> +			if (p->version >= ACPI_MADT_MP_WAKEUP_VERSION_V1)
> +				reset_vector = p->reset_vector;
> +
> +			pr_debug("MP Wakeup (version[%d], mailbox[%#llx], reset[%#llx])\n",
> +				 p->version, p->mailbox_address, reset_vector);
> +		}
> +		break;
> +
>  	case ACPI_MADT_TYPE_CORE_PIC:
>  		{
>  			struct acpi_madt_core_pic *p = (struct acpi_madt_core_pic *)header;
> -- 
> 2.43.0
> 
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
