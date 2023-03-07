Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 233E2C61DA4
	for <kexec@archiver.kernel.org>; Tue,  7 Mar 2023 03:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/w7846YCFhmCHx4P8rxxpgy2sxIZr1rIBOUr4tLlMys=; b=RTGK7Y126zI4k9
	YR6Db0vwasgPk1Smgt22ojlTa+uYovdVpDShLlbDq8fBPl6baBZQwDqDwHYoILk+uu1TDi6kmD/LS
	xEHJTTxv1j/P5e2HQRtq9f2JDDSmkpkqYGrz3VG966mfh0tKzi/qnJp684dsUAHhYRByJQqLhXkoa
	JYTrSFngwzO49+k499ZkaXTsQbAOb//sAeb7b6aIxEhlxI5FZ+b1oC/B6mEAmaMM7Xbv1sd6GGzn2
	mfklpk48uMN6+sMPg6Z91mCAsr3TQ/vaj8TxewQ3hO/NdC1bS4I+bhtvjPj1C+uUSVV3htdMWwtrQ
	5Rxn9FKCtVYlxZEIx55w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZO0D-00G2vt-5V; Tue, 07 Mar 2023 03:28:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZO05-00G2uc-G5
	for kexec@lists.infradead.org; Tue, 07 Mar 2023 03:28:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1678159703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=krvsyVnQOzCxSAiThCfP2vsIzesMA2g4BaaJjjXhtwU=;
	b=h2B6Ohdsu8bbqpwHvgdSgbTfc/o4oq16U0676T4+IN0pc5p6wiIWsocwTMsGK4Fe6b9/Vk
	62lz+Hmp5S+j1ZyDy+rJ1McmeAxb+HSz7q0385KDtK9DXriLWXySf573fNNhfOlarzDXyF
	WaLz/0TkOoC2XpvcYbbsrPGOxV4M4zQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-84-BUI5Cx3DNvOqU4M_SoKz1A-1; Mon, 06 Mar 2023 22:28:19 -0500
X-MC-Unique: BUI5Cx3DNvOqU4M_SoKz1A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55EF3101A52E;
	Tue,  7 Mar 2023 03:28:19 +0000 (UTC)
Received: from localhost (ovpn-12-63.pek2.redhat.com [10.72.12.63])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6CFB71121314;
	Tue,  7 Mar 2023 03:28:18 +0000 (UTC)
Date: Tue, 7 Mar 2023 11:28:15 +0800
From: Baoquan He <bhe@redhat.com>
To: Philipp Rudo <prudo@redhat.com>
Cc: Youling Tang <tangyouling@loongson.cn>, Simon Horman <horms@kernel.org>,
	kexec@lists.infradead.org
Subject: Re: [PATCH 1/2] kexec: Default __NR_kexec_file_load is set to
 undefined
Message-ID: <ZAavT+pFKb00lKD8@MiWiFi-R3L-srv>
References: <1677232268-2451-1-git-send-email-tangyouling@loongson.cn>
 <20230227161919.7c4884cd@rotkaeppchen>
 <Y/4CaolPP0U4h6bB@MiWiFi-R3L-srv>
 <20230303120319.67307b61@rotkaeppchen>
MIME-Version: 1.0
In-Reply-To: <20230303120319.67307b61@rotkaeppchen>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230306_192829_768787_6CA24C21 
X-CRM114-Status: GOOD (  29.23  )
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

On 03/03/23 at 12:03pm, Philipp Rudo wrote:
> Hi Baoquan,
> 
> On Tue, 28 Feb 2023 21:32:26 +0800
> Baoquan He <bhe@redhat.com> wrote:
> 
> > Hi Philipp,
> > 
> > On 02/27/23 at 04:19pm, Philipp Rudo wrote:
> > ...... 
> > > > diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
> > > > index be6ccd5..ea77936 100644
> > > > --- a/kexec/kexec-syscall.h
> > > > +++ b/kexec/kexec-syscall.h
> > > > @@ -59,9 +59,7 @@
> > > >  #endif
> > > >  #endif /*ifndef __NR_kexec_load*/
> > > >  
> > > > -#ifdef __arm__
> > > >  #undef __NR_kexec_file_load
> > > > -#endif
> > > >  
> > > >  #ifndef __NR_kexec_file_load  
> > > 
> > > I don't think this will work as intended. 
> > > 
> > > On the top of the file sys/syscall.h gets included. In there
> > > architectures that support kexec_file_load define __NR_kexec_file_load.
> > > This also means that if an architecture doesn't support kexec_file_load
> > > __NR_kexec_file_load shouldn't be defined in the first place. Thus I
> > > suggest that you find out why sys/syscall.h defines
> > > __NR_kexec_file_load for LoongArch even when the system call is not
> > > supported and fix it there.  
> > 
> > Checking whether LoongArch has defined __NR_kexec_file_load sounds a
> > good suggestion. Wondering why we still need add __NR_kexec_file_load
> > definition in kexec-tools. E.g below s390 kexec_file support you added.
> > <sys/syscall.h> sometime won't be found or __NR_kexec_file_load could be
> > not defined yet?
> > 
> > commit d4a948c268272cf37c71be820fb02bf40e56292b
> > Author: Philipp Rudo <prudo@linux.ibm.com>
> > Date:   Wed May 16 14:27:18 2018 +0200
> > 
> >     kexec/s390: Add support for kexec_file_load
> > 
> 
> To be honest I don't remember why I have added it back then. Most
> likely I simply copied what others have done before.
> 
> The benefit in having the extra definition I see is that you don't need
> to rebuild glibc when you implement the syscall and don't use the
> generic unistd.h. But that is something only few people should ever
> encounter.

OK, got it. From the code, the adding won't cuase issue, but a double
insurance, not sure if it's redundant. Someone interested can
investigate and clean up if needed.

Thanks for the information.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
