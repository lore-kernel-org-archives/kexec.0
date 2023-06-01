Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7028AC77B7A
	for <kexec@archiver.kernel.org>; Thu,  1 Jun 2023 10:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ygbwPxVKMBZj6Wyv4+ANlqhn9ZKMUxe3PKCnmoqGw40=; b=tvB/3kPhwsuIK3
	dNy/5U0XQBahRq0ziOakw+V4jn0ufG7nPBoA0tixzpKOsHUehNhrZMwevrKbvV1AIFGdOMw1biXVc
	Ukdx9oj3riMRyZlB/sVjbrPEMNZK4crP5CSz3yQjcIq1VE9LiZUgOmnJX76VXaAGdsx5iv3UQUMRY
	J/Cfi3jnve6UEu9dKGRWYU8i3AObmuprDXFtibz+eykgqqfnW+QtVy73Ei59+12WjbSP+QbTxi/2K
	3rDmxm6oi6JVlPL5TEvDixBKo2oeIPjTuB6gZmAg2EQBzVELVbtxHgnH3jJUWEZpHb73Ks5Vwlqxx
	UIUXRG6K9xV3EqnAhT+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4fsK-0037RK-0a;
	Thu, 01 Jun 2023 10:49:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4fsH-0037Pg-2Y
	for kexec@lists.infradead.org;
	Thu, 01 Jun 2023 10:49:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685616577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YbR9CXr6tf+W2x5hw6RwEAlyQOocli6uAUnQNn0VL3M=;
	b=Ktox3tdiIVzp9o7o5FnDqbSZqVZ5FqBRvlcWuG5hin8M4lXaSfOBNSNRtbFg2h87t0pF27
	ZDefmBtZVqi5zASw5fe5C3w9cahWvMQyjAm5qZNV8WWhwrCGpRVBPArRsawxNYmPrUrfXV
	gbb5PP7QBaeQ+A9+WRJk3OaPY2bcrxY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-491-SxdGd6MvNq2cNu63Kpr6Xg-1; Thu, 01 Jun 2023 06:49:36 -0400
X-MC-Unique: SxdGd6MvNq2cNu63Kpr6Xg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 854C41C04327;
	Thu,  1 Jun 2023 10:49:35 +0000 (UTC)
Received: from localhost (ovpn-12-54.pek2.redhat.com [10.72.12.54])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 98AE4492B0A;
	Thu,  1 Jun 2023 10:49:34 +0000 (UTC)
Date: Thu, 1 Jun 2023 18:49:31 +0800
From: Baoquan He <bhe@redhat.com>
To: Simon Horman <horms@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Eric Biederman <ebiederm@xmission.com>,
	"Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kexec: Avoid calculating array size twice
Message-ID: <ZHh3u+9H/OBHFKlC@MiWiFi-R3L-srv>
References: <20230525-kexec-array_size-v1-1-8b4bf4f7500a@kernel.org>
 <ZHh1kBxfOf6hCvo8@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZHh1kBxfOf6hCvo8@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230601_034945_925423_A3E6DC36 
X-CRM114-Status: GOOD (  20.94  )
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

On 06/01/23 at 06:40pm, Baoquan He wrote:
> On 05/25/23 at 04:26pm, Simon Horman wrote:
> > Avoid calculating array size twice in kexec_purgatory_setup_sechdrs().
> > Once using array_size(), and once open-coded.
> > 
> > Flagged by Coccinelle:
> > 
> >   .../kexec_file.c:881:8-25: WARNING: array_size is already used (line 877) to compute the same size
> 
> Amazingly smart. Thanks.
> 
> Acked-by: Baoquan He <bhe@redhat.com>

Just noticed Andrew has picked this one, please ignore this.

> 
> > 
> > No functional change intended.
> > Compile tested only.
> > 
> > Signed-off-by: Simon Horman <horms@kernel.org>
> > ---
> >  kernel/kexec_file.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index f989f5f1933b..3f5677679744 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -867,6 +867,7 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
> >  {
> >  	unsigned long bss_addr;
> >  	unsigned long offset;
> > +	size_t sechdrs_size;
> >  	Elf_Shdr *sechdrs;
> >  	int i;
> >  
> > @@ -874,11 +875,11 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
> >  	 * The section headers in kexec_purgatory are read-only. In order to
> >  	 * have them modifiable make a temporary copy.
> >  	 */
> > -	sechdrs = vzalloc(array_size(sizeof(Elf_Shdr), pi->ehdr->e_shnum));
> > +	sechdrs_size = array_size(sizeof(Elf_Shdr), pi->ehdr->e_shnum);
> > +	sechdrs = vzalloc(sechdrs_size);
> >  	if (!sechdrs)
> >  		return -ENOMEM;
> > -	memcpy(sechdrs, (void *)pi->ehdr + pi->ehdr->e_shoff,
> > -	       pi->ehdr->e_shnum * sizeof(Elf_Shdr));
> > +	memcpy(sechdrs, (void *)pi->ehdr + pi->ehdr->e_shoff, sechdrs_size);
> >  	pi->sechdrs = sechdrs;
> >  
> >  	offset = 0;
> > 
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
