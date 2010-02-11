Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtprelay02.ispgateway.de ([80.67.18.44])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NfTry-0007yt-OK
	for kexec@lists.infradead.org; Thu, 11 Feb 2010 07:53:54 +0000
Subject: Re: kdump cp /proc/vmcore exiting with "Invalid Argument" Error
Mime-Version: 1.0 (Apple Message framework v1077)
From: Bernhard Walle <bernhard@bwalle.de>
In-Reply-To: <74ae4f6a1002101046y5faeacebxdf822eac8ccf6c98@mail.gmail.com>
Date: Thu, 11 Feb 2010 08:53:41 +0100
Message-Id: <F5FD1B18-ECCA-49E6-B720-D41D33C8E991@bwalle.de>
References: <74ae4f6a1002051845i6a2787deve82963c5d258eda4@mail.gmail.com>
	<4B6D393A.7060103@bwalle.de>
	<74ae4f6a1002101046y5faeacebxdf822eac8ccf6c98@mail.gmail.com>
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
To: Sujit V <sujit.linux@gmail.com>
Cc: kexec@lists.infradead.org


Am 10.02.2010 um 19:46 schrieb Sujit V:

> Tried readelf on the /proc/vmcore but gave the below error. The
> readelf worked correctly on another binary.
> 
> kdump shell>/sbin/readelf -l /proc/vmcore
> readelf: Error: Cannot stat input file /proc/vmcore.

My only guess is that readelf has no large file support (see http://sourceware.org/ml/binutils/2007-07/msg00087.html). Could you please execute "strace readelf -l /proc/vmcore"?


Regards,
Bernhard


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
