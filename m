Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6B0D116E2
	for <kexec@archiver.kernel.org>; Sun, 30 Nov 2025 02:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O+TZ5IvwVAJilCgStks8oRIyF+Xcnm6BlG3sJPZcOWo=; b=gvDEX03offMETab2AdN29poEz+
	S7AS7K4xMKIR1b7Qm3BTbpku9h/MROV3QsJjYa8yZ6Fa9naLY4EE/QAqorFVGVDcE2Ghmo3kENBXR
	gv928d9qt5sD087gugRtPQOx8cuY061LYt+7XVPNoCpZOYAoM5PYc3rL/LdeBKVvGW6+aI3+ndhY9
	MBJlMCixdLb42GgOArOfnS/lFz+sc6BYSHm2f9cfi6w9nYSDF4aDF9Va4wZI3QMYEgQ4OjK5AOexg
	w/tQWAxxuU+/sM702LRA/YCBoUDX24WK5Np9Rg5xMQ/JoasBgSzLdvD3Emdq/6dSfIjr+AS0Nkcdh
	P3enyarw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPXcJ-00000001yQk-373l;
	Sun, 30 Nov 2025 02:56:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPXcE-00000001yPa-48km
	for kexec@lists.infradead.org;
	Sun, 30 Nov 2025 02:56:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764471405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O+TZ5IvwVAJilCgStks8oRIyF+Xcnm6BlG3sJPZcOWo=;
	b=ModiT8XP+uDushnjsZmcI+IsdDETdajWSL0wBXSK0AjtjAKnSwOFjNpYB52gw85Rspb1Vh
	LA1AK3oqPjvhoqEtOZFiN3+liO7tp5oZfuBPBIh04Sc99XUdZ+oZ4qAsU2RKlrzGS6lafX
	yg4X3XZFqPIwQiD00rKh2LL3spawS98=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-4CZnjbkNNsSlXUHxWAjX5g-1; Sat,
 29 Nov 2025 21:56:42 -0500
X-MC-Unique: 4CZnjbkNNsSlXUHxWAjX5g-1
X-Mimecast-MFC-AGG-ID: 4CZnjbkNNsSlXUHxWAjX5g_1764471401
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA2A9195605A;
	Sun, 30 Nov 2025 02:56:40 +0000 (UTC)
Received: from localhost (unknown [10.72.112.6])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8CF05195608E;
	Sun, 30 Nov 2025 02:56:38 +0000 (UTC)
Date: Sun, 30 Nov 2025 10:56:33 +0800
From: Baoquan He <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: akpm@linux-foundation.org, Qiang Ma <maqianga@uniontech.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	shivang upadhyay <shivangu@linux.ibm.com>
Subject: Re: [PATCH v3 0/3] kexec: print out debugging message if required
 for kexec_load
Message-ID: <aSuyYXnVqPp0HGwt@MiWiFi-R3L-srv>
References: <20251126084427.3222212-1-maqianga@uniontech.com>
 <7aadda55-d2a4-40f9-95ef-d284ec358646@linux.ibm.com>
 <aShunGBgVbEZmCxO@MiWiFi-R3L-srv>
 <77ce0329-1f82-49be-b18a-73c9e5c3e85e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77ce0329-1f82-49be-b18a-73c9e5c3e85e@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251129_185647_096937_780B0846 
X-CRM114-Status: GOOD (  27.18  )
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

On 11/28/25 at 03:11pm, Sourabh Jain wrote:
> Hello Baoquan,
> 
> On 27/11/25 21:00, Baoquan He wrote:
> > On 11/27/25 at 05:31pm, Sourabh Jain wrote:
> > > Hello All,
> > > 
> > > Do we have plan to support KEXEC_DEBUG flag?
> > > 
> > > Because upstream kexec-tools already added support for KEXEC_DEBUG flag
> > > and that breaks the kexec_load with -d option.
> > > 
> > > - kexec: add kexec flag to support debug printing
> > >    https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=71d6fd99af7e
> > I think we should revert that kexec-tools commit.
> 
> Yeah, userspace changes shouldn't go in until the kernel patches are
> finalized. It seems that there are disagreements regarding the approach
> and usefulness of this patch series, so reverting the kexec-tools patch
> might be the right thing to avoid breaking anything for now.

The patch 1 is issue fixing, that is a good one. While patch 2, 3 are
trying to add debugging printing for kexec_load interface which I think
is not needed. I added debugging printing for kexec_file_load because I
has been using 'kexec -d' to debug for kexec_load while kexec_file_load
didn't have. So I mimicked kexec_load's debugging printing to add one
for kexec_file_load. Now patch 2,3's adding doesn't make sense as he
said he is doing for future need.

> 
> I have one question: should the kernel advertise KEXEC_DEBUG so that
> backward compatibility can be maintained between the kernel and
> kexec-tools? Or is that too much for a debugging flag? How was backward
> compatibility handled when we added the KEXEC_FILE_DEBUG flag?

When I added KEXEC_FILE_DEBUG, I didn't consider backward compatibility.
That is making the then latest kernel match the then latest kexec-tools.

> 
> > This whole patchset is
> > non-sense. Because of my carelessness, that userspace patch was merged.
> > 
> > Hi Sourabh,
> > 
> > Could you go through this patchset and help check if they are really
> > needed? I can't find anything to convince myself. Thanks.
> 
> Sure I will review this patch series.

Thanks. Please check patch 2,3 to see if we really need the debugging
printing for kexec_load, or its adding really brings benefit even if
it's a little bit compared with the mess it brings; and if my objecting
is too subjective.

Thanks
Baoquan


