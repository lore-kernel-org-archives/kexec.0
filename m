Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Kf7RM-0002hK-L3
	for kexec@lists.infradead.org; Mon, 15 Sep 2008 06:20:05 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m8F6Jdbc012444
	for <kexec@lists.infradead.org>; Mon, 15 Sep 2008 02:19:39 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m8F6JcEY154496
	for <kexec@lists.infradead.org>; Mon, 15 Sep 2008 02:19:38 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m8F6JcuG024896
	for <kexec@lists.infradead.org>; Mon, 15 Sep 2008 02:19:38 -0400
Message-ID: <48CDFE50.8080003@in.ibm.com>
Date: Mon, 15 Sep 2008 11:48:56 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
MIME-Version: 1.0
Subject: Re: [patch kexec] Fix test for loaded kernel
References: <48CABE27.10301@am.sony.com> <48CAC406.4060608@am.sony.com>
In-Reply-To: <48CAC406.4060608@am.sony.com>
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
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Cell Broadband Engine OSS Development <cbe-oss-dev@ozlabs.org>

Hi Geoff,

> 
> The only way to fix the NFS problem is to change the init scripts to
> pass the -x option to kexec.

Can we simply call ifup (that function does not exist now) to bring up 
the network interface while returning from main() in kexec.c? This will 
be executed only if kexec'ing a kernel fails.

Regards,
Mohan.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
