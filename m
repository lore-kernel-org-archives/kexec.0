Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B684E7F148
	for <kexec@archiver.kernel.org>; Wed, 27 Sep 2023 00:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0iIc7LkGY/GYqLGvyWtvpLLQtlead5q1Ui87Y8A7EKU=; b=usqVqJsXw02qYJ
	ptImhx/eAwF2lxpJGNbhgfG2Qd0muJIs5Xz9dcD+vzqG1Kq3USRU+JPn7DbXTtPcGkvbmidh2ly0e
	eGpwN5gbkWgcjqsVhdQXF1tqJHjrVckWNDgzIhbM+wwawPPrlrIfejccYaK3w9kM8s8j4GIwj51MS
	FOxjFkIHuaaXTn4unjF7xxsZeS8mGOpoRpAsqSo2jDGwDPOapHpW5koAF+O2qeQ6G7VqA6iCWhzn0
	M9/TORXH2EasdyqnQAkEAzkAlNjgrNKe6yIo2hd9bKzGqTOipse8l5ELPYYxKddoLP2k9z3QBPvsr
	urC5UV6guCb77lP+qGSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlICd-00HEVZ-1n;
	Wed, 27 Sep 2023 00:14:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlICa-00HEUY-0J
	for kexec@lists.infradead.org;
	Wed, 27 Sep 2023 00:14:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695773689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MwEDd7lXj2bXGV+so2/RWLmuszrHLj3xfaoIMd/pJXo=;
	b=Zs8GbZ7Nc2qSu37hEg5E/rbPVKMyOIRmJOdINOETLsmL+7NMP1/ARJR1kTnqiYR4GAMHdl
	z32lBJXkvdqjziEgOdeixC1E8QtV8xCqLndE11J3r2tsFBOMfe9h8AKHaonjED/G88Ot5k
	gPnGdQz/vFv2KcnUcfm57LhNpAgRrck=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-oDALSo7ZOnaxTmKVT_hOCQ-1; Tue, 26 Sep 2023 20:14:45 -0400
X-MC-Unique: oDALSo7ZOnaxTmKVT_hOCQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1836485A5BE;
	Wed, 27 Sep 2023 00:14:45 +0000 (UTC)
Received: from localhost (unknown [10.72.112.58])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 567262026D4B;
	Wed, 27 Sep 2023 00:14:44 +0000 (UTC)
Date: Wed, 27 Sep 2023 08:14:41 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Eric DeVolder <eric.devolder@oracle.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	vschneid@redhat.com, sourabhjain@linux.ibm.com
Subject: Re: [PATCH v3] Crash: add lock to serialize crash hotplug handling
Message-ID: <ZRNz8T1XOX7PWOt6@MiWiFi-R3L-srv>
References: <20230926120905.392903-1-bhe@redhat.com>
 <20230926135001.4eb6ca73b1a4aa6224355ad1@linux-foundation.org>
 <11bebd5e-8183-d7a7-6acc-53b00a6cc2d5@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <11bebd5e-8183-d7a7-6acc-53b00a6cc2d5@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230926_171452_224267_F274CF09 
X-CRM114-Status: GOOD (  12.66  )
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

On 09/26/23 at 04:53pm, Eric DeVolder wrote:
> 
> 
> On 9/26/23 15:50, Andrew Morton wrote:
> > On Tue, 26 Sep 2023 20:09:05 +0800 Baoquan He <bhe@redhat.com> wrote:
> > 
> > > Eric reported that handling corresponding crash hotplug event can be
> > > failed easily when many memory hotplug event are notified in a short
> > > period. They failed because failing to take __kexec_lock.
> > 
> > I'm assuming that this failure is sufficiently likely so as to  justify a -stable
> > backport of the fix.   Please let me know if this is incorrect.
> 
> Andrew,
> Correct, this is sufficiently likely to happen.

Agree. Maybe a Fixes tag need be added:
===
Fixes: 247262756121 ("crash: add generic infrastructure for crash hotplug support")


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
