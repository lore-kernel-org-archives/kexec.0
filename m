Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2D1CCD1BF
	for <kexec@archiver.kernel.org>; Tue, 28 Oct 2025 03:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/PboEGb5Bi20U4EjQEuRJRA//eO8r+xifvCuzH96AMU=; b=Wh8Ulc4Cct9UxCK7eF72Rxb03K
	UIhP7yKl6Kbyr7u5zetiqTJUM8q4wWSt8S6VXmZdaQKQYyzYYyeqEYQYw3aWTvsuYmSidonMAY39l
	ooK5/GctFIcNBg3TIy93OjVBfKM62LHZ7lLQDPxloy9tL7L5IafQbHo9lQqrr9m46l4lFiIQGu65N
	oWp6zNILiLlBFCRLPetZSEi/cDHYw7BW01rSKhqbE3leemrOAQX54lKqCY/j4pItGrdRYs2f46sIk
	RC2a7dx1xakwGxt7/gzg1qWMTPVBOfgG87QaedyGB7JSm/3uYifpm6v+/TSTp7aWPCMEspUC4a2s2
	u2ns2uoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDa5t-0000000F9Fz-2R3H;
	Tue, 28 Oct 2025 03:09:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDa5o-0000000F9FL-0kiW
	for kexec@lists.infradead.org;
	Tue, 28 Oct 2025 03:09:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761620989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/PboEGb5Bi20U4EjQEuRJRA//eO8r+xifvCuzH96AMU=;
	b=Vwvd+LwCvEDDO+wZXyzSCc4oBEYYNrurFYr2FCAbBOs9Uv9rHPPNIREdIpFho0NP762MJa
	erfRUDdI7oVrg/prC86s9IJdTfEobhVQrYQZ5dPIWVEzg94dWxqKP34jcw5LfftnpbdxYh
	QwsSpH9FVD0W0EytmFIBYtRxqrknX8o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-BdOLfbtFP9is6KRXmxDCcg-1; Mon,
 27 Oct 2025 23:09:41 -0400
X-MC-Unique: BdOLfbtFP9is6KRXmxDCcg-1
X-Mimecast-MFC-AGG-ID: BdOLfbtFP9is6KRXmxDCcg_1761620978
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 81EEF180136A;
	Tue, 28 Oct 2025 03:09:37 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.84])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E93B2180057F;
	Tue, 28 Oct 2025 03:09:27 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Joel Granados <joel.granados@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCHv2 0/2]: kexec: Force kexec to proceed under heavy deadline load
Date: Tue, 28 Oct 2025 11:09:12 +0800
Message-ID: <20251028030914.9520-1-piliu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251027_200952_284991_B18B2B5D 
X-CRM114-Status: UNSURE (   7.19  )
X-CRM114-Notice: Please train this message.
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

During discussion of the scheduler deadline bug [1], Pierre Gondois
pointed out a potential issue during kexec: as CPUs are unplugged, the
available DL bandwidth of the root domain gradually decreases. At some
point, insufficient bandwidth triggers an overflow detection, causing
CPU hot-removal to fail and kexec to hang.[2]
    
I reproduced it on a system with 160 cpus with the following command
  seq 10 | xargs -I{} -P10 sh -c 'chrt -d -T 1000000 -P 1000000 0 yes > /dev/null &'
  kexec -e

The system hang during the kexec process.
 
This series skips the DL bandwidth check, SIGSTOP all DL tasks so that
the kexec process can proceed.

[1]: https://lore.kernel.org/all/20250929133602.32462-1-piliu@redhat.com/
[2]: https://lore.kernel.org/all/3408aca5-e6c9-434a-9950-82e9147fcbba@arm.com/

RFC -> v2:
Instead of migrating the DL tasks, SIGSTOP them.

Pingfan Liu (2):
  sched/deadline: Skip the deadline bandwidth check if kexec_in_progress
  kernel/kexec: Stop all userspace deadline tasks

 kernel/kexec_core.c     | 23 +++++++++++++++++++++++
 kernel/sched/deadline.c |  7 +++++++
 2 files changed, 30 insertions(+)

-- 
2.49.0


