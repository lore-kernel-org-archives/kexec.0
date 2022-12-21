Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DB7C4167B
	for <kexec@archiver.kernel.org>; Wed, 21 Dec 2022 06:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZQZpMq9Mxh4i3QbA10r4VpPQJuRdNX+SUH+6Ehn1YW8=; b=tcK26gZ4pnzhVe
	2U+OyHR1Q0aubOugnUcKat6oIA4JPyFSH+PRSaqADvIrbur/izlyWimrnzYd7757y7K10faxPDxd9
	4Saj8dVS2/bMn193nFqosF1uKToreIhjJjCscpizl6J5sG1ccBszmoHKsZXeJFuD1lUCu+SH8DLAE
	hET2xPgH6cQtFO66yRtnLjcSS/rl6Gct1P4fL9fkhL/uZ6c5DT27/wzGFKj2thp3nBIvkKZ57J102
	B+5kKGTUkV1hj5HnA/VsFXRKdAyNGabGUDSKEbYoQhWnUFjeNUkCTcXc+QqM988/6m6ObXvAuZbWI
	3gepxrBIyVyF1gCgneMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7sER-00ANat-Cp; Wed, 21 Dec 2022 06:05:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7sEL-00ANUM-Sb
	for kexec@lists.infradead.org; Wed, 21 Dec 2022 06:05:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1671602728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qtlhrl2qq3dgmxn4quIc/7aksQ9mUhgFQl5OdwTK7n0=;
	b=cZHIg17weViwxn4SFw9pGjeh6rGmPWmyIcN18zTwVxAWKzEXqSNHEutGr9doPjH4WrXCJq
	GfDF9RJlFG9z/T8t1726cD4lUZe8rlWqZS9rLZqc5X1fd1C83Cg0+WRfCaYxVL833T+KYK
	9gj7vzf62HoBlPELuS/2dFD2TQpm5xU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-75-NfehV5i0MJGFVwXnLhGVkA-1; Wed, 21 Dec 2022 01:05:25 -0500
X-MC-Unique: NfehV5i0MJGFVwXnLhGVkA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7D28B801779;
	Wed, 21 Dec 2022 06:05:23 +0000 (UTC)
Received: from localhost (ovpn-12-50.pek2.redhat.com [10.72.12.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CB1321731B;
	Wed, 21 Dec 2022 06:05:22 +0000 (UTC)
Date: Wed, 21 Dec 2022 14:05:19 +0800
From: Baoquan He <bhe@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] kexec: Remove unnecessary arch hook
Message-ID: <Y6KiH2Nf/hMiaPmD@MiWiFi-R3L-srv>
References: <20221215182339.129803-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221215182339.129803-1-helgaas@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221220_220530_074404_19DF585D 
X-CRM114-Status: GOOD (  10.35  )
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

On 12/15/22 at 12:23pm, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> There are no arch-specific things in arch_kexec_kernel_image_load(), so
> remove it and just use the generic version.

This patchset looks good to me, thx.

Acked-by: Baoquan He <bhe@redhat.com>

Since it cleans up the last arch specific version of
arch_kexec_kernel_image_load in x86, maybe this patchset can go into x86
branch?

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
