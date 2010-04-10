Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mxout-07.mxes.net ([216.86.168.182])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1O0OoS-0005fJ-RF
	for kexec@lists.infradead.org; Sat, 10 Apr 2010 00:44:41 +0000
Received: from [192.168.0.52] (unknown [71.112.164.215])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.mxes.net (Postfix) with ESMTPSA id C980822E255
	for <kexec@lists.infradead.org>; Fri,  9 Apr 2010 20:44:35 -0400 (EDT)
Message-ID: <4BBFC9F5.3070105@anabaptists.org>
Date: Fri, 09 Apr 2010 17:44:37 -0700
From: Brian Smucker <bsmucker@anabaptists.org>
MIME-Version: 1.0
Subject: Kexec for ARM:  Is it expected to load old kernels?
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hi,

I use kexec to load a new 2.6.32 kernel and things work fine.  However 
when I try to use kexec to load a 2.6.21 kernel (ARM architecture) , it 
hangs after the "Bye!" message.

Is this to be expected?

If not, how can I debug things further?

Thanks,

Brian

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
