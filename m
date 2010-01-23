Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NYV4d-0004MF-Gm
	for kexec@lists.infradead.org; Sat, 23 Jan 2010 01:46:07 +0000
Subject: Re: bzip2-compressed bzimage support?
References: <cone.1263962411.847498.22847.1000@toolshiner.phx1.kidfixit.com>
	<201001201014.56630.florian@openwrt.org>
	<cone.1264002495.970050.22847.1000@toolshiner.phx1.kidfixit.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 22 Jan 2010 17:45:50 -0800
In-Reply-To: <cone.1264002495.970050.22847.1000@toolshiner.phx1.kidfixit.com>
	(Joey Korkames's message of "Wed\, 20 Jan 2010 08\:48\:15 -0700")
Message-ID: <m1d41161bl.fsf@fess.ebiederm.org>
MIME-Version: 1.0
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
To: Joey Korkames <joey@kidfixit.com>
Cc: kexec@lists.infradead.org, Florian Fainelli <florian@openwrt.org>

Joey Korkames <joey@kidfixit.com> writes:

> Gotcha, kexec resuses the bzImage's decompression stub. Now I have another
> reason to dislike the Debian.org kernels. I didn't know the _destination_ kernel
> had to have the config option as well.

The _destination_ kernel doesn't need the config option.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
