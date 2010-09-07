Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]
	helo=TX2EHSOBE003.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Ot30C-00038b-8R
	for kexec@lists.infradead.org; Tue, 07 Sep 2010 18:34:40 +0000
MIME-Version: 1.0 (Apple Message framework v1081)
Subject: kexec on ppc64
From: Matthew McClintock <msm@freescale.com>
Date: Tue, 7 Sep 2010 13:34:24 -0500
Message-ID: <0D324CAF-2A5D-4363-9000-7EB48179C11C@freescale.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org

All,

I'm trying to determine how kexec'ing works on 64 bit powerpc. When allocating a region for the kexec'ed kernel is it ever the same as the currently running kernel or do you always boot the kexec'ed kernel from a different memory region? I understand that a crash kernel will be in a different region, however I was hoping to confirm the behavior for a normal "kexec -e".

Thanks,
Matthew

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
