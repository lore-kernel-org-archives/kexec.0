Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KBDbZ-0003Gj-W4
	for kexec@lists.infradead.org; Tue, 24 Jun 2008 18:51:02 +0000
Date: Tue, 24 Jun 2008 20:50:59 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: how to cross compile kexec for 64b x86_64 on a 32b x86
Message-ID: <20080624205059.4218f727@kopernikus.site>
In-Reply-To: <df1bdeb10806241146l6af052an3e9dd3305eb36ca5@mail.gmail.com>
References: <df1bdeb10806241111q1b992291k35ed22894282377f@mail.gmail.com>
	<20080624201407.2cf464ed@kopernikus.site>
	<df1bdeb10806241146l6af052an3e9dd3305eb36ca5@mail.gmail.com>
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
To: Srinivas Dharmasanam <the.srinivas@gmail.com>
Cc: kexec@lists.infradead.org

* "Srinivas Dharmasanam" <the.srinivas@gmail.com> [2008-06-24 11:46]:
>
> Tried that; it fails saying:
> 
> checking for gcc...
> /gcc-3.4.5-glibc-2.3.6/x86_64-unknown-linux-gnu/bin/x86_64-unknown-linux-gnu-gcc
> checking for C compiler default output file name... a.out
> checking whether the C compiler works... configure: error: cannot run
> C compiled programs.
> If you meant to cross compile, use `--host'.
> See `config.log' for more details.

Ah, right, try

  ./configure \
      --host=x86_64-unknown-linux-gnu
      --build=x86_64-unknown-linux-gnu

> I dont see a conftest.c file anywhere.

Read config.log. It's "inline", the conftest.c gets deleted on very
check.


Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
