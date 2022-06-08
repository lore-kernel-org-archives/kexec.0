Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4124C433EF
	for <kexec@archiver.kernel.org>; Wed,  8 Jun 2022 00:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c+yy5cZ1i1jpZiFBAy1B85hJqbNUUevF7opwMoUwLuI=; b=Kis81WG7wDB9P1
	NB5wIPFaWeUsSJwQLrnlIswJmkRBueB8g/uECc10GF3U5fJez3lv0eXtJdg9kub47he4osmjvh0gQ
	cMikXTU6XnRlm9sYbKY7xS5BQFeshoUlN1ahRCs7w+ZIUmv4KeYqwBQotu9c77Z/p4l2dFnt0mnIQ
	cbs/lpPE37kDkMtXnSxRS6BeiOj9Z55Ykm0Y6vain+1YkBiZpjIWA5u+JYWBUWmmq8ECvK44XVhYI
	WV0q63iC5nAktRUP/5yrVseTDo9HTWQ85RhVo6MBLzoqy8YPcivA5bTotjA5U/MGO2mz1G1irJPA1
	KHZKLIBXoPwj0mi6W6TQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyjZ2-00A7SR-5v; Wed, 08 Jun 2022 00:28:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyjYy-00A7Rb-R7
	for kexec@lists.infradead.org; Wed, 08 Jun 2022 00:28:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1654648123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V5n7RskVKP1lkUAH2EjF8RedQEXHRrdfvn+kcEQHl4g=;
	b=hotgTz3ECyIVB1X/Zbsn3chR31F25Ko+6CJK5paZpBND1Jq4k2+jO6EU/cSkLGssi5HKIu
	0g2E0dRqbrps3bDbLlYB/9ovC5F4uJk+xZu2mXuz87XzV5K4BW7ZKUwyEHyvxRhObWosLo
	vPlixNae/Ado2GqJwwlvovTIFgjLEv4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-171-vA2S3ik2NfO8vrB9KFwFzA-1; Tue, 07 Jun 2022 20:28:40 -0400
X-MC-Unique: vA2S3ik2NfO8vrB9KFwFzA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BDFF580159B;
	Wed,  8 Jun 2022 00:28:39 +0000 (UTC)
Received: from localhost (ovpn-12-81.pek2.redhat.com [10.72.12.81])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 87C1840466A3;
	Wed,  8 Jun 2022 00:28:38 +0000 (UTC)
Date: Wed, 8 Jun 2022 08:28:31 +0800
From: Baoquan He <bhe@redhat.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Sasha Levin <sashal@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>, rburanyi@google.com,
	Greg Thelen <gthelen@google.com>, viro@zeniv.linux.org.uk,
	kexec mailing list <kexec@lists.infradead.org>,
	linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] kexec_file: Increase maximum file size to 4G
Message-ID: <Yp/tL5F7TFdwk8Sj@MiWiFi-R3L-srv>
References: <20220527025535.3953665-1-pasha.tatashin@soleen.com>
 <20220527025535.3953665-3-pasha.tatashin@soleen.com>
 <Yp1s2c0hyYzM4hbz@MiWiFi-R3L-srv>
 <CA+CK2bC5U5j1xkZKuOETANo1=PPpbJn2mKYOa2fK1GLFib0ibw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+CK2bC5U5j1xkZKuOETANo1=PPpbJn2mKYOa2fK1GLFib0ibw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220607_172844_992573_6C15CC69 
X-CRM114-Status: GOOD (  25.30  )
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

On 06/07/22 at 12:02pm, Pasha Tatashin wrote:
> On Sun, Jun 5, 2022 at 10:56 PM Baoquan He <bhe@redhat.com> wrote:
> >
> > On 05/27/22 at 02:55am, Pasha Tatashin wrote:
> > > In some case initrd can be large. For example, it could be a netboot
> > > image loaded by u-root, that is kexec'ing into it.
> > >
> > > The maximum size of initrd is arbitrary set to 2G. Also, the limit is
> > > not very obvious because it is hidden behind a generic INT_MAX macro.
> > >
> > > Theoretically, we could make it LONG_MAX, but it is safer to keep it
> > > sane, and just increase it to 4G.
> >
> > Do we need to care about 32bit system where initramfs could be larger
> > than 2G? On 32bit system, SSIZE_MAX is still 2G, right?
> 
> Yes, on 32-bit SSIZE_MAX is still 2G, so we are safe to keep 32-bit
> systems run exactly as today.
> 
> #define KEXEC_FILE_SIZE_MAX    min_t(s64, 4LL << 30, SSIZE_MAX)
> Is meant to protect against running over the 2G limit on 32-bit systems.

OK. In fact I was wrong. I386 doesn't have kexec_file loading support.

> 
> >
> > Another concern is if 2G is enough. If we can foresee it might need be
                          ~~ 4G, typo
> > enlarged again in a near future, LONG_MAX certainly is not a good
> > value, but a little bigger multiple of 2G can be better?
> 
> This little series enables increasing the max value above 2G, but
> still keeps it within a sane size i.e. 4G, If 4G seems too small, I
> can change it to 8G or 16G instead of 4G.

Just raising to try to discuss if 4G is enough. I have no knowledge
about how much is enough, and we don't need to guess, if you think 4G is
enough according to information you get, that's OK. We can wait a while
to see if other people have words about the vlaue. If no, then 4G is a
good one.

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
