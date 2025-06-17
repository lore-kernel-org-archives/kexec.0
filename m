Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFD8C7115F
	for <kexec@archiver.kernel.org>; Tue, 17 Jun 2025 08:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tuESWdgQF0sreM50+xMhPqu+zRbHva+ThYdTCQTTky8=; b=HFzkgIgOHMaVqplZWce3HW17tp
	RB9GqODsCpgVnfZXau+to+YUWgBJ4S4tgm0avegI1ODOWDOvqMh+r1Hwn+R2RP8rXAkwFgzxdx6RX
	aB8+gQhCf1AS70j1sAfK+vX+AAH7GQeG/sjMr1htxXqwO+V86jR/sFfrFuqBY8mIWf/urUZQqNWq2
	yv4i0wD6QkjvHcXtQnCdF7mVWx0sT1Ff2NosIxD7XTCR68cNlNKjzM5jrbjtIUfdpJd7ixiPccQCt
	QevEezUpa/wrFXzT9j94ae/dATPq3/kz7i/YqL6JhGB/nC1qKudnqVWqIvS1yg8Xsl86SNuFdKgAx
	7w0m3wiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRRsp-00000006ctH-26Ej;
	Tue, 17 Jun 2025 08:41:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRRdt-00000006b1v-4B2A
	for kexec@lists.infradead.org;
	Tue, 17 Jun 2025 08:26:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750148763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tuESWdgQF0sreM50+xMhPqu+zRbHva+ThYdTCQTTky8=;
	b=B7YeHmWFWJDxd921vDcV0iOtYoi3Y5b9tJRLnzJWuIRQlc3CdrsVcLhhzyVMTeCOGMbmWw
	fjd2AJO1pNW9l1sy3LGPDLptJYkt9iE7pL0Kkwlr2T8gbaz+q56D90fkod5oEhldAaDeln
	IqibQ2qLM+IWyi5gVn4wyihBikU5rRo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-pQNieNqsM8eGs0Z9CKa3gg-1; Tue,
 17 Jun 2025 04:26:00 -0400
X-MC-Unique: pQNieNqsM8eGs0Z9CKa3gg-1
X-Mimecast-MFC-AGG-ID: pQNieNqsM8eGs0Z9CKa3gg_1750148759
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B6FD91809C8F;
	Tue, 17 Jun 2025 08:25:58 +0000 (UTC)
Received: from localhost (unknown [10.72.112.135])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C95B819560A3;
	Tue, 17 Jun 2025 08:25:56 +0000 (UTC)
Date: Tue, 17 Jun 2025 16:25:51 +0800
From: Baoquan He <bhe@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	coxu@redhat.com, piliu@redhat.com, pmenzel@molgen.mpg.de,
	chenste@linux.microsoft.com, kexec@lists.infradead.org
Subject: Re: [PATCH v3] ima: add a knob ima= to allow disabling IMA in kdump
 kernel
Message-ID: <aFEmj7ZuuMgOplZK@MiWiFi-R3L-srv>
References: <20250614022342.5988-1-bhe@redhat.com>
 <ca82fa443365217535aedacbcdf823370f387995.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca82fa443365217535aedacbcdf823370f387995.camel@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250617_012606_107145_2B589877 
X-CRM114-Status: GOOD (  15.73  )
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

On 06/16/25 at 10:04am, Mimi Zohar wrote:
> On Sat, 2025-06-14 at 10:23 +0800, Baoquan He wrote:
> > Kdump kernel doesn't need IMA functionality, and enabling IMA will cost
> > extra memory. It would be very helpful to allow IMA to be disabled for
> > kdump kernel.
> > 
> > Hence add a knob ima=on|off here to allow turning IMA off in kdump
> > kernel if needed.
> > 
> > Note that this IMA disabling is limited to kdump kernel, please don't
> > abuse it in other kernel and thus serious consequences are caused.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> > v2->v3:
> > - Remove rdundant word 'only' and rephrase sentences in patch log code
> >   comment, and rephrase patch subject, thanks to Mimi's comments.
> 
> Thanks, Baoquan.  The patch is now queued.

Thanks a lot for your patience, careful reviewing and great suggestions.


