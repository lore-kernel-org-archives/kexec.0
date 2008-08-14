Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from web1110.biz.mail.sk1.yahoo.com ([74.6.114.42])
	by bombadil.infradead.org with smtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KTXoE-00019K-Ju
	for kexec@lists.infradead.org; Thu, 14 Aug 2008 08:03:51 +0000
Date: Thu, 14 Aug 2008 01:03:48 -0700 (PDT)
From: Cai Qian <caiqian@cclom.cn>
Subject: Kdump Automation Mechanism
MIME-Version: 1.0
Message-ID: <249026.52731.qm@web1110.biz.mail.sk1.yahoo.com>
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
To: kexec@lists.infradead.org
Cc: caiqian@cclom.cn

Hi,

I am wondering if this is the right project to accept Kdump automation files. For example, Kdump
daemon init script, mkdumprd (read from Kdump configuration file and generate Kdump initramfs for
the system), default Kdump configuration file, tools to compress vmcore etc.

The problem I am having right now is that, I am trying to write a Kdump test suite, but I could
not 
find a easy way to write a general enough suite for every distro to use. Red Hat and SUSE have
slightly different setting up. Debian and Ubuntu don't have Kdump automation mechanism as the time
I was checking. Also, It make things much easier for different distros and users to pick it up and
contribute to those efforts.

Thanks,
CaiQian

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
