Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1O1IJr-0007xI-7U
	for kexec@lists.infradead.org; Mon, 12 Apr 2010 12:00:49 +0000
Received: by bwz1 with SMTP id 1so1174257bwz.2
	for <kexec@lists.infradead.org>; Mon, 12 Apr 2010 05:00:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4BBFC9F5.3070105@anabaptists.org>
References: <4BBFC9F5.3070105@anabaptists.org>
Date: Mon, 12 Apr 2010 14:00:44 +0200
Message-ID: <n2id1b08f941004120500o43859311x8331038ceb84d1b7@mail.gmail.com>
Subject: Re: Kexec for ARM: Is it expected to load old kernels?
From: Andrea Adami <andrea.adami@gmail.com>
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

Brian,

I suppose you need the ATAG changes introduced in 2.6.24 in order to
boot an arm kernel from kexec.
There are around patches for 2.6.22 and 2.6.23
(http://docs.openmoko.org/trac/ticket/930).

See amongst others:

[ARM] 4599/1: Preserve ATAG list for use with kexec (2.6.23)
[ARM] 4836/1: Make ATAGS_PROC depend on KEXEC


Regards

Andrea

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
