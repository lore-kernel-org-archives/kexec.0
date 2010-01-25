Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from lo.gmane.org ([80.91.229.12])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1NZWab-0001EX-PB
	for kexec@lists.infradead.org; Mon, 25 Jan 2010 21:35:22 +0000
Received: from list by lo.gmane.org with local (Exim 4.50) id 1NZWaQ-0006xp-El
	for kexec@lists.infradead.org; Mon, 25 Jan 2010 22:35:06 +0100
Received: from dsl01.83.171.174.205.ip-pool.nefkom.net ([83.171.174.205])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <kexec@lists.infradead.org>; Mon, 25 Jan 2010 22:35:06 +0100
Received: from bernhard by dsl01.83.171.174.205.ip-pool.nefkom.net with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <kexec@lists.infradead.org>; Mon, 25 Jan 2010 22:35:06 +0100
From: Bernhard Walle <bernhard@bwalle.de>
Subject: Re: [PATCH] Fix --reuse-cmdline so it is usable.
Date: Mon, 25 Jan 2010 22:34:20 +0100
Message-ID: <hjl2nk$fot$1@ger.gmane.org>
References: <m1d4167c5s.fsf@fess.ebiederm.org>	<20100125072352.GD23849@verge.net.au>
	<m1eile4n5g.fsf@fess.ebiederm.org>
Mime-Version: 1.0
In-Reply-To: <m1eile4n5g.fsf@fess.ebiederm.org>
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

Am 25.01.2010 09:14, schrieb Eric W. Biederman:
> Where does the memory that getopt uses come from?

The optarg string points to the original *argv[] array and doesn't
allocate new memory.


Regards,
Bernhard





_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
