Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from hq-exedge.brocade.com ([66.243.153.82])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1MJbu5-0004JN-Lb
	for kexec@lists.infradead.org; Wed, 24 Jun 2009 23:29:28 +0000
From: Ming Lei <mlei@Brocade.COM>
Date: Wed, 24 Jun 2009 16:29:17 -0700
Subject: question on ppc64 relocatable kernel
Message-ID: <7301F255FCB62048851F165FFAAF9BD1025142B8BC@HQ-EXCH-7.corp.brocade.com>
Content-Language: en-US
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
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
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hi,

I try to understand how relocatable kernel works on ppc64(mainly on IBM). I saw -pie link option on linker but no -fpic on compiling. What does this mean?
 
Second question is:
Does ppc64 have GOT?

Third question is:
Does data section in relocatable kernel on ppc64 relocatable? Is it in .dynamic section?

Thanks
Ming

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
