Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCC6D74954
	for <kexec@archiver.kernel.org>; Wed, 30 Oct 2024 02:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=quEj3WP+kAUrG/xyZGNZE3at5jVZYH9GGkaC6yg/jNo=; b=P3MSybjd6cBYZC
	LhRH0B/rrBGT44rQsC8l51GojJSur0BshyeIxEQslCOOetHbH0ZUVMzZMYqyqjxpZaFeRMb8M7DT5
	l4x4sNihiwo1OT/9Q7jjsfrXn+Sk8aML+TQ1NuT0645INa3tfXb822tcoMp7PiaR9Ic9OPl5Ptiby
	bQJnFayOv5UiIcMOGEUPCj/yEnvZsN9KJuAXfNnucROxn2kh11KSBg2+wCWF3W+w01sZhhdpJmfZR
	fF4ok9E/YvBY+3lzj3Gsk1dAI9li4f6HQfIxJHOB+jA7Qr5hqOdj598lztqg9RifVFMj6dSHu9iaM
	9odr0U0+bdnmvF0ujNcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5yqu-0000000GYm1-3xlA;
	Wed, 30 Oct 2024 02:54:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5yqr-0000000GYlI-30yH
	for kexec@lists.infradead.org;
	Wed, 30 Oct 2024 02:54:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730256868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9MajDa86shltyihCJs2RWiiHVZZLIphX6dVVnM3/Ivw=;
	b=UT0dvYBck6wvcbKSExCyNIDVc9OBagriLvhDuLSsAQeMMushFXnWjh89PdQL7nuYuVVrfI
	a2Zwn4r9Zub0cKaywgYMoFLOICnkVO3N5T1Ljt08Zj4l7/pntrgmx9Wn7QFkyDWk3Ph0eO
	Tv0PJ4H7DGEXXI/RvjHJMMLM3NpXIco=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-oqLcKpGVNSKeFJnwoe99ow-1; Tue,
 29 Oct 2024 22:54:24 -0400
X-MC-Unique: oqLcKpGVNSKeFJnwoe99ow-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 367F6195608A;
	Wed, 30 Oct 2024 02:54:23 +0000 (UTC)
Received: from localhost (unknown [10.72.112.14])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 58B4A19560A2;
	Wed, 30 Oct 2024 02:54:20 +0000 (UTC)
Date: Wed, 30 Oct 2024 10:54:16 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
	dyoung@redhat.com, daniel.kiper@oracle.com, noodles@fb.com,
	lijiang@redhat.com, kexec@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH v3 0/2] x86/mm/sme: fix the kdump kernel breakage on SME
 system when CONFIG_IMA_KEXEC=y
Message-ID: <ZyGf2PZtf4H+dE9u@MiWiFi-R3L-srv>
References: <20240911081615.262202-1-bhe@redhat.com>
 <20241029182306.04c3451808c8b76e5e96fdb4@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241029182306.04c3451808c8b76e5e96fdb4@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_195429_855680_47CAB9BD 
X-CRM114-Status: GOOD (  19.38  )
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

On 10/29/24 at 06:23pm, Andrew Morton wrote:
> On Wed, 11 Sep 2024 16:16:13 +0800 Baoquan He <bhe@redhat.com> wrote:
> 
> > Currently, distros like Fedora/RHEL have enabled CONFIG_IMA_KEXEC by
> > default. This makes kexec/kdump kernel always fail to boot up on SME
> > platform because of a code bug. By debugging, the root cause is found
> > out and bug is fixed with this patchset.
> 
> [1/1] is a cleanup.  [2/2] fixes a bug which appears to go all the way
> back to 5.10.  The bugfix patch has a dependency on the cleanup, which
> is unfortunate.
> 
> We could add the Fixes: to [1/1] and add cc:stable to both patches so
> they get backported into -stable kernels together.  But I think it's
> nicer to just concentrate on the single bugfix patch (with Fixes: and
> cc:stable) and do the cleanup later, in the usual fashion.

Totally agree, thanks a lot.

> 
> So can I suggest a resend please?

Will send a standalone patch to fix the bug, and send clean up patch
after the fix patch is settled.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
