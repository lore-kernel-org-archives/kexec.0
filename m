Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 768C1C433EF
	for <kexec@archiver.kernel.org>; Wed,  8 Jun 2022 00:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CLfbmcbAbq3hweh3qNV3PkAFnGHPbm894WFSD1vcJIs=; b=DyqfNxXJ9FxnAi
	gPbcMpYN0BTGspDx4U5v5K+UWr4XErhjznf8I+ZS4LXuZdVwsfgITd6nXqKJzcZrIO5y+fXU0mU7X
	fqpD7QlxkYHY7ENIvuSvH2mknXSHX0Q+s2IULlInD+0NKd3TLVmFs1kaEVsOuXOq/3xG6NC9dxedi
	8iJK8zGTFghfvKt8arh/5/ZcMMc7vGabBheNAyQ13VFF7h0CnbTyATxCtugmOVtQ7n0rIVbjlplzk
	ciQI2+TUfn5C/RFJstg9uWEnOgdTDmx8fgogB2iFg0BywQu6KafZbfu2fkMMs85Unb/EffkZkMR1G
	DI6BoBpT8FEesTpusXRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyk13-00AB08-EW; Wed, 08 Jun 2022 00:57:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyk10-00AAz0-Pk
	for kexec@lists.infradead.org; Wed, 08 Jun 2022 00:57:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1654649861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vPTB/7bKS227d/qHuHLFt/85sZuUpC11PLW3IwyD5sM=;
	b=PS3K6VuHEHSWBUF9YeAQPZzgq8Xp/gMDzqThnEigYTBPSassPD3xXrbtPIty+DeGS9iYBb
	gcwSlwCF0Al2Ze3SrMMeZdtfJZnods4IhVOOESUm8mQqlX0t5518ru/1eyuXZ04+yFmZhi
	mevIiNN4xfsaZNXTYwzIO4nPa6VUXlI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-318-ctHPKVURO3qn2sO5bj8SKA-1; Tue, 07 Jun 2022 20:57:37 -0400
X-MC-Unique: ctHPKVURO3qn2sO5bj8SKA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D8C23C01D82;
	Wed,  8 Jun 2022 00:57:37 +0000 (UTC)
Received: from localhost (ovpn-12-81.pek2.redhat.com [10.72.12.81])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F62C2166B26;
	Wed,  8 Jun 2022 00:57:36 +0000 (UTC)
Date: Wed, 8 Jun 2022 08:57:33 +0800
From: Baoquan He <bhe@redhat.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Sasha Levin <sashal@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>, rburanyi@google.com,
	Greg Thelen <gthelen@google.com>, viro@zeniv.linux.org.uk,
	kexec mailing list <kexec@lists.infradead.org>,
	linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] fs/kernel_read_file: Allow to read files up-to
 ssize_t
Message-ID: <Yp/z/f1IUaqS3qbe@MiWiFi-R3L-srv>
References: <20220527025535.3953665-1-pasha.tatashin@soleen.com>
 <20220527025535.3953665-2-pasha.tatashin@soleen.com>
 <Yp1qO70pdxLx4h1H@MiWiFi-R3L-srv>
 <CA+CK2bACmbW9saepkMy6G5FtssBhCv2NsoLGeFdF0XosKg5A-g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+CK2bACmbW9saepkMy6G5FtssBhCv2NsoLGeFdF0XosKg5A-g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220607_175742_946239_45BE75BF 
X-CRM114-Status: GOOD (  14.31  )
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

On 06/07/22 at 11:52am, Pasha Tatashin wrote:
> On Sun, Jun 5, 2022 at 10:45 PM Baoquan He <bhe@redhat.com> wrote:
> >
> > On 05/27/22 at 02:55am, Pasha Tatashin wrote:
> > > Currently, the maximum file size that is supported is 2G. This may be
> > > too small in some cases. For example, kexec_file_load() system call
> > > loads initramfs. In some netboot cases initramfs can be rather large.
> > >
> > > Allow to use up-to ssize_t bytes. The callers still can limit the
> > > maximum file size via buf_size.
> >
> > If we really met initramfs bigger than 2G, it's reasonable to increase
> > the limit. While wondering why we should take sszie_t, but not size_t.
> 
> ssize_t instead of size_t so we can return errors as negative values.

Makes sense. Thanks.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
