Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBC4C352A1
	for <kexec@archiver.kernel.org>; Wed,  7 Dec 2022 12:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wVV9O1o4RNjUqmh1idSfq7EGn6HjR6dc1h4LwlOy8Uo=; b=j85+TZlgpaP95D
	EMga53wFBHvCVqpFadmMBTqof6JbApZuTwr/1tO93xda5urau0Iu9XOSmgM4H87S0a5Ru9d4CPPQe
	i8tjyZGwX65AtEM1TfUfsn6UrIgpE5duUtM0PaxuCqlOf47Vu2D4dBiDDNfOcJomS6Bd1VcPUQWs8
	IB+6ShFWZaVJOWx/krkDH4rQ4uOdqS/VgBrmvtdarZSv8+tR+jv5MYeu9XxZiystqRx6eX+dWXf39
	zWY8YlSizvmblwdXzAgJQVSFIGyk3vg3L22iBmEnGtf2fdbdKk+Jzbxe3LtM5BH7i+0uyrnCgPFE/
	ss60VZURTTflNisvzA1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2tf7-002ZbH-0R; Wed, 07 Dec 2022 12:36:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2tf4-002Za9-9h
	for kexec@lists.infradead.org; Wed, 07 Dec 2022 12:36:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1670416588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9atWu9JU4Cx+ETdJlBYNzYOikPveUu+xlZLV8W2MIpw=;
	b=bi8xuoGAoBBorLpbBdbO3inGXM9si7s/wwi9wlFczWv6a73aTrzYffi+Nz6Yb2Mb0GODuc
	7qtPwJKHUsq/vQyZqY2OTCuHNUoe37LGtFZWi/E0cWdczWcvvZ9yy7AhfB6SKCIcvECMNp
	QZLI5t6EDpt2gVh0l5XNGxfJc8KroT8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-KQv1VQ-TPnmsF6_VZrQsNw-1; Wed, 07 Dec 2022 07:36:24 -0500
X-MC-Unique: KQv1VQ-TPnmsF6_VZrQsNw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D86A380450D;
	Wed,  7 Dec 2022 12:36:23 +0000 (UTC)
Received: from localhost (ovpn-13-181.pek2.redhat.com [10.72.13.181])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 378A620FD3AA;
	Wed,  7 Dec 2022 12:36:22 +0000 (UTC)
Date: Wed, 7 Dec 2022 20:36:13 +0800
From: Baoquan He <bhe@redhat.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Eric DeVolder <eric.devolder@oracle.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
	dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
	nramas@linux.microsoft.com, thomas.lendacky@amd.com,
	robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
	sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
	boris.ostrovsky@oracle.com
Subject: Re: [PATCH v14 3/7] crash: add generic infrastructure for crash
 hotplug support
Message-ID: <Y5CIvcZLuokwyGYT@MiWiFi-R3L-srv>
References: <20221116214643.6384-1-eric.devolder@oracle.com>
 <20221116214643.6384-4-eric.devolder@oracle.com>
 <Y4A1/cSekXUTFriC@MiWiFi-R3L-srv>
 <Y5BkL8x01KWoF502@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y5BkL8x01KWoF502@zn.tnic>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221207_043630_432773_BAAEFFBE 
X-CRM114-Status: GOOD (  13.96  )
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

On 12/07/22 at 11:00am, Borislav Petkov wrote:
> On Fri, Nov 25, 2022 at 11:26:53AM +0800, Baoquan He wrote:
> > This kernel config CRASH_HOTPLUG is added in patch 7, but we have used
> > it in the previous patch, not sure if this is acceptable.
> 
> Why would it not be acceptable?

Below is my last reply to Eric about my thinking on this. That would be
great if it's a normal situation when adding Kconfig item, I am happy to
learn this if it's confirmed normal.

=====
Hmm, since it's bisect-able, seems doesn't break rule. I could be too
sensitive. Do we have a precendent like this, to strengthen our
confidence?

If no concern from other people, it's also fine to me.
=====

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
