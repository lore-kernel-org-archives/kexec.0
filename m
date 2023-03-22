Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3CD4C761A6
	for <kexec@archiver.kernel.org>; Wed, 22 Mar 2023 14:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SM5qOfj2gwSogGTQvxD5OHksg6Tlb9l8lbNKyNR/nxk=; b=EpMZcVTq5THx6O
	hz891FwSRUbOU8GiChnkA5emKUG8zmehWRxFGVs28f/MQTxUTL1VOJK1larhImHfZSpEkZbRi5jyx
	6UP8i4XTGosnccRlVgdov0UsgqwG+bZUIfGeEhx3yJ9zGqjduEjhmEJkxvAxEOM/oXtDjTnT1LXsZ
	jqdUv4tz3bn+Po8/DfX+HPlSwOc18Pmxwd4wvNgMeNFWacm3wyB9q/U0iH7kkSmjs0BnakNnF9Wqp
	+Uo/ruwOZLYa22QNxmO6HDfmyccigyinT/1p7Bpo1x6OM8O7k+157QN25T146WfexvniJA8nAaRGk
	Hnv6H6llF3Hyw4Nrxv/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pezp7-00GNkn-0O;
	Wed, 22 Mar 2023 14:52:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pezp4-00GNjr-1V
	for kexec@lists.infradead.org;
	Wed, 22 Mar 2023 14:52:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1679496737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yd8xp51YysAjXirymoem/GVNmv6KZ1BXPi2JfEf4sqg=;
	b=ENXop1Rt8F3bcGUQWFslfk0aTibcJY1bEIxL0AnEG+iPA8qd+++SviLuHEAV8bKdzqZbPI
	RrtxtV1ag8j91KKLR0UjkmxLR8GPwu54pF+QKlwVuZZP7Egh3TvGq/1dwuy2Nb/M9teO0q
	ORTK6dAMNJlVqNNEL/ZC+QG56ReeGa0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-jcCXm_MtO56UVePGUKvZ6A-1; Wed, 22 Mar 2023 10:52:14 -0400
X-MC-Unique: jcCXm_MtO56UVePGUKvZ6A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B6DB886068;
	Wed, 22 Mar 2023 14:52:13 +0000 (UTC)
Received: from localhost (ovpn-12-97.pek2.redhat.com [10.72.12.97])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D610B202701F;
	Wed, 22 Mar 2023 14:52:12 +0000 (UTC)
Date: Wed, 22 Mar 2023 22:52:04 +0800
From: Baoquan He <bhe@redhat.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Philipp Rudo <prudo@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH] kexec: Support purgatories with .text.hot sections
Message-ID: <ZBsWFOb9wDGSwRSW@MiWiFi-R3L-srv>
References: <20230321-kexec_clang16-v1-0-a768fc2c7c4d@chromium.org>
 <ZBsSBr87al9ccG96@home.goodmis.org>
 <CANiDSCt_wvaHBq-Yss0QaKTtefBhWwtahFO8_jw6CPSvBwbbMg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANiDSCt_wvaHBq-Yss0QaKTtefBhWwtahFO8_jw6CPSvBwbbMg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_075218_581266_E39F88D0 
X-CRM114-Status: GOOD (  28.76  )
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

On 03/22/23 at 03:42pm, Ricardo Ribalda wrote:
> Hi Steven
> 
> On Wed, 22 Mar 2023 at 15:34, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Tue, Mar 21, 2023 at 12:49:08PM +0100, Ricardo Ribalda wrote:
> > > Clang16 links the purgatory text in two sections:
> > >
> > >   [ 1] .text             PROGBITS         0000000000000000  00000040
> > >        00000000000011a1  0000000000000000  AX       0     0     16
> > >   [ 2] .rela.text        RELA             0000000000000000  00003498
> > >        0000000000000648  0000000000000018   I      24     1     8
> > >   ...
> > >   [17] .text.hot.        PROGBITS         0000000000000000  00003220
> > >        000000000000020b  0000000000000000  AX       0     0     1
> > >   [18] .rela.text.hot.   RELA             0000000000000000  00004428
> > >        0000000000000078  0000000000000018   I      24    17     8
> > >
> > > And both of them have their range [sh_addr ... sh_addr+sh_size] on the
> > > area pointed by `e_entry`.
> > >
> > > This causes that image->start is calculated twice, once for .text and
> > > another time for .text.hot. The second calculation leaves image->start
> > > in a random location.
> > >
> > > Because of this, the system crashes inmediatly after:
> > >
> > > kexec_core: Starting new kernel
> > >
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > To: Eric Biederman <ebiederm@xmission.com>
> > > Cc: Philipp Rudo <prudo@linux.vnet.ibm.com>
> > > Cc: kexec@lists.infradead.org
> > > Cc: linux-kernel@vger.kernel.org
> > > ---
> > >  kernel/kexec_file.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > > index f1a0e4e3fb5c..b1a25d97d5e2 100644
> > > --- a/kernel/kexec_file.c
> > > +++ b/kernel/kexec_file.c
> > > @@ -904,7 +904,8 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
> > >               if (sechdrs[i].sh_flags & SHF_EXECINSTR &&
> > >                   pi->ehdr->e_entry >= sechdrs[i].sh_addr &&
> > >                   pi->ehdr->e_entry < (sechdrs[i].sh_addr
> > > -                                      + sechdrs[i].sh_size)) {
> > > +                                      + sechdrs[i].sh_size) &&
> > > +                 kbuf->image->start != pi->ehdr->e_shnum) {
> >
> > Shouldn't this be: kbuf->image->start == pi->ehdr->e_shnum) {
> 
> You are absolutely right, I screwed up when I ported the code from my
> test tree to the tree that I use for upstreaming.
> Instead of removing all the printks I wrote code.
> 
> :S
> 
> Will resend the patch

When you resne patch, please fix Philipp's mail adress as
'Philipp Rudo <prudo@redhat.com>' if he should know this. He has joined
Redhat.

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
