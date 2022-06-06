Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D55D8C43334
	for <kexec@archiver.kernel.org>; Mon,  6 Jun 2022 03:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KLAV3qzLk+stYJ5LTIsOfeqrhi0eP7QevKEdhoRc74Y=; b=oagpQu3zBLwR8l
	TkMiTINOIz9tYW+Drm7AYe8aGLPJiMITTxzNPx2PF6hXUfUWYCf3FHzn/Ey5UnC74qREC5z84E6+k
	+xALYVadp/WbLxYM/Mg5EHgGbGtQJ9DpQE48x7CnC/RMjXdAG8jygKQuK6DdrZxN0nCqy/0eubxKr
	4Lgc06oVnUvVm5lBSSZgIkeyRXdWwRG1KgOOs6YoFZOa3kChp7AY6L/+gkEtdCSBOBeVRzBYjiZ+x
	5Ko3+lxDu4Y6TGn89Wx57Y5nkc6Gcl2XZ71iQ3ym0u6sT0jI7gL1dvhreKsQ1sUpL6o9xQ6vtq8HA
	m20poN45Fi+MAxCj3tMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ny3pN-00Gdo1-Mk; Mon, 06 Jun 2022 03:54:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ny3pL-00Gdne-2D
	for kexec@lists.infradead.org; Mon, 06 Jun 2022 03:54:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1654487688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i5iEgTqlGFXZU9nwYiUMELTTny6xbpViLZQTc0dGuT4=;
	b=NVStVK0bn3BR6FAVbMcL9mK4bfnrxBa6DZMHh5XS23H0koAnIKTBQKP+iT9iR1x5wIvxJe
	YXcgcE+rDu0LzhFB/59f/4JcAZVQDDHfsXU21BtUzXPzXodJN7Zki4cAJzZ22ZNIazdnt+
	36fu2Yu+SrQxv5t+VUrAbehm1FByRWw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-IQrCFuIjN8215spNptb1Rg-1; Sun, 05 Jun 2022 23:54:42 -0400
X-MC-Unique: IQrCFuIjN8215spNptb1Rg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41FCD398CA60;
	Mon,  6 Jun 2022 03:54:41 +0000 (UTC)
Received: from localhost (ovpn-12-209.pek2.redhat.com [10.72.12.209])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AB65D403371;
	Mon,  6 Jun 2022 03:54:38 +0000 (UTC)
Date: Mon, 6 Jun 2022 11:54:35 +0800
From: Baoquan He <bhe@redhat.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Jonathan McDowell <noodles@fb.com>, Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org
Subject: Re: [PATCH v4] x86/kexec: Carry forward IMA measurement log on kexec
Message-ID: <Yp16e5hMphomr2+H@MiWiFi-R3L-srv>
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
 <YmgjXZphkmDKgaOA@noodles-fedora-PC23Y6EG>
 <YnuJCH75GrhVm0Tp@noodles-fedora.dhcp.thefacebook.com>
 <Yn01Cfb3Divf49g7@noodles-fedora.dhcp.thefacebook.com>
 <8634d4dd0813b9522f039ed211023c2c65c6f888.camel@linux.ibm.com>
 <YpSC4AQInLM73wex@noodles-fedora.dhcp.thefacebook.com>
 <e7758ed1-5dcb-80dd-092a-a6bb21c3997d@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e7758ed1-5dcb-80dd-092a-a6bb21c3997d@intel.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220605_205451_214908_6D661C87 
X-CRM114-Status: GOOD (  16.19  )
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

On 06/03/22 at 08:55am, Dave Hansen wrote:
> On 5/30/22 01:40, Jonathan McDowell wrote:
> > Borislav,
> > 
> > I don't think there are any outstanding review comments for me to deal
> > with on this, so is it safe to assume it'll get picked up at some point
> > once the merge window calms down?
> 
> Nothing here looks too crazy, but it's still been _very_ lightly
> reviewed.  It doesn't seem like anyone from the kexec world has seen it,
> for instance.
> 
> Mimi's review was a great start, but it would be really nice to make
> sure that the kexec bits look good.

The change looks good from kexec/kdump side. Not sure if Eric has
any concern.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
