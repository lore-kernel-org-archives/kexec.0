Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from 52.19.354a.static.theplanet.com ([74.53.25.82]
	helo=elimiz.elimizonline.net)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1K0Dmn-0003eX-Ow
	for kexec@lists.infradead.org; Sun, 25 May 2008 10:49:10 +0000
Received: from [78.110.121.1] (helo=ArminLaptop)
	by elimiz.elimizonline.net with esmtpa (Exim 4.68)
	(envelope-from <zoup@zoup.org>) id 1K0Dmd-0004W0-Qm
	for kexec@lists.infradead.org; Sun, 25 May 2008 15:49:00 +0500
Date: Sun, 25 May 2008 15:19:04 +0430
From: Armin ranjbar <zoup@zoup.org>
Subject: Freeze problem
Message-Id: <20080525151904.10392ec8.zoup@zoup.org>
Mime-Version: 1.0
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

Dear all ,

HI :) 

i have a problem with kexec , when i load a panic kernel with kexec -p
which goes successful and panic the kernel using alt+sysrc+c , well ,
nothing happens , system says that triggering a panic and it freezes . 
note that the main kernel and crash kernel are the same and are
relocate able . 
.config of kernel http://pastebin.ca/1028714



-- 
Armin ranjbar , System Administrator

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
