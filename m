Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KBD1v-00087z-F4
	for kexec@lists.infradead.org; Tue, 24 Jun 2008 18:14:12 +0000
Date: Tue, 24 Jun 2008 20:14:07 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: how to cross compile kexec for 64b x86_64 on a 32b x86
Message-ID: <20080624201407.2cf464ed@kopernikus.site>
In-Reply-To: <df1bdeb10806241111q1b992291k35ed22894282377f@mail.gmail.com>
References: <df1bdeb10806241111q1b992291k35ed22894282377f@mail.gmail.com>
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

* "Srinivas Murthy" <codevana@gmail.com> [2008-06-24 11:11]:
>
> Hi,
> 	I need to cross-compile kexec-tools-1.101 for a x86_64 architecture
> platform on a 32b x86.
> 
> 	I didn't see any instructions in the configure, etc. scripts for doing this.

gcc does not support that (like the -m32 flag when you build i386 on
x86-64). You need to build a cross compiler, and then you would pass
that via

      CC=your-cross-compiler ./configure



Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
