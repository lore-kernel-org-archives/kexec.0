Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84868C04FFE
	for <kexec@archiver.kernel.org>; Tue, 23 Apr 2024 13:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Rtmg/wASFzw7yVeRAuy6wL2D++DS2rbOJI2rGwRp6oU=; b=XJjsSsEo4j+Tx7
	Mm73GoRyuHUtMbJEz0Td8jUqscfAF+Cm/N9hHef3T2zqbh6qfJ1s1QXZUyD+fkFTWCaEK0sIAOGV9
	Ub6riw+NIvlBaZ3fqlo/LnLyhdVY3ztyYr6GZc1eN8rHkUgmEumiPykvsLg9MPISwo+HI6CpbkQHQ
	81XjMA68taxu8WWwjjS0p6uieccJNcg2/0IjucAwLbcu4upTTHIaVuep8StIf8EtxjqHMRtIJ1yTB
	eXR1MGtcmjvHtYkcqIl20K4IN/Wrr8OKqCZcZ1sSMy16ct3eYS6eX0xKPp/R+688ah1OxAjyHWgdy
	9M9ktuvQcZF8g5K6paYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzGdu-00000000Bgf-3u2g;
	Tue, 23 Apr 2024 13:57:06 +0000
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3] helo=gandalf.ozlabs.org)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzGdl-00000000Bbl-1UFk
	for kexec@lists.infradead.org;
	Tue, 23 Apr 2024 13:57:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1713880607;
	bh=CHtOdwbj0E1GvwNkXmOfZvz8pKIWj92NEKclpPh6Nas=;
	h=From:To:Cc:Subject:Date:From;
	b=gxbDmDtHv8CHQGC16MwRvxY5H/eQJEZ1uUUgkCA/31tRoQMst3mllrY1L96An4W8z
	 ZgjxurB7hIx+CtkxSJDlLfsLTdn/P1yplRiwmzmxV9JwOG9JZ2/WmxhqOH01VHAZ2T
	 Xu1m+u1oHdw7sgbgSBu7lL9GAVZP/Y3beq5ooL3aox888yI+yo1X8shY49JKWqEkZ7
	 +gSfoW3JSxL9xF9Ch0lFhJROyiJy741/A4jxtn1EDV6AQhd0gHlWiRWN1YVB1XNyMl
	 9Hvi3NtvspG1aywuM84oL3s6QPy2ihc8nuZPuhlVhnsvv8YVLxqoEiaxt7RaGclVK6
	 ioTNNK6Xg5/Vw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VP3ZP3GqJz4wby;
	Tue, 23 Apr 2024 23:56:45 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, kexec@lists.infradead.org,
 sourabhjain@linux.ibm.com, bhe@redhat.com 
Subject: Please add powerpc topic/kdump-hotplug branch to linux-next
Date: Tue, 23 Apr 2024 23:56:42 +1000
Message-ID: <87bk60ji79.fsf@mail.lhotse>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240423_065657_746501_4F88CB2E 
X-CRM114-Status: UNSURE (   6.32  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Stephen,

Can you please add the topic/kdump-hotplug branch of the powerpc tree to
linux-next. It contains a series that touches generic kexec code as well
as x86 and powerpc code.

The hope is to have to get it merged for v6.10, so it should go along
with the powerpc next branch in the merge order.

https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/log/?h=topic/kdump-hotplug

cheers

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
