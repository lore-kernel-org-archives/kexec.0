Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rv-out-0708.google.com ([209.85.198.245])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KBIFt-0007fg-Ej
	for kexec@lists.infradead.org; Tue, 24 Jun 2008 23:48:57 +0000
Received: by rv-out-0708.google.com with SMTP id b17so10833461rvf.42
	for <kexec@lists.infradead.org>; Tue, 24 Jun 2008 16:48:56 -0700 (PDT)
Message-ID: <df1bdeb10806241648k605af62bme82f1dcb8d5c2793@mail.gmail.com>
Date: Tue, 24 Jun 2008 16:48:56 -0700
From: "Srinivas Murthy" <codevana@gmail.com>
Subject: Re: how to cross compile kexec for 64b x86_64 on a 32b x86
In-Reply-To: <20080624205059.4218f727@kopernikus.site>
MIME-Version: 1.0
Content-Disposition: inline
References: <df1bdeb10806241111q1b992291k35ed22894282377f@mail.gmail.com>
	<20080624201407.2cf464ed@kopernikus.site>
	<df1bdeb10806241146l6af052an3e9dd3305eb36ca5@mail.gmail.com>
	<20080624205059.4218f727@kopernikus.site>
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

./configure \
     --host=x86_64-unknown-linux-gnu
seems to work. The --build is if we're building on the x86_64.

It seems that I now need the crash utility also to be cross compiled.
I dont see any cross-compile support in the crash-4.0-6.3 pkg.

Any suggestions for how to cross compile the crash-4.0-6.3 for x86_64
on an x86 system.

Thanks.

On Tue, Jun 24, 2008 at 11:50 AM, Bernhard Walle <bwalle@suse.de> wrote:
> * "Srinivas Dharmasanam" <the.srinivas@gmail.com> [2008-06-24 11:46]:
>>
>> Tried that; it fails saying:
>>
>> checking for gcc...
>> /gcc-3.4.5-glibc-2.3.6/x86_64-unknown-linux-gnu/bin/x86_64-unknown-linux-gnu-gcc
>> checking for C compiler default output file name... a.out
>> checking whether the C compiler works... configure: error: cannot run
>> C compiled programs.
>> If you meant to cross compile, use `--host'.
>> See `config.log' for more details.
>
> Ah, right, try
>
>  ./configure \
>      --host=x86_64-unknown-linux-gnu
>      --build=x86_64-unknown-linux-gnu
>
>> I dont see a conftest.c file anywhere.
>
> Read config.log. It's "inline", the conftest.c gets deleted on very
> check.
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
