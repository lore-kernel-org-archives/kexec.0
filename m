Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A52C02180
	for <kexec@archiver.kernel.org>; Wed, 15 Jan 2025 04:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+unhOYBjiPAqZTRFood5aIiHdu2obot7zgKwQr1T8N4=; b=CCruFJM1Te/D/3i1Uvl9Yz0pup
	eHZ4WwUEdnVLSm/l25TuhVP4qoQ6948sTd4CkMJ6YQTKMSPq/zzToBHjyMfBpGzzyEZHNTbteU5tK
	TJPiPVcHOYm9vmfCdBN+82pVtuoZ+1h8lnXq8sWAZGcXyDNSZu2rhoyj1fV5F8p+OL8DjPuk8wZ9h
	5a0lxPQWqtmp6HCIR1mCXkUL2JtY1wDiZNItxspkqBiJ4OPl+OFkHp1sQvU9s3kqNNEAnn86NLY9g
	sszw/g8xeL5q0zN6b3rbXLO6D3mVFGYoofm3/RAvnvasOl2kY21+sKNn53JIA4FMeyAvv0Yn9h4vh
	MSjafSeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXuds-0000000AZmf-1WPf;
	Wed, 15 Jan 2025 04:04:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXudn-0000000AZlw-1PCG
	for kexec@lists.infradead.org;
	Wed, 15 Jan 2025 04:04:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736913864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+unhOYBjiPAqZTRFood5aIiHdu2obot7zgKwQr1T8N4=;
	b=OWn03VrAPkWTz+qBIltYz+MCHrxN6uGSy+QQnTfYWTfsT5rbsvpZG/op6IqjHqI5rRzgrQ
	9GcBzLvMrdVp6OiWpGFPWVTiEsPtxxwWMu5qQnyE4RkoVusrg4e2i3nJ9K9/qw105ZIpSH
	8WzOVHNlV66UUzqStTvyd8JWJ6NmqqE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-D0RozbHVNbOEewaG-IRirA-1; Tue,
 14 Jan 2025 23:04:21 -0500
X-MC-Unique: D0RozbHVNbOEewaG-IRirA-1
X-Mimecast-MFC-AGG-ID: D0RozbHVNbOEewaG-IRirA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80ED71955DDF;
	Wed, 15 Jan 2025 04:04:18 +0000 (UTC)
Received: from localhost (unknown [10.72.112.24])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CE473003FD9;
	Wed, 15 Jan 2025 04:04:15 +0000 (UTC)
Date: Wed, 15 Jan 2025 12:04:10 +0800
From: Baoquan He <bhe@redhat.com>
To: Roberto Ricci <io@r-ricci.it>
Cc: ebiederm@xmission.com, rafael@kernel.org, pavel@ucw.cz,
	ytcoode@gmail.com, kexec@lists.infradead.org,
	linux-pm@vger.kernel.org, akpm@linux-foundation.org,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from
 hibernation
Message-ID: <Z4czuvi2BiNlDWPP@MiWiFi-R3L-srv>
References: <Z4WFjBVHpndct7br@desktop0a>
 <Z4Zjmva-pLbLjtQv@desktop0a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4Zjmva-pLbLjtQv@desktop0a>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250114_200427_450207_001DA799 
X-CRM114-Status: GOOD (  15.00  )
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

On 01/14/25 at 02:16pm, Roberto Ricci wrote:
> On 2025-01-13 Mon 22:28:48 +0100, Roberto Ricci wrote:
> > I can reproduce this with kernel 6.13-rc7 in a qemu x86_64 virtual machine
> > running Void Linux, with the following commands:
> > 
> > ```
> > # kexec -l /boot/vmlinuz-6.13.0-rc7 --initrd=/boot/initramfs-6.13.0-rc7 --reuse-cmdline
> > # reboot
> > # printf reboot >/sys/power/disk
> > # printf disk >/sys/power/state
> > ```
> 
> Looks like it's the kernel performing the kexec which causes the issue,
> not the target one. E.g.: kexec-ing 6.7 from 6.13-rc7 makes resume from
> hibernation fail; but if I kexec 6.13-rc7 from 6.7, then it works fine.

I tried the latest mainline kernel with your above command execution
series, I didn't see the problem you reported. Can you try kexec from
6.7 to 6.7 or something like that and try to bisect a specific criminal
commit?

As for below commit, it seems not a suspect.
18d565ea95fe ("kexec_file: fix incorrect temp_start value in locate_mem_hole_top_down()")

If possible, can you revert below two commits altogether to have a try?
I am not sure if they caused the problem.

18d565ea95fe kexec_file: fix incorrect temp_start value in locate_mem_hole_top_down()
816d334afa85 kexec: modify the meaning of the end parameter in kimage_is_destination_range()

Thanks
Baoquan


