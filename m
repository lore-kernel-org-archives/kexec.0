Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fed1rmmtao104.cox.net ([68.230.241.42])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NXd7J-0004R5-QX
	for kexec@lists.infradead.org; Wed, 20 Jan 2010 16:09:18 +0000
References: <cone.1263962411.847498.22847.1000@toolshiner.phx1.kidfixit.com>
	<201001201014.56630.florian@openwrt.org>
Message-ID: <cone.1264002495.970050.22847.1000@toolshiner.phx1.kidfixit.com>
From: Joey Korkames <joey@kidfixit.com>
Subject: Re: bzip2-compressed bzimage support?
Date: Wed, 20 Jan 2010 08:48:15 -0700
Mime-Version: 1.0
Content-Disposition: inline
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
To: Florian Fainelli <florian@openwrt.org>
Cc: kexec@lists.infradead.org

Gotcha, kexec resuses the bzImage's decompression stub. Now I have another 
reason to dislike the Debian.org kernels. I didn't know the 
_destination_ kernel had to have the config option as well.

Thanks!
-joey


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
