Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD56AC48BEB
	for <kexec@archiver.kernel.org>; Wed, 21 Feb 2024 20:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PpHTGehI23xHGTzzsthSuKqqVkMOcaZ11nERWjQztxU=; b=vHBj42IVmtGOWA
	KGGEJkukLWMsQX1fkKsWbZwKG4qc++OMag2HRFXLPOhMNBHF9DmesKraiYjvHwU1SM8kgRM2FJq5o
	e97fFrwGIxzFSb06QyDDxWHMFhp69TzmkiW+vBC27BFc5thPmUr+LIqn3KhhhkygU5VYDVHxR4JGw
	7kR0KneNmuvAumWEzIe1+Ztvzzz/LlIL0C54K8V+62NYY/WXaJ/AKdU82M7+WPWmh9inS9W1OPXhH
	PMinae50R4CVtNvmcuxwxLLAD6u6dmks5/nZ8xKo5hdVLQpFCeTlAxY0STv5UMYpks4IK4IhifOMX
	dR241W16jen5yM3U7uFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcswt-00000002Rpz-2qcz;
	Wed, 21 Feb 2024 20:12:11 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcswq-00000002RpO-36At;
	Wed, 21 Feb 2024 20:12:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0B8F9615E1;
	Wed, 21 Feb 2024 20:12:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0F2C433F1;
	Wed, 21 Feb 2024 20:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708546326;
	bh=KKWjsYrhxbzP+pEV3+kQm3VuOC8L+ibneC+FX980NRc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MuEJuTRkJMRKFh3mqp6fOZFvfpTamLVq2EoDhR5mfha94P8FQDRrLDaKnE+k3kAQZ
	 D+GTp72il9gGReGfi9Ecu5EvwmjwjIQjWeb5Sl3WDVdyp0MgKQCiHumttOefNnW4dZ
	 V8FEBJZwbop8/DmgOiy+uG0GbLTy+1K4MhvY4Dg8=
Date: Wed, 21 Feb 2024 12:12:05 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, piliu@redhat.com, linux-sh@vger.kernel.org,
 x86@kernel.org, kexec@lists.infradead.org, linux-mips@vger.kernel.org,
 ebiederm@xmission.com, loongarch@lists.linux.dev, hbathini@linux.ibm.com,
 linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2 01/14] kexec: split crashkernel reservation code out
 from crash_core.c
Message-Id: <20240221121205.00202fab8c1732bc433a845f@linux-foundation.org>
In-Reply-To: <e1bd53c6-ad9a-46d5-9f49-ecdd64d98f61@linux.ibm.com>
References: <20240119145241.769622-1-bhe@redhat.com>
	<20240119145241.769622-2-bhe@redhat.com>
	<e1bd53c6-ad9a-46d5-9f49-ecdd64d98f61@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240221_121208_913453_DD17034A 
X-CRM114-Status: UNSURE (   8.26  )
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

On Wed, 21 Feb 2024 22:59:47 +0530 Sourabh Jain <sourabhjain@linux.ibm.com> wrote:

> >   config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
> > -	def_bool CRASH_CORE
> > +	def_bool CRASH_RESEERVE
> 
> %s/CRASH_RESEERVE/CRASH_RESERVE? 

Yes, thanks, this has been addressed in a followon fixup patch
in the mm.git tree.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
