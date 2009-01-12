Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from sj-iport-3.cisco.com ([171.71.176.72])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1LMVWZ-0006nP-8u
	for kexec@lists.infradead.org; Mon, 12 Jan 2009 22:44:50 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: newbie question: kexec linux-based bootstrap
Date: Mon, 12 Jan 2009 14:44:44 -0800
Message-ID: <F795765B112E7344AF36AA911279641508F6B3F5@xmb-sjc-212.amer.cisco.com>
In-Reply-To: <496BBE57.2040802@oracle.com>
References: <F795765B112E7344AF36AA911279641508F6AFCB@xmb-sjc-212.amer.cisco.com>	<496B4127.1070201@anduras.de>
	<F795765B112E7344AF36AA911279641508F6B39B@xmb-sjc-212.amer.cisco.com>
	<496BBE57.2040802@oracle.com>
From: "Bizhan Gholikhamseh (bgholikh)" <bgholikh@cisco.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Sven Anders <anders@anduras.de>, kexec@lists.infradead.org



> I use kexec daily for boot-testing new kernels.
I have enabled the kexec in the kernel configuration, when I ran the
kexec I get the following error:

# ./kexec -l ./bzImage
kexec_load failed: Function not implemented
entry       = 0x977b8 flags = 0
nr_segments = 3
segment[0].buf   = 0x8071600
segment[0].bufsz = 2a00
segment[0].mem   = 0x3000
segment[0].memsz = 3000
segment[1].buf   = 0x806a550
segment[1].bufsz = 7060
segment[1].mem   = 0x97000
segment[1].memsz = 9000
segment[2].buf   = 0xb7c3aa08
segment[2].bufsz = 1d7eb8
segment[2].mem   = 0x100000
segment[2].memsz = 1d8000

???                             


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
