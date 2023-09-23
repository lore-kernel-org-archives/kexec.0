Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A188CE7A81
	for <kexec@archiver.kernel.org>; Sat, 23 Sep 2023 00:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9ZIAYiyiViHUlWH8hxsPKTRXWvv9F2CJuq2pxflekaM=; b=cwOpHly5nGqfBu
	MpEUeUnqZYu78dCIbNjgH6TolbeLLVyW1+xCu7DIbSr+5Hz917BgU3PreJ6qVBIBx1Gdn5ETRIiV5
	CiRWJtXp/b8HgajkjfOHwTx+AFYujyqrEdyAusa6lkk/XO4j/e5jRdUSIsF5i1WP0ejv/QeBRA6GL
	VKL4aKTN5kerpJQe1ICMEhpdSuQYAm9WErYecZ39kwV+ixiVuHB/9Mx5HcbmPjmbuUReq6GGA2l45
	pxi4+WJORu4UpMoB88ZlcTb6lDcTuWIfeOodMccNoJSnx/eeJ+P7kRAc3FYcgI9qSL8UJGZCbT0Qz
	hAvUzE341qZq32XXad9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjq8r-00A1DD-1u;
	Sat, 23 Sep 2023 00:05:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjq8p-00A1CN-0N
	for kexec@lists.infradead.org;
	Sat, 23 Sep 2023 00:05:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695427497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nRQ3+p4XcET1bcqGNVOLqwdH4/wR+jQ5PPEPDi382mU=;
	b=RhVCi26TMQb+smv4eQ8tK4f1JcbnVUGlWLQsXn1RcjqCYpnwV5m/8I+nNe7wENUgoas7X5
	0X8wmeb2gdS3NS67F+ci4MCv1zgA9mb3o693PkUueonq3JfvWlV83wwEQWEqLwvmg2618D
	wvVsGB2UjrpXgg6QvBKUF3NMzjccqpQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-298-GS7LEWNiP8ihW9ffbmUtzg-1; Fri, 22 Sep 2023 20:04:54 -0400
X-MC-Unique: GS7LEWNiP8ihW9ffbmUtzg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 99C54801779;
	Sat, 23 Sep 2023 00:04:53 +0000 (UTC)
Received: from localhost (unknown [10.72.112.18])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BF08851E3;
	Sat, 23 Sep 2023 00:04:52 +0000 (UTC)
Date: Sat, 23 Sep 2023 08:04:49 +0800
From: Baoquan He <bhe@redhat.com>
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org,
	vgoyal@redhat.com, dyoung@redhat.com, ebiederm@xmission.com,
	kexec@lists.infradead.org, sourabhjain@linux.ibm.com,
	konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] kexec: change locking mechanism to a mutex
Message-ID: <ZQ4rofBmfl/dn3x5@MiWiFi-R3L-srv>
References: <20230921215938.2192-1-eric.devolder@oracle.com>
 <xhsmh7coiuq8z.mognet@vschneid.remote.csb>
 <0ec5f56e-6b55-627a-39c0-ff0a1680794d@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0ec5f56e-6b55-627a-39c0-ff0a1680794d@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_170459_221719_D9EE91B9 
X-CRM114-Status: GOOD (  29.20  )
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

On 09/22/23 at 12:35pm, Eric DeVolder wrote:
> 
> 
> On 9/22/23 11:28, Valentin Schneider wrote:
> > On 21/09/23 17:59, Eric DeVolder wrote:
> > > The design decision to use the atomic lock is described in the comment
> > > from kexec_internal.h, cited above. However, examining the code of
> > > __crash_kexec():
> > > 
> > >          if (kexec_trylock()) {
> > >                  if (kexec_crash_image) {
> > >                          ...
> > >                  }
> > >                  kexec_unlock();
> > >          }
> > > 
> > > reveals that the use of kexec_trylock() here is actually a "best effort"
> > > due to the atomic lock.  This atomic lock, prior to crash hotplug,
> > > would almost always be assured (another kexec syscall could hold the lock
> > > and prevent this, but that is about it).
> > > 
> > > So at the point where the capture kernel would be invoked, if the lock
> > > is not obtained, then kdump doesn't occur.
> > > 
> > > It is possible to instead use a mutex with proper waiting, and utilize
> > > mutex_trylock() as the "best effort" in __crash_kexec(). The use of a
> > > mutex then avoids all the lock acquisition problems that were revealed
> > > by the crash hotplug activity.
> > > 
> > 
> > @Dave thanks for the Cc, I'd have missed this otherwise.
> > 
> > 
> > Prior to the atomic thingie, we actually had a mutex and did
> > mutex_trylock() in __crash_kexec(). I'm a bit confused as this looks like a
> > revert of
> >    05c6257433b7 ("panic, kexec: make __crash_kexec() NMI safe")
> > with just the helpers kept in - this doesn't seem to address any of the
> > original issues regarding NMIs?
> > 
> > Sebastian raised some good points in [1] regarding these issues.
> > The main hurdle pointed out there is, if we end up in the slowpath during
> > the unlock, then we can can up acquiring the ->wait_lock which isn't NMI
> > safe.
> > 
> > This is even worse on PREEMPT_RT, as both trylock and the unlock can end up
> > acquiring the ->wait_lock.
> > 
> > [1]: https://lore.kernel.org/all/YqyZ%2FUf14qkYtMDX@linutronix.de/
> > 
> Having reviewed the references, it would seem that Baoquan's approach of a new
> lock to handle the hotplug activity is the way to go?

If so, I have posted a formal one. It's simple and should work to fix
the issue.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
