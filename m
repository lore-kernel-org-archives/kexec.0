Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KBOwa-0005zs-Im
	for kexec@lists.infradead.org; Wed, 25 Jun 2008 06:57:28 +0000
Date: Wed, 25 Jun 2008 08:57:24 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: how to cross compile kexec for 64b x86_64 on a 32b x86
Message-ID: <20080625085724.1c453dfa@kopernikus.site>
In-Reply-To: <df1bdeb10806241648k605af62bme82f1dcb8d5c2793@mail.gmail.com>
References: <df1bdeb10806241111q1b992291k35ed22894282377f@mail.gmail.com>
	<20080624201407.2cf464ed@kopernikus.site>
	<df1bdeb10806241146l6af052an3e9dd3305eb36ca5@mail.gmail.com>
	<20080624205059.4218f727@kopernikus.site>
	<df1bdeb10806241648k605af62bme82f1dcb8d5c2793@mail.gmail.com>
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
To: Srinivas Murthy <codevana@gmail.com>
Cc: kexec@lists.infradead.org

* "Srinivas Murthy" <codevana@gmail.com> [2008-06-24 16:48]:
>
> Any suggestions for how to cross compile the crash-4.0-6.3 for x86_64
> on an x86 system.

Tweak the Makefile. Or ask Dave on the crash list
(https://www.redhat.com/mailman/listinfo/crash-utility).



Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
