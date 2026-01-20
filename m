Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E16BD2ED0F
	for <kexec@archiver.kernel.org>; Tue, 20 Jan 2026 10:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DaphwKTr6kruAM6Ca6z24D6/blOeNF2NHw7uL9x+gGQ=; b=H2LG7gI4AJDky6XhIXNq+3ETKL
	G+b5sst7KN94Mj9RZw128OJojJnqe8r6WmOcZ3z4dJGqhjCWYuvwPEqwd8/sF6oX7lrBj++zHqlkM
	/Du5rcpjg3tleIte2QEs8OK4w1VV8uPn+7dZzhHJpGhce0sOPxx5BU/R5LsMHEpnB8G+fSi3oO+7N
	4jEc6/R/Bc6tGyWPXdr7IK70lFHht3Wcg/PNVuaGl0yA/RHoK0wKMeIZaZ32nAIlOtXCaX5rzO6xV
	KARjgs8VG++opM2hec6bxUHKJdbLKh4z0yhiLKOEq2ik5UGpUmommw+lQs2OmpM4jzQD6HUcHj6fP
	9GWyrFoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vi8mK-00000003auA-0F8O;
	Tue, 20 Jan 2026 10:16:04 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vi8mA-00000003ass-13d4
	for kexec@bombadil.infradead.org;
	Tue, 20 Jan 2026 10:15:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DaphwKTr6kruAM6Ca6z24D6/blOeNF2NHw7uL9x+gGQ=; b=dIiLdVk0v8mQ9sIEPfm9fygkeY
	7htraddIO1tiaZ87Fm+2loxGPlgl1QCOxODC2I6mFlUVlZYUs2z8SmDPgAz7v96r+LU5KCJj/6cum
	LkH6wBQzJL/vGRMEe7SKCnGvxLfJyZZ8PxrAe+sJP3ixq8oEbOfr8143yC7W7lAbqEYUKWgi3DkCN
	ztzPEHYQBg4u/uXsidnBp+drbyOcnEn0IaKtel7by1zsW0kx6PagY22Npoa1S74Sg3CVP+AuUmm/x
	ROD62Q456ezZGYhlENUUf3BfSfgHj+d+OKXm12DfZ6YcFL2Y/qKzhTYi9nWJkgHOi1w+A35t/W4sS
	lwVxvuNw==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vi8m7-0000000DmZm-12l2
	for kexec@lists.infradead.org;
	Tue, 20 Jan 2026 10:15:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768904148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DaphwKTr6kruAM6Ca6z24D6/blOeNF2NHw7uL9x+gGQ=;
	b=GtlKPQAfm7a8g/SEweyPX2JtjVLqUJZDAoBSpEJlN252AO6ruajc7VelG067yvb2zsVcOv
	Qx+KS4loZ46V33kDut9LSHOpzgpUrzLQGk0XcaaAy/ZvNaasXEAcpSUMC4cbAAkgLGnJr4
	r9QYBPUoSmfN9hHudwu8M6JgnqwOTYg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768904148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DaphwKTr6kruAM6Ca6z24D6/blOeNF2NHw7uL9x+gGQ=;
	b=GtlKPQAfm7a8g/SEweyPX2JtjVLqUJZDAoBSpEJlN252AO6ruajc7VelG067yvb2zsVcOv
	Qx+KS4loZ46V33kDut9LSHOpzgpUrzLQGk0XcaaAy/ZvNaasXEAcpSUMC4cbAAkgLGnJr4
	r9QYBPUoSmfN9hHudwu8M6JgnqwOTYg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-XPoEYggVOSeMcVKFq0boNA-1; Tue,
 20 Jan 2026 05:15:41 -0500
X-MC-Unique: XPoEYggVOSeMcVKFq0boNA-1
X-Mimecast-MFC-AGG-ID: XPoEYggVOSeMcVKFq0boNA_1768904140
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 414C01954B0B;
	Tue, 20 Jan 2026 10:15:39 +0000 (UTC)
Received: from localhost (unknown [10.72.112.122])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 45B4B19560A2;
	Tue, 20 Jan 2026 10:15:36 +0000 (UTC)
Date: Tue, 20 Jan 2026 18:15:33 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Qiang Ma <maqianga@uniontech.com>
Cc: catalin.marinas@arm.com, will@kernel.org, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] kexec: add kexec flag to control debug printing
Message-ID: <aW9VxaXD60X36ZFV@MiWiFi-R3L-srv>
References: <20251219093134.2268620-1-maqianga@uniontech.com>
 <20260119154947.e351bfb8e97d91305932e2eb@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119154947.e351bfb8e97d91305932e2eb@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260120_101551_463771_3E5E4A85 
X-CRM114-Status: GOOD (  20.42  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 01/19/26 at 03:49pm, Andrew Morton wrote:
> On Fri, 19 Dec 2025 17:31:30 +0800 Qiang Ma <maqianga@uniontech.com> wrote:
> 
> > The commit cbc2fe9d9cb2 ("kexec_file: add kexec_file flag to control
> > debug printing") added the kexec_file flag to control debug printing.
> > However, for arm64, after commit 6f8c1da071a4 ("kexec_file, arm64: print
> > out debugging message if required"), when using the kexec_load interface,
> > the kexec_image_info function is called to print debug message, but
> > it uses kexec_dprintk, which is only available under kexec_file,
> > then when specifying 'kexec -d', kexec_load interface will print nothing.
> > 
> > For riscv, commit eb7622d908a09 ("kexec_file, riscv: print out debugging
> > message if required") remove kexec_image_info(), because the content has
> > been printed out in generic code in kexec_file_load, but not in kexec_load.
> > 
> > Therefore, in order to solve the two problems mentioned above, for this
> > patchset, several things need to be done:
> > 
> > 1. Enabling kexec_dprintk is available for kexec_load.
> > 2. Add some debugging message of the deleted kexec_image_info
> >    to generic code.
> > 3. Remove duplicate debugging prints for arm64.
> 
> Some additional review input on this series would be good, if someone
> has the time.

As I have said before, I am not fan of this patchset becuase I think
it's not necessary, even though it has no much harm except of adding code.
Leave this to those who like it.


