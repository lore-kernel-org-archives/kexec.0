Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from yx-out-1718.google.com ([74.125.44.154])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KBDWt-0002mF-U9
	for kexec@lists.infradead.org; Tue, 24 Jun 2008 18:46:12 +0000
Received: by yx-out-1718.google.com with SMTP id 6so604856yxn.72
	for <kexec@lists.infradead.org>; Tue, 24 Jun 2008 11:46:11 -0700 (PDT)
Message-ID: <df1bdeb10806241146l6af052an3e9dd3305eb36ca5@mail.gmail.com>
Date: Tue, 24 Jun 2008 11:46:10 -0700
From: "Srinivas Dharmasanam" <the.srinivas@gmail.com>
Subject: Re: how to cross compile kexec for 64b x86_64 on a 32b x86
In-Reply-To: <20080624201407.2cf464ed@kopernikus.site>
MIME-Version: 1.0
Content-Disposition: inline
References: <df1bdeb10806241111q1b992291k35ed22894282377f@mail.gmail.com>
	<20080624201407.2cf464ed@kopernikus.site>
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
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org

Tried that; it fails saying:

checking for gcc...
/gcc-3.4.5-glibc-2.3.6/x86_64-unknown-linux-gnu/bin/x86_64-unknown-linux-gnu-gcc
checking for C compiler default output file name... a.out
checking whether the C compiler works... configure: error: cannot run
C compiled programs.
If you meant to cross compile, use `--host'.
See `config.log' for more details.


configure:1803:
/gcc-3.4.5-glibc-2.3.6/x86_64-unknown-linux-gnu/bin/x86_64-unknown-linux-gnu-gcc
   conftest.c  >&5
configure:1806: $? = 0
configure:1852: result: a.out
configure:1857: checking whether the C compiler works
configure:1863: ./a.out
./configure: ./a.out: No such file or directory
configure:1866: $? = 127
configure:1875: error: cannot run C compiled programs.
If you meant to cross compile, use `--host'.
See `config.log' for more details.

I dont see a conftest.c file anywhere.



On Tue, Jun 24, 2008 at 11:14 AM, Bernhard Walle <bwalle@suse.de> wrote:
> * "Srinivas Murthy" <codevana@gmail.com> [2008-06-24 11:11]:
>>
>> Hi,
>>       I need to cross-compile kexec-tools-1.101 for a x86_64 architecture
>> platform on a 32b x86.
>>
>>       I didn't see any instructions in the configure, etc. scripts for doing this.
>
> gcc does not support that (like the -m32 flag when you build i386 on
> x86-64). You need to build a cross compiler, and then you would pass
> that via
>
>      CC=your-cross-compiler ./configure
>
>
>
> Bernhard
> --
> Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
