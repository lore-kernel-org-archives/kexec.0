Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC7DDCCD1BB
	for <kexec@archiver.kernel.org>; Wed, 22 Oct 2025 12:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zvReUmFuOQX/SJC9oEYeW8Gu66yrEnKENSYxIaDF4ho=; b=RP87BA0ebslf3pwgpeUJClNyR+
	QK69AMNXi5gHzXR7TYXMBWbzyd6B50KCEwulrsNG6vBziMgUrF68UR05WFoK1iJlQ2qWQ7klowtdY
	y6Gvfaom8zu/nBFPSFFD19UReCQwYBa3OnnB/Gadt2xHEc+vlHHN8ny3yqsiYHIRcpcehlhER1NGf
	sh0EtdW7jRqkI2zKItFbMPfvkXRNf0Vev1WsUqBoTdyQQ2is7oJwL8j3aHelQGctK2f8YIVBmWGav
	u1E9c89i0o7R+6LbP+pHVUih9zJ/yf+GOWU+6ri3HnTIY7BU5N12+oIvgx5+XAVL8Y4KHyNtGQImt
	Z3IE/Ugg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBXjR-00000002lYB-1ML2;
	Wed, 22 Oct 2025 12:14:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBXjO-00000002lWR-0cdt
	for kexec@lists.infradead.org;
	Wed, 22 Oct 2025 12:14:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761135255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zvReUmFuOQX/SJC9oEYeW8Gu66yrEnKENSYxIaDF4ho=;
	b=i10mBIiGXcWlWI55vWbM+7AvLAzHzXweP2ecmrmzPsFcLcVl7hdMhrlHYw8k+wZonNwwSw
	YX6hpxwY2z+IWXmjSoSV7kW+LjiHCtw+jzUBS61XMPu9XJPJxu7G7KoAc00zqemlR3YFDp
	fQvN5JjCwD5oVpDcoG7ie9CIMgBSeic=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-2ZqrSGLPNYaIcltsT0sPlA-1; Wed,
 22 Oct 2025 08:14:12 -0400
X-MC-Unique: 2ZqrSGLPNYaIcltsT0sPlA-1
X-Mimecast-MFC-AGG-ID: 2ZqrSGLPNYaIcltsT0sPlA_1761135250
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E79F11800345;
	Wed, 22 Oct 2025 12:14:08 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.98])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DD324180057E;
	Wed, 22 Oct 2025 12:13:59 +0000 (UTC)
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
	Joel Granados <joel.granados@kernel.org>
Subject: [RFC 0/3] kexec: Force kexec to proceed under heavy deadline load
Date: Wed, 22 Oct 2025 20:13:42 +0800
Message-ID: <20251022121345.23496-1-piliu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251022_051418_252520_1BAEFF82 
X-CRM114-Status: UNSURE (   7.84  )
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
 
This series skips the DL bandwidth check, migrates the task from dying
CPU directly to the kexec CPU, and promotes the kexec to DL task. By
this way, the heavy deadline load will not starve the CPU hot-removal
kthread so that kexec task can move on.

In contrast to this series, an alternative aggressive approach is to
send SIGKILL to all DL tasks at the beginning of the kexec process.
Let us discuss how to resolve this issue.


[1]: https://lore.kernel.org/all/20250929133602.32462-1-piliu@redhat.com/
[2]: https://lore.kernel.org/all/3408aca5-e6c9-434a-9950-82e9147fcbba@arm.com/

Pingfan Liu (3):
  sched/deadline: Skip the deadline bandwidth check if kexec_in_progress
  kernel/cpu: Mark nonboot cpus as inactive when shutting down nonboot
    cpus
  kexec_core: Promote the kexec to DL task

 kernel/cpu.c            | 10 ++++++++++
 kernel/kexec_core.c     | 28 ++++++++++++++++++++++++++++
 kernel/sched/deadline.c |  7 +++++++
 3 files changed, 45 insertions(+)

-- 
2.49.0


